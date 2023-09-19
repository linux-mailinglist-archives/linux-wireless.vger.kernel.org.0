Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8417A5926
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 07:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjISFHj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 01:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISFHi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 01:07:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB57FD
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 22:07:31 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RqV1k1PJtzMlKC;
        Tue, 19 Sep 2023 13:03:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 13:07:27 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-wireless@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2] rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()
Date:   Tue, 19 Sep 2023 13:06:50 +0800
Message-ID: <20230919050651.962694-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since debugfs_create_file() return ERR_PTR and never return NULL, so use
IS_ERR() to check it instead of checking NULL.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
- Fix typo "Fix Fix" in subject.
- Add Acked-by.
---
 drivers/net/wireless/realtek/rtw88/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index f8ba133baff0..35bc37a3c469 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -1233,9 +1233,9 @@ static struct rtw_debugfs_priv rtw_debug_priv_dm_cap = {
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
-		if (!debugfs_create_file(#name, mode,			\
+		if (IS_ERR(debugfs_create_file(#name, mode,		\
 					 parent, &rtw_debug_priv_ ##name,\
-					 &file_ops_ ##fopname))		\
+					 &file_ops_ ##fopname)))	\
 			pr_debug("Unable to initialize debugfs:%s\n",	\
 			       #name);					\
 	} while (0)
-- 
2.34.1

