Return-Path: <linux-wireless+bounces-22553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624EAAA8E6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A7118876FE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F6355E33;
	Mon,  5 May 2025 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG3/u/MV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E4355E21;
	Mon,  5 May 2025 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484888; cv=none; b=bGvWqPCld9xC4UyfBGJRTYqe/L6DXeg6p5LdEgY6BzTtlosYcVpQWL+Vlzn8tSjDcGsbSmxlqNHfv0xpdZaR8znKVCNqnDl4kkjSHT12Iz7fYlqEOZfi6+tMd8CRBDI08gfeHPXfRe7KEpNHRy60axLIjnTqAUvfW063AobjF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484888; c=relaxed/simple;
	bh=e59gN0M7ydCagNVUGLQLhN+yYOY3odh4c/JbSARTAo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e02BdVF7gdEcUtyG67tKxY8LJ+7pw46ZzIXnEmUotFCT7Gr/awaC2giBp5fmtGQpjtmgXheTcmza9a80N12bTnauiT8DyPCBF7u853zIeTdTorAQJJCbCNsAxwV2S/XdmzW6dHENnVmdLVLBUrfB6ff9Vj7csBUZlI6TSqXRsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG3/u/MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462C1C4CEE4;
	Mon,  5 May 2025 22:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484887;
	bh=e59gN0M7ydCagNVUGLQLhN+yYOY3odh4c/JbSARTAo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jG3/u/MVJe4gDive6UTkO7ccJBOmzgzH31TL2/OAXUATGt/LoR3lkGGaDYLd85mrt
	 Cath88/l8IhrR5THqg8vQxsxfFKFNKXQKhs6shKNR6/agER71yQ2X1rpx/FeWHk4cK
	 KtQQec+PkECEQNnAfWnQGnMlOD2kY+TMu3GrF/IG4NjcJoVhoG33so2Xiz+wTaEdum
	 bGSxQkAkEcSUZu7/6tljd2nI7FGPDUyv+iepdsq/0+NH58oqx7JC5MiXjicU4mlXrw
	 j0E03EkuCQIVl2smV+LQd2aQS4kqfujHphCSt/eivf4gXKf5+YdaP48JScCCcFyhmE
	 TO8uu2+UwjrvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shayne.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 062/486] wifi: mt76: mt7996: revise TXS size
Date: Mon,  5 May 2025 18:32:18 -0400
Message-Id: <20250505223922.2682012-62-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

[ Upstream commit 593c829b4326f7b3b15a69e97c9044ecbad3c319 ]

Size of MPDU/PPDU TXS is 12 DWs.
In mt7996/mt7992, last 4 DWs are reserved, so TXS size was mistakenly
considered to be 8 DWs. However, in mt7990, 9th DW of TXS starts to be used.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Link: https://patch.msgid.link/20250311103646.43346-1-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index db0c29e65185c..487ad716f872a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -314,6 +314,9 @@ enum tx_frag_idx {
 #define MT_TXFREE_INFO_COUNT		GENMASK(27, 24)
 #define MT_TXFREE_INFO_STAT		GENMASK(29, 28)
 
+#define MT_TXS_HDR_SIZE			4 /* Unit: DW */
+#define MT_TXS_SIZE			12 /* Unit: DW */
+
 #define MT_TXS0_BW			GENMASK(31, 29)
 #define MT_TXS0_TID			GENMASK(28, 26)
 #define MT_TXS0_AMPDU			BIT(25)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index f590902fdeea3..ef2d7eaaaffdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1399,7 +1399,7 @@ bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
 		mt7996_mac_tx_free(dev, data, len);
 		return false;
 	case PKT_TYPE_TXS:
-		for (rxd += 4; rxd + 8 <= end; rxd += 8)
+		for (rxd += MT_TXS_HDR_SIZE; rxd + MT_TXS_SIZE <= end; rxd += MT_TXS_SIZE)
 			mt7996_mac_add_txs(dev, rxd);
 		return false;
 	case PKT_TYPE_RX_FW_MONITOR:
@@ -1442,7 +1442,7 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		mt7996_mcu_rx_event(dev, skb);
 		break;
 	case PKT_TYPE_TXS:
-		for (rxd += 4; rxd + 8 <= end; rxd += 8)
+		for (rxd += MT_TXS_HDR_SIZE; rxd + MT_TXS_SIZE <= end; rxd += MT_TXS_SIZE)
 			mt7996_mac_add_txs(dev, rxd);
 		dev_kfree_skb(skb);
 		break;
-- 
2.39.5


