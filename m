Return-Path: <linux-wireless+bounces-30247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB79CEC8C3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6277300ACCF
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139212D3226;
	Wed, 31 Dec 2025 21:00:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428A1C7012;
	Wed, 31 Dec 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767214804; cv=none; b=m3kX6/KQSXSrY2klIeJYsp4Ur1C2NmhjvIXn1RmfnmWMmusqFMhfGpGRPoEWg/OUrzQ8NkqTnDQiAcKzOi3gYu/EMgWwoCMSw29R5aGDWjm3tqpTF99dy4VqfzFVnNW6MJdAWb3UWLYotX5EBIjYWGXTxSb3mE0968h1w6sO0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767214804; c=relaxed/simple;
	bh=05il5/H64ucfD4ZVvaPxo+1OEQH5VOUt/8ASoK+VH5c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QT6SxLX4cr3pv8m27I1C9F7H8xFX756tgjS3QSLT9gjSdEXgRVGiSLQGnJnVACOSYv1lfL1YEndZlvK7Mdm8+DHn7LpCHFIKRze6DFOVj6PIlmds+7eM6r1BoaoSQKFrQlv9gecY0QR8/6HapGqmZKlAkj3t+x3xxpTC5C/oS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07ecd7.dip0.t-ipconnect.de [91.7.236.215])
	by mail.itouring.de (Postfix) with ESMTPSA id 2407FD20158;
	Wed, 31 Dec 2025 21:59:52 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id B7C366016E288;
	Wed, 31 Dec 2025 21:59:51 +0100 (CET)
Subject: Re: [BUG 6.18.2] Null Pointer Exception in Fair Scheduler
To: "Dylan E." <dylan.eskew@candelatech.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, jjohnson@kernel.org
References: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <39762dfb-d8bd-f1ab-b2f5-a44fa8139911@applied-asynchrony.com>
Date: Wed, 31 Dec 2025 21:59:51 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-12-31 21:00, Dylan E. wrote:
> Hello,
> 
> When booting into the v6.18.2 tagged kernel from linux-stable, I get the following
> stack trace while booting into the system every 1 in 5 boots or so, usually during
> fsck or early systemd service initialization:
> 
> ---
> BUG: kernel NULL pointer dereference, address: 0000000000000051
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 0 UID: 0 PID: 15 Comm: rcu_preempt Not tainted 6.18.2 #2 PREEMPT(full)
> Hardware name:  /SKYBAY, BIOS 5.12 06/27/2017
> RIP: 0010:pick_task_fair+0x57/0x160
> Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 74 ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 00 48 89 c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
> RSP: 0000:ffffc900000d3cf8 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000800
> RDX: fffffc02295d3c00 RSI: 0000000000000800 RDI: 0000000002edc4f2
> RBP: ffff888108f13000 R08: 0000000000000400 R09: 0000000000000002
> R10: 0000000000000260 R11: ffff888108b74200 R12: ffff888265c2cd00
> R13: 0000000000000000 R14: ffff888265c2cd80 R15: ffffffff827c6fa0
> FS:  0000000000000000(0000) GS:ffff8882e2724000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000051 CR3: 00000001110a5003 CR4: 00000000003706f0
> Call Trace:
>   <TASK>
>   pick_next_task_fair+0x1d/0x3d0
>   __schedule+0x1ee/0x10c0

Welcome to the club :) I already reported it and requested a fix in:
https://lore.kernel.org/stable/04b82346-c38a-08e2-49d5-d64981eb7dae@applied-asynchrony.com/

You can apply the patch from:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=127b90315ca07ccad2618db7ba950a63e3b32d22
which should fix it.

cheers
Holger

