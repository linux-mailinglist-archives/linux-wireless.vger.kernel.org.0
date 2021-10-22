Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3154436F7D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 03:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhJVBlV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 21:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhJVBlU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 21:41:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE881C061764
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 18:39:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j190so1951209pgd.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 18:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MmDL5zAvqTX2YYbXvvZ3TXQ4huRanNDEQ01MoOAhto=;
        b=nkCV2pEBEaJH24DNcKgorUf7oQFvPH6FmWtSJOHdIec4P0OXB+zi/C857K7cah3r4P
         1EOCfIFfF3n9yEztr2RdmoJbf8jnbUPMt44EHqXgSog6KLf+PXC6k6Bo4wEUtbJKI9hf
         HRtoI9DorGwD4WMIdfkW0ZJlShFH42NJ6PHiQVibv+3/E1AM1YzCsPWIfrfgNQOMyFMv
         l1eH708JRftfal+PxlqHhiS1sa8pk/zn4pGXI2Cjf2VZ7k5JvBvGoE+E06O8yrCwFh+M
         X321fihPEnlUZTSI6mP6mFX0gKQiw1hKaX/+Th3GqCRsJZTeMliz0jVS6kinccskh1gy
         qXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MmDL5zAvqTX2YYbXvvZ3TXQ4huRanNDEQ01MoOAhto=;
        b=k+cbWaBgf/wSrqvlNoW+mc0X4GHpqTGxbRRFIeOFPlKoFUBDwZ8/cRxU1ufboprd0f
         cNN2R1KT8mqCodqWVmWn+iITyfZm4vKZft3lt39r1BqaZdih+JeTBR8Z7ndclHYDevX1
         7Irgp3qY1OKytKbAG59TC5VI/3ynYp2/6EJX3DefDEqGNas7e/tfhDz1LrefBhEBy2j4
         7sURr8xeWNB0Kg+ZcVA4jLuGIb3/O+KnNcxU7RkfMKAAkoAwzu/KyQfg0H48BywnATZC
         urxNxYyhVaDFWrX4/+pq6o1h/ohEdzhS6Osap8YWoBdV7dMLujNEdohKnz8dmnDJHrOS
         I3OQ==
X-Gm-Message-State: AOAM533VBoeGnwB2xCd/HU6L9Vn6Eyw8I8XPHt4HxzBHlE3ZtogfVUM6
        AXhOunfUXaSnkx4QCig+qMF76JgAHaniIZiQ
X-Google-Smtp-Source: ABdhPJxnSdqi74DM/umGT88u7EvgoPA9Jz0ju5YvcZy4J39HJenyzY7bmyUAm7MUuF1RVMJY6WxCZg==
X-Received: by 2002:a63:710d:: with SMTP id m13mr7015529pgc.467.1634866743424;
        Thu, 21 Oct 2021 18:39:03 -0700 (PDT)
Received: from localhost.localdomain ([112.20.112.18])
        by smtp.gmail.com with ESMTPSA id f4sm6447370pgn.93.2021.10.21.18.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 18:39:03 -0700 (PDT)
From:   Wang Haojun <jiangliuer01@gmail.com>
X-Google-Original-From: Wang Haojun <wanghaojun@loongson.cn>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-wireless@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Wang Haojun <wanghaojun@loongson.cn>
Subject: [PATCH] drivers:net:wireless:mediatek: fix build warning
Date:   Fri, 22 Oct 2021 09:38:43 +0800
Message-Id: <20211022013843.3643856-1-wanghaojun@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

drivers/net/wireless/mediatek/mt76/mt7921/main.c: In function 'mt7921_get_et_stats':
drivers/net/wireless/mediatek/mt76/mt7921/main.c:1024:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
   dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %lu",

Signed-off-by: Wang Haojun <wanghaojun@loongson.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 35a490c049e9..0b456431cb59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1021,7 +1021,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	ei += wi.worker_stat_count;
 	if (ei != ARRAY_SIZE(mt7921_gstrings_stats))
-		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %lu",
+		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %u",
 			ei, ARRAY_SIZE(mt7921_gstrings_stats));
 }
 
-- 
2.27.0

