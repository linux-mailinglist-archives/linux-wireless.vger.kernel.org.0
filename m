Return-Path: <linux-wireless+bounces-27631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8904B990F7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 11:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30C34C13A0
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DF2D63F6;
	Wed, 24 Sep 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DLvvx9si"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D02367AD;
	Wed, 24 Sep 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705532; cv=none; b=aLeKMlKlltLh+8NtgI4oOK/xMdPUYFk2+ixZWpaahcmMGM5tH/Mx3EKPtEwaJSXcZZgLMyy5GLYQ6AGIdJ8nKFHBuGX3s6oWiNeNcL4tqHtv41Zk/aFSseY5U/Pd3AJw2kU2vlLg0KA2Nv4WB95f3ay9gN47m4gH4gUCYaq0vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705532; c=relaxed/simple;
	bh=V1BVU9vghb+3hqADlMRwIMDwc8PSCmJkw/ORv9uoqSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=euTt982rAghGDelo5k0eBtxDeQVtwoSw2r+/L3/bdr0xmNRGwzhElWaqqB6aZrpAuOYg8LUixtq0i57y9JNjMrxJJvE8Ly8zRs7SW0sSapoc9GGXDiYy1eq063j3RRcAwVuSNIsWkjYvcpjSrEB4z5nK4Jco+Tz2ZJk5cd/h58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DLvvx9si; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58O9IV4003463184, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758705511; bh=Hnuj4b/Pgg3Ub9gafKwfIHogn23g5X7O4ZGoMJATF4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DLvvx9si/Zdv1r0CXRWeKZiSdeN0Z0YU/xCjFEDN0x65Lbec4l6QQ2jjLJYbvSIAr
	 4GQKR8rMH86TzVzgMha6AG/32X4hTQ//gieg76Ky8ySSaDZQGlOFN6l6WxOEEOntp8
	 ZnfjbstXl8u1Q2/PMZ/LZ7A77j4UQjvr0C/Fcm7NO3u0evmrZWQPpQOMZ4kkr8156A
	 yVg/db+t8xulWLK4NMmCzUSM0R/UEwXjlqXoZDlVQ21tGVySqUlJ8fFTNCe39EM00M
	 ivDm9066nlYBflXlF9ibxllNw+LLcFOSqVy0uhphs3qIiffodG03pqavNQtjEvdxRy
	 Kk+ROKj1IVfgw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58O9IV4003463184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 17:18:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 24 Sep 2025 17:18:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 24 Sep 2025 17:18:31 +0800
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
Subject: RE: [PATCH rtw-next 3/6] wifi: rtw89: implement C2H TX report handler
Thread-Topic: [PATCH rtw-next 3/6] wifi: rtw89: implement C2H TX report
 handler
Thread-Index: AQHcKjJeBA5Do5JYl0SCBEWCp8awr7SiD80A
Date: Wed, 24 Sep 2025 09:18:31 +0000
Message-ID: <5d0ee6db6ab44ad48222cc4f224aa307@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-4-pchelkin@ispras.ru>
In-Reply-To: <20250920132614.277719-4-pchelkin@ispras.ru>
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
> Toggle a bit in the TX descriptor and place skb in a queue to wait for a
> message from the firmware.  Do this according to the vendor driver for
                            ^^ nit: two spaces

