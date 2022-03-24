Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59114E5CAD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 02:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiCXBUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 21:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiCXBUp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 21:20:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AC692872
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 18:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648084755; x=1679620755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aZaxFGN7wIInQGry0NnfGJUmQpkaYS5NdcbjHX9xLOI=;
  b=zM8Dw4r3qxUqExaDdSY7Q3/S/yW+dkFtq1wRzS3wrL5S63nmkyt4CMmD
   lGZnQUcBZwn4kOUw16vvOQpvR0G6FJvBojMHBggBrOWRT4F2BdJ+loMIR
   T0jG6QpbGcfXMkP+7lO81x4t6odIsxnpHgndNMn9l0bJeVwaFXlIxlfVZ
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 18:19:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:19:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 18:19:13 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 18:19:12 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] ath11k: store and send country code to firmware after recovery
Date:   Wed, 23 Mar 2022 21:18:56 -0400
Message-ID: <20220324011856.11014-1-quic_wgong@quicinc.com>
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

Currently ath11k does not send the country code to firmware after device
recovery, as a result the regdomain info is reported from firmware by
default. Regdomain info is important, so ath11k also need to restore
it to the value which was used before recovery.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: rebased to ath.git ath-202203230912

 drivers/net/wireless/ath/ath11k/core.c | 1 +
 drivers/net/wireless/ath/ath11k/core.h | 1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 8 ++++++++
 drivers/net/wireless/ath/ath11k/reg.c  | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 9cfba73b9e22..5243bd0aadb3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1300,6 +1300,7 @@ static void ath11k_update_11d(struct work_struct *work)
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 
+		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
 		ret = ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
 		if (ret)
 			ath11k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 70eb6e418422..a23812617298 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -651,6 +651,7 @@ struct ath11k {
 	int hw_rate_code;
 	u8 twt_enabled;
 	bool nlo_enabled;
+	u8 alpha2[REG_ALPHA2_LEN + 1];
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 34a62933ccd2..9c25c60587ae 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7951,6 +7951,14 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 		ar->state = ATH11K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
 
+		if (ar->ab->hw_params.current_cc_support &&
+		    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
+			struct wmi_set_current_country_params set_current_param = {};
+
+			memcpy(&set_current_param.alpha2, ar->alpha2, 2);
+			ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		}
+
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
 			ath11k_dbg(ab, ATH11K_DBG_BOOT,
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 81e11cde31d7..35eb1a0c04dc 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -83,6 +83,7 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	 */
 	if (ar->ab->hw_params.current_cc_support) {
 		memcpy(&set_current_param.alpha2, request->alpha2, 2);
+		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
 		ret = ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
 		if (ret)
 			ath11k_warn(ar->ab,

base-commit: d3dc55a0ce389be715ac7d104ee2cc852681e8d1
-- 
2.31.1

