Return-Path: <linux-wireless+bounces-22487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB5AAA06F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BCB3AD4F6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D84290BC6;
	Mon,  5 May 2025 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsEZhmGa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DDD27BF64;
	Mon,  5 May 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483435; cv=none; b=pGI0mAX57dlfpRYLh+Mikni/+nqQ8KAUHhCmylvLL7oOaL4lQa6QczHQPrs+tyxkn5fm6UEBVuCDXLz/+WL+yLh+JR3bDHT+tRlQPrw7f2EgTiictTzGPFDipdW/wkS5nSA29NIgXhoKcdqs4938LuyT8KKOO1woM+CgKVAsWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483435; c=relaxed/simple;
	bh=dnFX6L2FuA3kKeW+zfBCzbB85ETKxmxU1Lrgu5g1UlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmnySGEPV+y+V94JVNtlKSnKFwuhQpkhD6I0bLmU9RIHwnXkKFgZ7Mye0pI/W/DGIScG7GP6CnBeBPfRJ1RD3RXl/AScM3qunfORO6mkdd7azRwqIJIYdYXm+3SkRbXcvnL/5vXv4744xa1qn3QsI3RgV+xpXbCzss7tbACBu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsEZhmGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44B9C4CEE4;
	Mon,  5 May 2025 22:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483434;
	bh=dnFX6L2FuA3kKeW+zfBCzbB85ETKxmxU1Lrgu5g1UlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsEZhmGaHbtsqsSwZUaDn3hv0xM0I82ApJQsCoIIOC41VJCS3apSA51ZUvH+j/tnT
	 eqBJbDZXUFyaceJVRbc90/ZNxN/F5nBMj07AdZJSp1ywAwVegrBLSbBaoNNk3rJYN1
	 0v+adjnERbs7tebpc3+5guXi6dWBtH2HGnDrlNV9XP8alxriKXjG8igfoWfGs5qeL/
	 YL5SKgG9oeKDataDmGq0HcxLy4cubdp6alJ0L+R/5OPWuQcP31xetbFJkJyjEGKmSq
	 zqmuisy1yS3y7hcMXAqNl1GiVXJsn4s9oPOxxikeyxgsK+dH22K4uijSCRL5dMz2Em
	 c5KqpYl8tXCqw==
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
Subject: [PATCH AUTOSEL 6.14 079/642] wifi: mt76: mt7996: revise TXS size
Date: Mon,  5 May 2025 18:04:55 -0400
Message-Id: <20250505221419.2672473-79-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 88f9d9059d5f2..c7e8336027334 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1413,7 +1413,7 @@ bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
 		mt7996_mac_tx_free(dev, data, len);
 		return false;
 	case PKT_TYPE_TXS:
-		for (rxd += 4; rxd + 8 <= end; rxd += 8)
+		for (rxd += MT_TXS_HDR_SIZE; rxd + MT_TXS_SIZE <= end; rxd += MT_TXS_SIZE)
 			mt7996_mac_add_txs(dev, rxd);
 		return false;
 	case PKT_TYPE_RX_FW_MONITOR:
@@ -1456,7 +1456,7 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
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


