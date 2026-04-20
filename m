Return-Path: <linux-wireless+bounces-35102-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLBxND6n5mlPzQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35102-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 00:22:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39181434948
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 00:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948F730063B9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 22:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E537B00C;
	Mon, 20 Apr 2026 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIS/HPWy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABE2147F9
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723771; cv=none; b=YheA7CaL2eE4jLfJNS4SkFv5Gk6RYSdNsYb3eGE+HEfMdIZXDWiIXVI5HUTohlNBQAVxu51f13raGZd2V592pgC84gNn5Sfm/ci+hqANqCKPMo1fYmxT1U3+grAjsHpWC7CTgtMizkmNYnLhPQGKYejTNk1hqBKJugoDl4Nl31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723771; c=relaxed/simple;
	bh=dkNLjZ4c12SM5WIoADdNPCJ4Kd0P3NDB3sBXyHDpOlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPf0zdILUS7WElCbG0d7ouJgrO8b76D316b5/oZyW6h+wRWt4Yz+zZJuvT4PZGxhpLywH0DWdCYHCp+KuBcV7/7f+iJ9FRiSKjl5sy1OJ0hwCBtJfNLe3/SQiXuJECwMK0EQeiPWcQ1ayS2/UQUOayrx/oXXu/vSf9QIbbgykD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIS/HPWy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so2844579f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776723769; x=1777328569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4Akk4PmaTtBaI+sRxEne0tr29GBnpho9tJgIDaaWHY=;
        b=IIS/HPWyT0KCQ9+7INsKHMgg+kcpD9wqG8M35+UCCFOmh7pAoTxrQDlmFvX9WAfF2U
         jphEUhjATzEXkpqD6kb/Xua7X3XIyR1tOjrZgb2aAxtPTbozVSzLSgD1JA9BdkqX+UFd
         ohAtuhEMCXlIjCKle6SkOdpbT6F3qQ+/pB+ntwSPIDT5m2mLay9mXkWemlwXTJRdTN3x
         FjiwFH2dhx08GKqwDjZo7y8Ne7K/+WgynSEBqrLGs0YP1GcvBvFcTQyoyXCwkeSxuGvz
         GquABnRbKpCwgITwXDiJM+SofooitNV+3RSAFXmQWgIdNdZzCcVvhEpT7+nCnvn/Q6Pk
         KX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776723769; x=1777328569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4Akk4PmaTtBaI+sRxEne0tr29GBnpho9tJgIDaaWHY=;
        b=N+Vs2tEJBozNUfcCTaFQlGbT5VZ5s0lw2oQAg2EZgbK/7wMolU6k4sCWY2wqjn68VG
         jeV1vlHx2JJt+LZibNBFYPioP6xn2FJgmyPz/VhAgNab4HyClu/t5WWN6gwDrAforAOD
         j+hEr5Jhq/BGvB5k33poKsXHvnDK8zKRuIVBFYTHnsAxxc/6HVa9j7gib2/5T1Aom8j1
         OB7dGYfDTvx/Pu+J5EScsPpoEEOiE21nZRayRZh5RwhqKFk6BbuUTEo7GXH+7bRVk0Z6
         43QBXBQhoM5eiq0QoWctD2/Bm7kTXsujV075GWLkjHoPQsDjrYyppIIkyZEANhYpxjdw
         rfTg==
X-Forwarded-Encrypted: i=1; AFNElJ/BNDjsqIJOI3Y2/8v662JFpSoVBX2P5OgEkgzYyEK4PaJ51sclITGNTM0Jxdv9TC/4xjtaqKnFISrrjez00g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/JK4RBSlf5JQVVwcYeRleHV05DIsP4EH7VmTkiWazb6mHr5X
	H1RhbfZ/U5pGpEpgK7l5UVkRYJzJpqnJJ3+P1lGrDYwx1YFhPcmFaE2r
X-Gm-Gg: AeBDiesz7ovCTzBcV7nk3pl4gmSOCDr/LesgZ6BFQLnWcqYxO5kySqhACUtsxws0040
	MP6OB7eRSIOCoEmYzvRWhHJfvVifGPpAyeRZ9QCPi9YYVOT7FJPiYFvtotl1uzLCmClQwSV9wGW
	UmfQsyky5OG9giGf6h+aABhh4DEz3C57ppJ+gdFUs4CwZJnkPRh2nXsNwacHXQBzn/Y276sQn7Y
	1hClqkGe3NMiEn1RZgAc4sp+uUx990+7anH2mcxyn2JvoI52CNu8ldKz34zcZyPg68ZpzW3m2Ke
	3V1U69KUOrMm8aVtDK4SqNm6wn4O5TEQY83RpgFlvP5ZSGXRt1PtJzwL7Rj+9MsKFiBeEzfnZIb
	DnoHkpdw5ruSIaqb15ABQNETQxobBvL8QBXnhe4BEoGpoTlYm2SdSmUvvL5fhihgqMUOKg216Qk
	OITsKQUqviOslyt96DGCV9iraagACoTAKCwPi2YrI/
