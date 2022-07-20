Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0557B7E6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbiGTNu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbiGTNuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:50:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C42A97F
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658325022; x=1689861022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmilRMPhLJ3rPLS23qj2er0z3QNu3azRUL1YV2weMiw=;
  b=PUBfaOXkwkw8Nc4SYC6k9dV4hKGj+6Pu0mqJETQ3qkRmq5LvnB5D9GB5
   kXn29z6hfIWxd7l47IJyf9ElnJc39A+f6RU2uZNEJCQlp4EGBVUfXP5ea
   TwsmrjqD1/KYcL0mZ117HzIKgSeaKLFvJwWxvKVb2GQrMj3mCEoJG8qLj
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jul 2022 06:50:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:50:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:50:21 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:50:20 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 4/4] ath11k: Fix failed to parse regulatory event print
Date:   Wed, 20 Jul 2022 19:19:59 +0530
Message-ID: <20220720134959.15688-5-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the continuous WiFi ON/OFF scenario, we see a lot of
"failed to parse regulatory event" prints on the console.
This is because we already would have created a regulatory
domain for the wiphy and we will discard the subsequent
events to create the same regulatory event.

Fix this error print by freeing up the regulatory resources
in WiFi OFF and create the database again in WiFi ON. The same
applies for hardware recovery as well.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 3 ++-
 drivers/net/wireless/ath/ath11k/reg.c  | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2dd51f1ecfd0..a3d6f1b28405 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1210,7 +1210,6 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
 	ath11k_debugfs_soc_destroy(ab);
-	ath11k_reg_free(ab);
 	ath11k_qmi_deinit_service(ab);
 }
 
@@ -1532,6 +1531,7 @@ static void ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
+	ath11k_reg_free(ab);
 
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 }
@@ -1929,6 +1929,7 @@ void ath11k_core_stop_device(struct ath11k_base *ab)
 	ath11k_thermal_unregister(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_dp_free(ab);
+	ath11k_reg_free(ab);
 }
 
 int ath11k_core_any_pdevs_on(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 7ee3ff69dfc8..0aa4c7b039d0 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -757,5 +757,7 @@ void ath11k_reg_free(struct ath11k_base *ab)
 	for (i = 0; i < ab->hw_params.max_radios; i++) {
 		kfree(ab->default_regd[i]);
 		kfree(ab->new_regd[i]);
+		ab->default_regd[i] = NULL;
+		ab->new_regd[i] = NULL;
 	}
 }
-- 
2.35.1

