Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA343FFF62
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348069AbhICLtn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:49:43 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17175 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhICLtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:49:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669718; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=1NXJeUbnWJhpPLVO6LB2BPGMdz0cm2i+y35XfNacnKE=; b=ewODx8QK1z9WOsPOO6pYcIFwW8rO1lQTQJZOb3rCgvv0drpLGt0fF+TXG1SkPR3l9RdmzwJI
 j3ev7FuHhVK4bHoJy9gZNpqJK576PePCPuICRrQpW3OY5Ewrp/8CnstZ9T9EgM51imkxwCZz
 DBC+Xti3sRPoLSQqpMbJHhP/nAc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61320b961567234b8c8fde07 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:38
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96A61C4338F; Fri,  3 Sep 2021 11:48:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37C97C4360D;
        Fri,  3 Sep 2021 11:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 37C97C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 6/9] ieee80211: add definition for transmit power envelope element
Date:   Fri,  3 Sep 2021 07:48:18 -0400
Message-Id: <20210903114821.23346-7-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903114821.23346-1-wgong@codeaurora.org>
References: <20210903114821.23346-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IEEE Std 802.11ax™-2021 have some change for transmit power envelope
element. Add the definition of it.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/linux/ieee80211.h | 42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index bed510b7bb6b..b35cdfae0625 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2324,6 +2324,46 @@ struct ieee80211_he_6ghz_oper {
 	u8 minrate;
 } __packed;
 
+/*
+ * In "9.4.2.161 Transmit Power Envelope element" of
+ * "IEEE Std 802.11ax-2021", it show 4 types in "Table
+ * 9-275a-Maximum Transmit Power Interpretation subfield encoding".
+ * And it has 2 category for each type in "Table E-12-Regulatory
+ * Info subfield encoding in the United States".
+ * So it it totally max 8 Transmit Power Envelope element.
+ */
+#define IEEE80211_TPE_MAX_IE_COUNT	8
+
+/*
+ * In "Table 9-277 Meaning of Maximum Transmit Power Count subfield"
+ * of "IEEE Std 802.11ax-2021", the max power level is 8.
+ */
+#define IEEE80211_MAX_NUM_PWR_LEVEL	8
+
+#define IEEE80211_TPE_MAX_POWER_COUNT	8
+
+/* transmit power interpretation type of transmit power envelope element*/
+enum ieee80211_tx_power_intrpt_type {
+	IEEE80211_TPE_LOCAL_EIRP,
+	IEEE80211_TPE_LOCAL_EIRP_PSD,
+	IEEE80211_TPE_REG_CLIENT_EIRP,
+	IEEE80211_TPE_REG_CLIENT_EIRP_PSD,
+};
+
+/*
+ * struct ieee80211_tx_pwr_env
+ *
+ * This structure represents the "Transmit Power Envelope element"
+ */
+struct ieee80211_tx_pwr_env {
+	u8 tx_power_info;
+	s8 tx_power[IEEE80211_TPE_MAX_POWER_COUNT];
+} __packed;
+
+#define IEEE80211_TX_PWR_ENV_INFO_COUNT 0x7
+#define IEEE80211_TX_PWR_ENV_INFO_INTERPRET 0x38
+#define IEEE80211_TX_PWR_ENV_INFO_CATEGORY 0xC0
+
 /*
  * ieee80211_he_oper_size - calculate 802.11ax HE Operations IE size
  * @he_oper_ie: byte data of the He Operations IE, stating from the byte
@@ -2905,7 +2945,7 @@ enum ieee80211_eid {
 	WLAN_EID_VHT_OPERATION = 192,
 	WLAN_EID_EXTENDED_BSS_LOAD = 193,
 	WLAN_EID_WIDE_BW_CHANNEL_SWITCH = 194,
-	WLAN_EID_VHT_TX_POWER_ENVELOPE = 195,
+	WLAN_EID_TX_POWER_ENVELOPE = 195,
 	WLAN_EID_CHANNEL_SWITCH_WRAPPER = 196,
 	WLAN_EID_AID = 197,
 	WLAN_EID_QUIET_CHANNEL = 198,
-- 
2.31.1

