Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD83956A8
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 10:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhEaIJn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 04:09:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3303 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhEaIJl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 04:09:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ftnpw255vz1BGvl;
        Mon, 31 May 2021 16:03:20 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 16:07:53 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 16:07:52 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] ath10k: remove the repeated declaration
Date:   Mon, 31 May 2021 16:07:39 +0800
Message-ID: <1622448459-50805-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Functions 'ath10k_pci_free_pipes' and 'ath10k_wmi_alloc_skb'
are declared twice in their header file, so remove the repeated
declaration.

Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/net/wireless/ath/ath10k/pci.h | 1 -
 drivers/net/wireless/ath/ath10k/wmi.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
index 862d0901c5b8..cf64898b9447 100644
--- a/drivers/net/wireless/ath/ath10k/pci.h
+++ b/drivers/net/wireless/ath/ath10k/pci.h
@@ -235,7 +235,6 @@ u16 ath10k_pci_hif_get_free_queue_number(struct ath10k *ar, u8 pipe);
 void ath10k_pci_hif_power_down(struct ath10k *ar);
 int ath10k_pci_alloc_pipes(struct ath10k *ar);
 void ath10k_pci_free_pipes(struct ath10k *ar);
-void ath10k_pci_free_pipes(struct ath10k *ar);
 void ath10k_pci_rx_replenish_retry(struct timer_list *t);
 void ath10k_pci_ce_deinit(struct ath10k *ar);
 void ath10k_pci_init_napi(struct ath10k *ar);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index d870f7067cb7..0b7c3348a328 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -7418,7 +7418,6 @@ int ath10k_wmi_wait_for_unified_ready(struct ath10k *ar);
 struct sk_buff *ath10k_wmi_alloc_skb(struct ath10k *ar, u32 len);
 int ath10k_wmi_connect(struct ath10k *ar);
 
-struct sk_buff *ath10k_wmi_alloc_skb(struct ath10k *ar, u32 len);
 int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id);
 int ath10k_wmi_cmd_send_nowait(struct ath10k *ar, struct sk_buff *skb,
 			       u32 cmd_id);
-- 
2.7.4

