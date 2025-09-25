Return-Path: <linux-wireless+bounces-27640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37871B9D16A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 04:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92C332870D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 02:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE072DF3D9;
	Thu, 25 Sep 2025 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hwgj+0M8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032B288C2D;
	Thu, 25 Sep 2025 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765970; cv=none; b=syAzX2XKT3CRnXydhfZqERIT7wKATxbUcua+tt1YuhR4OWyEECz2c1FyyjHTmEATyRyZwMllIf1zpWFIWQBnoTKzc1LXjOKhlFTDbhtdbs9/HZkghVY9RYbWe5zv3Hlf62NRCOetkSTt/DuBamwY94BICn3Wj3U2L3Af7Y2yuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765970; c=relaxed/simple;
	bh=V6Ac39L6EVrmLIpZdBRJv6dSPwWHxezJCGUp7xoyVGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eouzmh+hxnApG3J5MrtVIuyu+YtbEZeFEastcLbslF5FxKLPJOJ5K5y0pFrgSwz1/qlEL1sJyX2dD8ciAJoU29RV8wjh8J3g1QdDYtC89ghpy5JBJm4/M4NAxcyRLHDi+yvkCE1/M/mbXcX63O9ubq1YjBWpzu5iFqrVGQPttLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hwgj+0M8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58P25hmxE451473, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758765943; bh=vCSmgQTDHAGmr3PGwuLPnD/3d2hEPSlmNIBHPWzt1k8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hwgj+0M8D6JQos4vOGSQVVgMx5q1a+aJTUpU27HiFEYBPiBDmQR6SbupPiLMRgFkH
	 erR64q3gfZl1B1pZ09oFkj8ItW0/rkbbleT9djfPs1DbTULdgWle8tUQwPMT96fDRu
	 BXypwlDU8FA18BxSVIWHFQTHSSjC2ek4EwhD3UoBVljzd0UXohQGb97vqdFkLObt5d
	 b0S8eDPV+emAF3um3eUphJoik1vl4a1kLGhZQonCxuIzD3cL15FPI3wpebNOv2SOc5
	 9jH9Hee0JFfJ63zNGrHFsGNmGk2+2ISblsY3R5n0KLoSra5w6q1p/Fd9/cw0mxWBvN
	 NQ/pV5/N+80mQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58P25hmxE451473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 10:05:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 25 Sep 2025 10:05:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 25 Sep 2025 10:05:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 25 Sep 2025 10:05:43 +0800
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
Subject: RE: [PATCH rtw-next 4/6] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Topic: [PATCH rtw-next 4/6] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Index: AQHcKjJqi/Jzq1+F0kmqtZl8ZrJi1LSiFmVg
Date: Thu, 25 Sep 2025 02:05:42 +0000
Message-ID: <de5673b6c65d460187b9d99a14783a7e@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-5-pchelkin@ispras.ru>
In-Reply-To: <20250920132614.277719-5-pchelkin@ispras.ru>
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
> Frames flagged with IEEE80211_TX_CTL_REQ_TX_STATUS mean the driver has to
> report to mac80211 stack whether AP sent ACK for the null frame/probe
> request or not.  It's not implemented in USB part of the driver yet.
                 ^^ nit: two spaces
>=20
> PCIe HCI has its own way of getting TX status incorporated into RPP
> feature, and it's always enabled there.  Other HCIs need a different
                                         ^^ nit: two spaces

I wonder if you want two spaces intentionally?=20

