Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA35C530AFB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 10:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiEWHqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 03:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiEWHqk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 03:46:40 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E828183B9
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291998; x=1684827998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+q0WXzxSQbtArcEIo1rVm0eVyYhPsRQcHJbnG4aVD2A=;
  b=HaHKOAGGSLmPmGgPxSp1Vc5VyBytxVfsQ255KTwczKrzNiNbXVO0U4MP
   2OlNgejqOwTAF23Njl0ep+FzSgjJPUkmbXVqDNqSiHjI7NENTJieiMeoG
   uP571DPNlrWQZTLr5lC0PeV+UPQyP2LX5KZyTqpwQnxxCfhFTciYdgK5I
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 May 2022 23:01:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 23:01:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:27 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:27 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 5/9] ath11k: create a structure for WMI vdev up parameters
Date:   Sun, 22 May 2022 23:01:04 -0700
Message-ID: <20220523060108.23982-6-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523060108.23982-1-quic_alokad@quicinc.com>
References: <20220523060108.23982-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include an instance of the structure instead of individual parameters
as input to ath11k_wmi_vdev_up().

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 31 +++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/wmi.c | 15 +++++++------
 drivers/net/wireless/ath/ath11k/wmi.h | 16 ++++++++++----
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8f629e54a53d..32ddb80f4cec 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -920,6 +920,7 @@ static int ath11k_mac_monitor_vdev_start(struct ath11k *ar, int vdev_id,
 	struct ieee80211_channel *channel;
 	struct wmi_vdev_start_req_arg arg = {};
 	int ret;
+	struct vdev_up_params params = { 0 };
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -960,7 +961,9 @@ static int ath11k_mac_monitor_vdev_start(struct ath11k *ar, int vdev_id,
 		return ret;
 	}
 
-	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	params.vdev_id = vdev_id,
+	params.bssid = ar->mac_addr,
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -1419,6 +1422,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 {
 	struct ath11k *ar = arvif->ar;
 	int ret = 0;
+	struct vdev_up_params params = { 0 };
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
 
@@ -1446,8 +1450,10 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
-	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-				 arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.aid = arvif->aid;
+	params.bssid = arvif->bssid;
+	ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
 			    arvif->vdev_id, ret);
@@ -2704,6 +2710,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	struct ath11k_peer *peer;
 	bool is_auth = false;
 	int ret;
+	struct vdev_up_params params = { 0 };
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -2752,7 +2759,10 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	arvif->aid = bss_conf->aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
-	ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.aid = arvif->aid;
+	params.bssid = arvif->bssid;
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set vdev %d up: %d\n",
 			    arvif->vdev_id, ret);
@@ -6956,6 +6966,8 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 	/* TODO: Update ar->rx_channel */
 
 	for (i = 0; i < n_vifs; i++) {
+		struct vdev_up_params params = { 0 };
+
 		arvif = (void *)vifs[i].vif->drv_priv;
 
 		if (WARN_ON(!arvif->is_started))
@@ -6996,8 +7008,10 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
-		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-					 arvif->bssid);
+		params.vdev_id = arvif->vdev_id;
+		params.aid = arvif->aid;
+		params.bssid = arvif->bssid;
+		ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath11k_warn(ab, "failed to bring vdev up %d: %d\n",
 				    arvif->vdev_id, ret);
@@ -7089,6 +7103,7 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	int ret;
+	struct vdev_up_params params = { 0 };
 
 	if (WARN_ON(arvif->is_started))
 		return -EBUSY;
@@ -7115,7 +7130,9 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	}
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
-		ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, 0, ar->mac_addr);
+		params.vdev_id = arvif->vdev_id,
+		params.bssid = ar->mac_addr,
+		ret = ath11k_wmi_vdev_up(ar, &params);
 		if (ret) {
 			ath11k_warn(ab, "failed put monitor up: %d\n", ret);
 			return ret;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d0716f6208b2..fa443a2646b5 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -996,7 +996,7 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	return ret;
 }
 
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
@@ -1011,10 +1011,13 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_VDEV_UP_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
-	cmd->vdev_id = vdev_id;
-	cmd->vdev_assoc_id = aid;
-
-	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
+	cmd->vdev_id = params->vdev_id;
+	cmd->vdev_assoc_id = params->aid;
+	ether_addr_copy(cmd->vdev_bssid.addr, params->bssid);
+	cmd->profile_idx = params->profile_idx;
+	cmd->profile_count = params->profile_count;
+	if (params->tx_bssid)
+		ether_addr_copy(cmd->tx_vdev_bssid.addr, params->tx_bssid);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_VDEV_UP_CMDID);
 	if (ret) {
@@ -1024,7 +1027,7 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
 		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
-		   vdev_id, aid, bssid);
+		   params->vdev_id, params->aid, params->bssid);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index c572774b9659..fa46fb6ef1ad 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2611,14 +2611,23 @@ struct wmi_vdev_delete_cmd {
 	u32 vdev_id;
 } __packed;
 
+struct vdev_up_params {
+	u32 vdev_id;
+	u16 aid;
+	const u8 *bssid;
+	u32 profile_idx;
+	u32 profile_count;
+	u8 *tx_bssid;
+};
+
 struct wmi_vdev_up_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
 	u32 vdev_assoc_id;
 	struct wmi_mac_addr vdev_bssid;
-	struct wmi_mac_addr trans_bssid;
+	struct wmi_mac_addr tx_vdev_bssid;
 	u32 profile_idx;
-	u32 profile_num;
+	u32 profile_count;
 } __packed;
 
 struct wmi_vdev_stop_cmd {
@@ -5998,8 +6007,7 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid,
-		       const u8 *bssid);
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params);
 int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart);
-- 
2.31.1

