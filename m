Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3871549DA3F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiA0Fd4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:33:56 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2556 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236273AbiA0Fdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261635; x=1674797635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=grINu50fIJpu2V6gAsNBKv5IVQeesGIUlU5chOhbTic=;
  b=XKnsj9yFEr20wDZCN1LL/j8PEio/e+3koNTjlZmfcPwavh+xZenAmmmt
   3COXczbKhierD43OIS/wiCR1uCnf4O4SBjJrHo9p7e/NQ30vaHbEZqpoD
   Gybwl43eleKhvJ2bDk7cEmN3djS6ftH2ZeOef5kEzw2wMh5nRiJmIKMPL
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jan 2022 21:33:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:33:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:55 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:53 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH RFC 6/8] ath11k: Increase TCL data ring size
Date:   Thu, 27 Jan 2022 11:03:27 +0530
Message-ID: <1643261609-13500-7-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase TCL data ring size from 512 to 2048, this is
needed to meet 160Mhz TX throughput on WCN6750.

As the ring size is increased, there will be a slight
increase in memory used but should not impact the
functioning of any hardware.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 409d6cc..9a30367 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_DP_H
@@ -199,7 +200,7 @@ struct ath11k_pdev_dp {
 #define DP_IDLE_SCATTER_BUFS_MAX 16
 
 #define DP_WBM_RELEASE_RING_SIZE	64
-#define DP_TCL_DATA_RING_SIZE		512
+#define DP_TCL_DATA_RING_SIZE		2048
 #define DP_TX_COMP_RING_SIZE		32768
 #define DP_TX_IDR_SIZE			DP_TX_COMP_RING_SIZE
 #define DP_TCL_CMD_RING_SIZE		32
-- 
2.7.4

