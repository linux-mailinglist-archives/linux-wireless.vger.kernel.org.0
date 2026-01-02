Return-Path: <linux-wireless+bounces-30291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B526FCEE82B
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 13:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5B4D3008561
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863A2E1743;
	Fri,  2 Jan 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pZMQqm9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4527466A;
	Fri,  2 Jan 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356587; cv=none; b=ktb1Z5rFBw/2sXAJIIKR36qzRiwq3OsaGwtJiGzEWJqeuk/NucmGeoP6W9wXVR0TOcwZnbMb90Kn8McviqHlQGI/zQuyXsEqvjQKfwhAqeGoFlT+8TW/iddmazq9zhbLVm73iAIorLElFxYpZIZvh3XP7XePnckOuHD3gERAMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356587; c=relaxed/simple;
	bh=pmqqJuh5Y5fXLBjeFNN71/uuNBNHJNd2F8ECVpYK/pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc+msuQlUv9qw4oYkquCB4nrkS0CceCU5bKy5liugEAz2A7yFB94i8DpXCh+kFzsHFOEcdmuVNWwE/cTnureiozUB72SJj7TpfTQ6CRsWXa8tbppn7ILGjx+eXPvfHSOV8+8lukUwQVATn20/U/L8AYt7m2TSwxv9G4J0zjRSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pZMQqm9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E61C116B1;
	Fri,  2 Jan 2026 12:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767356583;
	bh=pmqqJuh5Y5fXLBjeFNN71/uuNBNHJNd2F8ECVpYK/pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZMQqm9/6EZKu7919ODWJie7df9BcS1vDKtpu2tfmAfBzc351z35swqkErysN8+pt
	 TpwGLs4Xxk86JHVHGPnBiAsrA1/EvoNhAX/TR/burBzUV9UrLW+eUTmresyUfkHFcT
	 EFpGsGJ2PVbhLPhdMMCnwYfN1PK40N8UUZGqt6lc=
Date: Fri, 2 Jan 2026 13:23:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: "Dylan E." <dylan.eskew@candelatech.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	sashal@kernel.org, jjohnson@kernel.org
Subject: Re: [BUG 6.18.2] Null Pointer Exception in Fair Scheduler
Message-ID: <2026010252-pushchair-cornmeal-5c82@gregkh>
References: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
 <39762dfb-d8bd-f1ab-b2f5-a44fa8139911@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39762dfb-d8bd-f1ab-b2f5-a44fa8139911@applied-asynchrony.com>

On Wed, Dec 31, 2025 at 09:59:51PM +0100, Holger Hoffstätte wrote:
> On 2025-12-31 21:00, Dylan E. wrote:
> > Hello,
> > 
> > When booting into the v6.18.2 tagged kernel from linux-stable, I get the following
> > stack trace while booting into the system every 1 in 5 boots or so, usually during
> > fsck or early systemd service initialization:
> > 
> > ---
> > BUG: kernel NULL pointer dereference, address: 0000000000000051
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: Oops: 0000 [#1] SMP
> > CPU: 0 UID: 0 PID: 15 Comm: rcu_preempt Not tainted 6.18.2 #2 PREEMPT(full)
> > Hardware name:  /SKYBAY, BIOS 5.12 06/27/2017
> > RIP: 0010:pick_task_fair+0x57/0x160
> > Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 74 ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 00 48 89 c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
> > RSP: 0000:ffffc900000d3cf8 EFLAGS: 00010086
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000800
> > RDX: fffffc02295d3c00 RSI: 0000000000000800 RDI: 0000000002edc4f2
> > RBP: ffff888108f13000 R08: 0000000000000400 R09: 0000000000000002
> > R10: 0000000000000260 R11: ffff888108b74200 R12: ffff888265c2cd00
> > R13: 0000000000000000 R14: ffff888265c2cd80 R15: ffffffff827c6fa0
> > FS:  0000000000000000(0000) GS:ffff8882e2724000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000051 CR3: 00000001110a5003 CR4: 00000000003706f0
> > Call Trace:
> >   <TASK>
> >   pick_next_task_fair+0x1d/0x3d0
> >   __schedule+0x1ee/0x10c0
> 
> Welcome to the club :) I already reported it and requested a fix in:
> https://lore.kernel.org/stable/04b82346-c38a-08e2-49d5-d64981eb7dae@applied-asynchrony.com/
> 
> You can apply the patch from:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=127b90315ca07ccad2618db7ba950a63e3b32d22
> which should fix it.

Will be in the next 6.18.y release, thanks.

greg k-h

