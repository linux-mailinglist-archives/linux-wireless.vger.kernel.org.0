Return-Path: <linux-wireless+bounces-20566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2359A68F03
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5630016C505
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69464185935;
	Wed, 19 Mar 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrpcEvbH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E533985;
	Wed, 19 Mar 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394308; cv=none; b=FuNUNRMKpJ7BFpfFYk+QnBbEENtg7b17euWka6s1gv4PcAMvVEe6tD4mKrzK8BBxh1r1FpkQLHGgRBGAN6nZyTRX/CO7Nz8iXwOFZcNVIbEXIocFXxWqHbVSNL9DI8KHaeEsZQHvTPSVA1Iawn9eAhQIiV9vxCKGXKPOuLuMst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394308; c=relaxed/simple;
	bh=wDgw2csZBPQcWBrKVT5KpdphI4PqT1UDvWwdhE9RWlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qk/M5abmELpiSX8eJQtgRKZ+a2QCOp8JEYtI8E0rK7GXbMggFLqzZySk9LIQNmuo9YzqxndRpPI46s/FEiKs1/NuNiuLAlWFMtQCfkB7cO026fYJQA2swMAoTTN3GAKm1BUwzb2zlEcr0Smx7W65nVcfiiDJI5JF0wMCIGfaviI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrpcEvbH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22398e09e39so151093805ad.3;
        Wed, 19 Mar 2025 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742394306; x=1742999106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNksdIhq+kJyMWp8wRFPS1me1SWYSJ97oSn66vlZssA=;
        b=hrpcEvbHNNtzFYtlaEtKd9YKtYuXgWq0Q73IF1MR/a6Q/4Xz9R7aQqLEcPRQNYnTG+
         dSfGa93tAsmUVVCZS2JyIOFpR5Tsd9C4XSiztv/aXPwjd3nVErShrssD7PJZ/Ixrqutk
         Bhf4xFe6VU1AnLRezorONIcRsUVnxdpE3cIF/bxmlctq+eE4pNqf4/2Zp5M+TqruPuY4
         mfqvFFssjhOXljny3qX4XuaAX59poye7lBkq3eQvIhT+6+ZCQU9V2KBsjDSEd9/vX0H/
         dnYvk79RqJ7KX1BqMp1BtV69w6S7caoAU/JL+poOlV969eHpCXXtBB2rT3GQ0HGR4mGC
         zkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394306; x=1742999106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNksdIhq+kJyMWp8wRFPS1me1SWYSJ97oSn66vlZssA=;
        b=r0CD/pyNA4lJFjWocdaQaI7mTcmkGv9+iZ/pyTqKVKaQ3enTVYgWW6VggWPsJ6ZC3O
         /8AEda19wjczkm1va/d/Fmrk336qpo+x/D7LVgxWcI3mW+DxavO9ArhmhgaV8urkLfS7
         jph1uDHFPf1ZaBCvMtAOri/5McGk4IEmsNxqAKIVCMYmyzWjTwYLXWmiLf0I9hEbyN0t
         QdThA2WtE6qUlqz4QKz7hBz4sip4HzJuzDAOQyCIYi1HYRMRjjC5CTIFUiiw7Rg9DzoC
         aNao5l9KN0+e2bjcX273GYpFnhvE7+zs8grGepEXDIs9jFrQNeyCgyrJEIrbLq7U70KD
         WEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNbt1Bw54e0EOsFChuJs4tm1NxpZQLhu8JzpUJ/HVGZoMNBARvvfR/kqJQxJZ7dA9l0tHfdUAWhOm/lfODVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIW4h6UUNfTu2Jzj9ACwZ+9llBd+6xd5uf3u3y+nm1h58n+S+
	KoZm/gn4IKyGJMv0GyoY8f6DbZBrjcpb+7tAR8PsZ8XVDH9ea94b
X-Gm-Gg: ASbGncvLGhPhNmUfZnMtwnVTbptvEKrBq1wvp+4CvmCyDI+oW/nXgto4Mq7fjl7L2Fl
	bJtNB+ANPed/K2Ou3yxGT1Cr13b2Aht5nlOq9Bo8EVGj+UKjOJa2Sv55pYe1dZCwYnuMTA4+Crb
	c5/yIibuvqmtBPOpN1IKTae0tna4yf3m+GeY0jIIKW9uhDUcZY/Y0Zuky9IsJdI3HiW+jy1BUfA
	Oih5MTj2L7Q/wG+Q1SC56s2ECKAicBAuFFN56mFwc1TKZjSNUPok6AJa1HPKKWbT1QAPgexE2rv
	990ZoNAJQDF3DrbZFJdJKzhzyGdtak08tmiKEM5dXyJrPh7NUlfG+nM+v9I=
X-Google-Smtp-Source: AGHT+IFuU4AzNWF5DfOUG7KW8ZkLZqHClL5Z/kkY80OgTtVyGqqloU1ReDkB8cGLzcdqjKadIfM3Ng==
X-Received: by 2002:a17:902:e847:b0:21f:4649:fd49 with SMTP id d9443c01a7336-22649a6a8e9mr42407545ad.49.1742394305643;
        Wed, 19 Mar 2025 07:25:05 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887eesm114845355ad.25.2025.03.19.07.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 07:25:05 -0700 (PDT)
