Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4B493711
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 10:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353000AbiASJSl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 04:18:41 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:26850 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353004AbiASJSg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 04:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642583916; x=1674119916;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Yl1IAdxTibpox69ABhbYjQVyClR+0xgOoYkTwSrAyV4=;
  b=IgFz0QbrLyE1RDrwbXBDSTDdCuijs0EE9CUtP44n0VOCerzK6e36FeEV
   Kg6b96/Ocx+4cVhmKbtMgK5S6Xroj1caifQkLy2PtnYAxz3nFUoMJ1Cp2
   bw64597snHPfW7UJgm3TpJ5urXpi0fdCHdGumSiqxa7vO6tgLGskLVCk2
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Jan 2022 01:18:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 01:18:32 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 19 Jan 2022 01:18:32 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 19 Jan 2022 01:18:30 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH] ath11k: Rename ath11k_ahb_ext_irq_config
Date:   Wed, 19 Jan 2022 14:48:13 +0530
Message-ID: <1642583893-21485-1-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rename ath11k_ahb_ext_irq_config() to ath11k_ahb_config_ext_irq()
for just symmetry with ath11k_ahb_free_ext_irq().

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 3fb0aa0..3fcec42 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -466,7 +466,7 @@ static irqreturn_t ath11k_ahb_ext_interrupt_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int ath11k_ahb_ext_irq_config(struct ath11k_base *ab)
+static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
 {
 	struct ath11k_hw_params *hw = &ab->hw_params;
 	int i, j;
@@ -574,7 +574,7 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
 	}
 
 	/* Configure external interrupts */
-	ret = ath11k_ahb_ext_irq_config(ab);
+	ret = ath11k_ahb_config_ext_irq(ab);
 
 	return ret;
 }
-- 
2.7.4

