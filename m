Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8C47EE62
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352512AbhLXK6m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352507AbhLXK6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAF3C061757
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 02:58:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0CEF6202C
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D062C36AE5;
        Fri, 24 Dec 2021 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343520;
        bh=uR0cqKqg1uRYeyD+0EdL4mlbKVhhmUYGhJoGlNaEf5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIYcEKym9IJJW+JUfeblBaSnKb/EoOliyM2xuyBN+8y8e3VVUwDlnEFgb8J9/cNkc
         3tufMe4hb458tzZuU+JJ5HOOKLWAph/VQuxJHQi/n7ukGXmm44P9NQCopMZWFjXbZI
         ssDzDlMv2mLb/wDReWwCbACFFTlmmY3YNa37YhRviwV9SiXw0pbleaGaMJOMauMEjD
         XT+HAF0ohQt4PfzwkAdb3Ni/OfPHH093f56AuSryjKzwOdHcQi6/ZvVyqPp0SoGoPa
         s7yV2397mCQRfSZ07a0rA9Zah83AJcMI00Bypoiv5AW4XxTOWCakPTGzc2JNk/nx2K
         2xPWgJ4Q/0i9g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 07/10] mt76: mt7915: rely on mt76_connac_mcu_init_download
Date:   Fri, 24 Dec 2021 11:58:08 +0100
Message-Id: <c28c89f73a53681a02d86401e9ffb833721171df.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_init_download routine in mt7915 driver and
remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 29 +++----------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index efd0519a1872..2b647c19521b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -62,8 +62,8 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 	};
 	int cmd;
 
-	if (is_mt7921(dev) &&
-	    (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS) || addr == 0x900000))
+	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
+	    (is_mt7921(dev) && addr == 0x900000))
 		cmd = MCU_CMD(PATCH_START_REQ);
 	else
 		cmd = MCU_CMD(TARGET_ADDRESS_LEN_REQ);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3eaf230b452e..3f4b04582879 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1957,28 +1957,6 @@ static int mt7915_driver_own(struct mt7915_dev *dev, u8 band)
 	return 0;
 }
 
-static int mt7915_mcu_init_download(struct mt7915_dev *dev, u32 addr,
-				    u32 len, u32 mode)
-{
-	struct {
-		__le32 addr;
-		__le32 len;
-		__le32 mode;
-	} req = {
-		.addr = cpu_to_le32(addr),
-		.len = cpu_to_le32(len),
-		.mode = cpu_to_le32(mode),
-	};
-	int attr;
-
-	if (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS))
-		attr = MCU_CMD(PATCH_START_REQ);
-	else
-		attr = MCU_CMD(TARGET_ADDRESS_LEN_REQ);
-
-	return mt76_mcu_send_msg(&dev->mt76, attr, &req, sizeof(req), true);
-}
-
 static int mt7915_load_patch(struct mt7915_dev *dev)
 {
 	const struct mt7915_patch_hdr *hdr;
@@ -2030,8 +2008,8 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 		len = be32_to_cpu(sec->info.len);
 		dl = fw->data + be32_to_cpu(sec->offs);
 
-		ret = mt7915_mcu_init_download(dev, addr, len,
-					       DL_MODE_NEED_RSP);
+		ret = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+						    DL_MODE_NEED_RSP);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Download request failed\n");
 			goto out;
@@ -2100,7 +2078,8 @@ mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
 		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
 			override = addr;
 
-		err = mt7915_mcu_init_download(dev, addr, len, mode);
+		err = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+						    mode);
 		if (err) {
 			dev_err(dev->mt76.dev, "Download request failed\n");
 			return err;
-- 
2.33.1

