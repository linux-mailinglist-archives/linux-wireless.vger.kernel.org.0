Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2F5FB3B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfGDPx0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jul 2019 11:53:26 -0400
Received: from nbd.name ([46.4.11.11]:38246 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfGDPx0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jul 2019 11:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4YLVhgwT8S8gqJ2TZbogUgOznElffznmymz/GCnelgo=; b=SKSBgrD4S2IEy654ivYOEu4MZD
        8WWxgF7ty8s+BsG75tMv+MiX26uoGhxzglMzYxcqMa1GkPGlV8GKXXXjJHogcAwfvTACPctJVgr2g
        UH/Lqd4jnWRMzqgyri6g4FvjSFNiNYb1ogvIxRYGCREZ7zmu63fas1jxXMAMLwOo1MUg=;
Received: from p54ae9425.dip0.t-ipconnect.de ([84.174.148.37] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hj432-0004qT-Uk
        for linux-wireless@vger.kernel.org; Thu, 04 Jul 2019 17:53:25 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id 5CDF06165C10; Thu,  4 Jul 2019 17:53:24 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] mt76: mt7615: reset rate index/counters on rate table update
Date:   Thu,  4 Jul 2019 17:53:23 +0200
Message-Id: <20190704155324.56693-3-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190704155324.56693-1-nbd@nbd.name>
References: <20190704155324.56693-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These values must be initialized to zero, otherwise the hardware could
reuse previous values, especially the rate index

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 49c14eb008d7..b896d8ce9e72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -501,7 +501,10 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	w27 |= FIELD_PREP(MT_WTBL_W27_CC_BW_SEL, bw);
 
 	w5 = mt76_rr(dev, addr + 5 * 4);
-	w5 &= ~(MT_WTBL_W5_BW_CAP | MT_WTBL_W5_CHANGE_BW_RATE);
+	w5 &= ~(MT_WTBL_W5_BW_CAP | MT_WTBL_W5_CHANGE_BW_RATE |
+		MT_WTBL_W5_MPDU_OK_COUNT |
+		MT_WTBL_W5_MPDU_FAIL_COUNT |
+		MT_WTBL_W5_RATE_IDX);
 	w5 |= FIELD_PREP(MT_WTBL_W5_BW_CAP, bw) |
 	      FIELD_PREP(MT_WTBL_W5_CHANGE_BW_RATE, bw_idx ? bw_idx - 1 : 7);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 70e5ace33cc3..ea40581dc870 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -181,6 +181,10 @@
 #define MT_WTBL_W5_SHORT_GI_80		BIT(10)
 #define MT_WTBL_W5_SHORT_GI_160		BIT(11)
 #define MT_WTBL_W5_BW_CAP		GENMASK(13, 12)
+#define MT_WTBL_W5_MPDU_FAIL_COUNT	GENMASK(25, 23)
+#define MT_WTBL_W5_MPDU_OK_COUNT	GENMASK(28, 26)
+#define MT_WTBL_W5_RATE_IDX		GENMASK(31, 29)
+
 #define MT_WTBL_W27_CC_BW_SEL		GENMASK(6, 5)
 
 #define MT_EFUSE_BASE			0x81070000
-- 
2.17.0

