Return-Path: <linux-wireless+bounces-9122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3390B4A2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 17:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E27D1C22E92
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA414F9D8;
	Mon, 17 Jun 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0KHB6Ry"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395114E2FF;
	Mon, 17 Jun 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636951; cv=none; b=IHO4SkDePpmch+EI8oTGHe1YUc+axh8Z5YQBfS92Rpr8jru/UKN0zCZfm/j5eXxP7TSNVVK4fcdTl6Mzkqr6FZA1BvbP8RWjzIO5XgbU0yNB0XLQ69/hf3JlgUjTWpuyzW6Iqv+fNFLaEfMGoa/Q8OLVrVvchJkTfmNbiJja/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636951; c=relaxed/simple;
	bh=IT162UEg2/PWZivrlpF3xwi1skWmZOYgmUYGn5FNmVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3LmYWWisKg7LqsLnL72nvYPRM/QnxhAUNri5cE8DYXtH8LfVPO1ckbS+wPPTDKUC7FIJMbpdAfQk3a3bVuFUFiKnAtZCSRgKj0L1xZmgTktWG71753iMr4R3lZkIVpXYOoUal0HZ3aTMWChIRBOvNd1zi7gvly35xsRC3Y6gF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0KHB6Ry; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f47f07aceaso36410225ad.0;
        Mon, 17 Jun 2024 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718636949; x=1719241749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSfIk8K4XME6GZfBy3FFM+3s5/rKYnSusBreIG/t7cA=;
        b=e0KHB6RyIJlpmBKe3bjozvNuTO5gorhaFaEd+JN3Hnxag2+OUICNQUXq7gRjgbH8YX
         iFHcFaaJYCeQtcMtDKnsprdLbHFnwGd0M5BrX2mFv+kb3F7sP1fpqFqu0f+B6igtBOFv
         +Prhhvj5bulfEFSh9lL7FFsiuwaEoACdwQEAGOm1eyPJqRALX2xSXjcZGqu81bqM4EKF
         vj0FQjmbP+XcpANeaT7br6o1TYRke4MLKbqfUCKKYC2R8wxR8YZ89FQgMBHQq5Z3oStS
         l7R0LwE8qIfPJM4LIKsQZ3u4MTfa7W0CxgWgejJoqKqt6Inx+EpsqgZ4MJUyDh8t5L2T
         NDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718636949; x=1719241749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSfIk8K4XME6GZfBy3FFM+3s5/rKYnSusBreIG/t7cA=;
        b=LtxjCVZwMlI+F9tSeBqhMya16yE96G3ElOi4bh6lGWFRX5dFOissLgbcB1RjuKbfhC
         EcuO5aJL2gkje2iv6xmfP+VPmtZNmXqm7FbeLEN9CpXeacxLNIL/jdZfz70pnKLJxq6T
         aWOJm1CcHYVCHL3qIhDFtqnmcMvyAoMHdwzvHxvhIJsGxtG9z8Kk0EKcdjIcFOwYVI0c
         CytNaKNcruV1yW0ynX1yz4K4P6ZzhGyAoo5ZSp7yt0smtHSCf5ShmACMpbjygZ7IAich
         VZzQ+d7cR4UV39diPoHUrSxRQU2+k9FuuxwUIYmK9AnU03W03Ajg5nA7redZwKpvGbm5
         /Mzg==
X-Forwarded-Encrypted: i=1; AJvYcCVNoVocayMHEk1f31bp5osrNLZKTBv0Mou+O1ddaWkJurkaz0Cn0o+Pd7xotk4ISmJ6oPAoD4bge2Rc1x1VGHjHshczavNxzh+alRix
X-Gm-Message-State: AOJu0YzoNXTeTgGPciTRqtbm9TBnrFE/JCN4nAJYvEHlcqDDB3TOXOQY
	HsKaT6FJT2vnHv8Q4pdst6q0r8Ruj5D7jclcCGZ1g53Wf3oWA9if
X-Google-Smtp-Source: AGHT+IHaWapibFdK79vB3fJG4Nz96RSjPehaB6COG+NcELElXjUeNz89MPURVFDFdeqFx+o2JGWVzg==
X-Received: by 2002:a17:903:22c5:b0:1f7:e32f:f067 with SMTP id d9443c01a7336-1f862a1694emr104999715ad.50.1718636949159;
        Mon, 17 Jun 2024 08:09:09 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e56183sm80122435ad.28.2024.06.17.08.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 08:09:08 -0700 (PDT)
Message-ID: <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com>
Date: Mon, 17 Jun 2024 08:09:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
To: Paul Menzel <pmenzel@molgen.mpg.de>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

On 6/16/24 6:10 AM, Paul Menzel wrote:
> Dear Linux folks,
>
>
> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when 
> connecting to a public WiFi:
>
>     ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 
> 2 mcs 9

