Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4152E431ECB
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhJROFU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 10:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234988AbhJRODm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 10:03:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDA8860EE3;
        Mon, 18 Oct 2021 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634565452;
        bh=RQflT1Uq9yCk/MViWXYiNiU5C9eTtX1MMIK3oFIKA8o=;
        h=From:To:Cc:Subject:Date:From;
        b=jUT/hrzvg7U4zi8C6/+i1LKbLdfG38Lj+bOYC1feGGpxWKy3OLyF/vS5W8VA48r8t
         o9rAHNznj/3+fLQr0Hx08MazrRufUysbQC11+8mu3oqp3ryFhIs5c6QtHDIGSytd1H
         rrcSNK6fHjlLpSRW3rwwisxRBVagnJqSCx1AodtdfjYjXVYREHodiCqYEFVpknjs2Y
         tWsPWetDLY7s5jSO8A76N6aJ9I5CnkYDNgSKhjsfRuw8gTr7IfOXknPNiRbQ/Mcgqb
         GIIBInoakWcjA42WmRfrwyDzAWp3k7JZbtMPbKFhdjZ1I6NLC87ksbLWezXXsaBlKt
         dohHFYImjxAew==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: [PATCH] mt76: mt7915: remove dead code in mt7915_get_et_stats
Date:   Mon, 18 Oct 2021 15:57:24 +0200
Message-Id: <84d1ef5a8a381e2f63acec71a755c6414c6530ad.1634565380.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove phy check in mt7915_get_et_stats since hw is received from mac80211
and it can't be NULL

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 7210a1db2050..d56c8456cd2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1213,11 +1213,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	struct mib_stats *mib = &phy->mib;
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
-	int i, n;
-	int ei = 0;
-
-	if (!phy)
-		return;
+	int i, n, ei = 0;
 
 	mutex_lock(&dev->mt76.mutex);
 
-- 
2.31.1

