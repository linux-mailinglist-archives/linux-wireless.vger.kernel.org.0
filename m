Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB72F759E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 10:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhAOJj2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 04:39:28 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46283 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbhAOJj1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 04:39:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ULo2AUV_1610703515;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULo2AUV_1610703515)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Jan 2021 17:38:41 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     amitkarwar@gmail.com
Cc:     ganapathi.bhat@nxp.com, huxinming820@gmail.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] marvell/mwifiex: replace one-element array with flexible-array member.
Date:   Fri, 15 Jan 2021 17:38:33 +0800
Message-Id: <1610703513-933-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the follow coccicheck warnings:

./drivers/net/wireless/marvell/mwifiex/fw.h: WARNING use flexible-array
member instead(https://www.kernel.org/doc/html/latest/process/
deprecated.html#zero-length-and-one-element-arrays)

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/net/wireless/marvell/mwifiex/fw.h | 40 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 470d669..a9cb209 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -53,7 +53,7 @@ struct mwifiex_fw_header {
 struct mwifiex_fw_data {
 	struct mwifiex_fw_header header;
 	__le32 seq_num;
-	u8 data[1];
+	u8 data[];
 } __packed;
 
 struct mwifiex_fw_dump_header {
@@ -653,7 +653,7 @@ struct mwifiex_ie_types_header {
 
 struct mwifiex_ie_types_data {
 	struct mwifiex_ie_types_header header;
-	u8 data[1];
+	u8 data[];
 } __packed;
 
 #define MWIFIEX_TxPD_POWER_MGMT_NULL_PACKET 0x01
@@ -781,7 +781,7 @@ struct mwifiex_chan_scan_param_set {
 
 struct mwifiex_ie_types_chan_list_param_set {
 	struct mwifiex_ie_types_header header;
-	struct mwifiex_chan_scan_param_set chan_scan_param[1];
+	struct mwifiex_chan_scan_param_set chan_scan_param[];
 } __packed;
 
 struct mwifiex_ie_types_rxba_sync {
@@ -791,7 +791,7 @@ struct mwifiex_ie_types_rxba_sync {
 	u8 reserved;
 	__le16 seq_num;
 	__le16 bitmap_len;
-	u8 bitmap[1];
+	u8 bitmap[];
 } __packed;
 
 struct chan_band_param_set {
@@ -801,17 +801,17 @@ struct chan_band_param_set {
 
 struct mwifiex_ie_types_chan_band_list_param_set {
 	struct mwifiex_ie_types_header header;
-	struct chan_band_param_set chan_band_param[1];
+	struct chan_band_param_set chan_band_param[];
 } __packed;
 
 struct mwifiex_ie_types_rates_param_set {
 	struct mwifiex_ie_types_header header;
-	u8 rates[1];
+	u8 rates[];
 } __packed;
 
 struct mwifiex_ie_types_ssid_param_set {
 	struct mwifiex_ie_types_header header;
-	u8 ssid[1];
+	u8 ssid[];
 } __packed;
 
 struct mwifiex_ie_types_num_probes {
@@ -853,13 +853,13 @@ struct mwifiex_ietypes_chanstats {
 struct mwifiex_ie_types_wildcard_ssid_params {
 	struct mwifiex_ie_types_header header;
 	u8 max_ssid_length;
-	u8 ssid[1];
+	u8 ssid[];
 } __packed;
 
 #define TSF_DATA_SIZE            8
 struct mwifiex_ie_types_tsf_timestamp {
 	struct mwifiex_ie_types_header header;
-	u8 tsf_data[1];
+	u8 tsf_data[];
 } __packed;
 
 struct mwifiex_cf_param_set {
@@ -919,7 +919,7 @@ struct mwifiex_ie_types_tdls_idle_timeout {
 
 struct mwifiex_ie_types_rsn_param_set {
 	struct mwifiex_ie_types_header header;
-	u8 rsn_ie[1];
+	u8 rsn_ie[];
 } __packed;
 
 #define KEYPARAMSET_FIXED_LEN 6
@@ -1343,7 +1343,7 @@ struct host_cmd_ds_802_11_snmp_mib {
 	__le16 query_type;
 	__le16 oid;
 	__le16 buf_size;
-	u8 value[1];
+	u8 value[];
 } __packed;
 
 struct mwifiex_rate_scope {
@@ -1440,7 +1440,7 @@ struct mwifiex_tdls_stop_cs_params {
 
 struct host_cmd_ds_tdls_config {
 	__le16 tdls_action;
-	u8 tdls_data[1];
+	u8 tdls_data[];
 } __packed;
 
 struct mwifiex_chan_desc {
@@ -1511,7 +1511,7 @@ struct mwifiex_scan_cmd_config {
 	 *  TLV_TYPE_CHANLIST, mwifiex_ie_types_chan_list_param_set
 	 *  WLAN_EID_SSID, mwifiex_ie_types_ssid_param_set
 	 */
-	u8 tlv_buf[1];	/* SSID TLV(s) and ChanList TLVs are stored
+	u8 tlv_buf[];	/* SSID TLV(s) and ChanList TLVs are stored
 				   here */
 } __packed;
 
@@ -1581,18 +1581,18 @@ struct ie_body {
 struct host_cmd_ds_802_11_scan {
 	u8 bss_mode;
 	u8 bssid[ETH_ALEN];
-	u8 tlv_buffer[1];
+	u8 tlv_buffer[];
 } __packed;
 
 struct host_cmd_ds_802_11_scan_rsp {
 	__le16 bss_descript_size;
 	u8 number_of_sets;
-	u8 bss_desc_and_tlv_buffer[1];
+	u8 bss_desc_and_tlv_buffer[];
 } __packed;
 
 struct host_cmd_ds_802_11_scan_ext {
 	u32   reserved;
-	u8    tlv_buffer[1];
+	u8    tlv_buffer[];
 } __packed;
 
 struct mwifiex_ie_types_bss_mode {
@@ -1603,7 +1603,7 @@ struct mwifiex_ie_types_bss_mode {
 struct mwifiex_ie_types_bss_scan_rsp {
 	struct mwifiex_ie_types_header header;
 	u8 bssid[ETH_ALEN];
-	u8 frame_body[1];
+	u8 frame_body[];
 } __packed;
 
 struct mwifiex_ie_types_bss_scan_info {
@@ -1643,7 +1643,7 @@ struct host_cmd_ds_802_11_bg_scan_query_rsp {
 struct mwifiex_ietypes_domain_param_set {
 	struct mwifiex_ie_types_header header;
 	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
-	struct ieee80211_country_ie_triplet triplet[1];
+	struct ieee80211_country_ie_triplet triplet[];
 } __packed;
 
 struct host_cmd_ds_802_11d_domain_info {
@@ -1740,7 +1740,7 @@ struct mwifiex_ie_types_local_pwr_constraint {
 
 struct mwifiex_ie_types_wmm_param_set {
 	struct mwifiex_ie_types_header header;
-	u8 wmm_ie[1];
+	u8 wmm_ie[];
 } __packed;
 
 struct mwifiex_ie_types_mgmt_frame {
@@ -1966,7 +1966,7 @@ struct host_cmd_tlv_wep_key {
 	struct mwifiex_ie_types_header header;
 	u8 key_index;
 	u8 is_default;
-	u8 key[1];
+	u8 key[];
 };
 
 struct host_cmd_tlv_auth_type {
-- 
1.8.3.1

