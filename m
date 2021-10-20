Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB62435649
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhJTXL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 19:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTXL6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 19:11:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EF076112D;
        Wed, 20 Oct 2021 23:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634771383;
        bh=Oddsb3NEj3MkSjYmH53Zrxg4zLo1pDO5umlx5J/jl+k=;
        h=From:To:Cc:Subject:Date:From;
        b=TV3kZLpbi+qKdWa3GVlmm1aQACUNWGP4cUYi3oXK8daXGa+EnJP2FNgdrDDGQl2K+
         cq799sA4hfkM00O6QAjJrUZ778vd/D/3qsYsxiKA+Y3kOKrBb26PmlZ2cMgzs+cpWf
         9T3nQjjdCLKa4A3GemYdh6kQZRnK2S3APN/fx9BeT1FxFW1XbPOrZFBPKyw6ymc1dw
         OT36uj/SzNIL1Qp4Cg1KrVrdDF81oyGGcYDAk5arySk0NK56zc7XoBIeAT2X6xxduZ
         fHOlJmWNKXMI8lmfpyxY6R8H2KXUUw7vkYFfaq8I+rrqU//Dhz7PtKzSA+/yb1Ykoz
         kY8Dr0RUAnyMg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: fix endiannes warning mt7915_mcu_beacon_check_caps
Date:   Thu, 21 Oct 2021 01:09:32 +0200
Message-Id: <52eb6d71c8394eb418cedf092a5f8333dc846eac.1634771269.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning mt7915_mcu_beacon_check_caps routine:
warning: cast to restricted __le32
warning: cast from restricted __le16

Fixes: 22dffbddf0167 ("mt76: mt7915: introduce mt7915_mcu_beacon_check_caps()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b4cc4cb35762..4c8a17d3fa28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2443,9 +2443,8 @@ mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			      len);
 	if (ie && ie[1] >= sizeof(*ht)) {
 		ht = (void *)(ie + 2);
-		bc = le32_to_cpu(ht->cap_info);
-
-		vc->ldpc |= !!(bc & IEEE80211_HT_CAP_LDPC_CODING);
+		vc->ldpc |= !!(le16_to_cpu(ht->cap_info) &
+			       IEEE80211_HT_CAP_LDPC_CODING);
 	}
 
 	ie = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, mgmt->u.beacon.variable,
-- 
2.31.1

