Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CED1B71B0
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDXKNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:13:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36110 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgDXKNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:13:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03OACvQV2030521, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03OACvQV2030521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Apr 2020 18:12:57 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 18:12:56 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Apr 2020 18:12:56 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw88: fix sparse warnings for download firmware routine
Date:   Fri, 24 Apr 2020 18:12:55 +0800
Message-ID: <20200424101255.28239-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/realtek/rtw88/mac.c:653:5: sparse: sparse:
symbol '__rtw_download_firmware' was not declared. Should it be static?
>> drivers/net/wireless/realtek/rtw88/mac.c:817:5: sparse: sparse:
symbol '__rtw_download_firmware_legacy' was not declared. Should it be
static?

Fixes: 15d2fcc6b2de ("rtw88: add legacy firmware download for 8723D devices")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 645207a01525..6969379ba37e 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -696,7 +696,8 @@ static void download_firmware_end_flow(struct rtw_dev *rtwdev)
 	rtw_write16(rtwdev, REG_MCUFW_CTRL, fw_ctrl);
 }
 
-int __rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+static int __rtw_download_firmware(struct rtw_dev *rtwdev,
+				   struct rtw_fw_state *fw)
 {
 	struct rtw_backup_info bckp[DLFW_RESTORE_REG_NUM];
 	const u8 *data = fw->firmware->data;
@@ -860,7 +861,8 @@ static int download_firmware_validate_legacy(struct rtw_dev *rtwdev)
 	return -EINVAL;
 }
 
-int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+static int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev,
+					  struct rtw_fw_state *fw)
 {
 	int ret = 0;
 
-- 
2.17.1

