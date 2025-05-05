Return-Path: <linux-wireless+bounces-22486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDEAAA071
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673031A837C7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292D290BAC;
	Mon,  5 May 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2SA2VFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B327BF64;
	Mon,  5 May 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483431; cv=none; b=hTUub3hkvpU8GMXhVj7KQL3S6F1/iNQrxq8kROVeqA1suWRIdWkXzYHWVm8Iz4JmByjZzI4tuuPekhCjdwjurnrpTWBkoUwb0ZoMeKR3gSvFJNwg6dCW5KqZ22U8SglLPk3znvwXldKURqCX/EF9GPxiz+CpaXpKhrwCKkeGycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483431; c=relaxed/simple;
	bh=3qEf2fFv1ctCBQfhN3VdnszlaOGcMXZgdrvEJbs9jsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoQT9xlllHvaj5QMCA14UUARi97UTyEE9lK9KI/qHvhWBXwO9OAH/7Ot+lVZ9C8sXKVY+hmAr5787iZaWSoCpfFHPyuOvQZS5dNaq7KTaqgIvkqj9Mz9yWy+MJKW2MvrCXpi5ehZ1fBT1sHOYNaKRXtyaqYCYywtfXMR1EhA/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2SA2VFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3840C4CEE4;
	Mon,  5 May 2025 22:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483431;
	bh=3qEf2fFv1ctCBQfhN3VdnszlaOGcMXZgdrvEJbs9jsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2SA2VFYka19dbhJEfE04bIzTGVVi/3q6n1KgMalb8BNldNrDzRV7ZXVBQDS0xT6G
	 IG/P7yVWP1qLkDB7Vf5mAGIJgQSdbG6Z8LeB+jYZMnXhxhcRhSYjruOqfS2iIDAYVd
	 jPpyomg29TvzPjRHHlrGjtSnOO8Fh/15rpn+xT1tIhoD+SnClS1/svmWOJUGDmsqva
	 nxvjrpgf12P2uKTZFNMjZ6Twb6vR7Ga/92Mmsngi1TRjnsiwBIw1EkO5/+NEVHnJTA
	 sOtbZ4vYipfUqx5MJi1SrkfyW3Kgd783M7M9GJzUQOx4CUGjVo4CvkJC/tCvRLf/2a
	 ASrWzGYQ8zlSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rex Lu <rex.lu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	razvan.grigore@vampirebyte.ro,
	Bo.Jiao@mediatek.com,
	shayne.chen@mediatek.com,
	wiagn233@outlook.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 078/642] wifi: mt76: mt7996: fix SER reset trigger on WED reset
Date: Mon,  5 May 2025 18:04:54 -0400
Message-Id: <20250505221419.2672473-78-sashal@kernel.org>
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

From: Rex Lu <rex.lu@mediatek.com>

[ Upstream commit 8d38abdf6c182225c5c0a81451fa51b7b36a635d ]

The firmware needs a specific trigger when WED is being reset due to an
ethernet reset condition. This helps prevent further L1 SER failure.

Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Link: https://patch.msgid.link/20250311103646.43346-2-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h  | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 43468bcaffc6d..a75e1c9435bb0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -908,7 +908,8 @@ enum {
 	UNI_CMD_SER_SET_RECOVER_L3_TX_DISABLE,
 	UNI_CMD_SER_SET_RECOVER_L3_BF,
 	UNI_CMD_SER_SET_RECOVER_L4_MDP,
-	UNI_CMD_SER_SET_RECOVER_FULL,
+	UNI_CMD_SER_SET_RECOVER_FROM_ETH,
+	UNI_CMD_SER_SET_RECOVER_FULL = 8,
 	UNI_CMD_SER_SET_SYSTEM_ASSERT,
 	/* action */
 	UNI_CMD_SER_ENABLE = 1,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 7a8ee6c75cf2b..9d37f82387464 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -281,7 +281,7 @@ static int mt7996_mmio_wed_reset(struct mtk_wed_device *wed)
 	if (test_and_set_bit(MT76_STATE_WED_RESET, &mphy->state))
 		return -EBUSY;
 
-	ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_TRIGGER, UNI_CMD_SER_SET_RECOVER_L1,
+	ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_TRIGGER, UNI_CMD_SER_SET_RECOVER_FROM_ETH,
 				 mphy->band_idx);
 	if (ret)
 		goto out;
-- 
2.39.5


