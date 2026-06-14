Return-Path: <linux-wireless+bounces-37792-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /JFnCFcsL2oQ8gQAu9opvQ
	(envelope-from <linux-wireless+bounces-37792-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 00:33:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D476C6826C4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 00:33:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PNZCR7lU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37792-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37792-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980B53007C82
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6282F691D;
	Sun, 14 Jun 2026 22:33:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193F2475CB;
	Sun, 14 Jun 2026 22:33:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781476413; cv=none; b=GYwRsGyI+6KR/3fsbM3x9ww39KWZrAvPNbjjrzPbIP2KkC3OzVuzyo/SJJN3yXKLmjycL7tDNQ5pePXMF4hFQL3TpzN5Oe4/w/xcRxc0X2g+dRoeClrPw+p651swB7RijNiDz3d90RqOtsZFIOAwp8iY/huWUXEuIXmtVVL6AmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781476413; c=relaxed/simple;
	bh=+zEHZDzJQtQKUninfL0hHh7G8Cm4+WJrtjMGTXgWkvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-ID:Date; b=ASxydaoF3Eh6joZ8GuNr6zp13W2JQdZqbqvMYPS+ZSGa1Szm/76QtsUpI8suTlwR1XrRQwj1jYbdhEX1JEyLCC9k92/UmDMrbaZ8FZ7ARGFaau296w6bc+JEYRnKrVqLF0ZBgv1Sa5U68bXIPr6VcqGuJiBLl4yK9rlGH419o2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNZCR7lU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792731F000E9;
	Sun, 14 Jun 2026 22:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781476412;
	bh=+zEHZDzJQtQKUninfL0hHh7G8Cm4+WJrtjMGTXgWkvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PNZCR7lUBZ7A85gTo+oVchsId1gl48v3CJZFjLEq1mBembB/UpVSjdsaRMKD5dvty
	 KReC9a/rYHS551IrHfGA8BX3A23fc/E6xOJGLm2hRsSG20XNO6oOrvvlANDw8Jo9c8
	 45QteygvAUh8Rhejf+RL1umHvB/+XSsWe0lCwOQLybU4AMup4PwIIJChWjGToHL8Vi
	 MlQIdoF1a3Hzg6+PkngHN4z6tlHS6eGWWZrB3EU2BaZo9bMBXQwDc6M6Ov9aqEhcAW
	 zFwNGJ3M5m3LdQ2xOcrfhLBhHhe0bnY+xd/qvMHygnDHaZykfbPYubrS2uczZ+Gp+4
	 2jG5RNWb/I58A==
From: Tejun Heo <tj@kernel.org>
To: wuyankun <wuyankun@uniontech.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: johan@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, sumanth.gavini@yahoo.com, syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] wifi: ath6kl: fix invalid workqueue flags in ath6kl_usb_create()
In-Reply-To: <20260611015545.111157-1-wuyankun@uniontech.com>
References: <075511fc-1136-4208-84d0-9214e761f8ba@I-love.SAKURA.ne.jp> <20260611015545.111157-1-wuyankun@uniontech.com>
Message-ID: <wq-applied-ath6kl-23b81fcab247@kernel.org>
Date: Sun, 14 Jun 2026 12:31:43 -1000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37792-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,yahoo.com,syzkaller.appspotmail.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:wuyankun@uniontech.com,m:penguin-kernel@I-love.SAKURA.ne.jp,m:jeff.johnson@oss.qualcomm.com,m:johan@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:sumanth.gavini@yahoo.com,m:syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,f80c62f371ba6a1e7d79];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D476C6826C4

Applied to wq/for-7.2, thanks.

Holler if there are any concerns.

--
tejun

