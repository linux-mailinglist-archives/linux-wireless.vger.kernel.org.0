Return-Path: <linux-wireless+bounces-20581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A697CA699BF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 20:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E0A464A68
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D9F2101B3;
	Wed, 19 Mar 2025 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9vZACxq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62010A920;
	Wed, 19 Mar 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413816; cv=none; b=S7tVdxW3VO1cQLlUaY5dYJODz4LciM+cnKf1rbjGjUQOWqZHu5rkWAvmFtxFT4JWMond/i2d8tCJ7+RFI0UzRXXlf9hcELE+TlVRR4sS4XRm0W+T+wn7txf7DgOzSUT5n2HFYkyopqz/i4WkT6Cr9sdUCvjhl4898VULr9pvKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413816; c=relaxed/simple;
	bh=ZsbP6Tfa+TakJIzIxvjtnOXdCdqTl1sJleAd/BtH++E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jW4pptXor4n3cr6Ut7Pbd5nZy3683r7RdFuVXUn/RapkVGpo9iH3bGu06HycHiYDyTHa/bEvMVRCYgg59Duc8L0ND8CrXPtgWRTMRHCimaPu4Wh5BR5QOPR+uqlXaBHWYjk/D1dYD/yO/1NrrtfvxIXHMEDFbQdgZ1bZY4y9MGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9vZACxq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so93775a91.0;
        Wed, 19 Mar 2025 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742413813; x=1743018613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOCrjFT8pPG35qudWbMcGszw7gK+zyViIVYP8L9Kl0U=;
        b=M9vZACxqajJSaTjaKKsISGzWgQWJ+1OXTMda/0GvWz9oKB+AgDAIfkIq5Upy0RTsNM
         Y5A4dhttMzt/XFd5c9AYPEfj2104r7ntERHQUQT+bzJ+tydHEEhya2Q4WJ2LP7XWTfi9
         jdFXY0plWLKHC1AGgMXBQ7Nx8Tn0ES1yzvtvxtkKg4N8MbsjuN9REiPxHueJYanPtgww
         QxjrwXoVaETpUlblIIitrVHR8JDO7lCumaA71++QC2VkrJPjci13s7IZNoTr5unFrCTZ
         hvBA+55/kxusYSO1ga8ACfsmiaYsByHj+U30L9gFktSwiuOu06fwzw9XKlBmZd26kAQl
         rn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413813; x=1743018613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOCrjFT8pPG35qudWbMcGszw7gK+zyViIVYP8L9Kl0U=;
        b=Jk5Q5TcB0gRSfYyjdbpTqao3Tw+pT5ZpCElIrp6Ta3iNV0l/4IKdZHs8r61RLI9C77
         m+GKdUaWnjw5M6Aqp7fotxbiZsi8D2IgEpdjNreei9FtTcUMUGo5kl8jUuZaoe0Tmyc5
         W9iT0gP4rUScA6JtSIvH6Q+uYbYgxRGYDb6FoXdZGcqcyfJfDdZuPlNGYEcgs16WtmyM
         Ri2IrMbVhWGjshCZCMG6t++bqDjgzY8MitFOFw/ZTKHecw0sj+FRipDd9G7JlatKQYBB
         2DO/V3pgOrr+X+Uz1PdIem57B4rvZPonyKTbzsNj4RnZiSzm58bF0yArPoQag0OuajFG
         o3DA==
X-Forwarded-Encrypted: i=1; AJvYcCWMGn/n18f9tKDhvJn3Ci9HTiIizPkN60AqWxqJawMx8I6l9dxRlCqcZerdTh2+HanE3Ob55jowPZ6R4yJpVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKCfYum/Hv2TThYzUie1/qiOoo+Bc22B9u0lQ1FGGMhudTQr0
	MnIz6HYNowtSnsKQJABWDndSqKDg2ZpMcH2g9zjsgtQ/wxABXFJX
X-Gm-Gg: ASbGncvv4t3Xg61vpBq2V6+YuH1DmJDzxcBL4nl/RTOn+n/r7wEkq9VotKUyPY5BZOK
	vmroLIgLeO3acSWTE54h8OprSaPesr5pI3kbqF1378aQK6nM2wA4wefxIxXYXw6yC9n4FSmZ4Os
	7VMY4wJgKdvR5xfdSq43qb36ZQUAr7eS2LwDkAm/EmziMIW9AsHFhBUsXnttiT4R9Fy2jNiyd2v
	F0J9BRtebGNQy8bKeZrHfTPzfgVCZGgUlwf299LPjV7Ez9gDlDV+VApH8rgPH27UW6+RXPodRlq
	X0fVCankD4jyJn8MU1LhEtD3GIKOMlwwueMXZccOLutCZRcJ
X-Google-Smtp-Source: AGHT+IG60Nv4IyKEwP5oBlRZaeZbJxv+QDR41nvkKlo0pUCU9APXKlZxdx1aNv2TezDy79IPBTgtig==
X-Received: by 2002:a17:90b:3d10:b0:301:1c11:aa83 with SMTP id 98e67ed59e1d1-301be1f8caamr5530982a91.28.1742413813406;
        Wed, 19 Mar 2025 12:50:13 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58af67sm2087269a91.17.2025.03.19.12.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:50:12 -0700 (PDT)
Message-ID: <792bd4a3-4e51-49ef-ba55-1922505b1c8d@gmail.com>
Date: Wed, 19 Mar 2025 12:50:10 -0700
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

Hi Alexandre,

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

Fwiw I didn't see any difference in throughput with and without this 
patch. We do use wifi 6/6e APs and wifi 5 clients (ath10k), but I 
suspect it has something to do with our configuration not taking full 
advantage of 6/6e speeds, so the APs may not be proposing an ADDBA size 
that the client rejects. But I'll keep this in mind if we ever notice 
the behavior.

Overall though I didn't observe and regression-type behavior.

Thanks,

James

>
> Note, as a Wifi rookie it is not immediately obvious to me how the semantics of
> ack aggregation would interfere with broadcast actions, as ADDBA are supposedly
> unicast. But you're the expert :)
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

