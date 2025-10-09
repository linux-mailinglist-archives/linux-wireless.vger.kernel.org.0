Return-Path: <linux-wireless+bounces-27894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA877BC72C2
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 04:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7580D3E5E82
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A841D516C;
	Thu,  9 Oct 2025 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DWGngXQf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4281C1F02;
	Thu,  9 Oct 2025 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975337; cv=none; b=c9w9n+jFslzEPmt64KtyhfLtXRz/DdDhdQClmwIT6s2ywQ4swo/hGbtbmL8Y1GdjU3ebsUeypJ8LjKg6Kjkhvvtw8w4M1YkJo9tzzD2EkHy1ewu9QmS7tSr8pUx5HYW6T0Shr8C+hYBgBBNICOtDkk0SR2C6dhmQUnUyueTnbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975337; c=relaxed/simple;
	bh=AXBJLQjmVKX4CqJCA5PpFecbwyCPvLASHLapqhwJkaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m2yvMo/z73dm58djxWMz2RhUQyReUqWoopwWRpa7tlFnfPHg26m6Wex1nw/xqqhaXKs/0zJDUyaCZaq94BL7j0NZTfobgLLTdcq++/fOjwJoDaS/21XbpIAEhyJ+GKJlKkd25Qfcz61o5nW9m1CYDyaBKCMAu5iL5t3QkkxGkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DWGngXQf; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f6396deaa4b311f0b33aeb1e7f16c2b6-20251009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aZIE8iEoWepIU4IvbJ7gGd9jnoBAtSM2nxsZWSBh934=;
	b=DWGngXQfD5chsjPJIdgLykAiwas4ZVDDZOIwMTIDcADe2vWAMrwgLNX79azOylUzi89XOD3d1j/IP5rhFLmRcGTFPz5BMEOM9+8tGIZJwS5zj7kg07Kj2bJqXwNQn2ApkIrlUHag/OvmHISFBlSJ+MneBV5hr7aeMf6oVFt8UWw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8d919feb-cf50-4614-9c8f-5fcdd3366f0f,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:e83c3202-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f6396deaa4b311f0b33aeb1e7f16c2b6-20251009
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 549237259; Thu, 09 Oct 2025 10:02:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 9 Oct 2025 10:01:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 9 Oct 2025 10:01:59 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>,
	<stable@vger.kernel.org>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix a potential clc buffer length underflow
Date: Thu, 9 Oct 2025 10:01:58 +0800
Message-ID: <20251009020158.1923429-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Leon Yen <leon.yen@mediatek.com>

The buf_len is used to limit the iterations for retrieving the country
power setting and may underflow under certain conditions due to changes
in the power table in CLC.

This underflow leads to an almost infinite loop or an invalid power
setting resulting in driver initialization failure.

Cc: stable@vger.kernel.org
Fixes: fa6ad88e023d ("wifi: mt76: mt7921: fix country count limitation for CLC")
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 86bd33b916a9..80ccd56409b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1353,6 +1353,9 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		u16 len = le16_to_cpu(rule->len);
 		u16 offset = len + sizeof(*rule);
 
+		if (buf_len < offset)
+			break;
+
 		pos += offset;
 		buf_len -= offset;
 		if (rule->alpha2[0] != alpha2[0] ||
-- 
2.34.1


