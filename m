Return-Path: <linux-wireless+bounces-36666-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCLsCDClDGq8jwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36666-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 20:00:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146C58361D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 20:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58853300FEF3
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD8342539;
	Tue, 19 May 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joV75TtB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC034250D
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213603; cv=none; b=F81HW+Mvs035XCTN1Rf3DR4++tgOn1Lsokl+riAJURgATyEvr5MUgHVm6FFGU18iBiJytaL5XH2nnXfp6e0P79+ZYyTEqTTXbgqvCvvYTyX6F8C8LhgKlqqsoHwgPicYtm+l7hCcDqu5RCbTmLY1bNdBftTlZWkS6WdWoLfkSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213603; c=relaxed/simple;
	bh=OfFMGEZo7z2ILYs9ZR95jqpeAiW5fv6NI+DHcFfwwnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oulelKR3aYPqUCjcQECsVHQeyNQDB8oG4ycmviUBBstZKk/hP3JX5MVRV41F2g8dU34icnINZcMBhfDrFZ2i99riKm89b4tQ+q+xYuw+XpnPt3g/lpy4R7lu+BR/536E6V07RIDroXE7KHefAaHSGHR7UM5wM/uaEnuFL+OSLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joV75TtB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so26009075e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 11:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779213601; x=1779818401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ks3vWbO1KycwHY7998GC/p7kD33/gTpMwGjqF2aluJI=;
        b=joV75TtBbRcTncI9Hy8LbEiTNtFjU3l0/mp1i4M7XJMzfj0qfpyg66MBpJPFp/1Ksz
         jG6LQhVBfciL2gwGKb3AB5zy2sA0fAn6PFirYy4362HEpS7hrZTfC8ylQQOlao0oGD4o
         zsMZt2ik3UvNJMhUYVZmaP+Lf0/8c+28N/tS1Ii8z3okRr/OmRTFgh6MYaG9RNSImfiD
         CWqfR/BORJRzvWJreLdlUnW213OddxvPBuB8NguEHBybdBlJADg8kwUh07C/lYswPipj
         pYsFN7ES8ojMxunGdi9aJUFsWg2MR9xlf8F5cK/uWdFAcypkvFHejGLHKUxiNF7Hh41z
         Fj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779213601; x=1779818401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks3vWbO1KycwHY7998GC/p7kD33/gTpMwGjqF2aluJI=;
        b=HZ7LOyXEi16nEX5gNhgrarxeAU5Q05vtwB608Tffpi7ywsnyYBu/8ZuYvvSt1von0q
         4oU3dIGvfOaAgb7W/SAw8q2fxy4M5t2ZSPoMHrCJj/Pp0a9Jcfs1A8hvf1nm0ZStYBJ9
         hvrhSJkjUskiU7cdG9tbmOwB6omerZR1e2zO/1fYy0jKjm6MO4rlZ/kJGsUICq5Fd2BO
         q191qogGoZsQaAGlwn4DlXIpz6gKvEB5WWqcxcSMXST8rvahBoShT//WGFkud6B4DSSF
         f7jrxZ5NvOx56YNFjwBHkr5BjxruemuAMKca1XX/BH9/QbBzeATvNoVS5va54CNGpu3n
         CE1w==
X-Forwarded-Encrypted: i=1; AFNElJ82iSKkYHN9NWz6mS5o70EjyIgOz5S7NfaxwQzllaZuq6EJejo6AMqxIGcspE5FaTfCaU9Tv+Ki8LYMMXPODw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0f3y4hYHUujy8skWmfU33TfbC555oA4ptIGNemjRiLcGKG8ZO
	b3RED306gGybUlQTAtEYV+fNn4tfhfx+7JJbIUNPd9dtwrhaP4dpaw0d
X-Gm-Gg: Acq92OHnCkZlgqI4EfvyQMDf1M2X0AA8Ht2gebF9h/k/qG5xl0iaS65veoO2kbconV/
	7/MivT9apXA9Sexggz5EAvUyGNwmfkow2QdIcT7E4k9yKOhuXmiROUvCQGV9+HWDxOpYXmx2Moy
	a9pF1YY5XlWnE+G8fR839NSQ8j+r2N6a/F7xTznQDSkmzU94VmDJtw1hxna9Vb6LnGqHcRo7ltQ
	Ei1+6G0Uwwii6rn12CyuODOlDi8LwoEkWanzORwwtBTfIdjSnlB1fPYdhq5R2NpQsE8Y1AbKtaT
	pRJt/ZdrrlZXN9ueML1TUxhpR2wuGhaVQDDJ7g3XPhoRO42zrXRopq6P5TwLuQUu7ssAxXZAeEv
	Jd67wncmoxLcLTL9rcNKNxWZbUi19yfQhCZCH3s3/dTp5pZuOJgMgS/PmhN7Dv2FTDvEIDMJrAd
	h2KHNxDBuC1qaA6m7OHz4pib45JzKoAXo=
