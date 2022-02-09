Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF54AEA0E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 07:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiBIGGE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 01:06:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiBIGAs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 01:00:48 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155CC02C45B
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 22:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644386451; x=1675922451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vqWY9/rbKVCqvD3Eg6vHChDIW5QC7U0HRyQcATZeaPw=;
  b=g64PpwwkVop+yv+uUy2wXc+i9GGt4i68Jm7u1diro+6wZkVrHzjMQ/Us
   ozCv6EUFzA6U+nWxs+qjqZz/Qco6S34Zk20RX8QUvEztlLE3gqloybVL1
   eBzKkVGT6lHTSr2QU3WzH8L5EvscYlUsKfyTPyDyG2GBH4n9QH47OOD9O
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Feb 2022 22:00:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 22:00:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:00:36 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:00:35 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 6/6] ath11k: Add hw-restart option to simulate_fw_crash
Date:   Wed, 9 Feb 2022 01:00:12 -0500
Message-ID: <20220209060012.32478-7-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209060012.32478-1-quic_wgong@quicinc.com>
References: <20220209060012.32478-1-quic_wgong@quicinc.com>
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

Add hw-restart to directly restart wlan. Like UTF mode start it will
restart hardware and download firmware again.

Usage:
1. Run command:
   echo hw-restart > /sys/kernel/debug/ath11k/qca6390\ hw2.0/simulate_fw_crash
   echo hw-restart > /sys/kernel/debug/ath11k/wcn6855\ hw2.0/simulate_fw_crash
2. wlan will be restart and do recovery process and success.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index c0ebdb1262f0..7375defb0f23 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -557,6 +557,10 @@ static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
 		ret = ath11k_wmi_force_fw_hang_cmd(ar,
 						   ATH11K_WMI_FW_HANG_ASSERT_TYPE,
 						   ATH11K_WMI_FW_HANG_DELAY);
+	} else if (!strcmp(buf, "hw-restart")) {
+		ath11k_info(ab, "user requested hw restart\n");
+		queue_work(ab->workqueue_aux, &ab->reset_work);
+		ret = 0;
 	} else {
 		ret = -EINVAL;
 		goto exit;
-- 
2.31.1

