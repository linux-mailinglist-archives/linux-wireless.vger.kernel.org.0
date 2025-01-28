Return-Path: <linux-wireless+bounces-18053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE95A2042B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 06:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAF6165342
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69AE83A14;
	Tue, 28 Jan 2025 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XqdyhQYt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4481487F8
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043561; cv=none; b=U9m2xeZsKF+hbUaL716SpHKy4uTJNAkl0UFoYS8nzYOJj8RVRyFBLitlEgfi9LhW8SWmNbuVF6H08HaTUpRV5shGYGfrWEJWW6svqZIuPiNiUPWwhogGjHyXVkkeTCR09QMWmM87Wvx68Rk/p3iuvphaL1x2BBsGg6aektLpJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043561; c=relaxed/simple;
	bh=vxQXHKMdBdZ3MpYzzGkJ3Jypwfv1cfxxnG5VsuGdIRI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iMdNrPykw87wDDhFgLybUFYr9F0P7aVLwBZWPuk19YJ7is0UmYgv4hGluuCydOetJdf4Eh0CkIS/oJvLgNYTjvd3SSHktoAszUBWKQ2bE73ou092kjPSiSovxfECsuFppFM2niLdQmV2mUIXFXkE3JCFXQUsBzAfTXgtfo8Qwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XqdyhQYt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50S5qY5b94095113, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738043554; bh=vxQXHKMdBdZ3MpYzzGkJ3Jypwfv1cfxxnG5VsuGdIRI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XqdyhQYt5pKVIDpQzeC0Eoddq4do16+8WAWJotTW8j3U9jIlxhb8nr5YgbkFp8oI2
	 36V3JF7mq3pBDI9Kza5+yUMz/MIRUufQN/pW6eZdKj45rbP53HTgS2Qj1RmFcZ4N0L
	 CqU31nVqwdhclQMpcI/N6xPMQZn4xZY5aqb0rrqWCxoeJ6C8zkCXdb8ApGfh3Hs1J0
	 sAZ8Ge/384gFpfvADQ7N2me7Nwbp54/iDfnXGpOl9m30GaTnNzQEF06CLy2+fRiRGa
	 Er9zTRk4q6AGYE/Hope23BQeqYI79S07iENgfQ3RnbRttYMeqkYdC5qLXT4/zkh+Gf
	 lVeTXBGH2kmAg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50S5qY5b94095113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 13:52:34 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 Jan 2025 13:52:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 Jan 2025 13:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Tue, 28 Jan 2025 13:52:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
Thread-Topic: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
Thread-Index: AQHbcEWMDvUgah16k02kcTsE1TgourMqKWuBgACTdYCAAPJSlA==
Date: Tue, 28 Jan 2025 05:52:34 +0000
Message-ID: <53740c9ec74a4aa0a5a3c51b895eb385@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
 <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
 <ca7380d8560046c4a2a2badde9302691@realtek.com>,<d05ba9e5-d5e3-4761-bd1e-f7c2b63f5a36@gmail.com>
In-Reply-To: <d05ba9e5-d5e3-4761-bd1e-f7c2b63f5a36@gmail.com>
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

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> On 27/01/2025 08:36, Ping-Ke Shih wrote:
> > Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> >> The existing code is suitable for chips with up to 2 spatial streams.
> >> Inform the firmware about the rates it's allowed to use when
> >> transmitting 3 spatial streams.
> >>
> >> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> >> ---
> >>  drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
> >>  drivers/net/wireless/realtek/rtw88/fw.h |  1 +
> >>  2 files changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wir=
eless/realtek/rtw88/fw.c
> >> index 02389b7c6876..0ca1b139110d 100644
> >> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> >> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> >> @@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, s=
truct rtw_sta_info *si,
> >>  {
> >>         u8 h2c_pkt[H2C_PKT_SIZE] =3D {0};
> >>         bool disable_pt =3D true;
> >> +       u32 mask_hi;
> >>
> >>         SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
> >>
> >> @@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, =
struct rtw_sta_info *si,
> >>         si->init_ra_lv =3D 0;
> >>
> >>         rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
> >> +
> >> +       if (rtwdev->chip->rf_tbl[RF_PATH_C]) {
> >
> > Using `efuse->hw_cap.nss >=3D 3` would be consistent with latter patch.
> >
>=20
> I would like that, but nss is 2 when RTL8814AU is in USB 2 mode.
> I assume this is to keep the current draw under the 500 mA limit
> of USB 2.
>=20
> What about rtwdev->hal.rf_path_num >=3D 3 ? I don't remember why
> I didn't do that.

I think `rtwdev->hal.rf_path_num >=3D 3` is suitable to initialize/configur=
e
hardware registers, because no matter USB 2 or 3 mode should be the same.

For this case (RA info), this is related to protocol, so I feel=20
`efuse->hw_cap.nss >=3D 3` is suitable, but I have not seen a patch to decl=
are
supported NSS in register_hw(), or I missed it? Or, without RA_INFO_HI,
it gets abnormal rate to RTL8814AU in your test?


