Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49992456C22
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 10:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhKSJLg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 04:11:36 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:56019 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhKSJLg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 04:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637312915; x=1668848915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EY6Hj1JcJC/1S4QuBYTIJCq9zNwJCIR2QbgZBl4ACJk=;
  b=Dk1c3/7HE2tDAEGLuf3IIdEq6Zp2gT/ck841wAzOB8EQC+5aiXDJFz7h
   iuhWYS46K/ZHOgkKZV2fghb9x2SXzaQEMhHYVG65AX4wl4kmFtHy2dxNN
   NNOAt45W9OYnlCwQNSN/5jxiUr7SFIpVlOU3ti90OQ4SExZMel3nS3vmR
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Nov 2021 01:08:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:08:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 01:08:34 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 01:08:32 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCHv2 2/2] ath11k: add spectral/CFR buffer validation support
Date:   Fri, 19 Nov 2021 14:38:21 +0530
Message-ID: <1637312901-10279-2-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637312901-10279-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1637312901-10279-1-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently there is no validation on the spectral/CFR report
over the db ring buffers from the hardware. Improper/incomplete
DMA by the target can result in invalid data received by host.
Due to this we may populate incorrect data to user space.

This buffer validation support fix this issues by filling some
magic value in the buffer during buffer replenish and check for
the magic value in the buffer received by the target. If host
detect magic value in the received buffer it will drop the buffer.

Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
v2:
 * Rebased on TOT

 drivers/net/wireless/ath/ath11k/dbring.c   | 32 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dbring.h   |  1 +
 drivers/net/wireless/ath/ath11k/spectral.c | 10 ++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index 31cf7ac..5c07442 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -6,6 +6,37 @@
 #include "core.h"
 #include "debug.h"
 
+#define ATH11K_DB_MAGIC_VALUE 0xdeadbeaf
+
+int ath11k_dbring_validate_buffer(struct ath11k *ar, void *buffer, u32 size)
+{
+	u32 *temp;
+	int idx;
+
+	size = size >> 2;
+
+	for (idx = 0, temp = buffer; idx < size; idx++, temp++) {
+		if (*temp == ATH11K_DB_MAGIC_VALUE) {
+			ath11k_warn(ar->ab, "found magic value in the buffer\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void ath11k_dbring_fill_magic_value(struct ath11k *ar,
+					   void *buffer, u32 size)
+{
+	u32 *temp;
+	int idx;
+
+	size = size >> 2;
+
+	for (idx = 0, temp = buffer; idx < size; idx++, temp++)
+		*temp++ = ATH11K_DB_MAGIC_VALUE;
+}
+
 static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 					struct ath11k_dbring *ring,
 					struct ath11k_dbring_element *buff,
@@ -27,6 +58,7 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 
 	ptr_unaligned = buff->payload;
 	ptr_aligned = PTR_ALIGN(ptr_unaligned, ring->buf_align);
+	ath11k_dbring_fill_magic_value(ar, ptr_aligned, ring->buf_sz);
 	paddr = dma_map_single(ab->dev, ptr_aligned, ring->buf_sz,
 			       DMA_FROM_DEVICE);
 
diff --git a/drivers/net/wireless/ath/ath11k/dbring.h b/drivers/net/wireless/ath/ath11k/dbring.h
index 78a985f..124c7db 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.h
+++ b/drivers/net/wireless/ath/ath11k/dbring.h
@@ -76,4 +76,5 @@ int ath11k_dbring_get_cap(struct ath11k_base *ab,
 			  struct ath11k_dbring_cap *db_cap);
 void ath11k_dbring_srng_cleanup(struct ath11k *ar, struct ath11k_dbring *ring);
 void ath11k_dbring_buf_cleanup(struct ath11k *ar, struct ath11k_dbring *ring);
+int ath11k_dbring_validate_buffer(struct ath11k *ar, void *data, u32 size);
 #endif /* ATH11K_DBRING_H */
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index ac4da99..b65e23d 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -581,6 +581,7 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 	u16 length, freq;
 	u8 chan_width_mhz, bin_sz;
 	int ret;
+	u32 check_length;
 
 	lockdep_assert_held(&ar->spectral.lock);
 
@@ -614,6 +615,11 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 		return -EINVAL;
 	}
 
+	check_length = sizeof(*fft_report) + (num_bins * ab->hw_params.spectral.fft_sz);
+	ret = ath11k_dbring_validate_buffer(ar, data, check_length);
+	if (ret)
+		return ret;
+
 	ret = ath11k_spectral_pull_search(ar, data, &search);
 	if (ret) {
 		ath11k_warn(ab, "failed to pull search report %d\n", ret);
@@ -747,6 +753,10 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
 				goto err;
 			}
 
+			ret = ath11k_dbring_validate_buffer(ar, data, tlv_len);
+			if (ret)
+				goto err;
+
 			summary = (struct spectral_summary_fft_report *)tlv;
 			ath11k_spectral_pull_summary(ar, &param->meta,
 						     summary, &summ_rpt);
-- 
2.7.4

