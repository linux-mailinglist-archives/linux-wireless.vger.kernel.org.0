Return-Path: <linux-wireless+bounces-28167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88ABFA33A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 08:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2015677DE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5FB2EA17D;
	Wed, 22 Oct 2025 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lJ1kGnYh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22682EC098;
	Wed, 22 Oct 2025 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114116; cv=none; b=O1ksPTUS2OfVY3ZagkPH8Rajkbrd3dzgphpzaEQOmpr1hKzqBX+7jULt1w/eFXibsiCUzdh0wN6iuojznALs0FZcUZyANcohVt/YjBHxVBrYq8Y1xnMWtvC7YZLjYcguGrvnenYkMwUjPkgmV6l7m7+4RqAD4So2W0mlGlu3p1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114116; c=relaxed/simple;
	bh=OC3F52ADrWP/59GalCSeXz8yrsYxVmTOYL6SAp7OzzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kLqwBEGZAsF+pK/EYvJHRgGreRV2kRvWDVjEqyNy9EhR9eFOyUDD3su7ZjjkEsV8lwVGZtXkPxBGiI/hsshTLB21Xd7OoUCmdsFgFWXKCMkL32m8L+XwcH7yTjWScwAmfzo8qcO5ILElyObODegzu9sa9zBSJ3j3a4K68RaM+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lJ1kGnYh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59M6LPHz8161193, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761114086; bh=/sBWd5M1erAr+Fm6dqF8QBFlZvDD8JDJzHaoZPregQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lJ1kGnYhQnCW/zVpFQvREgsN2+rGxEmjgYERrMEaxZDE7/cTV9VqIkD3OO2sxXF80
	 yqOWgdoK+TRa9bPF3uY64krFsiR1PSZBTyVFdl6tKD+yA/IHyk5jmyv8r049xDhiYh
	 Kke4EXJitEweQ0NMdqf4SqElcLYrXqe1ooVPUELe8uHM1a+AEw0wCdZfWfW7smsEOL
	 W37+6FBLMe7dVTipLU2UuHl+A9AoJACfD6AnZ/YlpSLLxq1v/ZDc/C+fTPFW6rHEUw
	 92eYrF0PL7C8Dx7uh2Ji8nrOhaFv/P5BULNmkBZyGf/J5RB9hBXAs5f0fTxbKLAnEh
	 bUSUYqMhH34mg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59M6LPHz8161193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 14:21:26 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 22 Oct 2025 14:21:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 22 Oct 2025 14:21:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 22 Oct 2025 14:21:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v3 5/9] wifi: rtw89: implement C2H TX report handler
Thread-Topic: [PATCH rtw-next v3 5/9] wifi: rtw89: implement C2H TX report
 handler
Thread-Index: AQHcP04Zo3fbbkHRTkiig8Q9g2Z2oLTNsmTQ
Date: Wed, 22 Oct 2025 06:21:25 +0000
Message-ID: <6dc0740a095f4a38ae2427169b1d100c@realtek.com>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
 <20251017100658.66581-6-pchelkin@ispras.ru>
