Return-Path: <linux-wireless+bounces-32374-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GUrN4NzpmkuQAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32374-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 06:37:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80B1E9487
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 06:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90E27302D0A0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 05:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781C1DF261;
	Tue,  3 Mar 2026 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FFWTh02t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1BC40855
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772516223; cv=none; b=oQTykIsQ79EflsybfJnR7tfxNSrVRpJ1SJwiiKLHGnaFBconszYYJVcjSz53vCtZdnrmWOX7qku6MKvEMeq9e5Nwr1aaURmNMk0vJZlJlKa9QrzUoAW5Tu0+DVRHdW42j3DGkJdMJ1qKcZwUE/knv0xlzIjrQ0Gd6uWfFN9QjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772516223; c=relaxed/simple;
	bh=TPmmdSqMaR1Xp/kxj7bwKhUoY7xHfS/Ahn87NmW3uyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I35kzYMXZMCBEZFon+x4065zL+kdtVQK/bjlGDqJdwLFYMqtlLWPwT+U47uqkR4F2LEiSG9noMoxNfn3Q6ThrxvrPl1Bojxefr7799YsEAdGpXWq9TMjPukT+SikYi6X7PtibiF2LHiD39OyP7eg3gk9wEGy0BEXtS6sahS56bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FFWTh02t; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: facbb0f816c211f1bcd7499a721e883d-20260303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=I5MVbiSNp2ZHifDR6N19v65FzkDq63EhGl8ZOM9pIVk=;
	b=FFWTh02thVTpeBn0mh3vcnm1gPfA27BcLNTeNPTfTvHjW50C6EjijfIa2RqliaUlNiYGF9cqYPKMUKYLM/m2djudSQeFDnwTOENcXsBgMCWk04ac6f7pdhzmQ/hSN4E1LW2lbsGTMnyl0N5C0Tg24JXTBgbcf9hRF4UqFXLPFEE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:519538a0-0f62-4952-936f-d7ebc283edc7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:e839747b-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: facbb0f816c211f1bcd7499a721e883d-20260303
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1730592745; Tue, 03 Mar 2026 13:36:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Mar 2026 13:36:50 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 3 Mar 2026 13:36:49 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>
Subject: [PATCH v2 2/5] wifi: mt76: mt7921: refactor CLC support check flow
Date: Tue, 3 Mar 2026 13:36:34 +0800
Message-ID: <20260303053637.465465-2-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260303053637.465465-1-jb.tsai@mediatek.com>
References: <20260303053637.465465-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Queue-Id: 8A80B1E9487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32374-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Move the disable_clc module parameter to regd.c and introduce
mt7921_regd_clc_supported() to centralize CLC support checks.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
---
v2: Drop the CLC ARRAY_SIZE(phy->clc) defensive checks in
mt7921_load_clc() and mt7921_mcu_set_clc(), since phy->clc is dynamically
allocated and ARRAY_SIZE() is not applicable.
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  |  8 ++------
 drivers/net/wireless/mediatek/mt76/mt7921/regd.c | 13 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/regd.h |  1 +
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8442dbd2ee23..9777c899e503 100644
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
index 51dbbadbc63a..943342984965 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
@@ -6,6 +6,19 @@
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
index 2907b78d375b..ece85feb7a23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
@@ -11,5 +11,6 @@ struct regulatory_request;
 void mt7921_regd_update(struct mt792x_dev *dev);
 void mt7921_regd_notifier(struct wiphy *wiphy,
 			  struct regulatory_request *request);
+bool mt7921_regd_clc_supported(struct mt792x_dev *dev);
 
 #endif
-- 
2.43.0


