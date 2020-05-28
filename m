Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA301E647E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgE1Ouc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbgE1Ou3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:50:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8650EC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:50:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJrW-004vYI-5l; Thu, 28 May 2020 16:50:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Tova Mussai <tova.mussai@intel.com>
Subject: [PATCH 03/24] ieee80211: definitions for reduced neighbor reports
Date:   Thu, 28 May 2020 16:49:59 +0200
Message-Id: <20200528165011.4f9154461c06.I518d9898ad982f838112ea9ca14a20d6bbb16394@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

Add the necessary definitions to parse reduced neighbor
report elements.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
[change struct name, remove IEEE80211_MIN_AP_NEIGHBOR_INFO_SIZE]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 0320ca4c7d28..c29184bf9416 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2754,6 +2754,8 @@ enum ieee80211_eid {
 	WLAN_EID_QUIET_CHANNEL = 198,
 	WLAN_EID_OPMODE_NOTIF = 199,
 
+	WLAN_EID_REDUCED_NEIGHBOR_REPORT = 201,
+
 	WLAN_EID_S1G_BCN_COMPAT = 213,
 	WLAN_EID_S1G_SHORT_BCN_INTERVAL = 214,
 	WLAN_EID_S1G_CAPABILITIES = 217,
@@ -3675,4 +3677,30 @@ static inline bool for_each_element_completed(const struct element *element,
 #define WLAN_RSNX_CAPA_PROTECTED_TWT BIT(4)
 #define WLAN_RSNX_CAPA_SAE_H2E BIT(5)
 
+/*
+ * reduced neighbor report, based on Draft P802.11ax_D5.0,
+ * section 9.4.2.170
+ */
+#define IEEE80211_AP_INFO_TBTT_HDR_TYPE				0x03
+#define IEEE80211_AP_INFO_TBTT_HDR_FILTERED			0x04
+#define IEEE80211_AP_INFO_TBTT_HDR_COLOC			0x08
+#define IEEE80211_AP_INFO_TBTT_HDR_COUNT			0xF0
+#define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		8
+#define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	12
+
+#define IEEE80211_RNR_TBTT_PARAMS_OCT_RECOMMENDED		0x01
+#define IEEE80211_RNR_TBTT_PARAMS_SAME_SSID			0x02
+#define IEEE80211_RNR_TBTT_PARAMS_MULTI_BSSID			0x04
+#define IEEE80211_RNR_TBTT_PARAMS_TRANSMITTED_BSSID		0x08
+#define IEEE80211_RNR_TBTT_PARAMS_COLOC_ESS			0x10
+#define IEEE80211_RNR_TBTT_PARAMS_PROBE_ACTIVE			0x20
+#define IEEE80211_RNR_TBTT_PARAMS_COLOC_AP			0x40
+
+struct ieee80211_neighbor_ap_info {
+       u8 tbtt_info_hdr;
+       u8 tbtt_info_len;
+       u8 op_class;
+       u8 channel;
+} __packed;
+
 #endif /* LINUX_IEEE80211_H */
-- 
2.26.2

