Return-Path: <linux-wireless+bounces-30698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AEED11F81
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 11:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5825530B3A58
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E2329C77;
	Mon, 12 Jan 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acldigital.com header.i=@acldigital.com header.b="Pjih2eKs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB0264609
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214439; cv=none; b=ZTqqoSw23fz/EXKmOpM3jpEAnrBjzwipFMkTuUD1UN64GEEf1bxgkzf7BTZ+1nJVNoibgFPXaFI7lrO9EmsZX26UdqV3eo67TodveVyDzdw4MLZrrof6iIW5HLBxWCr2ACfG24UaSZQtGLi5VygTrBT3JpSioBxwON6Frkc2wKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214439; c=relaxed/simple;
	bh=kDEGxX1iqIANMlkQ46NirU6ZK8NPA15bfDGsEFXP1kI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=h6tO0szqCFJgLmrglHbI8lunA4J0jw+T5anlvxL9Taqxn19s1hl4pFowuOwPgD6MZBU8Jzu/IH36kEIETdVaYwDxoX6x1w3KsAwGCFlkOSRNsc4gy+9nj9+RvDEaTqnP8iidvSZ4ZvNGiPkIUqEACzMOVCS16osuv1Kc6ZlEo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acldigital.com; spf=pass smtp.mailfrom=acldigital.com; dkim=pass (2048-bit key) header.d=acldigital.com header.i=@acldigital.com header.b=Pjih2eKs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acldigital.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acldigital.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0a33d0585so39138115ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 02:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=acldigital.com; s=google; t=1768214437; x=1768819237; darn=vger.kernel.org;
        h=content-language:subject:from:to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DZpo2Z0ru/dJ5oRey7CdxR7JCtXwbsgsDv2h2jPolkQ=;
        b=Pjih2eKscAGFAx96jgsiQOp0RgQb69CNmiqLdt3+QKgjb+ufEgvZzlqmghVK36bsWi
         78OPSfo5JHezXuc3YqWTNG5zVXFNXt69ho26vPqj7QXkD1EkyGGsRUcXV41TPtC3O+U4
         N4IQGB0eXeIL8OY0sgb8RqdUW/QuzB646p4rywykJIt4tDbQ65IHERjkCg6vkGEnrX+i
         e+09FmfhaCAM/eewy7j9oOHeAwHfUgalAHU6gd1pZobfkL58hay2Rva++3nU3ULtQH6g
         SPt2pS3d4uW4GojLSQ9Au8IoFdWoYUyI9tCfY47mRuCb6GG52zHrP/Am2xQ8wj6SGPTJ
         7LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214437; x=1768819237;
        h=content-language:subject:from:to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZpo2Z0ru/dJ5oRey7CdxR7JCtXwbsgsDv2h2jPolkQ=;
        b=d4wwNoTKLx16+n4dRGpRsmZySgFjYH0ued2k4nMtnUNjjHUJ/NM/lUaHB6jLXwhiyV
         K8ZjifPzLjn+Sa6WjiCtOCDe1U7jK+dP0PEdz1OZ3Bw/jfmOBNkfJxHbYkjscaJB4OtS
         32Kuf+EGRCyR6XDVVaOx7Dr/0hRmspb0Aa4Ri4pSZ3Yo1Q6Z6QLA92rb1VBi6sZM4Itt
         6AjzNTebAFvSYT2jur4WLH37quT7htAdvLHp+utrP/3Y08cz4B/keO53IG5+yWSWvGsX
         eUShmowNqD47D4CiZQ/5juu8ZcV0B4gr8OH3DUWFd8f3MRiJzC5cOt8mCc9nkmzmjA45
         SvaQ==
X-Gm-Message-State: AOJu0YxgBlr3jWtuVUU7Ge5MMdtv8ah04e69reDrK59cGzAZUfBVF220
	QT2HsWgfVeMQu/shxaiPTrPz8WrdrtBpQXHjbo7Eaw4w3gkBSupvHsBQzqRkhgSGb5r2FLyi4pR
	5r856hjLgCL0rPkoFisX14OUjxThdnWXH04xorREH6yxJyH8ogmn7jy6D7DgLwfTwwqKC1E8uKY
	d9Fg==
