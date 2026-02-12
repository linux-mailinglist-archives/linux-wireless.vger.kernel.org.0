Return-Path: <linux-wireless+bounces-31760-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGmIHOOXjWkt5AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31760-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 10:05:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC9B12BB47
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 10:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE964300380F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB122DCF43;
	Thu, 12 Feb 2026 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nKfE0bY+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA91400C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887133; cv=none; b=GHhJf9IVfQiZ7yiDtrkPMBAxhsOAYdP16G3fXHIfFvNlO5mStrObpTWoJLc1jWuCpNoBOux1vByJB/JAtvH79o6hdXx9DAY+2scncQ0EjTP0+h2ygZu8Xv4xF/19TFPfP32xgT6SZqn2C1s/elxcQHKpHgj5LE+3G4ahWy5XVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887133; c=relaxed/simple;
	bh=U6euETl6EEBZeZ+9PI/unHE6eK85avjztvzGkzlA6T8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNW84yVG6d23G3TGZK1rS+xzeVWzpOgy7cC0BeZ6rqM/+lu7GeXO7UY8Y5gLohsfjYEe0YnFfjjIvv6uG7a1mNd23r5kOfYG1f79ptS8ReEDHN2icmOxkHFGHduFMTgP9Crh6CUc+trCP6zpXAaP/8UWRKexdw0q1ZUQZ8iwbQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nKfE0bY+; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f7efaaea07f111f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TZ3uOaMaLdzHzN8G3oXEtJI9llm/fFxrp6KV8BGLatU=;
	b=nKfE0bY+WLmRbRVfRFggJPfuuv+guqCTQQEH+uRSAL5/9sGJcEyIKcacJiFoh3bEJ+6TeJRb5e0Xxl4x/C46e47FLVmeeZq6tZfuTFe0rspNJ922i66uVeNFIklBXgYZjeJNyuEup+pxJJfzQrrIF++TLEvf5cNwXbGxdQSEgXA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:518edcb2-44eb-4195-a9d4-02ca2cdf6bcb,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:399b9ae9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f7efaaea07f111f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1823976124; Thu, 12 Feb 2026 17:05:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 17:05:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 17:05:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Shayne Chen
	<shayne.chen@mediatek.com>
Subject: [PATCH mt76 2/3] wifi: mt76: mt7996: add variant for MT7992 chipsets
Date: Thu, 12 Feb 2026 17:03:09 +0800
Message-ID: <20260212090310.3335392-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260212090310.3335392-1-shayne.chen@mediatek.com>
References: <20260212090310.3335392-1-shayne.chen@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-31760-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email]
X-Rspamd-Queue-Id: 0DC9B12BB47
X-Rspamd-Action: no action

Introduce VAR_TYPE_24 for the MT7992 chipsets, a dual-band variant
supporting 3T3R/2SS on the 2 GHz band and 5T5R/4SS on the 5GHz band.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 7 +++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 00c72be8498f..ac05f7d75d63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -33,6 +33,8 @@ static char *mt7996_eeprom_name(struct mt7996_dev *dev)
 			if (dev->var.fem == MT7996_FEM_INT)
 				return MT7992_EEPROM_DEFAULT_23_INT;
 			return MT7992_EEPROM_DEFAULT_23;
+		case MT7992_VAR_TYPE_24:
+			return MT7992_EEPROM_DEFAULT_24;
 		case MT7992_VAR_TYPE_44:
 		default:
 			if (dev->var.fem == MT7996_FEM_INT)
@@ -392,7 +394,8 @@ bool mt7996_eeprom_has_background_radar(struct mt7996_dev *dev)
 			return false;
 		break;
 	case MT7992_DEVICE_ID:
-		if (dev->var.type == MT7992_VAR_TYPE_23)
+		if (dev->var.type == MT7992_VAR_TYPE_23 ||
+		    dev->var.type == MT7992_VAR_TYPE_24)
 			return false;
 		break;
 	case MT7990_DEVICE_ID: {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 1fab04909831..3b4f808b968c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1173,7 +1173,7 @@ static int mt7996_variant_type_init(struct mt7996_dev *dev)
 		else if (u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB_7992))
 			var_type = MT7992_VAR_TYPE_44;
 		else
-			return -EINVAL;
+			var_type = MT7992_VAR_TYPE_24;
 		break;
 	case MT7990_DEVICE_ID:
 		var_type = MT7990_VAR_TYPE_23;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 46099486ec09..98db3bcf76f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -18,6 +18,9 @@
 		case MT7992_VAR_TYPE_23:			\
 			_fw = MT7992_##name##_23;		\
 			break;					\
+		case MT7992_VAR_TYPE_24:			\
+			_fw = MT7992_##name##_24;		\
+			break;					\
 		default:					\
 			_fw = MT7992_##name;			\
 		}						\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ea1f656a9334..d36fb5396141 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -64,6 +64,11 @@
 #define MT7992_FIRMWARE_DSP_23		"mediatek/mt7996/mt7992_dsp_23.bin"
 #define MT7992_ROM_PATCH_23		"mediatek/mt7996/mt7992_rom_patch_23.bin"
 
+#define MT7992_FIRMWARE_WA_24		"mediatek/mt7996/mt7992_wa_24.bin"
+#define MT7992_FIRMWARE_WM_24		"mediatek/mt7996/mt7992_wm_24.bin"
+#define MT7992_FIRMWARE_DSP_24		"mediatek/mt7996/mt7992_dsp_24.bin"
+#define MT7992_ROM_PATCH_24		"mediatek/mt7996/mt7992_rom_patch_24.bin"
+
 #define MT7990_FIRMWARE_WA		""
 #define MT7990_FIRMWARE_WM		"mediatek/mt7996/mt7990_wm.bin"
 #define MT7990_FIRMWARE_DSP		""
@@ -79,6 +84,7 @@
 #define MT7992_EEPROM_DEFAULT_MIX	"mediatek/mt7996/mt7992_eeprom_2i5e.bin"
 #define MT7992_EEPROM_DEFAULT_23	"mediatek/mt7996/mt7992_eeprom_23.bin"
 #define MT7992_EEPROM_DEFAULT_23_INT	"mediatek/mt7996/mt7992_eeprom_23_2i5i.bin"
+#define MT7992_EEPROM_DEFAULT_24	"mediatek/mt7996/mt7992_eeprom_24_2i5i.bin"
 
 #define MT7990_EEPROM_DEFAULT		"mediatek/mt7996/mt7990_eeprom.bin"
 #define MT7990_EEPROM_DEFAULT_INT	"mediatek/mt7996/mt7990_eeprom_2i5i.bin"
@@ -158,6 +164,7 @@ enum mt7996_var_type {
 enum mt7992_var_type {
 	MT7992_VAR_TYPE_44,
 	MT7992_VAR_TYPE_23,
+	MT7992_VAR_TYPE_24,
 };
 
 enum mt7990_var_type {
-- 
2.51.0


