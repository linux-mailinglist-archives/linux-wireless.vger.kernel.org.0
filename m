Return-Path: <linux-wireless+bounces-26862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88983B3B79B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 11:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF5168212B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6212F0680;
	Fri, 29 Aug 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="w2wzKJQZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B193043B8;
	Fri, 29 Aug 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460483; cv=none; b=P+LeIsiKFWcLErlyjA2d7JSo4PS1ZHweAbTquBpKRC3gSZPzYtUMmAhrqw0UWRXXR+hLp4FrqwBQml05VDRKV9iPdEE+J9K11FWku6EQNDOj9jV0913uscjEheeRG/LXPVkkt2NXolm+lPSL3IiwEkBv/KJ1V13U3h5I8JU69q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460483; c=relaxed/simple;
	bh=CkSf9nDgRBzfKl3t2CBt/uXviW28S25xi5AxQQDIpZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKbQBAvRGkVBenkpOuWciHFlpIoqPORyTYTV/sTYmdnqMtoGQsgvaudAPTtnyw3mlxzh4cT1c/l/4clEX3+ZfBXRcUci3u+5DqnKHszAELVWsG69N3rQVtJx3zfoUJUg1gCiMeLoMJpBps5bMW/4sOPHTpPJ14KedgMBwdkR3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=w2wzKJQZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T9evOF33335886, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756460457; bh=4moyHNWba+bebLk0dnMJdhTozC/x1rqIuMhlvLYSABU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=w2wzKJQZSaO+lwXJZ90eud0if16WJE2DlOnS4WMcUX/TFg9qlAJqkML8vqF7weVFT
	 RyibEtmDeWOnIBEjtqjzW8RTwplg6Cm5gzZjrhCyvWAHWAh+dS0ZhHf8f+xY30hsWU
	 rK9OkV5F7cwkPkAQZ3LXqeKc9uuvZRlqKfU2zwWxNEjS+PxNf3tLH/CncX085W8got
	 AtIyhokWGtC8jlawNvjOjZ7KwSz2oWApk3KgvWsYPjQ6e6ds/kgA7so2HXBafGPcDc
	 mo4pfHs8DygKOVUzYQPRM9Gs6YFjlOJOlomtgPaDI9+Z6Xob9rrvovNmkL+uV8OwnB
	 uSHkWgapgbKRQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T9evOF33335886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 17:40:57 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 17:40:57 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Fri, 29 Aug 2025 17:40:57 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw v3 2/5] wifi: rtw89: fix tx_wait initialization race
Thread-Topic: [PATCH rtw v3 2/5] wifi: rtw89: fix tx_wait initialization race
Thread-Index: AQHcGGCjH5eSvzlnzk+EPaGXQpbFnLR5Tksw
Date: Fri, 29 Aug 2025 09:40:57 +0000
Message-ID: <99e8d23ce3314a76a2a50db1e7d386f3@realtek.com>
References: <20250828211245.178843-1-pchelkin@ispras.ru>
 <20250828211245.178843-3-pchelkin@ispras.ru>
In-Reply-To: <20250828211245.178843-3-pchelkin@ispras.ru>
Accept-Language: zh-TW, en-US
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
> Now that nullfunc skbs are recycled in a separate work item in the driver=
, the following race
> during initialization and processing of those skbs might lead to noticeab=
le bugs:
>=20
>       Waiting thread                          Completing thread
>=20
> rtw89_core_send_nullfunc()
>   rtw89_core_tx_write_link()
>     ...
>     rtw89_pci_txwd_submit()
>       skb_data->wait =3D NULL
>       /* add skb to the queue */
>       skb_queue_tail(&txwd->queue, skb)
>                                             rtw89_pci_napi_poll()
>                                             ...
>                                               rtw89_pci_release_txwd_skb(=
)
>                                                 /* get skb from the queue=
 */
