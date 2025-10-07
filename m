Return-Path: <linux-wireless+bounces-27842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B502DBC056F
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 08:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C8DC34CBA1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 06:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F31DDA1E;
	Tue,  7 Oct 2025 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Y/HVrS7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915571D7E41;
	Tue,  7 Oct 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818693; cv=none; b=QQUuuQtFqyUEiBvptNecMdPrDFMYJpAy0P3KrCNzDyDR8Ip9qj52dr7fg+yVSbSexCM0isy0us+SLvDwCiKyB0opWY44N/GD3gUBy1i7p1u17RhtagcFvyEnPtvIdsJndO9pQd5KEL9+zZ0+1mEkxUxBhkk7Mm3S7QMhAszpNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818693; c=relaxed/simple;
	bh=4MSQ9ncht23a5L9uiEJ2yq7wIshDmJvAACfRSzy0vKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C47h+0BdmgFcWe1LUNqkxVNA08ZkSQLtNO/JMQypphj+qpUdRmkp5jnDovup8dK9htxKjLJ3s1gXKRa4cAEywyEa4mr1mmRKYyMClUyeJqtUzVp7ZjueRBIwa8gO2nBx4xp18hHV+jJ3A6LnFFftJVsH0hyD7AyNNzTGD8HTCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Y/HVrS7/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5976V6RA03625828, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759818666; bh=mrbWCv3whD58zBjDQj8QwtnTfs2hygM1jlpxGjxv3vA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Y/HVrS7/iTlfgM63+jJseOWoHppGj4NZLQhJKaNPHiRTx0sYNU+u1DLHtQQSNcFt7
	 l8LZCnr3n9UiH2e/0peGoS43Onhs6AZhQeb2OvkUoVjt+TGKzsWGaDeRrTCzejvNUc
	 NFBLH04UrWWmtjK7uZ+9rhO14w3+S1cwhbBQGHVwr/aCG8pP1pW9hLuoctCCssLiIb
	 7LL9vt4swgoMvwzTg/1ILSCrfR88X4KbAfQaLkiFoweClQiYSxcFMh2GWh12wk2ULT
	 BRbshXkkiPeYcl6Q8bQWTIb5sRmZVkBAoWUWVln03EqUfOYrOm7Dcy9xxDzYNpMLGf
	 2vs4fWib+EGdg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5976V6RA03625828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 14:31:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 14:31:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 7 Oct 2025 14:31:06 +0800
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
Subject: RE: [PATCH rtw-next v2 6/7] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Topic: [PATCH rtw-next v2 6/7] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Index: AQHcM9kdfiUOXJLj/0mDvzfuYNV6NLS2Ds4g
Date: Tue, 7 Oct 2025 06:31:06 +0000
Message-ID: <b1725b36caba476ba9ee4916910d8232@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-7-pchelkin@ispras.ru>
In-Reply-To: <20251002200857.657747-7-pchelkin@ispras.ru>
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
>=20
> PCIe HCI has its own way of getting TX status incorporated into RPP
> feature, and it's always enabled there.  Other HCIs need a different
> scheme based on processing C2H messages.
>=20
> Thus define a .tx_rpt_enable flag defining which HCIs would need a TX
> report feature.  Currently it is USB only.
>=20
> Do skb handling / queueing part quite similar to what rtw88 has.  Store
> the flagged skbs in a queue for further processing in a C2H handler.
> Flush the queue on HCI reset and on timeout via delayed work handler used
> for TX waits - it's convenient since the further changes will pass TX wai=
t
> skbs management to the same TX report queue.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>=20
> v2: - update TX rpt description in rtw89_core_tx_update_desc_info()
>     - add a flag in rtw89_hci_info to determine if we should enable TX re=
port (Ping-Ke)
>     - refine rtw89_tx_rpt_queue_purge() - it's called on USB HCI reset
>       and at rtw89_tx_wait_work.  Queueing delayed rtw89_tx_wait_work may=
 be
>       suboptimal but basically it's what rtw88 does with timer stuff.
>       We can drop it and rely only on HCI reset to free remaining buffers
>       in case firmware didn't send any TX status report.  I'd like to kno=
w
>       your thoughts on this.
>=20
>  drivers/net/wireless/realtek/rtw89/core.c |  9 ++++-
>  drivers/net/wireless/realtek/rtw89/core.h |  6 ++++
>  drivers/net/wireless/realtek/rtw89/mac.c  | 19 ++++++++++
>  drivers/net/wireless/realtek/rtw89/mac.h  | 43 +++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/usb.c  | 14 +++++++-
>  5 files changed, 89 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index 49ecc248464b..214924f8bee0 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1107,6 +1107,9 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rt=
wdev,
>                                                  tx_req->rtwsta_link);
>                 if (addr_cam->valid && desc_info->mlo)
>                         upd_wlan_hdr =3D true;
> +
> +               if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
> +                       rtw89_tx_rpt_enable(rtwdev, tx_req);

