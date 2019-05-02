Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843A811177
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 04:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfEBC14 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 22:27:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38576 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726183AbfEBC14 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 22:27:56 -0400
X-UUID: ad54b050aeb2478fb8a69c80944006d0-20190502
X-UUID: ad54b050aeb2478fb8a69c80944006d0-20190502
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1936304678; Thu, 02 May 2019 10:27:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 May 2019 10:27:43 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 May 2019 10:27:42 +0800
Message-ID: <1556764062.12176.2.camel@mtkswgap22>
Subject: Re: [RFC 12/17] mt7615: mcu: do not use function pointer whenever
 possible
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <linux-wireless@vger.kernel.org>, <royluo@google.com>
Date:   Thu, 2 May 2019 10:27:42 +0800
In-Reply-To: <0feb5dd8f162e2c8bdb8629b6c8cac96e3f3b515.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
         <0feb5dd8f162e2c8bdb8629b6c8cac96e3f3b515.1556726268.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-05-01 at 18:07 +0200, Lorenzo Bianconi wrote:
> Remove function pointer in mt7615_mcu_set_bss_info and run function
> directly. Moreover remove __mt7615_mcu_set_bss_info since it is run just
> by mt7615_mcu_set_bss_info and remove duplicated istructions
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 220 +++++++++---------
>  1 file changed, 105 insertions(+), 115 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> index c90ae77db22b..b3fb3d731129 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -676,154 +676,107 @@ int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
>  	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE);
>  }
>  
> -static void bss_info_omac_handler (struct mt7615_dev *dev,
> -				   struct bss_info *bss_info,
> -				   struct sk_buff *skb)
> +static void
> +mt7615_mcu_bss_info_omac_header(struct mt7615_vif *mvif, u8 *data,
> +				u32 conn_type)
>  {
> -	struct bss_info_omac tlv = {0};
> -
> -	tlv.tag = cpu_to_le16(BSS_INFO_OMAC);
> -	tlv.len = cpu_to_le16(sizeof(tlv));
> -	tlv.hw_bss_idx = (bss_info->omac_idx > EXT_BSSID_START) ?
> -			 HW_BSSID_0 : bss_info->omac_idx;
> -	tlv.omac_idx = bss_info->omac_idx;
> -	tlv.band_idx = bss_info->band_idx;
> -	tlv.conn_type = cpu_to_le32(bss_info->conn_type);
> -
> -	memcpy(skb_put(skb, sizeof(tlv)), &tlv, sizeof(tlv));
> +	struct bss_info_omac *hdr = (struct bss_info_omac *)data;
> +	u8 idx;
> +
> +	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
> +	hdr->tag = cpu_to_le16(BSS_INFO_OMAC);
> +	hdr->len = cpu_to_le16(sizeof(struct bss_info_omac));
> +	hdr->hw_bss_idx = idx;
> +	hdr->omac_idx = mvif->omac_idx;
> +	hdr->band_idx = mvif->band_idx;
> +	hdr->conn_type = cpu_to_le32(conn_type);
>  }
>  
> -static void bss_info_basic_handler (struct mt7615_dev *dev,
> -				    struct bss_info *bss_info,
> -				    struct sk_buff *skb)
> +static void
> +mt7615_mcu_bss_info_basic_header(struct ieee80211_vif *vif, u8 *data,
> +				 u32 net_type, u8 tx_wlan_idx,
> +				 bool enable)
>  {
> -	struct bss_info_basic tlv = {0};
> -
> -	tlv.tag = cpu_to_le16(BSS_INFO_BASIC);
> -	tlv.len = cpu_to_le16(sizeof(tlv));
> -	tlv.network_type = cpu_to_le32(bss_info->network_type);
> -	tlv.active = bss_info->enable;
> -	tlv.bcn_interval = cpu_to_le16(bss_info->bcn_interval);
> -	memcpy(tlv.bssid, bss_info->bssid, ETH_ALEN);
> -	tlv.wmm_idx = bss_info->wmm_idx;
> -	tlv.dtim_period = bss_info->dtim_period;
> -	tlv.bmc_tx_wlan_idx = bss_info->bmc_tx_wlan_idx;
> -
> -	memcpy(skb_put(skb, sizeof(tlv)), &tlv, sizeof(tlv));
> +	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
> +	struct bss_info_basic *hdr = (struct bss_info_basic *)data;
> +
> +	hdr->tag = cpu_to_le16(BSS_INFO_BASIC);
> +	hdr->len = cpu_to_le16(sizeof(struct bss_info_basic));
> +	hdr->network_type = cpu_to_le32(net_type);

If I read this patch correctly, it seems nobody sets the net_type?

> +	hdr->active = enable;
> +	hdr->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
> +	memcpy(hdr->bssid, vif->bss_conf.bssid, ETH_ALEN);
> +	hdr->wmm_idx = mvif->wmm_idx;
> +	hdr->dtim_period = vif->bss_conf.dtim_period;
> +	hdr->bmc_tx_wlan_idx = tx_wlan_idx;
>  }
>  
> -static void bss_info_ext_bss_handler (struct mt7615_dev *dev,
> -				      struct bss_info *bss_info,
> -				      struct sk_buff *skb)
> +static void
> +mt7615_mcu_bss_info_ext_header(struct mt7615_vif *mvif, u8 *data)
>  {
>  /* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
>  #define BCN_TX_ESTIMATE_TIME (4096 + 20)
> -	struct bss_info_ext_bss tlv = {0};
> +	struct bss_info_ext_bss *hdr = (struct bss_info_ext_bss *)data;
>  	int ext_bss_idx;
>  
> -	ext_bss_idx = bss_info->omac_idx - EXT_BSSID_START;
> -
> +	ext_bss_idx = mvif->omac_idx - EXT_BSSID_START;
>  	if (ext_bss_idx < 0)
>  		return;
>  
> -	tlv.tag = cpu_to_le16(BSS_INFO_EXT_BSS);
> -	tlv.len = cpu_to_le16(sizeof(tlv));
> -	tlv.mbss_tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
> -
> -	memcpy(skb_put(skb, sizeof(tlv)), &tlv, sizeof(tlv));
> +	hdr->tag = cpu_to_le16(BSS_INFO_EXT_BSS);
> +	hdr->len = cpu_to_le16(sizeof(struct bss_info_ext_bss));
> +	hdr->mbss_tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
>  }
>  
> -static struct bss_info_tag_handler bss_info_tag_handler[] = {
> -	{BSS_INFO_OMAC, sizeof(struct bss_info_omac), bss_info_omac_handler},
> -	{BSS_INFO_BASIC, sizeof(struct bss_info_basic), bss_info_basic_handler},
> -	{BSS_INFO_RF_CH, sizeof(struct bss_info_rf_ch), NULL},
> -	{BSS_INFO_PM, 0, NULL},
> -	{BSS_INFO_UAPSD, 0, NULL},
> -	{BSS_INFO_ROAM_DETECTION, 0, NULL},
> -	{BSS_INFO_LQ_RM, 0, NULL},
> -	{BSS_INFO_EXT_BSS, sizeof(struct bss_info_ext_bss), bss_info_ext_bss_handler},
> -	{BSS_INFO_BMC_INFO, 0, NULL},
> -	{BSS_INFO_SYNC_MODE, 0, NULL},
> -	{BSS_INFO_RA, 0, NULL},
> -	{BSS_INFO_MAX_NUM, 0, NULL},
> -};
> -
> -static int __mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> -				     struct bss_info *bss_info)
> +int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> +			    struct ieee80211_vif *vif, int en)
>  {
> +	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
>  	struct req_hdr {
>  		u8 bss_idx;
>  		u8 rsv0;
>  		__le16 tlv_num;
>  		u8 is_tlv_append;
>  		u8 rsv1[3];
> -	} __packed req_hdr = {0};
> +	} __packed;
> +	int len = sizeof(struct req_hdr) + sizeof(struct bss_info_basic);
> +	int ret, i, features = BIT(BSS_INFO_BASIC), ntlv = 1;
> +	u32 conn_type = NETWORK_INFRA, net_type = 0;
> +	u8 *buf, *data, tx_wlan_idx = 0;
> +	struct req_hdr *hdr;
>  	struct sk_buff *skb;
> -	u16 tlv_num = 0;
> -	u32 size = 0;
> -	int i;
>  
> -	for (i = 0; i < BSS_INFO_MAX_NUM; i++)
> -		if ((BIT(bss_info_tag_handler[i].tag) & bss_info->feature) &&
> -		    bss_info_tag_handler[i].handler) {
> -			tlv_num++;
> -			size += bss_info_tag_handler[i].len;
> +	if (en) {
> +		len += sizeof(struct bss_info_omac);
> +		features |= BIT(BSS_INFO_OMAC);
> +		if (mvif->omac_idx > EXT_BSSID_START) {
> +			len += sizeof(struct bss_info_ext_bss);
> +			features |= BIT(BSS_INFO_EXT_BSS);
> +			ntlv++;
>  		}
> -
> -	skb = mt7615_mcu_msg_alloc(NULL, sizeof(req_hdr) + size);
> -
> -	req_hdr.bss_idx = bss_info->bss_idx;
> -	req_hdr.tlv_num = cpu_to_le16(tlv_num);
> -	req_hdr.is_tlv_append = tlv_num ? 1 : 0;
> -
> -	memcpy(skb_put(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
> -
> -	for (i = 0; i < BSS_INFO_MAX_NUM; i++)
> -		if ((BIT(bss_info_tag_handler[i].tag) & bss_info->feature) &&
> -		    bss_info_tag_handler[i].handler)
> -			bss_info_tag_handler[i].handler(dev, bss_info, skb);
> -
> -	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE);
> -}
> -
> -int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> -			    struct ieee80211_vif *vif, int en)
> -{
> -	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
> -	struct bss_info bss_info = {
> -		.bss_idx = mvif->idx,
> -		.omac_idx = mvif->omac_idx,
> -		.band_idx = mvif->band_idx,
> -		.bcn_interval = vif->bss_conf.beacon_int,
> -		.dtim_period = vif->bss_conf.dtim_period,
> -		.enable = en,
> -		.feature = BIT(BSS_INFO_BASIC),
> -		.wmm_idx = mvif->wmm_idx,
> -	};
> +		ntlv++;
> +	}
>  
>  	switch (vif->type) {
>  	case NL80211_IFTYPE_AP:
> -		bss_info.bmc_tx_wlan_idx = mvif->sta.wcid.idx;
> -		bss_info.network_type = NETWORK_INFRA;
> -		bss_info.conn_type = CONNECTION_INFRA_AP;
> +		tx_wlan_idx = mvif->sta.wcid.idx;
> +		conn_type = CONNECTION_INFRA_AP;
>  		break;
>  	case NL80211_IFTYPE_STATION: {
> -		/* find the unicast entry for sta mode bmc tx */
> -		struct ieee80211_sta *ap_sta;
> +		struct ieee80211_sta *sta;
>  		struct mt7615_sta *msta;
>  
>  		rcu_read_lock();
>  
> -		ap_sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
> -		if (!ap_sta) {
> +		sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
> +		if (!sta) {
>  			rcu_read_unlock();
>  			return -EINVAL;
>  		}
>  
> -		msta = (struct mt7615_sta *)ap_sta->drv_priv;
> -		bss_info.bmc_tx_wlan_idx = msta->wcid.idx;
> -		bss_info.network_type = NETWORK_INFRA;
> -		bss_info.conn_type = CONNECTION_INFRA_STA;
> +		msta = (struct mt7615_sta *)sta->drv_priv;
> +		tx_wlan_idx = msta->wcid.idx;
> +		conn_type = CONNECTION_INFRA_STA;
>  
>  		rcu_read_unlock();
>  		break;
> @@ -832,15 +785,52 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
>  		WARN_ON(1);
>  		break;
>  	}
> -	memcpy(bss_info.bssid, vif->bss_conf.bssid, ETH_ALEN);
>  
> -	if (en) {
> -		bss_info.feature |= BIT(BSS_INFO_OMAC);
> -		if (mvif->omac_idx > EXT_BSSID_START)
> -			bss_info.feature |= BIT(BSS_INFO_EXT_BSS);
> +	buf = kzalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	hdr = (struct req_hdr *)buf;
> +	hdr->bss_idx = mvif->idx;
> +	hdr->tlv_num = cpu_to_le16(ntlv);
> +	hdr->is_tlv_append = 1;
> +
> +	data = buf + sizeof(*hdr);
> +	for (i = 0; i < BSS_INFO_MAX_NUM; i++) {
> +		int tag = ffs(features & BIT(i)) - 1;
> +
> +		switch (tag) {
> +		case BSS_INFO_OMAC:
> +			mt7615_mcu_bss_info_omac_header(mvif, data,
> +							conn_type);
> +			data += sizeof(struct bss_info_omac);
> +			break;
> +		case BSS_INFO_BASIC:
> +			mt7615_mcu_bss_info_basic_header(vif, data, net_type,
> +							 tx_wlan_idx, en);
> +			data += sizeof(struct bss_info_basic);
> +			break;
> +		case BSS_INFO_EXT_BSS:
> +			mt7615_mcu_bss_info_ext_header(mvif, data);
> +			data += sizeof(struct bss_info_ext_bss);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	skb = mt7615_mcu_msg_alloc(buf, len);
> +	if (!skb) {
> +		ret = -ENOMEM;
> +		goto out;
>  	}
>  
> -	return __mt7615_mcu_set_bss_info(dev, &bss_info);
> +	ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE);
> +
> +out:
> +	kfree(buf);
> +
> +	return ret;
>  }
>  
>  static int


