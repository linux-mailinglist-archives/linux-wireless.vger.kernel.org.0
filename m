Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B6724D1FF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 12:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHUKKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 06:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHUKKL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 06:10:11 -0400
Received: from lore-desk.redhat.com (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B0D207DA;
        Fri, 21 Aug 2020 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598004611;
        bh=/rSAMTjY0TLa/oi0MdcxxWOmYRw1XUAphkyZYSi3opE=;
        h=From:To:Cc:Subject:Date:From;
        b=F1dTuYMprbrmzigrWSmxkId67HB/EvhE3PjuTdrigIIGNXcZrCPMzt8prGktptdfA
         UO1CMec5kej5NZjRn6bU2xRR4AUI17FU/KxumFaPUQmfdW+2Exdisw9/ADawW/Hi84
         d+N17LY+k3NjLHTIg6C60eJRPSGktYMtqRigTmZU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix a possible NULL pointer dereference in mt7615_pm_wake_work
Date:   Fri, 21 Aug 2020 12:09:54 +0200
Message-Id: <a3ffc514ddd9655852674aed228c05d648ac5cc2.1598004511.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize wcid to global_wcid if msta is NULL in mt7615_pm_wake_work
routine since wcid will be dereferenced running mt76_tx()

Fixes: 2b8cdfb28d340 ("mt76: mt7615: wake device before pushing frames in mt7615_tx")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e3663c7c374f..e4aeba17da67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1857,12 +1857,13 @@ void mt7615_pm_wake_work(struct work_struct *work)
 	spin_lock_bh(&dev->pm.txq_lock);
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		struct mt7615_sta *msta = dev->pm.tx_q[i].msta;
-		struct mt76_wcid *wcid = msta ? &msta->wcid : NULL;
 		struct ieee80211_sta *sta = NULL;
+		struct mt76_wcid *wcid;
 
 		if (!dev->pm.tx_q[i].skb)
 			continue;
 
+		wcid = msta ? &msta->wcid : &dev->mt76.global_wcid;
 		if (msta && wcid->sta)
 			sta = container_of((void *)msta, struct ieee80211_sta,
 					   drv_priv);
-- 
2.26.2