> scheme based on processing C2H messages.
>=20
> Thus define a .tx_rpt_enable handler which will initialize the
> corresponding values used later when writing to TX descriptor.  The
> handler is a no-op for PCIe, TX status reporting behaviour doesn't change
> there.
>=20
> Do skb handling / queueing part quite similar to what rtw88 has.  Store
> the flagged skbs in a queue for further processing in a C2H handler.
> Flush the queue on HCI reset (done at core deinitialization phase, too).
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c |  5 ++++
>  drivers/net/wireless/realtek/rtw89/core.h | 18 ++++++++++++++
>  drivers/net/wireless/realtek/rtw89/mac.c  | 29 +++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/pci.c  |  1 +
>  drivers/net/wireless/realtek/rtw89/pci.h  |  4 ----
>  drivers/net/wireless/realtek/rtw89/usb.c  | 18 ++++++++++++++
>  drivers/net/wireless/realtek/rtw89/usb.h  | 15 ++++++++++++
>  7 files changed, 86 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index d2a559ddfa2e..3e7bd0cedbdf 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1229,6 +1229,7 @@ static int rtw89_core_tx_write_link(struct rtw89_de=
v *rtwdev,
>         struct ieee80211_sta *sta =3D rtwsta_link_to_sta_safe(rtwsta_link=
);
>         struct ieee80211_vif *vif =3D rtwvif_link_to_vif(rtwvif_link);
>         struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
> +       struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
>         struct rtw89_vif *rtwvif =3D rtwvif_link->rtwvif;
>         struct rtw89_core_tx_request tx_req =3D {};
>         int ret;
> @@ -1240,6 +1241,9 @@ static int rtw89_core_tx_write_link(struct rtw89_de=
v *rtwdev,
>         tx_req.rtwsta_link =3D rtwsta_link;
>         tx_req.desc_info.sw_mld =3D sw_mld;
>=20
> +       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
> +               rtw89_hci_tx_rpt_enable(rtwdev, &tx_req);
> +

Normally, we update TX description in rtw89_core_tx_update_desc_info(), and
rtw89_hci_tx_rpt_enable() can be implemented in common flow (but give prope=
r
name). And add a flag in rtw89_hci_info to determine if we should enable
TX report.

By the way, I'm thinking if add a `struct rtw89_hci_attr` as HCI common
attributes for common flow.=20

Another is that rtw89_core_tx_update_desc_info() is a common entry to all
TX types, but most conditions (including we are going to add) are unnecessa=
ry
to RTW89_CORE_TX_TYPE_FWCMD. I also plan to refine this.

Anyway, just add what you need first.=20

>         rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, true, true);
>         rtw89_wow_parse_akm(rtwdev, skb);
>         rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
> @@ -5839,6 +5843,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
>         wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6gh=
z_probe_work);
>         INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
>=20
> +       skb_queue_head_init(&rtwdev->tx_rpt_queue);
>         skb_queue_head_init(&rtwdev->c2h_queue);
>         rtw89_core_ppdu_sts_init(rtwdev);
>         rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index 2362724323a9..4e597a5df005 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -3509,6 +3509,11 @@ struct rtw89_phy_rate_pattern {
>         bool enable;
>  };
>=20
> +#define RTW89_TX_DONE                  0x0
> +#define RTW89_TX_RETRY_LIMIT           0x1
> +#define RTW89_TX_LIFE_TIME             0x2
> +#define RTW89_TX_MACID_DROP            0x3
> +
>  #define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
>  struct rtw89_tx_wait_info {
>         struct rcu_head rcu_head;
> @@ -3646,6 +3651,8 @@ struct rtw89_hci_ops {
>         void (*pause)(struct rtw89_dev *rtwdev, bool pause);
>         void (*switch_mode)(struct rtw89_dev *rtwdev, bool low_power);
>         void (*recalc_int_mit)(struct rtw89_dev *rtwdev);
> +       void (*tx_rpt_enable)(struct rtw89_dev *rtwdev,
> +                             struct rtw89_core_tx_request *tx_req);
>=20
>         u8 (*read8)(struct rtw89_dev *rtwdev, u32 addr);
>         u16 (*read16)(struct rtw89_dev *rtwdev, u32 addr);
> @@ -6008,6 +6015,9 @@ struct rtw89_dev {
>         struct list_head tx_waits;
>         struct wiphy_delayed_work tx_wait_work;
>=20
> +       atomic_t sn;
> +       struct sk_buff_head tx_rpt_queue;
> +
>         struct rtw89_cam_info cam_info;
>=20
>         struct sk_buff_head c2h_queue;
> @@ -6294,6 +6304,7 @@ static inline void rtw89_hci_reset(struct rtw89_dev=
 *rtwdev)
>  {
>         rtwdev->hci.ops->reset(rtwdev);
>         rtw89_tx_wait_list_clear(rtwdev);
> +       skb_queue_purge(&rtwdev->tx_rpt_queue);

ieee80211_purge_tx_queue()?=20
(a caller needs to hold lock)

>  }
>=20
>  static inline int rtw89_hci_start(struct rtw89_dev *rtwdev)
> @@ -6336,6 +6347,13 @@ static inline void rtw89_hci_tx_kick_off(struct rt=
w89_dev *rtwdev, u8 txch)
>         return rtwdev->hci.ops->tx_kick_off(rtwdev, txch);
>  }
>=20
> +static inline void rtw89_hci_tx_rpt_enable(struct rtw89_dev *rtwdev,
> +                                          struct rtw89_core_tx_request *=
tx_req)
> +{
> +       if (rtwdev->hci.ops->tx_rpt_enable)
> +               rtwdev->hci.ops->tx_rpt_enable(rtwdev, tx_req);
> +}
> +
>  static inline int rtw89_hci_mac_pre_deinit(struct rtw89_dev *rtwdev)
>  {
>         return rtwdev->hci.ops->mac_pre_deinit(rtwdev);
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index 01afdcd5f36c..831e53aedccc 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5457,15 +5457,44 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rt=
wdev, struct sk_buff *c2h, u32
>         rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
>  }
>=20
> +static void
> +rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *skb, bo=
ol acked)
> +{
> +       struct ieee80211_tx_info *info;
> +
> +       info =3D IEEE80211_SKB_CB(skb);

nit: just declare ` struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb=
);`=20

> +       ieee80211_tx_info_clear_status(info);
> +       if (acked)
> +               info->flags |=3D IEEE80211_TX_STAT_ACK;
> +       else
> +               info->flags &=3D ~IEEE80211_TX_STAT_ACK;
> +
> +       ieee80211_tx_status_irqsafe(rtwdev->hw, skb);

I'm not aware USB use _irqsafe version before. Can I know the context of
rtw89_usb_write_port_complete()? Is it IRQ context?

> +}
> +
>  static void
>  rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 =
len)
>  {
>         u8 sw_define =3D RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
>         u8 tx_status =3D RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
> +       struct sk_buff *cur, *tmp;
> +       unsigned long flags;
> +       u8 *n;
>=20
>         rtw89_debug(rtwdev, RTW89_DBG_TXRX,
>                     "C2H TX RPT: sn %d, tx_status %d\n",
>                     sw_define, tx_status);
> +
> +       spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
> +       skb_queue_walk_safe(&rtwdev->tx_rpt_queue, cur, tmp) {
> +               n =3D (u8 *)RTW89_TX_SKB_CB(cur)->hci_priv;

The *n is rtw89_usb_tx_data::sn, right? I feel this is hard to ensure
correctness. Why not just define this in struct rtw89_tx_skb_data?
So no need RTW89_USB_TX_SKB_CB() for this.

> +               if (*n =3D=3D sw_define) {
> +                       __skb_unlink(cur, &rtwdev->tx_rpt_queue);
> +                       rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status =3D=
=3D RTW89_TX_DONE);
> +                       break;
> +               }
> +       }
> +       spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);

