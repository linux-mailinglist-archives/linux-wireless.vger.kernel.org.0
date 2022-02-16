Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D035F4B8308
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 09:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiBPIdA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 03:33:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiBPIc7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 03:32:59 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B31B7A8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 00:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645000367; x=1676536367;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qRzxwrAzA775KEAgATuoX2mgiC3P40OgCfS9DVA/Gu4=;
  b=vVC3UYhwhyFNQmlh62jV3Cepq0rt/zCYhgpvnex7VuRzm2S+T3Xo/8Yp
   icbSEc1zM4/M2dUlms6v9tz85LE3LsB+YuoWaouKO3emnJuaAvzQEIMMC
   oPy9V54dbBfXrxT9N53jMa3UN1+8/WuyRREmU6TF/ZF6UhoQVY5te5hRc
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Feb 2022 00:32:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:32:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 00:32:47 -0800
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 00:32:45 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCHv2] ath11k: Invalidate cached reo ring entry before accessing it
Date:   Wed, 16 Feb 2022 14:02:34 +0530
Message-ID: <1645000354-32558-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
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

REO2SW ring descriptor is currently allocated in cacheable memory.
While reaping reo ring entries on second trial after updating head
pointer, first entry is not invalidated before accessing it.

This results in host reaping and using cached descriptor which is
already overwritten in memory by DMA device (HW).
Since the contents of descriptor(buffer id, peer info and other information
bits) are outdated host throws errors like below while parsing corresponding
MSDU's and drops them.

[347712.048904] ath11k_pci 0004:01:00.0: msdu_done bit in attention is not set
[349173.355503] ath11k_pci 0004:01:00.0: frame rx with invalid buf_id 962

Move the try_again: label above  ath11k_hal_srng_access_begin()
so that first entry will be invalidated and prefetched.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Fixes: 6452f0a3d565 ("ath11k: allocate dst ring descriptors from cacheable memory")
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

---
v2:
  - Updated commit log to describe the symptoms and the bug being fixed.
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 89b77b94..99c7e8a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2652,9 +2652,9 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 	spin_lock_bh(&srng->lock);
 
+try_again:
 	ath11k_hal_srng_access_begin(ab, srng);
 
-try_again:
 	while (likely(desc =
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
-- 
2.7.4

