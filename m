Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D79A4B8055
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 06:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiBPFeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 00:34:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344603AbiBPFcN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 00:32:13 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB0778047
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 21:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644989518; x=1676525518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdNmNzVZYRiytrtxz3FD2pJQQk2S9nltguF4C2aU2Ug=;
  b=tUEC5dT6G2XD4A05iG+c9hO3khQBt4pvDgILUKsAUqMDFUx9vU2W8SDu
   rtkBwNSzToGevApLHqF4d+WaiXcFJe15lHlAC8sDuuySL6r/5Dmtg9q8M
   qFwx318KBhgD7V9pkbZJIzZdBpBtjxrUelN1Dk7Sg7Lt0+mH+WpLdnwLU
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 21:31:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 21:31:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 21:31:56 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 21:31:56 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 2/3] nl80211: retrieve EHT operation element in AP mode
Date:   Tue, 15 Feb 2022 21:31:44 -0800
Message-ID: <20220216053145.20898-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220216053145.20898-1-quic_alokad@quicinc.com>
References: <20220216053145.20898-1-quic_alokad@quicinc.com>
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

Add support to retrieve the EHT operation element passed by
the userspace in the beacon template and store the pointer in
struct cfg80211_ap_settings to be used by MAC80211.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h | 2 ++
 net/wireless/nl80211.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index aaf25645aef3..a4c31b480a2e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1295,6 +1295,7 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @mbssid_config: AP settings for multiple bssid
@@ -1324,6 +1325,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_he_cap_elem *he_cap;
 	const struct ieee80211_he_operation *he_oper;
 	const struct ieee80211_eht_cap_elem *eht_cap;
+	const struct ieee80211_eht_operation *eht_oper;
 	bool ht_required, vht_required, he_required, sae_h2e_required;
 	bool twt_responder;
 	u32 flags;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 03eb6870e60f..a5f049fe8de7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5437,6 +5437,9 @@ static void nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
 	if (cap && cap->datalen >= sizeof(*params->eht_cap) + 1)
 		params->eht_cap = (void *)(cap->data + 1);
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*params->eht_oper) + 1)
+		params->eht_oper = (void *)(cap->data + 1);
 }
 
 static bool nl80211_get_ap_channel(struct cfg80211_registered_device *rdev,
-- 
2.31.1

