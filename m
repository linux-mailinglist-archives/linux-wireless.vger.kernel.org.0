Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12F647E2E8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348114AbhLWMIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39412 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348120AbhLWMIN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8269061E2E
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB084C36AEA;
        Thu, 23 Dec 2021 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261292;
        bh=G0BiJ7Jr17BgtPXwGco1tl6m3eUgd8PevcQPQkdxFNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7BQc7PGzpUgYWFMLhuxItpG5Z0Zch2i3Pds2KGkDGsYPBTOmzJMcJCTE4a1SQbAL
         B4DCsMQ+udM2qbem62IWCX0FykrA41yjz3uc2/2K4x3tjdRAgEgKIPsVxCfJNGJbsP
         pjgaM6xwU3L8lA/OWd/jLPUtSPya2iMd+CmMrfpFP+AWyRkZ0BJgMFEDB12MWdflVC
         CQT9ID4WEGFU/i4QmM+2bhGT0zLih06Y8jhK2xP2ofso3fBwbU1zsTRQqcCUzdYHcC
         4yGJSofIfkTgGHDoBS+Gqobok6do30+OBxebuO1+/O8KKJA4RM1/sotNyga2evUifc
         tyd/7tgPm+s6w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 06/15] mt76: mt7915: rely on mt76_connac_mcu_wtbl_ba_tlv
Date:   Thu, 23 Dec 2021 13:07:34 +0100
Message-Id: <4ca8c2091e87f33240bdb7a20d63d4a57e1489ef.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_wtbl_ba_tlv routine in mt7915 and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 35 ++-----------------
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 7788f0073c1e..1b56c2956d29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1015,7 +1015,7 @@ void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		ba->rst_ba_sb = 1;
 	}
 
-	if (is_mt7921(dev)) {
+	if (is_mt7921(dev) || is_mt7915(dev)) {
 		ba->ba_winsize = enable ? cpu_to_le16(params->buf_size) : 0;
 		return;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 7b94d78393dc..f56fc4c82fe6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -742,37 +742,6 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 }
 
 /** starec & wtbl **/
-static void
-mt7915_mcu_wtbl_ba_tlv(struct sk_buff *skb,
-		       struct ieee80211_ampdu_params *params,
-		       bool enable, bool tx, void *sta_wtbl,
-		       void *wtbl_tlv)
-{
-	struct wtbl_ba *ba;
-	struct tlv *tlv;
-
-	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
-					     wtbl_tlv, sta_wtbl);
-
-	ba = (struct wtbl_ba *)tlv;
-	ba->tid = params->tid;
-
-	if (tx) {
-		ba->ba_type = MT_BA_TYPE_ORIGINATOR;
-		ba->sn = enable ? cpu_to_le16(params->ssn) : 0;
-		ba->ba_en = enable;
-	} else {
-		memcpy(ba->peer_addr, params->sta->addr, ETH_ALEN);
-		ba->ba_type = MT_BA_TYPE_RECIPIENT;
-		ba->rst_ba_tid = params->tid;
-		ba->rst_ba_sel = RST_BA_MAC_TID_MATCH;
-		ba->rst_ba_sb = 1;
-	}
-
-	if (enable)
-		ba->ba_winsize = cpu_to_le16(params->buf_size);
-}
-
 static int
 mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 		  struct ieee80211_ampdu_params *params,
@@ -800,8 +769,8 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt7915_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
-
+	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, tx,
+				    sta_wtbl, wtbl_hdr);
 	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				    MCU_EXT_CMD(STA_REC_UPDATE), true);
 	if (ret)
-- 
2.33.1

