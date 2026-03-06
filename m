Return-Path: <linux-wireless+bounces-32657-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHkGMjQ9q2n7bQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32657-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 21:46:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3443C2279E4
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 21:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06025304074A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1453B8BC8;
	Fri,  6 Mar 2026 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz1IUPkq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6535E942;
	Fri,  6 Mar 2026 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829956; cv=none; b=Cz+ii73aQps+qoN/RbR0D7heR1EA8zXslTtIzMb9aquCqNurCS2FkOEMGk9U+mRF78GBoVp7V4DUh7tgsDFDonGoxPxKzr6tmWDVLh81qDGQBoLfvoBxpIkp4HQEH/NGpvx93ydkkJ1L5744IxS60W5ct8/s+erbstI8vZHXXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829956; c=relaxed/simple;
	bh=kFk6ooamSnu9YFD2e++J1jgp+Er83/m+qGdJi8h8aQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6Apd1wUdXEs2fsIUKu4dfdATsZsXIoBuXZKTLcU5n42WoG+6fVUTH9U2+HscBtZFnQ+zhlI9LoSwBSgWJZSp6aDCwf5RsF9Z0Kivs8iCVuCaO7jpM1lrFtr/qen10HFuPLpaXhtUzyFVYcfynHBvRYbnCMwBtxRqHT9sg5y++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz1IUPkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9EAC4CEF7;
	Fri,  6 Mar 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772829956;
	bh=kFk6ooamSnu9YFD2e++J1jgp+Er83/m+qGdJi8h8aQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fz1IUPkqM2gsBXKVmY6omhX7GGc1eNUMo2ADuzHkbwE8GF1jVFtnBRdNObyEW04De
	 voyb5YjacRtVQuDFL8CAYt1qtWWDQr2M3VHQspME9wod4KoAckMNZssDhTszUVPx31
	 rSnkBnHHwFtTAMQLdh0H81G83MTaSC0m7wqJqXvTA+43yp83Uf4ViUy428q1vsX37y
	 vp8iMGJ6D5YfjfgiNwEV30hrm88+eLId/ZohVsu1XF5mSBhCy+in4EEIF9rfGMZCr8
	 EC0Z2pzo4qGi0FUK77egNqasPRDKgb15tRY/V0dDv6uamohXIIG424fO1CkkW5OXkj
	 BVG5/eiEW0v7Q==
Date: Fri, 6 Mar 2026 12:45:54 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-wireless@vger.kernel.org, 
	syzbot+feb9ce36a95341bb47a4@syzkaller.appspotmail.com
Subject: Re: [PATCH] wifi: mac80211: fix static key race condition in
 aql_enable_write()
Message-ID: <pqyce33vy6ypncoogcuhjy6v4tfksz532jxpaozdy2f5l4nb25@fahxv2v7y37h>
References: <890b1c1e0eec8f97426c1443745853250dc80737.1772827269.git.jpoimboe@kernel.org>
 <c1029770c99b9aa7e9603e666b6626197a5d1c9c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1029770c99b9aa7e9603e666b6626197a5d1c9c.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 3443C2279E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32657-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpoimboe@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,feb9ce36a95341bb47a4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:23:07PM +0100, Johannes Berg wrote:
> On Fri, 2026-03-06 at 12:01 -0800, Josh Poimboeuf wrote:
> > If multiple tasks are writing to the 'aql_enable' debugfs file, it may
> > incorrectly call static_branch_dec() for an already disabled static key,
> > resulting in the following warning:
> > 
> >   val == 0
> >   WARNING: kernel/jump_label.c:311 at __static_key_slow_dec_cpuslocked.part.0+0x107/0x120 kernel/jump_label.c:311, CPU#0: syz.1.3155/20288
> >   ...
> >   Call Trace:
> >    <TASK>
> >    __static_key_slow_dec_cpuslocked kernel/jump_label.c:297 [inline]
> >    __static_key_slow_dec kernel/jump_label.c:321 [inline]
> >    static_key_slow_dec+0x7c/0xc0 kernel/jump_label.c:336
> >    aql_enable_write+0x2b2/0x310 net/mac80211/debugfs.c:343
> >    short_proxy_write+0x133/0x1a0 fs/debugfs/file.c:383
> >    vfs_write+0x2aa/0x1070 fs/read_write.c:684
> >    ksys_pwrite64 fs/read_write.c:793 [inline]
> >    __do_sys_pwrite64 fs/read_write.c:801 [inline]
> >    __se_sys_pwrite64 fs/read_write.c:798 [inline]
> >    __x64_sys_pwrite64+0x1eb/0x250 fs/read_write.c:798
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Fix it by using the atomic static_branch_{enable,disable}() interfaces.
> 
> Heh, I just applied the same change:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=b94ae8e0d5fe1bdbbfdc3854ff6ce98f6876a828

Ha, and the code looks identical.  I approve ;-)

-- 
Josh

