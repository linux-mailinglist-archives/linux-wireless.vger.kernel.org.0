Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C0CEF350
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 03:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfKECTC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 21:19:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:34592 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfKECTB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 21:19:01 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA52IfSP024659, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA52IfSP024659
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 5 Nov 2019 10:18:42 +0800
Received: from localhost.localdomain (172.21.69.95) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 5 Nov 2019 10:18:41 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <wahrenst@gmx.net>
Subject: [PATCH] rtlwifi: fix memory leak in rtl92c_set_fw_rsvdpagepkt()
Date:   Tue, 5 Nov 2019 10:18:38 +0800
Message-ID: <20191105021838.4302-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.95]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

This leak was found by testing the EDIMAX EW-7612 on Raspberry Pi 3B+ with
Linux 5.4-rc5 (multi_v7_defconfig + rtlwifi + kmemleak) and noticed a
single memory leak during probe:

unreferenced object 0xec13ee40 (size 176):
  comm "kworker/u8:1", pid 36, jiffies 4294939321 (age 5580.790s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<fc1bbb3e>] __netdev_alloc_skb+0x9c/0x164
    [<863dfa6e>] rtl92c_set_fw_rsvdpagepkt+0x254/0x340 [rtl8192c_common]
    [<9572be0d>] rtl92cu_set_hw_reg+0xf48/0xfa4 [rtl8192cu]
    [<116df4d8>] rtl_op_bss_info_changed+0x234/0x96c [rtlwifi]
    [<8933575f>] ieee80211_bss_info_change_notify+0xb8/0x264 [mac80211]
    [<d4061e86>] ieee80211_assoc_success+0x934/0x1798 [mac80211]
    [<e55adb56>] ieee80211_rx_mgmt_assoc_resp+0x174/0x314 [mac80211]
    [<5974629e>] ieee80211_sta_rx_queued_mgmt+0x3f4/0x7f0 [mac80211]
    [<d91091c6>] ieee80211_iface_work+0x208/0x318 [mac80211]
    [<ac5fcae4>] process_one_work+0x22c/0x564
    [<f5e6d3b6>] worker_thread+0x44/0x5d8
    [<82c7b073>] kthread+0x150/0x154
    [<b43e1b7d>] ret_from_fork+0x14/0x2c
    [<794dff30>] 0x0

It is because 8192cu doesn't implement usb_cmd_send_packet(), and this
patch just frees the skb within the function to resolve memleak problem
by now. Since 8192cu doesn't turn on fwctrl_lps that needs to download
command packet for firmware via the function, applying this patch doesn't
affect driver behavior.

Reported-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index 56cc3bc30860..f070f25bb735 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -1540,6 +1540,8 @@ static bool usb_cmd_send_packet(struct ieee80211_hw *hw, struct sk_buff *skb)
    * This is maybe necessary:
    * rtlpriv->cfg->ops->fill_tx_cmddesc(hw, buffer, 1, 1, skb);
    */
+	dev_kfree_skb(skb);
+
 	return true;
 }
 
-- 
2.21.0

