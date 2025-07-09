Return-Path: <linux-wireless+bounces-25107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF39AFF1DB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 21:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDEB1700F2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A62242902;
	Wed,  9 Jul 2025 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VPx7eDQC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAE23717C
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089403; cv=none; b=C5+L78ymbw33Tor6sXyCgNbkMJiju41Db7c0GH35QuV/EDBnUbELIPS4JhdZiaZFhT9xNRVDg5dN22morGl/o92lSxTXertVUFl9w29j7qjhmyQ0lNT1Y9CK8Z/28/ZDEHCuHlaQi/HlTp48fOGY6AlckzTJXXwIt/bxX0AkRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089403; c=relaxed/simple;
	bh=XzzanGiSaPXnm3Zbc7SoewSZ+/rYTxlZgUK49mQoxlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gn3xuPnIgt2YxraWvBsnE+1loqaxEMPS3qKb5SSYXuD2p3Sb5OJKsByxfYopwMDOWfnCxDahepEM/QhI8jeiLZgCyUxYHDezKZwtBVPsrIBlz8asUR33cWoExFokGDHNtJjrEKl5oAPIS5+vm7llBVkedP+F5/tivbnXEld+krA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VPx7eDQC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7494999de5cso161736b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752089401; x=1752694201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=svX4y+7i2VeIrWCYvYRjRYUir6JNrmT3fa5A7V8x0Ts=;
        b=VPx7eDQCcoHUoDG5OJ4fQVkLCrZZK2z8sAwaeO1wJldbkm0SXu7yiPYR7CJojkSUdj
         ps46STf4NF2uIeGVLxF/fF6z+Olr1jxhWufp0R/FLJCs6w8UIXLFCc93Wdl4ucnpXX2a
         yHTXhLScnMi77i/tSfjPaNa4rFCo2pBCOU/EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089401; x=1752694201;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svX4y+7i2VeIrWCYvYRjRYUir6JNrmT3fa5A7V8x0Ts=;
        b=hfGdbIlb0uKb8GCdWbLDqhlM1ogPOGUsa06CKzAskGH3M755nD+hbBcO4+97cidorE
         suVoTAdBBM5RAvGsF6LGw1Y2b7S3uuTBzeY0wP/QEptsornXRaxalL902l/WFzDIywKn
         wEmR2mG+1VxzA2xBVzvv7Q6z8ddMH11ixn6w/s+7KcUHBYmgiy2CHRc9WkqE00rv5yNM
         kXWav9UJxjDNoIUbnxVZwGfHMlWr9c+o2YlgdZ/+DqEs0u3EtC9FmE3vDwLwqnXzvl/n
         COOMuqVrHpdXlDCyIzEYo3VCaIDznedodw6a1/wx3pmgBvGxE+//rgLdV9wUiHC3PTJK
         C5Mw==
X-Gm-Message-State: AOJu0YzPiJsOrXXZ9AmfgB+OE//pJahgMuWYzz87ZVq56xlVJ7jIId7v
	0rsMg4iuth6kW8kzq+8aLgm6C8HQcrcgXDWBcYFUP+gQ/Bm2KTA0UsSQ/yjAzbOKFQ==
X-Gm-Gg: ASbGnctWqRM4lknOMNG1MzzapgDjy7NZ1zG+UPdZV6XtXzPkGho6Z9tQc3ommp3HvUK
	eW/67Kdb4D4hxYcmBr/vCuL6P2UCC8BG16BzeMeoBJN8quzLvjDk/68TX/n2NllcLNzekwucOFH
	bUVWhQbDdLcCsbQKob0ITekdo8FBUDkLhDGOmdsNE7D58Hz4mqfGgRfNKYkNSVxdKlCyi1npPZh
	0Ezb7ywh0JGc/UwNKVm1KeDSf79MbTPgFHBWGNLc8veAV5Ea9/Ga0WKvKYHI9/lLE+EeJfZT773
	PGM+UZsD9oK4nvu62CDfQXZD7zc6pmG0ll6PumBzdF/3K/KcSdXA7Pmbzt/FIrDC/ePHYW33908
	kl9lKPF/t1ITPHMhU
X-Google-Smtp-Source: AGHT+IG8YaC3IjkknXWxnrbj2DCZK6FMFbSFRMyJsRs6jA1Ot2LgQWQUG4fErJ/SegZ0cAd/sTMVaw==
X-Received: by 2002:a05:6a21:339b:b0:220:1215:fea7 with SMTP id adf61e73a8af0-22cd5a0d9c9mr5950196637.9.1752089400794;
        Wed, 09 Jul 2025 12:30:00 -0700 (PDT)
Received: from [10.229.41.11] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450a61sm15046751a12.8.2025.07.09.12.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 12:30:00 -0700 (PDT)
Message-ID: <43232898-f652-4f73-abb7-45fb3002c5e4@broadcom.com>
Date: Wed, 9 Jul 2025 21:29:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Add support for the SDIO 43751 device
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-wireless@vger.kernel.org, mgonzalez@freebox.fr,
 Johannes Berg <johannes@sipsolutions.net>, brcm80211@lists.linux.dev,
 wlan-kernel-dev-list@infineon.com
References: <20250702040228.2452348-1-festevam@gmail.com>
 <aG6vptRgLtUeRz7n@ISCN5CG14747PP.infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <aG6vptRgLtUeRz7n@ISCN5CG14747PP.infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/2025 8:06 PM, Gokul Sivakumar wrote:
> We would suggest you to find who is the actual vendor for this WLAN chip and use
> the respective firmware vendor ID here.
> 
>>   	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
> Also we are not the vendor for the other chip 43752 which is already listed here
> with CYW firmware vendor ID. We will send a patch to remove 43752 from the list of
> Infineon/Cypress supported WLAN chips.

Probably both are Synaptics chipsets. Although the AP6398S(V) mentioned 
is a 43598 from Synaptics according the information from AMPAK [1]. 
Synaptics has not shown any interest in supporting their chipsets in 
linux upstream and I do not think that is likely to change. Indeed it 
seems incorrect to mark these as CYW. Probably WCC would be more 
appropriate, but I am not sure.

Regards,
Arend

[1] https://www.ampak.com.tw/product/WiFi-Bluetooth/Stamp-Type-2T2R/AP6398S

