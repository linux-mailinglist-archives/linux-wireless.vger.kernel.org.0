Return-Path: <linux-wireless+bounces-13195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13D985EC2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6967B20CF2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9755212F1A;
	Wed, 25 Sep 2024 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ0S6+2g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D9212F0E;
	Wed, 25 Sep 2024 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266344; cv=none; b=H3rfJYowPDlKZEjOysUAinuy5U9A1BPyKLdceXUN/buhqHkYYPzt7sdjpzYaJzAVIOykx8aaU6dlRfTMXV39LyvN3PO9Tynnu52dVXqW3hCcG0sQdU44yxanci9UyvS9wYf0Irf6Rh29j9Fyr8NO8vo8o1lN+RJuHg9g26E2beE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266344; c=relaxed/simple;
	bh=3D2z+0SsT8huZ7rlh5ty6QMMg2TVj6QXTKvgfOUzK20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQqJeF5jLJtmwXeD4yVV0pik9iWzo3ve//sI8xKO7wkD+qG4Y9OJruQQ+C89LBzIFEqt/lwNs9vvx6sCE+DEZL8KzEDJ+YdGW6J3Q5L5w6VwZhqbheWFJhoka1V83sZH88BI2yUCFrocKG1dRE6ER0za7CGDKKXK2rPgmHZYvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ0S6+2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445E8C4CEC7;
	Wed, 25 Sep 2024 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266344;
	bh=3D2z+0SsT8huZ7rlh5ty6QMMg2TVj6QXTKvgfOUzK20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJ0S6+2gdwxgCKrf5bqQrGX7JzEj9IXIG0IIZqMAwDKuZIa9cgCiAJFe0vWgMv4HD
	 xEz1j/DlRBl5kgvD2+xmx4Udwfalou0bkSsLnLAx1/+NiKrV/uaCaZwU72iBfby0pi
	 66y0iP2PGKPVwpwCmQBOoGj16WCeIkpNsuCUdrnNPl3Yz7EN6xoNEMw82gzGz+iR4B
	 JfQMi3OlHZtRcqJ6v0KXXcS7gZYm/jLN6XJsaG84skAr46GnZQhUeP8iq+bDiKG63O
	 6fQz+kDHbUIgCCCyTp406lY1/jCMVo3TicncP5QuWyIEEjDfzC1ndxe89M7NJWMHQH
	 uW/zi19h9AgHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shayne.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	meichia.chiu@mediatek.com,
	johannes.berg@intel.com,
	quic_adisi@quicinc.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 019/139] wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
Date: Wed, 25 Sep 2024 08:07:19 -0400
Message-ID: <20240925121137.1307574-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 256cbd26fbafb30ba3314339106e5c594e9bd5f9 ]

Avoids firmware race condition.

Link: https://patch.msgid.link/20240827093011.18621-7-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 272e55ef8e2d2..5fba103bfd65d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -688,13 +688,17 @@ int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)params->sta->drv_priv;
 	struct mt7915_vif *mvif = msta->vif;
+	int ret;
 
+	mt76_worker_disable(&dev->mt76.tx_worker);
 	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
+	ret = mt76_connac_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+				     MCU_EXT_CMD(STA_REC_UPDATE),
+				     enable, true);
+	mt76_worker_enable(&dev->mt76.tx_worker);
 
-	return mt76_connac_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
-				      MCU_EXT_CMD(STA_REC_UPDATE),
-				      enable, true);
+	return ret;
 }
 
 int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
-- 
2.43.0


