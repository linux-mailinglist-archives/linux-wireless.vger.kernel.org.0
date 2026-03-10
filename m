Return-Path: <linux-wireless+bounces-32921-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J+NHt5JsGnFhgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32921-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:42:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C5254FE9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0DCA30C192C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92023B6349;
	Tue, 10 Mar 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdbfzdRP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE6397E86
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160472; cv=none; b=BYwvObqq0RiTAMqyUKmAgl4tmxGHZdcVkvn1VzGNK0Oxjw5pxX+X0VnCiod+H6RsOR/ZIX50YewEDwUV9FYX/MOH76lZcUcnIzHReg3Y4IPDOYTGaAIsz7mvEXceSPGCfTF2ws3wkcFp1cM8wCx16am+RLtKcBbe5D8iw+IGBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160472; c=relaxed/simple;
	bh=wxzEfd39lqDXY9VUjcFCvjnWniY0MqD1HSt0+RRoRj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+zl/KL56C+g4Dhajk5U4QXKKNIiL4//2GYUQOiN5PlFbPWBYi/D09/rQOExtVC/L7we2QcmB1RxXoB+fRuRzHncDGMifwd3Nch8Ki2vlimissk5PqNTGAiudmjM00kKjPJ/DB8BRCzqyhWH01srTQp69pdfAhzlasPvONwwwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdbfzdRP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c73bbdc01b7so724955a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773160471; x=1773765271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PLZtl3oVr4yYDPbn5N7JCWRiWZLyk0vw6WyQr08T0Wo=;
        b=DdbfzdRPeWZke5kEe259r0Hkh+Fel3DkycJHddzJIfHD3T2SWWAH652E04HP8FPYSS
         KnaA/V0889Dc33QqqQ5+d+NKN9+Curu/ugvFv7FkrbTgBIJPcwydb4rRw0o2J0zlUonm
         97F/bZvdypbskjlPVpl5ae7aq9HT+QIsSAS2NuP1WDj2JGtamWNCWJ3ku7fOa8kfCvfp
         nf1yQnsyDqDUaM2Y/pjNFBTlrK4lxVkHcfc8lq+JV2bRNW4DH7qJHKw/zFbmC5i56CaT
         s3hWmUNRocmn9sz3YOYdPKmEZJQZxpOjbEUUpYgxvf0FIw6z2XKuChyhGDh3//E+4pYI
         URdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160471; x=1773765271;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLZtl3oVr4yYDPbn5N7JCWRiWZLyk0vw6WyQr08T0Wo=;
        b=ZQ4IVEihdbq6K5zATa/xbnrRZ/eKYA6sddDu3a0gYN+xZ550rTHxwE3mjwIR7MBOgA
         ONeCGWjpOq0uQFpBKW2aI8pyTbFWeypcI5jtlTsCc4vYvmPjrQJYHK7kS6kwV8/4b7GI
         wt1aHwMSuGFiQV1ReOwAR7uQTwWvmUR/xsiaEbOJ+JrNXdELzvJEpwyNPbk26d++VkXJ
         QJs0CZ6G/y961aZTfKx0s+iMLVLfemNFFC+a0YG1LAzRLOybrOwBgzKhYJ9dtDq6Tgf2
         FMXeHpnDNxEotsce5EVu0jl2Y+pVpWBWayS8jw04gorQHTwNbK9ka0NUtZrT2DiroIKn
         xH2A==
X-Gm-Message-State: AOJu0Yyx0fwB3f8cyRYwMXs3/QcpIsnmcmRnZJ7OH9oUp/fw9+FPc9b8
	W9Uj+N5wscYKa3wb1Y7rBN8i4ngiZOsnVRcAp88KoZQb+wlUFy+J0RWVbHQFnw==
