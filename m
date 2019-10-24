Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD02E2D16
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 11:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393040AbfJXJUa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 05:20:30 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50991 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389413AbfJXJUa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 05:20:30 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9O9KP7n031233, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9O9KP7n031233
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 24 Oct 2019 17:20:25 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 24 Oct 2019 17:20:24 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw88: fix GENMASK_ULL for u64
Date:   Thu, 24 Oct 2019 17:19:48 +0800
Message-ID: <20191024091948.10569-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This fixes compile warning:

    In file included from include/linux/bitops.h:5:0,
                     from include/linux/kernel.h:12,
                     from include/asm-generic/bug.h:19,
                     from arch/mips/include/asm/bug.h:42,
                     from include/linux/bug.h:5,
                     from include/net/mac80211.h:16,
                     from drivers/net/wireless/realtek/rtw88/main.h:8,
                     from drivers/net/wireless/realtek/rtw88/main.c:5:
    drivers/net/wireless/realtek/rtw88/main.c: In function 'rtw_update_rate_mask':
      include/linux/bits.h:23:11: warning: right shift count is negative
      [-Wshift-count-negative]
       (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
               ^
    drivers/net/wireless/realtek/rtw88/main.c:622:17: note: in expansion of macro 'GENMASK'
      u64 cfg_mask = GENMASK(63, 0);
                     ^~~~~~~

Fixes: f39e9bd49a3d ("rtw88: add set_bitrate_mask support")
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 32e7328ce126..7c1b89c4fb6c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -627,7 +627,7 @@ static u64 rtw_update_rate_mask(struct rtw_dev *rtwdev,
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	const struct cfg80211_bitrate_mask *mask = si->mask;
-	u64 cfg_mask = GENMASK(63, 0);
+	u64 cfg_mask = GENMASK_ULL(63, 0);
 	u8 rssi_level, band;
 
 	if (wireless_set != WIRELESS_CCK) {
-- 
2.17.1

