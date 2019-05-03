Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09912CF0
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfECLxg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfECLxg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:53:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DC3D5277B;
        Fri,  3 May 2019 11:53:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC7CC5C6AA;
        Fri,  3 May 2019 11:53:35 +0000 (UTC)
Date:   Fri, 3 May 2019 13:53:33 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [RFC] rtw88: fix subscript above array bounds compiler warning
Message-ID: <20190503115333.GA23109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 03 May 2019 11:53:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My compiler complain about:

drivers/net/wireless/realtek/rtw88/phy.c: In function ‘rtw_phy_rf_power_2_rssi’:
drivers/net/wireless/realtek/rtw88/phy.c:430:26: warning: array subscript is above array bounds [-Warray-bounds]
  linear = db_invert_table[i][j];

According to comment power_db should be in range 1 ~ 96 .
Correct rtw_phy_power_2_db() to make max power 96 db
(still min is 0). This make the warning gone.

However power >= 20 check still looks somewhat suspicious to me.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 35a35dbca85f..a716a44d78b0 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -410,12 +410,12 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 
 static u8 rtw_phy_power_2_db(s8 power)
 {
-	if (power <= -100 || power >= 20)
+	if (power <= -96 || power >= 20)
 		return 0;
 	else if (power >= 0)
-		return 100;
+		return 96;
 	else
-		return 100 + power;
+		return 96 + power;
 }
 
 static u64 rtw_phy_db_2_linear(u8 power_db)
-- 
1.9.3

