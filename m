Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A01A3E4ADA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 19:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhHIR3a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 13:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234154AbhHIR3a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 13:29:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75A4160E76;
        Mon,  9 Aug 2021 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628530149;
        bh=Bpau1Hdkp1O2Q8dRWfeH3s6HF1thF6WEZ6oLTs+k/no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PtqlE/orBO6AVW3qSQs0GaGp4BR/scNGa8dxAP48i7dsNIR53Srr/VbR5BRX4DoUV
         4872js7LgH/y9MQs0DeFSjUVXUGs5CJPY/wepmNs5c0VlGNuOGKQa2ylIGc9x2flkJ
         O/aHYrWbMc8aHGlCFfEUerKpGaAfUwyu8QzgpYgp7n5x+1gESNbjoLId7z0cbwvURs
         kYOf1/vStc+joODpRRv+4kxYrUz6qWGzRvZcObMtZiN8V1jbvsYfSrNLe8SBJcWkrx
         yrU5t++z0dZk1kG7is5g/KJVQ/Gb2s3Y+g3PCydD7seHa+9pe/oOpvy5cNL1pfey51
         LzAbo/W9MnzqA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v2 mac80211-next 6/7] mt76: mt7915: enable twt responder capability
Date:   Mon,  9 Aug 2021 19:28:32 +0200
Message-Id: <8737ac319e44c84db9e5890ffb573ed22b6ac349.1628529781.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628529781.git.lorenzo@kernel.org>
References: <cover.1628529781.git.lorenzo@kernel.org>
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

