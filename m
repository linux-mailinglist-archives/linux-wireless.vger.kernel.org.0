Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28D565228
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiGDKZw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiGDKZ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED8610FFD
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656930248; x=1688466248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JLjUcfEAoZGdc0LpXM0fzRBNZSHUKbX665cALsYwCoo=;
  b=keOjFQ4TSAcijuoytFihVG2NPWiz9J1uNHGOiJwjxIYNa7ArzHVqTM+J
   DmW+sdbZHTFPwszc+hgUO0RyOa7P3m2CzqObsJT/GmbGWW95EtWq916Tx
   1D6+5Z6i9Ch8ynYzVOk5ZX374phmEz9Amgj163zorUHw5IyL6MfgOK4b+
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 04 Jul 2022 03:24:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:24:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:07 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:06 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 3/7] mac80211: add combined power type definition for 6 GHz
Date:   Mon, 4 Jul 2022 15:53:37 +0530
Message-ID: <20220704102341.5692-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704102341.5692-1-quic_adisi@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

6 GHz regulatory domain introduces different power modes for 6 GHz AP
operation - Low Power Indoor(LPI), Standard Power(SP) and Very Low
Power(VLP). 6 GHz STAs could be operated as either Regular or
Subordinate clients. We have separate definitions of AP and client.

However, during concurrency (multi-interfaces), it would be
difficult to keep different enum containers for different interface
types in order to track its power mode.

Add new combined power type definition for 6 GHz interfaces. Also add
support to convert existing AP/Client Power type to this new combined
power type enum.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h       | 19 ++++++++++++
 include/uapi/linux/nl80211.h | 38 +++++++++++++++++++++++
 net/wireless/util.c          | 60 ++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 600c080a280b..ed482b23fb9c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5902,6 +5902,25 @@ ieee80211_frequency_to_channel(int freq)
 struct ieee80211_channel *
 ieee80211_get_channel_khz(struct wiphy *wiphy, u32 freq);
 
