Return-Path: <linux-wireless+bounces-37797-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vIpCKINbL2rw+wQAu9opvQ
	(envelope-from <linux-wireless+bounces-37797-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 03:55:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8520682CBD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 03:55:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=dMHrEQ8+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37797-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37797-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8475B3004F6E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 01:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03121A9FB0;
	Mon, 15 Jun 2026 01:55:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FD2CCC5;
	Mon, 15 Jun 2026 01:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488512; cv=none; b=kJXsUo82E9Udd5puaJjeh7/cENN2vRkLWQzeJt6AuTAA3cOPtFNz4Y/GS0S2szgLYhxje/KAeiLMuwudCCc76WfD551IbzPHZzUtSa2abCMDUulpxoKKSyRW6bP3rIhevSCTNxtiyrQEhvwtSJBUfYAmSCvx1k2Aa4rLS/TT3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488512; c=relaxed/simple;
	bh=pfYtKVRrgMH7lIX8B9Mg/Z677wGRoDxJcKMb61N2YKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKq38DztS8xVnPl8yD5vsRn+q27NajRjhTXLc85RxfhqlhtkzzveWLj4XwDwnTga3Au/SKdKw9EMHhrjUyQRvnQFevMsPv/rlhbjJKcZqUEUiTHbgBepRKTNkrL8ejJjX3iEXJY9X0YkSS4OsUoudbB1PGrxgV8MrgRk5p682E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dMHrEQ8+; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F1styyF401899, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781488495; bh=pfYtKVRrgMH7lIX8B9Mg/Z677wGRoDxJcKMb61N2YKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dMHrEQ8+cTW9/Sww/8fez3VfhddS+fFJR2eeLFLYbpoZmx/Sfe+Xq831UdlOwtsYy
	 8WfJljkAw3/DeJYUqHhVLKZwr8+DkOya9TIFMyVNhqb+/vgQ3tcWuuaTR9t/EH8Z0u
	 5s1HOBDqkjF9+KszqZTOwCuaENLEsETgqLGZxf5bYIG2Auif5SuOjlkS+zH5qMPfKh
	 uG0Y1m3XN1Q/ry76BZlIgtU6WPtDH4MDw3u2iGx5oGCDCIKlDGLkCvFhTWzFTe49bW
	 Uh+C8fNeG3P93QUUiVz5hMV5Jj2VPeOJWLTDcVOeRrqwE0cqyX6h73Ax4vuQUC/PxC
	 FSSAuus5jsLHg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F1styyF401899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 09:54:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 09:54:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 15 Jun 2026 09:54:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen Jung Ku
	<cjku@proton.me>
Subject: RE: [PATCH] wifi: realtek: rtw8822c: replace msleep() with fsleep()
 for DPK delays
Thread-Topic: [PATCH] wifi: realtek: rtw8822c: replace msleep() with fsleep()
 for DPK delays
Thread-Index: AQHc+1bXUI9lQ3CMLU216yjwQVY3JbY+x5IggAAVGvA=
Date: Mon, 15 Jun 2026 01:54:55 +0000
Message-ID: <8e0121a2437547dd812ded7f5ee4e4f7@realtek.com>
References: <20260613170434.23645-1-ku.loong@gapp.nthu.edu.tw>
 <5183c87219e2489eb99c9015cb96a7f8@realtek.com>
In-Reply-To: <5183c87219e2489eb99c9015cb96a7f8@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37797-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ku.loong@gapp.nthu.edu.tw,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cjku@proton.me,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8520682CBD

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Chen Jung Ku <ku.loong@gapp.nthu.edu.tw> wrote:
> > Replace msleep() with fsleep(), because msleep() may oversleep
> > to as much as 20 ms when used for a 10 ms delay.
> > According to the kernel documentation, fsleep() is more suitable
> > and aligns better with modern kernel style.
> >
> > Documentation link: https://docs.kernel.org/timers/delay_sleep_function=
s.html
> >
> > Signed-off-by: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
>=20
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>=20

Oops. The subject prefix should be "wifi: rtw88: ..."

I'll correct subject as below during getting merged:

wifi: rtw88: 8822c: replace msleep() with fsleep() for DPK delays



