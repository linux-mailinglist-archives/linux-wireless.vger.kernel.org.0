Return-Path: <linux-wireless+bounces-26663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC6B3762A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 02:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F2F189E99E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBD314F9FB;
	Wed, 27 Aug 2025 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CeRtCxN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5AEACE;
	Wed, 27 Aug 2025 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255332; cv=none; b=fNdw/CEBDFMpdwEbqbnC6Xk0ydg9QTsa6xH9G/NmHelX/91BJwvM+JLJFZJw2ZluNiiDyHjFs1hHtB4qWcnL5CGI0PAJfPk7ytLbr4BXbKxiBbIqAGjLfw1plWDsk9xp8jwjiA0ta2+5wR0z9kOoB98RJwUvmPBMI1pSq32oGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255332; c=relaxed/simple;
	bh=aWrkSc0EvEUTVz7uCJDC5DoUaqvbLy75eSYZVCTHbLI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QcYCAiHb5kxVu3+oi2ppPjCRbwBLHZNxuBaxJJhCuFSKNkg6eXtAdh2LeVbIuLkOBpB3/HxmdHzLyu+wb7w2imWbXWhrs/dXHhyTqAI9T+HloyjEFWynXEsb70doZapupb3zPYWfoqWjiTYiPEh1VcdFE+s7A1Fx9rIHjg3Kp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CeRtCxN4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57R0g5fB52564623, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756255326; bh=A1zkMaBL6G6zKXwe6drFmbj8wp4GlsPTwl9smSGEmic=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CeRtCxN4FUynvKN2OHau+NvGiX8m673tFu2uzrwiz4kBuDyiX3B0hJmKeUVtrcR+F
	 T4dssHqoHk2QrtnfHYFTcL8gN5Zd1IImWKJiTAnakvde49Qm0Scbxok8fbgQZ8ULQl
	 lHlIWamcFNtp/zwzsM1lDrA0enSm9/QdL4GkU9mD6XeTF86PqqSv7AI8acZRcHx+2q
	 /Zi1gJrL6HYzuIUdV1Lsl6TGGGaT8Tch8Ipj24sawsTwSpjgHkSkJjIbw2sbIHNOiT
	 07mm9Ufl3c4xzelpULKDGJFx0XMdazxQYA/24P2KsBb1qC//I39lay8UuzuaVd+Iru
	 CNY4INJ6LObzg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57R0g5fB52564623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 08:42:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 27 Aug 2025 08:42:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 27 Aug 2025 08:42:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: use int type to store negative error codes
Thread-Topic: [PATCH] wifi: rtw89: use int type to store negative error codes
Thread-Index: AQHcFo1wpnnDoE003EKhdLe9btN+vLR1pnvQ
Date: Wed, 27 Aug 2025 00:42:06 +0000
Message-ID: <b1f89b89906a4573bb8a916ed33763b5@realtek.com>
References: <20250826132905.501755-1-rongqianfeng@vivo.com>
In-Reply-To: <20250826132905.501755-1-rongqianfeng@vivo.com>
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

Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> The 'ret' variable stores returns from other functions, which return
> either zero on success or negative error codes on failure.  Storing
> error codes in u32 (an unsigned type) causes no runtime issues but is
> stylistically inconsistent and very ugly.  Change 'ret' from u32 to
> int - this has no runtime impact.
>=20
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/net/wireless/realtek/rtw89/fw.c  |  7 ++++---
>  drivers/net/wireless/realtek/rtw89/mac.c | 16 ++++++++--------
>  drivers/net/wireless/realtek/rtw89/pci.c |  4 ++--
>  3 files changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wirele=
ss/realtek/rtw89/fw.c
> index 16e59a4a486e..01d53f7c142d 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -1537,7 +1537,7 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev=
 *rtwdev,
>         struct rtw89_fw_hdr *fw_hdr;
>         struct sk_buff *skb;
>         u32 truncated;
> -       u32 ret =3D 0;
> +       int ret =3D 0;

Initializer is not necessary, by the way.=20

>=20
>         skb =3D rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
>         if (!skb) {
> @@ -6826,7 +6826,8 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *=
rtwdev,
>         const struct rtw89_chip_info *chip =3D rtwdev->chip;
>         struct rtw89_fw_info *fw_info =3D &rtwdev->fw;
>         const u32 *c2h_reg =3D chip->c2h_regs;
> -       u32 ret, timeout;
> +       u32 timeout;
> +       int ret;
>         u8 i, val;

Keep it in reverse X'mas tree order.

>=20
>         info->id =3D RTW89_FWCMD_C2HREG_FUNC_NULL;
> @@ -6865,7 +6866,7 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
>                      struct rtw89_mac_h2c_info *h2c_info,
>                      struct rtw89_mac_c2h_info *c2h_info)
>  {
> -       u32 ret;
> +       int ret;
>=20
>         if (h2c_info && h2c_info->id !=3D RTW89_FWCMD_H2CREG_FUNC_GET_FEA=
TURE)
>                 lockdep_assert_wiphy(rtwdev->hw->wiphy);

[...]

> @@ -3105,7 +3105,7 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev=
)
>  static int rtw89_hw_sch_tx_en_h2c(struct rtw89_dev *rtwdev, u8 band,
>                                   u16 tx_en_u16, u16 mask_u16)
>  {
> -       u32 ret;
> +       int ret;

Please move below to be reverse X'mas tree order.

>         struct rtw89_mac_c2h_info c2h_info =3D {0};
>         struct rtw89_mac_h2c_info h2c_info =3D {0};
>         struct rtw89_h2creg_sch_tx_en *sch_tx_en =3D &h2c_info.u.sch_tx_e=
n;

(move here)

[...]

> @@ -4158,7 +4158,7 @@ static int rtw89_pci_lv1rst_stop_dma_ax(struct rtw8=
9_dev *rtwdev)
>=20
>  static int rtw89_pci_lv1rst_start_dma_ax(struct rtw89_dev *rtwdev)
>  {
> -       u32 ret;
> +       int ret;
>=20
>         if (rtwdev->chip->chip_id =3D=3D RTL8852C)
>                 return 0;


The last statement of this function is 'return ret;', but actually it can
just be 'return 0;'. Please change it by the way.=20



