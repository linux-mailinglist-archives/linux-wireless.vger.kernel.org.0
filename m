Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896E251DA4D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 16:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348657AbiEFOTQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442128AbiEFOSu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 10:18:50 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229467D1F
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651846507; x=1683382507;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+0DeCUXgHYOliKNNx5awok/fbx4nt/t/OE7cBsxR4zk=;
  b=WjjaHp3PtXF3cvQT4Ncn7j+vRC3H2HMzKjxogHjXW6qqp0yP44rQzjX8
   dfkhGlmeUwyEETc4nR321RCgYsnC7inxiOj3Pmhc0j9K3PAlb+wAWuRkK
   pPhzKxWHwZGfzFkxbMD2nZoICsFMu1Yh8T7f110IamosqUQKSC+aL38vb
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 May 2022 07:15:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 07:15:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 07:15:06 -0700
Received: from hu-akolli-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 07:15:04 -0700
From:   Anilkumar Kolli <quic_akolli@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>
Subject: [PATCH] ath11k: Reuse the available memory after firmware reload
Date:   Fri, 6 May 2022 19:44:48 +0530
Message-ID: <20220506141448.10340-1-quic_akolli@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

Ath11k allocates memory when firmware requests memory in QMI.
Coldboot calibration and firmware recovery uses firmware reload.
On firmware reload, firmware sends memory request again. If Ath11k
allocates memory on first firmware boot, reuse the available
memory. Also check if the segment type and size is same
on the next firmware boot. Reuse if segment type/size is
same as previous firmware boot else free the segment and
allocate the segment with size/type.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00752-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 -
 drivers/net/wireless/ath/ath11k/qmi.c  | 24 +++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/qmi.h  |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 01e1d494b527..7115a3507bc6 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1768,7 +1768,6 @@ static void ath11k_core_reset(struct work_struct *work)
 						ATH11K_RECOVER_START_TIMEOUT_HZ);
 
 	ath11k_hif_power_down(ab);
-	ath11k_qmi_free_resource(ab);
 	ath11k_hif_power_up(ab);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index d1e945074bc1..61ead37a944a 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1970,6 +1970,21 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
 		chunk = &ab->qmi.target_mem[i];
+
+		/* Firmware reloads in coldboot/firmware recovery.
+		 * in such case, no need to allocate memory for FW again.
+		 */
+		if (chunk->vaddr) {
+			if (chunk->prev_type == chunk->type ||
+			    chunk->prev_size == chunk->size)
+				continue;
+
+			/* cannot reuse the existing chunk */
+			dma_free_coherent(ab->dev, chunk->size,
+					  chunk->vaddr, chunk->paddr);
+			chunk->vaddr = NULL;
+		}
+
 		chunk->vaddr = dma_alloc_coherent(ab->dev,
 						  chunk->size,
 						  &chunk->paddr,
@@ -1990,6 +2005,8 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 				   chunk->type);
 			return -EINVAL;
 		}
+		chunk->prev_type = chunk->type;
+		chunk->prev_size = chunk->size;
 	}
 
 	return 0;
@@ -2466,9 +2483,6 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 	char path[100];
 	int ret;
 
-	if (m3_mem->vaddr || m3_mem->size)
-		return 0;
-
 	fw = ath11k_core_firmware_request(ab, ATH11K_M3_FILE);
 	if (IS_ERR(fw)) {
 		ret = PTR_ERR(fw);
@@ -2478,6 +2492,9 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 		return ret;
 	}
 
+	if (m3_mem->vaddr || m3_mem->size)
+		goto skip_m3_alloc;
+
 	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
 					   fw->size, &m3_mem->paddr,
 					   GFP_KERNEL);
@@ -2488,6 +2505,7 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 		return -ENOMEM;
 	}
 
+skip_m3_alloc:
 	memcpy(m3_mem->vaddr, fw->data, fw->size);
 	m3_mem->size = fw->size;
 	release_firmware(fw);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index c24e6995cca3..c83cf822be81 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -97,6 +97,8 @@ struct ath11k_qmi_event_msg {
 struct target_mem_chunk {
 	u32 size;
 	u32 type;
+	u32 prev_size;
+	u32 prev_type;
 	dma_addr_t paddr;
 	u32 *vaddr;
 	void __iomem *iaddr;
-- 
2.17.1