X-Gm-Gg: AY/fxX4ZlfnQzOpQVFE6uAsUWZxhyX3T+db0smCNWDZyGgQI8N6EZgTIRBBsblN05i7
	TH1tMwn2SSBOhCkD2sPtl/um6UInVV0eiu2AF5vevrVk99i/pWuVYaylKSOBdOQpUgSVvIAz4cn
	e7P/iI12qwHdZ659l6Twgt3q9R6viVHM+M185pfpxuYez47B2Zwz3eve2FFENEOY2KxTWM6hqbZ
	FrG7YGzSrnvsbm9EY4mp5T3amHlLi3ECHYxydplvup8WIJrF1BJr/qq1LqJtAep2TfFprcVOVNM
	YtbIPXbk5FBD5yn6febs+nO35ESXc9fH2Fb2dIEMTAjSts86k3QmnEfuyZdd5KCiau/cSJuJmGY
	RTMm4pUOMyMECYYPmt2sIpAGYGUBy+0XGvS5HJFIJfhi/7HGAVokjqvQ9ETyCfo7C3y5vJAn0nE
	H2Ad3MSApKOT64Njuxw1iHlpydwWSzGHd5KGsSmwd7Bk9WyQ==
X-Google-Smtp-Source: AGHT+IE4hjvzxOSFe5sVX4lL+BAkGVgqsxgCwt2UdVR1t3j/rCusRDCPbWnwGX5s3aP0T+55ZMdBVQ==
X-Received: by 2002:a17:90b:1d12:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-34f68c4ff6amr15129893a91.11.1768214437197;
        Mon, 12 Jan 2026 02:40:37 -0800 (PST)
Received: from [172.29.125.222] ([202.131.99.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb7419csm17425069a91.13.2026.01.12.02.40.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 02:40:36 -0800 (PST)
Message-ID: <994b4e1c-df11-45d8-a4bf-7ed166388441@acldigital.com>
Date: Mon, 12 Jan 2026 16:10:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org
From: Naseemakhtar <naseemakhtar.shaikh@acldigital.com>
Subject: =?UTF-8?Q?Query=3A_Shutdown_/_Reset_ownership_for_Intel_AX200_=28iw?=
 =?UTF-8?Q?lwifi=29_=E2=80=93_Firmware_vs_Driver?=
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed

Hello Linux Wireless Community,

I am currently analyzing the shutdown, reset, and power-management 
behavior of the Intel Wi-Fi 6 AX200 (iwlwifi PCIe device) as part of a 
driver-level investigation.

During my analysis of the iwlwifi PCIe driver, I observed that for AX200 
and newer devices the apmg_not_supported configuration flag is set, 
which causes the driver to skip PRPH/APMG power control register access 
during shutdown or resume paths. From code inspection and debug logs, it 
appears that for these devices the firmware fully owns power management, 
and direct PRPH register read/write operations from the driver are 
intentionally avoided, as they may break firmware state.

Based on this understanding, I would like to confirm the following with 
the community:

1. Is the shutdown and reset functionality for Intel AX200 fully 
firmware-owned, meaning the device driver should not explicitly trigger 
power-down, reset, or PRPH/APMG-based power transitions?

2. Is there any supported mechanism for the driver to initiate a 
hardware reset or shutdown for AX200, or are these operations 
exclusively managed internally by firmware (including during runtime PM 
and system suspend)?

3. Are there any public documents, commit references, or design notes 
that clearly describe this ownership model for AX200 and newer Intel 
Wi-Fi devices?

My goal is to ensure that any driver changes strictly follow the 
intended design and do not interfere with firmware-managed power sequencing.

Thank you for your time and guidance. Any clarification or pointers to 
relevant documentation or commits would be greatly appreciated.

Regards,
Naseem Shaikh
M.6353852575
ACL Digital

-- 
This email and its contents are intended solely for the intended 
recipient(s) and may contain confidential or proprietary information of ACL 
Digital. Unauthorized use, disclosure, distribution, or copying is strictly 
prohibited. If you are not the intended recipient, please notify the sender 
immediately and delete this email.

