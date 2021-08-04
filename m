Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211FF3DFC2D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 09:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhHDHh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 03:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235964AbhHDHhX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 03:37:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5279460F25;
        Wed,  4 Aug 2021 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628062630;
        bh=Bpau1Hdkp1O2Q8dRWfeH3s6HF1thF6WEZ6oLTs+k/no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8umoFSsepLBIwgIwRzxESpgxXp9V9hz6PJ4m71fz/rYK1FzaJEhb0/xbq9lyqFQo
         jiCgz96IIsDyAjkF0UyqSQG8eQRwnc4b8fyVZ7aE0uTbqVlMaZo0It+ucah2mIJbCI
         YetS1kvs7I02fbuj+CmzfMHgnUFgBFv5JiFL67mg1kJifqDIYfvZZuMcKCRpymb7X5
         nFAaBkv11m7JJ3FAOiIXHrzrWRT9QnaSzIQB2gHMjz68qaavUioJGgf5L+w13H4GcB
         HqlwjN5vVGzUYCAMD6xBFxlZngyUAemZ0kkZ8S0KXGeXSzw0d5HnSW3ogU1iESArjP
         JfeyewbFCycMg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH mac80211-next 6/7] mt76: mt7915: enable twt responder capability
Date:   Wed,  4 Aug 2021 09:36:37 +0200
Message-Id: <24f719df1c9100a53315dd0206ed956a19a96628.1628062233.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628062233.git.lorenzo@kernel.org>
References: <cover.1628062233.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable TWT support in AP mode

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 3ed48542e122..b554de8e7100 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -666,6 +666,8 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 
 		switch (i) {
 		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_RES;
 			he_cap_elem->mac_cap_info[2] |=
 				IEEE80211_HE_MAC_CAP2_BSR;
 			he_cap_elem->mac_cap_info[4] |=
-- 
2.31.1