In-Reply-To: <20251017100658.66581-6-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> rtw89 has several ways of handling TX status report events.  The first on=
e
> is based on RPP feature which is used by PCIe HCI.  The other one depends
> on firmware sending a corresponding C2H message, quite similar to what
> rtw88 has.
>=20
> Toggle a bit in the TX descriptor to indicate to the firmware that TX
> report for the frame is expected.   This will allow handling TX wait skbs
> and the ones flagged with IEEE80211_TX_CTL_REQ_TX_STATUS correctly.
>=20
> Do the bulk of the patch according to the vendor driver for RTL8851BU.
> However, there are slight differences in C2H message format between
> different types of chips.  RTL885xB ones follow format V0.  RTL8852C has
> format V1, and RTL8922AU has format V2.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wirele=
ss/realtek/rtw89/fw.h
> index ddebf7972068..e0e587ec4592 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.h
> +++ b/drivers/net/wireless/realtek/rtw89/fw.h
> @@ -3747,6 +3747,47 @@ struct rtw89_c2h_scanofld {
>  #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
>         le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
>=20
> +struct rtw89_c2h_mac_tx_rpt {
> +       struct rtw89_c2h_hdr hdr;
> +       __le32 w2;
> +       __le32 w3;
> +       __le32 w4;
> +       __le32 w5;
> +       __le32 w6;
> +       __le32 w7;
> +};

__packed

> +
> +#define RTW89_C2H_MAC_TX_RPT_W2_TX_STATE GENMASK(7, 6)
> +#define RTW89_C2H_MAC_TX_RPT_W2_SW_DEFINE GENMASK(11, 8)
> +#define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT GENMASK(13, 8)
> +#define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1 GENMASK(15, 10)
> +
> +struct rtw89_c2h_mac_tx_rpt_v2 {
> +       struct rtw89_c2h_hdr hdr;
> +       __le32 w2;
> +       __le32 w3;
> +       __le32 w4;
> +       __le32 w5;
> +       __le32 w6;
> +       __le32 w7;
> +       __le32 w8;
> +       __le32 w9;
> +       __le32 w10;
> +       __le32 w11;
> +       __le32 w12;
> +       __le32 w13;
> +       __le32 w14;
> +       __le32 w15;
> +       __le32 w16;
> +       __le32 w17;
> +       __le32 w18;
> +       __le32 w19;
> +};

__packed

> +
> +#define RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2 GENMASK(9, 8)
> +#define RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2 GENMASK(15, 12)
> +#define RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2 GENMASK(15, 10)
> +
>  struct rtw89_mac_mcc_tsf_rpt {
>         u32 macid_x;
>         u32 macid_y;
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index fd11b8fb3c89..2fe239f18534 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5457,6 +5457,35 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtw=
dev, struct sk_buff *c2h, u32
>         rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
>  }
>=20
> +static void
> +rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 =
len)
> +{
> +       u8 sw_define, tx_status, data_txcnt;
> +
> +       if (rtwdev->chip->chip_id =3D=3D RTL8922A) {

Add a chip_ops c2h_tx_rpt? Then, no need chip_id checking, and reduce line
length (normally we prefer shorter than 80 or 90 characters; over 100 chara=
cters
isn't a good idea).

Maybe this is because you want to store the status into local variables.
With a chip_ops, you should define another struct to store them.

Or, you just keep it as was, but wrap lines to be shorter, and give shorter
naming. For example,
  - rpt_v2 -> v2

  - data_txcnt -> txcnt

		if (rtwdev->chip->chip_id =3D=3D RTL8852C)
			txcnt =3D le32_get_bits(rpt->w5,
					              RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1);
		else
			txcnt =3D le32_get_bits(rpt->w5,
					              RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT);


> +               const struct rtw89_c2h_mac_tx_rpt_v2 *rpt_v2;
> +
> +               rpt_v2 =3D (const struct rtw89_c2h_mac_tx_rpt_v2 *)c2h->d=
ata;
> +               sw_define =3D le32_get_bits(rpt_v2->w12, RTW89_C2H_MAC_TX=
_RPT_W12_SW_DEFINE_V2);
> +               tx_status =3D le32_get_bits(rpt_v2->w12, RTW89_C2H_MAC_TX=
_RPT_W12_TX_STATE_V2);
> +               data_txcnt =3D le32_get_bits(rpt_v2->w14, RTW89_C2H_MAC_T=
X_RPT_W14_DATA_TX_CNT_V2);
> +       } else {
> +               const struct rtw89_c2h_mac_tx_rpt *rpt;
> +
> +               rpt =3D (const struct rtw89_c2h_mac_tx_rpt *)c2h->data;
> +               sw_define =3D le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT=
_W2_SW_DEFINE);
> +               tx_status =3D le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT=
_W2_TX_STATE);
> +               if (rtwdev->chip->chip_id =3D=3D RTL8852C)
> +                       data_txcnt =3D le32_get_bits(rpt->w5, RTW89_C2H_M=
AC_TX_RPT_W5_DATA_TX_CNT_V1);
> +               else
> +                       data_txcnt =3D le32_get_bits(rpt->w5, RTW89_C2H_M=
AC_TX_RPT_W5_DATA_TX_CNT);
> +       }
> +
> +       rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> +                   "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
> +                   sw_define, tx_status, data_txcnt);
> +}
> +
>  static void
>  rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,=
 u32 len)
>  {

[...]


