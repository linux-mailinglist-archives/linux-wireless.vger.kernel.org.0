Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F995547FF4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 08:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiFMGwX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 02:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiFMGwS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 02:52:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8171759B
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jun 2022 23:52:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25D6q9ED1019228, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25D6q9ED1019228
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jun 2022 14:52:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 14:52:09 +0800
Received: from localhost (172.16.16.131) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 13 Jun
 2022 14:52:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw89: 8852a: rfk: fix div 0 exception
Date:   Mon, 13 Jun 2022 14:51:44 +0800
Message-ID: <20220613065144.15647-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.131]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/13/2022 06:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTMgpFekyCAwNDoyMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The DPK is a kind of RF calibration whose algorithm is to fine tune
parameters and calibrate, and check the result. If the result isn't good
enough, it could adjust parameters and try again.

This issue is to read and show the result, but it could be a negative
calibration result that causes divisor 0 and core dump. So, fix it by
phy_div() that does division only if divisor isn't zero; otherwise,
zero is adopted.

  divide error: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 1 PID: 728 Comm: wpa_supplicant Not tainted 5.10.114-16019-g462a1661811a #1 <HASH:d024 28>
  RIP: 0010:rtw8852a_dpk+0x14ae/0x288f [rtw89_core]
  RSP: 0018:ffffa9bb412a7520 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 00000000000180fc RDI: ffffa141d01023c0
  RBP: ffffa9bb412a76a0 R08: 0000000000001319 R09: 00000000ffffff92
  R10: ffffffffc0292de3 R11: ffffffffc00d2f51 R12: 0000000000000000
  R13: ffffa141d01023c0 R14: ffffffffc0290250 R15: ffffa141d0102638
  FS:  00007fa99f5c2740(0000) GS:ffffa142e5e80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000013e8e010 CR3: 0000000110d2c000 CR4: 0000000000750ee0
  PKRU: 55555554
  Call Trace:
   rtw89_core_sta_add+0x95/0x9c [rtw89_core <HASH:d239 29>]
   rtw89_ops_sta_state+0x5d/0x108 [rtw89_core <HASH:d239 29>]
   drv_sta_state+0x115/0x66f [mac80211 <HASH:81fe 30>]
   sta_info_insert_rcu+0x45c/0x713 [mac80211 <HASH:81fe 30>]
   sta_info_insert+0xf/0x1b [mac80211 <HASH:81fe 30>]
   ieee80211_prep_connection+0x9d6/0xb0c [mac80211 <HASH:81fe 30>]
   ieee80211_mgd_auth+0x2aa/0x352 [mac80211 <HASH:81fe 30>]
   cfg80211_mlme_auth+0x160/0x1f6 [cfg80211 <HASH:00cd 31>]
   nl80211_authenticate+0x2e5/0x306 [cfg80211 <HASH:00cd 31>]
   genl_rcv_msg+0x371/0x3a1
   ? nl80211_stop_sched_scan+0xe5/0xe5 [cfg80211 <HASH:00cd 31>]
   ? genl_rcv+0x36/0x36
   netlink_rcv_skb+0x8a/0xf9
   genl_rcv+0x28/0x36
   netlink_unicast+0x27b/0x3a0
   netlink_sendmsg+0x2aa/0x469
   sock_sendmsg_nosec+0x49/0x4d
   ____sys_sendmsg+0xe5/0x213
   __sys_sendmsg+0xec/0x157
   ? syscall_enter_from_user_mode+0xd7/0x116
   do_syscall_64+0x43/0x55
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7fa99f6e689b

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index e3c2fce326516..3d60feb783121 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -2330,8 +2330,8 @@ static u8 _dpk_pas_read(struct rtw89_dev *rtwdev, bool is_check)
 		val2_q = abs(sign_extend32(val2_q, 11));
 
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] PAS_delta = 0x%x\n",
-			    (val1_i * val1_i + val1_q * val1_q) /
-			    (val2_i * val2_i + val2_q * val2_q));
+			    phy_div(val1_i * val1_i + val1_q * val1_q,
+				    val2_i * val2_i + val2_q * val2_q));
 
 	} else {
 		for (i = 0; i < 32; i++) {
-- 
2.25.1

