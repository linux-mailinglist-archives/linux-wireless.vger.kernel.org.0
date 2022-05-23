Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B65C530AE9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiEWHqk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiEWHqg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 03:46:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69971838F
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291994; x=1684827994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xMvM8K5/2JRocHqXV0x2xEjw4vheAWvTgCDBqHY1WwE=;
  b=PZ7jWwMsRqY9ISY8QEugu8cNOhd3vjkxxj1sePLSDjLYOp/mqTz5CA8J
   GCPymNTpqv/58TV9pUndECMY/99XzlCFT3F8SYM3DB1ugkEnaSTLiiiYl
   LktjS2vfvLP9kBu9MSF2N/jFUNp4rjIg3O2Hvjq0i5mywdR4ZVst29k+a
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 May 2022 23:01:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 23:01:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:28 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:28 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 7/9] ath11k: move vif parameter setting in a different function
Date:   Sun, 22 May 2022 23:01:06 -0700
Message-ID: <20220523060108.23982-8-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523060108.23982-1-quic_alokad@quicinc.com>
References: <20220523060108.23982-1-quic_alokad@quicinc.com>
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

Move the configuration of struct ath11k_vif parameters rsnie_present,
and wpaie_present to a separate function.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 41 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 10d35cdfafdb..ff50341f1574 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1350,28 +1350,14 @@ static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 	return ret;
 }
 
-static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+static void ath11k_mac_setup_bcn_tmpl_vif_params(struct ath11k_vif *arvif,
+						 struct sk_buff *bcn)
 {
-	struct ath11k *ar = arvif->ar;
-	struct ath11k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ar->hw;
-	struct ieee80211_vif *vif = arvif->vif;
-	struct ieee80211_mutable_offsets offs = {};
-	struct sk_buff *bcn;
 	struct ieee80211_mgmt *mgmt;
 	u8 *ies;
-	int ret;
-
-	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
-		return 0;
-
-	bcn = ieee80211_beacon_get_template(hw, vif, &offs);
-	if (!bcn) {
-		ath11k_warn(ab, "failed to get beacon template from mac80211\n");
-		return -EPERM;
-	}
 
 	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
+	mgmt = (struct ieee80211_mgmt *)bcn->data;
 	ies += sizeof(mgmt->u.beacon);
 
 	if (cfg80211_find_ie(WLAN_EID_RSN, ies, (skb_tail_pointer(bcn) - ies)))
@@ -1385,7 +1371,28 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 		arvif->wpaie_present = true;
 	else
 		arvif->wpaie_present = false;
+}
+
+static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ath11k_base *ab = ar->ab;
+	struct ieee80211_hw *hw = ar->hw;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_mutable_offsets offs = {};
+	struct sk_buff *bcn;
+	int ret;
+
+	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
+		return 0;
+
+	bcn = ieee80211_beacon_get_template(hw, vif, &offs);
+	if (!bcn) {
+		ath11k_warn(ab, "failed to get beacon template from mac80211\n");
+		return -EPERM;
+	}
 
+	ath11k_mac_setup_bcn_tmpl_vif_params(arvif, bcn);
 	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
 
 	kfree_skb(bcn);
-- 
2.31.1

