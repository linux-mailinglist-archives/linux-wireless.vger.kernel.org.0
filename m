Return-Path: <linux-wireless+bounces-24820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32553AF93A4
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A107B5BD5
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031D2F50B0;
	Fri,  4 Jul 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anzXzF2u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FFF2D63E8
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634507; cv=none; b=Uinb1anwISnBo43hCmfWbpL1dZZ9SyOvCTFO4dlbA1PYqBlyIE//BOhcyVh1B5b60V5y4tXaF8u7X5/Qt3iJr/8xXRJLVk7hYK540oPJMlUDys30O9uKpUgQ1vThoFy2o0L42dPSj+1N0l5CypLFcwD8FXwUqQN+vSiLV4E5Q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634507; c=relaxed/simple;
	bh=tQbN0zpDKtZUkhv/MpLlcCccFqUgkW64nZndPIHZEfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yl2pM72Q51gjUg3vavb3gCjVVpX/NhvBcYLyv1RSwajN5JFOX9YXjAt93Eht2kh9kUg+vQMpdOJKRJqpQchBvaAIREoe+Hk1rwE30rCZIuTj/Kfh6HXkrTcW8XUapiG62vKENkRaV/zcSffImoOS6FgFzpdoRClWzpW4oFp/Ww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anzXzF2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EABAC4CEE3;
	Fri,  4 Jul 2025 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634507;
	bh=tQbN0zpDKtZUkhv/MpLlcCccFqUgkW64nZndPIHZEfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=anzXzF2uMEeKjaXubq2vr+o1Z7qkBGyYRG8NnDMFZjsAS97unymxdNGhOc/dMEgQF
	 LPVTDBCkbTypHKFZ1Sy1TpmG+/e1XEkYmNXTnf76JqeRvGF4B9wJXdZxDeUD4gwCbx
	 85lTxmunxhPgLQGfv99kyBbinH5gsHyAMcLTP4RGaHADZLUGAyFnRXZMshq8LeB599
	 aMS+Z6AC3lJlyOX6FMFdFrQb0ymYcdAL3SOrH0if4xNa6NSSPqehmNKcDOrT2JEdmt
	 +Oul4BJruit9wb5uZA52gIuQFpoGAjVfUk//kF+gvEzqGHhgCPljHN3iYmltiHSuLe
	 tIggKCmSRq4/Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:05 +0200
Subject: [PATCH mt76 1/9] wifi: mt76: fix vif link allocation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-1-356456c73f43@kernel.org>
References: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
In-Reply-To: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

From: Felix Fietkau <nbd@nbd.name>

Reuse the vif deflink for link_id = 0 in order to avoid confusion with
vif->bss_conf, which also gets a link id of 0.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h    | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index cc2d888e3f17a58512e6282686b446109ec7ab3c..77b75792eb488e9c5da9ca8026c04157182c13a4 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -173,13 +173,13 @@ void mt76_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	if (!mlink)
 		goto out;
 
-	if (link_conf != &vif->bss_conf)
+	if (mlink != (struct mt76_vif_link *)vif->drv_priv)
 		rcu_assign_pointer(mvif->link[link_id], NULL);
 
 	dev->drv->vif_link_remove(phy, vif, link_conf, mlink);
 	mlink->ctx = NULL;
 
-	if (link_conf != &vif->bss_conf)
+	if (mlink != (struct mt76_vif_link *)vif->drv_priv)
 		kfree_rcu(mlink, rcu_head);
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 14927a92f9d1b313253158c0e53dce8fab9fba18..022d83bb03da1803440c942c9343b709d76aecd4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1865,6 +1865,9 @@ mt76_vif_link(struct mt76_dev *dev, struct ieee80211_vif *vif, int link_id)
 	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_vif_data *mvif = mlink->mvif;
 
+	if (!link_id)
+		return mlink;
+
 	return mt76_dereference(mvif->link[link_id], dev);
 }
 
@@ -1875,7 +1878,7 @@ mt76_vif_conf_link(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_vif_data *mvif = mlink->mvif;
 
-	if (link_conf == &vif->bss_conf)
+	if (link_conf == &vif->bss_conf || !link_conf->link_id)
 		return mlink;
 
 	return mt76_dereference(mvif->link[link_conf->link_id], dev);

-- 
2.50.0


