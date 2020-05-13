Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26911D043E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 03:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbgEMBSx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 21:18:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728131AbgEMBSx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 21:18:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CEC732CC98540DDD5EB9;
        Wed, 13 May 2020 09:18:50 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 13 May 2020
 09:18:41 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <mark@fasheh.com>, <herton@canonical.com>,
        <htl10@users.sourceforge.net>, <Larry.Finger@lwfinger.net>,
        <kvalo@codeaurora.org>
CC:     <davem@davemloft.net>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH -next v2] rtl8187: Remove unused variable rtl8225z2_tx_power_ofdm
Date:   Wed, 13 May 2020 09:17:54 +0800
Message-ID: <20200513011754.28432-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following warning:

drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c:609:17: warning:
‘rtl8225z2_tx_power_ofdm’ defined but not used
 static const u8 rtl8225z2_tx_power_ofdm[] = {

Acked-by: Hin-Tak Leung <htl10@users.sourceforge.net>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
v1->v2:
- change the subject

 drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
index b2616d61b66d..585784258c66 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
@@ -606,10 +606,6 @@ static const u8 rtl8225z2_tx_power_cck[] = {
 	0x26, 0x25, 0x21, 0x1b, 0x14, 0x0d, 0x06, 0x03
 };
 
-static const u8 rtl8225z2_tx_power_ofdm[] = {
-	0x42, 0x00, 0x40, 0x00, 0x40
-};
-
 static const u8 rtl8225z2_tx_gain_cck_ofdm[] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
 	0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b,
-- 
2.22.0

