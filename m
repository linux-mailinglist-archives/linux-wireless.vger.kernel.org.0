Return-Path: <linux-wireless+bounces-18059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A963A2072F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 10:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45795188AA6F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E191DF997;
	Tue, 28 Jan 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSesVS6O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCD1DEFE9;
	Tue, 28 Jan 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056020; cv=none; b=Kp96xkDho45rd7Y4+Qh9n01fS1Q/EpR7AMP4oG1O9if5LQslWbEQ7WY6YBdj6h7S/0U4RFQF7nFRZ5E13OcNByya29xUjYIiT72p+UQ+8AWo2XDJY1LE0kEnzBTq46YgZhMW6Wd9Pv3oRalxadQuxmqQB8Aq10s2L5xdB30PVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056020; c=relaxed/simple;
	bh=rGOqPnMcPaALyi5d29RWxJtKcmZH4LunMi/Lgq+Ty6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvQFicBSuRLjt+IwEEdo9P5uYwsUpgDwWwBzNuLkYbqp+gEqbJEha3PCWQaRlhLqTC8D3hHV2E7g2s2WlXkiySM4badt/hoFmv2M3vDOlAMQK69wpPEfwuNizKorySNNK4otAMjUa0c02gjzGtKS07Vy+wMrdA76mKyGAjRbhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSesVS6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3342FC4CED3;
	Tue, 28 Jan 2025 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738056019;
	bh=rGOqPnMcPaALyi5d29RWxJtKcmZH4LunMi/Lgq+Ty6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cSesVS6OsKu/zn6nh779zkr66YxjwF/EWVzjwITPJG5Oc/HLDK1zRztPZm//DaPeP
	 k6f/b4uPXAZC+oWS2PqEfnPZ04ng3erqkVtL1E/Xg6oUCvso0gbmx6k90Nuu46yU66
	 uEFVWCTWykEVp3aPKqwQSTFgrBiX9txPWar/GoJhAC8ykcbv1FIT7nVAaYHISFDikn
	 PycRNjc/YHelLkcX+mZhg75AyGDRCO1CJF5oaulTu3yVLHvlHc5iiLfFG6diAA7lXY
	 uJ5+nAPNhDmC8mjOEAxK+Vv+tWbachTifGNT5NTm8y0lGgSntUwmTk/pJHhdKjbCJG
	 8R+plfeGr68ig==
Message-ID: <1df7ff9d-d63a-44f5-a67d-8f20973c7b57@kernel.org>
Date: Tue, 28 Jan 2025 10:20:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] wifi: ath12k: add Ath12k AHB driver support for
 IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
 <fd338dd5-db11-4439-835d-b6641f3feb78@kernel.org>
 <001ae2e4-bba8-4b76-a4b6-eda8533c5fc5@kernel.org>
 <af926bd7-730c-4465-a206-4168bb93d01a@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <af926bd7-730c-4465-a206-4168bb93d01a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2025 10:16, Raj Kumar Bhagat wrote:
> On 12/10/2024 8:42 PM, Krzysztof Kozlowski wrote:
>> On 10/12/2024 16:08, Krzysztof Kozlowski wrote:
>>> On 10/12/2024 08:41, Raj Kumar Bhagat wrote:
>>>> Currently, Ath12k driver only supports WiFi devices that are based on
>>>> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
>>>> Ath12k AHB support for IPQ5332.
>>>>
>>>> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
>>>> device:
>>>> - Add hardware parameters for IPQ5332.
>>>> - CE register address space in IPQ5332 is separate from WCSS register
>>>>   space. Hence, add logic to remap CE register address.
>>>> - Add support for fixed QMI firmware memory for IPQ5332.
>>>> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>>>>   AHB support.
>>>>
>>>> v4:
>>>> - Missed to include some review list in v3. Hence sending v4 with
>>>>   all review list as per - scripts/get_maintainers.pl
>>>>
>>> The amount of undocumented ABI you add here, points to the problem that
>>> either your drivers don't work or your drivers would never work with
>>> upstream. Why? Because either you would have wrong DTS or drivers not
>>> matching DTS, thus not working.
>>>
>>> Please point us to your upstream DTS implementing (and working 100%)
>>> this ABI, so we can review that you do not sneak more broken or
>>> undocumented things. I will NAK also future submissions without above,
>>> because I believe you usptream something which will not work.
>>
>>
>> I dug a bit and I found your earlier v2:
>> https://lore.kernel.org/all/20241015182637.955753-3-quic_rajkbhag@quicinc.com/
>>
>> which confirms:
>> 1. DTS not following coding style, so not possible to accept
>> 2. Driver relying on that exact DTS, so not really working.
>>
>> Please post in separate series updated DTS, after fixing all the issues
>> pointed out by DTS coding style.
>>
> 
> To fix all the issues in DTS (including undocumented ABIs) we did changes in
> dt-binding as well.
> 
> The dt-binding and working DTS are now posted as separate series -
> https://lore.kernel.org/lkml/20250128091012.2574478-1-quic_rajkbhag@quicinc.com/


You replied 1.5 months after, so entire context is gone. Anyway, your
DTS does not work.

Best regards,
Krzysztof

