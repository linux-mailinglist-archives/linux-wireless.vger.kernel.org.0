Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC191B9FC8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgD0JXP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 05:23:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbgD0JXP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 05:23:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8CF3AB6057CBCDBA4051;
        Mon, 27 Apr 2020 17:23:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 17:22:57 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] ath11k: use GFP_ATOMIC under spin lock
Date:   Mon, 27 Apr 2020 09:24:17 +0000
Message-ID: <20200427092417.56236-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A spin lock is taken here so we should use GFP_ATOMIC.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index f74a0e74bf3e..34b1e8e6a7fb 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -892,7 +892,7 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 	else
 		hw_desc_sz = ath11k_hal_reo_qdesc_size(DP_BA_WIN_SZ_MAX, tid);
 
-	vaddr = kzalloc(hw_desc_sz + HAL_LINK_DESC_ALIGN - 1, GFP_KERNEL);
+	vaddr = kzalloc(hw_desc_sz + HAL_LINK_DESC_ALIGN - 1, GFP_ATOMIC);
 	if (!vaddr) {
 		spin_unlock_bh(&ab->base_lock);
 		return -ENOMEM;



