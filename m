Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5323814472
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 08:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfEFGYA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 02:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfEFGYA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 02:24:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36996308FE8D;
        Mon,  6 May 2019 06:24:00 +0000 (UTC)
Received: from localhost (ovpn-204-123.brq.redhat.com [10.40.204.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A67135D9CD;
        Mon,  6 May 2019 06:23:59 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: [PATCH 5.1] rtw88: fix subscript above array bounds compiler warning
Date:   Mon,  6 May 2019 08:23:58 +0200
Message-Id: <20190506062358.8288-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 06 May 2019 06:24:00 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My compiler complains about:

drivers/net/wireless/realtek/rtw88/phy.c: In function ‘rtw_phy_rf_power_2_rssi’:
drivers/net/wireless/realtek/rtw88/phy.c:430:26: warning: array subscript is above array bounds [-Warray-bounds]
  linear = db_invert_table[i][j];

According to comment power_db should be in range 1 ~ 96 .
To fix add check for boundaries before access the array.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
RFC -> v1
- add check before accessing the array insted of
  rtw_phy_power_2_db() change.

 drivers/net/wireless/realtek/rtw88/phy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 4381b360b5b5..9ca52a4d025a 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -423,6 +423,11 @@ static u64 rtw_phy_db_2_linear(u8 power_db)
 	u8 i, j;
 	u64 linear;
 
+	if (power_db > 96)
+		power_db = 96;
+	else if (power_db < 1)
+		power_db = 1;
+
 	/* 1dB ~ 96dB */
 	i = (power_db - 1) >> 3;
 	j = (power_db - 1) - (i << 3);
-- 
2.20.1

