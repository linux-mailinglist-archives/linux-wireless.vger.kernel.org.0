Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47F3386B38
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhEQUVm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 16:21:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55231 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239054AbhEQUVf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 16:21:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621282817; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=n+zVQOhh2k/MElkBkxeXhh/b1v9515nxkUatCtVPed8=; b=I8fjo5XcTDZNIXUoDWJpCyiJ3xfx9jbDWoS2KVWLIsK4PZ/hG0JsV7IjuOxZacse8wbskkXU
 Ga3BXdIuDtVb1t/z3xO8WUgnVMcBOQ6/qfiNWyobPPd1nhIWq7UHjOhnBDGa1TArfF5QMycn
 JflfzdQrwDZDMY8tQoo0DVWSty0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60a2cffd5f788b52a5430976 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 May 2021 20:20:13
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8007EC43460; Mon, 17 May 2021 20:20:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FF19C43217;
        Mon, 17 May 2021 20:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FF19C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 6/9] mac80211: add definition for transmit power envelope element
Date:   Mon, 17 May 2021 16:19:29 -0400
Message-Id: <20210517201932.8860-7-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517201932.8860-1-wgong@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IEEE P802.11ax™/D8.0 have some change for  transmit power envelope
element. This patch to add the definition of it.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/linux/ieee80211.h | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 894a2c4d7cb7..a39b5fc1dffc 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2292,6 +2292,35 @@ struct ieee80211_he_6ghz_oper {
 	u8 minrate;
 } __packed;
 
+#define IEEE80211_TPE_MAX_IE_COUNT	8
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
+/**
+ * struct ieee80211_tx_pwr_env
+ *
+ * This structure represents the "Transmit Power Envelope element"
+ */
+struct ieee80211_tx_pwr_env {
+	u8 tx_power_info;
+	s8 tx_power[IEEE80211_TPE_MAX_POWER_COUNT];
+} __packed;
+
+#define TX_PWR_ENV_INFO_COUNT	GENMASK(2, 0)
+#define TX_PWR_ENV_INFO_INTERPRET	GENMASK(5, 3)
+#define TX_PWR_ENV_INFO_CATEGORY	GENMASK(7, 6)
+
+#define GET_TX_PWR_ENV_COUNT(fv) FIELD_GET(TX_PWR_ENV_INFO_COUNT, fv)
+#define GET_TX_PWR_ENV_INTERPRET(fv) FIELD_GET(TX_PWR_ENV_INFO_INTERPRET, fv)
+#define GET_TX_PWR_ENV_CATEGORY(fv) FIELD_GET(TX_PWR_ENV_INFO_CATEGORY, fv)
+
 /*
  * ieee80211_he_oper_size - calculate 802.11ax HE Operations IE size
  * @he_oper_ie: byte data of the He Operations IE, stating from the byte
@@ -2873,7 +2902,7 @@ enum ieee80211_eid {
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