X-Received: by 2002:a5d:5f47:0:b0:439:b55d:b0e5 with SMTP id ffacd0b85a97d-43fe3dfbfdfmr24155809f8f.28.1776723768378;
        Mon, 20 Apr 2026 15:22:48 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm33904395f8f.7.2026.04.20.15.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 15:22:47 -0700 (PDT)
Message-ID: <a5aaf34f-d2ec-40ef-a176-9a921dcf435e@gmail.com>
Date: Tue, 21 Apr 2026 01:22:46 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtw88: fix OOB read from firmware RX descriptor
 exceeding DMA buffer
To: Ping-Ke Shih <pkshih@realtek.com>, Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20260415222440.1545959-1-tristmd@gmail.com>
 <090b3c83-e3d5-4c8d-bd46-aaff692de529@gmail.com>
 <e4f18297feda4056bb461b6b2516b27c@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <e4f18297feda4056bb461b6b2516b27c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35102-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39181434948
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/04/2026 08:31, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> On 16/04/2026 01:24, Tristan Madani wrote:
>>> From: Tristan Madani <tristan@talencesecurity.com>
>>>
>>> In rtw_pci_rx_napi(), new_len is computed as the sum of pkt_len (14-bit
>>> descriptor field, max 16383) and pkt_offset (drv_info_sz + shift, both
>>> firmware-controlled). The result can exceed RTK_PCI_RX_BUF_SIZE (11478),
>>> causing an out-of-bounds read from the pre-allocated DMA buffer when
>>> skb_put_data copies new_len bytes. The USB transport already validates
>>> this (rtw_usb_rx_data_put checks against RTW_USB_MAX_RECVBUF_SZ); the
>>> PCIe path does not.
>>>
>>> Add a check that new_len does not exceed the DMA buffer size.
>>>
>>> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
>>> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
>>> ---
>>> Note: v2 resubmission -- original sent via Gmail had HTML rendering
>>> issues. This version uses git send-email for plain-text formatting.
>>>
>>> Changes in v2:
>>>   - v2: clarify field widths and maximum new_len derivation in commit
>>>     message, per Ping-Ke Shih's feedback.
>>>
>>> drivers/net/wireless/realtek/rtw88/pci.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
>>> index XXXXXXX..XXXXXXX 100644
>>> --- a/drivers/net/wireless/realtek/rtw88/pci.c
>>> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
>>> @@ -1078,6 +1078,11 @@ static int rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
>>>               new_len = pkt_stat.pkt_len + pkt_offset;
>>> +             if (new_len > RTK_PCI_RX_BUF_SIZE) {
> 
> Since this is data (hot) path, I'd prefer unlikely(new_len > RTK_PCI_RX_BUF_SIZE).
> 
>>> +                     rtw_dbg(rtwdev, RTW_DBG_RX,
>>> +                             "oversized RX packet: %u\n", new_len);
>>> +                     goto next_rp;
>>> +             }
>>>               new = dev_alloc_skb(new_len);
>>>               if (WARN_ONCE(!new, "rx routine starvation\n"))
>>>                       goto next_rp;
>>>
>>>
>>
>> I'm working on a patch which will implement the same validation
>> in rtw_rx_query_rx_desc(), along with two other checks. I got a
>> report about too short packets from RTL8814AU, so USB devices
>> can also benefit from checking pkt_len. It will make this patch
>> redundant.
> 
> Bitterblue, if you can take the change of this patch into your
> patch, I'd skip this patch. Please let me know your thought.
> 

No, I was mistaken. My patch doesn't do exactly the same thing as
this patch. It just checks if pkt_len is more than 11454. This
patch is also needed. Sorry for the noise.

>>
>> Well, kind of. Maybe RTK_PCI_RX_BUF_SIZE is too small? 11454 + 24
>> doesn't take into account the PHY info size.
> 
> In rtw_pci_sync_rx_desc_device(), driver does
>     buf_desc->buf_size = cpu_to_le16(RTK_PCI_RX_BUF_SIZE);
> 
> This is to tell hardware the size of RX DMA buffer. I think hardware
> can't DMA data over this size.
> 

Indeed, I don't think the hardware will write more than
RTK_PCI_RX_BUF_SIZE bytes. But I wonder if some bytes won't be lost
(or the entire packet?) if it ever receives a frame of 11454 bytes
and wants to attach a PHY status? Then it would need a buffer of
11454 + 24 + 32 bytes. I don't know if this ever happens.

> Ping-Ke
> 


