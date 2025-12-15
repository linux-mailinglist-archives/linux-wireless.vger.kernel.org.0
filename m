Return-Path: <linux-wireless+bounces-29756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A41CBDCCF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 13:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A5B4301874D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4362989B5;
	Mon, 15 Dec 2025 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="codP5FRs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B91265CA8
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801441; cv=none; b=nNxdNqtYOeJYHTVRaArdPt5q3roli8DP8pvDPS86mAN6wSjCxB7Ul1s+9xhi3MS9wwM6qFL2hwRrK/PEsdJeWvw39m1SFDENhGuja53/Xn32AzzqOJzJqQkuBzwDIkXYkjBdfK/xBHeEYBWGTbgznt94R5T+q4ijO9L8D+ckYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801441; c=relaxed/simple;
	bh=8g4nYYrcJMsKd/AcAueumsmuvDfVls/lGP0k3T5Sccw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O5/FwPxlDsrnh24wkx4pxqHqwpNMbJkl+i9hK3zLunHyBU6M5pMsqYngQ0kBO1R02Khpyf6hOcorb1H3j+gX0dTAKw/wSkuYIw2kXguar54GEZKQuA/gX/W76B3B5F5tpw9pCyUiX6a1orkWsCAKa6dfqnFuR+LnZEW0VMcczyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=codP5FRs; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ea581210d9b011f0b33aeb1e7f16c2b6-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DfpaJEkerBrqfTqE/r1TRmtVSWOUMTlHDDSSj6YOrlQ=;
	b=codP5FRs/1smgszJAdqGd8oXBf2FWzD4SfBPt8yIk9H8SHIIQLdnOCjNgJ1N3SWA0mO7ECDogxRwLHs++vpLIB+p+fqBVnqNnpOzOJ9fkDjL7XTaLqHO9furi9y3HSdlgWRB1idPV/O8VDnGAwbQqmZ8ajC9V5M7VLtwh4DeZc4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:aee98ec9-396e-468f-9111-228d160a8923,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:6d7e75c6-8a73-4871-aac2-7b886d064f36,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ea581210d9b011f0b33aeb1e7f16c2b6-20251215
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <leon.yen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1108337038; Mon, 15 Dec 2025 20:23:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 20:23:50 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 20:23:50 +0800
From: Leon Yen <leon.yen@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<mingyen.hsieh@mediatek.com>, <michael.lo@mediatek.com>,
	<allan.wang@mediatek.com>, <quan.zhou@mediatek.com>,
	<sarick.jiang@mediatek.com>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <leon.yen@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt792x: Fix a potential deadlock in high-load situations
Date: Mon, 15 Dec 2025 20:22:31 +0800
Message-ID: <20251215122231.3180648-1-leon.yen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

A deadlock may occur between two works, ps_work and mac_work, if their work
functions run simultaneously as they attempt to cancel each other by
calling cancel_delayed_work_sync().

mt792x_mac_work() ->   ...  -> cancel_delayed_work_sync(&pm->ps_work);
mt792x_pm_power_save_work() -> cancel_delayed_work_sync(&mphy->mac_work);

In high-load situations, they are queued but may not have chance to be
executed until the CPUs are released. Once the CPUs are available, there
is a high possibility that the ps_work function and mac_work function will
be executed simultaneously, resulting in a possible deadlock.

This patch replaces cancel_delayed_work_sync() with cancel_delayed_work()
in ps_work to eliminate the deadlock and make the code easier to maintain.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
---
v2: Modify the solution to make it simpler and easier to maintain
---
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 71dec93094eb..888e5a505673 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -375,7 +375,7 @@ void mt792x_pm_power_save_work(struct work_struct *work)
 	}
 
 	if (!mt792x_mcu_fw_pmctrl(dev)) {
-		cancel_delayed_work_sync(&mphy->mac_work);
+		cancel_delayed_work(&mphy->mac_work);
 		return;
 	}
 out:
-- 
2.45.2


