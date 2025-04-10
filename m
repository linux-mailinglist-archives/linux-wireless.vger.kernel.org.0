Return-Path: <linux-wireless+bounces-21368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E08A837D7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 06:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F190C3AD80D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 04:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706BE19E96D;
	Thu, 10 Apr 2025 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XZo0xgCU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F2F4FA;
	Thu, 10 Apr 2025 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744259437; cv=none; b=BBjZJSXofQEny1Uo81+69mWLfoCwvBJDcNVVGZBwiifqzdUB3GOFVW8OwFYpaAgtO290KZysVodpTPIqUY48iYInXqGsPawxERAE+5u7k3kYwtnRaakUsDcWa6nXDTl4D0jpnfsB12R9V/aeoGD//36YxIEWKxFFZzi4psjbw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744259437; c=relaxed/simple;
	bh=E440f6fp2htax5yG9/sgd0YfZ1XhZwCiqYvFl+2+VzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aOKjO9cw+AbAJTYjMe6A3Wl4jIVyy/HIeyc6jmuP4SQlyRSXpySZJ/KcVz8WJ1rukycAC/LOVh4UJ6i8uxR8HUho0tKwpzsMRgfJsYz1wFGBX8eTKU+csAQ/o7j8qpGZU28eC2ozwKylnbbaFvw5kTo98xm39n7PsKz7PpkpHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XZo0xgCU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53A4U17d82807889, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744259401; bh=E440f6fp2htax5yG9/sgd0YfZ1XhZwCiqYvFl+2+VzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XZo0xgCUNMRusq59HfcCpAZL3D9QSkdmcfXOI+iCKfFICZIu5XG12i7vyHS5mqyNi
	 o4knh5xxe/eFWa7/B8E5kK0s6RbgWQTiayEqA1xwv2VMkENq1QsJixRILQ74iq1ngy
	 BdDEM4Xbtb/jyZWThMnRX1AhSf6VTY1f4/jAARwfbQaIFCWGBpCk6dBMuw26VFEbGq
	 aYr7BifWIOqLCVMPgaV3unTWJ+12gKQP+rvNBoeL0GZOkdHQD6JVAxfF+zKUdRp+f0
	 g5X9Vpi8H59swPRkwzBv2n+Bais9aNt1KLZ6ttsFUKj+S7ec7pKOIo/r3hgdwAV714
	 GTEaKbme0GvWA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53A4U17d82807889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 12:30:01 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Apr 2025 12:30:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 10 Apr 2025 12:30:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 10 Apr 2025 12:30:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zhen XIN <zhen.xin@nokia-sbell.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com"
	<martin.blumenstingl@googlemail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC -v2] wifi: rtw88: sdio: Tx status for management frames
Thread-Topic: [RFC -v2] wifi: rtw88: sdio: Tx status for management frames
Thread-Index: AQHbqQKFFV8iNo+vskOiprOnyfj2d7OcT5Uw
Date: Thu, 10 Apr 2025 04:30:01 +0000
Message-ID: <7f96b6ee57b44626996b70da969219b5@realtek.com>
References: <20250409034910.1637422-1-zhen.xin@nokia-sbell.com>
In-Reply-To: <20250409034910.1637422-1-zhen.xin@nokia-sbell.com>
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

Hi Martin,

Zhen XIN <zhen.xin@nokia-sbell.com> wrote:
> Rtw88-sdio is missing the tx status report for management frames
>=20
> Fix this by mapping mgmt frames to queue TX_DESC_QSEL_MGMT
>=20
> Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
> ---
> v2: have the right queue for mgmt frames as pointed out by Bitterblue Smi=
th
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index e024061bdbf7..4311eb7cffef 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -718,10 +718,7 @@ static u8 rtw_sdio_get_tx_qsel(struct rtw_dev *rtwde=
v, struct sk_buff *skb,
>         case RTW_TX_QUEUE_H2C:
>                 return TX_DESC_QSEL_H2C;
>         case RTW_TX_QUEUE_MGMT:
> -               if (rtw_chip_wcpu_11n(rtwdev))
> -                       return TX_DESC_QSEL_HIGH;
> -               else
> -                       return TX_DESC_QSEL_MGMT;
> +               return TX_DESC_QSEL_MGMT;

Do you remember why you did the special deal with 11n chips?=20
And this RFC looks good to me. (except to commit message, but this is RFC)

>         case RTW_TX_QUEUE_HI0:
>                 return TX_DESC_QSEL_HIGH;
>         default:
> @@ -1227,10 +1224,7 @@ static void rtw_sdio_process_tx_queue(struct rtw_d=
ev *rtwdev,
>                 return;
>         }
>=20
> -       if (queue <=3D RTW_TX_QUEUE_VO)
> -               rtw_sdio_indicate_tx_status(rtwdev, skb);
> -       else
> -               dev_kfree_skb_any(skb);
> +       rtw_sdio_indicate_tx_status(rtwdev, skb);
>  }
>=20
>  static void rtw_sdio_tx_handler(struct work_struct *work)
> --
> 2.25.1


