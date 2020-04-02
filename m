Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5519C8AE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 20:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbgDBST2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 14:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbgDBST1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 14:19:27 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0324020BED;
        Thu,  2 Apr 2020 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585851567;
        bh=cgadFpj6F9DWfBCLRSNBDY3c5hZQkzUcEfymNRsHvJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0lpHmD3pGbolkzx/ebfMXGZfm7fCkek1Q365PLS3UoC6i6phFWBuPzNqRKL2tiqg
         eOs40bJW+If1stxWLTXVKk4xKT9FB9NMqzDep0yiBhU2MnXHeiieG4+3FdUCzKQNoc
         pQ1AC2joI3maTDr+06lhDximbo5eMZvSi9mlBP+w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 8/9] mt76: mt7615: introduce mt7615_wtbl_desc data structure
Date:   Thu,  2 Apr 2020 20:18:55 +0200
Message-Id: <caec62c349f28d5aa6ce7925666c29e3be513e26.1585851049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585851049.git.lorenzo@kernel.org>
References: <cover.1585851049.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Generalize mt7615_rate_desc introducing mt7615_wtbl_desc and
mt7615_key_desc data structures in order to configure the hw wtbl
in a non-atomic context for usb devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  1 -
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 29 ++++++++++++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 86e7c1c1b61e..7b8873002441 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -893,7 +893,6 @@ mt7615_mac_update_rate_desc(struct mt7615_phy *phy, struct mt7615_sta *sta,
 		rd->bw_idx = 7;
 
 	rd->rateset = rateset;
-	rd->sta = sta;
 	rd->bw = bw;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 588cc38bfac0..bd5967f5b4b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -92,10 +92,6 @@ struct mt7615_rate_set {
 };
 
 struct mt7615_rate_desc {
-	struct list_head node;
-
-	struct mt7615_sta *sta;
-
 	bool rateset;
 	u16 probe_val;
 	u16 val[4];
@@ -103,6 +99,31 @@ struct mt7615_rate_desc {
 	u8 bw;
 };
 
+enum mt7615_wtbl_desc_type {
+	MT7615_WTBL_RATE_DESC,
+	MT7615_WTBL_KEY_DESC
+};
+
+struct mt7615_key_desc {
+	enum set_key_cmd cmd;
+	u32 cipher;
+	s8 keyidx;
+	u8 keylen;
+	u8 *key;
+};
+
+struct mt7615_wtbl_desc {
+	struct list_head node;
+
+	enum mt7615_wtbl_desc_type type;
+	struct mt7615_sta *sta;
+
+	union {
+		struct mt7615_rate_desc rate;
+		struct mt7615_key_desc key;
+	};
+};
+
 struct mt7615_sta {
 	struct mt76_wcid wcid; /* must be first */
 
-- 
2.25.1

