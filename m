Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653641E6B16
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406635AbgE1Te7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406624AbgE1Tez (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:34:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AAEC08C5CA
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:34:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeOIn-0054OL-Pr; Thu, 28 May 2020 21:34:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 05/24] ieee80211: add HE ext EIDs and 6 GHz capability defines
Date:   Thu, 28 May 2020 21:34:28 +0200
Message-Id: <20200528213443.1a6689fe093f.Ifdc5400fb01779351354daf38663ebeea03c9ad9@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add the HE extended element IDs and the definitions for the
HE 6 GHz band capabilities element, from Draft 5.0.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2bd9e757167d..9580dfd9e2d1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2839,9 +2839,19 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_UORA = 37,
 	WLAN_EID_EXT_HE_MU_EDCA = 38,
 	WLAN_EID_EXT_HE_SPR = 39,
+	WLAN_EID_EXT_NDP_FEEDBACK_REPORT_PARAMSET = 41,
+	WLAN_EID_EXT_BSS_COLOR_CHG_ANN = 42,
+	WLAN_EID_EXT_QUIET_TIME_PERIOD_SETUP = 43,
+	WLAN_EID_EXT_ESS_REPORT = 45,
+	WLAN_EID_EXT_OPS = 46,
+	WLAN_EID_EXT_HE_BSS_LOAD = 47,
 	WLAN_EID_EXT_MAX_CHANNEL_SWITCH_TIME = 52,
 	WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION = 55,
 	WLAN_EID_EXT_NON_INHERITANCE = 56,
+	WLAN_EID_EXT_KNOWN_BSSID = 57,
+	WLAN_EID_EXT_SHORT_SSID_LIST = 58,
+	WLAN_EID_EXT_HE_6GHZ_CAPA = 59,
+	WLAN_EID_EXT_UL_MU_POWER_CAPA = 60,
 };
 
 /* Action category code */
@@ -3384,6 +3394,24 @@ struct ieee80211_tspec_ie {
 	__le16 medium_time;
 } __packed;
 
+struct ieee80211_he_6ghz_capa {
+	/* uses IEEE80211_HE_6GHZ_CAP_* below */
+	__le16 capa;
+} __packed;
+
+/* HE 6 GHz band capabilities */
+/* uses enum ieee80211_min_mpdu_spacing values */
+#define IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START	0x0007
+/* uses enum ieee80211_vht_max_ampdu_length_exp values */
+#define IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP	0x0038
+/* uses IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_* values */
+#define IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN	0x00c0
+/* WLAN_HT_CAP_SM_PS_* values */
+#define IEEE80211_HE_6GHZ_CAP_SM_PS		0x0600
+#define IEEE80211_HE_6GHZ_CAP_RD_RESPONDER	0x0800
+#define IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS	0x1000
+#define IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS	0x2000
+
 /**
  * ieee80211_get_qos_ctl - get pointer to qos control bytes
  * @hdr: the frame
-- 
2.26.2

