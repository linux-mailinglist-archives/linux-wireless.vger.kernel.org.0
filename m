Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0561BA19C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 12:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgD0KpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 06:45:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbgD0KpP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 06:45:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 857609184C37FC15E13C;
        Mon, 27 Apr 2020 18:45:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 18:45:01 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kalle Valo <kvalo@codeaurora.org>, John Crispin <john@phrozen.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] ath11k: fix error return code in ath11k_dp_alloc()
Date:   Mon, 27 Apr 2020 10:46:21 +0000
Message-ID: <20200427104621.23752-1-weiyongjun1@huawei.com>
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

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: d0998eb84ed3 ("ath11k: optimise ath11k_dp_tx_completion_handler")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/wireless/ath/ath11k/dp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 50350f77b309..2f35d325f7a5 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -909,8 +909,10 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 		dp->tx_ring[i].tx_status_head = 0;
 		dp->tx_ring[i].tx_status_tail = DP_TX_COMP_RING_SIZE - 1;
 		dp->tx_ring[i].tx_status = kmalloc(size, GFP_KERNEL);
-		if (!dp->tx_ring[i].tx_status)
+		if (!dp->tx_ring[i].tx_status) {
+			ret = -ENOMEM;
 			goto fail_cmn_srng_cleanup;
+		}
 	}
 
 	for (i = 0; i < HAL_DSCP_TID_MAP_TBL_NUM_ENTRIES_MAX; i++)



