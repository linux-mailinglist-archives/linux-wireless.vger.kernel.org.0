Return-Path: <linux-wireless+bounces-21746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18DBA94159
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 05:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A817B220C
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 03:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679ED53AC;
	Sat, 19 Apr 2025 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UD8N6BD3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC612AE97
	for <linux-wireless@vger.kernel.org>; Sat, 19 Apr 2025 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745032575; cv=none; b=KsmcWNFHDpDqghmKYklniQd8c6SkqIkrf5ik/on/ihh3lYYoSGBmDhWwhJCav95iHIUOe4azSzXIOINY3hhJ8IfIqJ0ZdcZxZMRehet9DH+Ugpy3a5hM0rE1GxxDdjRYacHtaOeX+UioJ3Irr2abD/9a7PaC5HUvw8mTcx7GSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745032575; c=relaxed/simple;
	bh=1hgUWAApDZ5hyEuUg2aB23eXrAGf+Uo6jxH9Jr113xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iNjhkUN0QhPLFNK1wt3PWDHNCyE9PEi1MZb6EPGsQXwZRujzNibrkWammQTpK9JgNySbmwP7ZxknfgxrpMM0H15t+XtnoEh13c+lrSRJ9qMmPThB5vrwZFdi66Chwv3/Jo+Tk/nXRO4TbE2pvvaHjTw4mjMxdOAlMgRqwbQhrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UD8N6BD3; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745032569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HEB3Gu0mmtCLHoo7vWAwYwONR42w2RB1PSaApMMRgZ0=;
	b=UD8N6BD3tYDGzkmMJbDeZEkO8JXQY5pN24SwGdbUgaaIaUgiuZAwtjzpkfiVKXTqzoDVjl
	8ZJQ0OXXBIKd1g47WPLE+obP9bjFP1tERbEtDmJIaBHFvFVw+CvhGgSdKiCICYh0cGeHvc
	AokjfPoZ966kJE8y4FIVKnneZH4aFt0=
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
Subject: [PATCH] wifi: mt76: mt7996: fix uninitialized symbol warning
Date: Sat, 19 Apr 2025 11:15:28 +0800
Message-Id: <20250419031528.2073892-1-sunliming@linux.dev>
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
drivers/net/wireless/mediatek/mt76/mt7996/main.c:952 mt7996_mac_sta_add_links()
error: uninitialized symbol 'err'.
drivers/net/wireless/mediatek/mt76/mt7996/main.c:1133 mt7996_set_rts_threshold()
error: uninitialized symbol 'ret'.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202504101051.1ya4Z4va-lkp@intel.com/
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index cc6bb4544c2a..7c7c4b5a28b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -991,7 +991,7 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	unsigned int link_id;
-	int err;
+	int err = 0;
 
 	for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf;
@@ -1248,7 +1248,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	int i, ret;
+	int i, ret = 0;
 
 	mutex_lock(&dev->mt76.mutex);
 
-- 
2.25.1


