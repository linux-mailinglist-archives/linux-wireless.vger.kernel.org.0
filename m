Return-Path: <linux-wireless+bounces-21522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF77A89185
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 03:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A796189AB54
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 01:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22BB19E99E;
	Tue, 15 Apr 2025 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pUxcYfAj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC457EEA9;
	Tue, 15 Apr 2025 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681306; cv=none; b=MdMihUBWC29vhroWTbyk4TzM64cQz+k/PoG2NQlPHVBGaYtIHudAtzNeguZioexSremYZzqWsAytBbSW2G9LF2n4AHSl7bkU0lblOCfmXqxVd76e83oSxrGg+NwjKqkTySqiLJTo/JBu8WY7SsQ7kek5GosUSCoclGzw1pKvLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681306; c=relaxed/simple;
	bh=5V0c5pcHPBJDFeK7QcA59uEXxs97k1DgLs4FaxIv7Zo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hKOz2ZRh4STQSP6Xw+9M/CrSNGW+/r9Rp96iP9b0A6u+DkSLBIm3ncD6K3/LQb01p/mYzzH7/ovfOYnstavJii2nQaBrydrTsGuFTg5GVJhv4Z5Bp+Tl2dJYsdgafIO7jXPsSLpyoscaNIQYU139zOHdgRdz5UaX3LmsYHnT5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pUxcYfAj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53F1fTTQ1362095, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744681289; bh=5V0c5pcHPBJDFeK7QcA59uEXxs97k1DgLs4FaxIv7Zo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pUxcYfAjAidLK5Bmvni9fSunlluItwiOIosCP7yDZX6J+ZekdOLyuyDftC3bp7kS5
	 vHsRoF2V3wMfjKAmaVWnAF6IU9q5DXaho1mFKVJp/mm6PJl/nEZdjmiYVksNcTCYdA
	 2QTy7ILvJUhzm86dme7FKxIGwLeLyG3dy/oSSQnwUFgDLqqHkL+0x2JKOeSQOAZfNk
	 aaFVSC3k0Yy7XV/23BPfE5n18ceRiJprWOPdvHnl79GWDEcD/SU1lfG5oxrgt281m+
	 /OfmqLoMbvr8bZLKdTDRqTeVrep9J0guadruIsWZYYDi3WgR0yzDQh/kXC0aM+6ELw
	 Bz8LiyoZyCfbg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53F1fTTQ1362095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 09:41:29 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 09:41:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 15 Apr 2025 09:41:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 15 Apr 2025 09:41:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zhen XIN <zhen.xin@nokia-sbell.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH -v2 2/2] wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
Thread-Topic: [PATCH -v2 2/2] wifi: rtw88: sdio: map mgmt frames to queue
 TX_DESC_QSEL_MGMT
Thread-Index: AQHbqi/AoiBG2M0l1Umtjv/+rZii17Oj+WcQ
Date: Tue, 15 Apr 2025 01:41:29 +0000
Message-ID: <0ea484ea33794b1f9b99de46c94553ad@realtek.com>
References: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com>
 <20250410154217.1849977-3-zhen.xin@nokia-sbell.com>
In-Reply-To: <20250410154217.1849977-3-zhen.xin@nokia-sbell.com>
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

Zhen XIN <zhen.xin@nokia-sbell.com> wrote:
> Rtw88-sdio do not work in AP mode due to the lack of tx status report for
> management frames.
>=20
> Map the management frames to queue TX_DESC_QSEL_MGMT, which enables the
> chip to generate TX reports for these frames

I will change the order of this patch to first one, because with patch 1/2
only, it will throw many messages that times out to wait for TX reports
from firmware.=20

By the way, patch subject should contain "rtw-next" as hint for NIPA to
test build [1]. This patchset is simple so it also work to build with
wireless-next.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/2025041015421=
7.1849977-3-zhen.xin@nokia-sbell.com/

>=20
> Tested-on: rtl8723ds
>=20
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")
> Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index ef51128a4b44..4311eb7cffef 100644
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
>         case RTW_TX_QUEUE_HI0:
>                 return TX_DESC_QSEL_HIGH;
>         default:
> --
> 2.25.1