> RTL8851BU.
>=20
> It seems the only way to implement TX status reporting for rtw89 USB.
> This will allow handling TX wait skbs and the ones flagged with
> IEEE80211_TX_CTL_REQ_TX_STATUS correctly.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 12 +++++++++++-
>  drivers/net/wireless/realtek/rtw89/core.h |  2 ++
>  drivers/net/wireless/realtek/rtw89/fw.h   |  5 +++++
>  drivers/net/wireless/realtek/rtw89/mac.c  | 23 +++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/mac.h  |  9 +++++++++
>  drivers/net/wireless/realtek/rtw89/txrx.h |  2 ++
>  6 files changed, 52 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index 917b2adede61..d2a559ddfa2e 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1420,11 +1420,20 @@ static __le32 rtw89_build_txwd_info2_v1(struct rt=
w89_tx_desc_info *desc_info)
>         return cpu_to_le32(dword);
>  }
>=20
> +static __le32 rtw89_build_txwd_info3(struct rtw89_tx_desc_info *desc_inf=
o)
> +{
> +       bool rpt_en =3D desc_info->report;
> +       u32 dword =3D FIELD_PREP(RTW89_TXWD_INFO3_SPE_RPT, rpt_en);

just:
	      u32 dword =3D FIELD_PREP(RTW89_TXWD_INFO3_SPE_RPT, desc_info->report=
);

> +
> +       return cpu_to_le32(dword);
> +}
> +
>  static __le32 rtw89_build_txwd_info4(struct rtw89_tx_desc_info *desc_inf=
o)
>  {
>         bool rts_en =3D !desc_info->is_bmc;
>         u32 dword =3D FIELD_PREP(RTW89_TXWD_INFO4_RTS_EN, rts_en) |
> -                   FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1);
> +                   FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1) |
> +                   FIELD_PREP(RTW89_TXWD_INFO4_SW_DEFINE, desc_info->sn)=
;
>=20
>         return cpu_to_le32(dword);
>  }
> @@ -1447,6 +1456,7 @@ void rtw89_core_fill_txdesc(struct rtw89_dev *rtwde=
v,
>         txwd_info->dword0 =3D rtw89_build_txwd_info0(desc_info);
>         txwd_info->dword1 =3D rtw89_build_txwd_info1(desc_info);
>         txwd_info->dword2 =3D rtw89_build_txwd_info2(desc_info);
> +       txwd_info->dword3 =3D rtw89_build_txwd_info3(desc_info);
>         txwd_info->dword4 =3D rtw89_build_txwd_info4(desc_info);
>=20
>  }
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index 928c8c84c964..2362724323a9 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -1167,6 +1167,8 @@ struct rtw89_tx_desc_info {
>         u8 ampdu_density;
>         u8 ampdu_num;
>         bool sec_en;
> +       bool report;
> +       u8 sn;

Since you limit this to 4 bits by:
   tx_req->desc_info.sn =3D atomic_inc_return(&rtwdev->sn) & 0xF;

How about just 'u8 sn: 4' here?

>         u8 addr_info_nr;
>         u8 sec_keyid;
>         u8 sec_type;
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wirele=
ss/realtek/rtw89/fw.h
> index ddebf7972068..f196088a8316 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.h
> +++ b/drivers/net/wireless/realtek/rtw89/fw.h
> @@ -3747,6 +3747,11 @@ struct rtw89_c2h_scanofld {
>  #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
>         le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
>=20
> +#define RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h) \
> +       le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 6))
> +#define RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h) \
> +       le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(12, 8))
> +

This is old style we don't prefer now.

Please define a struct and masks, and the consumer use le32_get_bits() to
get the values. See rtw89_fw_c2h_parse_attr() for example.

>  struct rtw89_mac_mcc_tsf_rpt {
>         u32 macid_x;
>         u32 macid_y;
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index fd11b8fb3c89..01afdcd5f36c 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5457,6 +5457,17 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtw=
dev, struct sk_buff *c2h, u32
>         rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
>  }
>=20
> +static void
> +rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 =
len)
> +{
> +       u8 sw_define =3D RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
> +       u8 tx_status =3D RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
> +
> +       rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> +                   "C2H TX RPT: sn %d, tx_status %d\n",
> +                   sw_define, tx_status);
> +}
> +
>  static void
>  rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,=
 u32 len)
