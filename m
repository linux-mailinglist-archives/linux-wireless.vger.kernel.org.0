Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D197C3DC6DD
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jul 2021 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhGaQM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Jul 2021 12:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGaQM0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Jul 2021 12:12:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2580E61040;
        Sat, 31 Jul 2021 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627747940;
        bh=u4vhuV6w68/tQ78seszT2ioNX+E9BAVwslcQ57LTKP8=;
        h=From:To:Cc:Subject:Date:From;
        b=hvcSRdDyYx8dZJQUAas+6wucLUHMoa8hFq/Nh/C0kpD9t6AJ9n1ivsDMg7kcKBxUT
         gf08CucaYjxifYr6nweW9iiLU5uouggKX2uvgekYS1Tmw+S9ZyOmsaCJkMhOXg6Afn
         DeEYreACiyb7r/khNh1fxkVdqNfHnIz+l6MxtSkY0tecAl7DMphQMFGUXxM5ZoZXly
         iSLxd+XnwvtChE3ufS2AXiyIMn5IwdoWsXy3ylHFExYO7TPgYtklvWAFI5kc6BMr4m
         JQQWmj6MzFKG84thOMso1VrxlSFqGLVQAU2pHYmGCrLkAjIRuuKKl+yHQTjCuc6eBB
         P1gBdVcPaWQkg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: improve code readability in mt7915_mcu_sta_bfer_ht
Date:   Sat, 31 Jul 2021 18:12:14 +0200
Message-Id: <81e2299f3fdb73c6cded1a4cbf027cdc49260da6.1627747597.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even if it is a not real issue, add missing brackets in
mt7915_mcu_sta_bfer_ht routine in order to improve code readability

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 012d5b348892..ac406786080a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1745,7 +1745,7 @@ mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
 	bf->tx_mode = MT_PHY_TYPE_HT;
 	bf->bf_cap = MT_IBF;
 
-	if (mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF &&
+	if ((mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF) &&
 	    (mcs->tx_params & IEEE80211_HT_MCS_TX_DEFINED))
 		n = FIELD_GET(IEEE80211_HT_MCS_TX_MAX_STREAMS_MASK,
 			      mcs->tx_params);
-- 
2.31.1

