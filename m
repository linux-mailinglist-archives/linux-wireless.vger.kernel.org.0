Return-Path: <linux-wireless+bounces-17601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189AEA139B3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 13:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9605A3A584D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00B91DDC0D;
	Thu, 16 Jan 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LflwdjRn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F224A7C2
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029200; cv=none; b=hF7HGZ39AnjfdhzOX/mOZMbJGE2Y5PwKbspcWzbr1wVLOgVez9JpboVMdlxExjVqGWXZmZEeRQCYjUxBF/atB8XatETicZAJ7laP5lIj3LwUjBPXHiGlP7aDYzB1GlkTVILK3GxC2R2lHW3fOft0ej6KieSJ1bT9ISUbUyjRjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029200; c=relaxed/simple;
	bh=UTmw9FYLVzCCf0AzLI+yYkVtjQdcZQxMykSgUiz9oqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QCLUzVPXfMUFV0sq7bPGZhtx6dQljsal69ejW47FMvJs48lbONHCBgDzWzx9mdAcEIhahltGkzZz1lM2DUua06Czf4oMivX/zkkSXuhpObTaSjL+wMfggi0WKMabNLQAOxgI3ICuCJ6tOocMxIw1hnkQGEdUUvPMDwCt9IonmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LflwdjRn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50GC6OWi8948574, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737029184; bh=UTmw9FYLVzCCf0AzLI+yYkVtjQdcZQxMykSgUiz9oqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LflwdjRn+yiPb7yZcvZona9XLNtw5gBMy5jWfSesQOu6InHDEAUBCDptAQaXRtcsO
	 dU2WF45OI2cMPtT/4RV1IfaiTgNNq4JTISKU2MhN9+6RnRunQOs+QcdiTck8E5GOQW
	 BdJDjp3JNrWKqPzHv9XiDv0QhE9DDe3Xm34TvdHIz26jbSt/bymhEo2XAGibOA4/KP
	 Cbgx3MxfmxoFDBcLsFtBfBgSu56gTlDGVdCFrlyi1hTvq1Bdh+Hsof2EFSR9llIl4m
	 CPuX14NC2ExEIZNOXJM+Z6KomA7K3Zz385IfhgbKwMCiPOhuhVarSAl34ieiOZJGZ0
	 Sumfu6KD9MVsg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50GC6OWi8948574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:06:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 16 Jan 2025 20:06:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 Jan 2025 20:06:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 16 Jan 2025 20:06:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        Stephen Rothwell
	<sfr@canb.auug.org.au>
Subject: Re: [PATCH] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to Kconfig
Thread-Topic: [PATCH] wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to
 Kconfig
Thread-Index: AQHbZ9mvcCacfzes3E2TTCURefvNkbMZL+n+gAAeJr0=
Date: Thu, 16 Jan 2025 12:06:11 +0000
Message-ID: <d30d222d7c0845fa85fa3506242511b5@realtek.com>
References: <20250116054337.35723-1-pkshih@realtek.com>,<877c6vnjvk.fsf@kernel.org>
In-Reply-To: <877c6vnjvk.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Kalle Valo <kvalo@kernel.org> wrote:
> + stephen
>=20
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > When using allmodconfig, .config has CONFIG_LEDS_CLASS=3Dm but
> > autoconf.h has CONFIG_LEDS_CLASS_MODULE (additional suffix _MODULE)
> > instead of CONFIG_LEDS_CLASS, which condition CONFIG_LEDS_CLASS in
> > rtw88/led.h can't work properly.
> >
> > Add RTW88_LEDS to Kconfig, and use it as condition to fix this problem.
> >
> > drivers/net/wireless/realtek/rtw88/led.c:19:6: error: redefinition of '=
rtw_led_init'
> >    19 | void rtw_led_init(struct rtw_dev *rtwdev)
> >       |      ^~~~~~~~~~~~
> > In file included from drivers/net/wireless/realtek/rtw88/led.c:7:
> > drivers/net/wireless/realtek/rtw88/led.h:15:20: note: previous
> > definition of 'rtw_led_init' with type 'void(struct rtw_dev *)'
> >    15 | static inline void rtw_led_init(struct rtw_dev *rtwdev)
> >       |                    ^~~~~~~~~~~~
> > drivers/net/wireless/realtek/rtw88/led.c:64:6: error: redefinition of '=
rtw_led_deinit'
> >    64 | void rtw_led_deinit(struct rtw_dev *rtwdev)
> >       |      ^~~~~~~~~~~~~~
> > drivers/net/wireless/realtek/rtw88/led.h:19:20: note: previous
> > definition of 'rtw_led_deinit' with type 'void(struct rtw_dev *)'
> >    19 | static inline void rtw_led_deinit(struct rtw_dev *rtwdev)
> >       |                    ^~~~~~~~~~~~~~
> >
> > Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
> > Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>=20
> Maybe add Reported-by and Closes pointing to Stephen's report?

add these by v2.

>=20
> > --- a/drivers/net/wireless/realtek/rtw88/Kconfig
> > +++ b/drivers/net/wireless/realtek/rtw88/Kconfig
> > @@ -238,4 +238,9 @@ config RTW88_DEBUGFS
> >
> >         If unsure, say Y to simplify debug problems
> >
> > +config RTW88_LEDS
> > +     bool
> > +     depends on LEDS_CLASS
> > +     default y
> > +
> >  endif
>=20
> As led.c uses ieee80211_create_tpt_led_trigger() should we depend on
> mac80211? For example ath10k has:
>=20
> config ATH10K_LEDS
>         bool
>         depends on ATH10K

Kconfig of rtw89 uses a big 'if RTW88', so I will not add 'depdens on RTW88=
'.

>         depends on LEDS_CLASS=3Dy || LEDS_CLASS=3DMAC80211
>         default y
>=20
> I can't recall the details but I suspect that's handling the case where
> one of the modules is 'm' and other one 'y' (or something like that).
>=20

Since ieee80211_create_tpt_led_trigger() depends on CONFIG_MAC80211_LEDS,
which looks like

config MAC80211_LEDS
        bool "Enable LED triggers"
        depends on MAC80211
        depends on LEDS_CLASS=3Dy || LEDS_CLASS=3DMAC80211

So I will imitate ath10k to use 'depends on LEDS_CLASS=3Dy || LEDS_CLASS=3D=
MAC80211'



