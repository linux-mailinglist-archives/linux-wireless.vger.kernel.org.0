Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667034560C7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhKRQol (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:44:41 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:40110 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233601AbhKRQol (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:44:41 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C3A341A006C
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:39 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3D84F3C007A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:39 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6974713C2B9;
        Thu, 18 Nov 2021 08:41:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6974713C2B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253667;
        bh=2Rp+S9LTuucB9sj479v4uVlG1rqCz9ggawQ+hU1s4Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVZ1p07R1HNK5mB5uCe9OcCl4ssSWPKyhWKd4B/aN5HU/Szp64YCYsWHmJW3MVF26
         2vs55nQ7L/RM1lNXOci93RlyI0mRdhfWySrDE4kg/9cfm0IUjUEUHZYmcuAyIOwgqG
         WgfLYEgJVvb69j9nLoA0OpBQj4EePAKJr2zXV1C8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 09/11] mt76: mt7915: add rx-ppdu-size-out-of-range ethtool counter
Date:   Thu, 18 Nov 2021 08:40:54 -0800
Message-Id: <20211118164056.2965-9-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164056.2965-1-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253700-xQX43nVUCZ07
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Support this additional MIB counter, it shares register with
the rx-fifo-overflow counter.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a97b4e64f74d..82786404f516 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2175,6 +2175,7 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 
 	cnt = mt76_rr(dev, MT_MIB_SDR4(ext_phy));
 	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
+	mib->rx_oor_cnt += FIELD_GET(MT_MIB_SDR4_RX_OOR_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR5(ext_phy));
 	mib->rx_mpdu_cnt += cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index c4eee951699e..7422421c1848 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1131,6 +1131,7 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 
 	/* rx counters */
 	"rx_fifo_full_cnt",
+	"rx_oor_cnt", /* rx ppdu length is bad */
 	"rx_mpdu_cnt",
 	"channel_idle_cnt",
 	"rx_vector_mismatch_cnt",
@@ -1315,7 +1316,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 		data[ei++] = mib->tx_amsdu[i];
 
 	/* rx counters */
-	data[ei++] = mib->rx_fifo_full_cnt;
+	data[ei++] = mib->rx_fifo_full_cnt; /* group-5 might exacerbate this */
+	data[ei++] = mib->rx_oor_cnt;
 	data[ei++] = mib->rx_mpdu_cnt;
 	data[ei++] = mib->channel_idle_cnt;
 	data[ei++] = mib->rx_vector_mismatch_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 60881b357399..f5e8ae9db4a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -180,6 +180,7 @@ struct mib_stats {
 
 	/* rx stats */
 	u32 rx_fifo_full_cnt;
+	u32 rx_oor_cnt;
 	u32 channel_idle_cnt;
 	u32 rx_vector_mismatch_cnt;
 	u32 rx_delimiter_fail_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index d23c669cc933..a142b860fc7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -164,6 +164,7 @@
 
 #define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, 0x018)
 #define MT_MIB_SDR4_RX_FIFO_FULL_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR4_RX_OOR_MASK		GENMASK(23, 16)
 
 /* rx mpdu counter, full 32 bits */
 #define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, 0x01c)
-- 
2.20.1

