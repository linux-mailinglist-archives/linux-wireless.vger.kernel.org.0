Return-Path: <linux-wireless+bounces-12482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38796BFB6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B7F289F64
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A061DB54A;
	Wed,  4 Sep 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSmvru+U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE61DB525;
	Wed,  4 Sep 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458962; cv=none; b=nt9BmPFBm5YapeZhT70L1rNy4XQjcHhaiOVRUQ6vjoagkSgAoIkfCktZZnFi+dsiXlvOWRhnsPUzzKHhkPwIKJfh6Lz4uOG1+hhbQfXTrAjfpu5hbFAUI2Xx5ydlOB72jakAugMTwzyVAJdtxKEs3181TUt2s31VJzu7bRl8y2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458962; c=relaxed/simple;
	bh=h2VCT5tluuwO2ETCzmGWn5KRPdTyjkms3lWwbziv/lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHxSzBEka/pQs1B2IYC/mXLVHCkrfDu3D4qf5QyzPmCT+c/VWvG8Zen902Tisqq9OM+YAwVfr10M8kXgZeCPJcfss29sShM4yZgSrejI+DukFAz9erUqz56O2AeOznCjhtD1TQ6K1enTMz/gkkvMqiC9ApFfhcjtK3lwuGLx62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSmvru+U; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c3603292abso18521996d6.1;
        Wed, 04 Sep 2024 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725458959; x=1726063759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBnNjREbFycHL4m/FJ4Jp/1aXtm04wBP4Y+JiUN5d3k=;
        b=kSmvru+Ut880fWmxFCqmm3SgUjmOqiuyuPGkNErJ/q+JEXcrEcrd9sofqDTPFT9Zfo
         vi2z/LH5yeXq6pEqLa6QWw4I0UUIskjcxoSwBaaQ1ONcjrrxt0YsnAiX8bOQ/LEfdm5p
         ELBhm+XLG2M54STToBVgu2/SlOT/OIu3Lw73NlbOx4GMdc230sdGgYJvgsHkNHLIZeGn
         dU2ymLH6EoHCspAEcnzU5ATwa66yTsf9y9DYWQ7Q2qjKK8iaB/QUfaE/UU0GyFHJrBVr
         KgZm6FUbF6bf3SKJOWQaYL6Z7Eq4vYZowOVYUREEE4HDKqPoJWedMlTCCKQ6pA30O4/g
         V93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458959; x=1726063759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBnNjREbFycHL4m/FJ4Jp/1aXtm04wBP4Y+JiUN5d3k=;
        b=ZQ72D3yybHXFBAjFsSyTjQjKsu8H9r8GkSDK1Xq9e+DV6yCsCH4dGISl+JBn6Cjnny
         N3Td4InhfFzKF7yk/crSC9Vjl2shtVDNSk1kRaTxIGli2DzXyf/ISfcH4CQT2KVwIiQK
         6hI2gadCIXvy9DSPm4wXUR051+rE2EoUmgemtkVrEfIBM3O5awld7cNI0QWCFJ2dGSco
         2epGbFM/pDgpxevJkf4XtobCbeUrQe9n39veQke/a8ssHXpg/fBtdufySmRKJH0VIBCm
         jFXiHSKg9R5e0ElL00f0lqt2by9YlBkeGO/mPZFjs/5dCgyQWWXS69qRaJxtxmqPtx0H
         114g==
X-Forwarded-Encrypted: i=1; AJvYcCVy9xOK9rsTyfMtMwdttICQHbVevSXkklcV7xnm5JqC3GBtn5MzbZKYCoQ6jCwaxYpXWYC1FcxkU7qGRuI=@vger.kernel.org, AJvYcCWxspFopgVasHayJHaWUvTTB0JROgwDkadMil0+lfRGBEs+sgD4fkQtlGmSlteul0SXCdVawWlN3yFehv1zjZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgonELXHyh750/0lgxR8URfxdbWnAt6GcUlokNYoI7W9rlh2U
	Vx/L5/6nt9xeX2oGSehWW0RJ2YXApOElEcwxGBj3KECr5bWyicpR
X-Google-Smtp-Source: AGHT+IG3CGvgAmLD0d29LbDLly51OTmvJujHY2V2VY29Luj12WBFXTdDaitxOnJu8gKy0sTPW0Bbrg==
X-Received: by 2002:a05:6214:5c0a:b0:6c3:7030:d28a with SMTP id 6a1803df08f44-6c3c9c17453mr60613026d6.43.1725458959098;
        Wed, 04 Sep 2024 07:09:19 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c35bd06de7sm41076296d6.17.2024.09.04.07.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:09:18 -0700 (PDT)
Message-ID: <8be8619d-f09f-43b2-ada8-2fca2a7d8ea5@gmail.com>
Date: Wed, 4 Sep 2024 07:09:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
 (ETIMEDOUT)
To: Paul Menzel <pmenzel@molgen.mpg.de>, Kalle Valo <kvalo@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
References: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

