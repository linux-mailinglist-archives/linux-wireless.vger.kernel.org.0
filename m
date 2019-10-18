Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C42BDD138
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 23:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440440AbfJRVbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 17:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732440AbfJRVbb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 17:31:31 -0400
Received: from localhost.localdomain (unknown [151.66.3.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2004F2070B;
        Fri, 18 Oct 2019 21:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571434291;
        bh=JRhWexNLuyM/83gNzScdv5VGYQIOtyYKpt6Fhp0I6O8=;
        h=From:To:Cc:Subject:Date:From;
        b=kypPVrBm6Xwo8WISKOV6WO7D12M8vd21pmYDv8E4O5K401gjSXJanlqqe0pvc5eEC
         ydQoFCiInYhfrusqrvgQJaYBJpLuLgXa6bdtg+nNox3UkpE2C7HNayD5z4aph31eaf
         yDB1v4BF6mr/EgXzyOVIL0mu0j/FUYw8tZh0+6BQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sidhayn@gmail.com, sgruszka@redhat.com
Subject: [PATCH] mt76: mt76x0: remove 350ms delay in mt76x0_phy_calibrate
Date:   Fri, 18 Oct 2019 23:31:23 +0200
Message-Id: <1df39fc826ff1fd79098b7431d04a00a0f3bdf6c.1571433997.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since mt76x0 does not save the phy calibration data it is not necessary
to wait 350ms in mt76x0_phy_calibrate

Tested-by: Sid Hayn <sidhayn@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 711a352dfd5c..61e1a086f3cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -899,7 +899,6 @@ void mt76x0_phy_calibrate(struct mt76x02_dev *dev, bool power_on)
 	}
 
 	mt76x02_mcu_calibrate(dev, MCU_CAL_FULL, val);
-	msleep(350);
 	mt76x02_mcu_calibrate(dev, MCU_CAL_LC, is_5ghz);
 	usleep_range(15000, 20000);
 
-- 
2.21.0

