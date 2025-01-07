Return-Path: <linux-wireless+bounces-17118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE69A03402
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 01:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5761884E03
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155F1BC5C;
	Tue,  7 Jan 2025 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZMIxgIvI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77437208AD;
	Tue,  7 Jan 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209687; cv=none; b=uc4czPzsZXDerBpiOBG5dlcguZ6dl+j9pcOijYvYOb/uCEPMnVfd1iyuILbJD6byy85so3NgC+Ij3RFDLnxOavJ1hODe0oKi1mmpbmk4DhJg7PgdFKgScoUltMzEKFe2RykXTzklZQCzZH4q/NhEDxgF3/LwqaRYJAGvm05ZA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209687; c=relaxed/simple;
	bh=jaaGEsVdd7XcrNCceHIfBm3LivSUEjcJegAwk1I9X9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DyFllqVpXWF0JEXZQaiWOuKIY9dMoAPgJJNAjvk2x5MZMSl+S6zYdhtfvyfNlq3/O3kqJ7UqBQOf8y+6akxA6bSQCMP6fc+k2Bof1HVQRZT1SIsBMy2Uy9CS/xkBPfbKGK+l3c9cKwOU1UYQNAenvymIDuz9Z7TiKIFkHVw9dKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZMIxgIvI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5070RhstE3037375, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736209663; bh=jaaGEsVdd7XcrNCceHIfBm3LivSUEjcJegAwk1I9X9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZMIxgIvId0mEV+BN1WpZJx5lSR83lSyinAoG1Bbte1KVp2jSaRTjgpyD508qpf32l
	 FzKcjl6es9V5Yl5sjfYPPkTUpvFJIKeYXTLNKXJu54knjjDkLyCFo0ZftFMXm/reKA
	 iT+xwHZbcIklH+jonRNhp2O87NAq7XHV/ch3iQhAE3ssbs4RfKCQyuqVJtD58QJEys
	 3CgE6i5KVEBC0XoLN//S58pcBCwkfFYsRQs+dNMFXPXDT6QvV5hXc+bp+ZmE93qlqB
	 I1fLtTgNOPhnr81rNSoUXXgZase434HgQ3srOhZikaGtVrHv78jUg/7Vj/o72yVYQS
	 fy8RhyV1bcweg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5070RhstE3037375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 08:27:43 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 Jan 2025 08:27:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 Jan 2025 08:27:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 7 Jan 2025 08:27:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Vasily Khoruzhick <anarsoul@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Ondrej Jirman <megi@xff.cz>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: sdio: Fix disconnection after beacon loss
Thread-Topic: [PATCH] wifi: rtw88: sdio: Fix disconnection after beacon loss
Thread-Index: AQHbYEKP0T2UCkJG7UaT2nZInqDC5rMKdLZw
Date: Tue, 7 Jan 2025 00:27:43 +0000
Message-ID: <4f1064c7b97b47de88b17c647e4a41c3@realtek.com>
References: <20250106135434.35936-1-fiona.klute@gmx.de>
In-Reply-To: <20250106135434.35936-1-fiona.klute@gmx.de>
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

Fiona Klute <fiona.klute@gmx.de> wrote:
> This is the equivalent of 28818b4d871bc93cc4f5c7c7d7c526a6a096c09c

Normally use 12 digits as pattern like:=20

Commit 28818b4d871b ("wifi: rtw88: usb: Fix disconnection after beacon loss=
")

I can spin this during merging.=20

> "wifi: rtw88: usb: Fix disconnection after beacon loss" for SDIO
> chips. Tested on Pinephone (RTL8723CS), random disconnections became
> rare, instead of a frequent nuisance.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index 799230eb5f1..e024061bdbf 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -1192,6 +1192,8 @@ static void rtw_sdio_indicate_tx_status(struct rtw_=
dev *rtwdev,
>         struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
>         struct ieee80211_hw *hw =3D rtwdev->hw;
>=20
> +       skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
> +
>         /* enqueue to wait for tx report */
>         if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
>                 rtw_tx_report_enqueue(rtwdev, skb, tx_data->sn);
> --
> 2.47.1


