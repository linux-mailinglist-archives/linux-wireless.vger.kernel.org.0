Return-Path: <linux-wireless+bounces-19745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E643AA4D7A4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 10:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB88188B90F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD71EEA54;
	Tue,  4 Mar 2025 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Y5Jjesi0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E21EE7AD
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079421; cv=none; b=TKNsTV0pDnyvC/KHNVW4vcCQaLQ2ql2UrBgfD9BI7/F2SARHcqvnS3hfeHbdpRdVcTpaialCIiXidBElTaQRHE4XJ7ZlqmZjXIzGY0u1ecQGk9w08sbTyzSMNhK/UUKRZuPN+3sHxg3xG2EHUHSdzrIGFu2INrf8EH4Emn4dfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079421; c=relaxed/simple;
	bh=jYdkDxnoJ48wFdMn+AqStOlIArwn5pY5Wg9Gs0egQOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fme9Rzp7RY7Ux6GZLG9v34xR05eBWMUj45AdlLYdL+eMQji24YElUgxHLcZit/OdLuJO7JQ2IScina1ZVqnqRKhonBdIjnC0TFNMEh9hj9qd98ugja97RKo8cTclRcFoSTmVnMVSY1C3k0BfzElpm7hkkFfwRV8VRmT/bAsPYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Y5Jjesi0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5249A1wB43431317, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741079401; bh=jYdkDxnoJ48wFdMn+AqStOlIArwn5pY5Wg9Gs0egQOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Y5Jjesi0He1NUo5a33pDpyd5xQCjbJgDJ4MolKMoeeAP8/GjAqR3AqAEAnuhYnnrq
	 B4SoOBEO67kr1cuQPzAhnYTVPidVqq1M+fZ7dD/wM6ZxuGchIHS4zbsRyw0beKPTCN
	 wgkIwwtKSipr0osu3NcRFrULQ2Do9J+km4eYdm8ng/KYJkOjJRNcfRVBl4N+VCJzjo
	 eoW2Qmi66X+bHN4A+PKOK2ujIDBjNCtTCYoFinVeK55QWfEZvZhJX0RuBEmhb5S/OI
	 ca/oOqokQrO3/5XvaV5aB7nMgJP2uGRori0RyaBDdZmx9NgMjlfeFB0tQVcrLnhWkI
	 1/08ppM1xQJ9A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5249A1wB43431317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:10:01 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Mar 2025 17:10:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Mar 2025 17:10:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Tue, 4 Mar 2025 17:10:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "Sean.Wang@mediatek.com"
	<Sean.Wang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "allan.wang@mediatek.com" <allan.wang@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based on the CLC data
Thread-Topic: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based
 on the CLC data
Thread-Index: AQHbjM7PI/j8mJkHIkCfOgfmxs+AIbNir+DQ
Date: Tue, 4 Mar 2025 09:10:00 +0000
Message-ID: <3c240deaec6e4a4887a8e144f558158d@realtek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
 <20250304062854.829194-2-mingyen.hsieh@mediatek.com>
In-Reply-To: <20250304062854.829194-2-mingyen.hsieh@mediatek.com>
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

Mingyen Hsieh <mingyen.hsieh@mediatek.com> wrote:

[...]

>=20
> +void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
> +{
> +       struct mt792x_phy *phy =3D &dev->phy;
> +       struct mt7925_clc_rule_v2 *rule;
> +       struct mt7925_clc *clc;
> +       bool old =3D dev->has_eht, new =3D true;
> +       u8 *pos;
> +
> +       if (!phy->clc[MT792x_CLC_BE_CTRL])
> +               goto out;
> +
> +       clc =3D (struct mt7925_clc *)phy->clc[MT792x_CLC_BE_CTRL];
> +       pos =3D clc->data;
> +
> +       while (1) {

while (1) could lead infinite loop unexpectedly.=20
Adding a checking of clc->len would be safer.=20

> +               rule =3D (struct mt7925_clc_rule_v2 *)pos;
> +
> +               if (rule->alpha2[0] =3D=3D alpha2[0] &&
> +                   rule->alpha2[1] =3D=3D alpha2[1]) {
> +                       new =3D false;
> +                       break;
> +               }
> +
> +               /* Check the last one */
> +               if (rule->flag && BIT(0))
> +                       break;
> +
> +               pos +=3D sizeof(*rule);
> +       }
> +
> +out:
> +       if (old =3D=3D new)
> +               return;
> +
> +       dev->has_eht =3D new;
> +       mt7925_set_stream_he_eht_caps(phy);
> +}
> +

[...]


