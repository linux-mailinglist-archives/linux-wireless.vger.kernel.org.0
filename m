Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125EB3D3D21
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 18:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhGWP0m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:26:42 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:35860 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230243AbhGWP0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:26:41 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.118])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 43E0F20071
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:07:14 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 201771C0094
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:07:14 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0094E13C2BE;
        Fri, 23 Jul 2021 09:06:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0094E13C2BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627056396;
        bh=h2xMhm9UxN6BDuy69k72yO4HI2gAYuDeEEu3x0t5Ygo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rS21TaCMbDpySAMhwoquTVdWLR/GqQ95fTJC7dsZwW+efiiMaSVUMEuM5wGjA1Vjz
         +oNl97Qv2cqq2bi9pMsmh8/zMEde87BD+IsHZ6DLiEOijMSutblQaVjizoCupG5clt
         h1aWib7tz8Z/WjzbOd35FTpnxffm+3DqIvaeLzL0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3 09/11] mt76: mt7915:  txfree status to show txcount instead of latency.
Date:   Fri, 23 Jul 2021 09:06:21 -0700
Message-Id: <20210723160623.14709-9-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723160623.14709-1-greearb@candelatech.com>
References: <20210723160623.14709-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627056434-HQJY2Nh1-InM
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Latency is not obviously that useful, but txcount can let us deduce
retries, which may be more interesting.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h  | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index f174cf219724..a0d282771d77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -304,6 +304,9 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 	/* enable hardware de-agg */
 	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
 
+	/* disable Tx latency report to enable Tx count in txfree path */
+	mt76_clear(dev, MT_PLE_HOST_RPT0, MT_PLE_HOST_RPT0_TX_LATENCY);
+
 	for (i = 0; i < MT7915_WTBL_SIZE; i++)
 		mt7915_mac_wtbl_update(dev, i,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 986a65badd1b..741d51b0fa06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -304,13 +304,15 @@ struct mt7915_tx_free {
 
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
+/* when configured for txfree latency mode.  See MT_PLE_HOST_RPT0_TX_LATENCY
+ * Not enabled by default now.
+ */
 #define MT_TX_FREE_LATENCY		GENMASK(12, 0)
-/* 0: success, others: dropped */
+/* when configured for txcount mode.  See MT_PLE_HOST_RPT0_TX_LATENCY. */
+#define MT_TX_FREE_TXCNT		GENMASK(12, 0)
 #define MT_TX_FREE_STATUS		GENMASK(14, 13)
 #define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
 #define MT_TX_FREE_PAIR			BIT(31)
-/* will support this field in further revision */
-#define MT_TX_FREE_RATE			GENMASK(13, 0)
 
 #define MT_TXS0_FIXED_RATE		BIT(31)
 #define MT_TXS0_BW			GENMASK(30, 29)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 62cc32a098fc..ac4d233b8cf2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -22,6 +22,10 @@
 #define MT_PLE_BASE			0x8000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
+/* Modify whether txfree struct returns latency or txcount. */
+#define MT_PLE_HOST_RPT0               MT_PLE(0x030)
+#define MT_PLE_HOST_RPT0_TX_LATENCY    BIT(3)
+
 #define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
 #define MT_PLE_FL_Q1_CTRL		MT_PLE(0x1b4)
 #define MT_PLE_FL_Q2_CTRL		MT_PLE(0x1b8)
-- 
2.20.1

