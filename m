Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC7347395
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 09:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhCXIZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 04:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233469AbhCXIZ3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 04:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C353F61962;
        Wed, 24 Mar 2021 08:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616574328;
        bh=6ANkZTT4SrahzCBfhWbRmJsyUKOhGKdqtkzvPOUVqmA=;
        h=From:To:Cc:Subject:Date:From;
        b=mNRbqjBU/yz5hdd7ONF50PBvQrQPjg//6AhldPN6645B88CvTa3VV5ap/lBZTL30I
         QL2sGM6eS2DeIM672UuHF0Ta0YxJa9jd1WsEhkgas/lMvMT4WTlHumv5ihbBiCGXjp
         fTJhRUfCUk6HMVRsbK1uAYd8ChK31UrKOD628+UioIeEx9PdH41BZgn8BGVG0bbhom
         P+Ux/R+0PpT6mQkWeG3pndv9EpUuGqgJgCL9z2xZA9r6EG7xXWUN+vhbfN7uq8PmXH
         vjKXvDGPAqfNVByuRGQOPcHzpQYGNZ5RKPn2PTI8PAW16PKDPIghE4vmVnYhqYaX2I
         fH4gjE/1DjOHw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: get rid of mt7921_mac_wtbl_lmac_addr
Date:   Wed, 24 Mar 2021 09:25:22 +0100
Message-Id: <b004508a112ab2f42955d7295c676dcd3146a750.1616574248.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of mt7921_mac_wtbl_lmac_addr routine since mt7921 wtbl size is
19 entries

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 8f26f61282be..19150b12a860 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -49,14 +49,6 @@ bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
 			 0, 5000);
 }
 
-static u32 mt7921_mac_wtbl_lmac_addr(struct mt7921_dev *dev, u16 wcid)
-{
-	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
-		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
-
-	return MT_WTBL_LMAC_OFFS(wcid, 0);
-}
-
 static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 {
 	static const u8 ac_to_tid[] = {
@@ -93,7 +85,7 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 		spin_unlock_bh(&dev->sta_poll_lock);
 
 		idx = msta->wcid.idx;
-		addr = mt7921_mac_wtbl_lmac_addr(dev, idx) + 20 * 4;
+		addr = MT_WTBL_LMAC_OFFS(idx, 0) + 20 * 4;
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 			u32 tx_last = msta->airtime_ac[i];
-- 
2.30.2