>  {
> @@ -5691,6 +5702,12 @@ void (* const rtw89_mac_c2h_mcc_handler[])(struct =
rtw89_dev *rtwdev,
>         [RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] =3D rtw89_mac_c2h_mcc_status_=
rpt,
>  };
>=20
> +static
> +void (* const rtw89_mac_c2h_misc_handler[])(struct rtw89_dev *rtwdev,
> +                                           struct sk_buff *c2h, u32 len)=
 =3D {
> +       [RTW89_MAC_C2H_FUNC_TX_REPORT] =3D rtw89_mac_c2h_tx_rpt,
> +};
> +

RTW89_MAC_C2H_FUNC_TX_REPORT is 1, so the size of rtw89_mac_c2h_misc_handle=
r[] is 2.

But, below you check ' if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MISC)', where
NUM_OF_RTW89_MAC_C2H_FUNC_MISC is 5.=20

I prefer just defining used enum. Remove RTW89_MAC_C2H_FUNC_WPS_RPT and=20
RTW89_MAC_C2H_FUNC_BF_SENS_FEEDBACK.


>  static
>  void (* const rtw89_mac_c2h_mlo_handler[])(struct rtw89_dev *rtwdev,
>                                            struct sk_buff *c2h, u32 len) =
=3D {
> @@ -5777,6 +5794,8 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtw=
dev, struct sk_buff *c2h,
>                 }
>         case RTW89_MAC_C2H_CLASS_MCC:
>                 return true;
> +       case RTW89_MAC_C2H_CLASS_MISC:
> +               return true;
>         case RTW89_MAC_C2H_CLASS_MLO:
>                 return true;
>         case RTW89_MAC_C2H_CLASS_MRC:
> @@ -5812,6 +5831,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev=
, struct sk_buff *skb,
>                 if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MCC)
>                         handler =3D rtw89_mac_c2h_mcc_handler[func];
>                 break;
> +       case RTW89_MAC_C2H_CLASS_MISC:
> +               if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MISC)
> +                       handler =3D rtw89_mac_c2h_misc_handler[func];
> +               break;
>         case RTW89_MAC_C2H_CLASS_MLO:
>                 if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MLO)
>                         handler =3D rtw89_mac_c2h_mlo_handler[func];
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wirel=
ess/realtek/rtw89/mac.h
> index 25fe5e5c8a97..632b85aed032 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -432,6 +432,14 @@ enum rtw89_mac_c2h_mcc_func {
>         NUM_OF_RTW89_MAC_C2H_FUNC_MCC,
>  };
>=20
> +enum rtw89_mac_c2h_misc_func {
> +       RTW89_MAC_C2H_FUNC_WPS_RPT,
> +       RTW89_MAC_C2H_FUNC_TX_REPORT,
> +       RTW89_MAC_C2H_FUNC_BF_SENS_FEEDBACK =3D 0x4,
> +
> +       NUM_OF_RTW89_MAC_C2H_FUNC_MISC,
> +};
> +
>  enum rtw89_mac_c2h_mlo_func {
>         RTW89_MAC_C2H_FUNC_MLO_GET_TBL                  =3D 0x0,
>         RTW89_MAC_C2H_FUNC_MLO_EMLSR_TRANS_DONE         =3D 0x1,
> @@ -470,6 +478,7 @@ enum rtw89_mac_c2h_class {
>         RTW89_MAC_C2H_CLASS_WOW =3D 0x3,
>         RTW89_MAC_C2H_CLASS_MCC =3D 0x4,
>         RTW89_MAC_C2H_CLASS_FWDBG =3D 0x5,
> +       RTW89_MAC_C2H_CLASS_MISC =3D 0x9,
>         RTW89_MAC_C2H_CLASS_MLO =3D 0xc,
>         RTW89_MAC_C2H_CLASS_MRC =3D 0xe,
>         RTW89_MAC_C2H_CLASS_AP =3D 0x18,
> diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wire=
less/realtek/rtw89/txrx.h
> index 984c9fdbb018..d7259e6d798e 100644
> --- a/drivers/net/wireless/realtek/rtw89/txrx.h
> +++ b/drivers/net/wireless/realtek/rtw89/txrx.h
> @@ -139,8 +139,10 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev=
 *rtwdev, u16 hw_rate)
>  #define RTW89_TXWD_INFO2_SEC_CAM_IDX GENMASK(7, 0)
>=20
>  /* TX WD INFO DWORD 3 */
> +#define RTW89_TXWD_INFO3_SPE_RPT BIT(10)
>=20
>  /* TX WD INFO DWORD 4 */
> +#define RTW89_TXWD_INFO4_SW_DEFINE GENMASK(3, 0)
>  #define RTW89_TXWD_INFO4_RTS_EN BIT(27)
>  #define RTW89_TXWD_INFO4_HW_RTS_EN BIT(31)

We also have rtw89_core_fill_txdesc_v1() and rtw89_core_fill_txdesc_v2().
If you have looked up the fields already, we can define them by this patch.



