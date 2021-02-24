Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0481A3241D8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBXQNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 11:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236602AbhBXP6F (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 10:58:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9496764EDB;
        Wed, 24 Feb 2021 15:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614182243;
        bh=jXKsc+uq3r/j6DzkPjcsXgrbFehr8RMoriMJPq3Qsfc=;
        h=From:To:Cc:Subject:Date:From;
        b=s+s97JQtE0Y/iB2yISSubcLWCZ1NdY3rCyhWzPzbiGEm9J5PjUA1ntjgciiA6dSVa
         QVcAqAYUvyUDNL6R2cxSuDJOVIkqkyi2cz6ISK6S/zrGH/IjOzQRdgjYxtjtrV4stN
         XCSqPX2Kf6KmSzpG0+wvcZt97FDRpNmC4JZxbmGU4hiPdAoxwUKgPs8QfdbK1LuhhB
         DkyHUgfMPYdoRdZEePYs/9UdtwPi1mINREKdAgz2ADzBE6IjeYIAO2wDwJuQO7Xzf+
         +Eh7xlRzdPociXRqk4D0lmlDkWmyas3Ii0nIBoIvLrBXfDh5zWoGbCPx3mTUqT7pHc
         HYsnoJ5LqvkvA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: get rid of mt7921_sta_rc_update routine
Date:   Wed, 24 Feb 2021 16:57:18 +0100
Message-Id: <7d12f530aed44be09b4c9c8a98c4793d184969b5.1614182096.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since the rate selection is currently managed by the fw, get rid of
empty mt7921_sta_rc_update routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8f9ac96cccb8..e6926842be3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1057,14 +1057,6 @@ mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
-static void
-mt7921_sta_rc_update(struct ieee80211_hw *hw,
-		     struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta,
-		     u32 changed)
-{
-}
-
 static void mt7921_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta,
@@ -1220,7 +1212,6 @@ const struct ieee80211_ops mt7921_ops = {
 	.sta_add = mt7921_sta_add,
 	.sta_remove = mt7921_sta_remove,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
-	.sta_rc_update = mt7921_sta_rc_update,
 	.set_key = mt7921_set_key,
 	.ampdu_action = mt7921_ampdu_action,
 	.set_rts_threshold = mt7921_set_rts_threshold,
-- 
2.29.2

