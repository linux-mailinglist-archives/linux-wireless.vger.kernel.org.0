Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E337169
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 12:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfFFKOq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 06:14:46 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:58250 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfFFKOq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 06:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=IVyG0+asKq/UCG7fsgR27xleEN4h1pxc9HyWAz1Nb+A=;
        b=JdlD+A7ZvGDKeJH02nK2YNcVgPjSfugBFOPFlypfOjHjvJoxffzgnRKwsPh/cQ3EPGcGvn+/oAzIzX/I0pwoI6OGuefPKkFJI+Zhuwi3FI5z3PhmGZ+9uBZe9aka0TTDvcuTPWhb874ZXw82QKq3idv0DFZetf9qdp/pXn7vwKA=;
Subject: Re: [PATCH v3 1/2] mt76: mt7615: enable support for mesh
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <a1ff446dfc06e2443552e7ec2d754099aacce7df.1559541944.git.ryder.lee@mediatek.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <a0a6f631-2eb1-87cc-5653-338c6126690c@newmedia-net.de>
Date:   Thu, 6 Jun 2019 12:14:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a1ff446dfc06e2443552e7ec2d754099aacce7df.1559541944.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [212.111.244.1] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1hYpQ1-0008Bc-SJ; Thu, 06 Jun 2019 12:14:49 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

in addition you should take care about this problem which is raised up 
if SAE is used. since AES-CMAC required tid to be non zero

WARNING: CPU: 2 PID: 15324 at 
/home/seg/DEV/mt7621/src/router/private/compat-wireless-2017-09-03/net/mac80211/key.c:1096 
mt76_wcid_key_setup+0x58/0x9c [mt76]
Modules linked in: shortcut_fe gcm ghash_generic ctr gf128mul mt7615e 
mt76 mac80211 compat
CPU: 2 PID: 15324 Comm: wpa_supplicant Tainted: G        W 4.14.123 #106
Stack : 00000000 87c2d000 00000000 8007d8b4 80480000 80482b9c 80610000 
805a4390
         8057e2b4 854fb99c 87ed045c 805e4767 80578288 00000001 854fb940 
805e9f78
         00000000 00000000 80640000 00000000 81147bb8 00000584 00000007 
00000000
         00000000 80650000 80650000 20202020 80000000 00000000 80610000 
872b9fe0
         872a2b14 00000448 00000000 87c2d000 00000010 8022d660 00000008 
80640008
         ...
Call Trace:
[<800153e0>] show_stack+0x58/0x100
[<8042e83c>] dump_stack+0x9c/0xe0
[<800349f0>] __warn+0xe4/0x144
[<8003468c>] warn_slowpath_null+0x1c/0x30
[<872b9fe0>] mt76_wcid_key_setup+0x58/0x9c [mt76]
[<87611690>] mt7615_eeprom_init+0x7b4/0xe9c [mt7615e]
---[ end trace e24aeb4b542e0dea ]---

Am 03.06.2019 um 08:08 schrieb Ryder Lee:
> Enable NL80211_IFTYPE_MESH_POINT and update its path.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Changes since v3 - fix a wrong expression
> Changes since v2 - remove unused definitions
> ---
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 4 +++-
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.h  | 6 ------
>   4 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> index 59f604f3161f..f860af6a42da 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -133,6 +133,9 @@ static const struct ieee80211_iface_limit if_limits[] = {
>   	{
>   		.max = MT7615_MAX_INTERFACES,
>   		.types = BIT(NL80211_IFTYPE_AP) |
> +#ifdef CONFIG_MAC80211_MESH
> +			 BIT(NL80211_IFTYPE_MESH_POINT) |
> +#endif
>   			 BIT(NL80211_IFTYPE_STATION)
>   	}
>   };
> @@ -195,6 +198,9 @@ int mt7615_register_device(struct mt7615_dev *dev)
>   	dev->mt76.antenna_mask = 0xf;
>   
>   	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
> +#ifdef CONFIG_MAC80211_MESH
> +				 BIT(NL80211_IFTYPE_MESH_POINT) |
> +#endif
>   				 BIT(NL80211_IFTYPE_AP);
>   
>   	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> index b0bb7cc12385..585e67fa2728 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> @@ -37,6 +37,7 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
>   
>   	switch (type) {
>   	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_MESH_POINT:
>   		/* ap use hw bssid 0 and ext bssid */
>   		if (~mask & BIT(HW_BSSID_0))
>   			return HW_BSSID_0;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> index 43f70195244c..e82297048449 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -754,6 +754,7 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
>   
>   	switch (vif->type) {
>   	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_MESH_POINT:
>   		tx_wlan_idx = mvif->sta.wcid.idx;
>   		conn_type = CONNECTION_INFRA_AP;
>   		break;
> @@ -968,7 +969,7 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
>   		.rx_wtbl = {
>   			.tag = cpu_to_le16(WTBL_RX),
>   			.len = cpu_to_le16(sizeof(struct wtbl_rx)),
> -			.rca1 = vif->type != NL80211_IFTYPE_AP,
> +			.rca1 = vif->type == NL80211_IFTYPE_STATION,
>   			.rca2 = 1,
>   			.rv = 1,
>   		},
> @@ -1042,6 +1043,7 @@ static void sta_rec_convert_vif_type(enum nl80211_iftype type, u32 *conn_type)
>   {
>   	switch (type) {
>   	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_MESH_POINT:
>   		if (conn_type)
>   			*conn_type = CONNECTION_INFRA_STA;
>   		break;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
> index e96efb13fa4d..0915cb735699 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
> @@ -105,25 +105,19 @@ enum {
>   #define STA_TYPE_STA		BIT(0)
>   #define STA_TYPE_AP		BIT(1)
>   #define STA_TYPE_ADHOC		BIT(2)
> -#define STA_TYPE_TDLS		BIT(3)
>   #define STA_TYPE_WDS		BIT(4)
>   #define STA_TYPE_BC		BIT(5)
>   
>   #define NETWORK_INFRA		BIT(16)
>   #define NETWORK_P2P		BIT(17)
>   #define NETWORK_IBSS		BIT(18)
> -#define NETWORK_MESH		BIT(19)
> -#define NETWORK_BOW		BIT(20)
>   #define NETWORK_WDS		BIT(21)
>   
>   #define CONNECTION_INFRA_STA	(STA_TYPE_STA | NETWORK_INFRA)
>   #define CONNECTION_INFRA_AP	(STA_TYPE_AP | NETWORK_INFRA)
>   #define CONNECTION_P2P_GC	(STA_TYPE_STA | NETWORK_P2P)
>   #define CONNECTION_P2P_GO	(STA_TYPE_AP | NETWORK_P2P)
> -#define CONNECTION_MESH_STA	(STA_TYPE_STA | NETWORK_MESH)
> -#define CONNECTION_MESH_AP	(STA_TYPE_AP | NETWORK_MESH)
>   #define CONNECTION_IBSS_ADHOC	(STA_TYPE_ADHOC | NETWORK_IBSS)
> -#define CONNECTION_TDLS		(STA_TYPE_STA | NETWORK_INFRA | STA_TYPE_TDLS)
>   #define CONNECTION_WDS		(STA_TYPE_WDS | NETWORK_WDS)
>   #define CONNECTION_INFRA_BC	(STA_TYPE_BC | NETWORK_INFRA)
>   
