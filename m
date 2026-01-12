Return-Path: <linux-wireless+bounces-30699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D6D12573
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 12:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C49C305499B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9446212566;
	Mon, 12 Jan 2026 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mbSIhAcB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AD1FECBA
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218031; cv=none; b=YKHcYAWJdeonGwVX0/neTq+Q+wFnzDE4Sl7ErJ52pIi+rCTWAm24NX92WE3ac5t17cRC49yfW8g/cLnSHNASfpk9UlShPwwyw4LVN6i22WBXOPfOgBxjNSznZR/FuZ/IklAC1EmJ/g/JQ+aaneMVou4UtAZCsGEriW+CKFHX0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218031; c=relaxed/simple;
	bh=p1wgX6SrB9TfOsqeuCLSzAfLnnOa57FiBiKxABaw/Yc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CeL7Rr7oBHBrWmUxv0r2VBHNNiOq14BCFVCKgQ9dTz9EnHY+8UVrf9n4+woVm6/rYbNZJSxOuUnwdBcoGw7XKCJAC8vwYvd6Pi60cFHSfvMMugKZ/NfPtyRxhqb7Aj6gaV1W75gfkyeBJGdhr0NRdexd7fOxUwa2HcVUb+0F504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mbSIhAcB; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 76fa4df4efab11f0942a039f3f28ce95-20260112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=561wSHnrgmKBR1P+hEk/MhPgUl4Ghix6Fy0zn2eRhEw=;
	b=mbSIhAcBmH0w1GIKyLMrpFgpl8z+KPLA71cJgnwl76DVauN0yI4iyKD0DMECss5X7q3OuiWBcpmTx+mksRVTAnYp7t8S/clStVan4NDnrLrq8M2iZgkot7QVV3BeRd2RnzyuRRbsUeRFmvmv3l2qav75mbTwBTdYJEEFZXACh5c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9,REQID:958f266f-1d11-4068-8e21-7209e6dda4cf,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:5047765,CLOUDID:2434b179-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76fa4df4efab11f0942a039f3f28ce95-20260112
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <leon.yen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 196207260; Mon, 12 Jan 2026 19:40:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 19:40:15 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 19:40:14 +0800
From: Leon Yen <leon.yen@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<mingyen.hsieh@mediatek.com>, <michael.lo@mediatek.com>,
	<allan.wang@mediatek.com>, <quan.zhou@mediatek.com>,
	<sarick.jiang@mediatek.com>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <leon.yen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: Skip scan process during suspend.
Date: Mon, 12 Jan 2026 19:40:07 +0800
Message-ID: <20260112114007.2115873-1-leon.yen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Michael Lo <michael.lo@mediatek.com>

We are experiencing command timeouts because an upper layer triggers
an unexpected scan while the system/device is in suspend.
The upper layer should not initiate scans until the NIC has fully resumed.
We want to prevent scans during suspend and avoid timeouts without harming
power management or user experience.

Signed-off-by: Michael Lo <michael.lo@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2d358a96640c..38474cd2c38d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1323,10 +1323,18 @@ void mt7925_mlo_pm_work(struct work_struct *work)
 void mt7925_scan_work(struct work_struct *work)
 {
 	struct mt792x_phy *phy;
+	struct mt792x_dev *dev;
+	struct mt76_connac_pm *pm;
 
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						scan_work.work);
 
+	dev = phy->dev;
+	pm = &dev->pm;
+
+	if (pm->suspended)
+		return;
+
 	while (true) {
 		struct sk_buff *skb;
 		struct tlv *tlv;
-- 
2.45.2


