Return-Path: <linux-wireless+bounces-27684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FCBA749F
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E87416635B
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D722F177;
	Sun, 28 Sep 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3hevEsR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF61C861E
	for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759076846; cv=none; b=V6hNViYJf+2cPsJ4Dl57GPZYgOa63qDnf8C8pFH8gQ7bsaJi2SZqFNghpoGz3R9JZc94yEc/LQKejJ7FGksLIy1R8DQH3DKW3T1gLwNlFUzwdsDtfmGTkIHIcNsu6y9V7LA0rTY7L9KYPp/bGHDBusnotESjzsKvbFdy6WO1o+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759076846; c=relaxed/simple;
	bh=FnampJXSHrU0rM+ZuwqnJeG9CYsIVyW79tDZuVj+Tlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A8xBPQtagYn1lncQbxWk/1EnyQSuGQX0iBWLTjyG7nyoBAucTe/OiazQW8f3kbf0EZNgfc3GZHHrei9APKPIev5SgIIoJRFFlrwlzurbG9uALYDdGnEHHyW4gSX1nhTfjff2k4a+/ilwqA8BB/DSjO35p24BF/AVJxgrWIp/7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3hevEsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B1AC4CEF0;
	Sun, 28 Sep 2025 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759076845;
	bh=FnampJXSHrU0rM+ZuwqnJeG9CYsIVyW79tDZuVj+Tlc=;
	h=From:Date:Subject:To:Cc:From;
	b=E3hevEsRkAecdgEYvHKNhZ8v4gsgm28pIuhVG+LL+Eu/q7VgguRHflI57Rdj2v29j
	 vXQjtAg6q1qb60SebttOHthzVm2IRUwxTbbYBjOf4JeYYbFUMo8Q2DUMxVTQbSqfhj
	 4pT34ONqp3P8BO325vhssd0Pum4old6ek0zs3n+qi8CAB47zdBBGAHJ1TeYck8+zFl
	 o0TkpHFL1wXBJRjwRyr7URiYHeK/X4tC18SpUDT1yaUjNCcBKVGlT13nDBdaG7YL3V
	 4TmEKqPW0q1TuMzlwufsd6QleGGiUbUdwdGpFGUfOtFleEzbK9NSwnuSM9zoCVbswz
	 OkUqNU4gEp/mA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 28 Sep 2025 18:27:01 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Add missing CHANCTX_STA_CSA
 property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-mt7996_chanctx_sta_csa-v1-1-82e455185990@kernel.org>
X-B4-Tracking: v=1; b=H4sIANRh2WgC/x2M0QoCIRAAf0X2OcHz0PJ+JUIW22of8g5XQhD/P
 etxGGY6CBUmgU11KPRh4T1PWE4K0gvzkzTfJ4M11plgL/pdzyH4+JOptigVYxLUJqy4OuM8OYQ
 ZH4Ue3P7j622ML4eAnYhoAAAA
X-Change-ID: 20250928-mt7996_chanctx_sta_csa-093a35056e5a
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Enable missing CHANCTX_STA_CSA property required for MLO.

Fixes: f5160304d57c ("wifi: mt76: mt7996: Enable MLO support for client interfaces")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5e95a36b42d1645dbf63d8bf6717ac6a29a91a5c..5048f8cf175c2ef4ba6ff343830bdab79fafc441 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -521,6 +521,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
 
 	hw->max_tx_fragments = 4;
 

---
base-commit: 56d9de46715245c9cc46dbe16830e431056abbc3
change-id: 20250928-mt7996_chanctx_sta_csa-093a35056e5a

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


