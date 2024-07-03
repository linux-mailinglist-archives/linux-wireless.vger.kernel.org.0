Return-Path: <linux-wireless+bounces-9921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB5925848
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B9F1F2187A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4516727B;
	Wed,  3 Jul 2024 10:20:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096314D42C
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002049; cv=none; b=t5EVPXJqrRiTWmTW5koxjLBkHjtrJwWvbBaPCOTBJWfD2LZLyBmofPyXoTDIKwViNzugOO3TJRL3d8qs1W8+BANXcKVgjSJT0evZcy5YD+kgaiIjuPZBV/BuUxQTdX1yd4Znl6qK0Wsvn/m23xicu/kqy0VGJgBfok5HX2Er5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002049; c=relaxed/simple;
	bh=8Wqe6jMM+VpytjTp0IknaTsCK85fp+DTV+hMsMcvZQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUCgxbaABoXMV8gxHVV2ng8INI5Fi2it5arrJ8qAAJ4JB4W7krvhLJkwONavGUtzYHvmvH7E8ha9D9blxTHtNrb2X5ugmUjuFg66xCpCwm4rTLfLk16aHRCr9bZ4ETVzLojE9UB2yp0Kp3IRa5yUrUDL4w7nh4AigHnW74gG7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz4t1720002040t6vk97a
X-QQ-Originating-IP: n6zjRwGAKCMFCZ6mbmsgCHh7bIUV/Bm23uhF1VR3xxQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jul 2024 18:20:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3367246597831120100
From: WangYuli <wangyuli@uniontech.com>
To: kuba@kernel.org,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	guanwentao@uniontech.com,
	sergio.it.consultant@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] drivers/mediatek: Fix some mt7601u vendor could not connect
Date: Wed,  3 Jul 2024 18:20:31 +0800
Message-ID: <E552B9CD8228F9A9+20240703102031.74932-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Some mt7601 devices cannot establish a connection properly.
This patch fixes the issue.
We do not know why, but it just works.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1716301/comments/52
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1716301/comments/53
Link: https://github.com/kuba-moo/mt7601u/issues/64
Link: https://www.mediatek.com/products/broadband-wifi/mt7601u
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/wireless/mediatek/mt7601u/mcu.c | 1 -
 drivers/net/wireless/mediatek/mt7601u/phy.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wireless/mediatek/mt7601u/mcu.c
index 1b5cc271a9e1..15751d11b4dc 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -446,7 +446,6 @@ static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 	mt7601u_wr(dev, 0x94c, 0);
 	mt7601u_wr(dev, MT_FCE_PSE_CTRL, 0);
 
-	mt7601u_vendor_reset(dev);
 	msleep(5);
 
 	mt7601u_wr(dev, 0xa44, 0);
diff --git a/drivers/net/wireless/mediatek/mt7601u/phy.c b/drivers/net/wireless/mediatek/mt7601u/phy.c
index d4cd2215aba9..f3c14a1552df 100644
--- a/drivers/net/wireless/mediatek/mt7601u/phy.c
+++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
@@ -589,8 +589,6 @@ void mt7601u_phy_recalibrate_after_assoc(struct mt7601u_dev *dev)
 	if (test_bit(MT7601U_STATE_REMOVED, &dev->state))
 		return;
 
-	mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->curr_temp);
-
 	mt7601u_rxdc_cal(dev);
 }
 
@@ -1160,9 +1158,6 @@ static int mt7601u_init_cal(struct mt7601u_dev *dev)
 	if (ret)
 		return ret;
 	ret = mt7601u_mcu_calibrate(dev, MCU_CAL_RXIQ, 0);
-	if (ret)
-		return ret;
-	ret = mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->dpd_temp);
 	if (ret)
 		return ret;
 
-- 
2.43.4


