Return-Path: <linux-wireless+bounces-17994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624CA1D0F5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025371884D17
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 06:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3B113AA2D;
	Mon, 27 Jan 2025 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dGF8itPz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BC16DED2
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737959800; cv=none; b=BYUHvw/8LMwNKGMQiubtE/h1b0KjmmnJmeWbHDxV34nZFrgIjvXdpU9/Yo1gIwjK+sCNN1PDX5lUNkQzaaAxaVCuN2wyFx7ItDy7dLW44g4cip8P1KdoIw8ibCDTxU7AfxcaqdnaYW7aL+1e9vvUA3NcqgdLJEpcJPYPkdpaaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737959800; c=relaxed/simple;
	bh=jBcCPtz290HF2oSND88+H8CD/nzOBfuJ1xkaKNe9Zpo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Up09V5t7W8l+srTusJ5HFiFEQSICZS43HLSo1AxpEfTYqp3kUib+28VeAmJsn7rrmTYbZc2Zev1tciDVLsL2VNiE0euIE/OHnEXIUTtmv1BbbAytJUJePMnPI6rFbTq8tIWRGHWnIuqcpZaocg2bbBQAQJbOFo9IPIjMLjeFXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dGF8itPz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R6aRyV52610594, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737959787; bh=jBcCPtz290HF2oSND88+H8CD/nzOBfuJ1xkaKNe9Zpo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dGF8itPzYks+dixModhChR4MZBkFou/sirsrUFt8VUkrU5RvcqbhwXWXDpfU9Eg/z
	 xEeFyxVepBi2hgDvckaOchA4JOMQbif0MJRvYYXlNhcZVLL5nmgksj14PFIEMOIzwu
	 LxrwDWClQTPYMYQRrWybw5C8Mex2drZ9vTnuUWR9NmjeQD7FwEQM3BMTHJB8I1Di2l
	 g3pI0LRJekCKlW7O6HKAVXc8PFg0/lZJOYXM0P1uE11kc/PEvCWdWzZzXPgMCn4JOq
	 4L5MPWox/WOtmxy/cTeWJDXAmi7+Ckd4Z6Kwz6Ti3jigp0v2AV8v5cle5v139eh5jG
	 Tc/LESGTdZw0Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R6aRyV52610594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:36:27 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 14:36:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 14:36:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 14:36:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
Thread-Topic: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
Thread-Index: AQHbcEWMDvUgah16k02kcTsE1TgourMqKWuB
Date: Mon, 27 Jan 2025 06:36:27 +0000
Message-ID: <ca7380d8560046c4a2a2badde9302691@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>,<fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
In-Reply-To: <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
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
> The existing code is suitable for chips with up to 2 spatial streams.
> Inform the firmware about the rates it's allowed to use when
> transmitting 3 spatial streams.
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
>  drivers/net/wireless/realtek/rtw88/fw.h |  1 +
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wirele=
ss/realtek/rtw88/fw.c
> index 02389b7c6876..0ca1b139110d 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, stru=
ct rtw_sta_info *si,
>  {
>         u8 h2c_pkt[H2C_PKT_SIZE] =3D {0};
>         bool disable_pt =3D true;
> +       u32 mask_hi;
>=20
>         SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
>=20
> @@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, str=
uct rtw_sta_info *si,
>         si->init_ra_lv =3D 0;
>=20
>         rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
> +
> +       if (rtwdev->chip->rf_tbl[RF_PATH_C]) {

Using `efuse->hw_cap.nss >=3D 3` would be consistent with latter patch.=20

> +               SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO_HI);
> +
> +               mask_hi =3D si->ra_mask >> 32;
> +
> +               SET_RA_INFO_RA_MASK0(h2c_pkt, (mask_hi & 0xff));
> +               SET_RA_INFO_RA_MASK1(h2c_pkt, (mask_hi & 0xff00) >> 8);
> +               SET_RA_INFO_RA_MASK2(h2c_pkt, (mask_hi & 0xff0000) >> 16)=
;
> +               SET_RA_INFO_RA_MASK3(h2c_pkt, (mask_hi & 0xff000000) >> 2=
4);
> +
> +               rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
> +       }
>  }

Prefer calling RA_INFO LO/HI in the same level. I meant

rtw_fw_send_ra_info()
{
        rtw_fw_send_ra_info_lo(); // original RA info
   =20
        if (efuse->hw_cap.nss <=3D 2)
                return;

        rtw_fw_send_ra_info_hi();
}