This has been reported/discussed [1]. It was hinted that there was a 
firmware fix for this, but none that I tried got rid of it. I got fed up 
enough with the logs filling up with this I patched our kernel to remove 
the warning. AFAICT it appears benign (?). Removing the warning was 
purely "cosmetic" so other devs stopped complaining about it :)

[1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.html

>
>
> Kind regards,
>
> Paul
>
>
> ```
> Jun 16 11:38:15 abreu kernel: Linux version 
> 6.10.0-rc3-00174-ga3e18a540541 (build@bohemianrhapsody.molgen.mpg.de) 
> (gcc (Debian 13.2.0-25) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) 
> #196 SMP PREEMPT_DYNAMIC Sun Jun 16 06:02:29 CEST 2024
> […]
> Jun 16 11:38:15 abreu kernel: DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 
> 2.21.0 06/02/2022
> […]
> Jun 16 11:38:33 abreu kernel: ath10k_pci 0000:3a:00.0: enabling device 
> (0000 -> 0002)
> Jun 16 11:38:33 abreu kernel: ath10k_pci 0000:3a:00.0: pci irq msi 
> oper_irq_mode 2 irq_mode 0 reset_mode 0
> Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 hw3.2 
> target 0x05030000 chip_id 0x00340aff sub 1a56:1535
> Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig debug 0 
> debugfs 0 tracing 0 dfs 0 testmode 0
> Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver 
> WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
> Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: board_file api 
> 2 bmi_id N/A crc32 d2863f91
> Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 3.87 
> wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> Jun 16 11:38:34 abreu kernel: ath: EEPROM regdomain: 0x6c
> Jun 16 11:38:34 abreu kernel: ath: EEPROM indicates we should expect a 
> direct regpair map
> Jun 16 11:38:34 abreu kernel: ath: Country alpha2 being used: 00
> Jun 16 11:38:34 abreu kernel: ath: Regpair used: 0x6c
> […]
> Jun 16 11:39:20 abreu kernel: wlp58s0: authenticate with 
> 70:18:a7:0e:f7:cb (local address=9c:b6:d0:d1:6a:b1)
> Jun 16 11:39:20 abreu kernel: wlp58s0: send auth to 70:18:a7:0e:f7:cb 
> (try 1/3)
> Jun 16 11:39:20 abreu kernel: wlp58s0: send auth to 70:18:a7:0e:f7:cb 
> (try 2/3)
> Jun 16 11:39:20 abreu kernel: wlp58s0: send auth to 70:18:a7:0e:f7:cb 
> (try 3/3)
> Jun 16 11:39:20 abreu kernel: wlp58s0: authentication with 
> 70:18:a7:0e:f7:cb timed out
> Jun 16 11:39:22 abreu kernel: wlp58s0: authenticate with 
> 4c:bc:48:39:16:ab (local address=9c:b6:d0:d1:6a:b1)
> Jun 16 11:39:22 abreu kernel: wlp58s0: send auth to 4c:bc:48:39:16:ab 
> (try 1/3)
> Jun 16 11:39:22 abreu kernel: wlp58s0: send auth to 4c:bc:48:39:16:ab 
> (try 2/3)
> Jun 16 11:39:22 abreu kernel: wlp58s0: send auth to 4c:bc:48:39:16:ab 
> (try 3/3)
> Jun 16 11:39:22 abreu kernel: wlp58s0: authentication with 
> 4c:bc:48:39:16:ab timed out
> Jun 16 11:39:24 abreu kernel: wlp58s0: authenticate with 
> 4c:bc:48:38:d8:4b (local address=9c:b6:d0:d1:6a:b1)
> Jun 16 11:39:24 abreu kernel: wlp58s0: send auth to 4c:bc:48:38:d8:4b 
> (try 1/3)
> Jun 16 11:39:24 abreu kernel: wlp58s0: authenticated
> Jun 16 11:39:24 abreu kernel: wlp58s0: associate with 
> 4c:bc:48:38:d8:4b (try 1/3)
> Jun 16 11:39:24 abreu kernel: wlp58s0: RX AssocResp from 
> 4c:bc:48:38:d8:4b (capab=0x1101 status=0 aid=30)
> Jun 16 11:39:24 abreu kernel: wlp58s0: associated
> Jun 16 11:39:24 abreu kernel: wlp58s0: Limiting TX power to 20 (23 - 
> 3) dBm as advertised by 4c:bc:48:38:d8:4b
> Jun 16 11:39:50 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:39:56 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:40:02 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:40:08 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:40:20 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:40:26 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:40:32 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:40:38 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:40:43 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:40:49 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:41:01 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:41:13 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:41:19 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
> params rate 1920 100kbps nss 2 mcs 9
> Jun 16 11:41:21 abreu kernel: wlp58s0: deauthenticating from 
> 4c:bc:48:38:d8:4b by local choice (Reason: 3=DEAUTH_LEAVING)
>