If we can use ieee80211_tx_status_ni() or ieee80211_tx_status_skb(),=20
I'd like use skb_queue_splice() to create a local skb list, and iterate the
local list, and then splice back to original.

(Reference to mesh_path_move_to_queue())

>  }
>=20
>  static void
> diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wirel=
ess/realtek/rtw89/pci.c
> index 0ee5f8579447..fdf142d77ecc 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -4675,6 +4675,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops =3D=
 {
>         .pause          =3D rtw89_pci_ops_pause,
>         .switch_mode    =3D rtw89_pci_ops_switch_mode,
>         .recalc_int_mit =3D rtw89_pci_recalc_int_mit,
> +       .tx_rpt_enable  =3D NULL, /* always enabled */

The comment is weird. PCI devices don't never use TX report, no?

>=20
>         .read8          =3D rtw89_pci_ops_read8,
>         .read16         =3D rtw89_pci_ops_read16,
> diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wirel=
ess/realtek/rtw89/pci.h
> index cb05c83dfd56..16dfb0e79d77 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.h
> +++ b/drivers/net/wireless/realtek/rtw89/pci.h
> @@ -1487,10 +1487,6 @@ struct rtw89_pci_tx_addr_info_32_v1 {
>  #define RTW89_PCI_RPP_POLLUTED         BIT(31)
>  #define RTW89_PCI_RPP_SEQ              GENMASK(30, 16)
>  #define RTW89_PCI_RPP_TX_STATUS                GENMASK(15, 13)
> -#define RTW89_TX_DONE                  0x0
> -#define RTW89_TX_RETRY_LIMIT           0x1
> -#define RTW89_TX_LIFE_TIME             0x2
> -#define RTW89_TX_MACID_DROP            0x3
>  #define RTW89_PCI_RPP_QSEL             GENMASK(12, 8)
>  #define RTW89_PCI_RPP_MACID            GENMASK(7, 0)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wirel=
ess/realtek/rtw89/usb.c
> index bc0d5e48d39b..98eff955fc96 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -188,6 +188,13 @@ static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
>         }
>  }
>=20
> +static void rtw89_usb_ops_tx_rpt_enable(struct rtw89_dev *rtwdev,
> +                                       struct rtw89_core_tx_request *tx_=
req)
> +{
> +       tx_req->desc_info.report =3D true;
> +       tx_req->desc_info.sn =3D atomic_inc_return(&rtwdev->sn) & 0xF;
> +}
> +
>  static void rtw89_usb_write_port_complete(struct urb *urb)
>  {
>         struct rtw89_usb_tx_ctrl_block *txcb =3D urb->context;
> @@ -216,6 +223,12 @@ static void rtw89_usb_write_port_complete(struct urb=
 *urb)
>                 skb_pull(skb, txdesc_size);
>=20
>                 info =3D IEEE80211_SKB_CB(skb);
> +               if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
> +                       /* sn is passed to rtw89_mac_c2h_tx_rpt() via dri=
ver data */
> +                       skb_queue_tail(&rtwdev->tx_rpt_queue, skb);
> +                       continue;
> +               }
> +
>                 ieee80211_tx_info_clear_status(info);
>=20
>                 if (urb->status =3D=3D 0) {
> @@ -364,6 +377,7 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *r=
twdev,
>         struct rtw89_tx_desc_info *desc_info =3D &tx_req->desc_info;
>         struct rtw89_usb *rtwusb =3D rtw89_usb_priv(rtwdev);
>         struct sk_buff *skb =3D tx_req->skb;
> +       struct rtw89_usb_tx_data *tx_data;
>         struct rtw89_txwd_body *txdesc;
>         u32 txdesc_size;
>=20
> @@ -387,6 +401,9 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *r=
twdev,
>         memset(txdesc, 0, txdesc_size);
>         rtw89_chip_fill_txdesc(rtwdev, desc_info, txdesc);
>=20
> +       tx_data =3D RTW89_USB_TX_SKB_CB(skb);
> +       tx_data->sn =3D tx_req->desc_info.sn;
> +
>         le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE)=
;
>=20
>         skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
> @@ -811,6 +828,7 @@ static const struct rtw89_hci_ops rtw89_usb_ops =3D {
>         .pause          =3D rtw89_usb_ops_pause,
>         .switch_mode    =3D rtw89_usb_ops_switch_mode,
>         .recalc_int_mit =3D rtw89_usb_ops_recalc_int_mit,
> +       .tx_rpt_enable  =3D rtw89_usb_ops_tx_rpt_enable,
>=20
>         .read8          =3D rtw89_usb_ops_read8,
>         .read16         =3D rtw89_usb_ops_read16,
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wirel=
ess/realtek/rtw89/usb.h
> index c1b4bfa20979..c8b2ad2eaa22 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.h
> +++ b/drivers/net/wireless/realtek/rtw89/usb.h
> @@ -53,11 +53,26 @@ struct rtw89_usb {
>         struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
>  };
>=20
> +struct rtw89_usb_tx_data {
> +       u8 sn;
> +};
> +
>  static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
>  {
>         return (struct rtw89_usb *)rtwdev->priv;
>  }
>=20
> +static inline struct rtw89_usb_tx_data *RTW89_USB_TX_SKB_CB(struct sk_bu=
ff *skb)
> +{
> +       struct rtw89_tx_skb_data *data =3D RTW89_TX_SKB_CB(skb);
> +
> +       BUILD_BUG_ON(sizeof(struct rtw89_tx_skb_data) +
> +                    sizeof(struct rtw89_usb_tx_data) >
> +                    sizeof_field(struct ieee80211_tx_info, driver_data))=
;
> +
> +       return (struct rtw89_usb_tx_data *)data->hci_priv;
> +}
> +
>  int rtw89_usb_probe(struct usb_interface *intf,
>                     const struct usb_device_id *id);
>  void rtw89_usb_disconnect(struct usb_interface *intf);
> --
> 2.51.0
>=20