X-Received: by 2002:a05:600c:4e13:b0:490:31e:d6fd with SMTP id 5b1f17b1804b1-490031ed899mr215824265e9.25.1779213600603;
        Tue, 19 May 2026 11:00:00 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab7c5sm364162665e9.12.2026.05.19.10.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 11:00:00 -0700 (PDT)
Message-ID: <cc24a412-40d7-4eb6-896e-0840ff0db067@gmail.com>
Date: Tue, 19 May 2026 20:59:57 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw88: Add more validation for the RX
 descriptor
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: LB F <goainwo@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Fiona Klute <fiona.klute@gmx.de>,
 "andrej.skvortzov@gmail.com" <andrej.skvortzov@gmail.com>,
 "anarsoul@gmail.com" <anarsoul@gmail.com>,
 Zhen XIN <zhen.xin@nokia-sbell.com>
References: <a237ba9e-9f05-451f-9dfc-9aa8b11b7bc4@gmail.com>
 <1d0efa51a4214ee8b65d7f3ff9d52097@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <1d0efa51a4214ee8b65d7f3ff9d52097@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36666-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,googlemail.com,gmx.de,nokia-sbell.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email]
X-Rspamd-Queue-Id: 7146C58361D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18/05/2026 11:14, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Some RTL8821CE cards can return frames with corrupted RX descriptor,
>> causing warnings and crashes if they are passed to the upper layers.
> 
> Not sure if this is the reason Larry uploaded a copy of vendor driver
> to his repository [1]. 
> 

He added it for someone whose wifi card sometimes wasn't powering on:

https://github.com/lwfinger/rtw88/issues/98#issuecomment-1263962943

> Recently, we received vulnerability report of rtw_mp_efuse_set() in
> vendor driver. I'd like to know if people are still using the vendor
> driver [1]. If not, is it possible to remove it? If people still need it,
> I will share the fix made by our internal later.
> 
> [1] https://github.com/lwfinger/rtw88/tree/master/alt_rtl8821ce
> 

We haven't been updating it for the kernel API changes, so I think we
can remove it.

>>
>> The PHY status size field is 4 bits wide, but in rtw88 its value should
>> only be 0 or 4. Checking this catches most of the corrupt frames.
>>
>> If a PHY status is present, the PHY status size should not be 0.
>>
>> The frame size should not be less than or equal to 4 and should not
>> exceed 11454.
>>
>> Discard the frame if any of these checks fail.
>>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221286
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
>> index d9e11343d498..65f6db3d7fcb 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rx.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rx.c
>> @@ -3,6 +3,7 @@
>>   */
>>
>>  #include "main.h"
>> +#include "mac.h"
>>  #include "rx.h"
>>  #include "ps.h"
>>  #include "debug.h"
>> @@ -261,9 +262,9 @@ static void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
>>         }
>>  }
>>
>> -void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
>> -                         struct rtw_rx_pkt_stat *pkt_stat,
>> -                         struct ieee80211_rx_status *rx_status)
>> +int rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
>> +                        struct rtw_rx_pkt_stat *pkt_stat,
>> +                        struct ieee80211_rx_status *rx_status)
>>  {
>>         u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
>>         struct rtw_rx_desc *rx_desc = rx_desc8;
>> @@ -303,12 +304,25 @@ void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
>>                 pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
> 
> Do you think if we should return -EINVAL for this case too?
> 

Yes. What do we do with the debug message? Should the other
conditions also have a debug message?

>>         }
>>
>> +       if (unlikely(pkt_stat->drv_info_sz &&
>> +                    pkt_stat->drv_info_sz != PHY_STATUS_SIZE))
>> +               return -EINVAL;
>> +
>> +       if (unlikely(pkt_stat->phy_status && !pkt_stat->drv_info_sz))
>> +               return -EINVAL;
>> +
>> +       if (unlikely(pkt_stat->pkt_len > IEEE80211_MAX_MPDU_LEN_VHT_11454))
>> +               return -EINVAL;
>> +
>>         /* drv_info_sz is in unit of 8-bytes */
>>         pkt_stat->drv_info_sz *= 8;
>>
>>         /* c2h cmd pkt's rx/phy status is not interested */
>>         if (pkt_stat->is_c2h)
>> -               return;
>> +               return 0;
>> +
>> +       if (unlikely(pkt_stat->pkt_len <= FCS_LEN))
>> +               return -EINVAL;
>>
>>         phy_status = rx_desc8 + desc_sz + pkt_stat->shift;
>>         hdr = phy_status + pkt_stat->drv_info_sz;
> 
> [...]
> 


