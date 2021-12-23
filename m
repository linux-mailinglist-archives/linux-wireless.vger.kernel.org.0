Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5847DE2C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 04:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbhLWD4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 22:56:41 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:7061 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbhLWD4l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 22:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640231801; x=1671767801;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=4bXlA5F3cLVBy3uYJ0gkFL2w1iNHOoR8G+83Wal1ibo=;
  b=dI8PJiVSQoPHF+PWAkx3Ww0XBzS3oN2gKyq2ewlM/gUeh+ceZZ5Y6EBE
   ZCBluvgSc8Bhif/NrDHuQzBPn9TpRBFBPXaMFnWM47K7KtsDb2B/zBRwS
   4vs6wdwBcpQKP7O0rmk+HcuGY7iT9R+gDf169aueVKu2PprefwjIH1FgC
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Dec 2021 19:56:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 19:56:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 19:56:40 -0800
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 19:56:38 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] ath11k: fix workqueue not getting destroyed after rmmod
Date:   Thu, 23 Dec 2021 09:26:27 +0530
Message-ID: <1640231787-17408-1-git-send-email-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, ath11k_core_alloc() creates a single thread workqueue.
This workqueue is not detroyed during clean up when ath11k modules
are unloaded from the kernel and is left as it is.
If workqueue is not destroyed, it could lead to kernel
memory scarcity in a longer run. This could affect self and
other drivers workability as well.

Add destroy workqueue in ath11k_core_free(). 

Tested on: IPQ8074 WLAN.HK.2.4.0.1-01746-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2ba3bf8..6de0fc5 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1172,6 +1173,9 @@ EXPORT_SYMBOL(ath11k_core_deinit);
 
 void ath11k_core_free(struct ath11k_base *ab)
 {
+	flush_workqueue(ab->workqueue);
+	destroy_workqueue(ab->workqueue);
+
 	kfree(ab);
 }
 EXPORT_SYMBOL(ath11k_core_free);
-- 
2.7.4

