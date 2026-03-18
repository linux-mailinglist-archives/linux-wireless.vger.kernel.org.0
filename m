Return-Path: <linux-wireless+bounces-33379-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGdGICdcumnFUgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33379-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 09:02:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF042B76AA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 09:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D74D303AB49
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C93375AD6;
	Wed, 18 Mar 2026 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dCr9CAta"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C53750AE;
	Wed, 18 Mar 2026 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820837; cv=none; b=XvKL8x+mHji5MjJ1s4MiHhzZxxcyYK5fpsziFbW0pdRS2FuWLjtvfx0HKIEH1r3Dekh61k49/7IUO1f1BpTRx4MA9b9KMFvKl4JDazdcfAtamycTJIbRBSHTXflMjGDBPgXAUkpKqQCxLtqlBmaXaPtjyX56EKFKOxoNL7yZ6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820837; c=relaxed/simple;
	bh=NFh1/dS2yY1V5/j/8/hnXWN2hIvOcY9YkdUK+OouIP8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7N2NCsu+0XDvOCGnjPuNTcKwzp7pd5b2U7XXffBWQ39CB4KuZkdmgMBTYX7kvJ4PzObrvFPARDYnST9RWy5oXMGOtQ+tZhNrZtFmDt3OjZ1VF9CogCTSFjpJ8oHyBup1o2aIn27WIGSdy4r5jZNI8smzxx7A5OoKy6MV+Ifx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dCr9CAta; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hixFf7wKq0QLhS/T/VMdwyyyYGbw1xeEU0sU2ZelLU4=;
	t=1773820835; x=1775030435; b=dCr9CAtafbV/QypXAZLI8gJSBASFtHFqgOO4oghmm3V+j+b
	CuQHbSqvex4YD7BFXuKBVKSdupoIIrW1HVPxuKVce5Bk5eUE9g4fRJ81CA9dYQL4EXn/VQBhHrQs3
	EnX30ufDVDaXPioQ1+ZN2euT93KYzKIaGwthNpYe/ma0jah23uYGHdLoDwiVVtmJg/DxPUwo5JyO/
	3W5KyhcLihG4wS4BFUgBSBAltlDEj0fqqLRAVTLbznyYgVvmrE5ATFM0p3+ITOoVABeAKRJOzSrn5
	0SiNAUd1qNorLm1aNGZfWD6/x4gGGZnFAwLhuQCq3IEbRpXtd7MJrj1asX2PlQzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w2lpQ-00000004GGr-2qkK;
	Wed, 18 Mar 2026 09:00:32 +0100
Message-ID: <d30024f1a2ae07944714a1eaaa056c55bdc774b2.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING in cfg80211_chandef_create
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, syzbot
	 <syzbot+d9f5fabbbcf4b377d01f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Wed, 18 Mar 2026 09:00:31 +0100
In-Reply-To: <tffrshs5h76cfj3k6lelrx6lmm7qtc7hww7r554xtnhfnsw2ip@dqktqrq2k47q> (sfid-20260318_015325_570672_B8B037B9)
References: <69b992c2.050a0220.248e02.0132.GAE@google.com>
	 <tffrshs5h76cfj3k6lelrx6lmm7qtc7hww7r554xtnhfnsw2ip@dqktqrq2k47q>
	 (sfid-20260318_015325_570672_B8B037B9)
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33379-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,d9f5fabbbcf4b377d01f];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: CCF042B76AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-18 at 11:53 +1100, Lachlan Hodges wrote:
> > HEAD commit:    b84a0ebe421c Add linux-next specific files for 20260313
>=20
> I think this didn't have your fix already?

Indeed, looks like that tree got cut between your and my commits, even
though they less than eight hours apart :)

johannes

