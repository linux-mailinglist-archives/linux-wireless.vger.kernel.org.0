Return-Path: <linux-wireless+bounces-14063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176409A04F1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 11:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C333228A650
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F68204F8E;
	Wed, 16 Oct 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzlAZV83"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA4417D378;
	Wed, 16 Oct 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069263; cv=none; b=lNlESbNiuIbdY+Het2yoaOgqF39Eyq/fDLII7m5gnszux4Koy5F0MbNSqX+L830yLk+DY8Nl1VGUi4sXdnRaM5Yl9Zy54N7DM3poTbFiboPDlpP6Yp6tDHl2NrdhiYuWs0tvWbLWat89yK7R2dPkfWR2OFafvS9mkuNd0cTXz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069263; c=relaxed/simple;
	bh=biQEO64j7oV50Bnrtyg65cg1yD57qTZrXWBPJsZN1ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ey51ueedYZNPcTsjLTJbWrlIED1UZ2w0i5OgDiEmKjXw8UwKsEIZd7h0Y6NJPmXVDVAQ1MAL4ApiH8lpBW2aO2nP4TEjuVWjS8WOaByE9x4cqMu0B4gLOzuzfWmF4h87V/vREqe/LdYZtzT66EErXcMOXn1vH2bGkBsFT1/gpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzlAZV83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5ACC4CEC5;
	Wed, 16 Oct 2024 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069262;
	bh=biQEO64j7oV50Bnrtyg65cg1yD57qTZrXWBPJsZN1ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EzlAZV83AMYZdVe+Y5aKVS4H2emCG3ZBzoelrAnfNUZ46H65AFtFktxxtgIV9GMbk
	 z3J9jFSJSWmBpW9R3BN0qF6iH/jtfN2CsX3HD1KJqqOa7DgCL3+HL0kc4UTYsqcKIc
	 7WnLOOA/mTkG/ZBWd+3RteDUOrFNjm/5Tsi1qhcq7X8WGlBzdkqRhVwu4T24j3CHIR
	 FhIJkG5H0ARW783JS4Uyv+K1WtrgRkA+tnjqFk0721zm4VPwfSDWW1fscl+6CBpQTD
	 Zoeul/g3Rz5fnHn8A6tzxp2ukHsEM7X8v+YK1J3NxaXfufxjHJfIehSkz0NjJssMHG
	 X5I4IU65oCFHA==
Message-ID: <b5f352e8-19a5-4c06-b9ba-44af791f6a81@kernel.org>
Date: Wed, 16 Oct 2024 11:00:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-2-quic_rajkbhag@quicinc.com>
 <h4xel7xh3vyljxi7jn2afqasfmbsiqjtgpvqthrviovode6cxt@ey5nnzi4dwtv>
 <708e9d22-0513-4646-aeac-2187c052e208@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <708e9d22-0513-4646-aeac-2187c052e208@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 10:37, Raj Kumar Bhagat wrote:
> On 10/16/2024 12:32 PM, Krzysztof Kozlowski wrote:
>> On Tue, Oct 15, 2024 at 11:56:16PM +0530, Raj Kumar Bhagat wrote:
>>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>>> device.
>>>
>>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>>> ---
>>
>> That's a v2, what changed?
>>
>> Did you ignore entire review? Limited review follows because of that (I
>> am not going to do the same work twice).
>>
> 
> Review comments in version 1 are addressed.
> 
> Per-patch version log is not added here. But we have consolidated version log
> in the cover-letter. Will include per-patch version log from next version.

Hm? There is no such in cover letter. There is description, dependencies
and list of commits which indicates end (format-patch standard stuff).
> 
> Below are the version log for v2:
> - "qcom,board_id" property is dropped. This is not the direct dependency for Ath12k
>   AHB support, hence it can be taken up separately.
> - "qcom,bdf-addr" property is dropped in device-tree and moved to ath12k driver.
> - Currently we have only one compatible enum (qcom,ipq5332-wifi), hence conditional
>   if() check for defining the binding is removed.
> - "reserved-memory" node is dropped from example DTS.
> - "status" property is dropped in wifi node of example DTS.


>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: gcc_xo_clk
>>
>> Drop _clk, drop gcc_. Look how this clock is called *everywhere* else.
>>
> 
> Thanks, Based on other bindings example, will rename to "xo"

git grep gcc_xo_clk -> nothing like that!

...

>>> +
>>> +  memory-region:
>>> +    minItems: 1
>>
>> upper constraint
>>
>>> +    description:
>>> +      phandle to a node describing reserved memory (System RAM memory)
>>> +      used by ath12k firmware (see bindings/reserved-memory/reserved-memory.txt)
>>> +
>>> +  qcom,rproc:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      DT entry of a WCSS node. WCSS node is the child node of q6 remoteproc driver.
>>> +      (see bindings/remoteproc/qcom,multipd-pil.yaml)
>>
>> DT nodes are not children of drivers. But other DT nodes. Explain why
>> this phandle is needed, what is it for.
>>
>> To me it looks like you incorrectly organized your nodes.
>>
> 
> This phandle is required by wifi driver (ath12k) to retrieve the correct remote processor
> (rproc_get_by_phandle()). Ath12k driver needs this rproc to interact with the remote
> processor (example: booting-up remote processor).

That's driver aspect. Why does the hardware needs it?

WiFi is the remote processor, so I would expect this being a child. Or
just drop entirely.

You keep using here arguments how you designed your drivers, which is
not valid. Sorry, fix your drivers... or use arguments in terms of hardware.


> 
> In next version, will correct the description based on existing bindings (qcom,ath11k.yaml).

Sorry, let's don't copy existing solutions just because they exist.



Best regards,
Krzysztof


