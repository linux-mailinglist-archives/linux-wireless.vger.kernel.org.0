Return-Path: <linux-wireless+bounces-33080-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KjFCnmOsmlINgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33080-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:59:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F526FEFF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAB1E301A7C9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55913BC680;
	Thu, 12 Mar 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bVMT1ilH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339803B3BF3
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309531; cv=none; b=HNaAiP5NQDd45CkZrA286S9Gcx9fJ0GlhLng8eGKvxMK9eDofxJliSxV3av+MQlUViDy/olGqOa9Qyj/T0f7OiPOJvxG3+/x1U/kspktr6dNhbJWNyKYA3MXE/c1sfITtLBpQCyajz29m8BMlVZFJ6nHw60AkPlno54BPl75n4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309531; c=relaxed/simple;
	bh=fIJwNvs9aXvaeStdORYDQUgGYPbScP+cZ1kAYCJMV4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HgWssdQQs6qEuYlUhJI3RGyPreiQ8EZKsFW0A3YtTbtqAD0GH8KGgkpm8jomN/EAP8cX+vxvz3AVAuj96jAWbeJ9pVXRLQQt+OLR1G+X4GYwMR/VtjfrnvtR5aitwxcjY6eW7TpsCnfRnv/QVWLYM0K0qGFUmZVte2OtasUwxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bVMT1ilH; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 09b57fac1dfa11f1a39cd589f645bc18-20260312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qplD8CGYzuO6b35VEHxpGDhWihWOwoDLawx+46tbPcQ=;
	b=bVMT1ilHTAXmLhRl+z/hCEDAPFLCe8JqxYRklwfhmKGhg1QETYMiFEdSkFgRl9YGtZgxqw9vh+gBst8NJQKvLIl9TcTyRsjD3+VavCy6SPU8T2Sadsj9PTFHsUkqGLCxYb03kAojdTULnoEkYwCd+VaO7fTf2OlQ3z5ffoLgbsc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dd7392c3-6963-446f-a9cd-0e68cd0aa32d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:756ea4d4-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 09b57fac1dfa11f1a39cd589f645bc18-20260312
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1985089657; Thu, 12 Mar 2026 17:58:36 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
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
Subject: [PATCH mt76 1/6] wifi: mt76: mt7996: fix RRO EMU configuration
Date: Thu, 12 Mar 2026 17:57:19 +0800
Message-ID: <20260312095724.2117448-1-shayne.chen@mediatek.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33080-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC4F526FEFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Use the correct helper to update specific bitfields instead of
overwriting the entire register.

Fixes: eedb427eb260 ("wifi: mt76: mt7996: Enable HW RRO for MT7992 chipset")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5aaa93767109..f3239f530aea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -873,8 +873,7 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 			}
 		} else {
 			/* set emul 3.0 function */
-			mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
-				MT_RRO_3_0_EMU_CONF_EN_MASK);
+			mt76_set(dev, MT_RRO_3_0_EMU_CONF, MT_RRO_3_0_EMU_CONF_EN_MASK);
 
 			mt76_wr(dev, MT_RRO_ADDR_ARRAY_BASE0,
 				dev->wed_rro.addr_elem[0].phy_addr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a415cc610eee..86aaf0f29e28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2559,7 +2559,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	mt7996_dma_start(dev, false, false);
 
 	if (!is_mt7996(&dev->mt76) && dev->mt76.hwrro_mode == MT76_HWRRO_V3)
-		mt76_wr(dev, MT_RRO_3_0_EMU_CONF, MT_RRO_3_0_EMU_CONF_EN_MASK);
+		mt76_set(dev, MT_RRO_3_0_EMU_CONF, MT_RRO_3_0_EMU_CONF_EN_MASK);
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
 		u32 wed_irq_mask = MT_INT_TX_DONE_BAND2 |
-- 
2.51.0


