Return-Path: <linux-wireless+bounces-34126-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGxeLg/HyWna2QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34126-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:42:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5635476B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2A63300515C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D221B4F1F;
	Mon, 30 Mar 2026 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HHhEKV2D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663E18871F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774831371; cv=none; b=EkJQyraU2TnEliBkgm4lgal/9OAe2B31Q85HaQKGTApiRVwkNqD/tPlLuvmc5BXqP3hLX9mUMbUvU8b6+4OLHa4eYFHpqx1rtpZ7Rtp2zmvYMvoK9J15rgZgwIIE7nVd8TatpmFjsKGb/IGYS8GzgfEDV7QLKZDGNq3QgRbuwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774831371; c=relaxed/simple;
	bh=EesRKqkRN7BR7ZaZszGM963dWtXwf222YZLsWkpOH80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9eHUzKq7VRaA9Yiy03hGxBJIjqvNj/EypkvdmcTuJuT8dN96gqI6cny+uQt2Blkja7sQF966FEsTTIROFa5M1gkvH00n7jhAkdly39jzv+LZh/LG1LdM+junId41fJrq/A+vr+DxamXhhFsyRDZMDsbfO2wfvu8yK9kjG8VXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HHhEKV2D; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U0gY3O14178087, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774831354; bh=61n/gfKScjShQFH+NVI4WNpdgz9oNpcU1sgz3qF4ORg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HHhEKV2D3pbyN8cmTvohYMDgEgMDwcivSDm3NF6x1GTRZEoZF2sXf5wvjPoS1eT2J
	 vinsMJY4sJBz9W7GZxlv0UgTR7RwJCMAwyazHvOfWCEy0/bX/E68Pg0SioWH3+QxL8
	 ok9OF2STwoiJcnp4CvSq8c4Pg+57Ksy1SXdGKP/jRtUI1RxxS/5VLtRFOPI7UeOF+O
	 Ip7F3IizfdxzHrLzXRMHFg5Phot1L/qdGkaWb2V0GMOzItk4A0OQU1o3gpoESvSb9p
	 rUp5BDBL2ofB+RU4ny2vx5EvXzBL33MEDp5Mfke5gLuCvYLEOYjgTDMwZ75wYzRA+E
	 BoGi7RO6sI1hQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U0gY3O14178087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:42:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 08:42:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 08:42:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "morrownr@gmail.com"
	<morrownr@gmail.com>
Subject: RE: [PATCH v4] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH v4] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcvry9Yiq3V1R+Y0SQc94MB5ta6rXGPOaggAAA47A=
Date: Mon, 30 Mar 2026 00:42:34 +0000
Message-ID: <9587a4a860d149f0932be459358085b5@realtek.com>
References: <20260323233347.158745-1-lucid_duck@justthetip.ca>
 <202603281411.62SEBByK43790225@rtits1.realtek.com.tw>
 <5c6bb05e4e684fa3adb56ad6e9cda98d@realtek.com>
In-Reply-To: <5c6bb05e4e684fa3adb56ad6e9cda98d@realtek.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34126-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:email,realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28E5635476B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johannes,

Ping-Ke Shih wrote:
>=20
> Lucid Duck <lucid_duck@justthetip.ca> wrote:
> >  usb.c | 20 ++++++++++++++++++--
> >  usb.h |  3 +++
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/usb.c b/usb.c
> > index eb489df..6f57788 100644
> > --- a/usb.c
> > +++ b/usb.c
>=20
> You must use kernel tree to send this patch as before.

Because of Lucid's mistake, patchwork assigns this patch to you, but
I think I can just assign back to me and change its state. Just a note.

Ping-Ke


