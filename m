Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652DF42B50
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfFLPyn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 11:54:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:45134 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbfFLPyn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 11:54:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CFsREA006600;
        Wed, 12 Jun 2019 08:54:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=onwj0RHtYUBYDVrGxVGjHD/TMaDqZ252h+zdeBbEBqo=;
 b=uRD1LyzXe39OUIsV25HYMeB+5EnNeZurSaxSvyQNQ6N4SY3DdaDFDtUd45DaQ+nFCAes
 N0k1hGPdusYe0H1M1WPZcnDjFmk1tyxt/gMxHczsflEiBOtgQvgL9aRCzjRIBB8gu6o4
 nnSKbKDaBoRuYts+sDwwz4ejMBNpSPpJ43KcRCaNNAr3zsRAvVsLN07gkLpb3PDLpwNp
 t7Jl38n07jp2yBI7UUYDhvAywSt35k+197Zhc3vlL9/QzQapAvYxGFBbG4yTvA23eStk
 IwXSeLnlNkGRsistxtWFoPhiQk1AltSqUPSLwgJv6I2fzcvA4zzGytuAFiPYe8CWp6oT gw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t2r82awhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Jun 2019 08:54:39 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 08:54:38 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 12 Jun 2019 08:54:38 -0700
Received: from gbhat-ThinkPad-T430.marvell.com (gbhat-thinkpad-t430.marvell.com [10.31.176.18])
        by maili.marvell.com (Postfix) with ESMTP id D40EF3F703F;
        Wed, 12 Jun 2019 08:54:35 -0700 (PDT)
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Ganapathi Bhat" <gbhat@marvell.com>
Subject: [PATCH] mwifiex: avoid deleting uninitialized timer during USB cleanup
Date:   Wed, 12 Jun 2019 21:24:33 +0530
Message-ID: <1560354873-17182-1-git-send-email-gbhat@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_09:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Driver calls del_timer_sync(hold_timer), in unregister_dev(), but
there exists is a case when the timer is yet to be initialized. A
restructure of init and cleanup is needed to synchronize timer
creation and delee. Make use of init_if() / cleanup_if() handlers
to get this done.

Reported-by: syzbot+373e6719b49912399d21@syzkaller.appspotmail.com
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 drivers/net/wireless/marvell/mwifiex/usb.c | 32 +++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index c2365ee..939f1e9 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -1348,6 +1348,8 @@ static void mwifiex_usb_cleanup_tx_aggr(struct mwifiex_adapter *adapter)
 
 	for (idx = 0; idx < MWIFIEX_TX_DATA_PORT; idx++) {
 		port = &card->port[idx];
+		if (!port->tx_data_ep)
+			continue;
 		if (adapter->bus_aggr.enable)
 			while ((skb_tmp =
 				skb_dequeue(&port->tx_aggr.aggr_list)))
@@ -1365,8 +1367,6 @@ static void mwifiex_unregister_dev(struct mwifiex_adapter *adapter)
 
 	mwifiex_usb_free(card);
 
-	mwifiex_usb_cleanup_tx_aggr(adapter);
-
 	card->adapter = NULL;
 }
 
@@ -1510,7 +1510,7 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
 static int mwifiex_usb_dnld_fw(struct mwifiex_adapter *adapter,
 			struct mwifiex_fw_image *fw)
 {
-	int ret;
+	int ret = 0;
 	struct usb_card_rec *card = (struct usb_card_rec *)adapter->card;
 
 	if (card->usb_boot_state == USB8XXX_FW_DNLD) {
@@ -1523,10 +1523,6 @@ static int mwifiex_usb_dnld_fw(struct mwifiex_adapter *adapter,
 			return -1;
 	}
 
-	ret = mwifiex_usb_rx_init(adapter);
-	if (!ret)
-		ret = mwifiex_usb_tx_init(adapter);
-
 	return ret;
 }
 
@@ -1584,7 +1580,29 @@ static void mwifiex_usb_submit_rem_rx_urbs(struct mwifiex_adapter *adapter)
 	return 0;
 }
 
+static int mwifiex_init_usb(struct mwifiex_adapter *adapter)
+{
+	struct usb_card_rec *card = (struct usb_card_rec *)adapter->card;
+	int ret = 0;
+
+	if (card->usb_boot_state == USB8XXX_FW_DNLD)
+		return 0;
+
+	ret = mwifiex_usb_rx_init(adapter);
+	if (!ret)
+		ret = mwifiex_usb_tx_init(adapter);
+
+	return ret;
+}
+
+static void mwifiex_cleanup_usb(struct mwifiex_adapter *adapter)
+{
+	mwifiex_usb_cleanup_tx_aggr(adapter);
+}
+
 static struct mwifiex_if_ops usb_ops = {
+	.init_if =		mwifiex_init_usb,
+	.cleanup_if =		mwifiex_cleanup_usb,
 	.register_dev =		mwifiex_register_dev,
 	.unregister_dev =	mwifiex_unregister_dev,
 	.wakeup =		mwifiex_pm_wakeup_card,
-- 
1.9.1

