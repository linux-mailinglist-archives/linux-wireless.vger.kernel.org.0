Return-Path: <linux-wireless+bounces-35012-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK4YNZ7N5WlIoAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35012-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 08:54:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DBC4277E2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 08:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92767300335C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C3C375ADD;
	Mon, 20 Apr 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QEbBgFtj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7BB40DFC4;
	Mon, 20 Apr 2026 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668058; cv=none; b=tADCKM/9qXgCwANu7AmOGHXpbMdbBTa5lxzEk7+sV+VGHGYTViEJ7Hiw+/MFgK+LVp/xc2rm26LUX6kVELEDVHXItsqXKkdESr8EuWl4SOeKKAjjcVSOAOVCCX7ywTFxer/Pl+xpgYbdNJrvlpUj2o4ghT0lSbSb4DLSbpp46GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668058; c=relaxed/simple;
	bh=pYZTz30yJWqQJ/UzTyih/hk0u4EqKH9OFebaScO655g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AKWK1qF/le88iUVdXszuH40Q3weBqI5vuDl+uFgGSzw7VA0aGoSIosZL2H7z7IZ2qvjVNh94X8AlaNXktf3p32QElC7z3iRN9MOXJWtMp7QXEjaBzVJOcXBzyfTznkRHn3YnHK6RShT93zwcxpK01NUv8bGWitL4Y+HL5N9s3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QEbBgFtj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/jYDSKee5ZmVogHWdAVV2dIkOR6ObD45aaDJCNijLJc=;
	t=1776668057; x=1777877657; b=QEbBgFtjVQfgODCfVgWuQvPNjAbMabkUfKqJM5R3Mz7hlcQ
	6VgdrlvxsIqpvVO4GFjjFndWCaX1Cuh2d9yTjYbi0WVqIerxmzx5iSYVcRuApZcvDMS6IfJiGJQ1g
	obfJG1wflBvVtQ2Rt3lHnTWYpHPjgISkuWT6ADI5Wcu62sTr1x7EtTTs2dohCdUMcTTloPNkyfBYS
	E/hyqWkuqs8UgcCay/r9SwIFhrlCj/pZOdXXDc3tCwd40m5G+0LyOb9ujzpZq19OBlFd8kWNcq0UJ
	47cKEfL2uQUWMhPvjJE+B8xAwRbaTsRCiMyYWjGnqehvHb7EdxF/vmbZCQt27zfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wEiWG-000000029QP-04p3;
	Mon, 20 Apr 2026 08:54:08 +0200
Message-ID: <f1b1c971acd5e3dfc9eae2b2dc5f9b6d0405efc9.camel@sipsolutions.net>
Subject: Re: [BUG] mac80211: lockdep warning from key debugfs creation
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg KH <gregkh@linuxfoundation.org>, Wxm-233 <lty2wxm@gmail.com>
Cc: linux-wireless@vger.kernel.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 08:54:07 +0200
In-Reply-To: <2026041944-dallying-unsettled-6e38@gregkh>
References: <20260417171253.662-1-2200013188@stu.pku.edu.cn>
	 <2026041944-dallying-unsettled-6e38@gregkh>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35012-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78DBC4277E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-04-19 at 08:48 +0200, Greg KH wrote:
> > The warning becomes possible because there is already an existing
> > dependency from relay_open_buf()/relay_create_buf_file(): that path
> > holds relay_channels_mutex and then enters the same debugfs/VFS
> > creation flow, which reaches the directory inode lock.

For the record, I have no idea what code path you're talking about here,
perhaps that's hidden away in some driver?

> > With both chains present, lockdep reports the cycle:
> >=20
> >   fs_reclaim -> relay_channels_mutex -> inode rwsem -> fs_reclaim
> >=20
> > This looks more like a real locking problem than a pure fuzzing
> > artifact. The trigger is a syzkaller-style key creation workload, but
> > the questionable part is that mac80211 performs non-essential debugfs
> > creation inside the locked key installation path.
> >=20
> > A possible fix direction would be to avoid creating per-key debugfs
> > entries while still in the locked add-key path, for example by
> > deferring the debugfs population until after the critical section or by
> > moving it to a safer asynchronous context.
> >=20
> > Relevant source locations in current trees are:
> >=20
> >   net/wireless/nl80211.c: nl80211_pre_doit(), nl80211_new_key()
> >   net/mac80211/key.c: ieee80211_key_link()
> >   net/mac80211/debugfs_key.c: ieee80211_debugfs_key_add()
> >   fs/namei.c: start_dirop()
> >=20
> > If useful, I can also send the full report/log pair.
>=20
> Why not send a fix for this so you get full credit for it?

Agree, that'd be nice, especially since you can actually reproduce and
therefore test it.

Note though that trying to fix this on the mac80211 side as you suggest
above ("A possible fix direction ...") is not going to work, you'll need
to address this on the other side (that relay thing.)

johannes

