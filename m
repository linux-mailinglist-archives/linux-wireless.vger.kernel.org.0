Return-Path: <linux-wireless+bounces-408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF885804359
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 01:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A60B20A9B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345F657;
	Tue,  5 Dec 2023 00:26:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C5FAC;
	Mon,  4 Dec 2023 16:26:33 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B50QEnyC2413507, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B50QEnyC2413507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Dec 2023 08:26:14 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 5 Dec 2023 08:26:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 5 Dec 2023 08:26:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 5 Dec 2023 08:26:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Gustavo
 A. R. Silva" <gustavoars@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, DeanKu <ku920601@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtw89: avoid stringop-overflow warning
Thread-Topic: [PATCH] rtw89: avoid stringop-overflow warning
Thread-Index: AQHaJoPDzskCZ6cSukWy41fWNynHdbCZ0mZg
Date: Tue, 5 Dec 2023 00:26:14 +0000
Message-ID: <6161bfc56d51413283915031e8d4d653@realtek.com>
References: <20231204073020.1105416-1-arnd@kernel.org>
In-Reply-To: <20231204073020.1105416-1-arnd@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Monday, December 4, 2023 3:30 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>; Gus=
tavo A. R. Silva
> <gustavoars@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>; DeanKu <ku920601@realtek.com>; linux-w=
ireless@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] rtw89: avoid stringop-overflow warning

Subject prefix should be "wifi: rtw89: ..."

>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> After -Wstringop-overflow got enabled, the rtw89 driver produced
> two odd warnings with gcc-13:
>=20
> drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_sc=
an_start':
> drivers/net/wireless/realtek/rtw89/coex.c:5362:50: error: writing 1 byte =
into a region of size 0
> [-Werror=3Dstringop-overflow=3D]
>  5362 |                 wl->dbcc_info.scan_band[phy_idx] =3D band;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> In file included from drivers/net/wireless/realtek/rtw89/coex.h:8,
>                  from drivers/net/wireless/realtek/rtw89/coex.c:5:
> drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 2=
55] into destination object
> 'scan_band' of size 2
>  1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
>       |            ^~~~~~~~~
> drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_sw=
itch_band':
> drivers/net/wireless/realtek/rtw89/coex.c:5406:50: error: writing 1 byte =
into a region of size 0
> [-Werror=3Dstringop-overflow=3D]
>  5406 |                 wl->dbcc_info.scan_band[phy_idx] =3D band;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 2=
55] into destination object
> 'scan_band' of size 2
>  1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
>       |            ^~~~~~~~~
>=20
> I don't know what happened here, but adding an explicit range check
> shuts up the output.

The callers of these two cases will pass RTW89_PHY_0 (0) as argument of phy=
_idx,
and will extend to pass RTW89_PHY_1 (1) in the future, but should not be la=
rger
than 1.

I don't mind to add this checking, but I really don't know what happened ne=
ither.
A statement 'wl->scan_info.band[phy_idx] =3D band;' did similar thing in th=
e same
function, but why doesn't gcc complain this?



