Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06F4B28BA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 16:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351217AbiBKPIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 10:08:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351215AbiBKPIP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 10:08:15 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267CF306
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 07:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644592094; x=1676128094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XmEPtEkg5T8mKJnHFaL++XjKoJ37epE2HY7P88qmP4I=;
  b=PNR19/+hQaD6RngSQBMfWpoYmCrjOGy365sby5Qp7Chmwa9M7vff2GR+
   KDdQqL/jTVyniEe2pAiFevUJlAPaOa0yEksA5h7Bu7DWsWiulalHxEFjN
   5+wGJkEESGbCkFZrO5uGN+s14YIk26l7VlYdrrHQXkHWcbjlCeDllJh03
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Feb 2022 07:08:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:08:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 07:08:13 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 07:08:11 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH 3/6] ath11k: register relayfs entries for CFR dump
Date:   Fri, 11 Feb 2022 20:37:52 +0530
Message-ID: <1644592075-27082-4-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
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

Provide a relayfs interface to collect the CFR dump from
the user space.

'/sys/kernel/debug/ieee80211/phyX/ath11k/cfr_capture' is exposed
to user space to get CFR data.

CFR format to user space:
 ___________________________________________
| CFR header | CFR payload | CFR tail data |
|____________|_____________|_______________|

CFR header contains the following fields,

* Start magic number 0xDEADBEAF - 4bytes
* vendor id - 4bytes
* cfr metadata version - 1byte
* cfr data version - 1byte
* chip type - 1byte
* platform type - 1byte
* CFR metadata length - 4bytes
* metadata - 92bytes
        peer mac - 6bytes
        capture status - 1byte (1 for success 0 for failure)
        capture_bw - 1byte
        channel_bw - 1byte
        phy_mode - 1byte
        prim20_chan - 2bytes
        center_freq1 - 2bytes
        center_freq2 - 2bytes
        capture_mode - 1byte
        capture_type - 1byte
        sts_count - 1byte
        num_rx_chain - 1byte
        timestamp - 4bytes
        length - 4bytes
        chain_rssi - 32bytes (4bytes for each chain)
        chain_phase - 16bytes (2bytes for each chain)
        cfo_measurement - 4bytes
        agc_gain - 8bytes (1 bytes for each chain)
        rx_start_ts - 4bytes

CFR payload:

CFR payload contains 8bytes of ucode header followed by the
tone information. Tone order is  positive tones, followed by
PHY memory garbage, followed by negative tones. Dummy tones
are uploaded to make number of tones always integer number
of 64. Number of tones is not preamble type dependent.

Each CFR tone has 14-bit I component and 14-bit Q component
and is sign extended to 16-bit I/Q. Two tones are packed
into one 64-bit unit as:

[63:0] = [Tone1_Q(63:48) Tone1_I(47:32) Tone0_Q(31:16) Tone0_I(15:0)]

CFR tail: end magic number 0xBEAFDEAD

Tested-on: IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 43 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index f5cc250..00230e0 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -14,6 +14,32 @@ static int ath11k_cfr_process_data(struct ath11k *ar,
 	return 0;
 }
 
+static struct dentry *create_buf_file_handler(const char *filename,
+					      struct dentry *parent,
+					      umode_t mode,
+					      struct rchan_buf *buf,
+					      int *is_global)
+{
+	struct dentry *buf_file;
+
+	buf_file = debugfs_create_file(filename, mode, parent, buf,
+				       &relay_file_operations);
+	*is_global = 1;
+	return buf_file;
+}
+
+static int remove_buf_file_handler(struct dentry *dentry)
+{
+	debugfs_remove(dentry);
+
+	return 0;
+}
+
+static const struct rchan_callbacks rfs_cfr_capture_cb = {
+	.create_buf_file = create_buf_file_handler,
+	.remove_buf_file = remove_buf_file_handler,
+};
+
 void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
 				 u32 buf_id)
 {
@@ -87,6 +113,11 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
 		ar = ab->pdevs[i].ar;
 		cfr = &ar->cfr;
 
+		if (ar->cfr.rfs_cfr_capture) {
+			relay_close(ar->cfr.rfs_cfr_capture);
+			ar->cfr.rfs_cfr_capture = NULL;
+		}
+
 		ath11k_cfr_ring_free(ar);
 
 		spin_lock_bh(&cfr->lut_lock);
@@ -151,6 +182,18 @@ int ath11k_cfr_init(struct ath11k_base *ab)
 		}
 
 		ar->cfr_enabled = true;
+
+		ar->cfr.rfs_cfr_capture =
+				relay_open("cfr_capture",
+					   ar->debug.debugfs_pdev,
+					   ar->ab->hw_params.cfr_stream_buf_size,
+					   ar->ab->hw_params.cfr_num_stream_bufs,
+					   &rfs_cfr_capture_cb, NULL);
+		if (!ar->cfr.rfs_cfr_capture) {
+			ath11k_warn(ar->ab, "failed to open relay for cfr in pdev %d\n",
+				    ar->pdev_idx);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index c050f03..f39b82c 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -46,6 +46,7 @@ struct ath11k_cfr {
 	struct ath11k_dbring rx_ring;
 	/* Protects cfr data */
 	spinlock_t lock;
+	struct rchan *rfs_cfr_capture;
 	struct ath11k_look_up_table *lut;
 	u32 lut_num;
 	u32 dbr_buf_size;
-- 
2.7.4

