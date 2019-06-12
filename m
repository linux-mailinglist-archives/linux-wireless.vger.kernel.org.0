Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF6041C80
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404510AbfFLGpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 02:45:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51313 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbfFLGpj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 02:45:39 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5C6jZqQ004392, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5C6jZqQ004392
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 14:45:35 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 14:45:34 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 11/11] rtw88: fix typo rtw_writ16_set
Date:   Wed, 12 Jun 2019 14:45:17 +0800
Message-ID: <1560321917-17751-12-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
References: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

rtw_writ16_set should be rtw_write16_set

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/hci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 2676582..aba329c 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -97,7 +97,7 @@ static inline void rtw_write8_set(struct rtw_dev *rtwdev, u32 addr, u8 bit)
 	rtw_write8(rtwdev, addr, val | bit);
 }
 
-static inline void rtw_writ16_set(struct rtw_dev *rtwdev, u32 addr, u16 bit)
+static inline void rtw_write16_set(struct rtw_dev *rtwdev, u32 addr, u16 bit)
 {
 	u16 val;
 
-- 
2.7.4

