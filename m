Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5535C4F202C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 01:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiDDXTm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243766AbiDDXTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 19:19:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC4100
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 16:16:04 -0700 (PDT)
X-UUID: efc2378dded64fe0b875356ca3df9f60-20220405
X-UUID: efc2378dded64fe0b875356ca3df9f60-20220405
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 294306073; Tue, 05 Apr 2022 07:15:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 5 Apr 2022 07:15:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Apr 2022 07:15:57 +0800
From:   <sean.wang@mediatek.com>
To:     <lorenzo.bianconi@redhat.com>
CC:     <nbd@nbd.name>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: Add hotspot mode support
Date:   Tue, 5 Apr 2022 07:15:56 +0800
Message-ID: <1649114156-5573-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <YksWqWcwmIHcttDv@lore-desk--annotate>
References: <YksWqWcwmIHcttDv@lore-desk--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> add hostspot mode support to mt7921 that can work for mt7921[e,s,u]
>> with the common code.
>>
>> Tested-by: Deren Wu <deren.wu@mediatek.com>

<snip>

>> +		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
>> +
>> +		mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
>> +					    true);
>> +		mt7921_mcu_sta_update(dev, NULL, vif, true,
>> +				      MT76_STA_INFO_STATE_NONE);
>> +	}
>> +
>> +	if (changed & (BSS_CHANGED_BEACON |
>> +		       BSS_CHANGED_BEACON_ENABLED)) {
>
>nit: we do not need brackets here.

thanks. will be fixed in v2.

>
>> +		mt7921_mcu_uni_add_beacon_offload(dev, hw, vif,
>> +						  info->enable_beacon);
>> +	}
>> +
>>	/* ensure that enable txcmd_mode after bss_info */
>>	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
>>		mt7921_mcu_set_tx(dev, vif);
>> @@ -1394,6 +1427,18 @@ static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
>>	return err;
>>  }
>>
>> +static void
>> +mt7921_channel_switch_beacon(struct ieee80211_hw *hw,
>> +			     struct ieee80211_vif *vif,
>> +			     struct cfg80211_chan_def *chandef) {
>> +	struct mt7921_dev *dev = mt7921_hw_dev(hw);
>> +
>> +	mt7921_mutex_acquire(dev);
>> +	mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
>> +	mt7921_mutex_release(dev);
>> +}
>> +
>>  const struct ieee80211_ops mt7921_ops = {
>>	.tx = mt7921_tx,
>>	.start = mt7921_start,
>> @@ -1412,6 +1457,7 @@ const struct ieee80211_ops mt7921_ops = {
>>	.set_rts_threshold = mt7921_set_rts_threshold,
>>	.wake_tx_queue = mt76_wake_tx_queue,
>>	.release_buffered_frames = mt76_release_buffered_frames,
>> +	.channel_switch_beacon = mt7921_channel_switch_beacon,
>>	.get_txpower = mt76_get_txpower,
>>	.get_stats = mt7921_get_stats,
>>	.get_et_sset_count = mt7921_get_et_sset_count, diff --git
>> a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
>> index da2be050ed7c..1ecbbe4fa498 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
>> @@ -248,7 +248,8 @@ mt7921_mcu_connection_loss_iter(void *priv, u8 *mac,
>>	if (mvif->idx != event->bss_idx)
>>		return;
>>
>> -	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
>> +	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER) ||
>> +	    vif->type != NL80211_IFTYPE_STATION)
>>		return;
>>
>>	ieee80211_connection_loss(vif);
>> @@ -1166,3 +1167,79 @@ int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
>>	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
>>				 true);
>>  }
>> +
>> +int
>> +mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
>> +				  struct ieee80211_hw *hw,
>> +				  struct ieee80211_vif *vif,
>> +				  bool enable)
>> +{
>> +	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
>> +	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
>> +	struct ieee80211_mutable_offsets offs;
>> +	struct {
>> +		struct req_hdr {
>> +			u8 bss_idx;
>> +			u8 pad[3];
>> +		} __packed hdr;
>> +		struct bcn_content_tlv {
>> +			__le16 tag;
>> +			__le16 len;
>> +			__le16 tim_ie_pos;
>> +			__le16 csa_ie_pos;
>> +			__le16 bcc_ie_pos;
>
>does the fw support bcc IE? if so I guess we introduce support for it here, right?

bcc IE cannot be supported by the ap mode in mt7921 fw

>
>Regards,
>Lorenzo
>
>> +			/* 0: disable beacon offload
>> +			 * 1: enable beacon offload
>> +			 * 2: update probe respond offload
>> +			 */
>> +			u8 enable;
>> +			/* 0: legacy format (TXD + payload)
>> +			 * 1: only cap field IE
>> +			 */
>> +			u8 type;
>> +			__le16 pkt_len;
>> +			u8 pkt[512];
>> +		} __packed beacon_tlv;
>> +	} req = {
>> +		.hdr = {
>> +			.bss_idx = mvif->mt76.idx,
>> +		},
>> +		.beacon_tlv = {
>> +			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
>> +			.len = cpu_to_le16(sizeof(struct bcn_content_tlv)),
>> +			.enable = enable,
>> +		},
>> +	};
>> +	struct sk_buff *skb;
>> +
>> +	if (!enable)
>> +		goto out;
>> +
>> +	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs);
>> +	if (!skb)
>> +		return -EINVAL;
>> +
>> +	if (skb->len > 512 - MT_TXD_SIZE) {
>> +		dev_err(dev->mt76.dev, "beacon size limit exceed\n");
>> +		dev_kfree_skb(skb);
>> +		return -EINVAL;
>> +	}
>> +
>> +	mt7921_mac_write_txwi(dev, (__le32 *)(req.beacon_tlv.pkt), skb,
>> +			      wcid, NULL, 0, true);
>> +	memcpy(req.beacon_tlv.pkt + MT_TXD_SIZE, skb->data, skb->len);
>> +	req.beacon_tlv.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
>> +	req.beacon_tlv.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE +
>> +offs.tim_offset);
>> +
>> +	if (offs.cntdwn_counter_offs[0]) {
>> +		u16 csa_offs;
>> +
>> +		csa_offs = MT_TXD_SIZE + offs.cntdwn_counter_offs[0] - 4;
>> +		req.beacon_tlv.csa_ie_pos = cpu_to_le16(csa_offs);
>> +	}
>> +	dev_kfree_skb(skb);
>> +
>> +out:
>> +	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
>> +				 &req, sizeof(req), true);
>> +}
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>> b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>> index eae223a31000..adbdb2e22934 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>> @@ -469,4 +469,8 @@ int mt7921u_wfsys_reset(struct mt7921_dev *dev);
>> int mt7921u_dma_init(struct mt7921_dev *dev, bool resume);  int
>> mt7921u_init_reset(struct mt7921_dev *dev);  int
>> mt7921u_mac_reset(struct mt7921_dev *dev);
>> +int mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
>> +				      struct ieee80211_hw *hw,
>> +				      struct ieee80211_vif *vif,
>> +				      bool enable);
>>  #endif
>> --
>> 2.25.1
>>
>
