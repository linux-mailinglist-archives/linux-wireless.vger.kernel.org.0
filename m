Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1F1C9AA4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 21:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEGTPB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 15:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTPB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 15:15:01 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA186208D6;
        Thu,  7 May 2020 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878900;
        bh=9XhMtvqi2aJhRaZgvQeop3m52+V471pk6YH+eynGWCA=;
        h=Date:From:To:Cc:Subject:From;
        b=ZhYyDv/WlRv4a2HOj6dxzW3nwSAsie64Lt+vDzJBg7Urkgtwd0bHr2Y7Cl4Ks4Fti
         /fRjLYe3bG57QyJQmpVThxrpUtvBPk5NsevZSKMljv4QB2OjBxbl79UWJFBD2AscrT
         jtZACVSJnF5a/NEYQhOacbuIXfzCXglJaZZil0ks=
Date:   Thu, 7 May 2020 14:19:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qtnfmac: Replace zero-length array with flexible-array
Message-ID: <20200507191926.GA15970@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/quantenna/qtnfmac/bus.h   |    2 
 drivers/net/wireless/quantenna/qtnfmac/qlink.h |   54 ++++++++++++-------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/bus.h b/drivers/net/wireless/quantenna/qtnfmac/bus.h
index 87d048df09d1..3334c45aac13 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/bus.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/bus.h
@@ -69,7 +69,7 @@ struct qtnf_bus {
 	struct notifier_block netdev_nb;
 	u8 hw_id[ETH_ALEN];
 	/* bus private data */
-	char bus_priv[0] __aligned(sizeof(void *));
+	char bus_priv[] __aligned(sizeof(void *));
 };
 
 static inline bool qtnf_fw_is_up(struct qtnf_bus *bus)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
