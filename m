Return-Path: <linux-wireless+bounces-13837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F29980D0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10411F292B6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D91B5ED6;
	Thu, 10 Oct 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="XA6FM2w3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BFE1BC9FE
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549509; cv=none; b=fnc2rtdjTuu1IAt+R7TpXFOEso24geZTO6FkF7afZBtS7ziyOq37DchXy674h6DgP9yoYb/LcPlaPe2HAiv6N3+0EjHNIK6NLtcmRrEYkfhuzXizaKUkvtUXhV3MnG6gt2H51Bt5SwTH4WjdpqdNRN7GVgmvF6f/QDnzbzutm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549509; c=relaxed/simple;
	bh=IbXZN8+em4qmu181esZmO46qOkR2Ae4aAkvuq6zuxig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3Ti142laoCsU/u2X4Pyrbai3+Zsrbl3pNzDb6QaHzpvBPXMDW+2DuSscnKv/v8BR0pfMqtXDRPnPbv6yRfDO7IjzKxAEKqqaZ2HoAvi6xGhVCfXu5qpQ5WaMhhj8Jp/3bJqNKw0Q32bu5HiKU6TruE6rIklKRwRSpNGu+OQtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=XA6FM2w3; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=53H0FS/43Qy88qbPHeuWCvIdr5qtkCkUQylpAvIoxQU=; b=XA6FM2w3hqchG4EpY237uxH4va
	3g5HLfDmA3Bf+yhsY87R7lLuZp0NRZRGAbotKNSYwR78KeSOXy3TosnQ7kJoeLhNx0xQNYfkCGgMf
	7mTvlmhDDBHL0OfsBm6nmGJO4hDxvoSgj9zSsuljdx8xT3DSLhd30xRrEietVnq5oLpk=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1syoga-007293-35;
	Thu, 10 Oct 2024 10:38:17 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	Steven Liu <steven.liu@mediatek.com>,
	Evelyn Tsai <Evelyn.Tsai@mediatek.com>,
	Paul <paul@asiarf.com>,
	Shayne Chen <Shayne.Chen@mediatek.com>
Subject: [PATCH wireless] wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz on MT7916
Date: Thu, 10 Oct 2024 10:38:16 +0200
Message-ID: <20241010083816.51880-1-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shayne Chen <shayne.chen@mediatek.com>

Due to a limitation in available memory, the MT7916 firmware can only
handle either 5 GHz or 6 GHz at a time. It does not support runtime
switching without a full restart.

On older firmware, this accidentally worked to some degree due to missing
checks, but couldn't be supported properly, because it left the 6 GHz
channels uncalibrated.
Newer firmware refuses to start on either band if the passed EEPROM
data indicates support for both.

Deal with this limitation by using a module parameter to specify the
preferred band in case both are supported.

Fixes: b4d093e321bd ("mt76: mt7915: add 6 GHz support")
Cc: stable@vger.kernel.org
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 21 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 ++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index bfdbc15abaa9..928e0b07a9bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -2,9 +2,14 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/firmware.h>
+#include <linux/moduleparam.h>
 #include "mt7915.h"
 #include "eeprom.h"
 
+static bool enable_6ghz;
+module_param(enable_6ghz, bool, 0644);
+MODULE_PARM_DESC(enable_6ghz, "Enable 6 GHz instead of 5 GHz on hardware that supports both");
+
 static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
@@ -170,8 +175,20 @@ static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 			phy->mt76->cap.has_6ghz = true;
 			return;
 		case MT_EE_V2_BAND_SEL_5GHZ_6GHZ:
-			phy->mt76->cap.has_5ghz = true;
-			phy->mt76->cap.has_6ghz = true;
+			if (enable_6ghz) {
+				phy->mt76->cap.has_6ghz = true;
+				u8p_replace_bits(&eeprom[MT_EE_WIFI_CONF + band],
+						 MT_EE_V2_BAND_SEL_6GHZ,
+						 MT_EE_WIFI_CONF0_BAND_SEL);
+			} else {
+				phy->mt76->cap.has_5ghz = true;
+				u8p_replace_bits(&eeprom[MT_EE_WIFI_CONF + band],
+						 MT_EE_V2_BAND_SEL_5GHZ,
+						 MT_EE_WIFI_CONF0_BAND_SEL);
+			}
+			/* force to buffer mode */
+			dev->flash_mode = true;
+
 			return;
 		default:
 			phy->mt76->cap.has_2ghz = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6bef96e3d2a3..f82216d1bda0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1239,14 +1239,14 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		goto unreg_dev;
 
-	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
-
 	if (phy2) {
 		ret = mt7915_register_ext_phy(dev, phy2);
 		if (ret)
 			goto unreg_thermal;
 	}
 
+	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
+
 	dev->recovery.hw_init_done = true;
 
 	ret = mt7915_init_debugfs(&dev->phy);
-- 
2.46.0