On 9/4/24 3:45 AM, Paul Menzel wrote:
> Dear Linux folks,
>
>
> Linux 6.11-rc6+ logged the warning below when resuming from ACPI S3 
> (or unloading and loading the `ath10k_core`/`ath10k_pci` modules) 
> having been connected to an AVM network:
>
>     wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware 
> (-110)
>
> Error code 110 is the value for ETIMEDOUT. I saw James patch [1], and 
> applied it, and the error is still there (as exepected).
My patch won't actually fix the timeout, I just lowered the time that 
ath10k would wait before it continued which fixed some incompatibility 
on the AP side of things. Based on your logs though, it appears you 
already got disconnected before the failure to remove the key...
>
> Can the warning be improved so the user know, which component is at 
> fault?
>
>
> Kind regards,
>
> Paul
>
>
> [1]: 
> https://lore.kernel.org/all/20240814164507.996303-1-prestwoj@gmail.com/
>
> ```
> Sep 04 07:21:38.469669 abreu kernel: Linux version 
> 6.11.0-rc6-00027-ga91d08fcc356 (build@bohemianrhapsody.molgen.mpg.de) 
> (gcc (Debian 14.2.0-4) 14.2.0, GNU ld (GNU Binutils for Debian) 
> 2.43.1) #294 SMP PREEMPT_DYNAMIC Tue Sep  3 23:01:18 CEST 2024
> Sep 04 07:21:38.469718 abreu kernel: Command line: 
> BOOT_IMAGE=/vmlinuz-6.11.0-rc6-00027-ga91d08fcc356 
> root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer 
> mem_sleep_default=deep log_buf_len=8M cryptomgr.notests
> […]
> Sep 04 12:34:55.826218 abreu sudo[25874]:  pmenzel : TTY=pts/7 ; 
> PWD=/home/pmenzel ; USER=root ; COMMAND=/usr/sbin/modprobe ath10k_pci
> Sep 04 12:34:55.828046 abreu sudo[25874]: pam_unix(sudo:session): 
> session opened for user root(uid=0) by pmenzel(uid=5272)
> Sep 04 12:34:55.869839 abreu kernel: ath10k_pci 0000:3a:00.0: pci irq 
> msi oper_irq_mode 2 irq_mode 0 reset_mode 0
> Sep 04 12:34:56.005202 abreu sudo[25874]: pam_unix(sudo:session): 
> session closed for user root
> Sep 04 12:34:56.161706 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 
> hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
> Sep 04 12:34:56.162591 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig 
> debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> Sep 04 12:34:56.163115 abreu kernel: ath10k_pci 0000:3a:00.0: firmware 
> ver WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 
> 0793bcf2
> Sep 04 12:34:56.241683 abreu kernel: ath10k_pci 0000:3a:00.0: 
> board_file api 2 bmi_id N/A crc32 d2863f91
> Sep 04 12:34:56.333784 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 
> 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> Sep 04 12:34:56.417649 abreu kernel: ath: EEPROM regdomain: 0x6c
> Sep 04 12:34:56.417919 abreu kernel: ath: EEPROM indicates we should 
> expect a direct regpair map
> Sep 04 12:34:56.418022 abreu kernel: ath: Country alpha2 being used: 00
> Sep 04 12:34:56.418114 abreu kernel: ath: Regpair used: 0x6c
> Sep 04 12:34:56.422440 abreu NetworkManager[610]: <info> 
> [1725446096.4223] device (wlan0): driver supports Access Point (AP) mode
> […]
> Sep 04 12:35:12.042484 abreu wpa_supplicant[618]: wlp58s0: WPA: Group 
> rekeying completed with ce:ce:1e:27:bb:e0 [GTK=CCMP]
> Sep 04 12:35:21.800998 abreu sudo[25953]:  pmenzel : TTY=pts/7 ; 
> PWD=/home/pmenzel ; USER=root ; COMMAND=/usr/sbin/modprobe -r ath10k_pci
> Sep 04 12:35:21.803733 abreu sudo[25953]: pam_unix(sudo:session): 
> session opened for user root(uid=0) by pmenzel(uid=5272)
> Sep 04 12:35:21.881668 abreu kernel: wlp58s0: deauthenticating from 
> ce:ce:1e:27:bb:e0 by local choice (Reason: 3=DEAUTH_LEAVING)
You get deauthenticated here, which then triggers the driver to remove 
the key...
> Sep 04 12:35:22.905717 abreu kernel: ath10k_pci 0000:3a:00.0: failed 
> to install key for vdev 0 peer ce:ce:1e:27:bb:e0: -110
> Sep 04 12:35:22.906604 abreu kernel: wlp58s0: failed to remove key (0, 
> ce:ce:1e:27:bb:e0) from hardware (-110)

And the removal fails. But afaict the removal failure was not the reason 
for the disconnect.

> Sep 04 12:35:22.908927 abreu wpa_supplicant[618]: wlp58s0: 
> CTRL-EVENT-DISCONNECTED bssid=ce:ce:1e:27:bb:e0 reason=3 
> locally_generated=1
> Sep 04 12:35:22.908995 abreu wpa_supplicant[618]: BSSID 
> ce:ce:1e:27:bb:e0 ignore list count incremented to 2, ignoring for 10 
> seconds
> ```

