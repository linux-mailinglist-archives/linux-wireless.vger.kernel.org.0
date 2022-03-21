Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E04E2034
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 06:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbiCUFpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 01:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiCUFpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 01:45:17 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947393467E
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 22:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647841433; x=1679377433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oYhsCb8l5yI0e3B4DHROAet318X6YWn9Ofatkwp8gdQ=;
  b=fUFvBPb0UtqxWOLdYu4s0RoMCL0OhP6+AkCXgztQQlpevev+R2uw9hPK
   Wq19B3IuG8kYny+kiPfQqAwU+Dbc1NUShSocf4o7acnRD6qYMd3HlcWJj
   I0To8P10JJTffE9aSn6gKgoxAHmiz/kS1gd6iabhJGk+vb+8qhLk4yNlU
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Mar 2022 22:43:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 22:43:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 20 Mar 2022 22:43:53 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 20 Mar 2022 22:43:51 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 2/2] ath11k: add support to configure 6GHz non-ht duplicate transmission
Date:   Mon, 21 Mar 2022 11:13:15 +0530
Message-ID: <1647841395-20213-3-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647841395-20213-1-git-send-email-quic_ramess@quicinc.com>
References: <1647841395-20213-1-git-send-email-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A 6GHz AP can decide to transmit Beacon, Broadcast probe response
and FILS discovery frames in a non-HT duplicate PPDU when
operating in non 20MHz Bandwidth to enhance its discoverability.
(IEEE Std 802.11ax‐2021-26.17.2.2)

Send WMI_VDEV_PARAM_6GHZ_PARAMS with enable/disable option to FW
based on he_6g_nonht_dup_beacon_set.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 38 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  8 ++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07f499d..697e4dc 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2915,6 +2915,33 @@ static int ath11k_mac_fils_discovery(struct ath11k_vif *arvif,
 	return ret;
 }
 
+static int ath11k_mac_set_6g_nonht_dup_conf(struct ath11k_vif *arvif,
+					    const struct cfg80211_chan_def *chandef)
+{
+	struct ath11k *ar = arvif->ar;
+	int ret = 0;
+	bool is_nontx_ap = arvif->vif->bss_conf.nontransmitted;
+	enum wmi_phy_mode mode = ath11k_phymodes[chandef->chan->band][chandef->width];
+	bool dup_bcn_enable = arvif->vif->bss_conf.he_6g_nonht_dup_beacon_set;
+
+	if ((arvif->vdev_type == WMI_VDEV_TYPE_AP) && !is_nontx_ap &&
+	    (chandef->chan->band == NL80211_BAND_6GHZ)) {
+		u32 param_id = WMI_VDEV_PARAM_6GHZ_PARAMS;
+		u32 value = 0;
+
+		if (mode > MODE_11AX_HE20 && dup_bcn_enable) {
+			value |= WMI_VDEV_6GHZ_BITMAP_NON_HT_DUPLICATE_BEACON;
+			value |= WMI_VDEV_6GHZ_BITMAP_NON_HT_DUPLICATE_BCAST_PROBE_RSP;
+			value |= WMI_VDEV_6GHZ_BITMAP_NON_HT_DUPLICATE_FD_FRAME;
+		}
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "Set 6GHz non-ht dup params for "
+			   "vdev %pM vdev_id %d param %d value %d\n", arvif->vif->addr,
+			   arvif->vdev_id, param_id, value);
+		ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param_id, value);
+	}
+	return ret;
+}
+
 static int ath11k_mac_config_obss_pd(struct ath11k *ar,
 				     struct ieee80211_he_obss_pd *he_obss_pd)
 {
@@ -3128,6 +3155,17 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			arvif->do_not_send_tmpl = true;
 		else
 			arvif->do_not_send_tmpl = false;
+
+		if (vif->type == NL80211_IFTYPE_AP && vif->bss_conf.he_support) {
+			if (!ath11k_mac_vif_chan(arvif->vif, &def)) {
+				ret = ath11k_mac_set_6g_nonht_dup_conf(arvif, &def);
+				if (ret) {
+					ath11k_warn(ar->ab, "failed to set 6G non-ht dup"
+						    " conf for vdev %d: %d\n",
+						    arvif->vdev_id, ret);
+				}
+			}
+		}
 	}
 
 	if (changed & (BSS_CHANGED_BEACON_INFO | BSS_CHANGED_BEACON)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 2f26ec1a..96ed891 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2125,6 +2125,14 @@ enum {
 /* preablbe short */
 #define WMI_VDEV_PREAMBLE_SHORT         0x2
 
+/** 6GHZ params **/
+/* Control to enable/disable beacon tx in non-HT duplicate */
+#define WMI_VDEV_6GHZ_BITMAP_NON_HT_DUPLICATE_BEACON		BIT(0)
+/* Control to enable/disable broadcast probe response tx in non-HT duplicate */
+#define WMI_VDEV_6GHZ_BITMAP_NON_HT_DUPLICATE_BCAST_PROBE_RSP	BIT(1)
+/* Control to enable/disable FILS discovery frame tx in non-HT duplicate */
+#define WMI_VDEV_6GHZ_BITMAP_NON_HT_DUPLICATE_FD_FRAME		BIT(2)
+
 enum wmi_peer_smps_state {
 	WMI_PEER_SMPS_PS_NONE = 0x0,
 	WMI_PEER_SMPS_STATIC  = 0x1,
-- 
2.7.4