During review of previous round, I add a patch [1] internally to adjust
this function, because we only need to fill few fields for FWCMD type.

Please add my patch into your patchset before this patch.

[1] https://lore.kernel.org/linux-wireless/20251007032656.13189-1-pkshih@re=
altek.com/T/#u

>         }
>         is_bmc =3D (is_broadcast_ether_addr(hdr->addr1) ||
>                   is_multicast_ether_addr(hdr->addr1));
> @@ -1140,7 +1143,10 @@ static void rtw89_tx_wait_work(struct wiphy *wiphy=
, struct wiphy_work *work)
>         struct rtw89_dev *rtwdev =3D container_of(work, struct rtw89_dev,
>                                                 tx_wait_work.work);
>=20
> -       rtw89_tx_wait_list_clear(rtwdev);
> +       if (!rtwdev->hci.tx_rpt_enable)
> +               rtw89_tx_wait_list_clear(rtwdev);
> +       else
> +               rtw89_tx_rpt_queue_purge(rtwdev);

I feel rtw89_tx_wait_work() should only free list of 'rtwdev->tx_waits'.
To mix TX report queue ('rtwdev->tx_rpt_queue') looks hard to understand.
A skb exists in two queues looks not easy to handle...

Also, I see rtw89_hci_reset() calls rtw89_tx_wait_list_clear(). Is it still
correct after this patch?

>  }
>=20
>  void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
> @@ -5847,6 +5853,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
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
> index 66b7bfa5902e..3940e54353d3 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -3527,6 +3527,8 @@ struct rtw89_tx_wait_info {
>=20
>  struct rtw89_tx_skb_data {
>         struct rtw89_tx_wait_info __rcu *wait;
> +       u8 tx_rpt_sn;
> +       u8 tx_pkt_cnt_lmt;
>         u8 hci_priv[];
>  };
>=20
> @@ -3696,6 +3698,7 @@ struct rtw89_hci_info {
>         u32 rpwm_addr;
>         u32 cpwm_addr;
>         bool paused;
> +       bool tx_rpt_enable;

tx_rpt_enabled?

>  };
>=20
>  struct rtw89_chip_ops {
> @@ -6015,6 +6018,9 @@ struct rtw89_dev {
>         struct list_head tx_waits;
>         struct wiphy_delayed_work tx_wait_work;
>=20
> +       atomic_t sn;
> +       struct sk_buff_head tx_rpt_queue;
> +
>         struct rtw89_cam_info cam_info;
>=20
>         struct sk_buff_head c2h_queue;
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index 10c2a39e544b..75d9efac452b 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5465,10 +5465,29 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, st=
ruct sk_buff *c2h, u32 len)
>         u8 sw_define =3D le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_S=
W_DEFINE);
>         u8 tx_status =3D le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_T=
X_STATE);
>         u8 data_txcnt =3D le32_get_bits(rpt->w5, RTW89_C2H_MAC_TX_RPT_W5_=
DATA_TX_CNT);
> +       struct rtw89_tx_skb_data *skb_data;
> +       struct sk_buff *cur, *tmp;
> +       unsigned long flags;
>=20
>         rtw89_debug(rtwdev, RTW89_DBG_TXRX,
>                     "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
>                     sw_define, tx_status, data_txcnt);
> +
> +       spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
> +       skb_queue_walk_safe(&rtwdev->tx_rpt_queue, cur, tmp) {
> +               skb_data =3D RTW89_TX_SKB_CB(cur);

Prefer just 'skb' instead of 'cur'.=20
I don't need look back to understand 'cur' is a sk_buff.

> +
> +               if (sw_define !=3D skb_data->tx_rpt_sn)
> +                       continue;
> +               if (tx_status !=3D RTW89_TX_DONE &&
> +                   data_txcnt !=3D skb_data->tx_pkt_cnt_lmt)

As commit message of previous patch, "When there is a failed
TX status reported by the firmware, the report is ignored until the limit
is reached or success status appears."

Do you still need to check data_txcnt for failed cases?=20


> +                       continue;
> +
> +               __skb_unlink(cur, &rtwdev->tx_rpt_queue);
> +               rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);
> +               break;
> +       }
> +       spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
>  }
>=20
>  static void
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wirel=
ess/realtek/rtw89/mac.h
> index 15c5c7e4033c..1f7d3734d15f 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -1616,4 +1616,47 @@ int rtw89_mac_scan_offload(struct rtw89_dev *rtwde=
v,
>=20
>         return ret;
>  }
> +
> +static inline
> +void rtw89_tx_rpt_enable(struct rtw89_dev *rtwdev,
> +                        struct rtw89_core_tx_request *tx_req)
> +{
> +       if (!rtwdev->hci.tx_rpt_enable)
> +               return;
> +
> +       tx_req->desc_info.report =3D true;
> +       tx_req->desc_info.sn =3D atomic_inc_return(&rtwdev->sn) & 0xF;

Since you have assigned 4 bits for 'sn', no need '& 0xF'.=20
If you still want to emphasize this, maybe add a comment.

> +       tx_req->desc_info.tx_cnt_lmt_en =3D true;
> +       tx_req->desc_info.tx_cnt_lmt =3D 8;

Question about '8'. Can it be larger?

I mean if hardware retry over 8 (e.g. 10), and succeed to send at 9th retry=
.
Would it be a problem?


> +}
> +
> +static inline
> +void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *sk=
b, u8 tx_status)
> +{
> +       struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> +
> +       ieee80211_tx_info_clear_status(info);
> +       if (tx_status =3D=3D RTW89_TX_DONE)
> +               info->flags |=3D IEEE80211_TX_STAT_ACK;
> +       else
> +               info->flags &=3D ~IEEE80211_TX_STAT_ACK;
> +
> +       ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
> +}
> +
> +static inline
> +void rtw89_tx_rpt_queue_purge(struct rtw89_dev *rtwdev)
> +{
> +       struct sk_buff_head q;
> +       struct sk_buff *skb;
> +       unsigned long flags;
> +
> +       __skb_queue_head_init(&q);

With a blank line, the lock would be clear.=20

> +       spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
> +       skb_queue_splice_init(&rtwdev->tx_rpt_queue, &q);
> +       spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
> +
> +       while ((skb =3D __skb_dequeue(&q)))
> +               rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACID_DROP);
> +}
>  #endif
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wirel=
ess/realtek/rtw89/usb.c
> index 655e8437d62e..f53ab676e9a8 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -216,6 +216,15 @@ static void rtw89_usb_write_port_complete(struct urb=
 *urb)
