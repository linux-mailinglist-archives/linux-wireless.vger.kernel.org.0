Return-Path: <linux-wireless+bounces-19211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72FA3DB32
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C20700FA2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E461F8BA4;
	Thu, 20 Feb 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV4pU/g4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77711F8AE5
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057582; cv=none; b=p1NpR8UyLOxxmaNH4bGkG/cC146/6t7ETxphO29xW9cpkNjkjOrajHsJ1atyJ6ZqpWKEJaNJGKNKtxeTnsi4mrnAClKTcfr5znf133ZYG1wp96rWNzTWNRsKmAY8PYwcAUU6e49pptrMNlRknxRK0NqfmzNZ0wCARWHs4Ypro9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057582; c=relaxed/simple;
	bh=+VpyAaCGQPDlKw/VJRkaWMvum+CMpG8GC+D7rosuNkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYUdwDsB0DkNDA0R8zLVp828P2YcwJWptlLYWRkWsue9yhUvL5QxLIPlB+EU5RMMwJJ8q9slUdsci/aYaOr62qaJNEA6QQqyLxBsKizCTu9LgrbgOFR90MiduCj26TfkLcJJW8g1QEKzAL5H97vPIDK1ciMSjPRbbbXY1rhAbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV4pU/g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121FAC4CEDD;
	Thu, 20 Feb 2025 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057581;
	bh=+VpyAaCGQPDlKw/VJRkaWMvum+CMpG8GC+D7rosuNkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SV4pU/g4yK9CU5ahOAUkvGWwYn4vheSlJeLiIMBeJiegxkJJcFtBbTHrPk0PLS9b5
	 0bCxlON2W5S4PaNuRPElEt3slEGF2iPuuMZ0/TnzORsTUZ1SoRiN64bZB0ZyIUlNsK
	 nRpg1DYDE7lLHo+7o1D8pYVdqnRKB0DRLEfaie42zGRyU+qUiU3nujZaHpufjL7xVG
	 vSHLLJdHZvPO3SGi6m66qF8xtaj1UXXbYWr2aK60F3AOCWk700KSRZZXbF9XGg25Yy
	 4O8MlUTsKskiIJFbqJEzCRjvDWAY61GnSOLryilBq46MhSOJXYWRG76VdyKsV/2e2y
	 7o2c6aqCi5Arw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:57 +0100
Subject: [PATCH 11/14] wifi: mt76: Check link_conf pointer in
 mt76_connac_mcu_sta_basic_tlv()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-11-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

This is a preliminary patch to introduce MLO support for MT7996 driver.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index f30cf9e716105d3aa05a68713e9c857d9df510f8..6e79dab7d8c786ef6435eff41d45aaf63ed1b078 100644
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
2.48.1


