Return-Path: <linux-wireless+bounces-32093-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHjEL1IEnGlG/AMAu9opvQ
	(envelope-from <linux-wireless+bounces-32093-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:40:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7A172C43
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA19C3037889
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5C11713;
	Mon, 23 Feb 2026 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LRZuVhzk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053834B40C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832349; cv=none; b=OreUZPExHv32DxtXrf1ilrWVz2K1xAmroNWlXwER4em64h4T7sxJA9qWSyB4Fj0Bzr47WGkSXuGTOo2UqyPJpR8YCzeRm937juikXofic3IzPR7mqcAuaIEJ7TTN/kQ5ff4g1JhNlZnrMWuxbnv4tZyLEWDn5DWCJVBHhFazBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832349; c=relaxed/simple;
	bh=WL1PAGfZ+XnVT6eyx9bnVnXkqxbVefPOhxVGyNwbTgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6Ib0RLjxtTIgTkGo4kl0PIXH6vbUodemU2OyL7vhID7ZNBz/w+WEm/9S61T5TjB8wGpV9tb1MuOPJv/E9aFZLv4NhYz951DTFpf9ufrBwlmHINs7+cNF1PGe2F4BZi0XRaKgltm6Cw7mVA8qYECVePEMnL0Nzxvebmdk0JGCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LRZuVhzk; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b7d50530108a11f1b7fc4fdb8733b2bc-20260223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YivnOTAbiMqEyFv+2SP79n5iUJYP62LtjycTcWNwMuc=;
	b=LRZuVhzkneELZJeYvGfl1E9YTka8R+uaJKEj+FMfby1ThYSkDEZuOjPa37eeN9kL6MGDK7Up+ZKDDWsivbuBFHDECA0ItwKULnoEJvnckE5NZ+sWdhy3MgWKYlmeYbMcZE6ay8+L8JccDwDuqIPybZP1Ox6TGY/NMHgD2SNN26A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:0f4a19ea-7d0d-4044-82f3-499b04444309,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:bef9805b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b7d50530108a11f1b7fc4fdb8733b2bc-20260223
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1623039624; Mon, 23 Feb 2026 15:39:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 23 Feb 2026 15:38:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 23 Feb 2026 15:38:58 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>
Subject: [PATCH 2/5] wifi: mt76: mt7921: refactor CLC support check flow
Date: Mon, 23 Feb 2026 15:38:51 +0800
Message-ID: <20260223073854.2464232-2-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260223073854.2464232-1-jb.tsai@mediatek.com>
References: <20260223073854.2464232-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32093-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:mid,mediatek.com:dkim,mediatek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44E7A172C43
X-Rspamd-Action: no action

Move the disable_clc module parameter to regd.c and introduce
mt7925_regd_clc_supported() to centralize CLC support checks.

Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  | 14 ++++++++------
 drivers/net/wireless/mediatek/mt76/mt7921/regd.c | 13 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/regd.h |  1 +
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8442dbd2ee23..1e2afa736cdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -4,6 +4,7 @@
 #include <linux/fs.h>
 #include <linux/firmware.h>
 #include "mt7921.h"
+#include "regd.h"
 #include "mcu.h"
 #include "../mt76_connac2_mac.h"
 #include "../mt792x_trace.h"
@@ -11,10 +12,6 @@
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
 
-static bool mt7921_disable_clc;
-module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
-MODULE_PARM_DESC(disable_clc, "disable CLC support");
-
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
 {
@@ -422,8 +419,7 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	u8 *clc_base = NULL, hw_encap = 0;
 
 	dev->phy.clc_chan_conf = 0xff;
-	if (mt7921_disable_clc ||
-	    mt76_is_usb(&dev->mt76))
+	if (!mt7921_regd_clc_supported(dev))
 		return 0;
 
 	if (mt76_is_mmio(&dev->mt76)) {
@@ -470,6 +466,9 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
 		clc = (const struct mt7921_clc *)(clc_base + offset);
 
+		if (clc->idx >= ARRAY_SIZE(phy->clc))
+			break;
+
 		/* do not init buf again if chip reset triggered */
 		if (phy->clc[clc->idx])
 			continue;
@@ -1403,6 +1402,9 @@ int mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	struct mt792x_phy *phy = (struct mt792x_phy *)&dev->phy;
 	int i, ret;
 
+	if (!ARRAY_SIZE(phy->clc))
+		return -ESRCH;
+
 	/* submit all clc config */
 	for (i = 0; i < ARRAY_SIZE(phy->clc); i++) {
 		ret = __mt7921_mcu_set_clc(dev, alpha2, env_cap,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
index 6e6c81189222..70440ab8ba82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
@@ -7,6 +7,19 @@
 #include "regd.h"
 #include "mcu.h"
 
+static bool mt7921_disable_clc;
+module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
+MODULE_PARM_DESC(disable_clc, "disable CLC support");
+
+bool mt7921_regd_clc_supported(struct mt792x_dev *dev)
+{
+	if (mt7921_disable_clc ||
+	    mt76_is_usb(&dev->mt76))
+		return false;
+
+	return true;
+}
+
 static void
 mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
index 0ba6161e1919..74bc2fdd532c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
@@ -9,5 +9,6 @@
 void mt7921_regd_update(struct mt792x_dev *dev);
 void mt7921_regd_notifier(struct wiphy *wiphy,
 			  struct regulatory_request *request);
+bool mt7921_regd_clc_supported(struct mt792x_dev *dev);
 
 #endif
-- 
2.45.2


