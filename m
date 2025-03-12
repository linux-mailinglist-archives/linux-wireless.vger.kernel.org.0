Return-Path: <linux-wireless+bounces-20202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA707A5D44A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 03:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21CFC7A985E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20551537C8;
	Wed, 12 Mar 2025 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HvZShm0I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDE14AD20
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745342; cv=none; b=IqPr3nlN/bQAiSjpArWtofzuDc+Aw+m9CmmK2rHGy5oJ/tcAz5Eubk3ri7XkYscV9j/TLs53g3+unmnC1wPM7i12hhADOaP1eGcYas4fYiML1ERCIeM+RD98kOeN3qtlfAmoqZIy9bFp1BZHrGsJCUMaFSNXcJN3vQLTW+sLV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745342; c=relaxed/simple;
	bh=13kHGtjBLElZiQgFOQMT1FL4Jd5y0Jufgs/bW1jgBZo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h3XwZGHBePExcVoeE3/KdISryWcWVwazrP7bmRu4wXNBnJwFgDi5dmQlkBb0+Km4rzYCzhOtPE9ESaBztV5gPXMncwqtCrTkKCl2y2B4Lx3QfRnOTmoEUs4ftF8hEeXPfN8m3IC1goMyoOednl9nJqetog3AgGvRaebLV8CTWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HvZShm0I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52C28rjQ62780182, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741745333; bh=13kHGtjBLElZiQgFOQMT1FL4Jd5y0Jufgs/bW1jgBZo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HvZShm0IoJ7MSTn7iq24CqZIzqPhDTiOS55HZJvzL9KG3DFs8hIfIzreAtjeCIYxC
	 e/nIj0JL/HcP9c1OqtLZrTcY1aiublvVEWVtj2V5/gGJDaV3h8PQOTDysGKXjzf4JO
	 xlm+/giW9kon/A12DRuOXJvuqzQLuMXg3tQV12POOHrcGsmeKHQg9FsUvSTDxbGV1K
	 Rz5G0IUI+TSuYtoW64hXfoSKx5h+2neI9Bm+Ouz62PffIHIvYUw0yDEIzdbOP3HqzW
	 7gCfp1TjuApgpqaKxMKsk8qhamtTfT8ufV4c9BJmKOmNnmNJDxK8tP3mgwiJBRuRF/
	 QS23glFID/W5g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52C28rjQ62780182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 10:08:53 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Mar 2025 10:08:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Mar 2025 10:08:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 12 Mar 2025 10:08:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Felix Fietkau <nbd@nbd.name>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5/8] wifi: mt76: mt7996: use the correct vif link for scanning/roc
Thread-Topic: [PATCH 5/8] wifi: mt76: mt7996: use the correct vif link for
 scanning/roc
Thread-Index: AQHbknGQqrNxlshlSkisMiHyor7mC7NuwjPQ
Date: Wed, 12 Mar 2025 02:08:51 +0000
Message-ID: <df60cf260e2c4a15b9d43bd5bc29f562@realtek.com>
References: <20250311103646.43346-1-nbd@nbd.name>
 <20250311103646.43346-5-nbd@nbd.name>
In-Reply-To: <20250311103646.43346-5-nbd@nbd.name>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

> @@ -839,11 +840,18 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, =
__le32 *txwi,
>         bool beacon =3D !!(changed & (BSS_CHANGED_BEACON |
>                                     BSS_CHANGED_BEACON_ENABLED)) && (!inb=
and_disc);
>=20
> -       mvif =3D vif ? (struct mt76_vif_link *)vif->drv_priv : NULL;
> -       if (mvif) {
> -               omac_idx =3D mvif->omac_idx;
> -               wmm_idx =3D mvif->wmm_idx;
> -               band_idx =3D mvif->band_idx;
> +       if (vif) {
> +               mvif =3D (struct mt7996_vif *)vif->drv_priv;
> +               if (wcid->offchannel)
> +                       mlink =3D rcu_dereference(mvif->mt76.offchannel_l=
ink);

need a RCU read lock?

> +               if (!mlink)
> +                       mlink =3D &mvif->deflink.mt76;
> +       }
> +
> +       if (mlink) {
> +               omac_idx =3D mlink->omac_idx;
> +               wmm_idx =3D mlink->wmm_idx;
> +               band_idx =3D mlink->band_idx;
>         }
>=20
>         if (inband_disc) {



