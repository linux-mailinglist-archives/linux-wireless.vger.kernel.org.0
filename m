Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939A12B2DE5
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Nov 2020 16:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgKNPWa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Nov 2020 10:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgKNPWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Nov 2020 10:22:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264FC0613D1;
        Sat, 14 Nov 2020 07:22:30 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w14so9855774pfd.7;
        Sat, 14 Nov 2020 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UhFoET2r5y9ItO6Xj8vFkSHDcaq4PvtHYEGmUkjIBcU=;
        b=hM3Ny1BiqS5AtB9tlxxo6LWiFmj8LpUNJZ4h33sD5bl8jsTuN0qB3ArOGOVCeC24Jp
         VMHOAT2WiM0KJR0Ef7/Y9WREigBJeaEEue9RMMfQf/6G6IqRvu7ZNJs94uRex8XF6yQy
         XFm8Q5NlSCwk/eRM+TSu0gGY7obrxLz5xFwSJnXxPgKEfBUG83oweaK0tbBINHL/PpfX
         M80RrucDVGB1dpJDGxFQgSy2ac3nPi7pLFK9eFdDal7hybEG1S/CkT4tGUESZFhrdoBT
         4POx/j9AA2sUMCAZIbzXJ1vxLQ/cqR78Iz8ssKjHNNmJHKxgBEPEN5epq1vLtk6zFILC
         P9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UhFoET2r5y9ItO6Xj8vFkSHDcaq4PvtHYEGmUkjIBcU=;
        b=W1Bt1XKoxsitTn4F83tEGD/DabYFVCeEsU53kHUTo+KMOdPX+GEa8xTEnJOg+7AJIS
         MMxaWfR4sMNzpOFge38aZq4Rnyh4aKT2WeOdLZV8Lq8UYBqW0JRbtGQEP3WewBp6m7K6
         Ids2rJ1gpOQx7ReNxYkHhUUOa4v2RwkGBdZDENS/LKOMH5m55JhhysHjxzL8riIAPC7P
         ObYASgFLSTSEF5SWC8LuUZIdsDPEmfv2ruDVkfCfICgZl4ZznZuyBkIzXvTgc2Htvjcw
         tWdiLb/QZwIxXLbSZeGNGhgR2rvH2LOVgzdXR8icBjFxlUwwoEwuk9dFZvRjBfhPLcDz
         mhMw==
X-Gm-Message-State: AOAM531hsmVYX4d7pLA0f5VG7A8UC2XudmVjwFGikg+EjFNelcRZ1RR1
        zu8pRyS7UESh6YuuDVSoUw==
X-Google-Smtp-Source: ABdhPJzNA3CxKhV4znlB7IxELk/Oy3Hm8ZOoLppinb713244TrYooiO8NjXgQXpvh2WCOkkebxJI3Q==
X-Received: by 2002:aa7:908d:0:b029:15f:d774:584 with SMTP id i13-20020aa7908d0000b029015fd7740584mr6524027pfa.6.1605367349716;
        Sat, 14 Nov 2020 07:22:29 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id x123sm13126316pfb.212.2020.11.14.07.22.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Nov 2020 07:22:28 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] rtw88: coex: remove the unreached code in rtw_coex_set_tdma
Date:   Sat, 14 Nov 2020 23:22:23 +0800
Message-Id: <1605367343-11770-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of the bool variable ap_enable is always false, so the first
if branch is unreached code. Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index aa08fd7d9fcd..9c7963e45755 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -863,18 +863,8 @@ static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 ps_type = COEX_PS_WIFI_NATIVE;
-	bool ap_enable = false;
-
-	if (ap_enable && (byte1 & BIT(4) && !(byte1 & BIT(5)))) {
-		byte1 &= ~BIT(4);
-		byte1 |= BIT(5);
-
-		byte5 |= BIT(5);
-		byte5 &= ~BIT(6);
 
-		ps_type = COEX_PS_WIFI_NATIVE;
-		rtw_coex_power_save_state(rtwdev, ps_type, 0x0, 0x0);
-	} else if (byte1 & BIT(4) && !(byte1 & BIT(5))) {
+	if (byte1 & BIT(4) && !(byte1 & BIT(5))) {
 		if (chip->pstdma_type == COEX_PSTDMA_FORCE_LPSOFF)
 			ps_type = COEX_PS_LPS_OFF;
 		else
-- 
2.20.0

