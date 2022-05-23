Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC2530A5C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 10:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiEWHqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiEWHqg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 03:46:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5F18388
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291995; x=1684827995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0DUTQjpzpa7nYC8Uqi/Z3X8keXH8jzfvfBYPWL+TFcQ=;
  b=ZISjf3T97EAzShNMS2bow9lTlRHNHru21IGXqtQWgqeafaTGHjstvpsk
   Im5TSq67p8wiE29tATkR2VoZCI1omoqWZh14uI4CHpAZ+ixZPI6ruJ25m
   QqwZDXCOcmtya7Il1J3grZ8O9W6gdUg6XbhdIPsOKgBf9vOvzqEXJDXJV
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 May 2022 23:49:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 23:49:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:49:20 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:49:20 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Vikram Kandukuri <quic_vikram@quicinc.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Subject: [PATCH v3] nl80211: retrieve EHT related elements in AP mode
Date:   Sun, 22 May 2022 23:49:04 -0700
Message-ID: <20220523064904.28523-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add support to retrieve EHT capabilities and EHT operation elements
passed by the userspace in the beacon template and store the pointers
in struct cfg80211_ap_settings to be used by the drivers.

Co-developed-by: Vikram Kandukuri <quic_vikram@quicinc.com>
Signed-off-by: Vikram Kandukuri <quic_vikram@quicinc.com>
Co-developed-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v3: Rolled v2 patch #1 and #2 into a single patch and added
checks for element lengths. Dropped patch #3 for now.

include/net/cfg80211.h |  4 ++++
 net/wireless/nl80211.c | 26 ++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 97a5804ccdcf..a7a68bf26333 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1290,6 +1290,8 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @ht_cap: HT capabilities (or %NULL if HT isn't enabled)
  * @vht_cap: VHT capabilities (or %NULL if VHT isn't enabled)
  * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
+ * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
+ * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
@@ -1326,6 +1328,8 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_vht_cap *vht_cap;
 	const struct ieee80211_he_cap_elem *he_cap;
 	const struct ieee80211_he_operation *he_oper;
+	const struct ieee80211_eht_cap_elem *eht_cap;
+	const struct ieee80211_eht_operation *eht_oper;
 	bool ht_required, vht_required, he_required, sae_h2e_required;
 	bool twt_responder;
 	u32 flags;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 740b29481bc6..3c62969107f0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5436,7 +5436,7 @@ static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
  * HT/VHT requirements/capabilities, we parse them out of the IEs for the
  * benefit of drivers that rebuild IEs in the firmware.
  */
-static void nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
+static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 {
 	const struct cfg80211_beacon_data *bcn = &params->beacon;
 	size_t ies_len = bcn->tail_len;
@@ -5462,6 +5462,26 @@ static void nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
 	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1)
 		params->he_oper = (void *)(cap->data + 1);
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
+	if (cap) {
+		if (!cap->datalen)
+			return -EINVAL;
+		params->eht_cap = (void *)(cap->data + 1);
+		if (!ieee80211_eht_capa_size_ok((const u8 *)params->he_cap,
+						(const u8 *)params->eht_cap,
+						cap->datalen - 1))
+			return -EINVAL;
+	}
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
+	if (cap) {
+		if (!cap->datalen)
+			return -EINVAL;
+		params->eht_oper = (void *)(cap->data + 1);
+		if (!ieee80211_eht_oper_size_ok((const u8 *)params->eht_oper,
+						cap->datalen - 1))
+			return -EINVAL;
+	}
+	return 0;
 }
 
 static bool nl80211_get_ap_channel(struct cfg80211_registered_device *rdev,
@@ -5770,7 +5790,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
-	nl80211_calculate_ap_params(params);
+	err = nl80211_calculate_ap_params(params);
+	if (err)
+		goto out;
 
 	if (info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS])
 		params->flags = nla_get_u32(

base-commit: 9335156ac0e174721921c404bd173526c8509124
-- 
2.31.1

