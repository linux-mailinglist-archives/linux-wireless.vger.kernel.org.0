Return-Path: <linux-wireless+bounces-11318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 820AE94F5D8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 19:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE101F222E0
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2241713A3F2;
	Mon, 12 Aug 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5vk4H36"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50F18800E
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484019; cv=none; b=a+iJIcsMmaQwvMEV1s+5ZOmbSIRbJgInmEigDkTCc0SoRJJCuvxDckzepBi8LWHzgo/VlSuEvOaDGhTAwTqy0V1Vjd4VeBUbaHOLiQCiFTk3tz1um48+Hjw51JTi0exRf0zhrlDYHOQEMMn7+gTWrX7jEBSl5Zau/tVlqT/bpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484019; c=relaxed/simple;
	bh=J1OlJN0KMLR0zCfeNLQekZwvFckOFooHWwJOUJP5o6g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=m4gsQFa06I093nrxGQHYxpLxLOXElKA9e4/z7PBRIsOpCgLvKtMVAiPFZy71ARV1lSAXY3ZTWS48uZOJrr++9XX6bqGKj5BpQYb7rRt/1TIKdLAubnVjrJMEbchGtVK2Oqsxi7i+hmiaFLB6gIcU/GPxV5VAQPV5PUXfgoLgeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5vk4H36; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so5404268a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723484015; x=1724088815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNtiuyn57wimdjlrR1mgpCvsCFleEbroM/SCyyNnp7g=;
        b=K5vk4H36fO9GwEweCsBYHNtSsKel6Xe6kRfgzzy0K62sjv9GVArq/WgXSXOVheVRZz
         CGHSFTGWmzPbSH9lf0t+gMxcSiLlr5+O0KYUn9RlDLwUyBe2K4E/BXlji4RaWxahUNJr
         gkR7G2e4TdLqq41jBkvhYVQz+RArYaPwzHrs6GYnCK1Jux2Dovruwto4OjDDXIhV5sJ3
         4Jh/67QgFrn8sYHHwlznpQMJpsx4IORRivEQYrDrbmDlOl+obPL+YBiHX2H4Qyzk3R4v
         doNESrOT6xUFAwSdwcnILbbPMmSUoM7sjXFpLYi65ufTLvw2xoz6x+Q0n/VIDPtTncx/
         ZmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484015; x=1724088815;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNtiuyn57wimdjlrR1mgpCvsCFleEbroM/SCyyNnp7g=;
        b=oT+WfJAjkPTNMU9bhKEJiuAsX7oiXa12MpDA8Q9ZyAh/s/lM5WzARBWSydVvAFmAes
         p6iE/eKw6GgKckTsT3lsD+PaLq6jrB84I7r+o/UVYj5FZP1KmtP36TQzVQvL/Aubm9sw
         7K5poIRYTirktYHv3qhcQNDBl7bT856FJ6YNiVb8OUZ3g14TL6St2hSuaI+hTjVecKV/
         r+vKIXs+P99vBTiMwRlfKWklcLF07vvZ2+QylZOWNIsaJh3Y7bD7bxQedYV64nUvXIb8
         LfnhdA8cox/Ovff6I+BWWvOwrxBxYKcxp5A4pzclJM5HQN+Ic+luUUsYzetS5bAxS3yC
         FE2Q==
X-Gm-Message-State: AOJu0YwiUIpDKpigVlACQ2Y002ICTnM/pK3iZp2sQ3/t1rE5Re13ormL
	ZSiT784Al21kLcmE6yxcsMEd915JkZCIzo8YD7LoqdK/cbPrKRLF+mS4yQ==
X-Google-Smtp-Source: AGHT+IH2S/uqRvhXne/3rXJ59ZEqUDgqzmDZ4OLXaH8g+ZRO+A5MCHSsmA6rMDXpD4Ct57C3lEc6cQ==
X-Received: by 2002:a17:907:6d27:b0:a7a:b385:37c5 with SMTP id a640c23a62f3a-a80ed1d4638mr76024566b.17.1723484014742;
        Mon, 12 Aug 2024 10:33:34 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cce87sm249887766b.101.2024.08.12.10.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 10:33:34 -0700 (PDT)
