Return-Path: <linux-wireless+bounces-27591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE2B93791
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 00:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207034800F6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971E31A059;
	Mon, 22 Sep 2025 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MYjl8XYt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A731A550
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579569; cv=none; b=PzAQVl/n9PCcHnHt//B9nOsLaxzc2tMcvBXZuK3lVuQDI/wuZQUzqqb8eJR1mfbVfTv7MyprKnImBmEOnXYxIWmQHbH0kFkDxi39QxvchqsU8m6KBurYDT0XIjte5gy+7l6+MRQ3otIAVoEhDwkFJh5tED33F+GIZT3HRQo56N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579569; c=relaxed/simple;
	bh=XGZvIp01wn7LPh7YpyzrGzfwnmq3Ff1XdQ3c5LqmWC8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CMObSUSonE8fuyH1Wd+9hQsq02CdwrtPUGkcAWiE7iixo8DcVzyeF+8vITiZ50ex51zJFbQlxSNEWsOLsYYV60J3GrURQt5WaI/RqBlzNYpO1kqmSjJE/E63TAXylGxZffppb0tP8ssYT2ozZxNYGTtHnC0TzoaOPdK/KByZmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MYjl8XYt; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2d8a8824980211f08d9e1119e76e3a28-20250923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KKLJCyUCq+FjMm6ii56qtkhbgKnscBrhK6k7vga1atU=;
	b=MYjl8XYt1wXvUg/GyvXFtF5d28fQAdwjUN4LnK98wZTbVxxE+6FUzXodoe6ecylCBX3cEb5P9MTDwmb4iJ9Pb+WBnJxLB4dfakoqAflyOVaXtw6tgiCeYCgO/2kFIiumbk6CbYM6ZAKrA0DsW0nVtxJmVHGQqz6pAHpta0OpDQM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:509c864d-aed4-41a6-8c4d-a34c2603c7d6,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:f71893f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d8a8824980211f08d9e1119e76e3a28-20250923
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1842891056; Tue, 23 Sep 2025 06:19:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Sep 2025 06:19:15 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 23 Sep 2025 06:19:12 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: <linux-wireless@vger.kernel.org>
CC: Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Felix Fietkau <nbd@nbd.name>, Ryder Lee
	<ryder.lee@mediatek.com>
Subject: [PATCH v1] wifi: cfg80211: fix width unit in cfg80211_radio_chandef_valid()
Date: Mon, 22 Sep 2025 22:19:08 +0000
Message-ID: <df54294e6c4ed0f3ceff6e818b710478ddfc62c0.1758579480.git.Ryder Lee ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

The original code used nl80211_chan_width_to_mhz(), which returns the width in MHz.
However, the expected unit is KHz.

Fixes: 510dba80ed66 ("wifi: cfg80211: add helper for checking if a chandef is valid on a radio")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v1: correct my email address
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index d12d49134c88..55925d6f800f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2992,7 +2992,7 @@ bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
 	u32 freq, width;
 
 	freq = ieee80211_chandef_to_khz(chandef);
-	width = cfg80211_chandef_get_width(chandef);
+	width = MHZ_TO_KHZ(cfg80211_chandef_get_width(chandef));
 	if (!ieee80211_radio_freq_range_valid(radio, freq, width))
 		return false;
 
-- 
2.45.2


