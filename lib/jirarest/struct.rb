class Struct
  def to_h
    Hash[*members.zip(values).flatten]
  end
end