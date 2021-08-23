Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81B3F5014
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhHWSEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 14:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231795AbhHWSED (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 14:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6EDC6138B;
        Mon, 23 Aug 2021 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629741800;
        bh=r/dyWtyROZaLlf9laLCTtzhNCxcH3a2A75/fyRzUe9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGu7VgKYFJf2UGYGQYTMympTcixmAXO3aXEZ1Id0mfrkJoa6fWfSVivNhUU9EEorp
         QywPvTsC9xb1ECQKdseEXO9d+T9g6EchDjVyIS1i6C/VE/OoFY3ZlLgi4tGN/jq4dY
         860zxw5bBYp+GX6bWdvjEAFg/yDjcT9csvc3XWGQmrPvCGBu/7WolzronxmIIM9ki4
         r0Lve57XHHUgBW11efNrW42KErW/cyxgV3dclHnG6NyNTAyAoUnmsglvw7rDG1F2N+
         PKg2vtIAno1HSEoepyJTegxWW9w4kV6l3Q70U9L1MSuYNRbMc2H6ADNmrcH917PZ7r
         FzeTfXsRSas1A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v4 mac80211-next 6/7] mt76: mt7915: enable twt responder capability
Date:   Mon, 23 Aug 2021 20:02:43 +0200
Message-Id: <fe82ca26930fefb707510651c428ff7999d9f480.1629741512.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629741512.git.lorenzo@kernel.org>
References: <cover.1629741512.git.lorenzo@kernel.org>
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
index ca9d0380d42b..11bd9b4686ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -699,6 +699,8 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 
 		switch (i) {
 		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_RES;
 			he_cap_elem->mac_cap_info[2] |=
 				IEEE80211_HE_MAC_CAP2_BSR;
 			he_cap_elem->mac_cap_info[4] |=
-- 
2.31.1

