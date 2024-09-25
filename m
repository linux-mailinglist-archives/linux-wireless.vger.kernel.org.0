Return-Path: <linux-wireless+bounces-13154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6711985869
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700B11F23B84
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017D18D63E;
	Wed, 25 Sep 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+AO3a8O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE317BEBD;
	Wed, 25 Sep 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264257; cv=none; b=GvJOKpRJaJRwBWVBszUreoBgD6+8UYKawB+rkaMLkscicrys6Kg5SyiBIKL0E3gUzkCrbA18fB4MkV/Fhe+AjFX8/saLKuAR7BnVdqzKgUD6okHSpejElBBAl5GZvt7TpbGV/usK9hfEAgrpb9D/tclcgsfH6bKQ8d054zGdmP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264257; c=relaxed/simple;
	bh=UAF5GK45iE9jlaJBfo86MVxmr9vv+zu9yrGete7VIXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLkQPJsM06h+ut0nCSP0tm8/ObZNb1Cm3OEzPkMwO3stwlUml/UPhuSnl52cGE9a+bUZqX4DkVCnKlZQDqROy4NiXHFQ4y87PDI3UHGq/1tULzwaO4LTYMsZTIYF0o+R4hZiX++qxNpxBPQt7uyqRl/0P/BtxqNB4Vx0Sx6E+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+AO3a8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91050C4CEC3;
	Wed, 25 Sep 2024 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264257;
	bh=UAF5GK45iE9jlaJBfo86MVxmr9vv+zu9yrGete7VIXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+AO3a8O7ippdvrp35cESMorQj30HC7YEwJS+pqQ3lYn5Q8gv8oh0FcASTj87qRIS
	 wCg8OnyBR5vjU20xOB+DbnAxNrOc8e+Dfw7MbP9C1c1I7//dOZwJrIkvgA0XMxsjkq
	 ddPkkib30szgfV9b7Qd7fpIMGCpKQDs7auzdE538VGUKJWyKLUqqlTQpc7q53nMnqn
	 kT+PSLhScWCYDPBeLG0XMya7g9umafeA9zVw0n4K/aO4WifLlI/ajobQBotAR6yTVE
	 /i11+1lM3FCvkVNLJcTaSW+O/zlteKbitcE61Plzykw6a2+iv5vyRP42pWt/5jeaPW
	 kC9Z6I3n3q+jA==
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
	johannes.berg@intel.com,
	meichia.chiu@mediatek.com,
	quic_adisi@quicinc.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 024/244] wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
Date: Wed, 25 Sep 2024 07:24:05 -0400
Message-ID: <20240925113641.1297102-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 2185cd24e2e1c..2f4755820b3cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -690,13 +690,17 @@ int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
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


