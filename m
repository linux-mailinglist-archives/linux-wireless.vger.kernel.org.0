Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95DA12B84
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfECKcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 06:32:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48822 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfECKcU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 06:32:20 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43AWGMY012128, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43AWGMY012128
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 18:32:16 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 3 May 2019 18:32:15 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] rtw88: mac: remove dangerous while (1)
Date:   Fri, 3 May 2019 18:31:41 +0800
Message-ID: <1556879502-16211-6-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Not to use while (1) to parse power sequence commands in an array.
Put the statement (when cmd is not NULL) instead to make the loop stop
when the next fetched command is NULL.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 25a923b..7487b2e 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -203,17 +203,14 @@ static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
 		return -EINVAL;
 	}
 
-	do {
-		cmd = cmd_seq[idx];
-		if (!cmd)
-			break;
-
+	while ((cmd = cmd_seq[idx])) {
 		ret = rtw_sub_pwr_seq_parser(rtwdev, intf_mask, cut_mask, cmd);
 		if (ret)
 			return -EBUSY;
 
+		/* fetch next command */
 		idx++;
-	} while (1);
+	};
 
 	return 0;
 }
-- 
2.7.4

