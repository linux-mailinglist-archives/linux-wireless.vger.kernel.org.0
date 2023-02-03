Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821FF688D1F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 03:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBCChQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Feb 2023 21:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBCChP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Feb 2023 21:37:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E521A945
        for <linux-wireless@vger.kernel.org>; Thu,  2 Feb 2023 18:37:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3132au7F3019567, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3132au7F3019567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 3 Feb 2023 10:36:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 3 Feb 2023 10:37:02 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 3 Feb 2023
 10:37:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <johannes@sipsolutions.net>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: mac80211: make ieee80211_get_tx_power() return error if tx_power is INT_MIN
Date:   Fri, 3 Feb 2023 10:36:36 +0800
Message-ID: <20230203023636.4418-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

UBSAN warns if use_chanctx but not implement ops get_txpower(), because
sdata->vif.bss_conf.txpower is still INT_MIN during ieee80211_register_hw().
To fix this simply, return error to indicate dbm is invalid, and then
doesn't report the value to user space at that moment.

 UBSAN: signed-integer-overflow in net/wireless/nl80211.c:3816:5
 -2147483648 * 100 cannot be represented in type 'int'
 CPU: 0 PID: 20433 Comm: insmod Tainted: G        WC OE
 Call Trace:
  dump_stack+0x74/0x92
  ubsan_epilogue+0x9/0x50
  handle_overflow+0x8d/0xd0
  ? nla_put+0x5e/0xc0
  __ubsan_handle_mul_overflow+0xe/0x10
  nl80211_send_iface+0x688/0x6b0 [cfg80211]
  ? __alloc_skb+0x9b/0x1f0
  nl80211_notify_iface+0x4d/0xb0 [cfg80211]
  cfg80211_register_wdev+0x78/0xb0 [cfg80211]
  cfg80211_netdev_notifier_call+0x200/0x620 [cfg80211]
  ? _raw_spin_unlock_bh+0x1e/0x20
  ? igmp6_group_added+0x6f/0xe0
  ? _raw_spin_unlock_bh+0x1e/0x20
  ? mld_del_delrec+0xf8/0x170
  ? __ipv6_dev_mc_inc+0x1fe/0x460
  ? ipv6_dev_mc_inc+0x10/0x20
  ? ipv6_add_dev+0x476/0x630
  ? addrconf_notify+0x31a/0xcf0
  ? inetdev_init+0x11a/0x1d0
  ? inetdev_event+0x4c2/0x640
  ? skb_dequeue+0x60/0x70
  raw_notifier_call_chain+0x5c/0xa0
  call_netdevice_notifiers_info+0x52/0xb0
  register_netdevice+0x53e/0x640
  ieee80211_if_add+0x60e/0x8f0 [mac80211]
  ieee80211_register_hw+0xda5/0x1170 [mac80211]
  ? ieee80211_register_hw+0xda5/0x1170 [mac80211]
  ? rtw89_regd_init+0xf0/0xf0 [rtw89_core]
  rtw89_core_register+0x206/0x860 [rtw89_core]
  rtw89_pci_probe+0x7fe/0xce0 [rtw89_pci]
  local_pci_probe+0x47/0xa0

Cc: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 net/mac80211/cfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f5d43f42f6d8a..d70198420e527 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3033,6 +3033,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	else
 		*dbm = sdata->vif.bss_conf.txpower;
 
+	/* With use_chanctx, txpower could be INT_MIN causing UBSAN warning. */
+	if (*dbm == INT_MIN)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.25.1

