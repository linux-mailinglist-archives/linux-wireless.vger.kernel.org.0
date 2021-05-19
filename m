Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2983887E9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbhESHA0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 03:00:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4677 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbhESHAW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 03:00:22 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlNv25t05z1BP8T;
        Wed, 19 May 2021 14:56:14 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 14:58:55 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 14:58:55 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>, Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 2/3] rt2x00: remove leading spaces before tabs
Date:   Wed, 19 May 2021 14:55:44 +0800
Message-ID: <1621407345-10625-3-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621407345-10625-1-git-send-email-tanghui20@huawei.com>
References: <1621407345-10625-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are a few leading spaces before tabs and remove it by running the
following commard:

	$ find . -name '*.c' | xargs sed -r -i 's/^[ ]+\t/\t/'
	$ find . -name '*.h' | xargs sed -r -i 's/^[ ]+\t/\t/'

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 5264b0a..deddb0a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1037,7 +1037,7 @@ void rt2800_txdone_entry(struct queue_entry *entry, u32 status, __le32 *txwi,
 	 * FIXME: if we do not find matching entry, we tell that frame was
 	 * posted without any retries. We need to find a way to fix that
 	 * and provide retry count.
- 	 */
+	 */
 	if (unlikely((aggr == 1 && ampdu == 0 && real_mcs != mcs)) || !match) {
 		rt2800_rate_from_status(skbdesc, status, rt2x00dev->curr_band);
 		mcs = real_mcs;
-- 
2.8.1