+/**
+ * ieee80211_ap_reg_power_to_reg_power_mode - convert AP specific 6 GHz power
+ *				type into combined 6 GHz power type
+ * @ap_type: AP's power mode
+ * Return: Power mode as referenced in &enum nl80211_regulatory_power_modes
+ */
+enum nl80211_regulatory_power_modes
+ieee80211_ap_reg_power_to_reg_power_mode(enum ieee80211_ap_reg_power ap_type);
+
+/**
+ * ieee80211_client_reg_power_to_reg_power_mode - convert Client specific 6 GHz
+ *				power type into combined 6 GHz power type
+ * @client_type: Client's power mode
+ * @ap_type: AP's power mode to which this client is associating
+ * Return: Power mode as referenced in &enum nl80211_regulatory_power_modes
+ */
+enum nl80211_regulatory_power_modes
+ieee80211_client_reg_power_to_reg_power_mode(enum ieee80211_client_reg_power client_type,
+					     enum ieee80211_ap_reg_power ap_type);
 /**
  * ieee80211_get_channel - get channel struct from wiphy for specified frequency
  *
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8c21136ac18c..789f73878f50 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3970,6 +3970,44 @@ enum nl80211_band_attr {
 
 #define NL80211_BAND_ATTR_HT_CAPA NL80211_BAND_ATTR_HT_CAPA
 
+/**
+ * enum nl80211_regulatory_power_modes - 6 GHz regulatory power
+ *					 modes
+ * @NL80211_REG_AP_LPI: Low Power Indoor (Access Point)
+ * @NL80211_REG_AP_SP: Standard Power (Access Point)
+ * @NL80211_REG_AP_VLP: Very Low Power (Access Point)
+ * @NL80211_REG_REGULAR_CLIENT_LPI: Low Power Indoor (Regular
+ *				    or Default Client)
+ * @NL80211_REG_REGULAR_CLIENT_SP: Standard Power (Regular
+ *				   or Default Client)
+ * @NL80211_REG_REGULAR_CLIENT_VLP: Very Low Power (Regular
+ *				    or Default Client)
+ * @NL80211_REG_SUBORDINATE_CLIENT_LPI: Low Power Indoor
+ *					(Subordinate Client)
+ * @NL80211_REG_SUBORDINATE_CLIENT_SP: Standard Power
+ *				       (Subordinate Client)
+ * @NL80211_REG_SUBORDINATE_CLIENT_VLP: Very Low Power
+ *					(Subordinate Client)
+ * @NL80211_REG_MAX_POWER_MODES: Max supported number of power
+ *				 modes
+ * @__NL80211_REG_LAST: Internal use
+ */
+enum nl80211_regulatory_power_modes {
+	NL80211_REG_AP_LPI,
+	NL80211_REG_AP_SP,
+	NL80211_REG_AP_VLP,
+	NL80211_REG_REGULAR_CLIENT_LPI,
+	NL80211_REG_REGULAR_CLIENT_SP,
+	NL80211_REG_REGULAR_CLIENT_VLP,
+	NL80211_REG_SUBORDINATE_CLIENT_LPI,
+	NL80211_REG_SUBORDINATE_CLIENT_SP,
+	NL80211_REG_SUBORDINATE_CLIENT_VLP,
+
+	/* keep last */
+	__NL80211_REG_LAST,
+	NL80211_REG_MAX_POWER_MODES = __NL80211_REG_LAST - 1,
+};
+
 /**
  * enum nl80211_wmm_rule - regulatory wmm rule
  *
diff --git a/net/wireless/util.c b/net/wireless/util.c
index b7257862e0fe..cca0ee321a03 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -190,6 +190,66 @@ struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(ieee80211_get_channel_khz);
 
+enum nl80211_regulatory_power_modes
+ieee80211_ap_reg_power_to_reg_power_mode(enum ieee80211_ap_reg_power ap_type)
+{
+	switch (ap_type) {
+	case IEEE80211_REG_LPI_AP:
+		return NL80211_REG_AP_LPI;
+	case IEEE80211_REG_SP_AP:
+		return NL80211_REG_AP_SP;
+	case IEEE80211_REG_VLP_AP:
+		return NL80211_REG_AP_VLP;
+	default:
+		return NL80211_REG_MAX_POWER_MODES + 1;
+	}
+}
+EXPORT_SYMBOL(ieee80211_ap_reg_power_to_reg_power_mode);
+
+/* ieee80211_client_reg_power_to_reg_power_mode: Accepts the individual power type of
+ * a 6 GHz client and power type of AP to which the client is associating and returns
+ * the final combined power mode as enumerated in &enum nl80211_regulatory_power_modes.
+ *
+ * Unlike AP, for client there is no direct mapping because final power mode of
+ * operation of client is dependent upon the power type of AP.
+ * For example -
+ * If client is a Regular client and AP is Low Power Indoor then combined power mode
+ * will be Regular Low Power Indoor where as if AP is Standard Power, then it will be
+ * Regular Standard Power Mode.
+ */
+enum nl80211_regulatory_power_modes
+ieee80211_client_reg_power_to_reg_power_mode(enum ieee80211_client_reg_power client_type,
+					     enum ieee80211_ap_reg_power ap_type)
+{
+	switch (client_type) {
+	case IEEE80211_REG_DEFAULT_CLIENT:
+		switch (ap_type) {
+		case IEEE80211_REG_LPI_AP:
+			return NL80211_REG_REGULAR_CLIENT_LPI;
+		case IEEE80211_REG_SP_AP:
+			return NL80211_REG_REGULAR_CLIENT_SP;
+		case IEEE80211_REG_VLP_AP:
+			return NL80211_REG_REGULAR_CLIENT_VLP;
+		default:
+			return NL80211_REG_MAX_POWER_MODES  + 1;
+		}
+	case IEEE80211_REG_SUBORDINATE_CLIENT:
+		switch (ap_type) {
+		case IEEE80211_REG_LPI_AP:
+			return NL80211_REG_SUBORDINATE_CLIENT_LPI;
+		case IEEE80211_REG_SP_AP:
+			return NL80211_REG_SUBORDINATE_CLIENT_SP;
+		case IEEE80211_REG_VLP_AP:
+			return NL80211_REG_SUBORDINATE_CLIENT_SP;
+		default:
+			return NL80211_REG_MAX_POWER_MODES;
+		}
+	default:
+		return NL80211_REG_MAX_POWER_MODES + 1;
+	}
+}
+EXPORT_SYMBOL(ieee80211_client_reg_power_to_reg_power_mode);
+
 static void set_mandatory_flags_band(struct ieee80211_supported_band *sband)
 {
 	int i, want;
-- 
2.17.1

