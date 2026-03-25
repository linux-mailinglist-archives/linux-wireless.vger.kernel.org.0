Return-Path: <linux-wireless+bounces-33858-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NB2BvgZxGkRwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33858-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 18:23:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30599329BB3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E29630917CE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FFC3C73EA;
	Wed, 25 Mar 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hKSqS6IZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4D3CEB98
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459056; cv=none; b=DI2Vr6R7VqijxpU8hp+uBNeTkJ19S5P5j9vVTTYp78QPz6uELsVL/HWtdlbzPBVOo4FuJ4WjBEwjq0/jn4kRybKXTyMoraHTkN4OVGny2THTJtoAwU2OXRccrJzYwmFcfiSjC8UPWJ+khTbxmoCnxtXqOZhEupsZNuIw1FHB92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459056; c=relaxed/simple;
	bh=HvS9eqj6f8rorxXglINXu91gtimVkaBxN0NxixlNIF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0tdyVEc5flxBWSrEzbJ9qLot43N5x9vAGkuoJAjB9k6WraBWasnGz30CqlNxVzmnoRb+N5euFFcJ2oi6/DNty56MO/YZRKgwVwV2tzpyGhb4UBnLSttJctSIrgx2+1THQbxafYjMhwqVHupYajykc9YVrrKoWqCNz7+TUTazfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hKSqS6IZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7fef6d62286e11f1a39cd589f645bc18-20260326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1NDzJA/0MjyusnuWKkzTQb8f5VjxX7ByPwK0ik1Pxfk=;
	b=hKSqS6IZcSKZdrhW9adfyWPBGiOC2WIdBgSclQSA5SV/HvOXiACvQvh6R7FHv9YP8IUaWMytu5VpilEBLrpIkb/0XwPxGnX8NABdp5B/v3AHFx/rv7LOcIgc4DJn+/W1cKPSv/u9/5zWqZZYdShoOR/K9Wbxk84wDOqG2+SjLkw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9f980465-293d-446a-a018-f863ac83daee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d5bc20d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7fef6d62286e11f1a39cd589f645bc18-20260326
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1294698684; Thu, 26 Mar 2026 01:17:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 26 Mar 2026 01:17:26 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 26 Mar 2026 01:17:26 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: <linux-mediatek@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	Shayne Chen <shayne.chen@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7996: disable UNI_BSS_INFO_PROTECT_INFO for mt7996
Date: Wed, 25 Mar 2026 10:17:23 -0700
Message-ID: <6427326eb4e8f375c63379f7a0df7e2ae9d120a4.1774458901.git.ryder.lee@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33858-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30599329BB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current MT7996 firmware causes TX failure and need further
investigation, so it is temporarily disabled.

MT7992 and MT7990 are working normally.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - add a comment to describe why this check is required.
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 16420375112d..ae068392b9dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1281,6 +1281,10 @@ int mt7996_mcu_set_protection(struct mt7996_phy *phy, struct mt7996_vif_link *li
 		PROT_NONGF_STA	 = BIT(7),
 	};
 
+	/* The current firmware causes TX failure. Need further investigation */
+	if (is_mt7996(&dev->mt76))
+		return 0;
+
 	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &link->mt76,
 					 MT7996_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.45.2


