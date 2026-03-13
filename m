Return-Path: <linux-wireless+bounces-33181-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHY+B/qxs2lYZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33181-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:43:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FAB27E454
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3441B3140323
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA21280318;
	Fri, 13 Mar 2026 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Kmaa5wO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25EB2F6192
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382999; cv=none; b=JSrQsleq//Jqvppsu8JJe5/QiOg8geq2naNYxCwLeODfcvUOlnaiaKk2f+R7ycFaicSSpDv1jLTW12qzsRYm2n7Ro+HSD7XJ766idvWjCaB9hBESVrl9cl6Zz9DzgiIJ1413PSoGnC51uC+4eVFswEZG9GansRW3Q3bDfVush9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382999; c=relaxed/simple;
	bh=NsJHT7INfaP+gZj0FBUGL8L7JE3Dgy2+6ceaQ6Ie/3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0mp6gTsu2BVXMb9l0ZrwXAwtv5q6lKgXdlscTM1KupuIte8IQcDmXR4vAw5hsCzmM83N+WvdLZ4/v23Gh9MWMNCXXV9X9Exxz47+kaaAm8LCR3zop+oA0RuNb/1B1UbJFpb7vbyZ6V0mu8h+wMVfw7Jo/TPd7aydZj/zUekbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Kmaa5wO4; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1c90881e1ea511f1a39cd589f645bc18-20260313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DR7rv7sxJEAxWeulaxRSLomxxIYwDbyOMGA2IwPmPZA=;
	b=Kmaa5wO436oOQ1vBjzPE8x59PfjxqZDSAzEh1RsxKDykDhxZoHW25ZYXaxavUPfsiY+wopqxzW3ZXU6QxKWWUwb504BV0licmlkWkfkVvsrxcnjHGS6du9WE2U7keFQT/8+HAxi/8zs+htO7FQnGkqbZ7GNxLhIM4ALu67O+EiI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:90f98468-2405-4bc1-a86f-e7ca8b1561ca,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:db03add4-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:5,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1c90881e1ea511f1a39cd589f645bc18-20260313
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1247570028; Fri, 13 Mar 2026 14:23:12 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 13 Mar 2026 14:23:11 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 13 Mar 2026 14:23:11 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Shayne Chen
	<shayne.chen@mediatek.com>
Subject: [PATCH wireless-next 1/2] wifi: ieee80211: fix definition of EHT-MCS 15 in MRU
Date: Fri, 13 Mar 2026 14:21:49 +0800
Message-ID: <20260313062150.3165433-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33181-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid]
X-Rspamd-Queue-Id: 10FAB27E454
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the definition in IEEE Std 802.11be-2024, Table 9-417r, each
bit indicates support for the transmission and reception of EHT-MCS 15 in:
- B0: 52+26-tone and 106+26-tone MRUs.
- B1: a 484+242-tone MRU if 80 MHz is supported.
- B2: a 996+484-tone MRU and a 996+484+242-tone MRU if 160 MHz is
      supported.
- B3: a 3×996-tone MRU if 320 MHz is supported.

Fixes: 6239da18d2f9 ("wifi: mac80211: adjust EHT capa when lowering bandwidth")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 include/linux/ieee80211-eht.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index f8e9f5d36d2a..a97b1d01f3ac 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -251,8 +251,8 @@ struct ieee80211_eht_operation_info {
 #define IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF		0x40
 #define IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK	0x07
 
-#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_80MHZ			0x08
-#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_160MHZ		0x30
+#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_80MHZ			0x10
+#define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_160MHZ		0x20
 #define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ		0x40
 #define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK			0x78
 #define IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP		0x80
-- 
2.51.0


