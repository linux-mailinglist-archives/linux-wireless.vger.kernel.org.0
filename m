Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60642987F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 22:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhJKU5L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 16:57:11 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:42614 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234300AbhJKU5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 16:57:09 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.119])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B02801A007B
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 20:55:07 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 850337C0085
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 20:55:07 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 2F27A13C2B0;
        Mon, 11 Oct 2021 13:55:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2F27A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1633985707;
        bh=fs2VMcN8i5WoNZAG1ObsP4Vysp1O646zd8WfuDg67zA=;
        h=From:To:Cc:Subject:Date:From;
        b=psb/Nuvl0smE1uNoCbb+SccNSkTEWMECvznc7tSf2ghwcbywoWKZr/L64Jjh2TnT0
         lYq6BeG4PeI1iEHmrsZgzjBuRpJxfacvRDSDjIqpA847ys9ETRvxhcKO7znzAB3jT3
         c9om64t7+Cf/ZlQjVKud4OD0rQkgV4lmlv1rR8oI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mt76: mt7915:  add module paramater to enable firmware debug
Date:   Mon, 11 Oct 2021 13:55:04 -0700
Message-Id: <20211011205504.23684-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1633985708-zwX5trZTkoz1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This helps to enable logging during startup.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  8 +-------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 19 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  8 ++++++++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index be1a0cf25587..7a12bf46c877 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -78,13 +78,7 @@ static int
 mt7915_fw_debug_set(void *data, u64 val)
 {
 	struct mt7915_dev *dev = data;
-	enum {
-		DEBUG_TXCMD = 62,
-		DEBUG_CMD_RPT_TX,
-		DEBUG_CMD_RPT_TRIG,
-		DEBUG_SPL,
-		DEBUG_RPT_RX,
-	} debug;
+	enum mt_debug debug;
 
 	dev->fw_debug = !!val;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e97cdeae785f..a16347af788e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -8,6 +8,11 @@
 #include "mac.h"
 #include "eeprom.h"
 
+static int fw_debug = 0;
+module_param(fw_debug, int, 0644);
+MODULE_PARM_DESC(fw_debug,
+		 "Set to 1 to enable FW debugging on startup.");
+
 struct mt7915_patch_hdr {
 	char build_date[16];
 	char platform[4];
@@ -3016,7 +3021,19 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 		return ret;
 
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
-	mt7915_mcu_fw_log_2_host(dev, 0);
+	if (fw_debug) {
+		enum mt_debug debug;
+
+		/* enable debugging on bootup */
+		dev->fw_debug = 1;
+		mt7915_mcu_fw_log_2_host(dev, 2);
+		for (debug = DEBUG_TXCMD; debug <= DEBUG_RPT_RX; debug++)
+			mt7915_mcu_fw_dbg_ctrl(dev, debug, dev->fw_debug);
+	}
+	else {
+		mt7915_mcu_fw_log_2_host(dev, 0);
+	}
+
 	mt7915_mcu_set_mwds(dev, 1);
 	mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_RED, 0, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index d05be18d9288..d0d0b3ee4105 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1098,6 +1098,14 @@ enum {
 	MT_BF_MODULE_UPDATE = 25
 };
 
+enum mt_debug {
+	DEBUG_TXCMD = 62,
+	DEBUG_CMD_RPT_TX,
+	DEBUG_CMD_RPT_TRIG,
+	DEBUG_SPL,
+	DEBUG_RPT_RX,
+};
+
 #define MT7915_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
 					 sizeof(struct wtbl_generic) +	\
 					 sizeof(struct wtbl_rx) +	\
-- 
2.20.1

