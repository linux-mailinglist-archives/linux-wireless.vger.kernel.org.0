Return-Path: <linux-wireless+bounces-17322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363AA09121
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DA13A5275
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF36205E32;
	Fri, 10 Jan 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4AoAYdX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD76DF78
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513617; cv=none; b=ibYSiiXEkVS+87fhI86UJMi38lBG7a/jjgqhqErJbRE8l6FWunfEpBrWS1+GlTjmvB0EfM5eeOzFHCecS6DxV0UlHWWEmQslXCuyHVzJ61owVdZt+tjlG2R62vTFaqiYbFo/I1gY6OY1akTbEbFwi0Vvopc7qlX/tNBPsyvF62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513617; c=relaxed/simple;
	bh=2xp7vjGE/XSV6gNA79B/IMUwlt25Oi7rJT/wvK5k4a8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MGWve5gEjYRgxVZ79k4XWSAbI+nLfvqcetsvtxD2vphVauV2Ty0ZCj+Iy7VECf7A5uSzIauz+Fu9JOnYJ6Jp0Ham8lULZTp4EZk3g0ojhhZX9o1b90oOp1igX+fsRxfVDBApVxEZBGjvOTJuouuGrFU5uPm4BxNp5K4BXd8N4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4AoAYdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857D5C4CEE0;
	Fri, 10 Jan 2025 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736513617;
	bh=2xp7vjGE/XSV6gNA79B/IMUwlt25Oi7rJT/wvK5k4a8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=s4AoAYdXfTl0Dou4hk94+JoD64x9ZO5N1FhVhjDLCvezIWn2hJ0OK44SCT2+8j3JZ
	 Vd5kP/M0BASRkQ17tKCnZl7+jawfB/a+eVbipajlWB/O8DTWrkvpAoZl/iX7Ci3HXQ
	 jrltLsFSCUPFme59mW1bhI1ebqemnmod+BN1mz5S1YjOmumtyVKxGqqHZcupwQAva3
	 kZH9wdq9CIKiv7wocmqOnGmHDH1C2m5LN0uPdDsIx/OJiXAKFf0D/5GvSisVhrDs9x
	 00VBdwP+/Dagplc/1Uvl12MD1Nw2vIbtFk2/xJGqnK3wbYVoP2z6im/ZJRMJUYzZiP
	 ZAW+SoiOljg6g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v2] wifi: brcmfmac: Check the return value of
 of_property_read_string_index()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250106170958.3595-1-stefan@codeweavers.com>
References: <20250106170958.3595-1-stefan@codeweavers.com>
To: =?utf-8?q?Stefan_D=C3=B6singer?= <stefan@codeweavers.com>
Cc: linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173651361499.72755.4727780165240125407.kvalo@kernel.org>
Date: Fri, 10 Jan 2025 12:53:36 +0000 (UTC)

Stefan Dösinger <stefan@codeweavers.com> wrote:

> Somewhen between 6.10 and 6.11 the driver started to crash on my
> MacBookPro14,3. The property doesn't exist and 'tmp' remains
> uninitialized, so we pass a random pointer to devm_kstrdup().
> 
> The crash I am getting looks like this:
> 
> BUG: unable to handle page fault for address: 00007f033c669379
> PF: supervisor read access in kernel mode
> PF: error_code(0x0001) - permissions violation
> PGD 8000000101341067 P4D 8000000101341067 PUD 101340067 PMD 1013bb067 PTE 800000010aee9025
> Oops: Oops: 0001 [#1] SMP PTI
> CPU: 4 UID: 0 PID: 827 Comm: (udev-worker) Not tainted 6.11.8-gentoo #1
> Hardware name: Apple Inc. MacBookPro14,3/Mac-551B86E5744E2388, BIOS 529.140.2.0.0 06/23/2024
> RIP: 0010:strlen+0x4/0x30
> Code: f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <80> 3f 00 74 14 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 cc
> RSP: 0018:ffffb4aac0683ad8 EFLAGS: 00010202
> RAX: 00000000ffffffea RBX: 00007f033c669379 RCX: 0000000000000001
> RDX: 0000000000000cc0 RSI: 00007f033c669379 RDI: 00007f033c669379
> RBP: 00000000ffffffea R08: 0000000000000000 R09: 00000000c0ba916a
> R10: ffffffffffffffff R11: ffffffffb61ea260 R12: ffff91f7815b50c8
> R13: 0000000000000cc0 R14: ffff91fafefffe30 R15: ffffb4aac0683b30
> FS:  00007f033ccbe8c0(0000) GS:ffff91faeed00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f033c669379 CR3: 0000000107b1e004 CR4: 00000000003706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? __die+0x23/0x70
>  ? page_fault_oops+0x149/0x4c0
>  ? raw_spin_rq_lock_nested+0xe/0x20
>  ? sched_balance_newidle+0x22b/0x3c0
>  ? update_load_avg+0x78/0x770
>  ? exc_page_fault+0x6f/0x150
>  ? asm_exc_page_fault+0x26/0x30
>  ? __pfx_pci_conf1_write+0x10/0x10
>  ? strlen+0x4/0x30
>  devm_kstrdup+0x25/0x70
>  brcmf_of_probe+0x273/0x350 [brcmfmac]
> 
> Signed-off-by: Stefan Dösinger <stefan@codeweavers.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

082d9e263af8 wifi: brcmfmac: Check the return value of of_property_read_string_index()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250106170958.3595-1-stefan@codeweavers.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