Message-ID: <38569a89-778a-472c-a99c-f63f23870803@gmail.com>
Date: Wed, 19 Mar 2025 07:25:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mac80211: clip ADDBA instead of bailing out
To: alexandre.ferrieux@orange.com,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20250317163902.1893378-1-sashal@kernel.org>
 <20250317163902.1893378-2-sashal@kernel.org>
 <69c63a19-5419-4bbe-858f-6ca100345a28@orange.com>
 <1560b292-6366-4588-ad4d-654377613b84@gmail.com>
 <2b5c91c6-49db-42bb-803c-c01dc785e1f1@orange.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <2b5c91c6-49db-42bb-803c-c01dc785e1f1@orange.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/19/25 7:18 AM, alexandre.ferrieux@orange.com wrote:
> Hi James,
>
> There is roughly a 8x slowdown :}
> I got these numbers from the colleagues who detected the issue
>
>    - physical available bandwidth 1.733 Gbps (as per iwconfig)
>    - ADDBA offer size=256
>    - effective bandwidth observed 1.2Gbps with accept-and-clip-ADDBA (size=64)
>    - vs. 150 Mbps with reject-ADDBA
>
> Note, as a Wifi rookie it is not immediately obvious to me how the semantics of
> ack aggregation would interfere with broadcast actions, as ADDBA are supposedly
> unicast. But you're the expert :)

"expert", your giving me too much credit :) My running theory is that 
allowing multicast RX inadvertently caused the driver/firmware to 
receive more than just the action frames we registered for, and in turn 
bogged down the RX path, and introduced packet loss. We saw this 
externally as ADDBA retries in the pcaps.

So it may have nothing to do with ADDBA rejections/failures, but when I 
saw this patch it got me thinking. Thanks for the numbers, either way 
this seems like a huge performance gain so I'm eager to test it out even 
if it has no effect on the multicast action RX performance.

Thanks,

James

>
>
>
> On 19/03/2025 14:21, James Prestwood wrote:
>> --------------------------------------------------------------------------------------------------------------
>> CAUTION : This email originated outside the company. Do not click on any links or open attachments unless you are expecting them from the sender.
>>
>> ATTENTION : Cet e-mail provient de l'extérieur de l'entreprise. Ne cliquez pas sur les liens ou n'ouvrez pas les pièces jointes à moins de connaitre l'expéditeur.
>> --------------------------------------------------------------------------------------------------------------
>>
>> Hi Alexandre,
>>
>> On 3/19/25 3:58 AM, Alexandre Ferrieux wrote:
>>> When a Linux Wifi{4,5} device talks to a Wifi6 AP, if the AP proposes a Block
>>> Acknowledgement aggregation size (ADDBA) exceeding its expectations, the code in
>>> mac80211 just bails out, rejecting the aggregation. This yields a big
>>> performance penalty on the ack path, which is observable in comparison with
>>> other OSes (Windows and MacOS) which "play smarter" and accept the proposal with
>>> a "clipped" size.
>> Out of curiosity do you have any performance numbers for this, like
>> Linux vs Windows vs MacOS? We ran into a significant performance hit
>> after I added multicast RX support on ath10k (after ~30 clients were on
>> the same channel). After looking into the pcaps we saw many ADDBA
>> failures and ultimately had to disable multicast RX. I want to give this
>> patch a try either way, but I was curious if you had any data on
>> performance improvements.
>>> A typical scenario would be:
>>>
>>>     AP -> Device : ADDBA_request(size=256)
>>>
>>> Current Linux reaction:
>>>
>>>     Device -> AP : ADDBA_reply(failure)
>>>
>>> Other OSes reaction:
>>>
>>>     Device -> AP : ADDBA_reply(size=64)
>>>
>>> Note that the IEEE802.11 standard allows for both reactions, but it sounds
>>> really suboptimal to be bailing out instead of clipping. The patch below does
>>> the latter.
>>>
>>> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
>>> ---
>>>
>>> diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
>>> index f3fbe5a4395e..264dad847842 100644
>>> --- a/net/mac80211/agg-rx.c
>>> +++ b/net/mac80211/agg-rx.c
>>> @@ -317,18 +317,20 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
>>>                   max_buf_size = IEEE80211_MAX_AMPDU_BUF_HT;
>>>
>>>           /* sanity check for incoming parameters:
>>> -        * check if configuration can support the BA policy
>>> -        * and if buffer size does not exceeds max value */
>>> +        * check if configuration can support the BA policy */
>>>           /* XXX: check own ht delayed BA capability?? */
>>>           if (((ba_policy != 1) &&
>>> -            (!(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
>>> -           (buf_size > max_buf_size)) {
>>> -               status = WLAN_STATUS_INVALID_QOS_PARAM;
>>> +            (!(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA)))) {
>>> +               status = WLAN_STATUS_INVALID_QOS_PARAM;
>>>                   ht_dbg_ratelimited(sta->sdata,
>>>                                      "AddBA Req with bad params from %pM on tid
>>> %u. policy %d, buffer size %d\n",
>>>                                      sta->sta.addr, tid, ba_policy, buf_size);
>>>                   goto end;
>>>           }
>>> +       if (buf_size > max_buf_size) {
>>> +         buf_size = max_buf_size ; // Clip instead of bailing out
>>> +       }
>>> +
>>>           /* determine default buffer size */
>>>           if (buf_size == 0)
>>>                   buf_size = max_buf_size;
>>>
>>>
> ____________________________________________________________________________________________________________
> Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.
>
> This message and its attachments may contain confidential or privileged information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
> Thank you.

