Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB766D92C5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjDFJb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjDFJb4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 05:31:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED2F8A6C
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 02:31:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3369V3n84000582, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3369V3n84000582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 6 Apr 2023 17:31:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 17:31:23 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 6 Apr 2023
 17:31:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: fix crash due to null pointer of sta in AP mode
Date:   Thu, 6 Apr 2023 17:30:09 +0800
Message-ID: <20230406093009.5869-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In AP mode, 'sta' could be NULL if sending broadcast/multicast packets,
so we should check before accessing, or it causes crash:

  BUG: kernel NULL pointer dereference, address: 0000000000000004
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP PTI
  CPU: 2 PID: 92 Comm: kworker/u33:0 Tainted: G           OE
  Workqueue: rtw89_tx_wq rtw89_core_txq_work [rtw89_core]
  RIP: 0010:rtw89_core_tx_update_desc_info+0x2cc/0x7d0 [rtw89_core]
  Code: e2 01 41 be 04 00 00 00 41 8b 84 c4 0c 01 00 00 75 0d 45 31 f6 ...
  RSP: 0018:ffffb4cf807afce0 EFLAGS: 00010297
  RAX: 0000000000000001 RBX: ffffb4cf807afd48 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
  RBP: ffffb4cf807afd30 R08: ffff9b28c1e59808 R09: ffff9b28c0297100
  R10: 00000000052cf7c4 R11: 00000000052cf7c4 R12: ffff9b28c1602040
  R13: ffff9b28c07b3000 R14: 0000000000000004 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff9b2a73280000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000004 CR3: 00000001ca410003 CR4: 00000000000606e0
  Call Trace:
   <TASK>
   rtw89_core_tx_write+0x7c/0x100 [rtw89_core]
   rtw89_core_txq_work+0x1b4/0x530 [rtw89_core]
   process_one_work+0x222/0x3f0
   worker_thread+0x50/0x3f0
   kthread+0x16b/0x190
   ? rescuer_thread+0x3a0/0x3a0
   ? set_kthread_struct+0x50/0x50
   ret_from_fork+0x22/0x30
   </TASK>

Fixes: e5307c9cd7ee ("wifi: rtw89: set data lowest rate according to AP supported rate")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 56a13be2e2833..194f64e8a8468 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -707,7 +707,7 @@ static u16 rtw89_core_get_data_rate(struct rtw89_dev *rtwdev,
 	else
 		lowest_rate = RTW89_HW_RATE_OFDM6;
 
-	if (!sta->deflink.supp_rates[chan->band_type])
+	if (!sta || !sta->deflink.supp_rates[chan->band_type])
 		return lowest_rate;
 
 	return __ffs(sta->deflink.supp_rates[chan->band_type]) + lowest_rate;
-- 
2.25.1

