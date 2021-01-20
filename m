Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C095F2FD0EC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 14:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbhATM7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 07:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbhATMML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 07:12:11 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063DFC061575
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jan 2021 04:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dR7HHTfMHCKCLhthHVIvW/2u3DBNOi21dKCrKwDa6/U=; b=V8inCJOICuMKOI3//pdurtLSv3
        VvMw+FvqiYZf/u+LYMt/hpB9RYkjUPjUGVyFrekeQtB2lFUszHamcDGa4OfE/JpTC/c5gcGNeCLw8
        oe2dVC63IiluMPY+HXQ+10bM2ELsgz/VOHqKlKEjiu/a6/KAJpVJs874ssWCzdwJWj/A=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l2CKe-0008Rx-IX
        for linux-wireless@vger.kernel.org; Wed, 20 Jan 2021 13:11:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7915: make vif index per adapter instead of per band
Date:   Wed, 20 Jan 2021 13:11:23 +0100
Message-Id: <20210120121124.81306-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The firmware treats it as global, so we need to avoid collisions here

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index cbd9892f5bf9..a38f52c87977 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -161,7 +161,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	    is_zero_ether_addr(vif->addr))
 		phy->monitor_vif = vif;
 
-	mvif->idx = ffs(~phy->mt76->vif_mask) - 1;
+	mvif->idx = ffs(~dev->mphy.vif_mask) - 1;
 	if (mvif->idx >= MT7915_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -186,7 +186,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
-	phy->mt76->vif_mask |= BIT(mvif->idx);
+	dev->mphy.vif_mask |= BIT(mvif->idx);
 	phy->omac_mask |= BIT_ULL(mvif->omac_idx);
 
 	idx = MT7915_WTBL_RESERVED - mvif->idx -
@@ -242,7 +242,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
 	mutex_lock(&dev->mt76.mutex);
-	phy->mt76->vif_mask &= ~BIT(mvif->idx);
+	dev->mphy.vif_mask &= ~BIT(mvif->idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
-- 
2.28.0