Message-ID: <9eafac85-2262-4f92-a70b-32109f65c05a@gmail.com>
Date: Mon, 12 Aug 2024 10:33:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
From: James Prestwood <prestwoj@gmail.com>
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <c407064a-1c2f-46ec-ac57-32bf9cf6f5c6@gmail.com>
Content-Language: en-US
In-Reply-To: <c407064a-1c2f-46ec-ac57-32bf9cf6f5c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

So I have no resolution to this (trying to get the AP vendor to chase it 
down), but I'm toying with the idea of trying to work around whatever 
issue the AP is having when this occurs. The only thing I can think of 
is that there is a 3 second delay between the authentication and 
reassociation, and perhaps this is causing some timeout in the AP and in 
turn the deauth.

I'm wondering how long it should take to add/remove a key from the 
firmware? 3 seconds seems very long, and I question if this timeout is 
really necessary or was just chosen arbitrarily? Is this something that 
could be lowered down to e.g. 1 second without negative impacts? The 
code in question is in ath10k_install_key:

ret = ath10k_send_key(arvif, key, cmd, macaddr, flags);
if (ret)
     return ret;

time_left = wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
if (time_left == 0)
     return -ETIMEDOUT;

Thanks,

James

On 7/15/24 4:54 AM, James Prestwood wrote:
> I forgot to mention:
>
> QCA6174 hw3.0 firmware WLAN.RM.4.4.1-00288-
>
> The higher rate of frequency is happening on kernel 5.15, although as 
> I said only at one location with a different AP vendor. We have many 
> other 5.15 devices with significantly less instances of this 
> happening. I also checked a few of our newer software releases using 
> kernel 6.2, and the timeout occurred there as well, but no real impact 
> (no disconnect, no assoc timeout).
>
> On 7/12/24 6:11 AM, James Prestwood wrote:
>> Hi,
>>
>> I've seen this error mentioned on random forum posts, but its always 
>> associated with a kernel crash/warning or some very obvious negative 
>> behavior. I've noticed this occasionally and at one location very 
>> frequently during FT roaming, specifically just after CMD_ASSOCIATE 
>> is issued. For our company run networks I'm not seeing any negative 
>> behavior apart from a 3 second delay in sending the re-association 
>> frame since the kernel waits for this timeout. But we have some 
>> networks our clients run on that we do not own (different vendor), 
>> and we are seeing association timeouts after this error occurs and in 
>> some cases the AP is sending a deauthentication with reason code 8 
>> instead of replying with a reassociation reply and an error status, 
>> which is quite odd.
>>
>> We are chasing down this with the vendor of these APs as well, but 
>> the behavior always happens after we see this key removal 
>> failure/timeout on the client side. So it would appear there is 
>> potentially a problem on both the client and AP. My guess is 
>> _something_ about the re-association frame changes when this error is 
>> encountered, but I cannot see how that would be the case. We are 
>> working to get PCAPs now, but its through a 3rd party, so that timing 
>> is out of my control.
>>
>> From the kernel code this error would appear innocuous, the old key 
>> is failing to be removed but it gets immediately replaced by the new 
>> key. And we don't see that addition failing. Am I understanding that 
>> logic correctly? I.e. this logic:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503 
>>
>>
>> Below are a few kernel logs of the issue happening, some with the 
>> deauth being sent by the AP, some with just timeouts:
>>
>> --- No deauth frame sent, just association timeouts after the error ---
>>
>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for 
>> new assoc to <new BSS>
>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install 
>> key for vdev 0 peer <previous BSS>: -110
>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous 
>> BSS>) from hardware (-110)
>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>> Jul 11 00:05:36 kernel: wlan0: authenticated
>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> 
>> (capab=0x1111 status=0 aid=16)
>> Jul 11 00:05:36 kernel: wlan0: associated
>>
>> --- Deauth frame sent amidst the association timeouts ---
>>
>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for 
>> new assoc to <new BSS>
>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install 
>> key for vdev 0 peer <previous BSS>: -110
>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous 
>> BSS>) from hardware (-110)
>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while 
>> associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>> Jul 11 00:43:24 kernel: wlan0: authenticated
>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> 
>> (capab=0x1111 status=0 aid=101)
>> Jul 11 00:43:24 kernel: wlan0: associated
>>

