Return-Path: <linux-wireless+bounces-26543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB22B3023D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 20:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D338C566063
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366A335BAB;
	Thu, 21 Aug 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WQRbTMyV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790D343D62
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801868; cv=none; b=aUWu9/Qq54Zm0vPhdepwTzOZw8TV1MkSP5z/mfmC7S+NHm8yoqefYx/Mg66wAnGCqR2tOKFUeRQqxVxDm/RWj2/FkT6DTbTMtT7UWNWDcfvRr85GutUbVaxalrYuzt5DFPHQlcDNeqYR9GbAgyT2zfq7uYjFbpptN5X/y7tS6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801868; c=relaxed/simple;
	bh=KQ79PtgU+urHOW0anVaHifb3uHHkNRuVJRuMkIiem5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rt4pdNVUNeeAdFFGClSg71/43tRjPLu+2n/OrUdbgDrm9Z7C6yLyYXf5615o0xU1MrEIUZq4Rw8UkETv3psGFShrOIqvx0KrzI+1X2N9auUwSIhySeVMKb4vZJs8AdqNrNp0u3vfGhb/SNxm5Je88JZUwc/3g97uEko59+/LbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WQRbTMyV; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3e67e6a1cc8so7004375ab.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 11:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755801866; x=1756406666;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3Vdinbv+yzCiaF+6xaTYU4lTVi63vniwlAs0d8gpeI=;
        b=rd/AZmJxtpUzJD95+Gsavmmcso9utt3yPqzsSAfM3GkdVI2HXzm/TKOKbxw10rnsVa
         4ml+fAw5POgTUwMdHcGs52MZPzwLVS+Dld+G4s23UaA6t+9XMpGtyMtf8zDOQiYpY5No
         BhupidPzPOlXx1iA0Niy/vCgCSXZlw/MD6WQ0QXtmG/+7XOc/gNJgv/HSrTskGZAj8DD
         2GSoovVLn6Nyftn2bavfQwtdbbRRGq3xDZ1lnoiMpR1Vx6XrP/BCa0r8oaRZLUYmJPGz
         Ey94Uj+0Yph6gUBuYGSQbeY0L+Ih4/mcUMmLCOmuS+n3kmVxdS3uoasO/wtkaUC4bS3A
         uOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/NP2Trfe1HHT8wMdzpPgp6q6QBSpEPK0uoPxFReIP9MzgWDO+tSc6OmDx2upLJjVA83ubAZsHpsiHxOryyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1vDuhyc+mXO8p3D+eTlAMPuwrPO0vGT6dgZQne5YssVXuWnO
	kL7vM/ESM/MMuDpACT5Oebwb01pPqlMHs01OCpoDtRRmdPuQc85mq9yGv5AfkK24O3rqbzhUNS2
	RIwDQD/YDSn3MYD1j1oduuc9b2zgmfq8+OYJruH9rMXBF2gT6cByRb2GgoN5cPUXFqY8qk8Dmij
	bche5p5TirjhWnxuDz0NS37IuG1VsSpoAThiFonbe44GvWuix3zcFogzxZwbaDsgXOzNinPU2P0
	jiydrp2jO+1OHMgW27vkllpRmUY
X-Gm-Gg: ASbGncsXoG64BjH3ioLaCSWoOZJXxzOn7OCGXChMBXK35SFqVSdVSaytQmMgu1F7XZj
	LqafqG2DSEcWjAZYFM5pmDelBhvi5i9VfseJBxKtiCNt/SQvLxqB8G9DugpYmU9JYKIQiwbj36W
	PFPMcbyAf2I8oI+eSThj0Zc6EAJwDxPH1Z0iH38MsLlzd7HKuEVictbslJLg6ixLdk7q/bcz/YZ
	xMSdqlRHjk42XwECIopMlkEYLbt4atJslloflvjByM3/n5yuNBRMlniRpIjktNrfkyRymSO9+pg
	D2HY6BbcGPpBrPw38liUd8BO5HLY25rf74fG7fHdN4i5PEkrVJz1ZZLSmKrwu/Z306suIImE4NN
	o0i1mZ86Fld0VbaivhyvNikZa0jnKxzOzpguPqLPOJYpHDCCk6dgyXlNIxebhHN07uwcKs6iYxh
	zkTwf/PQ==
