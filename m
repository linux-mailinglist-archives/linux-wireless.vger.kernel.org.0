Return-Path: <linux-wireless+bounces-22480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B742AAA024
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A01F177FC8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3728F507;
	Mon,  5 May 2025 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3xKHW86"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CA28F502;
	Mon,  5 May 2025 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483412; cv=none; b=gKwvZVvbQI99Y9a0rfaTyqXSkBZveL1ACfr9Xv2Rfm3+V4CuptwzC0WtnwG+AUIvMnMytfMB4wFbJuGrgtYEo5+4yblezBlQlHzeyMTOnQVRocHDlMEjP17GPmeezQXC/HyJd3s9lZ/0wl5Fn5GxkaeDiDy53Qud+qSxlcyYZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483412; c=relaxed/simple;
	bh=immGtHOQNAjbPw7pNkpPl9yR0ILfPCW0XuJiUmFodqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gq3WR8RzY2sfHsG3ncZL0rw/y/lXJQszpRf9b1JQALWHkhGAI5EarkGqncx2uCfeoTKiXTNqb2S83QxVdoWG/RgraelLy2+17zPuDLVM5TXzP2z9hqQievcPf+ZR87EhQkaYaY1Ldk55J1U9flKD0BxTt+LoGL+IZEjfn/ye898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3xKHW86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FF7C4CEEF;
	Mon,  5 May 2025 22:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483411;
	bh=immGtHOQNAjbPw7pNkpPl9yR0ILfPCW0XuJiUmFodqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3xKHW86fKdCJcarEJf8NkWmuldJEcWx277LGx2iE6v0tXJPjndNzCB4nUmN81dJQ
	 BRHH80X+HldsSN2Z1AF6Cffxj3cr08ZmN2VligF3BxIirL+G/UITvwqXg1ikx5cGnl
	 ua9D+KeUHevH2Mgv2Kf+jUbxgBk8kkiO6Qe4liMZNRsIu6kX+0kFbGgkf7x3/BCIPS
	 BeZfoaDVyBvKYa/HXAD0KvBF4SnhYyVXsQULcuVI9AL8xmIeBxhU/Eh2vE3mNdBQfd
	 2/caui0LOsB1iJIcfg3/BLtFr3FHPyYv2Jr2Uc+VeWEw3PkWYkXqAsMRqMmVcU/ju0
	 J2Xwur5gGAn9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 072/642] wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()
Date: Mon,  5 May 2025 18:04:48 -0400
Message-Id: <20250505221419.2672473-72-sashal@kernel.org>
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

From: Shayne Chen <shayne.chen@mediatek.com>

[ Upstream commit 9890624c1b3948c1c7f1d0e19ef0bb7680b8c80d ]

This is a preliminary patch to introduce MLO support for MT7996 driver.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Link: https://patch.msgid.link/20250311-mt7996-mlo-v2-10-31df6972519b@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index d0e49d68c5dbf..bafcf5a279e23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -391,7 +391,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
-		    !is_zero_ether_addr(link_conf->bssid)) {
+		    link_conf && !is_zero_ether_addr(link_conf->bssid)) {
 			memcpy(basic->peer_addr, link_conf->bssid, ETH_ALEN);
 			basic->aid = cpu_to_le16(vif->cfg.aid);
 		} else {
-- 
2.39.5


