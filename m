Return-Path: <linux-wireless+bounces-15031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FDC9BFD21
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 04:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77191C21199
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76531CD2B;
	Thu,  7 Nov 2024 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FC2bYFKM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C31119A
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730951795; cv=none; b=Ih93nLVOaFPYXDZPEx1B8uzsQnKlH0QQgkNDJ9AtmLJgOl2sMt9mzH/v672NCG5o0mpjnunG4FHqr+MZ/GHYn9ALn0xlKOp1QWcc24Grz9rkciHKCBwciCJt/06rs0s0Km56ZMZUhtDTnzd2CfNmDNavuQ5aponA9egxUqTNJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730951795; c=relaxed/simple;
	bh=YjxMhw3xaS1GmHdzW9ZpsxTLGpmD9iLOm9Vjsi1D4Z0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S76GHotZoTb9b494Qx/E1VMiHbCKUd+axmGGh5FU3j83YpDiJ5V2LU5GBkY3MEpjndZpZn5zVwyxq5lghwgk/wN+7WmfnU6qCtVWR8sV+arEr/tUpDSmhSJvbOGeWnITk96q4udryQbeCx4WtrDrS6d2PT04epNQOwEZlNL/kL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FC2bYFKM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A73uCWL13837165, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730951772; bh=YjxMhw3xaS1GmHdzW9ZpsxTLGpmD9iLOm9Vjsi1D4Z0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FC2bYFKMrv3EcaflcGfQdXodXj1UFizhKC6DmA0ZJWq+gSSxD5JV3Gnzfa7SvwfLn
	 gAgA7vi5/w6VjtDtSyKm+0iBuYH8o13pAQXpsRhHGjeeYlB0jEpFSU6xUByHufkp+K
	 ARCxa/wkicrb8aI+xhbDaiQHjlkckiuoge5zcWEMI5kF0/7E1MRezFZmpsw32s+LO+
	 lszJJrniGNR9oL9NR8FdGZgnHwxzzz6yH3XBW7OiELR7Houf+9XCbUl84HdFCyumFG
	 FfOhlJ+2R7IuT3J8G8xRbOJRopATsIb1JT/SRBFWP/5vMQpP/d+I3fNNpoBealxnjG
	 oc1jXx4LK+ymA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A73uCWL13837165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 11:56:12 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 11:56:13 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Nov 2024 11:56:12 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f]) by
 RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f%2]) with mapi id
 15.01.2507.035; Thu, 7 Nov 2024 11:56:12 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Issam Hamdi <ih@simonwunderlich.de>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "sw@simonwunderlich.de" <sw@simonwunderlich.de>,
        Kretschmer Mathias
	<mathias.kretschmer@fit.fraunhofer.de>
Subject: RE: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32 bit systems
Thread-Topic: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32
 bit systems
Thread-Index: AQHbLt5sCjLWbXTLAUSATUHXLCCG/LKqoSeAgACLp5A=
Date: Thu, 7 Nov 2024 03:56:12 +0000
Message-ID: <1ac0dcb7311e4851abdd15f3dd55cb6a@realtek.com>
References: <20241104172415.3790038-1-ih@simonwunderlich.de>
 <453ad4cc0ba24c07a02210f6a8acbd47@realtek.com>
In-Reply-To: <453ad4cc0ba24c07a02210f6a8acbd47@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
> Issam Hamdi <ih@simonwunderlich.de> wrote:
> > diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c index
> > cb5f16366b9c..39cdbc11f540 100644
> > --- a/net/mac80211/mesh.c
> > +++ b/net/mac80211/mesh.c
> > @@ -1164,7 +1164,7 @@ void ieee80211_mbss_info_change_notify(struct
> ieee80211_sub_if_data *sdata,
> >                 return;
> >
> >         /* if we race with running work, worst case this work becomes a=
 noop */
> > -       for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
> > +       for_each_set_bit(bit, &bits, sizeof(bits) * BITS_PER_BYTE)
> >                 set_bit(bit, ifmsh->mbss_changed);
> >         set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
> >         wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
>=20
> The ifmsh->mbss_changed is defined as:
> 	unsigned long mbss_changed[64 / BITS_PER_LONG];
>=20
> It seems like loop of for_each_set_bit() want to copy each bit of changed=
 (u64).
> When shrink traversal size of for_each_set_bit() from sizeof(changed) to =
sizeof(bits), upper 32
> bits of changed will not be copied to ifmsh->mbss_changed.
> Will it be a problem?
>=20

On 32-bit system, the upper 32 bits seem already lost when "unsigned long b=
its =3D changed". (no matter what the traversal size it is)
IIUC, this patch is going to prevent traversal of "bits" from getting out-o=
f-bound.

But perhaps, "unsigned long bits[] =3D { BITMAP_FROM_U64(changed) }" would =
be better.
Then, traversal size can keep as before.

