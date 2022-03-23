Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385EE4E5B92
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 23:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbiCWW4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbiCWW43 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 18:56:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD2C9024C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 15:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648076095; x=1679612095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oh5yg7KzWxb/vP8i7mSdTsI1YAHykHomDuyvN6dmt9U=;
  b=zmDN6r7SYnKc+ywZEJ/o9OPwgRJT1iKQ59FOjgD6P/nSBdCMcpPnBQcm
   EcCS2oa1Fk4EdXy3PAhdmvbrfMG3tI+nltwYQQNFG4qDuxWm6AlCSNjWo
   q9Q4NXU+aBP1LbcmCj4kZTI7nJIS1nE9HTpEoadDu2TJP4saVkxzVkMf/
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 15:54:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:54:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 15:54:54 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 15:54:54 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Vikram Kandukuri <quic_vikram@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 1/3] nl80211: retrieve EHT capabilities in AP mode
Date:   Wed, 23 Mar 2022 15:54:41 -0700
Message-ID: <20220323225443.13947-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Vikram Kandukuri <quic_vikram@quicinc.com>

Add support to retrieve the EHT capabilities element passed by
the userspace in the beacon template and store the pointer in
struct cfg80211_ap_settings to be used by MAC80211.

Signed-off-by: Vikram Kandukuri <quic_vikram@quicinc.com>
Co-developed-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2: Rebased on top of wireless-next git repository

 include/net/cfg80211.h | 2 ++
 net/wireless/nl80211.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 68713388b617..845db70a9473 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1285,6 +1285,7 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @ht_cap: HT capabilities (or %NULL if HT isn't enabled)
  * @vht_cap: VHT capabilities (or %NULL if VHT isn't enabled)
  * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
+ * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
@@ -1322,6 +1323,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_vht_cap *vht_cap;
 	const struct ieee80211_he_cap_elem *he_cap;
 	const struct ieee80211_he_operation *he_oper;
+	const struct ieee80211_eht_cap_elem *eht_cap;
 	bool ht_required, vht_required, he_required, sae_h2e_required;
 	bool twt_responder;
 	u32 flags;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ee1c2b6b6971..71946ad89059 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5442,6 +5442,9 @@ static void nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
 	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1)
 		params->he_oper = (void *)(cap->data + 1);
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*params->eht_cap) + 1)
+		params->eht_cap = (void *)(cap->data + 1);
 }
 
 static bool nl80211_get_ap_channel(struct cfg80211_registered_device *rdev,

base-commit: f5ba9781dde28f87d1e6db580ab63b308b5b5e1b
-- 
2.31.1

