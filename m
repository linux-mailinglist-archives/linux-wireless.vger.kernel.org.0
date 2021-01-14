Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D132F6014
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 12:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbhANLa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 06:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbhANLa4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:56 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C48C06179C
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 03:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ir6VsoUyVSVcGtH+ajueid4h1duQRlkmS+di7MbfAtY=; b=NyBjXbNc4cqySFdyJFNNMMiamV
        bauHlNqBycvA4qCKI+5EAZc9lYtB9iKoClYFzBxXZi8QE+mZg8FS23gV/Q42UtSy8tgI5zP05dODj
        cX0cjS4BvnfpS75tFWUt1sw1Oappretgk3UgN8L/gJNNynpETPLOQVnmpDdcOAFkosyk=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l00oh-0001PU-K8
        for linux-wireless@vger.kernel.org; Thu, 14 Jan 2021 12:29:27 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/7] mt76: mt7915: disable RED support in the WA firmware
Date:   Thu, 14 Jan 2021 12:29:23 +0100
Message-Id: <20210114112925.87646-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210114112925.87646-1-nbd@nbd.name>
References: <20210114112925.87646-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It causes high CPU load on the WA core, which can lead to extra latency when
using many stations. Dropping packets for long queues is managed by mac80211
fq_codel instead

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 17 +++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h | 15 +++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 59a5ef2a0139..44cef96db476 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -313,6 +313,22 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
 }
 
+static void
+mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
+{
+	struct {
+		__le32 args[3];
+	} req = {
+		.args = {
+			cpu_to_le32(a1),
+			cpu_to_le32(a2),
+			cpu_to_le32(a3),
+		},
+	};
+
+	mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+}
+
 static void
 mt7915_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -2831,6 +2847,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	mt7915_mcu_fw_log_2_host(dev, 0);
 	mt7915_mcu_set_mwds(dev, 1);
+	mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_RED, 0, 0);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index bd136ca29d0d..2d584142c27b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -239,6 +239,7 @@ enum {
 	MCU_CMD_PATCH_START_REQ = 0x05,
 	MCU_CMD_PATCH_FINISH_REQ = 0x07,
 	MCU_CMD_PATCH_SEM_CONTROL = 0x10,
+	MCU_CMD_WA_PARAM = 0xC4,
 	MCU_CMD_EXT_CID = 0xED,
 	MCU_CMD_FW_SCATTER = 0xEE,
 	MCU_CMD_RESTART_DL_REQ = 0xEF,
@@ -277,6 +278,17 @@ enum {
 	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
 };
 
+enum {
+	MCU_WA_PARAM_CMD_QUERY,
+	MCU_WA_PARAM_CMD_SET,
+	MCU_WA_PARAM_CMD_CAPABILITY,
+	MCU_WA_PARAM_CMD_DEBUG,
+};
+
+enum {
+	MCU_WA_PARAM_RED = 0x0e,
+};
+
 #define MCU_CMD(_t)		FIELD_PREP(__MCU_CMD_FIELD_ID, MCU_CMD_##_t)
 #define MCU_EXT_CMD(_t)		(MCU_CMD(EXT_CID) | \
 				 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID, \
@@ -285,6 +297,9 @@ enum {
 
 #define MCU_WA_CMD(_t)		(MCU_CMD(_t) | __MCU_CMD_FIELD_WA)
 #define MCU_WA_EXT_CMD(_t)	(MCU_EXT_CMD(_t) | __MCU_CMD_FIELD_WA)
+#define MCU_WA_PARAM_CMD(_t)	(MCU_WA_CMD(WA_PARAM) | \
+				 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID, \
+					    MCU_WA_PARAM_CMD_##_t))
 
 enum {
 	PATCH_SEM_RELEASE,
-- 
2.28.0

