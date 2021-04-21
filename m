Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933FA366964
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhDUKoj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235065AbhDUKoj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:44:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EBA56144F;
        Wed, 21 Apr 2021 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619001846;
        bh=3i8i+YuxFykd/N2sZYPpwKkoKgZ1UmdF2KcGhGOEZHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9yaMuGBb8bHT78iMcOvDMhSiFJ26K/uDKsr2oKVgLPBLY164TwXXzEc1j5ZoJhDW
         FQb2LglLQqwTU/9Gn+kcKeIT/jIlRFieUORBPrBn4PT5p3jIu3xSZsAjtMeTtZ2Rev
         UrKKIEbIIRI+AYJ7fHVByQ6H/7fksP1GXbMEzo5j4h39drAztBR6v+dBLdYKt96v/Y
         mLiOg9+DQVrtlBm8fQyAuHGid9yzRkcEUXqXLg2UP7M7Y82gUx4VOYguSp0wOeO1Fz
         CpzO4PGmVTIPwuM7OqUoIoKOdmEr8i+fdb4yEsJlr1jOQJkY7r0G1tHGbkZf++E7hX
         iHCrrsU8z2rIA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 4/4] mt76: mt7921: mt7921_stop should put device in fw_own state
Date:   Wed, 21 Apr 2021 12:43:51 +0200
Message-Id: <ee77bffb4abf0c84b2e04c9c76c484acd2622c61.1619001617.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619001617.git.lorenzo@kernel.org>
References: <cover.1619001617.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

mt7921_stop should put device in fw_own state to reduce
power consumption.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index b32f26c1f8b3..6f180c92d413 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -37,7 +37,7 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 	if (!mt76_is_mmio(dev))
 		return;
 
-	if (!pm->enable || !test_bit(MT76_STATE_RUNNING, &phy->state))
+	if (!pm->enable)
 		return;
 
 	pm->last_activity = jiffies;
-- 
2.30.2

