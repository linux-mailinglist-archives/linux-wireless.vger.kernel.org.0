Return-Path: <linux-wireless+bounces-31023-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJjmMpzDb2lsMQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31023-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 19:04:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338D4909F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 19:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8FAC3EC97B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01303385AE;
	Tue, 20 Jan 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HkTIH7Gt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77668314B79
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926746; cv=none; b=glf4w0Ub3cTUAS2urO623Wi/tEXX32xQXibD3nhg9OoFht898HbSguutbHKgQP3f/sZqbIZ4cu3aeKduN3CkSGbU3wDZaMoMjag1xnt6Ewv0hpXZA77bIndgrCDh3r1CqjzLqxS+YXum42j4II2/GPlcj7t0zurAJ/Z9ttXs9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926746; c=relaxed/simple;
	bh=Lv8IN7qK2tZ31RoEh+GxGeJXi2DLxJ7udc4GI1mbyl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rqruT8jSQVtajVkxL3PKHgexP2x+13HkAFvtflygaWeKNRjw+9FWfgKN3oRw/C51a76/SnNJEC+GLYFyMqlcmWdVV5A4dBsPtV3huvFOq7iGSdhYyAld00bjuFN3C3QTEogtoyBdXyF+ZwGV6N6CLP+lHBj+k5LeFesbqeZonNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HkTIH7Gt; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 92522bbcf61d11f0b7fc4fdb8733b2bc-20260121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VhzjevPNhMQIYJy/JYceU6XqDtK2KrWqkWBT13xQ+1c=;
	b=HkTIH7GtFLx7u61bQVBwVwuYaz5iwYlrLUS1eev5bkogPck/6lkPpd8APzb5KQ4Nme4V6VDV/+NblC2D794e/RlFxXRhsNL5Q0PnNs59i9i0xv0uO6RN6JwKHnl1kCPbQfOhDL98YZj1wz66AFzSQTpFPkvL4ehbPCUI9zlBmu4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:728b8178-8cd7-4ce3-a363-4af2dc3cf811,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:3a36027a-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 92522bbcf61d11f0b7fc4fdb8733b2bc-20260121
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <leon.yen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1681882341; Wed, 21 Jan 2026 00:32:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 21 Jan 2026 00:32:10 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 21 Jan 2026 00:32:10 +0800
From: Leon Yen <leon.yen@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<mingyen.hsieh@mediatek.com>, <michael.lo@mediatek.com>,
	<allan.wang@mediatek.com>, <quan.zhou@mediatek.com>,
	<sarick.jiang@mediatek.com>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <leon.yen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: fix tx power setting failure after chip reset
Date: Wed, 21 Jan 2026 00:31:52 +0800
Message-ID: <20260120163152.3694116-1-leon.yen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_FROM(0.00)[bounces-31023-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[mediatek.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[leon.yen@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1338D4909F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After the chip reset, the procedure to set the tx power will not be
successful because the previous region setting is still remains.
Clear the region setting during MAC initialization and allow it to be
reset to finalize the TX power setting.

Fixes: 3bc62aa4484d ("wifi: mt76: mt7925: add auto regdomain switch support")
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 3ce5d6fcc69d..c0c5cb9aff75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -91,6 +91,8 @@ int mt7925_mac_init(struct mt792x_dev *dev)
 
 	mt7925_mac_init_basic_rates(dev);
 
+	memzero_explicit(&dev->mt76.alpha2, sizeof(dev->mt76.alpha2));
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_init);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
index 292087e882d1..16f56ee879d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
@@ -232,7 +232,8 @@ int mt7925_regd_change(struct mt792x_phy *phy, char *alpha2)
 	    dev->regd_user)
 		return -EINVAL;
 
-	if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
+	if ((mdev->alpha2[0] && mdev->alpha2[0] != '0') &&
+	    (mdev->alpha2[1] && mdev->alpha2[1] != '0'))
 		return 0;
 
 	/* do not need to update the same country twice */
-- 
2.45.2


