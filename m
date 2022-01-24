Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E64499174
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jan 2022 21:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346843AbiAXUKv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jan 2022 15:10:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60268 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376758AbiAXUDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jan 2022 15:03:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64EF861342
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jan 2022 20:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F4C340E7;
        Mon, 24 Jan 2022 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643054630;
        bh=Clzg6womi6KSTm5YXX9h7K0ejylWUEqpWWIaLUAtGN0=;
        h=From:To:Cc:Subject:Date:From;
        b=j/y5tLS/KjFH/Nx0A4pRL8mR+TdmoDofQa/rSKblOUZACaLmKakyNjr9DshPp2gc4
         HcYVU6Br+AnGaGe2zfaGqkduuMdYPy63OaP9VyLoQGNWXkQODEKHB8nkjWfZPDdoYg
         9xhGW9EtpKk5XRvydeCi7WuX8vaFIFHb8OHcB3ga6dE4rGdmV7o9KHzV8bmfDzOGoX
         4VJExCjNDhQzDnIR/tTdCqezzd/GyEkTEY2dgPT29FWBaGyO6bu8A2NxJr7NymdkFu
         pQBO6ngKeLRumi6W+ieexv19eEebuQWwzc+Th7JxoHq11/vudtqzTWGrLXHAROUlVr
         8VDN0G+nWSqlA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921s: fix a possible memory leak in mt7921_load_patch
Date:   Mon, 24 Jan 2022 21:03:44 +0100
Message-Id: <e1e3c96cb9a1e305143c635c4066beba828a380d.1643054512.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Always release fw data at the end of mt7921_load_patch routine.

Fixes: 78b217580c509 ("mt76: mt7921s: fix bus hang with wrong privilege")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 509595c4157c..33a836825cca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -541,12 +541,8 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 	if (mt76_is_sdio(&dev->mt76)) {
 		/* activate again */
 		ret = __mt7921_mcu_fw_pmctrl(dev);
-		if (ret)
-			return ret;
-
-		ret = __mt7921_mcu_drv_pmctrl(dev);
-		if (ret)
-			return ret;
+		if (!ret)
+			ret = __mt7921_mcu_drv_pmctrl(dev);
 	}
 
 out:
-- 
2.34.1

