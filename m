Return-Path: <linux-wireless+bounces-22570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE8AAAA77
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB134C0356
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A362E687A;
	Mon,  5 May 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHQDQ0V1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B22D9DCD;
	Mon,  5 May 2025 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485875; cv=none; b=pCDlQYq5hsvJxUw/3BH8skNGYpPEz4jOzOfPCuFH/V2ObYAO7KgPguar+flLxPOwqznjamGNEq9U0kGPbhC4C6IeisGsYaKpQDE1DdbGyYgrFhc4EvbkT0O5Ug7tcQAGlgexK50neCSq4vQsiSzqnvH+GDi7BckoFGrtnvLQ6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485875; c=relaxed/simple;
	bh=qZz2XKaHDkoWIJpIga3brULNK+YXlIUjkrF7iAjl0+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fm0K+/HWNd84+Q133c8WfW4lNwisOBAq4odlpEZBCKrL+YdhSYsRonowEWX/OnMFJgUMNbgRY/FYjes++Fvlcb/vZVlYJi2M9RIO6vSaL+R2mHEvd91EHeFLw0onGE6/JWjviv6V8XRZyt009VJdtjY56pE8eeoXFIBhikGbUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHQDQ0V1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD437C4CEED;
	Mon,  5 May 2025 22:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485873;
	bh=qZz2XKaHDkoWIJpIga3brULNK+YXlIUjkrF7iAjl0+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHQDQ0V1XaxNQCB2l39tNsOwZ6DRyXH02uePo9HYxhhjBTS9Tvg84vY3ifhmRug41
	 G7AlxJdB2OjL+jmFmIqBkua0ygyoEQEtm6KWZXqEAX9AQKm0sWJWFagv3K9hFmB2Tk
	 k6P9FVjnkVmEH2/iyOypWaW2w+Lf5BLaivFPbnGKFZBG/3+/bMVYG6FZ2YRhFVGviJ
	 Jdca3jHLzRE0oShIRogjRZPmSjF2+YRJBvCGP00ZerjKzuacrtfWkdb76OgWD2G76U
	 WT+4fVBM6/0vMIoyfyiGaF1JpFRAbTAzH0MY5/xb93xri7GJSBvRsVG2AaHOHwyI1M
	 QDsC+5lupj62g==
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
Subject: [PATCH AUTOSEL 6.6 039/294] wifi: mt76: mt7996: revise TXS size
Date: Mon,  5 May 2025 18:52:19 -0400
Message-Id: <20250505225634.2688578-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 87bfa441a9374..4979012d5abfa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -280,6 +280,9 @@ enum tx_mgnt_type {
 #define MT_TXFREE_INFO_COUNT		GENMASK(27, 24)
 #define MT_TXFREE_INFO_STAT		GENMASK(29, 28)
 
+#define MT_TXS_HDR_SIZE			4 /* Unit: DW */
+#define MT_TXS_SIZE			12 /* Unit: DW */
+
 #define MT_TXS0_BW			GENMASK(31, 29)
 #define MT_TXS0_TID			GENMASK(28, 26)
 #define MT_TXS0_AMPDU			BIT(25)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 73d46ec1181ae..35d9673ec0d8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1354,7 +1354,7 @@ bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
 		mt7996_mac_tx_free(dev, data, len);
 		return false;
 	case PKT_TYPE_TXS:
-		for (rxd += 4; rxd + 8 <= end; rxd += 8)
+		for (rxd += MT_TXS_HDR_SIZE; rxd + MT_TXS_SIZE <= end; rxd += MT_TXS_SIZE)
 			mt7996_mac_add_txs(dev, rxd);
 		return false;
 	case PKT_TYPE_RX_FW_MONITOR:
@@ -1391,7 +1391,7 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
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


