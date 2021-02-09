Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF67E314DA7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 11:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhBIK5Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 05:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232147AbhBIKzG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 05:55:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2D6560232;
        Tue,  9 Feb 2021 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612868065;
        bh=YYmCzokLVzN+NFU/pw6x+uMmp6N1ySVR7zhAyvx21TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3yYrUpEalHGI/R8ct8a/9nZ3TrjMmTiYVGWDAzT7Rje9hgbw7Ni58qXHYifUgTsZ
         31WaXgJD2wdo05xFujm9aAwC1tAXvgbwIZRCU0nksYU3UE3+fC+5AvBw4PP8MNSuD/
         hUxhfC2a5awlotbRbyB1tuOhagzwXg+SxsyJgKxNn1VxNQiVyM2xNyW5tSMvMjyEHc
         mFWaI6YUKCyJZgwVvuvc8cwD6AQw1rZ+d+BTP3AUE7WCReX3PiQt7BAoI4qlI+CLuZ
         Gs5OBWEDXw1whLF+B07ph4LBRyFSwWKst/+yEqXyTvwiFY+O11OXWN3wkXG3x7faWo
         5TYh/6q+RxG+A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 1/6] mt76: mt7921: switch to new api for hardware beacon filter
Date:   Tue,  9 Feb 2021 11:54:02 +0100
Message-Id: <a114540553f3a78386e4aaeebcdebb1f0c8fb270.1612867656.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612867656.git.lorenzo@kernel.org>
References: <cover.1612867656.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Current firmware only supports new api for enabling hardware beacon filter.

Fixes: 1d8efc741df80 ("mt76: mt7921: introduce Runtime PM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 729f6c42cdde..617e48f243f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -296,7 +296,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 		goto out;
 
 	if (dev->pm.enable) {
-		ret = mt7921_mcu_set_bss_pm(dev, vif, true);
+		ret = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
 		if (ret)
 			goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index db125cd22b91..d784c75d47bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1294,8 +1294,14 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct mt7921_phy *phy = priv;
 	struct mt7921_dev *dev = phy->dev;
+	int ret;
+
+	if (dev->pm.enable)
+		ret = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
+	else
+		ret = mt7921_mcu_set_bss_pm(dev, vif, false);
 
-	if (mt7921_mcu_set_bss_pm(dev, vif, dev->pm.enable))
+	if (ret)
 		return;
 
 	if (dev->pm.enable) {
-- 
2.29.2

