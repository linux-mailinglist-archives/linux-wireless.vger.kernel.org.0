Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132753E9A89
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhHKVqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:46:08 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:52238 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232238AbhHKVp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:29 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.133])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C04281C0074
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8B13AB0007E
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 4F80213C2BF;
        Wed, 11 Aug 2021 14:44:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4F80213C2BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718292;
        bh=X8Zqugu+OMJeo5C8zaa/3Ph0NpZmgNtEhSXPpdJlpUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRknUvJQ5sIn+DY1zrjPNt4f7sSIn15GUuReMnAj//QpySdkFtCAI7VT/K9LrOBZa
         1oA2XC3bimRh0AXUI56rmwmXZ2kPeYuD8KvkfrY1J7T1i/SGCBYa8SH9j1ZqmyVu/s
         aqT3wLAGHa08+jfVT6+/2zoREwuSl4w1jz9Glwu4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 13/15] mt76: mt7915:  add rx-ppdu-size-out-of-range ethtool counter
Date:   Wed, 11 Aug 2021 14:44:37 -0700
Message-Id: <20210811214439.17458-14-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718293-oLya2UaV0IVH
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
index 9883d1e55f5b..44c76f7480f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2146,6 +2146,7 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 
 	cnt = mt76_rr(dev, MT_MIB_SDR4(ext_phy));
 	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
+	mib->rx_oor_cnt += FIELD_GET(MT_MIB_SDR4_RX_OOR_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR5(ext_phy));
 	mib->rx_mpdu_cnt += cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 4f609a5d38a4..fa9e3fd9bb4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1084,6 +1084,7 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 
 	/* rx counters */
 	"rx_fifo_full_cnt",
+	"rx_oor_cnt", /* rx ppdu length is bad */
 	"rx_mpdu_cnt",
 	"channel_idle_cnt",
 	"rx_vector_mismatch_cnt",
@@ -1322,7 +1323,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 		data[ei++] = mib->tx_amsdu_pack_stats[i];
 
 	/* rx counters */
-	data[ei++] = mib->rx_fifo_full_cnt;
+	data[ei++] = mib->rx_fifo_full_cnt; /* group-5 might exacerbate this */
+	data[ei++] = mib->rx_oor_cnt;
 	data[ei++] = mib->rx_mpdu_cnt;
 	data[ei++] = mib->channel_idle_cnt;
 	data[ei++] = mib->rx_vector_mismatch_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1a0d7d62c582..4515d42e5f74 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -168,6 +168,7 @@ struct mib_stats {
 
 	/* rx stats */
 	u32 rx_fifo_full_cnt;
+	u32 rx_oor_cnt;
 	u32 channel_idle_cnt;
 	u32 rx_vector_mismatch_cnt;
 	u32 rx_delimiter_fail_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 0bd911075aa9..6898cbe34470 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -149,6 +149,7 @@
 
 #define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, 0x018)
 #define MT_MIB_SDR4_RX_FIFO_FULL_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR4_RX_OOR_MASK		GENMASK(23, 16)
 
 /* rx mpdu counter, full 32 bits */
 #define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, 0x01c)
-- 
2.20.1

