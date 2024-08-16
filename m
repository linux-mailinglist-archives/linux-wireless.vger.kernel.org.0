Return-Path: <linux-wireless+bounces-11533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC73195462D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A275C1F2248A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B61714A9;
	Fri, 16 Aug 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="soRUbuJs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729516EBE9
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801824; cv=none; b=YNoPoj9LVjjkgfMH/CrOWQcZ+HERssQqC8vVGPShnab/bL9STjswP9qCKOsHhEltnEa8a/6Xp7sZ7NJVDVv/9BHOblGRDCbFUitzvaU18eNilGErdo7KkKsN4vqpvnaphIT0jNzPLp6T+xFmB52V9KVfW1UeshSjp21VVn5H9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801824; c=relaxed/simple;
	bh=yp1lg/vcalQcOawNbMo2mPuBfYc1esEmcl5VLGxYL/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcdToriNW3jaz49vxpSkS52kthnwWSQGqBDi3D7QD5+vO33ccLe4MhyMUjs/K20rQtFkJW466NnjdesZjXd4AI3RcpQQwS7VIQvn0YiKZD5afdEBmNU7GsWy0gixFjWXGvFpZsSw/M9q5Pr6hb+kLjkzsFQ4spvofn3HrQJBCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=soRUbuJs; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ef75670a5bb411ef8593d301e5c8a9c0-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=z12cKt2Fya2BcGcfBm4pxjf+7XYj5q5rwAR516ix9Go=;
	b=soRUbuJs/w3UYNwM3cIS1wnHiRh7V0THj3Rpsn7zGQK2PStOlXD497FKkDZ+Ybw/Srwpos9xRMhAYs/tDqvXWLHMpIdK6MXFjTouDldxEpjRi370Nf/DHV36CB4kG58E/hRBpZvyGyuuEsccqEdfJjQE3dAtBCPzFaThBFyslHs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:01be366d-1d20-41f5-aa05-6e5bba70f601,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:6160b1fe-77bb-433c-b174-ffb8012693b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ef75670a5bb411ef8593d301e5c8a9c0-20240816
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 613558364; Fri, 16 Aug 2024 17:50:14 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 17:50:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:50:15 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Rex Lu <rex.lu@mediatek.com>, "Shayne
 Chen" <shayne.chen@mediatek.com>
Subject: [PATCH 10/12] wifi: mt76: mt7996: fix handling mbss enable/disable
Date: Fri, 16 Aug 2024 17:46:33 +0800
Message-ID: <20240816094635.2391-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240816094635.2391-1-shayne.chen@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.738000-8.000000
X-TMASE-MatchedRID: NB29Ml8pA5+MLrybB70frhK6EFc0lvV0NACnndLvXwcFi3R9x/2qQp7O
	325kkkmtHa1OFK8PqLp+vz3/nHYaomSBCik5/ZoSdrnuu4cCcfFCX8V1FiRRkt9RlPzeVuQQIub
	j9bOa7MsojlDYdAoPBTLaKLaWub4PHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgWJgTEpee1jLEkPF
	OL0IWMv6tgcaa32v4+aX4c4HU22RBXNwy8dTpk73aqcyzs5P01HZhrzKUL75oWVTwFenPVPUAs2
	b6oloUkwZBgUyJVEbl6Fw8/PpTMRaVvmiAyeA2kc5MSfkiJFI5p3LlElBHTlw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.738000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A9015BE46A30762D5819E37EB2D208F55F8E2312483CD7430838C14C749845D52000:8
X-MTK: N

From: Rex Lu <rex.lu@mediatek.com>

When mbss was previously enabled, the TLV needs to be included when
disabling it again, in order to clear the firmware state.

Fixes: a7908d5b61e5 ("wifi: mt76: mt7996: fix non-main BSS no beacon issue for MBSS scenario")
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 238b1f78ff7c..e8d34bfbb41a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -822,7 +822,7 @@ mt7996_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct bss_info_uni_mbssid *mbssid;
 	struct tlv *tlv;
 
-	if (!vif->bss_conf.bssid_indicator)
+	if (!vif->bss_conf.bssid_indicator && enable)
 		return;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_11V_MBSSID, sizeof(*mbssid));
-- 
2.39.2


