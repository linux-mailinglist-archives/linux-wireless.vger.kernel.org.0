Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DEC3CB954
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbhGPPHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 11:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240679AbhGPPHi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 11:07:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD96E613F8;
        Fri, 16 Jul 2021 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447883;
        bh=SUapj8ZVjbbatk6pcsbhVW0JvfRU1EqjO4QsSmmnqUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dy5fAMrfds+gW0UjpsB6rQjAzI/+1yHxxFkEJG48Jla4eniPdLtAJU0c4c3qozXB5
         wVn3YJQEPLSW02Xu/HgKAMH7BGFfDpzF6NMpvm15uRweJRK3aHLg/AdH3FgAm6+cwM
         CL3/M78u3dmEXCQ9ecdT3PhM38x7kPluDbLy5DMsXVcCdOV12CothMLHE2fnuIZuWc
         PU5qoIJ13AjyeXQXWYjyBVaU1iD1STW5Kur7OSBJPa+pM5aGezxiLmsQugOGiwQ3Hd
         hEy9esRuizUoKrcUg2qc0KQQ1+9M8kSb9DnaFzs1F3YovzFin+Tun662InuolCt+Ey
         6Wa5GPkZDKcAQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name, ryder.lee@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [RFC mac80211-next 6/7] mt76: mt7915: enable twt responder capability
Date:   Fri, 16 Jul 2021 17:04:05 +0200
Message-Id: <500dce1b7be47e90b2c1ba01cb1771d7dbf44b61.1626447537.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626447537.git.lorenzo@kernel.org>
References: <cover.1626447537.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable TWT support in AP mode

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

