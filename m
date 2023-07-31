Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66B7696B1
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jul 2023 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjGaMqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjGaMpk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 08:45:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB119A1
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 05:45:34 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDycJ0C7QzrS2Q;
        Mon, 31 Jul 2023 20:44:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 20:45:31 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <toke@toke.dk>, <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] ath9k: Remove unnecessary ternary operators
Date:   Mon, 31 Jul 2023 20:44:55 +0800
Message-ID: <20230731124455.2039184-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ther are a little ternary operators, the true or false judgement
of which is unnecessary in C language semantics.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/wireless/ath/ath9k/eeprom_9287.c  | 3 +--
 drivers/net/wireless/ath/ath9k/hif_usb.c      | 2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom_9287.c b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
index 3caa149b1013..fd5312c2a7e3 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_9287.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
@@ -572,8 +572,7 @@ static void ath9k_hw_set_ar9287_power_per_rate_table(struct ath_hw *ah,
 	}
 
 	for (ctlMode = 0; ctlMode < numCtlModes; ctlMode++) {
-		bool isHt40CtlMode =
-			(pCtlMode[ctlMode] == CTL_2GHT40) ? true : false;
+		bool isHt40CtlMode = pCtlMode[ctlMode] == CTL_2GHT40;
 
 		if (isHt40CtlMode)
 			freq = centers.synth_center;
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 27ff1ca2631f..e5414435b141 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1432,7 +1432,7 @@ static void ath9k_hif_usb_disconnect(struct usb_interface *interface)
 {
 	struct usb_device *udev = interface_to_usbdev(interface);
 	struct hif_device_usb *hif_dev = usb_get_intfdata(interface);
-	bool unplugged = (udev->state == USB_STATE_NOTATTACHED) ? true : false;
+	bool unplugged = udev->state == USB_STATE_NOTATTACHED;
 
 	if (!hif_dev)
 		return;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 51766de5ec3b..44e02cfe2438 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -719,7 +719,7 @@ static int ath9k_htc_tx_aggr_oper(struct ath9k_htc_priv *priv,
 
 	aggr.sta_index = ista->index;
 	aggr.tidno = tid & 0xf;
-	aggr.aggr_enable = (action == IEEE80211_AMPDU_TX_START) ? true : false;
+	aggr.aggr_enable = action == IEEE80211_AMPDU_TX_START;
 
 	WMI_CMD_BUF(WMI_TX_AGGR_ENABLE_CMDID, &aggr);
 	if (ret)
-- 
2.34.1