index 4d22a54c034f..2dda4c5d7427 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -362,7 +362,7 @@ struct qlink_cmd {
 struct qlink_cmd_init_fw {
 	struct qlink_cmd chdr;
 	__le32 qlink_proto_ver;
-	u8 var_info[0];
+	u8 var_info[];
 } __packed;
 
 /**
@@ -434,7 +434,7 @@ struct qlink_cmd_frame_tx {
 	__le32 cookie;
 	__le16 freq;
 	__le16 flags;
-	u8 frame_data[0];
+	u8 frame_data[];
 } __packed;
 
 /**
@@ -466,7 +466,7 @@ struct qlink_cmd_add_key {
 	__le32 cipher;
 	__le16 vlanid;
 	u8 rsvd[2];
-	u8 key_data[0];
+	u8 key_data[];
 } __packed;
 
 /**
@@ -578,7 +578,7 @@ struct qlink_cmd_connect {
 	u8 mfp;
 	u8 pbss;
 	u8 rsvd[2];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 /**
@@ -592,7 +592,7 @@ struct qlink_cmd_external_auth {
 	struct qlink_cmd chdr;
 	u8 peer[ETH_ALEN];
 	__le16 status;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 /**
@@ -698,7 +698,7 @@ struct qlink_cmd_reg_notify {
 	u8 dfs_region;
 	u8 slave_radar;
 	u8 dfs_offload;
-	u8 info[0];
+	u8 info[];
 } __packed;
 
 /**
@@ -773,7 +773,7 @@ struct qlink_cmd_start_ap {
 	struct qlink_sr_params sr_params;
 	u8 twt_responder;
 	u8 rsvd[3];
-	u8 info[0];
+	u8 info[];
 } __packed;
 
 /**
@@ -807,7 +807,7 @@ struct qlink_mac_address {
 struct qlink_acl_data {
 	__le32 policy;
 	__le32 num_entries;
-	struct qlink_mac_address mac_addrs[0];
+	struct qlink_mac_address mac_addrs[];
 } __packed;
 
 /**
@@ -882,7 +882,7 @@ enum qlink_wowlan_trigger {
 struct qlink_cmd_wowlan_set {
 	struct qlink_cmd chdr;
 	__le32 triggers;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 enum qlink_ndev_event_type {
@@ -958,7 +958,7 @@ struct qlink_cmd_scan {
 	u8 bssid[ETH_ALEN];
 	u8 scan_width;
 	u8 rsvd[3];
-	u8 var_info[0];
+	u8 var_info[];
 } __packed;
 
 /**
@@ -972,7 +972,7 @@ struct qlink_cmd_update_owe {
 	struct qlink_cmd chdr;
 	u8 peer[ETH_ALEN];
 	__le16 status;
-	u8 ies[0];
+	u8 ies[];
 } __packed;
 
 /* QLINK Command Responses messages related definitions
@@ -1106,7 +1106,7 @@ struct qlink_resp_get_mac_info {
 	u8 n_reg_rules;
 	u8 dfs_region;
 	u8 rsvd[3];
-	u8 var_info[0];
+	u8 var_info[];
 } __packed;
 
 /**
@@ -1131,7 +1131,7 @@ struct qlink_resp_get_hw_info {
 	u8 mac_bitmap;
 	u8 total_tx_chain;
 	u8 total_rx_chain;
-	u8 info[0];
+	u8 info[];
 } __packed;
 
 /**
@@ -1167,7 +1167,7 @@ struct qlink_resp_get_sta_info {
 	struct qlink_resp rhdr;
 	u8 sta_addr[ETH_ALEN];
 	u8 rsvd[2];
-	u8 info[0];
+	u8 info[];
 } __packed;
 
 /**
@@ -1184,7 +1184,7 @@ struct qlink_resp_band_info_get {
 	u8 num_chans;
 	u8 num_bitrates;
 	u8 rsvd[1];
-	u8 info[0];
+	u8 info[];
 } __packed;
 
 /**
@@ -1196,7 +1196,7 @@ struct qlink_resp_band_info_get {
 struct qlink_resp_get_chan_stats {
 	struct qlink_resp rhdr;
 	__le32 chan_freq;
-	u8 info[0];
+	u8 info[];
 } __packed;
 
 /**
@@ -1270,7 +1270,7 @@ struct qlink_event_sta_assoc {
 	struct qlink_event ehdr;
 	u8 sta_addr[ETH_ALEN];
 	__le16 frame_control;
-	u8 ies[0];
+	u8 ies[];
 } __packed;
 
 /**
@@ -1297,7 +1297,7 @@ struct qlink_event_bss_join {
 	struct qlink_chandef chan;
 	u8 bssid[ETH_ALEN];
 	__le16 status;
-	u8 ies[0];
+	u8 ies[];
 } __packed;
 
 /**
@@ -1339,7 +1339,7 @@ struct qlink_event_rxmgmt {
 	__le32 flags;
 	s8 sig_dbm;
 	u8 rsvd[3];
-	u8 frame_data[0];
+	u8 frame_data[];
 } __packed;
 
 /**
@@ -1367,7 +1367,7 @@ struct qlink_event_scan_result {
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
 	u8 bssid[ETH_ALEN];
 	u8 rsvd[2];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 /**
@@ -1456,7 +1456,7 @@ struct qlink_event_update_owe {
 	struct qlink_event ehdr;
 	u8 peer[ETH_ALEN];
 	u8 rsvd[2];
-	u8 ies[0];
+	u8 ies[];
 } __packed;
 
 /* QLINK TLVs (Type-Length Values) definitions
@@ -1512,7 +1512,7 @@ enum qlink_tlv_id {
 struct qlink_tlv_hdr {
 	__le16 type;
 	__le16 len;
-	u8 val[0];
+	u8 val[];
 } __packed;
 
 struct qlink_iface_limit {
@@ -1524,7 +1524,7 @@ struct qlink_iface_limit_record {
 	__le16 max_interfaces;
 	u8 num_different_channels;
 	u8 n_limits;
-	struct qlink_iface_limit limits[0];
+	struct qlink_iface_limit limits[];
 } __packed;
 
 #define QLINK_RSSI_OFFSET	120
@@ -1647,7 +1647,7 @@ struct qlink_tlv_ie_set {
 	u8 type;
 	u8 flags;
 	u8 rsvd[2];
-	u8 ie_data[0];
+	u8 ie_data[];
 } __packed;
 
 /**
@@ -1660,7 +1660,7 @@ struct qlink_tlv_ext_ie {
 	struct qlink_tlv_hdr hdr;
 	u8 eid_ext;
 	u8 rsvd[3];
-	u8 ie_data[0];
+	u8 ie_data[];
 } __packed;
 
 #define IEEE80211_HE_PPE_THRES_MAX_LEN		25
@@ -1681,7 +1681,7 @@ struct qlink_tlv_iftype_data {
 	struct qlink_tlv_hdr hdr;
 	u8 n_iftype_data;
 	u8 rsvd[3];
-	struct qlink_sband_iftype_data iftype_data[0];
+	struct qlink_sband_iftype_data iftype_data[];
 } __packed;
 
 /**
@@ -1867,7 +1867,7 @@ struct qlink_random_mac_addr {
 struct qlink_wowlan_capab_data {
 	__le16 version;
 	__le16 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /**

