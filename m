Return-Path: <linux-wireless+bounces-14915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F2F9BC6E1
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 08:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86E3B226FA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64231FDF96;
	Tue,  5 Nov 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K14EgAS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E871FCC73;
	Tue,  5 Nov 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791501; cv=none; b=mgGnvMBpkg2pB8Qv5xh2EOwQk1NbdKd8frEFgdPMU4A5If4QoCiWp4jCrwZwtr10tpkZED+JF8gD0cwOuWEnX3yr4cvHwZBbJPZfdvwL7RpF914NyWU5DQVIlAk/pIwkKegR1Zh+u8Lse7RlULkyvEBYCyZaHyGxngCyC1/tqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791501; c=relaxed/simple;
	bh=eGZxOOO0qWTRtmyQ0DkH96remcaIk4dbRJWRtFjc1lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQVWXY3ZNFRnVVgLfzOscmd0lr0jX724ZQ4O1UBdZM/OxCucXWNJOja6cZ3GFJ/YaqSLA2qPCrNtgS4qqOKXndKhYJn69FBq0Qfuyv+zQWEhHA5GXPRcIW4LsC0VaLTrk1LsjHp37YazpNA9wO/bZM1gM8qBLD8yWrr9AUxwnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K14EgAS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2289DC4CECF;
	Tue,  5 Nov 2024 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730791501;
	bh=eGZxOOO0qWTRtmyQ0DkH96remcaIk4dbRJWRtFjc1lI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K14EgAS6cDnTl21odnotu2jbCE8UH0RU0svMLudd6nSUM/Uypckng9DUUeJcf7uy1
	 7WMup32SpBZ4FFT7474tkrYsoj3bB5Vz2uPit3OJh41bDq/mGK2jKrlaOtDHNrFIFO
	 ZcHjKjZx7spAna2uRBPMaY363DM+N7qhKL6f+xSfRCdAWraEO7t5u5hP9/YLjlQjyy
	 MAG09FxHOJ/gMyXpjJsxNkga1U183WuOTWmgyOpqKo1VAoTBBKJt3DjGUIdHnbtoMR
	 yvWL+jm9w0TVbccw/l8g9940aSJ7tphWXZfftLUKLT1lCcqsYhwM63GIFT4JXuMG9y
	 sJUaop/OYgL8w==
Message-ID: <74c84937-fa12-4ab2-922b-7889eb5dda47@kernel.org>
Date: Tue, 5 Nov 2024 08:24:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: net: wireless: ath12k: describe
 WSI properties for QCN9274
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
 <20241029173050.2188150-2-quic_rajkbhag@quicinc.com>
 <764f8f22-146d-4edc-9d46-7fe3c7d9a2f2@kernel.org>
 <cb69c30f-8230-4a8f-a538-3ec964b79084@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <cb69c30f-8230-4a8f-a538-3ec964b79084@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2024 19:44, Raj Kumar Bhagat wrote:
>>>  $id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml#
>>> @@ -18,10 +19,17 @@ properties:
>>>    compatible:
>>>      enum:
>>>        - pci17cb,1107  # WCN7850
>>> +      - pci17cb,1109  # QCN9274
>>
>> I asked for separate binding because it is quite a different device.
>> Unless it is not... but then commit msg is quite not precise here.
>>
> 
> sure, will create a separate binding, may be "qcom,ath12k_wsi.yaml".

Underscores are not allowed in compatibles and the file name follows
compatible name, so use hyphen.
>>> +    type: object
>>> +    description: |
>>> +      The ath12k devices (QCN9274) feature WSI support. WSI stands for
>>> +      WLAN Serial Interface. It is used for the exchange of specific
>>> +      control information across radios based on the doorbell mechanism.
>>> +      This WSI connection is essential to exchange control information
>>> +      among these devices.
>>> +
>>> +      Diagram to represent one WSI connection (one WSI group) among
>>> +      three devices.
>>> +
>>> +               +-------+        +-------+        +-------+
>>> +               | pcie2 |        | pcie3 |        | pcie1 |
>>> +               |       |        |       |        |       |
>>> +        +----->|  wsi  |------->|  wsi  |------->|  wsi  |-----+
>>> +        |      | grp 0 |        | grp 0 |        | grp 2 |     |
>>> +        |      +-------+        +-------+        +-------+     |
>>> +        +------------------------------------------------------+
>>> +
>>> +      Diagram to represent two WSI connections (two separate WSI groups)
>>> +      among four devices.
>>> +
>>> +           +-------+    +-------+          +-------+    +-------+
>>> +           | pcie2 |    | pcie3 |          | pcie1 |    | pcie0 |
>>> +           |       |    |       |          |       |    |       |
>>> +       +-->|  wsi  |--->|  wsi  |--+   +-->|  wsi  |--->|  wsi  |--+
>>> +       |   | grp 0 |    | grp 0 |  |   |   | grp 1 |    | grp 1 |  |
>>> +       |   +-------+    +-------+  |   |   +-------+    +-------+  |
>>> +       +---------------------------+   +---------------------------+
>>> +
>>> +    properties:
>>> +      qcom,wsi-group-id:
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        description:
>>> +          It represents the identifier assigned to the WSI connection. All
>>> +          the ath12k devices connected to same WSI connection have the
>>> +          same wsi-group-id.
>>
>> That's not needed according to description. Entire group is defined by
>> graph.
>>
> 
> So this mean "qcom,wsi-group-id" to be dropped and we can assign the
> group ID (in ath12k driver implementation) by using the graph?

Yes

> 
Best regards,
Krzysztof


