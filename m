Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD6E89D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfD2RRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 13:17:15 -0400
Received: from nbd.name ([46.4.11.11]:37842 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfD2RRP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 13:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2Q2BmWgFfH98Sjpyk5V7JP/6WBHEZw1DTpwo928RNxg=; b=nGJvN1T3+gBIeFyjcH9LwLz+cu
        OWh6d4Sw/HqDNiwPNRW8p4GEtH6FgqNo1utytHvnDN9uDIFPIDeE6Vb8iP9OY56ahVpdJzd8PRPoX
        vrqzTpZ4c7QD3b5iR9BZy1F/ftmL7iqZRTodI1lmV+hMHQd1yvD1Q3GRYmNZ9dLLFKdw=;
Received: from p4ff135f1.dip0.t-ipconnect.de ([79.241.53.241] helo=maeck-2.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hL9ty-0001E1-9h
        for linux-wireless@vger.kernel.org; Mon, 29 Apr 2019 19:17:14 +0200
Received: by maeck-2.local (Postfix, from userid 501)
        id 3A3A95A48252; Mon, 29 Apr 2019 19:17:13 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] mt76: mt7603: fix initialization of max rx length
Date:   Mon, 29 Apr 2019 19:17:11 +0200
Message-Id: <20190429171712.52983-3-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190429171712.52983-1-nbd@nbd.name>
References: <20190429171712.52983-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The previous version only accidentally disabled A-MSDU deaggregation by
using the wrong mask for rx length configuration, which left previous
length value in place.
Fix the length and initialize the register completely to keep A-MSDU
de-aggregation remaining disabled

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/init.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index d394839f1bd8..0d347ac6dfa6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -167,7 +167,8 @@ mt7603_mac_init(struct mt7603_dev *dev)
 		FIELD_PREP(MT_AGG_RETRY_CONTROL_BAR_LIMIT, 1) |
 		FIELD_PREP(MT_AGG_RETRY_CONTROL_RTS_LIMIT, 15));
 
-	mt76_rmw(dev, MT_DMA_DCR0, ~0xfffc, 4096);
+	mt76_wr(dev, MT_DMA_DCR0, MT_DMA_DCR0_RX_VEC_DROP |
+		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 4096));
 
 	mt76_rmw(dev, MT_DMA_VCFR0, BIT(0), BIT(13));
 	mt76_rmw(dev, MT_DMA_TMCFR0, BIT(0) | BIT(1), BIT(13));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index da6827ae6cee..9d257d5c309d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -233,6 +233,10 @@
 #define MT_WF_DMA(ofs)			(MT_WF_DMA_BASE + (ofs))
 
 #define MT_DMA_DCR0			MT_WF_DMA(0x000)
+#define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 0)
+#define MT_DMA_DCR0_DAMSDU		BIT(16)
+#define MT_DMA_DCR0_RX_VEC_DROP		BIT(17)
+
 #define MT_DMA_DCR1			MT_WF_DMA(0x004)
 
 #define MT_DMA_FQCR0			MT_WF_DMA(0x008)
-- 
2.17.0

