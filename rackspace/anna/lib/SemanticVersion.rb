class SemanticVersion
  SemVerStrRegexp = /\A(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][a-zA-Z0-9-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][a-zA-Z0-9-]*))*))?(?:\+([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?\Z/

  attr_accessor :major, :minor, :patch, :preReleaseVersion

  def initialize(semanticVersionString)
    version = semanticVersionString.match(SemVerStrRegexp)
    if version.nil?
      raise ArgumentError.new("Provided String is not SemnaticVersion string")
    end
    @major=version[1]
    @minor=version[2]
    @patch=version[3]
    @preReleaseVersion=version[4]
    @versionString=semanticVersionString
  end

  def <=>(string2)
    string1 = self

    [:major,:minor,:patch].each do |part|
      result= string1.send(part) <=> string2.send(part)
      if result != 0
        return result
      end
    end
    result = compare_pre(string1.preReleaseVersion, string2.preReleaseVersion)
    return result

  end

  def compare_pre(pre1,pre2)
    if pre1.nil? || pre2.nil?
      return 0 if pre1.nil? && pre2.nil?
      return 1 if pre1.nil?
      return -1 if pre2.nil?
    end
    a = identifiers(pre1)
    b = identifiers(pre2)
    smallest = a.size < b.size ? a : b
    smallest.each_with_index do |e, i|
      c = a[i] <=> b[i]
      if c.nil?
        return a[i].is_a?(Integer) ? -1 : 1
      elsif c != 0
        return c
      end
    end
    return a.size <=> b.size
  end

  def identifiers(pre)
    array = pre.split(".")
    array.each_with_index {|e,i| array[i] = Integer(e) if /\A\d+\z/.match(e)}
    return array
  end

  def ==(string2)
    return (self <=> string2) == 0
  end

  def >(string2)
    return (self <=> string2) == 1
  end

  def <(string2)
    return (self <=> string2) == -1
  end

  def >=(string2)
    return self > string2 || self == string2
  end

  def <=(string2)
    return self < string2 || self == string2
  end


  def pessimisticOperation(string2)

    stringMatchValid= /\A~>(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][a-zA-Z0-9-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][a-zA-Z0-9-]*))*))?(?:\+([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?\Z/.match(string2)
    stringToCompare = string2[2..-1]
    semanticVerCompare = SemanticVersion.new(stringToCompare)
    puts "Anu"

    majorVersionIncrement = (semanticVerCompare.major.to_i+1 == self.major.to_i && self.minor.to_i == 0 && self.patch.to_i == 0)
    minorVersionIncrement = (semanticVerCompare.minor.to_i+1 == self.minor.to_i && semanticVerCompare.major == self.major && self.patch.to_i == 0)
    return majorVersionIncrement || minorVersionIncrement
  end

end