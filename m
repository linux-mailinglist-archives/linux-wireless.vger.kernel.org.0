Return-Path: <linux-wireless+bounces-30413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467FCFA5EE
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 19:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E77C730402B3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40B921773D;
	Tue,  6 Jan 2026 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Waaw//hG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F12367AC;
	Tue,  6 Jan 2026 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725822; cv=none; b=vB/1g5fDKNOBoIHgZyXAWIxo1dS02BKyvlwl8kigsL+RZh4bPK4aMS09BMObXhlfksyM7q43+YcYvEAJQwT8zt+DaHoOp4F0k/iRklag3NiQMCd/35MeYBK6r3i0z5gOxvXCRljlcmJbmgk/2n/OQdnwDELQinkCrOyGtQUVikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725822; c=relaxed/simple;
	bh=meJWznmpisb4Z0tj5/BsgVG4zJyBnjMbDiLi5lcu3Rc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HhgMgBsjR7xVYVTPvOUxzam5JdqKYvt3jEoji3efECMzZk38G2Ie2atkRhmuymS2Z8s8RcMQ/8F8SGKX+LUdePN6r6XOfmuRPq0//dtJ5HrPh/zwo59Vx/X7rF1/OMCfMXbZwJ7HT/lhAhTHxqYf3cVl5de6t8NReUJzj3cxxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Waaw//hG; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2E321AC00E2;
	Tue,  6 Jan 2026 18:56:52 +0000 (UTC)
Received: from [192.168.101.118] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8479913C2B0;
	Tue,  6 Jan 2026 10:56:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8479913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1767725809;
	bh=meJWznmpisb4Z0tj5/BsgVG4zJyBnjMbDiLi5lcu3Rc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Waaw//hG/TyF6p7ucTuzVCWt0sB/c1bBOwzvPvXFFaqrOWX5OaI4iUxgMTnIK0tjT
	 HSGT+l6t6n0WB5adf8kstK/WRwC4VBeXY+Le+U3dC4YDWOJObQFAEm3aL59WmsTFwQ
	 IlZf5Zsqj1dZKpg3hFdSCWHoCHuNwi3fGnbwqJtM=
Message-ID: <e5cba37b-2bb5-46fb-b414-5cc6b2e894cf@candelatech.com>
Date: Tue, 6 Jan 2026 10:56:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG 6.18.2] Null Pointer Exception in Fair Scheduler
From: "Dylan E." <dylan.eskew@candelatech.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, jjohnson@kernel.org
References: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
Content-Language: en-US
In-Reply-To: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1767725813-gyDGdEY0fzPW
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1767725813;gyDGdEY0fzPW;<dylan.eskew@candelatech.com>;6d78aa1bc4c2468e9f5ce884163e871b
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello again,

On 6.18.3, I'm still seeing the scheduler NPE pop-up, though this one 
happened at shutdown. Looks to be an identical location to the previous 
stack trace.

---
BUG: kernel NULL pointer dereference, address: 0000000000000051
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 0 UID: 0 PID: 336 Comm: (udev-worker) Not tainted 6.18.3 #39 
PREEMPT(full)
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
RIP: 0010:pick_task_fair+0x57/0x160
Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 
74 ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 
00 48 89 c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
RSP: 0018:ffffc9000091bca0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000c00
RDX: fffffa1b1b2acc00 RSI: 0000000000001000 RDI: 0000000000000400
RBP: ffff8881255ef000 R08: 0000000000000400 R09: 0000000000000002
R10: 00000000000003ae R11: ffff88812d2cc200 R12: ffff88845dc2cd00
R13: 0000000000000000 R14: ffff88845dc2cd80 R15: ffffffff827c71e0
FS:  00007fed68640980(0000) GS:ffff8884da723000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000051 CR3: 00000001244dd006 CR4: 00000000003706f0
Call Trace:
  <TASK>
  pick_next_task_fair+0x1d/0x3d0
  __schedule+0x1ee/0x10c0
  ? sock_def_readable+0x3e/0xb0
  ? sock_poll+0x4d/0xd0
  schedule+0x23/0xc0
  schedule_hrtimeout_range_clock+0xf4/0x100
  do_epoll_wait+0x481/0x4b0
  ? ep_destroy_wakeup_source+0x20/0x20
  __x64_sys_epoll_wait+0x5a/0xf0
  ? syscall_trace_enter+0x8d/0x1a0
  do_syscall_64+0x50/0x3a0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7fed69033ea7
Code: 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb be 0f 1f 44 00 00 f3 0f 1e 
fa 80 3d c5 a4 0c 00 00 41 89 ca 74 10 b8 e8 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 51 c3 55 48 89 e5 48 83 ec 20 89 55 f8 48 89
RSP: 002b:00007ffd7c3b5508 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fed69033ea7
RDX: 0000000000000006 RSI: 0000558994c733e0 RDI: 0000000000000003
RBP: 00007ffd7c3b5620 R08: 0000558994c42010 R09: 0000000000000003
R10: 00000000ffffffff R11: 0000000000000202 R12: 0000558994c733e0
R13: 0000000000000002 R14: 0000558994c73060 R15: ffffffffffffffff
  </TASK>
Modules linked in: i915 drm_buddy intel_gtt drm_client_lib 
drm_display_helper drm_kms_helper cec rc_core ttm agpgart ixgbe igb mdio 
i2c_algo_bit libie_fwlog drm dca hwmon intel_oc_wdt i2c_core mei_wdt 
video wmi
CR2: 0000000000000051
---[ end trace 0000000000000000 ]---
RIP: 0010:pick_task_fair+0x57/0x160
Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 
74 ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 
00 48 89 c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
RSP: 0018:ffffc9000091bca0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000c00
RDX: fffffa1b1b2acc00 RSI: 0000000000001000 RDI: 0000000000000400
RBP: ffff8881255ef000 R08: 0000000000000400 R09: 0000000000000002
R10: 00000000000003ae R11: ffff88812d2cc200 R12: ffff88845dc2cd00
R13: 0000000000000000 R14: ffff88845dc2cd80 R15: ffffffff827c71e0
FS:  00007fed68640980(0000) GS:ffff8884da723000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000051 CR3: 00000001244dd006 CR4: 00000000003706f0
Kernel panic - not syncing: Fatal exception
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 30 seconds..
---

Let me know if I can provide anymore information!

-- Dylan


