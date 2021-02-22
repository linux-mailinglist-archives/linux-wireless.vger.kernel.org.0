Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DEA320EF4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 02:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBVBNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Feb 2021 20:13:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhBVBNE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Feb 2021 20:13:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 755CE64EC8;
        Mon, 22 Feb 2021 01:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956342;
        bh=y+y7z28JE7Bo8CxNqD9qVadZURoytZV2QYlyV29Hlgc=;
        h=From:To:Cc:Subject:Date:From;
        b=S48pRhqfUorwZA7f1EGLWswa1Z/SFoM3W9wd9HRru/29KayrpdVNc+8QILKgBQMBH
         Kl662135Fpb7GyH1eNgqjnd4XLpMpgR4x66CMHQNsFPmU9V6DMDK9abmtT8uXIpq2X
         tCU7yQtnfcneiR0GY9gFd8UueRD6HVMq9WpYcWnskdi+p15oHH5RG/zMa5Ukb9zOar
         4O1THC2e2b09MOhbQ2htK7NKSlTklB3JcHGRTm7ttO+VuH7t/uitxIBXq1y1CeTBel
         vhFDjPoYv7DqFJANXZDbwXKqNkGQ9Si2NkII+fPlKuzO7WTqAaBkBvU5+HmsvdZHxw
         T7XYH1YkC7p1g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: fix aggr length histogram
Date:   Mon, 22 Feb 2021 02:12:09 +0100
Message-Id: <ea1f13d567bcdc1951b1c79f93494e1a0222c24c.1613956174.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix register definitions for 802.11 aggr length histogram estimation.

Fixes: 474a9f21e2e2 ("mt76: mt7921: add debugfs support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 5 ++---
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h    | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 50cd0ad1ca89..de6816d72054 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -44,14 +44,13 @@ mt7921_ampdu_stat_read_phy(struct mt7921_phy *phy,
 		range[i] = mt76_rr(dev, MT_MIB_ARNG(0, i));
 
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
-		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 4], i) + 1;
+		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 4], i % 4) + 1;
 
 	seq_printf(file, "\nPhy0\n");
 
 	seq_printf(file, "Length: %8d | ", bound[0]);
 	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
-		seq_printf(file, "%3d -%3d | ",
-			   bound[i] + 1, bound[i + 1]);
+		seq_printf(file, "%3d  %3d | ", bound[i] + 1, bound[i + 1]);
 
 	seq_puts(file, "\nCount:  ");
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 18980bb32dee..d7e316eb006c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -128,9 +128,9 @@
 #define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
 #define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
 
-#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x0a8 + ((n) << 2))
-#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x164 + ((n) << 2))
-#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x4b8 + ((n) << 2))
+#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x7dc + ((n) << 2))
+#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x7ec + ((n) << 2))
+#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x0b0 + ((n) << 2))
 #define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
 
 #define MT_WTBLON_TOP_BASE		0x34000
-- 
2.29.2

