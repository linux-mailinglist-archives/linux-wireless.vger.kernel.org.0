Return-Path: <linux-wireless+bounces-30245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9700FCEC83D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 21:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 013FA30141E7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939BA146D5A;
	Wed, 31 Dec 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="XHqRbTnV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85622301;
	Wed, 31 Dec 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767211222; cv=none; b=nh2/+hFX+oPYTKcr78hfoWf+BDF9eAFtP+1yHOUMu481Nzh709I2XVbCHnzcl6xQD4H2mqPN+38+ejKdPFi6pAqTFWuuVJTzuwcMRFUG6oU8T8vI3kqX61HUkZ516IQVcUypp3nOpSYvVO/Jwp7HdAVRd8lzy8YTcPkK06K30D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767211222; c=relaxed/simple;
	bh=t+6l7so7sibkki5dM8g/m2/ZIV75V3ajEdxPmz2NrFE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=H7FiNhmbQXi1hM8CshFaCECQFIs9fGaJo8bbrs6Givr4ac6b7CFS2A2C5k/wXXuj3Sg9Ne8dz9Wz10R+B29rWBcT/fv6uq2yGkhPIe+wW7IXBsQBlLXZClKHInFhNDfb3E5IMM4nGOEGOFVi0wEgoO2v37xhFAq2TjQn3lvKPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=XHqRbTnV; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E96DC340070;
	Wed, 31 Dec 2025 20:00:10 +0000 (UTC)
Received: from [192.168.101.118] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2CC9213C2B0;
	Wed, 31 Dec 2025 12:00:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2CC9213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1767211208;
	bh=t+6l7so7sibkki5dM8g/m2/ZIV75V3ajEdxPmz2NrFE=;
	h=Date:To:Cc:From:Subject:From;
	b=XHqRbTnV0EjHUsEkIQhyLeEU7d88WPxOBHDIoWMjPNLONIVVejz0/6lcjZ8M31knB
	 e07fuoFVJ1YDE0Neh+jXsb6SwbR7bBoxqUfgQiszOkEqaFz0qm6Q1gQToGEx81odLY
	 uQttlnd4Nn+Rgk0H22982flKUP38y4ucjVMT/8Cc=
Message-ID: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
Date: Wed, 31 Dec 2025 12:00:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, jjohnson@kernel.org
From: "Dylan E." <dylan.eskew@candelatech.com>
Subject: [BUG 6.18.2] Null Pointer Exception in Fair Scheduler
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1767211212-wYfDzLNO-fRu
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1767211212;wYfDzLNO-fRu;<dylan.eskew@candelatech.com>;6d78aa1bc4c2468e9f5ce884163e871b
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

When booting into the v6.18.2 tagged kernel from linux-stable, I get the 
following
stack trace while booting into the system every 1 in 5 boots or so, 
usually during
fsck or early systemd service initialization:

---
BUG: kernel NULL pointer dereference, address: 0000000000000051
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 0 UID: 0 PID: 15 Comm: rcu_preempt Not tainted 6.18.2 #2 PREEMPT(full)
Hardware name:  /SKYBAY, BIOS 5.12 06/27/2017
RIP: 0010:pick_task_fair+0x57/0x160
Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 
74 ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 
00 48 89 c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
RSP: 0000:ffffc900000d3cf8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000800
RDX: fffffc02295d3c00 RSI: 0000000000000800 RDI: 0000000002edc4f2
RBP: ffff888108f13000 R08: 0000000000000400 R09: 0000000000000002
R10: 0000000000000260 R11: ffff888108b74200 R12: ffff888265c2cd00
R13: 0000000000000000 R14: ffff888265c2cd80 R15: ffffffff827c6fa0
FS:  0000000000000000(0000) GS:ffff8882e2724000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000051 CR3: 00000001110a5003 CR4: 00000000003706f0
Call Trace:
  <TASK>
  pick_next_task_fair+0x1d/0x3d0
  __schedule+0x1ee/0x10c0
  ? lock_timer_base+0x6d/0x90
  ? rcu_gp_cleanup+0x560/0x560
  schedule+0x23/0xc0
  schedule_timeout+0x6e/0xe0
  ? hrtimers_cpu_dying+0x1b0/0x1b0
  rcu_gp_fqs_loop+0xfb/0x510
  rcu_gp_kthread+0xcd/0x160
  kthread+0xf5/0x1e0
  ? kthreads_online_cpu+0x100/0x100
  ? kthreads_online_cpu+0x100/0x100
  ret_from_fork+0x114/0x140
  ? kthreads_online_cpu+0x100/0x100
  ret_from_fork_asm+0x11/0x20
  </TASK>
Modules linked in: i915 drm_buddy intel_gtt drm_client_lib 
drm_display_helper drm_kms_helper igb cec dca rc_core i2c_algo_bit ttm 
agpgart e1000e serio_raw hwmon drm mei_wdt i2c_core intel_oc_wdt video wmi
CR2: 0000000000000051
---[ end trace 0000000000000000 ]---
RIP: 0010:pick_task_fair+0x57/0x160
Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 
74 ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 
00 48 89 c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
RSP: 0000:ffffc900000d3cf8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000800
RDX: fffffc02295d3c00 RSI: 0000000000000800 RDI: 0000000002edc4f2
RBP: ffff888108f13000 R08: 0000000000000400 R09: 0000000000000002
R10: 0000000000000260 R11: ffff888108b74200 R12: ffff888265c2cd00
R13: 0000000000000000 R14: ffff888265c2cd80 R15: ffffffff827c6fa0
FS:  0000000000000000(0000) GS:ffff8882e2724000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000051 CR3: 00000001110a5003 CR4: 00000000003706f0
Kernel panic - not syncing: Fatal exception
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 30 seconds..
---

I can't seem to reproduce this issue with the v6.18.1 tagged 
linux-stable build, and
after bisecting between v6.18.1 and v6.18.2, I land on this commit 
(which is clearly
not the problem):

d911fa97dab3ba026a8b96bb7f833d007b7fc4e1 | wifi: ath12k: fix VHT MCS 
assignment

I don't have any ath12k radios in my system, but I do have 1 ath9k and 2 
ath10k
radios. A little up the tree I see this patch which *could* be related, 
but I lack
the knowledge to know:

b1497ea246396962156b63d5c568a16d6e32de0b | wifi: ath10k: move recovery 
check logic into a new work

Let me know if there's any more info that's needed or additional steps I 
can take to
further diagnose the bug.

Hardware Info:
- 1x Ath9k, 2x Ath10k, 1x MT7916
- Intel Core i5-6500TE

-- Dylan