X-Gm-Gg: ATEYQzynNJI2D8ojj9WUCJjoQ/ml9U7cmBM055j3Rf3Mnz0o490SUTxqqd6b6uUq8JC
	MTeasEFHiec+liD7WzfAGEnKsyiBTsvg7qEHbbY8WCrfhImD1Wli8kAWlpemVQ6g981OyyYoB0D
	UgMh8NKCpzzMxR2gRQiBRjsELFf8xq5agoFvLP2KuMkpmE1Lr7CMfj4Kq4J3eTnGBJMeVuCy6Ea
	UE2hOvzZQwl9Yboei7Jgh2ASWjs2DNG0L70GzYMVdLnz083yKTTg8pxwC22Kpv3EfJLaKfEe8wF
	J3Yzq1iEXsk51tTY2ffoTRMFtb91Rn0LVwaSS1wIeRcwplO6SM3U+hyIR9bT8xWRWjdhHlO2tcl
	63CwE4lVmm1xlD4cqo8zNuu04LAQFZocOClUFaLn6WtyR3D+dbXmwcFsOgbcq5BQN+EySApmsy1
	jxDdXoCKdJTzECnPn9ce9SsmtTNwKrg741Y8HcSStQwntG77lc+z/OiZdD+rj7JkelcZSBYcDn
X-Received: by 2002:a17:903:2406:b0:2ae:46b9:c645 with SMTP id d9443c01a7336-2ae8253879emr145182475ad.50.1773160470770;
        Tue, 10 Mar 2026 09:34:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783dbsm160260725ad.42.2026.03.10.09.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 09:34:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0f5c2dd8-e1e0-4588-ad37-6503dde96780@roeck-us.net>
Date: Tue, 10 Mar 2026 09:34:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wlcore: ensure skb headroom before skb_push
To: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
Cc: linux-wireless@vger.kernel.org
References: <097bd417-e1d7-acd4-be05-47b199075013@lysator.liu.se>
 <1768df30-cac9-4c55-a8bf-1d927d59029c@roeck-us.net>
 <6895624e-22f8-d533-5167-e32de031e369@lysator.liu.se>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <6895624e-22f8-d533-5167-e32de031e369@lysator.liu.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED9C5254FE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32921-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[roeck-us.net];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,roeck-us.net:mid]
X-Rspamd-Action: no action

On 3/10/26 08:52, Peter Åstrand wrote:
> On Wed, 25 Feb 2026, Guenter Roeck wrote:
> 
>> Hi,
>>
>> On Wed, Dec 03, 2025 at 08:57:08AM +0100, Peter Åstrand wrote:
>>>
>>> This avoids occasional skb_under_panic Oops from wl1271_tx_work. In this case, headroom is
>>> less than needed (typically 110 - 94 = 16 bytes).
>>>
>>> Signed-off-by: Peter Astrand <astrand@lysator.liu.se>
>>> ---
>>>   drivers/net/wireless/ti/wlcore/tx.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
>>> index f76087be2f75..6241866d39df 100644
>>> --- a/drivers/net/wireless/ti/wlcore/tx.c
>>> +++ b/drivers/net/wireless/ti/wlcore/tx.c
>>> @@ -207,6 +207,11 @@ static int wl1271_tx_allocate(struct wl1271 *wl, struct wl12xx_vif *wlvif,
>>>   	total_blocks = wlcore_hw_calc_tx_blocks(wl, total_len, spare_blocks);
>>>   
>>>   	if (total_blocks <= wl->tx_blocks_available) {
>>> +		if (skb_headroom(skb) < (total_len - skb->len) &&
>>> +		    pskb_expand_head(skb, (total_len - skb->len), 0, GFP_ATOMIC)) {
>>> +			wl1271_free_tx_id(wl, id);
>>> +			return -EAGAIN;
>>> +		}
>>
>> An experimental AI code review agent provided the following feedback:
>>
>>   If pskb_expand_head() fails, the code returns -EAGAIN. However, in
>>   wlcore_tx_work_locked(), a return value of -EAGAIN from
>>   wl1271_prepare_tx_frame() is interpreted as the aggregation buffer being full.
>>   This causes the code to flush the buffer, put the skb back at the head of the
>>   queue, and immediately retry the same skb in a tight while loop.
>>
>>   Because wlcore_tx_work_locked() holds wl->mutex, and the retry happens
>>   immediately with GFP_ATOMIC, will this result in an infinite loop and a CPU
>>   soft lockup? Should this return -ENOMEM instead, so the packet is dropped and
>>   the loop terminates?
>>
>> I don't understand the code well enough to understand if the AI agent has a
>> point or not. Please take a look and let me know if this is a real problem.
> 
>  From my perspective, this makes sense. We have never seen any CPU soft
> lockup, but perhaps pskb_expand_head() never fails on our systems. ath12k
> also returns -ENOMEM when pskb_expand_head() fails.
> 
> Can you submit a patch?
> 

Sure.

Thanks,
Guenter


