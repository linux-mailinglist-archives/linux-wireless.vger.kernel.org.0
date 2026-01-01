Return-Path: <linux-wireless+bounces-30265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E76F7CECFF3
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 13:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C3D43004D3F
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE662BD5AD;
	Thu,  1 Jan 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KyPOajH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E0238178;
	Thu,  1 Jan 2026 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767269290; cv=none; b=g/dsXA+GSqODU4eDGoZyl0oLc2MoevfYb/t8ph2Jr59ADckdCd/eK193RLrH1zr8AfCHmmupk7t6xTq8DdDXbQdq5LGDX/6k9YRY8JBaAF7Vnbwosmzg3lYV8nv6gFk8eg94F+/5vh3RMamhqj0vB00IKhNY5SqnX6ja6J3Rjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767269290; c=relaxed/simple;
	bh=tsGSo2HrsFMCY95+pk823dqDu+F13XWvyAa5ILtk8mY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oB7hUnrN8Pn58OWTU1JHWq0BQYB+UmkHu4ysj/Aubtxjzzq6bR7PKTXLY6HS6SBUn50oM/+0fNmLgN7/0HmJOMhedBIA2hPIDWTyF+QzhRDBx4mgsrLWHQDeiBggZPVKqAIDJ2BJ60MYDiVnwzeyHIMPLJAlxmAehImft0CSFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KyPOajH5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vKPGkbZIKCZmwh5SXm3zhdSjGIVlD9aFSZwKeUbOzjw=;
	t=1767269288; x=1768478888; b=KyPOajH5flWHeBg9ubdEzFMfVOysbzfhQglhCJQM8Qb68HG
	ATeayvBNNTGTOn84EddTvwcHu7aFCvNy2hNX1EKQDKLfOVqbOQourv3UmTnYdO8WQcpb+DaATKubu
	IcDkGgAb+I+IYIOC5AuFJW7x7ZnFh0EfufQktvtN4VnqUIQImI8MpT6bupSI9gsQovB5EwxjNf+EV
	plVcIVVssTxsxpRJtUHepkVoVreAzDiiwohnAkp0AUSsM6WosDuKhBJPXtht0wwAi2toUo1D8sKD1
	FQCfDI1I9e+W4zkgX7E1AS2jj9FFcxu/QUJqofidjus63iCjyIyaXYns13wYXazQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vbHTD-00000000V0v-2KOc;
	Thu, 01 Jan 2026 13:07:59 +0100
Message-ID: <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING in rfkill_unregister
From: Johannes Berg <johannes@sipsolutions.net>
To: syzbot <syzbot+16210d09509730207241@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 01 Jan 2026 13:07:58 +0100
In-Reply-To: <6955cbd5.050a0220.a1b6.032d.GAE@google.com> (sfid-20260101_022031_682582_A65E16A5)
References: <6955cbd5.050a0220.a1b6.032d.GAE@google.com>
	 (sfid-20260101_022031_682582_A65E16A5)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> ------------[ cut here ]------------
> rtmutex deadlock detected
> WARNING: kernel/locking/rtmutex.c:1674 at rt_mutex_handle_deadlock+0x21/0=
xb0 kernel/locking/rtmutex.c:1674, CPU#0: syz.7.2908/15923
> Modules linked in:
> CPU: 0 UID: 0 PID: 15923 Comm: syz.7.2908 Not tainted syzkaller #0 PREEMP=
T_{RT,(full)}=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/25/2025
> RIP: 0010:rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:167=
4
> Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 8=
5 86 00 00 00 48 89 f7 e8 a6 39 01 00 48 8d 3d af 7c 0a 04 <67> 48 0f b9 3a=
 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 10 b3 91 4c
> RSP: 0018:ffffc90004617710 EFLAGS: 00010286
> RAX: 0000000080000000 RBX: ffffc900046177a0 RCX: 0000000000000000
> RDX: 0000000000000006 RSI: ffffffff8ce0bbf9 RDI: ffffffff8ede5760
> RBP: ffffc900046178c0 R08: ffffffff8edb3477 R09: 1ffffffff1db668e
> R10: dffffc0000000000 R11: fffffbfff1db668f R12: 1ffff920008c2ef0
> R13: ffffffff8ad3d599 R14: ffffffff8eb910e0 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888126cef000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056422df5abe0 CR3: 000000005929c000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
>  __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
>  rt_mutex_slowlock+0x666/0x6b0 kernel/locking/rtmutex.c:1800
>  __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
>  __mutex_lock_common kernel/locking/rtmutex_api.c:534 [inline]
>  mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:552
>  rfkill_unregister+0xd1/0x230 net/rfkill/core.c:1145
>  nfc_unregister_device+0x96/0x300 net/nfc/core.c:1167
>  virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:172

NFC has been issues with this for *years*. Technically, Krzysztof is
listed as a maintainer but I suspect that's mostly dead.

Is there a way you could route rfkill issues to NFC (and have them
ignored there) if NFC is involved?

Clearly they're not useful if nobody is interested in fixing NFC, so
maybe we should just disable the virtual NFC driver completely and just
not have syzbot run on anything there...

If this email doesn't wake anyone up, I'll do that on the next syzbot
rfkill vs. NFC report I get :)

johannes

