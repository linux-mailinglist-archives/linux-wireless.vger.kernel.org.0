Return-Path: <linux-wireless+bounces-1191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36FC81C2E9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 02:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C61F23F81
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C05A50;
	Fri, 22 Dec 2023 01:54:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51CA31
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BM1sSR611801030, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BM1sSR611801030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 09:54:28 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 22 Dec 2023 09:54:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 09:54:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 22 Dec 2023 09:54:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v2 20/21] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
Thread-Topic: [PATCH v2 20/21] wifi: rtl8xxxu: make supporting AP mode only on
 port 0 transparent
Thread-Index: AQHaNC0oaJY+qGCnXUKN9G8m+k3jo7C0ikyQ
Date: Fri, 22 Dec 2023 01:54:27 +0000
Message-ID: <7bbb0d0b803d49088957b47ad716e99b@realtek.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <20231221164353.603258-21-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-21-martin.kaistra@linutronix.de>
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



> -----Original Message-----
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Friday, December 22, 2023 12:44 AM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH v2 20/21] wifi: rtl8xxxu: make supporting AP mode only on=
 port 0 transparent
>=20

[...]

> +
> +       /*
> +        * priv->vifs[0] is NULL here, based on how this function is curr=
ently
> +        * called from rtl8xxxu_add_interface().
> +        * When this function will be used in the future for a different
> +        * scenario, please check whether vifs[0] or vifs[1] can be NULL =
and if
> +        * necessary add code to set port_num =3D 1.
> +        */

Did you run scripts/checkpatch.pl to this patch? Initial line of comment bl=
ock
for networking code should not empty, so it should be below:=20

+       /* priv->vifs[0] is NULL here, based on how this function is curren=
tly
+        * called from rtl8xxxu_add_interface().
+        * When this function will be used in the future for a different
+        * scenario, please check whether vifs[0] or vifs[1] can be NULL an=
d if
+        * necessary add code to set port_num =3D 1.
+        */



