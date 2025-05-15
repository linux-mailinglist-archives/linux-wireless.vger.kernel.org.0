Return-Path: <linux-wireless+bounces-22968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C1FAB7C51
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FA71B65C57
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39E2951D8;
	Thu, 15 May 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cMBmSipQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36263286423
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279970; cv=none; b=a4ql28xKX4MP9Fs1cxJgBVgzLj11f7OSyVgwcKpF3AVTK+dS9srOw2wHMkx0sFxchKBpVPWovoTcCrgTZd7NquJvrFTh/LIYxVst6zlWB8PMNSFPbA5bF5RDeC7KscQ9mxtTMCaA4QOPyvh43mKiPbZlYb4ABpT7LdBtG5vTpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279970; c=relaxed/simple;
	bh=gyYOvFBuigjM8k+n8Qy1rBUZ3DKGy9gn9waz+cVr4Zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCrEgQlo7oEHXqncGtilOXCxg+3A03NWy5NcbSVcOK6puHui8yt096QqyUTKHdDWkuinGUY0gea6riUAQFGQvtXaJXZrzp3pq9DKoF3iqI8w2rHWwdaX+kNISEmudNx57+IvgI0dR3vqGGATUuu9pykCYJjKsNl2U+iObTAdTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cMBmSipQ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 41b37a30313d11f082f7f7ac98dee637-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CDDbFIP/VXu5/F06hRjfpTW4c4MFssvWZKlPaaKr6rA=;
	b=cMBmSipQ5PbUb3PI7JvUt1sViqlpSA/CuPs0t+FB0y35gYNsV6yv5ePM3gj0ndMegIkFWmdFoAagQ2HVHSJah6Wjwjl1I5noK9DnOU/nb2+1ir0T65NFwTDmuXgtU61WeeADu6vVbnzPlpynXWy4H3T9+6KASRfU/WtSOVBkbyI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6644e47c-cfd8-4b2d-b712-a73d15da517c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:0facbe97-7410-4084-8094-24619d975b02,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41b37a30313d11f082f7f7ac98dee637-20250515
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 519650693; Thu, 15 May 2025 11:32:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 11:32:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 11:32:39 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next 6/9] wifi: mt76: mt7996: change max beacon size
Date: Thu, 15 May 2025 11:29:49 +0800
Message-ID: <20250515032952.1653494-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515032952.1653494-1-shayne.chen@mediatek.com>
References: <20250515032952.1653494-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

According to hardware capability, the maximum beacon size is 2048 bytes
minus the size of TLV headers.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index fd660e913b82..130ea95626d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -832,13 +832,13 @@ enum {
 					 sizeof(struct sta_rec_eht_mld) +	\
 					 sizeof(struct tlv))
 
-#define MT7996_MAX_BEACON_SIZE		1338
 #define MT7996_BEACON_UPDATE_SIZE	(sizeof(struct bss_req_hdr) +		\
 					 sizeof(struct bss_bcn_content_tlv) +	\
 					 4 + MT_TXD_SIZE +			\
 					 sizeof(struct bss_bcn_cntdwn_tlv) +	\
 					 sizeof(struct bss_bcn_mbss_tlv))
-#define MT7996_MAX_BSS_OFFLOAD_SIZE	(MT7996_MAX_BEACON_SIZE +		\
+#define MT7996_MAX_BSS_OFFLOAD_SIZE	2048
+#define MT7996_MAX_BEACON_SIZE		(MT7996_MAX_BSS_OFFLOAD_SIZE - \
 					 MT7996_BEACON_UPDATE_SIZE)
 
 enum {
-- 
2.39.2


