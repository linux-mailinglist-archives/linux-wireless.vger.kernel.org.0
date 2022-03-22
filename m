Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1660E4E3763
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 04:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiCVDYU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 23:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiCVDYO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 23:24:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B3A5B3FA
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647919362; x=1679455362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HSNnzBWbE5MmfhaOQEyYaWxuxKcVUVnQ9QNFKwIpyg4=;
  b=knv28TVHHGuGLtk/tsDGyl3Ih30+asvWiSOgbAZ/T0sGTnSGsm7iI4Kg
   efgN/R6lP4jAId+1ZOTAzyB3XuFGsZl+2lVUKaaaGMwBBMop/wzOhtAgw
   okOpknjH9re5dI/kG8YFb5wz1SfeM95C7juTKCkTYxICo3BQO47I4uTjQ
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 20:22:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 20:22:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 20:22:41 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 20:22:40 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: store and send country code to firmware after recovery
Date:   Mon, 21 Mar 2022 23:22:24 -0400
Message-ID: <20220322032224.11382-1-quic_wgong@quicinc.com>
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

Currently ath11k does not send the country code to firmware after device
recovery, as a result the regdomain info is reported from firmware by
default. Regdomain info is important, so ath11k also need to restore
it to the value which was used before recovery.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
depends on the patchset "ath11k: add feature for device recovery"
https://patchwork.kernel.org/project/linux-wireless/cover/20220228064606.8981-1-quic_wgong@quicinc.com/
which already exist in master-pending branch of ath.git

 drivers/net/wireless/ath/ath11k/core.c | 1 +
 drivers/net/wireless/ath/ath11k/core.h | 1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 8 ++++++++
 drivers/net/wireless/ath/ath11k/reg.c  | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 17c205e1c39c..0bded1c5dc98 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1261,6 +1261,7 @@ static void ath11k_update_11d(struct work_struct *work)
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 
+		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
 		ret = ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
 		if (ret)
 			ath11k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 719667fcfb9e..8c23cacdbb99 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -619,6 +619,7 @@ struct ath11k {
 	bool regdom_set_by_user;
 	int hw_rate_code;
 	u8 twt_enabled;
+	u8 alpha2[REG_ALPHA2_LEN + 1];
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c9524e417cf6..9cca7c79c995 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7917,6 +7917,14 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
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

base-commit: d845cf007bdf8b2bf41522e1ecd0eb804e553d57
prerequisite-patch-id: 8bb6c2b19d735f076e8f60a4fe10ceea3ad1b80d
prerequisite-patch-id: 480ddeb9d867bda9fc673b0dd2af7e8fd0e1d184
prerequisite-patch-id: 2d69ea48692d11b6d8681447fa8f63d2753a7780
prerequisite-patch-id: bcfccd769faad1aa219c7e7d2b59def344c4a152
prerequisite-patch-id: abc29d03fdea060832fb3216c635991de46d0254
-- 
2.31.1

