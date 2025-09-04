Return-Path: <linux-wireless+bounces-26993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A4B434CB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409435E828D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3E12BE635;
	Thu,  4 Sep 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmKytEVg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD42BE622
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972644; cv=none; b=LYe3HuJwKfeI2hxbQzlFF16JINiPZCDyRz5c58d7CsfjmffIZPTXolwzkNW5+zTTmZ7NEDgAVPDC9o1O5wjiPz59pRN3tokGwHbnat76B7gCA1sR6JNtRPds35wPFy8aL3Zd2A7CTKSO8czKS48sOZURpXF4sF9WHTQ+R2gFTOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972644; c=relaxed/simple;
	bh=pvJsvoWdlUTvC290n9suVtfKhZuifPF5wPtJPHfxArI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxHU/EwxbXBtg8KM54m3QzODdoiEkqrQ3NwW3R3u8PNaGH2dh/7/NbBsrpqAvDBj7UVK360lwBHKrfDFYLD5zmoyZQymF83QBuxPBAMfkhwO/gTUEj/y50vS7BDGw0HQR0vn8CvKprk7v63B/A5IalvsbYBHKiP1iP9+0fSXepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmKytEVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC2FC4CEF0;
	Thu,  4 Sep 2025 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972643;
	bh=pvJsvoWdlUTvC290n9suVtfKhZuifPF5wPtJPHfxArI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DmKytEVgFvKUkYzq1imcCKcI1zp/r25292wZFTV+c2vUUHNgeB4MooczeAOgIkbi9
	 WyWOFY53frLOZediouAeCMZgkYOu5hIKeE94meIQNumgMpgUbdnH65IuGZe9kBBuGA
	 2UJrY74cmuQtWLiApp8AMekdIn+lNgVkMeau2Ruh9kZcmx/ujJG7c3FCx/6H9Mejh0
	 dx0wGfkAWrZugjCGc57RBCPAvWOT1XPANmkZIzQOC6sAjTNKPxggWy8BoDiKwoJbLp
	 GbCv8eXtPyq63GDTSKzHKnBiPKU8kH7yuT+agZjDk7hgBz4WAGZ3XSiJjDO8IXOUHr
	 9nQNIHM8rormw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 09:56:42 +0200
Subject: [PATCH mt76 4/4] wifi: mt76: mt7996: Temporarily disable EPCS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-mlo-more-fixes-v1-4-89d8fed67f20@kernel.org>
References: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
In-Reply-To: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

EPCS is not yet ready, so do not claim to support it.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index bce128bcb8be7dea64db42f4dd9984ba0b9f4ba1..21ac618d1c836aa997b12769cdbe386265b2b276 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1351,7 +1351,6 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 	eht_cap->has_eht = true;
 
 	eht_cap_elem->mac_cap_info[0] =
-		IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 		IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 		u8_encode_bits(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454,
 			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);

-- 
2.50.1


