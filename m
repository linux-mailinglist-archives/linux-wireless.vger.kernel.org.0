Return-Path: <linux-wireless+bounces-32656-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOs0JLY3q2mkbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32656-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 21:23:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE12227780
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 21:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E11D53013A62
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9123742F542;
	Fri,  6 Mar 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jiQaCMMX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70B4508F2;
	Fri,  6 Mar 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828593; cv=none; b=nbevM/n2UKMxy2wgwDphD/icQClwSWQWD5g4TiXr9ZenFjnSIz0z7uKH3mWidLHSto/4MviXBToOLfN9dBm1gP+42IQl1k/ycpvye5nyDRwvVk1Q+3fqVQmpCnVRHQUcMzy9+JVXUkb72CxqIZabHrPvza9YcrvIa/M5NQzrKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828593; c=relaxed/simple;
	bh=txDgOaP0odCqN6pFQBavXbVNtljV2IIsh6k8DZpH+Ro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qbxg4H7ll74JjIdq768aRSqyCUF5T67y6xgXAfMjL50GeJE+Bsc7Vj+ltugvFde6hYXmONwRtGPGywlG6iVcG96BSTW2SWOUP8KEshVkPYH24OKQLnsL2rPMX0dC23vpQ7Et4VhqiULUszFI0C9P7pFLodVexj/4kikkRTt6BmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jiQaCMMX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eQNnSVlJXdtN2tKZvPIOsYf7f9b5z/Pa3SKptpkQFQQ=;
	t=1772828592; x=1774038192; b=jiQaCMMXbQCjb5LZZIMBduIVzyI2JsgGJojs3R7N9BA/3fl
	15+T8zNtEgrDB61ZRONrkBqha7T18S4/BPrQL+6D/ED7EgRg+wpAXXW8cI6fHk10D0RiXwD4OUEgv
	yiCBRG8rGCCwZTbs8sE6YIOeCZSuekcG6Lwousmidogebxxw/6uCpRdq9Mv/8GaKxvkajBTBqvKS2
	vLqFaU+2ats9tx60MoZSiGKnwSU4o/Wja0/z//9uYuwUgI3LBbvp7qnSd+XuZaQHDU+qkRvPLM3Qc
	IAYmj6cuX4BSIVC6uvCZwGRqzcwcuOo2FMOElgghvH4idjREogHaU5Y44nekwOlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vybhU-0000000AKdY-10d2;
	Fri, 06 Mar 2026 21:23:08 +0100
Message-ID: <c1029770c99b9aa7e9603e666b6626197a5d1c9c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix static key race condition in
 aql_enable_write()
From: Johannes Berg <johannes@sipsolutions.net>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, linux-wireless@vger.kernel.org, 
	syzbot+feb9ce36a95341bb47a4@syzkaller.appspotmail.com
Date: Fri, 06 Mar 2026 21:23:07 +0100
In-Reply-To: <890b1c1e0eec8f97426c1443745853250dc80737.1772827269.git.jpoimboe@kernel.org>
References: 
	<890b1c1e0eec8f97426c1443745853250dc80737.1772827269.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: EEE12227780
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32656-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	TAGGED_RCPT(0.00)[linux-wireless,feb9ce36a95341bb47a4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Fri, 2026-03-06 at 12:01 -0800, Josh Poimboeuf wrote:
> If multiple tasks are writing to the 'aql_enable' debugfs file, it may
> incorrectly call static_branch_dec() for an already disabled static key,
> resulting in the following warning:
>=20
>   val =3D=3D 0
>   WARNING: kernel/jump_label.c:311 at __static_key_slow_dec_cpuslocked.pa=
rt.0+0x107/0x120 kernel/jump_label.c:311, CPU#0: syz.1.3155/20288
>   ...
>   Call Trace:
>    <TASK>
>    __static_key_slow_dec_cpuslocked kernel/jump_label.c:297 [inline]
>    __static_key_slow_dec kernel/jump_label.c:321 [inline]
>    static_key_slow_dec+0x7c/0xc0 kernel/jump_label.c:336
>    aql_enable_write+0x2b2/0x310 net/mac80211/debugfs.c:343
>    short_proxy_write+0x133/0x1a0 fs/debugfs/file.c:383
>    vfs_write+0x2aa/0x1070 fs/read_write.c:684
>    ksys_pwrite64 fs/read_write.c:793 [inline]
>    __do_sys_pwrite64 fs/read_write.c:801 [inline]
>    __se_sys_pwrite64 fs/read_write.c:798 [inline]
>    __x64_sys_pwrite64+0x1eb/0x250 fs/read_write.c:798
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Fix it by using the atomic static_branch_{enable,disable}() interfaces.

Heh, I just applied the same change:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3Db94ae8e0d5fe1bdbbfdc3854ff6ce98f6876a828

johannes

