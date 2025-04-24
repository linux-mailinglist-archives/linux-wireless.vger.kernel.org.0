Return-Path: <linux-wireless+bounces-21944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15585A99EF4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 04:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B47C5A53D3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CA3157A55;
	Thu, 24 Apr 2025 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="v002FFEU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD981A23AC;
	Thu, 24 Apr 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463011; cv=none; b=jUktxhBIdB9BLvz2abxl8RBMZ4BTjWKHgL8GbiFjk4jmBXa2jUCep2Ex758WPPuyJ6WTtD5wOL+8xtnjPe74rSmJH4AMrjdqreDrW5+QK8jucZN40MvdVQP/GILc/JobxUqjI+T8lx0McHkRfOtMzbKTVI/rDkkRQaF0wNRF6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463011; c=relaxed/simple;
	bh=EWfPEEMhtWzHJh3pB1UmpwNAPvdzoaM+KTm2iz8yfus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OF+3cnLwymywQjmoD7wyDK4CYl8fgOMd/HA4fFVRHN32/fyCAM4iaD49gmWG+Sxh8BQwaw930gab7Q8d/RbfnigtHLV3TCqfrdzYwSBwC6AeGQzXO5DaUGF6YAZZhGcrVknqBE+TsvnR/oeiykv0OG8pApGL1uI+YIwZY58CXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=v002FFEU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53O2o3vT53951108, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745463004; bh=EWfPEEMhtWzHJh3pB1UmpwNAPvdzoaM+KTm2iz8yfus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=v002FFEUWPpSxLeFtfc+5gNKVP/3taZqFckDPAUYxUCMJ2YKu/fR6B0b31MnBOygp
	 JLbRF04B1RyPXKQpVQRhscc6RlW3RQYWoxmkW9KfYl76AKZ69g+zkL5sxhhGBp2Hs+
	 SgXBlM0Mug0lCQz3dPuZdi9FwRMm43Zlh2gBVjy1KCJhz6zEteJ4pjVaEshcrp84i2
	 bvQHEKXY6en5Q+uGWITQEPtV8J9TFKKoJ7nXEffbqEnQZiSLpFVj1jTYiDr/4mXzbL
	 VZPBy2OBlEOPmB5/DGnB1vstcpdV9eM1nHXlQbWshMNWKPnXX7ORR38vmRZbptOO3T
	 1M5oFe7LBixtA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53O2o3vT53951108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 10:50:04 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Apr 2025 10:50:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Apr 2025 10:50:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 24 Apr 2025 10:50:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Thread-Topic: [RFC PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Thread-Index: AQHbtI0DZ0O+dUUXJEW0GCQZ07RXY7OyD4XQ
Date: Thu, 24 Apr 2025 02:50:03 +0000
Message-ID: <ea405158f1c7453dba2b3e2c7c3a0e03@realtek.com>
References: <20250423201826.1054254-1-yakoyoku@gmail.com>
In-Reply-To: <20250423201826.1054254-1-yakoyoku@gmail.com>
Accept-Language: en-US, zh-TW
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

Martin Rodriguez Reboredo <yakoyoku@gmail.com> wrote:
> This is an RFC to see if rtl8xxxu can be made to support P2P.
>=20
> Theoretically this should be handled by mac80211 but it seems that
> drivers may have to take some extra steps depending on which device we
> are talking about. I know that this patch is so basic that it might be
> missing some H2C commands or similar for this to work on Realtek chips
> but I don't have the required knowledge for me to implement it, so if
> you know a place to read about I'll be glad to hear.
>=20
> As of now only rtl8192ex devices will have their P2P_CLIENT, P2P_GO
> and P2P_DEVICE wiphy interface modes set because those are the only
> ones I can test on my rtl8192eu card.
>=20
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/8192e.c |  3 ++
>  drivers/net/wireless/realtek/rtl8xxxu/core.c  | 34 ++++++++++++++++++-
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 ++
>  3 files changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
> b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
> index 8e123bbfc665..3e78c5b73726 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
> @@ -1752,6 +1752,9 @@ struct rtl8xxxu_fileops rtl8192eu_fops =3D {
>         .gen2_thermal_meter =3D 1,
>         .needs_full_init =3D 1,
>         .supports_ap =3D 1,
> +       .supports_p2p_client =3D 1,
> +       .supports_p2p_go =3D 1,
> +       .supports_p2p_device =3D 1,

I think no any device supports either GO or GC only. Combine three to one
supports_p2p.=20

To prevent messed up the order for every chip_fops. Please define=20
'supports_p2p =3D 0' for the chips that don't support p2p yet.=20

>         .max_macid_num =3D 128,
>         .max_sec_cam_num =3D 64,
>         .adda_1t_init =3D 0x0fc01616,
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 569856ca677f..a86c4a9083b2 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -1600,9 +1600,11 @@ static void rtl8xxxu_set_linktype(struct rtl8xxxu_=
priv *priv,
>         case NL80211_IFTYPE_ADHOC:
>                 type =3D MSR_LINKTYPE_ADHOC;
>                 break;
> +       case NL80211_IFTYPE_P2P_CLIENT:
>         case NL80211_IFTYPE_STATION:
>                 type =3D MSR_LINKTYPE_STATION;
>                 break;
> +       case NL80211_IFTYPE_P2P_GO:
>         case NL80211_IFTYPE_AP:
>                 type =3D MSR_LINKTYPE_AP;
>                 break;
> @@ -6780,6 +6782,8 @@ static int rtl8xxxu_add_interface(struct ieee80211_=
hw *hw,
>                 return -EOPNOTSUPP;
>=20
>         switch (vif->type) {
> +       case NL80211_IFTYPE_P2P_CLIENT:
> +               fallthrough;

Just like rtl8xxxu_set_linktype(). No need fallthrough.

The fallthrough is needed, only if you do something in the case, but
still want to fall through to next case.

>         case NL80211_IFTYPE_STATION:
>                 if (port_num =3D=3D 0) {
>                         rtl8xxxu_stop_tx_beacon(priv);
> @@ -6790,6 +6794,8 @@ static int rtl8xxxu_add_interface(struct ieee80211_=
hw *hw,
>                         rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
>                 }
>                 break;
> +       case NL80211_IFTYPE_P2P_GO:
> +               fallthrough;

ditto.

>         case NL80211_IFTYPE_AP:
>                 if (port_num =3D=3D 1) {
>                         rtl8xxxu_switch_ports(priv);

[...]


