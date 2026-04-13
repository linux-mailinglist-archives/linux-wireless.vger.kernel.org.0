Return-Path: <linux-wireless+bounces-34682-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KkZIZuF3GleSQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34682-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 07:56:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7513E79A1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 07:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70EF03006951
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADD7382286;
	Mon, 13 Apr 2026 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GyXPFs6W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32983806B5
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059799; cv=none; b=LT+EmwtpAQejc2863EsPmnhJn6WxymqFOncGGCukOwHvKmngeXdRBxq3/w8KB+OP1dbvWdgOdji52iyACBF8w4qi8Yef4yXLFCkXrXbDl3W3Qjq0qglZJ5J4Q87SaUB4rlQZcSiqRr6eqzop5jh9LOwYXwibYDbswLWjm8L9vkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059799; c=relaxed/simple;
	bh=bNnrnUhMF6GJlvM4ilhd7gA1kL3sqNq1o++DY5Ig9N4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JRBZQi1HhqGds09Fmv0TNHknTuqB8F5SVrdIMzVtC1ND2jXiTP7OD/fr9wkEcJ/L41i74S8sCPkRj8vcg+XWPbOFrLJ88O9mgopoKp0XeQVKGuaQzwmrR51PGLJhQmhVp/9MAybk35tCVHwBMiYBSFFhx9+kq6Ml2vHjQSX8+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GyXPFs6W; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63D5uHg553727833, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776059777; bh=bNnrnUhMF6GJlvM4ilhd7gA1kL3sqNq1o++DY5Ig9N4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GyXPFs6Wz/JUT1kFMhrl1HZsAfch8ooGDKb/LtGdh+y7faNrLQKYStDBGszm74dHC
	 GNzO3Nv3iU+x00iwV0WdgSqxOO/fdv/x9GNvH3+kpc0GQOQYh23tVW6caeVjfBEA4L
	 TdKSKuPtIUcrbdbgbaFQ+oAbRDDJq4KH/0zvg8CJ+zN+EvMkEG4a1BOvxOEqIR6XJD
	 tGVHKVQFK9V6UZUp1pOJAdhRgrKbgRdZH2RhaSRz0k0oufysA67jCe/voFRkp+gOzd
	 Qx6g6ooWGd27znfZiLT4P4D//5ZOcyak3SMWS28ZQ2/C7KUhf/G19rVUGBiZAq7epV
	 AKJbtk0lIfRpw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63D5uHg553727833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 13:56:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Apr 2026 13:56:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 13 Apr 2026 13:56:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
CC: Kalle Valo <kvalo@kernel.org>, Yan-Hsuan Chuang <yhchuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: RE: [PATCH] rtw88: add TX power limit support to 114 and 130 channels
Thread-Topic: [PATCH] rtw88: add TX power limit support to 114 and 130
 channels
Thread-Index: AQHcrZj6b0aZaPK17kqRjXoafOBZKbXX3tPQ///l4ICABPIGEA==
Date: Mon, 13 Apr 2026 05:56:17 +0000
Message-ID: <f347beb33eb142cba384bbe9378a061c@realtek.com>
References: <20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com>
 <55c23c5551354c6f8752d620f268b37b@realtek.com>
 <adjN1Tl1N_xpzBHd@quatroqueijos.cascardo.eti.br>
In-Reply-To: <adjN1Tl1N_xpzBHd@quatroqueijos.cascardo.eti.br>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34682-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: DA7513E79A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> On Fri, Apr 10, 2026 at 03:56:11AM +0000, Ping-Ke Shih wrote:
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > > Though 114 and 130 are not usual channels, they are found in the wild=
 with
> > > setups using 5350MHz as the center frequency of a 80MHz setup.
> >
> > What did the AP setup? channel 114 160MHz?
> > I wonder why rtw88 can select a not usual channel 114 80MHz.
> >
> > Please share your environment setup.
> >
>=20
> This is a Mikrotik that uses channel 130 at 80MHz.

I'm surprised that an AP can work on this not usual channel/bandwidth.=20
Can you change the setting to usual channel/bandwidth? We'd avoid using
this unsupported channel/bandwidth by [1].

>=20
> > >
> > > rtw88 supports that, but issues a WARNING because it cannot find the =
TX
> > > power limit for those channels.
> >
> > Actually, rtw88 hardware can't support that, so we are working on patch
> > to avoid selecting unusual channels. Can it work properly with
> > the AP after this patch?
> >
>=20
> It does work just fine even without the patch. The only issue is the
> WARNING that is triggered.
>=20

As internal discussion, hardware doesn't work on channel 130 80M,
which means connection might be well, but it can't yield expected performan=
ce.
More, the power limit is not really verified on ch130 80M, so we wonder
that the signal might not in expectation.

By above reasons, we'd avoid using channel 114 and 130.

[1] https://lore.kernel.org/linux-wireless/20260413053601.13037-1-pkshih@re=
altek.com/T/#u



