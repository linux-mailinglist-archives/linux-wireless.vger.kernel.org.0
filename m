Return-Path: <linux-wireless+bounces-10221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F39311A8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 11:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1264284FCE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DD5186289;
	Mon, 15 Jul 2024 09:50:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B0335C0;
	Mon, 15 Jul 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037008; cv=none; b=MPedI5fetRoEh3lmRt7e3Ln5dHP3yYeES3WMH/Zq6bwqQoft8fJShmjxK/pIKEGj+TjLXpxiD62jcZcl9QO69YfdQvQwHOu+R8wyC9eTIN8hfolES0m8fly+9l7uM7jYUTtmII+w9kux1xybgnfNqza1fxRI+oeSWaJ8tRMsT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037008; c=relaxed/simple;
	bh=8Wqe6jMM+VpytjTp0IknaTsCK85fp+DTV+hMsMcvZQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldERAR2jsPIaZlPOpgHmrAqUv5saO8kp2YfpoCbrk8gh28HgzybIN7rxBzNYGC46M9Kh5etuk8beBUvKTzY5ghGpti6t0TN2qncY8KmlUNxtxjpz8Rk70P6xTyzQggxqOCD9Ed1l1i/S/BReAlMSrV9n73WdymLxfzVoYnc8GPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp89t1721036861toicl6cc
X-QQ-Originating-IP: +1vDfVCq/sJoRCMWUwHIAZGyJFSNel82oHF6cTZdGjs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jul 2024 17:47:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11744980703197485822
From: WangYuli <wangyuli@uniontech.com>
To: kuba@kernel.org,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	guanwentao@uniontech.com,
	sergio.it.consultant@gmail.com,
	nbd@nbd.name,
	lorenzo@kernel.org,
	shayne.chen@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	chui-hao.chiu@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH] drivers/mediatek: Fix some mt7601u vendor could not connect
Date: Mon, 15 Jul 2024 17:47:14 +0800
Message-ID: <A9442D62405552CE+20240715094714.1553336-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

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


