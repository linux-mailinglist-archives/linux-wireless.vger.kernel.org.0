Return-Path: <linux-wireless+bounces-33082-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YObyOY6OsmlINgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33082-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:59:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9F26FF13
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B11F304C2D7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891683B47E4;
	Thu, 12 Mar 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OqefKu2j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9423B47F8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309534; cv=none; b=KaR5YTnomZtoP5Z/duzXEomY9Ppv+PQbZT2YzRXET32eQf/xHnSBD496kMBeJYMbonNdBJLqNZJNZ3VTSDOWqDpMf1fwhJpP0dvUr1AGWzL/Vl/FRe6dXOGv7nzVdYI3FXmPmGDSpQLyM9r/+mZ3Gtb/CGob68Tlysdra41duZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309534; c=relaxed/simple;
	bh=iZ/G+JLJ53Rtw97akSBHrYRVTBEPPne98gFSI0Vt00o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWF3XAI+9hIZQ7HH1EGnj8ktY+KCd37SGZfpZsQs+BPOrq43FsUeNY5NBi+vFs9Y9aYWXLNM4vS0gd6qG1NqPrqcsaeDxqBiNaCUWPC08sP0cTK21OuQyVQecAPi3J5Qf5fBD1ujw/0fyuYWqwcz7cZOspparbwiAinYPAX21Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OqefKu2j; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a25651a1dfa11f1a02d4725871ece0b-20260312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LGW1Q3DcXuGPmdrKZkdMgEGTb3Lki1aiU/Y6FbqrF6k=;
	b=OqefKu2jQ08eqv8/FNRQr6IQ8MHha+3xKmf92yx7vnYUS7h19kUn48Yh0WI5YJDYhdmG5C16GkD5XXt2WIm0nv5xLVmvlEX5StQk3ige1WE8IMX+DARyXLx4MGwSqp+DGh8WDr6sfvbP6S3Fzz6b5DMPck1FAQeCYpRBiuMDBaY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d68a564b-59c2-4135-8716-b01e83299834,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:806ea4d4-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:2,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a25651a1dfa11f1a02d4725871ece0b-20260312
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1879968139; Thu, 12 Mar 2026 17:58:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Mar 2026 17:58:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Mar 2026 17:58:36 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 5/6] wifi: mt76: mt7996: fix the temporary buffer for calibration-free data
Date: Thu, 12 Mar 2026 17:57:23 +0800
Message-ID: <20260312095724.2117448-5-shayne.chen@mediatek.com>
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
	TAGGED_FROM(0.00)[bounces-33082-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 93A9F26FF13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Move the declaration of buf[] outside the for loop.

Fixes: 224c7c2be578 ("wifi: mt76: mt7996: apply calibration-free data from OTP")
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2a9c59d15894..4c733f51a03e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4104,6 +4104,7 @@ mt7996_mcu_get_cal_free_data(struct mt7996_dev *dev)
 	}
 
 	for (band = 0; band < __MT_MAX_BAND; band++) {
+		u8 buf[MT7996_EEPROM_BLOCK_SIZE];
 		const struct cal_free_data *cal;
 		u16 prev_block_idx = -1;
 		u16 adie_base;
@@ -4126,13 +4127,13 @@ mt7996_mcu_get_cal_free_data(struct mt7996_dev *dev)
 			u16 eep_offset = cal[i].eep_offs;
 			u16 block_idx = adie_offset / MT7996_EEPROM_BLOCK_SIZE;
 			u16 offset = adie_offset % MT7996_EEPROM_BLOCK_SIZE;
-			u8 buf[MT7996_EEPROM_BLOCK_SIZE];
 
 			if (is_mt7996(&dev->mt76) && band == MT_BAND1 &&
 			    dev->var.type == MT7996_VAR_TYPE_444)
 				eep_offset -= MT_EE_7977BN_OFFSET;
 
 			if (prev_block_idx != block_idx) {
+				memset(buf, 0, sizeof(buf));
 				ret = mt7996_mcu_get_eeprom(dev, adie_offset, buf,
 							    MT7996_EEPROM_BLOCK_SIZE,
 							    EEPROM_MODE_EFUSE);
-- 
2.51.0


