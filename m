Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA63F500E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhHWSD4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 14:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhHWSDx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 14:03:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2F8A61262;
        Mon, 23 Aug 2021 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629741791;
        bh=xhR9WKucc07BNA28ebWyElAWcYXYj1usDQ8+KglWLQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbKLhfSbRSyqEQodyN2erUuzw68etfvmh6OkDEwVjYF8PDV0WDPR6sCdMW7/pXR/2
         eI9XskD9xScLulg3g8+aMRhPG9JW61WfNuF98vwXzZtMgZBTf64eAa/r7xGzGdDDjJ
         0cneYytq0BBT1yq/oZlCnWQBABRYAmlLilyytkfwk/6GWt+mLiSoG3R7zJeXBlfqeK
         1pGkyEPmXb41gaLteVYAeAb8O6712fix+AM7scdEKgpfExaZQJgLmXBedWuFNeOU2c
         ATCb2O1pemflQK3jqPJF652yK4VWMQwOTs1d2K9aUsQUeCxN9WbOh9lWeEmtdl34SS
         WlWxtslGX31Ng==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v4 mac80211-next 1/7] mac80211: add twt ie in ieee80211_mgmt structure
Date:   Mon, 23 Aug 2021 20:02:38 +0200
Message-Id: <71d8b581fe4b5abc5b92f8d77ac2de3e2f7591b6.1629741512.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629741512.git.lorenzo@kernel.org>
References: <cover.1629741512.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce TWT definitions and TWT Information element structure
in ieee80211.h

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/ieee80211.h | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a6730072d13a..2e8953d80d4b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1088,6 +1088,48 @@ struct ieee80211_ext {
 	} u;
 } __packed __aligned(2);
 
+#define IEEE80211_TWT_CONTROL_NDP			BIT(0)
+#define IEEE80211_TWT_CONTROL_RESP_MODE			BIT(1)
+#define IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST	BIT(3)
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
+	u8 control;
+	u8 params[];
+} __packed;
+
 struct ieee80211_mgmt {
 	__le16 frame_control;
 	__le16 duration;
@@ -1252,6 +1294,10 @@ struct ieee80211_mgmt {
 					__le16 toa_error;
 					u8 variable[0];
 				} __packed ftm;
+				struct {
+					u8 action_code;
+					u8 variable[];
+				} __packed s1g;
 			} u;
 		} __packed action;
 	} u;
@@ -2881,6 +2927,7 @@ enum ieee80211_eid {
 	WLAN_EID_AID_RESPONSE = 211,
 	WLAN_EID_S1G_BCN_COMPAT = 213,
 	WLAN_EID_S1G_SHORT_BCN_INTERVAL = 214,
+	WLAN_EID_S1G_TWT = 216,
 	WLAN_EID_S1G_CAPABILITIES = 217,
 	WLAN_EID_VENDOR_SPECIFIC = 221,
 	WLAN_EID_QOS_PARAMETER = 222,
@@ -2950,6 +2997,7 @@ enum ieee80211_category {
 	WLAN_CATEGORY_FST = 18,
 	WLAN_CATEGORY_UNPROT_DMG = 20,
 	WLAN_CATEGORY_VHT = 21,
+	WLAN_CATEGORY_S1G = 22,
 	WLAN_CATEGORY_VENDOR_SPECIFIC_PROTECTED = 126,
 	WLAN_CATEGORY_VENDOR_SPECIFIC = 127,
 };
@@ -3023,6 +3071,20 @@ enum ieee80211_key_len {
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

