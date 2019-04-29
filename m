Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA06DD74
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfD2INN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 04:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfD2INN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 04:13:13 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC512147A;
        Mon, 29 Apr 2019 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556525592;
        bh=iqmbrPEi4BVpf3gnYhgxzlSmtYsG7wyCu9SIBIK4hKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HeR6PlFPjGAiaBXIMYTR9kTfSwUJwq0len+bpr+PJDojZ9T28/67WB0Cfv+d2xMFg
         4huPIFlnTpWnDvkEt1s9rjBIFK0NdFNUThV3Dgk4r+eomQY1nmTsHLKvEQrs2QfzST
         JGFZUpJyYK8tr6zlxd9ptdxDgb72kBo6tI3ynA8k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v2 1/5] mt76: do not enable/disable pre_tbtt_tasklet in scan_start/scan_complete
Date:   Mon, 29 Apr 2019 10:12:58 +0200
Message-Id: <6687d95d437b70ecf7ab9843aa502e71f034193f.1556525110.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556525110.git.lorenzo@kernel.org>
References: <cover.1556525110.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not enable/disable pre_tbtt_tasklet tasklet in
mt76x02_sw_scan/mt76x02_sw_scan_complete since it is already done
setting the operating channel

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ad8a53def7f7..5d656fea1dde 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -593,8 +593,6 @@ void mt76x02_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt76x02_dev *dev = hw->priv;
 
-	if (mt76_is_mmio(dev))
-		tasklet_disable(&dev->pre_tbtt_tasklet);
 	set_bit(MT76_SCANNING, &dev->mt76.state);
 }
 EXPORT_SYMBOL_GPL(mt76x02_sw_scan);
@@ -605,9 +603,6 @@ void mt76x02_sw_scan_complete(struct ieee80211_hw *hw,
 	struct mt76x02_dev *dev = hw->priv;
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
-	if (mt76_is_mmio(dev))
-		tasklet_enable(&dev->pre_tbtt_tasklet);
-
 	if (dev->cal.gain_init_done) {
 		/* Restore AGC gain and resume calibration after scanning. */
 		dev->cal.low_gain = -1;
-- 
2.20.1

