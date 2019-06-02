Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794B232399
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2019 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFBOgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jun 2019 10:36:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55696 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726084AbfFBOgs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jun 2019 10:36:48 -0400
X-UUID: 6a1c0736c5ba410e8098854fab9cdcb0-20190602
X-UUID: 6a1c0736c5ba410e8098854fab9cdcb0-20190602
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 730077780; Sun, 02 Jun 2019 22:36:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 2 Jun 2019 22:36:41 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 2 Jun 2019 22:36:41 +0800
Message-ID: <1559486201.2086.4.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] mt76: mt7615: enable support for mesh
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Chih-Min Chen" <chih-min.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sun, 2 Jun 2019 22:36:41 +0800
In-Reply-To: <e459fbc79154da9e0e6e098d2c49a9b17e842f47.1559301203.git.ryder.lee@mediatek.com>
References: <e459fbc79154da9e0e6e098d2c49a9b17e842f47.1559301203.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-05-31 at 22:09 +0800, Ryder Lee wrote:
> Enable NL80211_IFTYPE_MESH_POINT and update its path.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Changes since v2 - remove unused definitions
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 5 ++++-
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h  | 6 ------
>  4 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> index 59f604f3161f..f860af6a42da 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -133,6 +133,9 @@ static const struct ieee80211_iface_limit if_limits[] = {
>  	{
>  		.max = MT7615_MAX_INTERFACES,
>  		.types = BIT(NL80211_IFTYPE_AP) |
> +#ifdef CONFIG_MAC80211_MESH
> +			 BIT(NL80211_IFTYPE_MESH_POINT) |
> +#endif
>  			 BIT(NL80211_IFTYPE_STATION)
>  	}
>  };
> @@ -195,6 +198,9 @@ int mt7615_register_device(struct mt7615_dev *dev)
>  	dev->mt76.antenna_mask = 0xf;
>  
>  	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
> +#ifdef CONFIG_MAC80211_MESH
> +				 BIT(NL80211_IFTYPE_MESH_POINT) |
> +#endif
>  				 BIT(NL80211_IFTYPE_AP);
>  
>  	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> index b0bb7cc12385..585e67fa2728 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> @@ -37,6 +37,7 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
>  
>  	switch (type) {
>  	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_MESH_POINT:
>  		/* ap use hw bssid 0 and ext bssid */
>  		if (~mask & BIT(HW_BSSID_0))
>  			return HW_BSSID_0;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> index 43f70195244c..8b8db526cb16 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -754,6 +754,7 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
>  
>  	switch (vif->type) {
>  	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_MESH_POINT:
>  		tx_wlan_idx = mvif->sta.wcid.idx;
>  		conn_type = CONNECTION_INFRA_AP;
>  		break;
> @@ -968,7 +969,8 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
>  		.rx_wtbl = {
>  			.tag = cpu_to_le16(WTBL_RX),
>  			.len = cpu_to_le16(sizeof(struct wtbl_rx)),
> -			.rca1 = vif->type != NL80211_IFTYPE_AP,
> +			.rca1 = vif->type != (NL80211_IFTYPE_AP ||
> +					      NL80211_IFTYPE_MESH_POINT),

Oops, this expression is wrong. I will fix it in v3.
Sorry for the inconvenience.

Ryder