X-Google-Smtp-Source: AGHT+IFYrT8ZWbsMr4vrx+X4jBRpei23bV2wgIs8eeC+VOCVtK3vlb/TqEIMZKOHqpjua/R1zZAP4t51NLye
X-Received: by 2002:a05:6e02:1d89:b0:3e5:41a2:d71f with SMTP id e9e14a558f8ab-3e921a5c909mr7130295ab.14.1755801865397;
        Thu, 21 Aug 2025 11:44:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e57e63be71sm12935665ab.2.2025.08.21.11.44.24
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 11:44:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-61a748c7e36so1372768a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755801863; x=1756406663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h3Vdinbv+yzCiaF+6xaTYU4lTVi63vniwlAs0d8gpeI=;
        b=WQRbTMyVWLF7PGhw9fFzVkdcoCjZhlmqpexp9d6JiFneFh9nD49Zyt91xieDApXM/h
         vrhK0HvRrP37KqfgAsq0Yu2fAb2ZK8+fHT2t2pkUZBk7AlELXQK1c2AX0CX38IZnOfsw
         qg5+c0VuKhE9ACrzKhm8sIRSBeFYXzxBkM4Mg=
X-Forwarded-Encrypted: i=1; AJvYcCUG/KmBEMl7lROriD9lCTNOlcRzW8IKPC8dSKySFGvl4p9IMEDdoHF5M0CuiSJq7167ONNk6s2de4WpIx6fiw==@vger.kernel.org
X-Received: by 2002:a05:6402:40cd:b0:61a:2fc5:debc with SMTP id 4fb4d7f45d1cf-61c1b6e8a93mr97468a12.32.1755801863498;
        Thu, 21 Aug 2025 11:44:23 -0700 (PDT)
X-Received: by 2002:a05:6402:40cd:b0:61a:2fc5:debc with SMTP id 4fb4d7f45d1cf-61c1b6e8a93mr97444a12.32.1755801863068;
        Thu, 21 Aug 2025 11:44:23 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9b37sm5634601a12.7.2025.08.21.11.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 11:44:22 -0700 (PDT)
Message-ID: <d071faf8-e800-4169-a670-8971d57b6997@broadcom.com>
Date: Thu, 21 Aug 2025 20:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: btcoex: Fix use-after-free when rescheduling
 brcmf_btcoex_info work
To: Duoming Zhou <duoming@zju.edu.cn>, brcm80211@lists.linux.dev
Cc: brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
References: <20250821043202.21263-1-duoming@zju.edu.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250821043202.21263-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/21/2025 6:32 AM, Duoming Zhou wrote:
> The brcmf_btcoex_detach() only shuts down the btcoex timer, if the
> flag timer_on is false. However, the brcmf_btcoex_timerfunc(), which
> runs as timer handler, sets timer_on to false. This creates a critical
> race condition:
> 
> 1.If brcmf_btcoex_detach() is called while brcmf_btcoex_timerfunc()
> is executing, it may observe timer_on as false and skip the call to
> timer_shutdown_sync().
> 
> 2.The brcmf_btcoex_timerfunc() may then reschedule the brcmf_btcoex_info
> worker after the cancel_work_sync() has been executed.
> 
> 3.Subsequently, the brcmf_btcoex_info structure is freed.
> 
> 4.Finally, the rescheduled worker attempts to execute, leading to
> use-after-free bugs by accessing the freed brcmf_btcoex_info object.

Thanks for the patch. Being a nit picker just wanted to day that the 
use-after-free happens a bit earlier as the worker itself is contained 
in struct brcmf_btcoex_info. Also the diagram below does not add much 
more than the textual description above.

> The following diagram illustrates this sequence of events:
> 
> cpu0                            cpu1
> brcmf_btcoex_detach          |  brcmf_btcoex_timerfunc
>                               |    bt_local->timer_on = false;
>    if (cfg->btcoex->timer_on) |
>      ...                      |
>    cancel_work_sync();        |
>    ...                        |    schedule_work() //reschedule
>    kfree(cfg->btcoex);//free  |
>                               |    brcmf_btcoex_handler() //worker
>                               |    btci-> //use
> 
> To resolve this race condition, drop the conditional check and call
> timer_shutdown_sync() directly. It can deactivate the timer reliably,
> regardless of its current state. Once stopped, the timer_on state is
> then set to false.

However, no reason to stop this patch from going in so...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Fixes: 61730d4dfffc ("brcmfmac: support critical protocol API for DHCP")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

