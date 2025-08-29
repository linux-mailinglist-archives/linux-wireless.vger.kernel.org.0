Return-Path: <linux-wireless+bounces-26876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1832DB3C4C9
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Aug 2025 00:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FE51B21418
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826A9264A60;
	Fri, 29 Aug 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPmKgKfP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E447221F0A
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506430; cv=none; b=LnhONEuQ6Gg0/St5Ha/jpJ6OcFsVcJ1xx5+2kBEXUonoAZ7g//UPdC51lT4OqKM9fNBa4PIrAqPMZoSVomjmgLs07faVLQ22AIWTN2E9MiV240uV55aEDmrhrmbSUkTE72FI/5BJHPJATrjJfhpDxSElYrnrTmZlgxUeXmpEscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506430; c=relaxed/simple;
	bh=tNB5HFmWWfIYIDsG4opMaCX9wTee7IZcalG5TFvQ+J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=alVgE3RaN1NlAfVDkqtCteIDGcMe/AZj4lvZGisk81Wo4O+U+atfXAKEoCIyS8xHMTGtpsTLEpgw9//y4rA2OpiQbxOqX7GWPMosBzNnsybmCqSp7CdE8d+pj7j36Hd4xOwSOuS2Y9pJFNsZnuM3V/QsLQ93BHqWG0hnrxTkr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPmKgKfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAF9C4CEF0;
	Fri, 29 Aug 2025 22:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756506430;
	bh=tNB5HFmWWfIYIDsG4opMaCX9wTee7IZcalG5TFvQ+J8=;
	h=From:Date:Subject:To:Cc:From;
	b=dPmKgKfPLHCtlJIyOlT3PnWoga8MHPmxG0GOwx1ADVbp4+xKrpTgs7Tv5ly80uF+V
	 ojfouIhTxhFZOPrUkgxMJJ0UKiO2jplmIxYTieMbcZDs0FNA+6C8eJLTWyjRv2CoRs
	 bv+d4RjTXYMbBjSqTbeQSLYCm+fSz+i2I4AO1aV5NVj+3lMqOEyFVU3g4iPqJRnW1f
	 eSOaKdy2MJA2jb7YK2x1GYPoneKlAd2cDh6uYUXFct9bYhEbl+KurSfw1wiVx4PvDV
	 uspSnOy5aoa6wt/9fXnKEwUpp1Ai6CRI2UDJwIz7pDd/B6MEzK3VexqoFGlCuE1dfd
	 uN7mRQMlujnVw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Aug 2025 00:26:47 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Check phy before init msta_link
 in mt7996_mac_sta_add_links()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-mt7996_mac_sta_add_links-fix-v1-1-4219fb8755ee@kernel.org>
X-B4-Tracking: v=1; b=H4sIACYpsmgC/x3MTQqDMBBA4avIrBtIjD9Nr1IkDGbUoTUtmSCCe
 HeDy+8t3gFCiUngVR2QaGPhXywwjwrGBeNMikMx1Lpu9dNqtebeuc6vOHrJ6DEE/+X4ETXxrtC
 ZBq2bTGcRyuKfqOR7/x7O8wKQ+zhzbgAAAA==
X-Change-ID: 20250830-mt7996_mac_sta_add_links-fix-a914a39f163a
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to avoid a possible NULL pointer dereference in
mt7996_mac_sta_init_link routine, move the phy pointer check before
running mt7996_mac_sta_init_link() in mt7996_mac_sta_add_links routine.

Fixes: dd82a9e02c054 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 7f3a117c52bd3438b6bb41a068bbf11658dfba42..0aa90a447156b6e11adc5e0602d3a7b8d3d1057a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1069,16 +1069,17 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			goto error_unlink;
 		}
 
-		err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
-					       link_id);
-		if (err)
-			goto error_unlink;
-
 		mphy = mt76_vif_link_phy(&link->mt76);
 		if (!mphy) {
 			err = -EINVAL;
 			goto error_unlink;
 		}
+
+		err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
+					       link_id);
+		if (err)
+			goto error_unlink;
+
 		mphy->num_sta++;
 	}
 

---
base-commit: 035ba65d13516fa2afa78203ba3ef54fd70584af
change-id: 20250830-mt7996_mac_sta_add_links-fix-a914a39f163a

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


