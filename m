Return-Path: <linux-wireless+bounces-6828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C26B8B1E47
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDACB27482
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84384DFB;
	Thu, 25 Apr 2024 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fg7stGuB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEB84D2C
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038253; cv=none; b=k52WQDwGVH6LH16SD4iLmyYu/wPYWjSCgOgE3ybelMOAhVKLNZhFkq7mpfZvGiSIj6gWpOgF9RGcTed9f16yRbrAVLD2VRzwWc+apDv0Co/GxsyIf0mfYQ8ZtBX6153wEjthWsIneX1+tYuSo6xbSNjLplbkIXaVJnej0+ex+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038253; c=relaxed/simple;
	bh=QKm3cjQglVoIagl9NWdKZo12+gkQBKI3oWMzyS1j3aI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YM0wOIeB24ulI7SoiHeQohxHQk7kdH945gkdA+nbqRBJA2YQGq7Q1sUsg5lYamf95kiGqbr4pBx6EgN3gCQwpNGQM291myjp4sVRfuI7BgqdTrAPdXyqt5rGc5bkUnLE1ILdknsUqas0Y+egFgV2vl0GfhuLIAXIrxt3TIH+uoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fg7stGuB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 575d887802e811ef935d6952f98a51a9-20240425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dLDkQf2vaEkGIxazc+FMQzXIVTV0+ydf8M//rJxA6KM=;
	b=fg7stGuBmNdhbEVzjpurSIYfflff5n62P/OdVApj8dNGy+VnDRkhnlQ3G15meq5a4+FGr+gPXFas30AsWZb+XlJNAU5DzmTWx3QUqziRh6C9iwpj2xmgKIgGVggH4g+ZHGKicORRdJUDq7rPxMPmCOaFynq6sb2J+Z48R957Fxs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:2b610a08-f9d1-47ab-bc62-b0fb64d1a973,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:423857fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 575d887802e811ef935d6952f98a51a9-20240425
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 677973463; Thu, 25 Apr 2024 17:43:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Apr 2024 17:43:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 Apr 2024 17:43:58 +0800
From: Deren Wu <deren.wu@mediatek.com>
To: Chen-Yu Tsai <wens@kernel.org>
CC: <wireless-regdb@lists.infradead.org>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Taiwan (TW) on 6GHz
Date: Thu, 25 Apr 2024 17:43:13 +0800
Message-ID: <8f7c6ecd8e2cd15d277435719bf993217d40f12d.1714038069.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

The Ministry of Transportation and Communications in Taiwan has updated
its frequency allocation rules [1], now including the 5945 ~ 6425 MHz
range for Low Power Indoor (LPI) and Very Low Power (VLP) devices. As
only one power rule can be applied to a specific frequency range, we
choose the LPI devices with a power limit of 23 dBm. There is no Dynamic
Frequency Selection (DFS) requirement.

Also update the section information for the 2.4/5/60 GHz bands
with reference [1].

[1] LP0002 Low-power Radio-frequency Devices Technical Regulations
    2024/Feb/06
    https://www.ncc.gov.tw/chinese/files/24020/538_49880_240206_3.pdf

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 db.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index fdc2c13..6981930 100644
--- a/db.txt
+++ b/db.txt
@@ -1724,12 +1724,12 @@ country TT: DFS-FCC
 # Table of Frequency Allocations of Republic of China (Taiwan) / Feb 2017:
 #   https://www.motc.gov.tw/websitedowndoc?file=post/201702221012200.doc& \
 #	filedisplay=Table%2Bof%2Bradio%2Bfrequency%2Ballocation.doc
-# LP0002 Low-power Radio-frequency Devices Technical Regulations / 23 Aug 2016:
-#   http://www.ncc.gov.tw/english/show_file.aspx?table_name=news&file_sn=681
+# LP0002 Low-power Radio-frequency Devices Technical Regulations / 6 Feb 2024:
+#   https://www.ncc.gov.tw/chinese/files/24020/538_49880_240206_3.pdf
 country TW: DFS-FCC
-	# 2.4g band, LP0002 section 3.10.1
+	# 2.4g band, LP0002 section 4.10.1
 	(2400 - 2483.5 @ 40), (30)
-	# 5g U-NII band, LP0002 section 4.7
+	# 5g U-NII band, LP0002 section 5.7
 	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
 	(5150 - 5250 @ 80), (23), AUTO-BW
 	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
@@ -1739,7 +1739,9 @@ country TW: DFS-FCC
 	# happy and be able to use channel 144.
 	(5470 - 5730 @ 160), (23), DFS
 	(5725 - 5850 @ 80), (30)
-	# 60g band, LP0002 section 3.13.1.1 (3)(C), EIRP=40dBm(43dBm peak)
+	# 6g band, LP0002 section 5.13.1.1, EIRP=23dBm
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
+	# 60g band, LP0002 section 4.13.1.1 (1)(A), EIRP=40dBm(43dBm peak)
 	(57000 - 66000 @ 2160), (40)
  
 country TZ:
-- 
2.18.0


