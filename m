Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BDF3AE5D0
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFUJVY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 05:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUJVY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 05:21:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C547610A3;
        Mon, 21 Jun 2021 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624267150;
        bh=LANXM5QF/KoyumDKyhYf+6y9czuOM90F0YtYiPB+MME=;
        h=From:To:Cc:Subject:Date:From;
        b=PeMW2q+Fpesdijf8vnruikztoaDSQHjIgLJMeKczj/mIGCmSfqrT9zhNsk4/KpeLl
         M41ljgh1pKyBGToOyyrK1P6uZq811JK2Hd2CVzX/SplNvfD/OaPJJm9tjoi2fv300r
         d3PGuJF9O9aAnHJfSXmYJTwtNzk5X99UhHPyd+BjCKDI3B1OjFvcSuGwR6tWZbbSA1
         AIcQ5lim9eFV5WbWVQKzLDV9cOZqiopY+8SH2L8Y3JHroFKW/IhIE4XeAJ2db0FjMB
         bg1R8gh00GCKnUP62TRHTo8PxzByqzznFG0zxzKHh7OzqWYZz+rjRSxle+iFJXXYoZ
         lW32ihOlMi6Ag==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: fix endianness warning in mt7921_update_txs
Date:   Mon, 21 Jun 2021 11:18:58 +0200
Message-Id: <363e5246979f904c290dcf94fcd3707558277e63.1624267101.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7921_update_txs routine:
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:752:31:
	warning: cast to restricted __le32
drivers/net/wireless/mediatek/mt76/mt7921/mac.c:752:31:
	warning: restricted __le32 degrades to integer

Fixes: e5bca8c5d2cd3 ("mt76: mt7921: improve code readability for mt7921_update_txs")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7fe2e3a50428..f4714b0f6e5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -735,8 +735,9 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
 static void mt7921_update_txs(struct mt76_wcid *wcid, __le32 *txwi)
 {
 	struct mt7921_sta *msta = container_of(wcid, struct mt7921_sta, wcid);
-	u32 pid, frame_type = FIELD_GET(MT_TXD2_FRAME_TYPE, txwi[2]);
+	u32 pid, frame_type;
 
+	frame_type = FIELD_GET(MT_TXD2_FRAME_TYPE, le32_to_cpu(txwi[2]));
 	if (!(frame_type & (IEEE80211_FTYPE_DATA >> 2)))
 		return;
 
-- 
2.31.1

