Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EEA1BA18E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 12:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgD0Kmm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 06:42:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgD0Kmm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 06:42:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C946FC3326C60500B4D3;
        Mon, 27 Apr 2020 18:42:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 18:42:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Wen Gong <wgong@codeaurora.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] ath10k: fix possible memory leak in ath10k_bmi_lz_data_large()
Date:   Mon, 27 Apr 2020 10:43:48 +0000
Message-ID: <20200427104348.13570-1-weiyongjun1@huawei.com>
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

'cmd' is malloced in ath10k_bmi_lz_data_large() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: d58f466a5dee ("ath10k: add large size for BMI download data for SDIO")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/wireless/ath/ath10k/bmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/bmi.c b/drivers/net/wireless/ath/ath10k/bmi.c
index ea908107581d..5b6db6e66f65 100644
--- a/drivers/net/wireless/ath/ath10k/bmi.c
+++ b/drivers/net/wireless/ath/ath10k/bmi.c
@@ -380,6 +380,7 @@ static int ath10k_bmi_lz_data_large(struct ath10k *ar, const void *buffer, u32 l
 						  NULL, NULL);
 		if (ret) {
 			ath10k_warn(ar, "unable to write to the device\n");
+			kfree(cmd);
 			return ret;
 		}



