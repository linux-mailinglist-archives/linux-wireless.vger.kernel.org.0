Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257E747D14E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 12:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbhLVLwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 06:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbhLVLwd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 06:52:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1D3C06173F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 03:52:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7D67B81BC8
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 11:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A10C36AEA;
        Wed, 22 Dec 2021 11:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640173950;
        bh=21NhSvRv7+HMjSRF8OZg9KtzgafWBytJEjFs25vu1lQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HHLM76TS7Wp3I4hkf3vCEwRGe6Z+tCtiFh3CTdchuS40E8GVHEJaxxHMdMbm3ryxL
         2ILxvltGn/hsja15g38fTI12/qWtvJaCLIh68/fc6X4zHdD5urU5epK5S0VPnSbG2x
         LAaLH0a/qoloAEKZ3WJIbmJem0Sut9mEm4B3HsL/wRLlLmdXDfznx0+Eej9WTcyXoc
         GKZn/4kSRcB0OFfbsHck43hK3n8dxsjC7lKLk9T/IDQiUCw5xgfhvduD8p0fQmQbxS
         zFFNrfdW9IHQfTiMBtuf1mbw2fqmZf5fFIJp5poryG4/0TWY1Y2WA4W6b20Ix9KL4l
         8StjHK2YrhurQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: use proper aid value in mt7915_mcu_wtbl_generic_tlv in sta mode
Date:   Wed, 22 Dec 2021 12:52:17 +0100
Message-Id: <7ca692b291bec98229befe677ed5ff2af0c70088.1640173873.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211 provides aid in vif->bss_conf.aid for sta mode and not in
sta->aid. Fix mt7915_mcu_wtbl_generic_tlv routine using proper value for
aid in sta mode.

Fixes: e57b7901469fc ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 1985240c0083..a1d50bbdece2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -988,8 +988,11 @@ mt7915_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	generic = (struct wtbl_generic *)tlv;
 
 	if (sta) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
+		else
+			generic->partial_aid = cpu_to_le16(sta->aid);
 		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
-		generic->partial_aid = cpu_to_le16(sta->aid);
 		generic->muar_idx = mvif->mt76.omac_idx;
 		generic->qos = sta->wme;
 	} else {
-- 
2.33.1

