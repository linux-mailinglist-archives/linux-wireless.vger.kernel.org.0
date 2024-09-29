Return-Path: <linux-wireless+bounces-13283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F59897F8
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840EF2820DA
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B6156F33;
	Sun, 29 Sep 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bFPhXa2c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC714375C;
	Sun, 29 Sep 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646295; cv=none; b=u6xmQvj1k/OKPb+3L2sfFsspOAtyY16BFKVU9r/8JcwyYCLobFQOGGUKCSeKq3de6dX982GQKkCFyISrwvB2zMWzOntDOxEfdp6dtiTKzGy3N1xQTxUBuJ9sP19gAX+IHNXceBN6POAIzqn7ybainRGbyVUMFouCArQQCh0ucW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646295; c=relaxed/simple;
	bh=q8jPUs9sDrC76GpeR3+6wZiIJol7AI1mGAI3q0C3Q7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfI7nFHRmQPtuIm1yQOrTfVmwUVsmghBWbiX5Y5zISnyPhG7THIoYQ+10f2W1F8unHehhg3mtWYmV3ip/Efm+bqJmvPn5D/lBJo9XNe+ZyEhCPEIjPomIJwZwcakz9H6b90BvxurgjbqgMmKaNMnb7CT2SovUzFE8Tmd0POA63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bFPhXa2c; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id uzzOsWpetUr3muzzOsoFGG; Sun, 29 Sep 2024 21:53:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727639638;
	bh=mnfjPfodqDw5EgjVHclvMeONT3nDh9xuYN3QzGdkxtM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bFPhXa2cn+9H9Hxm/lauaUgMA+xMIR4+9UiBbHItciK4dpQ7OPyq2ERYDgoKODNBt
	 LNsbBzCedHkcj2vPr6F56bYlpBvoHPRLyhjiKRBfHUvzsO8Sl/XTpMQ1vKvFXScSGc
	 3U8N6RPxrhPoQHjupH62N7gXyPQMgeg2qaTWtB5qTXBLBaHOfwB4g4b+Sn7HT7EU7M
	 DQdHf0bucNXPlYaFZImbCzib7y9h1UJ/8IYs/rCE4nf4Kv4Hi3vqhKidEG0D735XnV
	 nXevBZ2ZnRBI0tE6UeHDT1kQClGzN1TS6auAqInsPOuOkGgaLii6bnXRGiFmz8ecHi
	 93aF4Et4tFdqA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Sep 2024 21:53:58 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7915: Fix an error handling path in mt7915_add_interface()
Date: Sun, 29 Sep 2024 21:53:40 +0200
Message-ID: <b9d8fbfc19360bfe60b9cea1cb0f735ab3b4bc26.1727639596.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mt76_wcid_alloc() fails, the "mt76.mutex" mutex needs to be released as
done in the other error handling path of mt7915_add_interface().

Fixes: f3049b88b2b3 ("wifi: mt76: mt7915: allocate vif wcid in the same range as stations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d75e8dea1fbd..bea8b77b1b92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -246,8 +246,10 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, mt7915_wtbl_size(dev));
-	if (idx < 0)
-		return -ENOSPC;
+	if (idx < 0) {
+		ret = -ENOSPC;
+		goto out;
+	}
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
-- 
2.46.2


