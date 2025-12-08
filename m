Return-Path: <linux-wireless+bounces-29577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BADCCABD6A
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23B2300940E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 02:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33BF22333B;
	Mon,  8 Dec 2025 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI65BHMo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555021F12F8;
	Mon,  8 Dec 2025 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765160447; cv=none; b=PQOtpNwdDjZI6VJXX5KIQFD05jggrh295GiL0xSy9oy6tdzOTWl8E1JOfBtYcvJuTFQOa/MqQmHB4ZZI/pJbHkQfXG9ccerEl0vz/UisOyUrHJUiyLu1n+La9Zm45fZ71LqtiJEQl1JiTp6BECO4IuGKQh9680t1hAvOWCl/gJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765160447; c=relaxed/simple;
	bh=TAKQ1BejKaRZJjBshOAo3jq/BYcYSUoEANnrwmHTPqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrSHzvYoUP/q38BKqxwULfPf/ozUWDTuf2/C4XKZ3cUcSDHOsvU+Q7u8eciFqBXdQ0Bjzb+WWpatGFoiltYOeOeyxSn47s9hlDKinigHF+3krIyEyTZrmztzGB+ZdD70H/Say6Lc1rdjisqrEeJ79+XGaoV7V1IkuqoRuNP3avA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI65BHMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7F4C4CEFB;
	Mon,  8 Dec 2025 02:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765160447;
	bh=TAKQ1BejKaRZJjBshOAo3jq/BYcYSUoEANnrwmHTPqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RI65BHMoNBJncsbWuTsTKsrmiPi8D4zLMYxbFWPqm6zIIqoez3U4WCyGO4Bba9mtF
	 0Jz3xUd+WKgvfz6MjExCa9pfoY/HVyDmzMswl4zzos39LssUlcZjz20ccm0rJFeurh
	 AZDbhDWdb7kNNkteH4z0/NHRy5HLrJHuFHIbjoAVbBrN4FQ5XCIPd16/S90wQsslFG
	 2b1YJ/AKtIHjTO7a1blolbsRqnTgtv4jeWHyCAWcEyhs6j/rUVOJGHnU1xhLzq0F8e
	 /qUrj7RBnCeyTfzybQtlG88avHQ+SUH5YcT8HFwnSRYUq9KSuB5zLqVFzRnaNL9+dI
	 2h40bx5Ge2xuw==
Message-ID: <40ab3a19-01b5-461e-aaf9-c3d8142fc926@kernel.org>
Date: Mon, 8 Dec 2025 03:20:38 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] dt-bindings: wireless: ath12k: Add disable-rfkill
 property
To: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>,
 Rob Herring <robh@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Dale Whinham <daleyo@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251201011457.17422-1-daleyo@gmail.com>
 <20251201011457.17422-7-daleyo@gmail.com>
 <7ea43ef2-b453-46cf-a35e-ea11ca1dbe24@kernel.org>
 <CA+kEDGEjR7cGA0zZfuKkYg37mJZs3Fn7eKbgkB6hdjDLtGxjRQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CA+kEDGEjR7cGA0zZfuKkYg37mJZs3Fn7eKbgkB6hdjDLtGxjRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/12/2025 20:28, Jérôme de Bretagne wrote:
> Le lun. 1 déc. 2025 à 08:34, Krzysztof Kozlowski <krzk@kernel.org> a écrit :
>>
>> On 01/12/2025 02:14, Dale Whinham wrote:
>>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>
>>> rfkill should be disabled according to the Surface Pro 11's DSDT.
>>>
>>> https://lore.kernel.org/all/20250113074810.29729-3-quic_lingbok@quicinc.com/
>>> has added support to read the ACPI bitflag when ACPI is supported.
>>
>> It wasn't merged. If it was, reference commits, not random emails.
> 
> Good catch, It was merged in commit c6a7c0b09d5f, we will reference
> this commit instead.
> 
>>> Document the disable-rfkill property to expose one specific feature
>>> (DISABLE_RFKILL_BIT) for devices described with a DT, so that the
>>> feature can be disabled.
>>
>> This is just a circular logic. Add property to have property in DT so
>> that you can use feature.
>>
>> No, describe the hardware or actual problem instead.
> 
> Point taken. Would something like the following be better?
> 
> "For some devices, Wi-Fi is entirely hard blocked by default making
> the Wi-Fi radio unusable, except if rfkill is disabled as described
> by an ACPI bitflag on those models. Add the disable-rfkill property
> to expose the DISABLE_RFKILL_BIT feature for devices described
> by a devicetree."
> 
>> You still need to answer Rob's questions.
> 
> Indeed, we didn't answer another question, sorry. Here it is for
> reference:
> 
>> [Rob] Assuming it belongs in DT, why is this ath12k specific? Could be
>> for any wireless chip...
> 
> Agree, it could be applicable to any wireless chip, it should be moved
> somewhere else. Would ieee80211.yaml be the right target file for
> this property? Or any other file suggestion instead? Thank you.

Yes, then place it please in above iee80211.yaml common file, with some
sort of bigger picture explanation.


Best regards,
Krzysztof

