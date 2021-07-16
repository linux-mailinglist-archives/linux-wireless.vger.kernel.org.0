Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE03CB94F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbhGPPH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 11:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240066AbhGPPH2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 11:07:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8C6A613BB;
        Fri, 16 Jul 2021 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447873;
        bh=to/GTuNdPYZGFsWyeqqcFW9/JkNAWYj8Ax7EsYA6g/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBVWYyjoibCj1xYowSFBIg9g2Yp/rBRsrlbyK93MOQf2Bg8yHH2jAHBOBi7aaVAfF
         EEvYje0YI33//SyS9kJX5lV9lFXp2XF8SfwgNCxVDfBlGWAxAwsg56KmAVXBf/HzNO
         zxRf9hBaXIfZ+GOecA6L7hnba57km+92Lj2MElEseVVemykr1lI57wnPoO3GcJv5RF
         l/e0LQbRtMeBK0aXfsYN7OPfIRWVRXCH3XzOS6qSo/8mLXE3HL/fIegPRJ8QQSwoYY
         KJOeTlEb5jmquR8//xnrnswPAKduxBq0kLHcZwZoG4pc31DgVrgM6QuX80xBPiHM9L
         m9+7bUCgXAt/g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name, ryder.lee@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [RFC mac80211-next 1/7] mac80211: add twt ie in ieee80211_mgmt structure
Date:   Fri, 16 Jul 2021 17:04:00 +0200
Message-Id: <9d724d46c893268560d744a46de62dd026112d15.1626447537.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626447537.git.lorenzo@kernel.org>
References: <cover.1626447537.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce TWT definitions and TWT Information element structure
in ieee80211.h

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/ieee80211.h | 67 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2967437f1b11..29afa2b74bae 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1088,6 +1088,53 @@ struct ieee80211_ext {
 	} u;
 } __packed __aligned(2);
 
+#define IEEE80211_TWT_CONTROL_NDP			BIT(0)
+#define IEEE80211_TWT_CONTROL_RESP_MODE			BIT(1)
+#define IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST	BIT(2)
+#define IEEE80211_TWT_CONTROL_RX_DISABLED		BIT(4)
+#define IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT		BIT(5)
+
+#define IEEE80211_TWT_REQTYPE_REQUEST			BIT(0)
+#define IEEE80211_TWT_REQTYPE_SETUP_CMD			GENMASK(3, 1)
+#define IEEE80211_TWT_REQTYPE_TRIGGER			BIT(4)
+#define IEEE80211_TWT_REQTYPE_IMPLICIT			BIT(5)
+#define IEEE80211_TWT_REQTYPE_FLOWTYPE			BIT(6)
+#define IEEE80211_TWT_REQTYPE_FLOWID			GENMASK(9, 7)
+#define IEEE80211_TWT_REQTYPE_WAKE_INT_EXP		GENMASK(14, 10)
+#define IEEE80211_TWT_REQTYPE_PROTECTION		BIT(15)
+
+enum ieee80211_twt_setup_cmd {
+	TWT_SETUP_CMD_REQUEST,
+	TWT_SETUP_CMD_SUGGEST,
+	TWT_SETUP_CMD_DEMAND,
+	TWT_SETUP_CMD_GROUPING,
+	TWT_SETUP_CMD_ACCEPT,
+	TWT_SETUP_CMD_ALTERNATE,
+	TWT_SETUP_CMD_DICTATE,
+	TWT_SETUP_CMD_REJECT,
+};
+
+struct ieee80211_twt_params {
+	u8 control;
+	__le16 req_type;
+	__le64 twt;
+	u8 min_twt_dur;
+	__le16 mantissa;
+	u8 channel;
+} __packed;
+
+struct ieee80211_twt_setup {
+	u8 dialog_token;
+	u8 element_id;
+	u8 length;
+	u8 params[0];
+} __packed;
+
+#define IEEE80211_TWT_IND_SETUP_SIZE		\
+	(IEEE80211_MIN_ACTION_SIZE + 1 +	\
+	 sizeof(struct ieee80211_twt_setup) +	\
+	 sizeof(struct ieee80211_twt_params))
+
 struct ieee80211_mgmt {
 	__le16 frame_control;
 	__le16 duration;
@@ -1252,6 +1299,10 @@ struct ieee80211_mgmt {
 					__le16 toa_error;
 					u8 variable[0];
 				} __packed ftm;
+				struct {
+					u8 action_code;
+					u8 variable[0];
+				} __packed s1g;
 			} u;
 		} __packed action;
 	} u;
@@ -2879,6 +2930,7 @@ enum ieee80211_eid {
 	WLAN_EID_AID_RESPONSE = 211,
 	WLAN_EID_S1G_BCN_COMPAT = 213,
 	WLAN_EID_S1G_SHORT_BCN_INTERVAL = 214,
+	WLAN_EID_S1G_TWT = 216,
 	WLAN_EID_S1G_CAPABILITIES = 217,
 	WLAN_EID_VENDOR_SPECIFIC = 221,
 	WLAN_EID_QOS_PARAMETER = 222,
@@ -2947,6 +2999,7 @@ enum ieee80211_category {
 	WLAN_CATEGORY_FST = 18,
 	WLAN_CATEGORY_UNPROT_DMG = 20,
 	WLAN_CATEGORY_VHT = 21,
+	WLAN_CATEGORY_S1G = 22,
 	WLAN_CATEGORY_VENDOR_SPECIFIC_PROTECTED = 126,
 	WLAN_CATEGORY_VENDOR_SPECIFIC = 127,
 };
@@ -3020,6 +3073,20 @@ enum ieee80211_key_len {
 	WLAN_KEY_LEN_BIP_GMAC_256 = 32,
 };
 
+enum ieee80211_s1g_actioncode {
+	WLAN_S1G_AID_SWITCH_REQUEST,
+	WLAN_S1G_AID_SWITCH_RESPONSE,
+	WLAN_S1G_SYNC_CONTROL,
+	WLAN_S1G_STA_INFO_ANNOUNCE,
+	WLAN_S1G_EDCA_PARAM_SET,
+	WLAN_S1G_EL_OPERATION,
+	WLAN_S1G_TWT_SETUP,
+	WLAN_S1G_TWT_TEARDOWN,
+	WLAN_S1G_SECT_GROUP_ID_LIST,
+	WLAN_S1G_SECT_ID_FEEDBACK,
+	WLAN_S1G_TWT_INFORMATION = 11,
+};
+
 #define IEEE80211_WEP_IV_LEN		4
 #define IEEE80211_WEP_ICV_LEN		4
 #define IEEE80211_CCMP_HDR_LEN		8
-- 
2.31.1

