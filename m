Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D47D73EB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjJYTJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjJYTJa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:09:30 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3AC0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:09:28 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 16C75B0006B
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:09:26 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 570AC13C2B1;
        Wed, 25 Oct 2023 12:09:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 570AC13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260965;
        bh=XMfesbeSVAxqpf2D0SpR1qJ1LtlVdwGS8uU64So2gBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGE/8JGNI2YIdfSImwsBDbymFKqXcrrATZ9LvNwKxh2S60O8hlyyFcIUVwZblbTkb
         r3OU7o4DF8uFGsMOTzmMCdiCUieJK3Q914fvIGsyKpCh7vQV+oneE10Lyr6rCv/h0v
         SlZV9xbzQ5qx2aCTA3vgJaFd2Sdn7rh4y5jjmgGI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 12/12] wifi: mt76: mt7915: add rx-ppdu-size-out-of-range ethtool counter
Date:   Wed, 25 Oct 2023 12:09:20 -0700
Message-Id: <20231025190920.2142693-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190920.2142693-1-greearb@candelatech.com>
References: <20231025190920.2142693-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260966-jpaXqw7cSorr
X-MDID-O: us5;at1;1698260966;jpaXqw7cSorr;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Support this additional MIB counter, it shares register with
the rx-fifo-overflow counter.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9b5c1ee7951d..03ec0eedaa8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -944,6 +944,7 @@ struct mt76_mib_stats {
 
 	/* rx stats */
 	u32 rx_fifo_full_cnt;
+	u32 rx_oor_cnt;
 	u32 channel_idle_cnt;
 	u32 primary_cca_busy_time;
 	u32 secondary_cca_busy_time;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f6d8e08d7083..d6ec34dff090 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1829,6 +1829,7 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 
 	cnt = mt76_rr(dev, MT_MIB_SDR4(band));
 	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
+	mib->rx_oor_cnt += FIELD_GET(MT_MIB_SDR4_RX_OOR_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR5(band));
 	mib->rx_mpdu_cnt += cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index e9b3b247c0d5..e9d3a47e7747 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1309,6 +1309,7 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 
 	/* rx counters */
 	"rx_fifo_full_cnt",
+	"rx_oor_cnt", /* rx ppdu length is bad */
 	"rx_mpdu_cnt",
 	"channel_idle_cnt",
 	"primary_cca_busy_time",
@@ -1537,7 +1538,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 		data[ei++] = mib->tx_amsdu[i];
 
 	/* rx counters */
-	data[ei++] = mib->rx_fifo_full_cnt;
+	data[ei++] = mib->rx_fifo_full_cnt; /* group-5 might exacerbate this */
+	data[ei++] = mib->rx_oor_cnt;
 	data[ei++] = mib->rx_mpdu_cnt;
 	data[ei++] = mib->channel_idle_cnt;
 	data[ei++] = mib->primary_cca_busy_time;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 89ac8e6707b8..a3070f07177b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -313,6 +313,7 @@ enum offs_rev {
 
 #define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR4))
 #define MT_MIB_SDR4_RX_FIFO_FULL_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR4_RX_OOR_MASK		GENMASK(23, 16)
 
 /* rx mpdu counter, full 32 bits */
 #define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR5))
-- 
2.40.0

