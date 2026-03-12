Return-Path: <linux-wireless+bounces-33079-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBdLO3iOsmlINgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33079-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:59:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766C26FEFE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD90A301468E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB13BC67A;
	Thu, 12 Mar 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X3nIMKfp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0C3B47F8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309531; cv=none; b=irDA7DhARFI/ciAwYtpKXmtegW7IozOTB0ROch4dqg74WnqwKBMwfflhk5yZpOTUgaDWqC+RajpgrAjM89h0PwXP+ZPVNToQtIa1MHSTAwiNVrfBdZNwBPQy2kPEqYTHmcl4v6c/NWN+Cn0BZif5+lb88nThF+snhkSGK0Auo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309531; c=relaxed/simple;
	bh=wER/Nzq7q52u/siZSyThjbxE4LADiJwgDMS7CFmzGsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLIOL8kEQ9BFWO5poKx63XoArXJheo11/6e9IOzWbJyR6AZorZuALoMKipbBaSN4fo7wZ/4VHMZCF5t1KpZZTHa2GsLZDAcdJ9Sd0B9FRrXRMceJQlR++A8LPrmvAkvYs2Y/hvU4KboqxBiXSiffxp6Q8E7wI1vHl7Ubf/vbXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=X3nIMKfp; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 09ecdc541dfa11f1a39cd589f645bc18-20260312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=K19GaqUpapvZu4p2oYRo+83CgK9hKV6x66IFjailb3s=;
	b=X3nIMKfpLolo2NZuwpom30IS9cDUTxYqRXDBh73mJcA6PcigbcWhHWtmMBSwEWW8sqj5IF2W42UeJ9r3yW30xVcldNGqaEgEzZHo+2eKpVswRBjGlQxwZh3pm+pmleVuUPDwbGndCwXXvBCkACNX14cXkElMJSoG+52KNiLBoRc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:154598da-d1d6-4335-b74f-fd58631c88a9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:579784eb-3b42-43ec-801b-62c7b12ba70e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 09ecdc541dfa11f1a39cd589f645bc18-20260312
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 926352955; Thu, 12 Mar 2026 17:58:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Mar 2026 17:58:35 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Mar 2026 17:58:35 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 3/6] wifi: mt76: mt7996: update WFSYS reset flow for MT7990 chipsets
Date: Thu, 12 Mar 2026 17:57:21 +0800
Message-ID: <20260312095724.2117448-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260312095724.2117448-1-shayne.chen@mediatek.com>
References: <20260312095724.2117448-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33079-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6766C26FEFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Skip WFSYS reset during bootup for MT7990 chipsets; only reset if L0.5
recovery is triggered.
Without this fix, the following kernel error may occur:
Internal error: synchronous external abort.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 29 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  8 +++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f3239f530aea..8dfb81eabc9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -791,11 +791,34 @@ static void mt7996_init_work(struct work_struct *work)
 
 void mt7996_wfsys_reset(struct mt7996_dev *dev)
 {
-	mt76_set(dev, MT_WF_SUBSYS_RST, 0x1);
-	msleep(20);
+	if (!is_mt7990(&dev->mt76)) {
+		mt76_set(dev, MT_WF_SUBSYS_RST, 0x1);
+		msleep(20);
+
+		mt76_clear(dev, MT_WF_SUBSYS_RST, 0x1);
+		msleep(20);
+
+		return;
+	}
 
-	mt76_clear(dev, MT_WF_SUBSYS_RST, 0x1);
+	if (!dev->recovery.hw_full_reset)
+		return;
+
+	mt76_set(dev, MT_WF_SUBSYS_RST,
+		 MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT |
+		 MT_WF_SUBSYS_RST_BYPASS_WFDMA_SLP_PROT |
+		 MT_WF_SUBSYS_RST_BYPASS_WFDMA2_SLP_PROT);
+	mt76_rmw(dev, MT_WF_SUBSYS_RST,
+		 MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT_CYCLE,
+		 u32_encode_bits(0x20, MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT_CYCLE));
+	mt76_clear(dev, MT_WF_L05_RST, MT_WF_L05_RST_WF_RST_MASK);
+	mt76_set(dev, MT_WF_SUBSYS_RST, MT_WF_SUBSYS_RST_WHOLE_PATH_RST);
 	msleep(20);
+
+	if (mt76_poll(dev, MT_WF_L05_RST, MT_WF_L05_RST_WF_RST_MASK, 0x1a, 1000))
+		return;
+
+	dev_err(dev->mt76.dev, "wfsys reset fail\n");
 }
 
 static void mt7996_rro_hw_init_v3(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 393faae2d52b..c6379933b6c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -736,7 +736,15 @@ enum offs_rev {
 #define MT_HW_REV				0x70010204
 #define MT_HW_REV1				0x8a00
 
+#define MT_WF_L05_RST				0x70028550
+#define MT_WF_L05_RST_WF_RST_MASK		GENMASK(4, 0)
+
 #define MT_WF_SUBSYS_RST			0x70028600
+#define MT_WF_SUBSYS_RST_WHOLE_PATH_RST		BIT(0)
+#define MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT	BIT(5)
+#define MT_WF_SUBSYS_RST_BYPASS_WFDMA_SLP_PROT	BIT(6)
+#define MT_WF_SUBSYS_RST_BYPASS_WFDMA2_SLP_PROT	BIT(16)
+#define MT_WF_SUBSYS_RST_WHOLE_PATH_RST_REVERT_CYCLE	GENMASK(15, 8)
 
 /* PCIE MAC */
 #define MT_PCIE_MAC_BASE			0x74030000
-- 
2.51.0


