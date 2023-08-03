Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314E076EB08
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbjHCNpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbjHCNoj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 09:44:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B213E;
        Thu,  3 Aug 2023 06:42:54 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RGqj50yKpzJrBM;
        Thu,  3 Aug 2023 21:40:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 21:42:52 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <yuehaibing@huawei.com>
CC:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH] wifi: iw_handler.h: Remove unused declaration dev_get_wireless_info()
Date:   Thu, 3 Aug 2023 21:42:48 +0800
Message-ID: <20230803134248.42652-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
declared but never implemented this, remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/iw_handler.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index d2ea5863eedc..99f46f521aa7 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -432,9 +432,6 @@ struct iw_public_data {
 
 /* First : function strictly used inside the kernel */
 
-/* Handle /proc/net/wireless, called in net/code/dev.c */
-int dev_get_wireless_info(char *buffer, char **start, off_t offset, int length);
-
 /* Second : functions that may be called by driver modules */
 
 /* Send a single event to user space */
-- 
2.34.1

