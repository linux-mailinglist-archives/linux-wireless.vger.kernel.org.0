Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5576B7B1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHAOgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjHAOf5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:35:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33851702
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:35:55 -0700 (PDT)
X-UUID: b27c5358307811eeb20a276fd37b9834-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zu93bIQIr1/O6IBg0G4dVvepgRjodHZuPm8l4mdlcR0=;
        b=adrEmGPG3DgRb7NBYquh8sLDVB0rAACzzBAbDoenzLE9F1+3cbePZSp97oT4aaG8NwuOX9k7aokOmvJmyD2tFNXF6+Xt45kmJXeYL1hBLL1N9nM1xdj6vNx2cPiZqxU1MxR5JKbTziqO9+PGMMmwmpuxDqiOvyXCwro36M25Edw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:493c134f-647d-4e39-a9f8-b5c393cacb5b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:4672b242-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b27c5358307811eeb20a276fd37b9834-20230801
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 681983824; Tue, 01 Aug 2023 22:35:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:35:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:35:43 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 06/17] wifi: mt76: mt7925: add mcu.h
Date:   Tue, 1 Aug 2023 22:34:22 +0800
Message-ID: <108b1cf79bba36fab37b388b8432aa8d633066bd.1690864199.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690864199.git.deren.wu@mediatek.com>
References: <cover.1690864199.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 537 ++++++++++++++++++
 1 file changed, 537 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
