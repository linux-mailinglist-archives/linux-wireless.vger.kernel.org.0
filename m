Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC84B992F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Feb 2022 07:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiBQG1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Feb 2022 01:27:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBQG1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Feb 2022 01:27:00 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79BA1C7E9E
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 22:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645079206; x=1676615206;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=jNWdit3qKnRNT9F668SEgLXfD6+qTHHC7FIrfqkvDCw=;
  b=WsrynRco6R45ZobheAiIjzDbOfk3I2Buf0QzRJzYysNAONyZ12gGabAi
   kFf5+xrvHbBZk8qkyHFXuYc6e/n0TKYKE+VOFs3kXbgL+KKPVEdCiK6sM
   MBKLjqeKFQSF9kuhMC+Jnv8GN2EMLLpMnoMPct174QrgVL7uipIr3+0x0
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Feb 2022 22:26:46 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:26:46 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 22:26:46 -0800
Received: from seevalam-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 22:26:44 -0800
From:   Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Subject: [PATCH] ath11k: Handle failure in qmi firmware ready
Date:   Thu, 17 Feb 2022 11:56:35 +0530
Message-ID: <1645079195-13564-1-git-send-email-quic_seevalam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In some scenarios like firmware crashes during init time
and hardware gets restarted after qmi firmware ready event.
During restart, ath11k_core_qmi_firmware_ready() returns timeout.
But, this failure is not handled and ATH11K_FLAG_REGISTERED is set.

When hardware restart completed, firmware sends firmware ready event
again. Since ATH11K_FLAG_REGISTERED is already set, ath11k handles
this as core restart. Inits are not done because of previous timeout.
But ath11k_core_restart does deinit's which causes NULL pointer crash.

Fix this by handling failure from ath11k_core_qmi_firmware_ready().

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-00881-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 42c2ad3..efb0146 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2959,7 +2959,11 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 				clear_bit(ATH11K_FLAG_CRASH_FLUSH,
 					  &ab->dev_flags);
 				clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
-				ath11k_core_qmi_firmware_ready(ab);
+				ret = ath11k_core_qmi_firmware_ready(ab);
+				if (ret) {
+					set_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
+					break;
+				}
 				set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
 			}
 
-- 
2.7.4

