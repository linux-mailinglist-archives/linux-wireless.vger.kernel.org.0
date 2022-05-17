Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84F529927
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 07:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiEQFxH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 01:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiEQFxF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 01:53:05 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CE3DDD7
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652766784; x=1684302784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2BEfwWj1pj5ztvRLob/vY7ITqciMcbXsvRZhwbzIy+0=;
  b=iCHDAJoU3yK5IUaPP5QHLWlEzHCZF0eOLo8N5lyx294NFDNQVPcHzB0z
   dlhttmYFQDrn7UH1Yesq6c04RSGXEKgDgeqxHme3NXAL+LiR+xd6/fX+H
   Bi6Y/VDH5U0k8C7NDdqRfaUteY7mzIJxFF//iquYakBpp3nb6KGbV4x0V
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 May 2022 22:53:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 22:53:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 22:53:02 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 22:53:00 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] ath11k: Init hw_params before setting up AHB resources
Date:   Tue, 17 May 2022 11:22:41 +0530
Message-ID: <20220517055241.15885-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
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

As part of adding the support of WCN6750 to ath11k, bus_params
were moved to hw_params and this regressed the initialization
of WCN6750. By the time AHB resources are setup for WCN6750,
hw_params will not be initialized and therefore initialization
for WCN6750 will fail. This is applicable only for WCN6750,
no other device is impacted.

Fix this by moving the initialization of hw_params before
setting up AHB resources.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Fixes: 00402f49d26f ("ath11k: Add support for WCN6750 device")
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index fa11807f48a9..d7d33d5cdfc5 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -976,11 +976,11 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
 
-	ret = ath11k_ahb_setup_resources(ab);
+	ret = ath11k_core_pre_init(ab);
 	if (ret)
 		goto err_core_free;
 
-	ret = ath11k_core_pre_init(ab);
+	ret = ath11k_ahb_setup_resources(ab);
 	if (ret)
 		goto err_core_free;
 
-- 
2.35.1

