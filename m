Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E56F1B84E8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 10:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYIxt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 04:53:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgDYIxt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 04:53:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 64120748827E0978C76B;
        Sat, 25 Apr 2020 16:53:47 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Apr 2020
 16:53:40 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <yhchuang@realtek.com>, <kvalo@codeaurora.org>
CC:     <davem@davemloft.net>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chentao107@huawei.com>
Subject: [PATCH] rtw88: mac: Make some functions static
Date:   Sat, 25 Apr 2020 16:53:04 +0800
Message-ID: <20200425085304.153077-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following warning:

vers/net/wireless/realtek/rtw88/mac.c:699:5: warning:
symbol '__rtw_download_firmware' was not declared. Should it be static?
drivers/net/wireless/realtek/rtw88/mac.c:863:5: warning:
symbol '__rtw_download_firmware_legacy' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 645207a01525..f5bf5bab9454 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -696,7 +696,7 @@ static void download_firmware_end_flow(struct rtw_dev *rtwdev)
 	rtw_write16(rtwdev, REG_MCUFW_CTRL, fw_ctrl);
 }
 
-int __rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+static int __rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 {
 	struct rtw_backup_info bckp[DLFW_RESTORE_REG_NUM];
 	const u8 *data = fw->firmware->data;
@@ -860,7 +860,7 @@ static int download_firmware_validate_legacy(struct rtw_dev *rtwdev)
 	return -EINVAL;
 }
 
-int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+static int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 {
 	int ret = 0;
 
-- 
2.22.0

