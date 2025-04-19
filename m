Return-Path: <linux-wireless+bounces-21745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7E3A9412C
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 04:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D627D447B44
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 02:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547ED136E;
	Sat, 19 Apr 2025 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dQcVhoNN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E833A1CD
	for <linux-wireless@vger.kernel.org>; Sat, 19 Apr 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745031320; cv=none; b=gtInO9RSo8WY2zNbWyKtiJUwwTlK55qwZZ7qlseAKBBXQT1rvc7NMmeVzNxKXm6CdABniFugJ3aWQjYdT0hceowU1XFDw/oYSEnV4+vEWMsfVS5Go4YrEXF4JgohXDVdPfnILBKwof3darNvVV58c0cmlQR0uxyyM1S61b5aZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745031320; c=relaxed/simple;
	bh=K9LT1D/0tD04Hyl41reZpd68EkxgVEYYcMwMlkrApPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=enw+5hZXimPtwXh453NbscOQGfs2jm3E9ASzKJby3auNsSmMFSz0GgDxEOntXZrCRaEDdF4bxQNI0Yf6mbKprKLpyQbbpbPVQbMMKkc45+x1UgTa8SDfmXDrER5xfQb9fGhOsbpivJdao+l/1mHrxWYJoRXBS9NUsEUM+JTg1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dQcVhoNN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745031305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=509KQPGQIr3wARpO0voQQWEHesmQ91+o+xtJTGAi9GM=;
	b=dQcVhoNNESuBOAZ++LX43Y1EWUIxYlO3e26/l2k/JMP8/JOpNALyIBtwdopsC0F7h8Zd2X
	1kvyqk70Zb7QZKPoSKCieESNsPOdbEMBRe4SxfruTiFFBUVUP0wPnJi2UMrPRwPdT3yYRJ
	LStkwjFk/rKFjWZBQA+fJIqWJPO5coo=
From: sunliming@linux.dev
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: sunliming <sunliming@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] wifi: mt76: mt7996: fix variable dereferenced before check warning
Date: Sat, 19 Apr 2025 10:54:17 +0800
Message-Id: <20250419025417.2066787-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below smatch warnings:
drivers/net/wireless/mediatek/mt76/mt7996/main.c:73 mt7996_stop_phy() warn:
variable dereferenced before check 'phy' (see line 71)
drivers/net/wireless/mediatek/mt76/mt7996/main.c:360 mt7996_set_monitor() warn:
variable dereferenced before check 'phy' (see line 358)

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202504101051.1ya4Z4va-lkp@intel.com/
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..cc6bb4544c2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -68,11 +68,13 @@ static int mt7996_start(struct ieee80211_hw *hw)
 
 static void mt7996_stop_phy(struct mt7996_phy *phy)
 {
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev;
 
 	if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
+	dev = phy->dev;
+
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -414,11 +416,13 @@ static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)
 
 static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
 {
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev;
 
 	if (!phy)
 		return;
 
+	dev = phy->dev;
+
 	if (enabled == !(phy->rxfilter & MT_WF_RFCR_DROP_OTHER_UC))
 		return;
 
-- 
2.25.1


