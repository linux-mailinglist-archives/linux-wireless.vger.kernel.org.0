Return-Path: <linux-wireless+bounces-4287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B13A86D9CE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 03:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA25928408D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E203FE36;
	Fri,  1 Mar 2024 02:37:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE13FB3D;
	Fri,  1 Mar 2024 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260633; cv=none; b=PLVyr5NiwCe3Gk5csW/N/pQICAI3MjqA0zjwY/seeL5Iumup7Hw+LKnd+rxz9WWqjCWaoRqdsrfYrvppiVTd67HC59YoB82BetvIj2WZlcvV0xgm4J1io3ovSvD/Z6KK02zn+g491ZirrA4jVrhFThUNhhnK1Te8RrTMoZ7UBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260633; c=relaxed/simple;
	bh=DCNBJjYgSctwJ1sh4vYpCJM2sffkY7ttDb2bZ/LkbOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qqdlMAmxKeTMwosrlZzKonhBxY6u2qvn2HgfDKQ4IfxLxX5hHx4wLCwx6lyG8g9IjYl70dMaJNSnyQEHVW4rKKA7c3UVYZG822oBtb84+68Ow+fqSZrKm8uZLo7HXncpBgr+QcQan5PxgZQRCbPBcG1r7gd5zpionbJZaCaoKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4212anl771842111, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4212anl771842111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 10:36:49 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Mar 2024 10:36:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 10:36:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 10:36:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz"
	<megi@xff.cz>
Subject: RE: [PATCH v2 7/9] wifi: rtw88: Add rtw8703b_tables.c
Thread-Topic: [PATCH v2 7/9] wifi: rtw88: Add rtw8703b_tables.c
Thread-Index: AQHaadh+VjiQRYuLIE6Vkan7rS/d/rEiLnWw
Date: Fri, 1 Mar 2024 02:36:48 +0000
Message-ID: <9ee0cb2bd7694e0da8f0576da6a182b5@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-8-fiona.klute@gmx.de>
In-Reply-To: <20240227235507.781615-8-fiona.klute@gmx.de>
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
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Wednesday, February 28, 2024 7:55 AM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org; ulf.hansson@linar=
o.org; linux-mmc@vger.kernel.org;
> pavel@ucw.cz; megi@xff.cz
> Subject: [PATCH v2 7/9] wifi: rtw88: Add rtw8703b_tables.c
>=20
> Initialization tables for rtw8703b: Initial register values and TX
> power limits.
>=20
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>  .../wireless/realtek/rtw88/rtw8703b_tables.c  | 901 ++++++++++++++++++
>  1 file changed, 901 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
> b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
> new file mode 100644
> index 00000000000..6ece407d560
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
> @@ -0,0 +1,901 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
> +
> +#include "main.h"
> +#include "phy.h"

include " rtw8703b_tables.h" to avoid sparse warnings:

drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:16:1: warning: symbol =
'rtw8703b_bb_pg_tbl' was not declared. Should it be static?
drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:194:1: warning: symbol=
 'rtw8703b_txpwr_lmt_tbl' was not declared. Should it be static?
drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:306:1: warning: symbol=
 'rtw8703b_mac_tbl' was not declared. Should it be static?
drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:633:1: warning: symbol=
 'rtw8703b_agc_tbl' was not declared. Should it be static?
drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:841:1: warning: symbol=
 'rtw8703b_bb_tbl' was not declared. Should it be static?
drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:901:1: warning: symbol=
 'rtw8703b_rf_a_tbl' was not declared. Should it be static?



