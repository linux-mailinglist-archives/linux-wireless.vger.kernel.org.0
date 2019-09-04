Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA396A8785
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfIDN6W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 09:58:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729677AbfIDN6W (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 09:58:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F329485DB3A85469E95C;
        Wed,  4 Sep 2019 21:58:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 21:58:14 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH] rtlwifi: Fix file release memory leak
Date:   Wed, 4 Sep 2019 14:16:11 +0000
Message-ID: <20190904141611.4780-1-weiyongjun1@huawei.com>
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

When using single_open() for opening, single_release() should be
used instead of seq_release(), otherwise there is a memory leak.

This is detected by Coccinelle semantic patch.

Fixes: 610247f46feb ("rtlwifi: Improve debugging by using debugfs")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/wireless/realtek/rtlwifi/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index a051de16284d..55db71c766fe 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -88,7 +88,7 @@ static const struct file_operations file_ops_common = {
 	.open = dl_debug_open_common,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = single_release,
 };
 
 static int rtl_debug_get_mac_page(struct seq_file *m, void *v)



