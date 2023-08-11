Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E1778C2F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 12:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHKKoS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 06:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHKKoR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 06:44:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00636130
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 03:44:16 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMgP02yHdzrSXT;
        Fri, 11 Aug 2023 18:43:00 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 18:44:14 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <kvalo@kernel.org>, <quic_jjohnson@quicinc.com>,
        <quic_srirrama@quicinc.com>, <yuehaibing@huawei.com>,
        <quic_mpubbise@quicinc.com>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath11k: Remove unused declarations
Date:   Fri, 11 Aug 2023 18:44:13 +0800
Message-ID: <20230811104413.33668-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 2c3960c2253d ("ath11k: setup ce tasklet for control path")
declared but never implemented ath11k_ce_map_service_to_pipe().
Commit e3396b8bddd2 ("ath11k: ce: support different CE configurations")
declared but never implemented ath11k_ce_attr_attach().
Commit d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
declared but never implemented ath11k_qmi_event_work()/ath11k_qmi_msg_recv_work().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/ath/ath11k/ce.h  | 3 ---
 drivers/net/wireless/ath/ath11k/qmi.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index 1fc6360e7f01..c0f6a0ba86df 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -203,9 +203,6 @@ int ath11k_ce_alloc_pipes(struct ath11k_base *ab);
 void ath11k_ce_free_pipes(struct ath11k_base *ab);
 int ath11k_ce_get_attr_flags(struct ath11k_base *ab, int ce_id);
 void ath11k_ce_poll_send_completed(struct ath11k_base *ab, u8 pipe_id);
-int ath11k_ce_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
-				  u8 *ul_pipe, u8 *dl_pipe);
-int ath11k_ce_attr_attach(struct ath11k_base *ab);
 void ath11k_ce_get_shadow_config(struct ath11k_base *ab,
 				 u32 **shadow_cfg, u32 *shadow_cfg_len);
 void ath11k_ce_stop_shadow_timers(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index b0407abf90cd..d477e2be814b 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -514,8 +514,6 @@ struct qmi_wlanfw_wlan_ini_resp_msg_v01 {
 int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 			      u32 mode);
 void ath11k_qmi_firmware_stop(struct ath11k_base *ab);
-void ath11k_qmi_event_work(struct work_struct *work);
-void ath11k_qmi_msg_recv_work(struct work_struct *work);
 void ath11k_qmi_deinit_service(struct ath11k_base *ab);
 int ath11k_qmi_init_service(struct ath11k_base *ab);
 void ath11k_qmi_free_resource(struct ath11k_base *ab);
-- 
2.34.1

