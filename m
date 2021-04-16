Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5195361B96
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhDPI2R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPI2Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 04:28:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEEAC061574
        for <linux-wireless@vger.kernel.org>; Fri, 16 Apr 2021 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ex0aPbGFlVOlSWuEAAf/eKvrFfrReHj+yCMkZOPsOd4=; b=UdAYKLYhYbexB3BgHbG7rbINPY
        XAN1uoDKsKJ9+a0fp766jGpnXVTBhq1QYAlho0CDmn8JVQXK5WakKdfPRgJ/ZrKTT9iL007HaU9mt
        BfNwi9coKu+0pQSSxVz6scMVNtgJ4G86l39EiFLQOpyim/muQMuIJwG4hCm3ojOGEKFw=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lXJpN-0003tx-4l
        for linux-wireless@vger.kernel.org; Fri, 16 Apr 2021 10:27:49 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: mt7615: load ROM patch before checking patch semaphore status
Date:   Fri, 16 Apr 2021 10:27:46 +0200
Message-Id: <20210416082746.21825-3-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210416082746.21825-1-nbd@nbd.name>
References: <20210416082746.21825-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For MT7663, the availability of the patch files is used to detect, which
corresponding firmware is going to be used (AP firmware or STA offload
firmware). If the ROM patch was already applied, it could attempt to
load the wrong firmware (without considering the alternative).

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 5f37255476e3..2e113fd431f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1341,25 +1341,26 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 	const struct firmware *fw = NULL;
 	int len, ret, sem;
 
+	ret = firmware_request_nowarn(&fw, name, dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->mt76.dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto release_fw;
+	}
+
 	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, true);
 	switch (sem) {
 	case PATCH_IS_DL:
-		return 0;
+		goto release_fw;
 	case PATCH_NOT_DL_SEM_SUCCESS:
 		break;
 	default:
 		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
-		return -EAGAIN;
-	}
-
-	ret = firmware_request_nowarn(&fw, name, dev->mt76.dev);
-	if (ret)
-		goto out;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev->mt76.dev, "Invalid firmware\n");
-		ret = -EINVAL;
-		goto out;
+		ret = -EAGAIN;
+		goto release_fw;
 	}
 
 	hdr = (const struct mt7615_patch_hdr *)(fw->data);
@@ -1388,8 +1389,6 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 		dev_err(dev->mt76.dev, "Failed to start patch\n");
 
 out:
-	release_firmware(fw);
-
 	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
 	switch (sem) {
 	case PATCH_REL_SEM_SUCCESS:
@@ -1400,6 +1399,9 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 		break;
 	}
 
+release_fw:
+	release_firmware(fw);
+
 	return ret;
 }
 
-- 
2.30.1