new file mode 100644
index 000000000000..3c41e21303b1
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -0,0 +1,537 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef __MT7925_MCU_H
+#define __MT7925_MCU_H
+
+#include "../mt76_connac_mcu.h"
+
+/* ext event table */
+enum {
+	MCU_EXT_EVENT_RATE_REPORT = 0x87,
+};
+
+struct mt7925_mcu_eeprom_info {
+	__le32 addr;
+	__le32 valid;
+	u8 data[MT7925_EEPROM_BLOCK_SIZE];
+} __packed;
+
+#define MT_RA_RATE_NSS			GENMASK(8, 6)
+#define MT_RA_RATE_MCS			GENMASK(3, 0)
+#define MT_RA_RATE_TX_MODE		GENMASK(12, 9)
+#define MT_RA_RATE_DCM_EN		BIT(4)
+#define MT_RA_RATE_BW			GENMASK(14, 13)
+
+struct mt7925_mcu_rxd {
+	__le32 rxd[8];
+
+	__le16 len;
+	__le16 pkt_type_id;
+
+	u8 eid;
+	u8 seq;
+	u8 option;
+	u8 __rsv;
+
+	u8 ext_eid;
+	u8 __rsv1[2];
+	u8 s2d_index;
+
+	u8 tlv[];
+};
+
+struct mt7925_mcu_uni_event {
+	u8 cid;
+	u8 pad[3];
+	__le32 status; /* 0: success, others: fail */
+} __packed;
+
+enum {
+	MT_EBF = BIT(0),	/* explicit beamforming */
+	MT_IBF = BIT(1)		/* implicit beamforming */
+};
+
+struct mt7925_mcu_reg_event {
+	__le32 reg;
+	__le32 val;
+} __packed;
+
+struct mt7925_mcu_ant_id_config {
+	u8 ant_id[4];
+} __packed;
+
+struct mt7925_txpwr_req {
+	u8 _rsv[4];
+	__le16 tag;
+	__le16 len;
+
+	u8 format_id;
+	u8 catg;
+	u8 band_idx;
+	u8 _rsv1;
+} __packed;
+
+struct mt7925_txpwr_event {
+	u8 rsv[4];
+	__le16 tag;
+	__le16 len;
+
+	u8 catg;
+	u8 band_idx;
+	u8 ch_band;
+	u8 format; /* 0:Legacy, 1:HE */
+
+	/* Rate power info */
+	struct mt7925_txpwr txpwr;
+
+	s8 pwr_max;
+	s8 pwr_min;
+	u8 rsv1;
+} __packed;
+
+enum {
+	TM_SWITCH_MODE,
+	TM_SET_AT_CMD,
+	TM_QUERY_AT_CMD,
+};
+
+enum {
+	MT7925_TM_NORMAL,
+	MT7925_TM_TESTMODE,
+	MT7925_TM_ICAP,
+	MT7925_TM_ICAP_OVERLAP,
+	MT7925_TM_WIFISPECTRUM,
+};
+
+struct mt7925_rftest_cmd {
+	u8 action;
+	u8 rsv[3];
+	__le32 param0;
+	__le32 param1;
+} __packed;
+
+struct mt7925_rftest_evt {
+	__le32 param0;
+	__le32 param1;
+} __packed;
+
+enum {
+	UNI_CHANNEL_SWITCH,
+	UNI_CHANNEL_RX_PATH,
+};
+
+enum {
+	UNI_CHIP_CONFIG_CHIP_CFG = 0x2,
+	UNI_CHIP_CONFIG_NIC_CAPA = 0x3,
+};
+
+enum {
+	UNI_BAND_CONFIG_RADIO_ENABLE,
+	UNI_BAND_CONFIG_RTS_THRESHOLD = 0x08,
+	UNI_BAND_CONFIG_SET_MAC80211_RX_FILTER = 0x0C,
+};
+
+enum {
+	UNI_WSYS_CONFIG_FW_LOG_CTRL,
+	UNI_WSYS_CONFIG_FW_DBG_CTRL,
+};
+
+enum {
+	UNI_EFUSE_ACCESS = 1,
+	UNI_EFUSE_BUFFER_MODE,
+	UNI_EFUSE_FREE_BLOCK,
+	UNI_EFUSE_BUFFER_RD,
+};
+
+enum {
+	UNI_CMD_ACCESS_REG_BASIC = 0x0,
+	UNI_CMD_ACCESS_RF_REG_BASIC,
+};
+
+enum {
+	UNI_MBMC_SETTING,
+};
+
+enum {
+	UNI_EVENT_SCAN_DONE_BASIC = 0,
+	UNI_EVENT_SCAN_DONE_CHNLINFO = 2,
+	UNI_EVENT_SCAN_DONE_NLO = 3,
+};
+
+struct mt7925_mcu_scan_chinfo_event {
+	u8 nr_chan;
+	u8 alpha2[3];
+} __packed;
+
+enum {
+	UNI_SCAN_REQ = 1,
+	UNI_SCAN_CANCEL = 2,
+	UNI_SCAN_SCHED_REQ = 3,
+	UNI_SCAN_SCHED_ENABLE = 4,
+	UNI_SCAN_SSID = 10,
+	UNI_SCAN_BSSID,
+	UNI_SCAN_CHANNEL,
+	UNI_SCAN_IE,
+	UNI_SCAN_MISC,
+	UNI_SCAN_SSID_MATCH_SETS,
+};
+
+enum {
+	UNI_SNIFFER_ENABLE,
+	UNI_SNIFFER_CONFIG,
+};
+
+struct scan_hdr_tlv {
+	/* fixed field */
+	u8 seq_num;
+	u8 bss_idx;
+	u8 pad[2];
+	/* tlv */
+	u8 data[];
+} __packed;
+
+struct scan_req_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 scan_type; /* 0: PASSIVE SCAN
+		       * 1: ACTIVE SCAN
+		       */
+	u8 probe_req_num; /* Number of probe request for each SSID */
+	u8 scan_func; /* BIT(0) Enable random MAC scan
+		       * BIT(1) Disable DBDC scan type 1~3.
+		       * BIT(2) Use DBDC scan type 3 (dedicated one RF to scan).
+		       */
+	u8 src_mask;
+	__le16 channel_min_dwell_time;
+	__le16 channel_dwell_time; /* channel Dwell interval */
+	__le16 timeout_value;
+	__le16 probe_delay_time;
+	u8 func_mask_ext;
+};
+
+struct scan_ssid_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 ssid_type; /* BIT(0) wildcard SSID
+		       * BIT(1) P2P wildcard SSID
+		       * BIT(2) specified SSID + wildcard SSID
+		       * BIT(2) + ssid_type_ext BIT(0) specified SSID only
+		       */
+	u8 ssids_num;
+	u8 pad[2];
+	struct mt76_connac_mcu_scan_ssid ssids[4];
+};
+
+struct scan_bssid_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 bssid[ETH_ALEN];
+	u8 match_ch;
+	u8 match_ssid_ind;
+	u8 rcpi;
+	u8 pad[3];
+};
+
+struct scan_chan_info_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 channel_type; /* 0: Full channels
+			  * 1: Only 2.4GHz channels
+			  * 2: Only 5GHz channels
+			  * 3: P2P social channel only (channel #1, #6 and #11)
+			  * 4: Specified channels
+			  * Others: Reserved
+			  */
+	u8 channels_num; /* valid when channel_type is 4 */
+	u8 pad[2];
+	struct mt76_connac_mcu_scan_channel channels[64];
+};
+
+struct scan_ie_tlv {
+	__le16 tag;
+	__le16 len;
+
+	__le16 ies_len;
+	u8 band;
+	u8 pad;
+	u8 ies[MT76_CONNAC_SCAN_IE_LEN];
+};
+
+struct scan_misc_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 random_mac[ETH_ALEN];
+	u8 rsv[2];
+};
+
+struct scan_sched_req {
+	__le16 tag;
+	__le16 len;
+
+	u8 version;
+	u8 stop_on_match;
+	u8 intervals_num;
+	u8 scan_func;
+	__le16 intervals[MT76_CONNAC_MAX_NUM_SCHED_SCAN_INTERVAL];
+};
+
+struct scan_sched_ssid_match_sets {
+	__le16 tag;
+	__le16 len;
+
+	u8 match_num;
+	u8 rsv[3];
+
+	struct mt76_connac_mcu_scan_match match[MT76_CONNAC_MAX_SCAN_MATCH];
+};
+
+struct scan_sched_enable {
+	__le16 tag;
+	__le16 len;
+
+	u8 active;
+	u8 rsv[3];
+};
+
+struct mbmc_set_req {
+	u8 pad[4];
+	u8 data[];
+} __packed;
+
+struct mbmc_conf_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 mbmc_en;
+	u8 band;
+	u8 pad[2];
+} __packed;
+
+struct edca {
+	__le16 tag;
+	__le16 len;
+
+	u8 queue;
+	u8 set;
+	u8 cw_min;
+	u8 cw_max;
+	__le16 txop;
+	u8 aifs;
+	u8 __rsv;
+};
+
+struct bss_req_hdr {
+	u8 bss_idx;
+	u8 __rsv[3];
+} __packed;
+
+struct bss_rate_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 __rsv1[4];
+	__le16 bc_trans;
+	__le16 mc_trans;
+	u8 short_preamble;
+	u8 bc_fixed_rate;
+	u8 mc_fixed_rate;
+	u8 __rsv2;
+} __packed;
+
+struct bss_mld_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 group_mld_id;
+	u8 own_mld_id;
+	u8 mac_addr[ETH_ALEN];
+	u8 remap_idx;
+	u8 link_id;
+	u8 __rsv[2];
+} __packed;
+
+struct sta_rec_ba_uni {
+	__le16 tag;
+	__le16 len;
+	u8 tid;
+	u8 ba_type;
+	u8 amsdu;
+	u8 ba_en;
+	__le16 ssn;
+	__le16 winsize;
+	u8 ba_rdd_rro;
+	u8 __rsv[3];
+} __packed;
+
+struct sta_rec_eht {
+	__le16 tag;
+	__le16 len;
+	u8 tid_bitmap;
+	u8 _rsv;
+	__le16 mac_cap;
+	__le64 phy_cap;
+	__le64 phy_cap_ext;
+	u8 mcs_map_bw20[4];
+	u8 mcs_map_bw80[3];
+	u8 mcs_map_bw160[3];
+	u8 mcs_map_bw320[3];
+	u8 _rsv2[3];
+} __packed;
+
+struct sec_key_uni {
+	__le16 wlan_idx;
+	u8 mgmt_prot;
+	u8 cipher_id;
+	u8 cipher_len;
+	u8 key_id;
+	u8 key_len;
+	u8 need_resp;
+	u8 key[32];
+} __packed;
+
+struct sta_rec_sec_uni {
+	__le16 tag;
+	__le16 len;
+	u8 add;
+	u8 n_cipher;
+	u8 rsv[2];
+
+	struct sec_key_uni key[2];
+} __packed;
+
+struct sta_rec_hdr_trans {
+	__le16 tag;
+	__le16 len;
+	u8 from_ds;
+	u8 to_ds;
+	u8 dis_rx_hdr_tran;
+	u8 rsv;
+} __packed;
+
+struct sta_rec_mld {
+	__le16 tag;
+	__le16 len;
+	u8 mac_addr[ETH_ALEN];
+	__le16 primary_id;
+	__le16 secondary_id;
+	__le16 wlan_id;
+	u8 link_num;
+	u8 rsv[3];
+	struct {
+		__le16 wlan_id;
+		u8 bss_idx;
+		u8 rsv;
+	} __packed link[2];
+} __packed;
+
+#define MT7925_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +		\
+					 sizeof(struct sta_rec_basic) +		\
+					 sizeof(struct sta_rec_bf) +		\
+					 sizeof(struct sta_rec_ht) +		\
+					 sizeof(struct sta_rec_he_v2) +		\
+					 sizeof(struct sta_rec_ba_uni) +	\
+					 sizeof(struct sta_rec_vht) +		\
+					 sizeof(struct sta_rec_uapsd) +		\
+					 sizeof(struct sta_rec_amsdu) +		\
+					 sizeof(struct sta_rec_bfee) +		\
+					 sizeof(struct sta_rec_phy) +		\
+					 sizeof(struct sta_rec_ra) +		\
+					 sizeof(struct sta_rec_sec) +		\
+					 sizeof(struct sta_rec_ra_fixed) +	\
+					 sizeof(struct sta_rec_he_6g_capa) +	\
+					 sizeof(struct sta_rec_eht) +		\
+					 sizeof(struct sta_rec_hdr_trans) +	\
+					 sizeof(struct sta_rec_mld) +		\
+					 sizeof(struct tlv))
+
+#define MT7925_BSS_UPDATE_MAX_SIZE	(sizeof(struct bss_req_hdr) +		\
+					 sizeof(struct mt76_connac_bss_basic_tlv) +	\
+					 sizeof(struct mt76_connac_bss_qos_tlv) +	\
+					 sizeof(struct bss_rate_tlv) +			\
+					 sizeof(struct bss_mld_tlv) +			\
+					 sizeof(struct bss_info_uni_he) +		\
+					 sizeof(struct bss_info_uni_bss_color) +	\
+					 sizeof(struct tlv))
+
+#define MT_CONNAC3_SKU_POWER_LIMIT      449
+struct mt7925_sku_tlv {
+	u8 channel;
+	s8 pwr_limit[MT_CONNAC3_SKU_POWER_LIMIT];
+} __packed;
+
+struct mt7925_tx_power_limit_tlv {
+	u8 rsv[4];
+
+	__le16 tag;
+	__le16 len;
+
+	/* DW0 - common info*/
+	u8 ver;
+	u8 pad0;
+	__le16 rsv1;
+	/* DW1 - cmd hint */
+	u8 n_chan; /* # channel */
+	u8 band; /* 2.4GHz - 5GHz - 6GHz */
+	u8 last_msg;
+	u8 limit_type;
+	/* DW3 */
+	u8 alpha2[4]; /* regulatory_request.alpha2 */
+	u8 pad2[32];
+
+	u8 data[];
+} __packed;
+
+struct mt7925_arpns_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 enable;
+	u8 ips_num;
+	u8 rsv[2];
+} __packed;
+
+struct mt7925_wow_pattern_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 bss_idx;
+	u8 index; /* pattern index */
+	u8 enable; /* 0: disable
+		    * 1: enable
+		    */
+	u8 data_len; /* pattern length */
+	u8 offset;
+	u8 mask[MT76_CONNAC_WOW_MASK_MAX_LEN];
+	u8 pattern[MT76_CONNAC_WOW_PATTEN_MAX_LEN];
+	u8 rsv[4];
+} __packed;
+
+int mt7925_mcu_set_dbdc(struct mt76_phy *phy);
+int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req);
+int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
+			      struct ieee80211_vif *vif);
+int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_sched_scan_request *sreq);
+int mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable);
+int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
+			    struct ieee80211_chanctx_conf *ctx,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    int enable);
+int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable);
+int mt7925_mcu_set_channel_domain(struct mt76_phy *phy);
+int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable);
+int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+			 struct ieee80211_chanctx_conf *ctx);
+int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy);
+int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
+				 struct mt76_vif *vif,
+				 struct ieee80211_bss_conf *info);
+#endif
-- 
2.18.0

