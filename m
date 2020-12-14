Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439BC2D91A2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 02:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437806AbgLNByC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Dec 2020 20:54:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58119 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437812AbgLNBxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Dec 2020 20:53:55 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BE1qqU23026825, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BE1qqU23026825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Dec 2020 09:52:52 +0800
Received: from localhost (172.21.69.213) by RTEXMB04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 14 Dec
 2020 09:52:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtlwifi: rise completion at the last step of firmware callback
Date:   Mon, 14 Dec 2020 09:52:38 +0800
Message-ID: <20201214015238.3245-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXH365.realtek.com.tw (172.21.6.37) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

request_firmware_nowait() which schedules another work is used to load
firmware when USB is probing. If USB is unplugged before running the
firmware work, it goes disconnect ops, and then causes use-after-free.
Though we wait for completion of firmware work before freeing the hw,
firmware callback rises completion too early. So I move it to the
last step.

usb 5-1: Direct firmware load for rtlwifi/rtl8192cufw.bin failed with error -2
rtlwifi: Loading alternative firmware rtlwifi/rtl8192cufw.bin
rtlwifi: Selected firmware is not available
==================================================================
BUG: KASAN: use-after-free in rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
Write of size 4 at addr ffff8881454cff50 by task kworker/0:6/7379

CPU: 0 PID: 7379 Comm: kworker/0:6 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
 request_firmware_work_func+0x12c/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x933/0x1520 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the page:
page:00000000f54435b3 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1454cf
flags: 0x200000000000000()
raw: 0200000000000000 0000000000000000 ffffea00051533c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881454cfe00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881454cfe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8881454cff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff8881454cff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881454d0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Reported-by: syzbot+65be4277f3c489293939@syzkaller.appspotmail.com
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index a7259dbc953d..67550cab716a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -78,7 +78,6 @@ static void rtl_fw_do_work(const struct firmware *firmware, void *context,
 
 	rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
 		"Firmware callback routine entered!\n");
-	complete(&rtlpriv->firmware_loading_complete);
 	if (!firmware) {
 		if (rtlpriv->cfg->alt_fw_name) {
 			err = request_firmware(&firmware,
@@ -91,13 +90,13 @@ static void rtl_fw_do_work(const struct firmware *firmware, void *context,
 		}
 		pr_err("Selected firmware is not available\n");
 		rtlpriv->max_fw_size = 0;
-		return;
+		goto exit;
 	}
 found_alt:
 	if (firmware->size > rtlpriv->max_fw_size) {
 		pr_err("Firmware is too big!\n");
 		release_firmware(firmware);
-		return;
+		goto exit;
 	}
 	if (!is_wow) {
 		memcpy(rtlpriv->rtlhal.pfirmware, firmware->data,
@@ -109,6 +108,9 @@ static void rtl_fw_do_work(const struct firmware *firmware, void *context,
 		rtlpriv->rtlhal.wowlan_fwsize = firmware->size;
 	}
 	release_firmware(firmware);
+
+exit;
+	complete(&rtlpriv->firmware_loading_complete);
 }
 
 void rtl_fw_cb(const struct firmware *firmware, void *context)
-- 
2.21.0

