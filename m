Return-Path: <linux-wireless+bounces-4666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E54687A2D5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 07:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096FC28310B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 06:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C956812E76;
	Wed, 13 Mar 2024 06:05:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE912E4E;
	Wed, 13 Mar 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710309949; cv=none; b=G5hQ8VTUe5bAYIeG4ure/hEkOPR8HgsuTG/4+ybBmhTc8ykMRIAzNDoWqs9igWaLu+Q+CQ4IcbNueg0NPZK8JvHw5d0cKvHalwp0RGy0g1xQRDrEubNOdONmzXfCo5K6ayanspIArbhTVWHdbHA7+jij/P+s5oe0NA84+8b2UAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710309949; c=relaxed/simple;
	bh=uMMhAyYQnETnl/wxHyvU2XPSESG2dD8qsAVPm/vmTW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PekVyeWiW4Wo3QGzYDG3fQld/y2q58rtcHYfo+yqM8s7jRNRbtzRwoMtznBMOdTZM91BvbB3tbub7jl8jo53UiYGx5f3uXtEbVumT1NGvXQzwbPXTNMmIC058v9wGodMwhmTuNy6wZ6ShfBFjerXVp++jmIlvviTL3SpbXAqsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42D65hhH6540981, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42D65hhH6540981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 14:05:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 14:05:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 14:05:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 13 Mar 2024 14:05:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ryan Walklin <ryan@testtoast.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: RE: [BUG] RTL8821CS panic on entering power-save mode
Thread-Topic: [BUG] RTL8821CS panic on entering power-save mode
Thread-Index: AQHadM7olU9bQwYCjEqmXTF3UHR0U7E1LQQg
Date: Wed, 13 Mar 2024 06:05:43 +0000
Message-ID: <2afd1590823740a2b6a8f7e485a33842@realtek.com>
References: <f3656995-b8fe-49c4-93b7-67612c685954@app.fastmail.com>
In-Reply-To: <f3656995-b8fe-49c4-93b7-67612c685954@app.fastmail.com>
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



> -----Original Message-----
> From: Ryan Walklin <ryan@testtoast.com>
> Sent: Wednesday, March 13, 2024 6:43 AM
> To: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
> Cc: linux-sunxi@lists.linux.dev
> Subject: [BUG] RTL8821CS panic on entering power-save mode
>=20
> Hi,
>=20
> I have an Allwinner-H700-based platform (Anbernic RG35XX+) which I am wor=
king on mainline u-boot/kernel
> support for. The RGL8821CS chip on this board works when configured with =
a 32MHz clock and 3.3v VCC and
> the RTW88 kernel driver,=20
>=20

Did the extensive logging of LPS state happen always? Or happen after a whi=
le?=20
Try module parameter rtw_disable_lps_deep_mode=3D1 to see if it works well.


The IO of SDIO is slower than PCIE, so maybe we can try to enlarge timeout =
time
in rtw_power_mode_change():

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless=
/realtek/rtw88/ps.c
index add5a20b8432..d959e3ebba07 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -92,7 +92,7 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool e=
nter)
        /* Check firmware get the power requset and ack via cpwm register *=
/
        ret =3D read_poll_timeout_atomic(rtw_read8, polling,
                                       (polling ^ confirm) & BIT_RPWM_TOGGL=
E,
-                                      100, 15000, true, rtwdev,
+                                      100, 15000 * 100, true, rtwdev,
                                       rtwdev->hci.cpwm_addr);
        if (ret) {
                /* Hit here means that driver failed to get an ack from fir=
mware.

> however the BT is unstable with extensive logging about LPS state entry f=
ailures,
> and the driver will eventually crash with the following:

Not sure why this could lead crash, because it is only a warning.=20

Anyway, please try above suggestions.=20

Ping-Ke=20


