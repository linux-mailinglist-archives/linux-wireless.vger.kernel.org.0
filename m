Return-Path: <linux-wireless+bounces-20190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7FA5CC97
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CCF7A4D9E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71659262D32;
	Tue, 11 Mar 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPpE0dJX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE18263C9E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715143; cv=none; b=oTQK1b8xznUrmxB2+nNLFBWOGZOycPuHXyOQL3mQrm0FXQBkFwTc9LyeUCaLpzIIRTjVzOD+gDRDGU4tEOzKMmeIz8ucCGGwTGn8AT01PxMttSq88/PPYS+iYbCxUvoqapiozxurjsqRz4+qBH/nmxi3kK8z+tWhySuox8oDe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715143; c=relaxed/simple;
	bh=GfQP+e9/FOkiyZ4CffiuWj+w7zarlndvdcfCxYmuIDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3k8eQ7yQhsLyQtTT+HlZbiWResmtxn3ghE+TL1RILQmt+GBqRc3U41dIbde8bk3EnoK0avHHV1vemuh9dWHXS6rO5+KQAptP5RpI3PX6Glr6Ds5SpGIRD+nFDO35LeSOiVeMhM92r8sCRJ2RNhxsvgDD5MWG92yOwjpDsilwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPpE0dJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EB0C4CEE9;
	Tue, 11 Mar 2025 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715142;
	bh=GfQP+e9/FOkiyZ4CffiuWj+w7zarlndvdcfCxYmuIDs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TPpE0dJXm/592JDWkQcW8CyoEIpLbdNDMFunMGBG74L2TsdDGvFPMAwWjKawXcBTo
	 lGZ1tmZy+TGuyfwbV25S0Wvo28RFOx/201pVu/JFXc+5bRzmeQV/+jVJ+1v7ij/pzW
	 Q6tQ1evL2v6/aX2lzBFDRyGY3csC8fPGvIsyEyiHC3h9kKZxzkBZe8a4JWGGtdxT+c
	 IkyuIW9eiBk5749CTScDz7wucc//FujACUpytIjckMDo5xnuC5OQvikOYe2K9vYuYS
	 cikVkBNMlxY+QXfl6SHu/OgEdxmsJI8rhojdL0pOfe5IilqUN2SN6dXX+xTUcz9vlB
	 /GEvlVv/GN0Ug==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:09 +0100
Subject: [PATCH v2 10/13] wifi: mt76: Check link_conf pointer in
 mt76_connac_mcu_sta_basic_tlv()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-10-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
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
index d0e49d68c5dbf0ed4eab084d9c6f1cad230bed93..bafcf5a279e23ff007d9052301cd2f6b899c491e 100644
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


