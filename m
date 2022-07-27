Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89067583571
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiG0XBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiG0XBm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:42 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1A1FCF4
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:41 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.31])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 471041C0087;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1A21B600079;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id B85B613C2B4;
        Wed, 27 Jul 2022 16:01:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B85B613C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962899;
        bh=/PN2qJTTJOcxuwObz7TvZN3FTEksAAunF11gXOzaFng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVvca/MPWVPhwnP71N8jaEenMrXmcBnLXOn3GSyte7VWIMsEvmzjMrec9FfCYiAf7
         hkFkU3GtP2snRAQk3Y7tUFez2V8eMfu+OmIpshaC+GOe/ypd67cZf3QT+TCVTidMdm
         o0ob5AaK9QkHe1bqRlTTw5ZepemTiR9ypHRfz/sc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 04/12] wifi: mt76: mt7915: txfree status to show txcount instead of latency
Date:   Wed, 27 Jul 2022 16:01:14 -0700
Message-Id: <20220727230122.29842-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962900-E5PEqJlAzysd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Latency is not obviously that useful, but txcount can let us deduce
retries, which may be more interesting.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h  | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 91a31b9d52f2..b4ceb78c6745 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -460,6 +460,9 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 	/* enable hardware de-agg */
 	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
 
+	/* disable Tx latency report to enable Tx count in txfree path */
+	mt76_clear(dev, MT_PLE_HOST_RPT0, MT_PLE_HOST_RPT0_TX_LATENCY);
+
 	for (i = 0; i < mt7915_wtbl_size(dev); i++)
 		mt7915_mac_wtbl_update(dev, i,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 2e6c574ae2dd..503a4b90ad11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -314,8 +314,12 @@ struct mt7915_tx_free {
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_MSDU_CNT_V0	GENMASK(6, 0)
 #define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
+/* when configured for txfree latency mode.  See MT_PLE_HOST_RPT0_TX_LATENCY
+ * Not enabled by default now.
+ */
 #define MT_TX_FREE_LATENCY		GENMASK(12, 0)
-/* 0: success, others: dropped */
+/* when configured for txcount mode.  See MT_PLE_HOST_RPT0_TX_LATENCY. */
+#define MT_TX_FREE_TXCNT		GENMASK(12, 0)
 #define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
 #define MT_TX_FREE_PAIR			BIT(31)
 #define MT_TX_FREE_MPDU_HEADER		BIT(30)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 4953be208c5e..8bbc9a0ae699 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -132,6 +132,10 @@ enum offs_rev {
 #define MT_PLE_BASE			0x820c0000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
+/* Modify whether txfree struct returns latency or txcount. */
+#define MT_PLE_HOST_RPT0               MT_PLE(0x030)
+#define MT_PLE_HOST_RPT0_TX_LATENCY    BIT(3)
+
 #define MT_FL_Q_EMPTY			MT_PLE(__OFFS(PLE_FL_Q_EMPTY))
 #define MT_FL_Q0_CTRL			MT_PLE(__OFFS(PLE_FL_Q_CTRL))
 #define MT_FL_Q2_CTRL			MT_PLE(__OFFS(PLE_FL_Q_CTRL) + 0x8)
-- 
2.20.1

