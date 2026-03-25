Return-Path: <linux-wireless+bounces-33802-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OgSOzxgw2m1qQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33802-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:10:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E5231F806
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C15317604B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 03:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5862DCF72;
	Wed, 25 Mar 2026 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HJNNN0aB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44682E2840
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411193; cv=none; b=atTyJ3t/RVtTusCKIYJec88jKvS5UYyCvjqDJfWXdWfHXSedZGi6qILVQ7mx0+0aR647u7adzEIgeqNbr5ZSfY0zuFhZb4voGAfW7ryNjjgfyVUX9BUs5mBzozYmABnIWV8z7zWyChMh1ygw3h2/wyqfrmWEzJ+rg//3DMd8fjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411193; c=relaxed/simple;
	bh=EtzwM1L311pCH5T8orEcz4MINnaubCLwT0aZjw4vUyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dc5J7Ux7qQsPP3lYHgXgIjNVS1SU0/WeMqiqipz8Z0L9o9qEppkBErKu4zMsXtrWrcIEl3zEJYl584yZSOXwopSvb2XCLj2dHK+G9Yukb8SqjF26XnxU96sdlYMk2wW8Qh/zIHneq0wskRXaFxm8Z4UPcHm+DJ1FRPipeSVrGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HJNNN0aB; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0f9ff2bc27ff11f1a02d4725871ece0b-20260325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CAcAj41Nboaxy537cdMv9ttueCZpamwxsdWgeZCwTvU=;
	b=HJNNN0aBvLxyeBl54O0K2UKWa3NM6EDwK1xMu13beHm62tQ5u8GVqfMvzvdCC8eqZw/LrkhOnAGMeuvSHSaUFUBWpd2WimxAQGR2sQV328A2LXqq+L5lO8beSPhVlIBIhf9hsvhWZ8aHpkF9YFTEYNOW0XZ/DpfqC1IHy2/ctro=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5a2d2b6f-eeaf-4a3f-b85a-7b5f1649c153,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:293a1ad5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0f9ff2bc27ff11f1a02d4725871ece0b-20260325
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1706654448; Wed, 25 Mar 2026 11:59:45 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 25 Mar 2026 11:59:44 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 25 Mar 2026 11:59:43 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: <linux-mediatek@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	Shayne Chen <shayne.chen@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7996: disable UNI_BSS_INFO_PROTECT_INFO for mt7996
Date: Tue, 24 Mar 2026 20:59:41 -0700
Message-ID: <a1f5ad05b164c836161e9c53e32335c15a1fa2a2.1774411028.git.ryder.lee@mediatek.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33802-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid]
X-Rspamd-Queue-Id: 62E5231F806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are known firmware issues with MT7996, so it is temporarily
disabled. MT7992 and MT7990 are working normally.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 16420375112d..bdc40e94127c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1281,6 +1281,9 @@ int mt7996_mcu_set_protection(struct mt7996_phy *phy, struct mt7996_vif_link *li
 		PROT_NONGF_STA	 = BIT(7),
 	};
 
+	if (is_mt7996(&dev->mt76))
+		return 0;
+
 	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &link->mt76,
 					 MT7996_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.45.2