>                 skb_pull(skb, txdesc_size);
>=20
>                 info =3D IEEE80211_SKB_CB(skb);
> +               if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
> +                       /* sn is passed to rtw89_mac_c2h_tx_rpt() via dri=
ver data */
> +                       skb_queue_tail(&rtwdev->tx_rpt_queue, skb);
> +                       wiphy_delayed_work_queue(rtwdev->hw->wiphy,
> +                                                &rtwdev->tx_wait_work,
> +                                                RTW89_TX_WAIT_WORK_TIMEO=
UT);
> +                       continue;
> +               }
> +
>                 ieee80211_tx_info_clear_status(info);
>=20
>                 if (urb->status =3D=3D 0) {
> @@ -396,6 +405,8 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *r=
twdev,
>         memset(txdesc, 0, txdesc_size);
>         rtw89_chip_fill_txdesc(rtwdev, desc_info, txdesc);
>=20
> +       RTW89_TX_SKB_CB(skb)->tx_rpt_sn =3D tx_req->desc_info.sn;

Prefer a local variable 'struct rtw89_tx_skb_data *skb_data;'.

> +
>         le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE)=
;

This is also to fill tx desc, so prefer filling tx_rpt_sn after this.=20

>=20
>         skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
> @@ -678,7 +689,7 @@ static void rtw89_usb_deinit_tx(struct rtw89_dev *rtw=
dev)
>=20
>  static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
>  {
> -       /* TODO: anything to do here? */
> +       rtw89_tx_rpt_queue_purge(rtwdev);

No sure if we can ensure no TX packets still on the fly --
which have been submitted, but not call rtw89_usb_write_port_complete() yet=
.

But I'm also not sure if it is a problem that newly TX completion happens
after calling rtw89_tx_rpt_queue_purge().

>  }
>=20
>  static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
> @@ -962,6 +973,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
>=20
>         rtwdev->hci.ops =3D &rtw89_usb_ops;
>         rtwdev->hci.type =3D RTW89_HCI_TYPE_USB;
> +       rtwdev->hci.tx_rpt_enable =3D true;
>=20
>         ret =3D rtw89_usb_intf_init(rtwdev, intf);
>         if (ret) {
> --
> 2.51.0
>=20


