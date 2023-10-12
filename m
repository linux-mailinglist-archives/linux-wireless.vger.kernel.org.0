Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607F27C700E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbjJLOIi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjJLOIh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 10:08:37 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 07:08:35 PDT
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617D9BB
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 07:08:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.61.141.228])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 1A011800080;
        Thu, 12 Oct 2023 22:01:24 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF mode table fail
Date:   Thu, 12 Oct 2023 22:01:20 +0800
Message-Id: <20231012140120.891411-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTB8fVksdThodSUwfSE0dTVUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPSlVJSUNZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b24312c1fb03akuuu1a011800080
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OD46EDo6AjwrTQtONFEjNTkR
        MhowCwxVSlVKTUJMSkpCSUNPTExLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPSlVJSUNZV1kIAVlBSkJIQjcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rtw88 driver throws a useless Call Trace when the rtl8812bu
or rtl8822be wifi modules fail to write the RF mode table.
Since this does not affect normal use of the wifi modules,
replace WARN() with driver warning to avoid useless panic.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 3017a9760da8..06b6efcd16d2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -820,8 +820,10 @@ static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
 			break;
 	}
 
-	if (WARN(counter <= 0, "write RF mode table fail\n"))
+	if (counter <= 0) {
+		rtw_warn(rtwdev, "write RF mode table fail\n");
 		return;
+	}
 
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE, RFREG_MASK, 0x80000);
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, RFREG_MASK, 0x00001);
-- 
2.25.1

