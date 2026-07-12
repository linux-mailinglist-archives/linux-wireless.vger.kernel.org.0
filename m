Return-Path: <linux-wireless+bounces-38910-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dsKXIf4QU2oKWgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38910-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:58:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A16743BAC
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:58:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=i0jUgSVY;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38910-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38910-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D8DC3014C21
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16612BE7D1;
	Sun, 12 Jul 2026 03:58:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477D846A;
	Sun, 12 Jul 2026 03:58:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783828731; cv=none; b=P2ZB/6MSIxMtK9+Sli1HHZ3KricehoWnRNN0tpc/cx2lOUbRBpvFsmrUAOJLCMc3tT4KO6VSPYyBouc8zdOmzB+l1x7kBFklpl2dK7iWyDCgc27P2pxbNrrSU3PjxWzbZIbsKkD+A7b0EvhjOzr+qxf0HlAvuxvc95qRtICpFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783828731; c=relaxed/simple;
	bh=C7cLHg44nm2J164DljAAU+Zlm3jBk4G5oPJIWsn7dL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arqKJo1npkn/S/fu8skaDr1uoOF/WM7gJyLHwMVWV4EQKrLb2Q0QsUJNPKVu5OsN1mDUduzG0sMPHZ7ovIyOKqDeWSSrrCBZ6G+/M52oA49kdNSNzp9tsmxeR0k7oHkv8UqwyIICJaTeZ6PbaEip59nRCZCt7+Zi/Haj3mVWjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i0jUgSVY; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C3wjErB538157, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783828725; bh=C7cLHg44nm2J164DljAAU+Zlm3jBk4G5oPJIWsn7dL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=i0jUgSVYDnD7AJ58HgF/kMLGHjMH+783lI3v/w2HWw9GrYh5QSe1xbiGLk6pPhqRC
	 bHUk7elZU85k0u0VNHoHvtR2ADzf5D2/l5xKarKMJYvahyvRwwKMHo/SDJKcSqyM1m
	 Zu2vXecW6I8Je9REtGWFuNF/ePt08+DJTRgZ1M2HeG9+AXi5nNZJFbmvLU+rY+i15U
	 nytheCsD22wRu+1qvJN+jfvD8Y/1ySIZxeM4l+2z+RzUlmp8bfcl+wXWzavs9hkNJ9
	 jyTGbkQ0+63eSn2xmeITCz+mAxqeViAfBf23fJXV1tlHGJ6EJA0/BiIK/WN21w+pX7
	 KmgCVxol8TYVA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C3wjErB538157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 Jul 2026 11:58:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:58:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Sun, 12 Jul 2026 11:58:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtlwifi: rtl8192d: remove dead SMPS rate mask code
Thread-Topic: [PATCH] rtlwifi: rtl8192d: remove dead SMPS rate mask code
Thread-Index: AQHdD9s/k7MDoSAv+UmUmPTHOO9/ULZpRWAw
Date: Sun, 12 Jul 2026 03:58:45 +0000
Message-ID: <f2e65bd2f1444a4eac4995b2a9cae7c7@realtek.com>
References: <20260709194315.157030-1-chelsyratnawat2001@gmail.com>
In-Reply-To: <20260709194315.157030-1-chelsyratnawat2001@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38910-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:chelsyratnawat2001@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2A16743BAC

Chelsy Ratnawat <chelsyratnawat2001@gmail.com> wrote:
> mimo_ps is initialized to IEEE80211_SMPS_OFF and never modified in
> rtl92d_update_hal_rate_table(). Therefore, the IEEE80211_SMPS_STATIC
> case is unreachable.
> Remove the unused mimo_ps variable and the dead branch.
>=20
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

I'd use "wifi: rtlwifi: ..." as prefix while merging this patch.


