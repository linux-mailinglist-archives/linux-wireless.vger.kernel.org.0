Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7CF45290D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 05:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbhKPEUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 23:20:41 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:64402 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242927AbhKPESn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 23:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637036147; x=1668572147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9m3zVsDbVQIbdVbjuskoyiFhnDvd9jsNTpxSecNVDZ4=;
  b=GU+EKj/OUieu4GgOWJpJ6hecx7pT2BF36WAiHf9LVMtujIlMyFEGCt4C
   3oalhKEXhXpyl2rLsYHnHzUbd5H5WvsLifgM6UTSO6ip3Ps4NPHBJgUVp
   pduQXa/ckkZJOtlAyYCaZArxgPHgNke55k4Q4ydoiqStvFHvii8uuIXdm
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Nov 2021 20:15:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 20:15:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 20:15:39 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 20:15:38 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v4 1/4] ath11k: add ath11k_qmi_free_resource() for recovery
Date:   Mon, 15 Nov 2021 23:15:19 -0500
Message-ID: <20211116041522.23529-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116041522.23529-1-quic_wgong@quicinc.com>
References: <20211116041522.23529-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k_qmi_free_target_mem_chunk() and ath11k_qmi_m3_free() is static
in qmi.c, they are needed for recovery, export them in a new function.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 5 +++++
 drivers/net/wireless/ath/ath11k/qmi.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index b5e34d670715..1f474a10d1b0 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2811,3 +2811,8 @@ void ath11k_qmi_deinit_service(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_qmi_deinit_service);
 
+void ath11k_qmi_free_resource(struct ath11k_base *ab)
+{
+	ath11k_qmi_free_target_mem_chunk(ab);
+	ath11k_qmi_m3_free(ab);
+}
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 3d5930330703..692e796ff839 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -471,5 +471,6 @@ void ath11k_qmi_event_work(struct work_struct *work);
 void ath11k_qmi_msg_recv_work(struct work_struct *work);
 void ath11k_qmi_deinit_service(struct ath11k_base *ab);
 int ath11k_qmi_init_service(struct ath11k_base *ab);
+void ath11k_qmi_free_resource(struct ath11k_base *ab);
 
 #endif
-- 
2.31.1

