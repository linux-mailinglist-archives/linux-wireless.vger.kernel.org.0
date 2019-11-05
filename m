Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72172EF7BF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfKEJGI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:06:08 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39359 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfKEJGI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:06:08 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA594jvo004848, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA594jvo004848
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 5 Nov 2019 17:04:45 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 5 Nov 2019 17:04:45 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <dan.carpenter@oracle.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw88: fix potential NULL pointer access for firmware
Date:   Tue, 5 Nov 2019 17:04:42 +0800
Message-ID: <20191105090442.8378-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Driver could access a NULL firmware pointer if we don't
return here.

Fixes: 5195b90426409 ("rtw88: avoid FW info flood")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 021668f1b74f..de82d08ea29e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1024,8 +1024,10 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 	struct rtw_fw_state *fw = &rtwdev->fw;
 	const struct rtw_fw_hdr *fw_hdr;
 
-	if (!firmware)
+	if (!firmware || !firmware->data) {
 		rtw_err(rtwdev, "failed to request firmware\n");
+		return;
+	}
 
 	fw_hdr = (const struct rtw_fw_hdr *)firmware->data;
 	fw->h2c_version = le16_to_cpu(fw_hdr->h2c_fmt_ver);
-- 
2.17.1

