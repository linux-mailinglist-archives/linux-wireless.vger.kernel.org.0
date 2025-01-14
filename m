Return-Path: <linux-wireless+bounces-17500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DA7A10B5E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13C13AAB0D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB71B424B;
	Tue, 14 Jan 2025 15:44:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD91ADC79;
	Tue, 14 Jan 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869494; cv=none; b=E/GUbxOY31whqhZAJw/GAZsSvI4KcurAtPh5qpR93OsuHU/p6HjjmGeIB9L4lHvFRefefopkDUtB1x8aOcnmiIKNfcUuEPH/1r+ZCRkMMQ+T4QQ2DUQFtjJW5/Kod6qZ6PjogjIbH3hzQb69tUurF0tKul2EXBjVYmuMzvahOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869494; c=relaxed/simple;
	bh=9vl5mVnDtXRe1/udoXie00wF1LIBpz7jWB+gQs7Xja4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ssk+3IIRzAggknhzs96yMe5wxOnwbhSKUMdhHId0pmnAv4nfhsye/UO8CoFGGSxJuEAXhEmx09sobkKGkdW1XeQUyjKxoah8dGGBl0TRLZbxHbN8Z7TLLmhR4uJPuRXHbCoJz+g0mVd5mQ4JWjDnjaOwawgUdEhT/2MBoXSCRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 14 Jan
 2025 18:44:45 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 14 Jan
 2025 18:44:45 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	"Ryder Lee" <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	"Sean Wang" <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] wifi: mt76: mt7915: fix possible integer overflows in mt7915_muru_stats_show()
Date: Tue, 14 Jan 2025 07:44:41 -0800
Message-ID: <20250114154441.16920-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Assuming sums of values stored in variables such as sub_total_cnt
and total_ppdu_cnt are big enough to warrant their u64 type, it
makes sense to ensure that their calculation takes into account
possible integer overflow issues.

Play it safe and fix the problem by casting right hand expressions
to u64 as well. Also, slightly adjust tabulation.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 1966a5078f2d ("mt76: mt7915: add mu-mimo and ofdma debugfs knobs")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    | 45 +++++++++++-----------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 578013884e43..4fec7d000a63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -303,9 +303,9 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 		   phy->mib.dl_vht_3mu_cnt,
 		   phy->mib.dl_vht_4mu_cnt);
 
-	sub_total_cnt = phy->mib.dl_vht_2mu_cnt +
-			phy->mib.dl_vht_3mu_cnt +
-			phy->mib.dl_vht_4mu_cnt;
+	sub_total_cnt = (u64)phy->mib.dl_vht_2mu_cnt +
+			     phy->mib.dl_vht_3mu_cnt +
+			     phy->mib.dl_vht_4mu_cnt;
 
 	seq_printf(file, "\nTotal non-HE MU-MIMO DL PPDU count: %lld",
 		   sub_total_cnt);
@@ -353,26 +353,27 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 		   phy->mib.dl_he_9to16ru_cnt,
 		   phy->mib.dl_he_gtr16ru_cnt);
 
-	sub_total_cnt = phy->mib.dl_he_2mu_cnt +
-			phy->mib.dl_he_3mu_cnt +
-			phy->mib.dl_he_4mu_cnt;
+	sub_total_cnt = (u64)phy->mib.dl_he_2mu_cnt +
+			     phy->mib.dl_he_3mu_cnt +
+			     phy->mib.dl_he_4mu_cnt;
 	total_ppdu_cnt = sub_total_cnt;
 
 	seq_printf(file, "\nTotal HE MU-MIMO DL PPDU count: %lld",
 		   sub_total_cnt);
 
-	sub_total_cnt = phy->mib.dl_he_2ru_cnt +
-			phy->mib.dl_he_3ru_cnt +
-			phy->mib.dl_he_4ru_cnt +
-			phy->mib.dl_he_5to8ru_cnt +
-			phy->mib.dl_he_9to16ru_cnt +
-			phy->mib.dl_he_gtr16ru_cnt;
+	sub_total_cnt = (u64)phy->mib.dl_he_2ru_cnt +
+			     phy->mib.dl_he_3ru_cnt +
+			     phy->mib.dl_he_4ru_cnt +
+			     phy->mib.dl_he_5to8ru_cnt +
+			     phy->mib.dl_he_9to16ru_cnt +
+			     phy->mib.dl_he_gtr16ru_cnt;
 	total_ppdu_cnt += sub_total_cnt;
 
 	seq_printf(file, "\nTotal HE OFDMA DL PPDU count: %lld",
 		   sub_total_cnt);
 
-	total_ppdu_cnt += phy->mib.dl_he_su_cnt + phy->mib.dl_he_ext_su_cnt;
+	total_ppdu_cnt += (u64)phy->mib.dl_he_su_cnt +
+			       phy->mib.dl_he_ext_su_cnt;
 
 	seq_printf(file, "\nAll HE DL PPDU count: %lld", total_ppdu_cnt);
 
@@ -404,20 +405,20 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 		   phy->mib.ul_hetrig_9to16ru_cnt,
 		   phy->mib.ul_hetrig_gtr16ru_cnt);
 
-	sub_total_cnt = phy->mib.ul_hetrig_2mu_cnt +
-			phy->mib.ul_hetrig_3mu_cnt +
-			phy->mib.ul_hetrig_4mu_cnt;
+	sub_total_cnt = (u64)phy->mib.ul_hetrig_2mu_cnt +
+			     phy->mib.ul_hetrig_3mu_cnt +
+			     phy->mib.ul_hetrig_4mu_cnt;
 	total_ppdu_cnt = sub_total_cnt;
 
 	seq_printf(file, "\nTotal HE MU-MIMO UL TB PPDU count: %lld",
 		   sub_total_cnt);
 
-	sub_total_cnt = phy->mib.ul_hetrig_2ru_cnt +
-			phy->mib.ul_hetrig_3ru_cnt +
-			phy->mib.ul_hetrig_4ru_cnt +
-			phy->mib.ul_hetrig_5to8ru_cnt +
-			phy->mib.ul_hetrig_9to16ru_cnt +
-			phy->mib.ul_hetrig_gtr16ru_cnt;
+	sub_total_cnt = (u64)phy->mib.ul_hetrig_2ru_cnt +
+			     phy->mib.ul_hetrig_3ru_cnt +
+			     phy->mib.ul_hetrig_4ru_cnt +
+			     phy->mib.ul_hetrig_5to8ru_cnt +
+			     phy->mib.ul_hetrig_9to16ru_cnt +
+			     phy->mib.ul_hetrig_gtr16ru_cnt;
 	total_ppdu_cnt += sub_total_cnt;
 
 	seq_printf(file, "\nTotal HE OFDMA UL TB PPDU count: %lld",

