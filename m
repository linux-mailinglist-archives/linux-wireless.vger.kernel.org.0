Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3E4ED0CF
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 02:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352076AbiCaAXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 20:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaAXF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 20:23:05 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AD1FCD1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648686079; x=1680222079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5FRvCD7h6pC+ySGbwaZD+OK9XuQCej2qlEclI+8oj4o=;
  b=O/2oBi3NZzmu1gM56zqu73GEIQOZ3J3tu5TlfkWc0jhCxLC71PuWkkLb
   gAplCWM4CyW6NfxFe8pdy6DFNmOyz1BiOGTqQxVgiQ0Eydf1n//Mi9Hxl
   //0cSj5y5m8hryjHzc8pq+C98P4BaWImzVbBwBLHqNt72v/grVGwaDa0X
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Mar 2022 17:21:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:21:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 17:21:18 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 17:21:17 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Remove unnecessary delay in ath11k_core_suspend
Date:   Thu, 31 Mar 2022 08:21:05 +0800
Message-ID: <20220331002105.1162099-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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

The intended delay in ath11k_core_suspend is introduced in commit
d1b0c33850d2 ("ath11k: implement suspend for QCA6390 PCI devices"),
now with ath11k_mac_wait_tx_complete added in commit ba9177fcef21
("ath11k: Add basic WoW functionalities"), that delay is not
necessary now, so remove it.

This is found in code review.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02431-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7f4462cf5787..509bfffceba1 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -459,11 +459,6 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 	if (!ar || ar->state != ATH11K_STATE_OFF)
 		return 0;
 
-	/* TODO: there can frames in queues so for now add delay as a hack.
-	 * Need to implement to handle and remove this delay.
-	 */
-	msleep(500);
-
 	ret = ath11k_dp_rx_pktlog_stop(ab, true);
 	if (ret) {
 		ath11k_warn(ab, "failed to stop dp rx (and timer) pktlog during suspend: %d\n",

base-commit: 748b34786d1c96e758862d8e8577106ccde6515a
-- 
2.25.1