>                                                 skb_unlink(skb, &txwd->qu=
eue)
>                                                 rtw89_pci_tx_status()
>                                                   rtw89_core_tx_wait_comp=
lete()
>                                                   /* use incorrect skb_da=
ta->wait
> */
>   rtw89_core_tx_kick_off_and_wait()
>   /* assign skb_data->wait but too late */
>=20
> The value of skb_data->wait indicates whether skb is passed on to the cor=
e ieee80211 stack
> or released by the driver itself.  So assure that by the time skb is adde=
d to txwd queue and
> becomes visible to the completing side, it has already allocated tx_wait-=
related data (in case
> it's needed).
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of=
 TX skbs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 30 ++++++++++++++---------
> drivers/net/wireless/realtek/rtw89/pci.c  |  2 --
>  2 files changed, 18 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> b/drivers/net/wireless/realtek/rtw89/core.c
> index 5c964283cd67..57f20559dfde 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1094,20 +1094,12 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_=
dev *rtwdev,
> struct sk_buff *sk
>                                     int qsel, unsigned int timeout)  {
>         struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
> -       struct rtw89_tx_wait_info *wait;
> +       struct rtw89_tx_wait_info *wait =3D skb_data->wait;

wiphy_dereference(rtwdev->hw->wiphy, skb_data->wait)

>         unsigned long time_left;
>         int ret =3D 0;
>=20
>         lockdep_assert_wiphy(rtwdev->hw->wiphy);
>=20
> -       wait =3D kzalloc(sizeof(*wait), GFP_KERNEL);
> -       if (!wait) {
> -               rtw89_core_tx_kick_off(rtwdev, qsel);
> -               return 0;
> -       }
> -
> -       init_completion(&wait->completion);
> -       rcu_assign_pointer(skb_data->wait, wait);
>         wait->skb =3D skb;

Also, move "wait->skb =3D skb" to where wait is initialized.

>=20
>         rtw89_core_tx_kick_off(rtwdev, qsel); @@ -1172,10 +1164,12 @@ int
> rtw89_h2c_tx(struct rtw89_dev *rtwdev,  static int rtw89_core_tx_write_li=
nk(struct
> rtw89_dev *rtwdev,
>                                     struct rtw89_vif_link *rtwvif_link,
>                                     struct rtw89_sta_link *rtwsta_link,
> -                                   struct sk_buff *skb, int *qsel, bool =
sw_mld)
> +                                   struct sk_buff *skb, int *qsel, bool =
sw_mld,
> +                                   struct rtw89_tx_wait_info *wait)
>  {
>         struct ieee80211_sta *sta =3D rtwsta_link_to_sta_safe(rtwsta_link=
);
>         struct ieee80211_vif *vif =3D rtwvif_link_to_vif(rtwvif_link);
> +       struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
>         struct rtw89_vif *rtwvif =3D rtwvif_link->rtwvif;
>         struct rtw89_core_tx_request tx_req =3D {};
>         int ret;
> @@ -1192,6 +1186,8 @@ static int rtw89_core_tx_write_link(struct rtw89_de=
v *rtwdev,
>         rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
>         rtw89_core_tx_wake(rtwdev, &tx_req);
>=20
> +       rcu_assign_pointer(skb_data->wait, wait);
> +
>         ret =3D rtw89_hci_tx_write(rtwdev, &tx_req);
>         if (ret) {
>                 rtw89_err(rtwdev, "failed to transmit skb to HCI\n"); @@ =
-1228,7 +1224,8
> @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif=
 *vif,
>                 }
>         }
>=20
> -       return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link,=
 skb, qsel, false);
> +       return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link,=
 skb, qsel, false,
> +                                       NULL);
>  }
>=20
>  static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_inf=
o) @@ -3426,6
> +3423,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct =
rtw89_vif_link
> *rt
>         struct ieee80211_vif *vif =3D rtwvif_link_to_vif(rtwvif_link);
>         int link_id =3D ieee80211_vif_is_mld(vif) ? rtwvif_link->link_id =
: -1;
>         struct rtw89_sta_link *rtwsta_link;
> +       struct rtw89_tx_wait_info *wait;
>         struct ieee80211_sta *sta;
>         struct ieee80211_hdr *hdr;
>         struct rtw89_sta *rtwsta;
> @@ -3435,6 +3433,12 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtw=
dev, struct
> rtw89_vif_link *rt
>         if (vif->type !=3D NL80211_IFTYPE_STATION || !vif->cfg.assoc)
>                 return 0;
>=20
> +       wait =3D kzalloc(sizeof(*wait), GFP_KERNEL);
> +       if (!wait)
> +               return -ENOMEM;
> +
> +       init_completion(&wait->completion);
> +
>         rcu_read_lock();
>         sta =3D ieee80211_find_sta(vif, vif->cfg.ap_addr);
>         if (!sta) {
> @@ -3459,7 +3463,8 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwd=
ev, struct
> rtw89_vif_link *rt
>                 goto out;
>         }
>=20

Fill wait->skb as mentioned above.

> -       ret =3D rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link=
, skb, &qsel, true);
> +       ret =3D rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link=
, skb, &qsel, true,
> +                                      wait);
>         if (ret) {
>                 rtw89_warn(rtwdev, "nullfunc transmit failed: %d\n", ret)=
;
>                 dev_kfree_skb_any(skb);
> @@ -3472,6 +3477,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwd=
ev, struct
> rtw89_vif_link *rt
>                                                timeout);
>  out:
>         rcu_read_unlock();
> +       kfree(wait);
>=20
>         return ret;
>  }
> diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wirel=
ess/realtek/rtw89/pci.c
> index 4e3034b44f56..cb9682f306a6 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -1372,7 +1372,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *=
rtwdev,
>         struct pci_dev *pdev =3D rtwpci->pdev;
>         struct sk_buff *skb =3D tx_req->skb;
>         struct rtw89_pci_tx_data *tx_data =3D RTW89_PCI_TX_SKB_CB(skb);
> -       struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
>         bool en_wd_info =3D desc_info->en_wd_info;
>         u32 txwd_len;
>         u32 txwp_len;
> @@ -1388,7 +1387,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *=
rtwdev,
>         }
>=20
>         tx_data->dma =3D dma;
> -       rcu_assign_pointer(skb_data->wait, NULL);
>=20
>         txwp_len =3D sizeof(*txwp_info);
>         txwd_len =3D chip->txwd_body_size;
> --
> 2.51.0
>=20


