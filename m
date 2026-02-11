Return-Path: <linux-wireless+bounces-31750-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD4zEQgTjWl/ygAAu9opvQ
	(envelope-from <linux-wireless+bounces-31750-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 00:38:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E438B128558
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 00:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D389830281CB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 23:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A93254B9;
	Wed, 11 Feb 2026 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMhz3t41"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109A26E702
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853121; cv=none; b=Ic5LMs0XCDZEZF/92n/fZKqbOKC8p2Pfhdd8KRz/l3m7R19FO1IbB6ILQVZ6XTS6McNo5pHjrq2XsSJh7RANecoKCTsAELFIuNBrhLoc17MEiaHhULwPbj14+TyK8mlxD270uIvPKj0z1BhsCyrtX5BOop5mZT5GidkHHL8I2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853121; c=relaxed/simple;
	bh=4jTbSxZzNpRvJyhZmPNiPdYfMrJ6GIEd9wv8G0Qpd44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TG9WYL5U6wjpckbrse0eHTSyaNR53OBcsZMJZT6I3ji45jjx+PddCQ+xltfOV4gKwED9ZmqbA8J3M9koUAMo1bo1LYuAnLMXq6zKyvLHsQFgHd2e97t5xf1q3P77I2CYF+L685upjoAtgnwMKpLdprtV/O7U0ZtrcBTbK8hC/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMhz3t41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CE3C4CEF7;
	Wed, 11 Feb 2026 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770853121;
	bh=4jTbSxZzNpRvJyhZmPNiPdYfMrJ6GIEd9wv8G0Qpd44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JMhz3t411aZw1o0RHm1vPLtquyB36ebyPU0SmGaU5t5GUYiPiodL/O48aA4FPqXTc
	 IimPJrYr4xHrRMPGhGhoDaJCU9F/yzViQyfvttoCb1npoBFn3sJNpOJXQX9fIOVN8l
	 5a9sCSE4ikBA9dz3hPWbl2DnU7kdDZ4YwK++T0cxyPFt8XWgm+2I2fb3sT8qZqHcgh
	 1OYQ5YERZ5PZ9xVP1+3EDLP3sMDtsyiHr0h71+dgrKkUpai9CIQ+FJazBEsQ2Hzter
	 9Jec6gCBiDfreWq6biAtP13ysy//Hk6yqxDWIAVWKL5FqzTMXrdo69NhY/oe53Yb6N
	 6j4wCySuloqmA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 12 Feb 2026 00:38:12 +0100
Subject: [PATCH RFC 2/2] wifi: mt76: mt7996: Add beacon_reconf IE parsing
 support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-mt7996-link-reconf-v1-2-2b110340d6c4@kernel.org>
References: <20260212-mt7996-link-reconf-v1-0-2b110340d6c4@kernel.org>
In-Reply-To: <20260212-mt7996-link-reconf-v1-0-2b110340d6c4@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>, 
 Ping-Ke Shih <pkshih@realtek.com>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31750-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,nbd.name,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E438B128558
X-Rspamd-Action: no action

From: Shayne Chen <shayne.chen@mediatek.com>

Implement the capability to offload the countdown for MLO link
reconfiguration IE sent by the AP MLD if the specified link is going
to be removed.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   5 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 185 +++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  69 +++++++-
 4 files changed, 260 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f44977f9093da76a9f5e2b4d7ce147de28c5b18e..669f20d57d591a092afbb33bc58f4b63e82ae9b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1067,6 +1067,7 @@ enum {
 	MCU_UNI_EVENT_WED_RRO = 0x57,
 	MCU_UNI_EVENT_PER_STA_INFO = 0x6d,
 	MCU_UNI_EVENT_ALL_STA_INFO = 0x6e,
+	MCU_UNI_EVENT_MLD = 0x81,
 	MCU_UNI_EVENT_SDO = 0x83,
 };
 
@@ -1309,6 +1310,8 @@ enum {
 	MCU_UNI_CMD_ALL_STA_INFO = 0x6e,
 	MCU_UNI_CMD_ASSERT_DUMP = 0x6f,
 	MCU_UNI_CMD_RADIO_STATUS = 0x80,
+	MCU_UNI_CMD_MLD = 0x82,
+	MCU_UNI_CMD_PEER_MLD = 0x83,
 	MCU_UNI_CMD_SDO = 0x88,
 };
 
@@ -1384,6 +1387,8 @@ enum {
 	UNI_BSS_INFO_MLD = 26,
 	UNI_BSS_INFO_PM_DISABLE = 27,
 	UNI_BSS_INFO_EHT = 30,
+	UNI_BSS_INFO_MLD_LINK_OP = 36,
+	UNI_BSS_INFO_BCN_ML_RECONF = 38,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 2937e89ad0c9c489274cfa4f6aeb694fb4456bd1..bf084cd434304e1afd3c3f8bbe726740f4d19f52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -507,7 +507,8 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 
 	wiphy->reg_notifier = mt7996_regd_notifier;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
-			WIPHY_FLAG_SUPPORTS_MLO;
+			WIPHY_FLAG_SUPPORTS_MLO |
+			WIPHY_FLAG_MLO_RECONF_ADV_OFFLOAD;
 	wiphy->mbssid_max_interfaces = 16;
 	wiphy->iftype_ext_capab = iftypes_ext_capa;
 	wiphy->num_iftype_ext_capab = ARRAY_SIZE(iftypes_ext_capa);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8e1c8e1d6a99f093a2b7d7dc3a0c56f3a4bc220b..310a580028a8e3532923fa82d65739b008dc58af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -816,6 +816,50 @@ mt7996_mcu_wed_rro_event(struct mt7996_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static void
+mt7996_mcu_mld_reconf_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7996_mld_event_data *data = priv;
+	struct mt7996_mcu_mld_ap_reconf_event *reconf = (void *)data->data;
+
+	if (!ether_addr_equal(vif->addr, data->mld_addr))
+		return;
+
+	ieee80211_mlo_reconf_complete_notify(vif,
+					     le16_to_cpu(reconf->link_bitmap));
+}
+
+static void
+mt7996_mcu_mld_event(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt7996_mcu_mld_event *e = (void *)skb->data;
+	struct mt7996_mld_event_data data = {};
+	struct tlv *tlv;
+	int len;
+
+	memcpy(data.mld_addr, e->mld_addr, ETH_ALEN);
+	skb_pull(skb, sizeof(*e));
+	tlv = (struct tlv *)skb->data;
+	len = skb->len;
+
+	while (len > 0 && le16_to_cpu(tlv->len) <= len) {
+		data.data = (u8 *)tlv;
+
+		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_MLD_RECONF_AP_REM_TIMER:
+			ieee80211_iterate_active_interfaces_atomic(
+				dev->mt76.hw, IEEE80211_IFACE_ITER_RESUME_ALL,
+				mt7996_mcu_mld_reconf_finish, &data);
+			break;
+		default:
+			break;
+		}
+
+		len -= le16_to_cpu(tlv->len);
+		tlv = (struct tlv *)((u8 *)tlv + le16_to_cpu(tlv->len));
+	}
+}
+
 static void
 mt7996_mcu_uni_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
 {
@@ -837,6 +881,9 @@ mt7996_mcu_uni_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
 	case MCU_UNI_EVENT_WED_RRO:
 		mt7996_mcu_wed_rro_event(dev, skb);
 		break;
+	case MCU_UNI_EVENT_MLD:
+		mt7996_mcu_mld_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -2863,6 +2910,142 @@ mt7996_mcu_beacon_cntdwn(struct sk_buff *rskb, struct sk_buff *skb,
 	}
 }
 
+static int
+mt7996_mcu_mld_reconf(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		      u16 removed_links, u16 *removal_count)
+{
+	struct mld_req_hdr hdr = { .mld_idx = 0xff };
+	unsigned long rem = removed_links;
+	struct mld_reconf_timer *rt;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	u8 link_id;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(hdr) + sizeof(*rt));
+	if (!skb)
+		return -ENOMEM;
+
+	memcpy(hdr.mld_addr, vif->addr, ETH_ALEN);
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_CMD_MLD_RECONF_AP_REM_TIMER,
+				     sizeof(*rt));
+	rt = (struct mld_reconf_timer *)tlv;
+	rt->link_bitmap = cpu_to_le16(removed_links);
+
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf;
+		struct mt7996_vif_link *link;
+		u8 band_idx;
+		u16 to_sec;
+
+		link_conf = link_conf_dereference_protected(vif, link_id);
+		if (!link_conf)
+			continue;
+
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
+
+		to_sec = link_conf->beacon_int * removal_count[link_id] / 1000;
+		band_idx = link->phy->mt76->band_idx;
+		rt->to_sec[band_idx] = cpu_to_le16(to_sec);
+		rt->bss_idx[band_idx] = link->mt76.idx;
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_WM_UNI_CMD(MLD), true);
+}
+
+static void
+mt7996_mcu_beacon_ml_reconf(struct mt7996_dev *dev,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct sk_buff *rskb, struct sk_buff *skb,
+			    struct ieee80211_mutable_offsets *offs)
+{
+	u16 tail_offset = offs->tim_offset + offs->tim_length;
+	u16 removal_count[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	u16 removal_offs[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	u8 link_id, *beacon_tail = skb->data + tail_offset;
+	struct bss_bcn_ml_reconf_offset *reconf_offs;
+	struct bss_bcn_ml_reconf_tlv *reconf;
+	const struct element *elem, *sub;
+	unsigned long removed_links = 0;
+	bool has_reconf = false;
+	struct tlv *tlv;
+
+	/* TODO: currently manually parse reconf info directly from the IE, it
+	 * is expected to be passed from upper layer in the future.
+	 */
+	for_each_element_extid(elem, WLAN_EID_EXT_EHT_MULTI_LINK, beacon_tail,
+			       skb->len - tail_offset) {
+		if (ieee80211_mle_type_ok(elem->data + 1,
+					  IEEE80211_ML_CONTROL_TYPE_RECONF,
+					  elem->datalen - 1)) {
+			has_reconf = true;
+			break;
+		}
+	}
+
+	if (!has_reconf)
+		return;
+
+	for_each_mle_subelement(sub, elem->data + 1, elem->datalen - 1) {
+		struct ieee80211_mle_per_sta_profile *prof = (void *)sub->data;
+		u8 *pos = prof->variable;
+		u16 control;
+
+		if (sub->id != IEEE80211_MLE_SUBELEM_PER_STA_PROFILE)
+			continue;
+
+		if (!ieee80211_mle_reconf_sta_prof_size_ok(sub->data,
+							   sub->datalen))
+			return;
+
+		control = le16_to_cpu(prof->control);
+		link_id = control & IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID;
+		removed_links |= BIT(link_id);
+
+		if (control &
+		    IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT)
+			pos += 6;
+
+		if (control &
+		    IEEE80211_MLE_STA_RECONF_CONTROL_AP_REM_TIMER_PRESENT) {
+			removal_offs[link_id] = pos - skb->data;
+			removal_count[link_id] = le16_to_cpu(*(__le16 *)pos);
+		}
+	}
+
+	if (!removed_links)
+		return;
+
+	/* the first link to be removed */
+	if (link_conf->link_id == __ffs(removed_links))
+		mt7996_mcu_mld_reconf(dev, link_conf->vif, removed_links,
+				      removal_count);
+
+	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_ML_RECONF,
+				     sizeof(*reconf) +
+				     sizeof(*reconf_offs) * hweight16(removed_links));
+	reconf = (struct bss_bcn_ml_reconf_tlv *)tlv;
+	reconf->reconf_count = hweight16(removed_links);
+
+	reconf_offs = (struct bss_bcn_ml_reconf_offset *)reconf->offset;
+	for_each_set_bit(link_id, &removed_links,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt7996_vif_link *link;
+
+		link = mt7996_vif_link(dev, link_conf->vif, link_id);
+		if (!link)
+			continue;
+
+		reconf_offs->ap_removal_timer_offs =
+			cpu_to_le16(removal_offs[link_id]);
+		reconf_offs->bss_idx = link->mt76.idx;
+		reconf_offs++;
+	}
+}
+
 static void
 mt7996_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
 		       struct bss_bcn_content_tlv *bcn,
@@ -3006,6 +3189,8 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (link_conf->bssid_indicator)
 		mt7996_mcu_beacon_mbss(rskb, skb, bcn, &offs);
 	mt7996_mcu_beacon_cntdwn(rskb, skb, &offs, link_conf->csa_active);
+	if (ieee80211_vif_is_mld(link_conf->vif))
+		mt7996_mcu_beacon_ml_reconf(dev, link_conf, rskb, skb, &offs);
 out:
 	dev_kfree_skb(skb);
 	return mt76_mcu_skb_send_msg(&dev->mt76, rskb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index d9fb49f7b01b6cca2fd7a0e760c1d2b1b74eab5b..bb98194b98879ed7039791b3990019cbd43f120b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -487,6 +487,20 @@ struct bss_prot_tlv {
 	__le32 prot_mode;
 } __packed;
 
+struct bss_bcn_ml_reconf_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 reconf_count;
+	u8 rsv[3];
+	u8 offset[];
+} __packed;
+
+struct bss_bcn_ml_reconf_offset {
+	__le16 ap_removal_timer_offs;
+	u8 bss_idx;
+	u8 rsv;
+} __packed;
+
 struct sta_rec_ht_uni {
 	__le16 tag;
 	__le16 len;
@@ -660,6 +674,57 @@ struct mld_setup_link {
 	u8 __rsv;
 } __packed;
 
+struct mld_req_hdr {
+	u8 ver;
+	u8 mld_addr[ETH_ALEN];
+	u8 mld_idx;
+	u8 flag;
+	u8 rsv[3];
+	u8 buf[];
+} __packed;
+
+struct mld_reconf_timer {
+	__le16 tag;
+	__le16 len;
+	__le16 link_bitmap;
+	__le16 to_sec[__MT_MAX_BAND]; /* timeout of reconf (second) */
+	u8 bss_idx[__MT_MAX_BAND];
+	u8 rsv;
+} __packed;
+
+enum {
+	UNI_CMD_MLD_RECONF_AP_REM_TIMER = 0x03,
+	UNI_CMD_MLD_RECONF_STOP_LINK = 0x04,
+};
+
+struct mt7996_mcu_mld_event {
+	struct mt7996_mcu_rxd rxd;
+	/* fixed field */
+	u8 ver;
+	u8 mld_addr[ETH_ALEN];
+	u8 mld_idx;
+	u8 rsv[4];
+	/* tlv */
+	u8 buf[];
+} __packed;
+
+struct mt7996_mld_event_data {
+	u8 mld_addr[ETH_ALEN];
+	u8 *data;
+};
+
+struct mt7996_mcu_mld_ap_reconf_event {
+	__le16 tag;
+	__le16 len;
+	__le16 link_bitmap;
+	u8 bss_idx[3];
+	u8 rsv[3];
+} __packed;
+
+enum {
+	UNI_EVENT_MLD_RECONF_AP_REM_TIMER = 0x04,
+};
+
 struct hdr_trans_en {
 	__le16 tag;
 	__le16 len;
@@ -847,7 +912,9 @@ enum {
 					 sizeof(struct bss_bcn_content_tlv) +	\
 					 4 + MT_TXD_SIZE +			\
 					 sizeof(struct bss_bcn_cntdwn_tlv) +	\
-					 sizeof(struct bss_bcn_mbss_tlv))
+					 sizeof(struct bss_bcn_mbss_tlv) +	\
+					 sizeof(struct bss_bcn_ml_reconf_tlv) +	\
+					 3 * sizeof(struct bss_bcn_ml_reconf_offset))
 #define MT7996_MAX_BSS_OFFLOAD_SIZE	2048
 #define MT7996_MAX_BEACON_SIZE		(MT7996_MAX_BSS_OFFLOAD_SIZE - \
 					 MT7996_BEACON_UPDATE_SIZE)

-- 
2.53.0


