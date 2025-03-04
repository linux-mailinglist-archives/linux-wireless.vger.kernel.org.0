Return-Path: <linux-wireless+bounces-19746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6DA4D7A7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2806A16CD20
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE871FC7F6;
	Tue,  4 Mar 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="S3p3YHNn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A51FC7C9
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079643; cv=none; b=asMspr+EF2iwWZnAArLYftyIKhfcKtZIdKkQ0vBB9vl9crrwQsXy9WZ8FxJjRWjiaw+z83XYxeRw2tH8XgKZK1O9XZ6pvAnfhbCLfMhm1ayo2R9ROGFS6IjRQw3vVps0hdCiRuDU39z7g7V3954SPzFHQWFLnk0x+usn8fS70qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079643; c=relaxed/simple;
	bh=U14yuLNH47gG7qspn1mFqtdeSsWKIMSVCGKOHmNCaNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fYH0QZyi4UwE6dbwY74TsQxx10HJPqldoZED8KfuDmIiPgvUPH08HchU29VLO5vMylJ/oN8kOhe5lT4CKAsp09a355buJurg4n/uYYHqS1eVO+dRLup8qk1DXpgZYNGZqYRF9LHLS/OEDgXVZKq3xOfzRzAwCL+cSC9Oz3afuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=S3p3YHNn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5249Di6823446908, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741079624; bh=U14yuLNH47gG7qspn1mFqtdeSsWKIMSVCGKOHmNCaNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=S3p3YHNn9lC8S6Lxp6Ue5e1CFJDghHtLujjdocUezF1VIL92nObI43B87gJVM7gsy
	 BcN4HfCSNsS1wG4nVKVUACIvH9kOIFAliwgT6vWyRnAtUAGScq1Q+byubXRyw/4mi7
	 GRB4KNBQHF3pSWXNtmIJatCgbEE+NJHukUbtsWUfpym5cB2vNygPouz2qr4JHJWn4R
	 Y6rGrWJDGX2myQTd20yOdnE9WpsnYe9oKJJxcEkRe+C0Xh7Nkd6fHquYx+t3VUECvj
	 8zkG8+ehJ2r9VdD36sDZ0oIFO87ZYFtmwmDjfnnx3oXCrN1RaaKAggy79xB9t9aqee
	 JS9XfxrfH1sPQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5249Di6823446908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:13:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Mar 2025 17:13:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Mar 2025 17:13:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Tue, 4 Mar 2025 17:13:44 +0800
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
Subject: RE: [PATCH v2 3/6] wifi: mt76: mt7925: update the channel usage when the regd domain changed
Thread-Topic: [PATCH v2 3/6] wifi: mt76: mt7925: update the channel usage when
 the regd domain changed
Thread-Index: AQHbjM7N2KFn0uDwKkCbcB2eIcZbBbNisOEA
Date: Tue, 4 Mar 2025 09:13:44 +0000
Message-ID: <96503735cafd4e1eaafccb3e0479e9fc@realtek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
 <20250304062854.829194-3-mingyen.hsieh@mediatek.com>
In-Reply-To: <20250304062854.829194-3-mingyen.hsieh@mediatek.com>
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

> +static void
> +mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
> +{
> +#define IS_UNII_INVALID(idx, sfreq, efreq) \
> +       (!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >=3D (sfreq) && =
(cfreq) <=3D (efreq))

Implicitly using 'cfreq' would be missing something by reviewers.
How about adding it as an argument of macro?

> +       struct ieee80211_supported_band *sband;
> +       struct mt76_dev *mdev =3D &dev->mt76;
> +       struct ieee80211_channel *ch;
> +       int i, cfreq;
> +
> +       sband =3D wiphy->bands[NL80211_BAND_5GHZ];
> +       if (!sband)
> +               return;
> +
> +       for (i =3D 0; i < sband->n_channels; i++) {
> +               ch =3D &sband->channels[i];
> +               cfreq =3D ch->center_freq;
> +
> +               /* UNII-4 */
> +               if (IS_UNII_INVALID(0, 5845, 5925))
> +                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> +       }
> +
> +       sband =3D wiphy->bands[NL80211_BAND_6GHZ];
> +       if (!sband)
> +               return;
> +
> +       for (i =3D 0; i < sband->n_channels; i++) {
> +               ch =3D &sband->channels[i];
> +               cfreq =3D ch->center_freq;
> +
> +               /* UNII-5/6/7/8 */
> +               if (IS_UNII_INVALID(1, 5925, 6425) ||
> +                   IS_UNII_INVALID(2, 6425, 6525) ||
> +                   IS_UNII_INVALID(3, 6525, 6875) ||
> +                   IS_UNII_INVALID(4, 6875, 7125))
> +                       ch->flags |=3D IEEE80211_CHAN_DISABLED;
> +       }
> +}
> +

[...]


