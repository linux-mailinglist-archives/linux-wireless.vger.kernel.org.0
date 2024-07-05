Return-Path: <linux-wireless+bounces-10009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDC69282FD
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 09:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A788628816D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DCE27452;
	Fri,  5 Jul 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NjrVb+OE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD714388D
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165420; cv=none; b=Pj0d3m/EUUVY9+W93l0NJTMK/dv269vG9J6TDiEY1wGozFnx95lB5SZ3iR/K7janjXiu73jNEvXGNqnk3XwMeQVTrQOUkQdcAOAgYalZKsToM7REpa7mmRLG5MQkR45JGAJ2vO2J7Ck33w26saYySapMZyJ40JXFPfcCvHY8NgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165420; c=relaxed/simple;
	bh=dmkieRRz7vA/q/zQt06waNN4w8QgqrrWW9EGRCxUGuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LO696XOzp7U4cgxCagsghvYXuCVF3k9Vz0NeCp2UBcEjATUIyzkbs/sq2iPuMF9ypzaLlG3h567vvGfPOASEwKEwyciINIjqK2fp++KoQ1JxTuMmDcbXqg1KyChtKt1PD7isCTslYU5Wp0r9bkqdl8UBdHwnOiAX/6MyJMXNrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NjrVb+OE; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 481b42963aa211ef8b8f29950b90a568-20240705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kYFcNWmfgI7sdVFz1bKkFAqD23lCibB0iUvKYSeV6Qc=;
	b=NjrVb+OEhJ0sacYPr60I/zIS7a6TStsItqOY+MfvqZJiSoVoSsBS78inufSK9Fn+8s9ATvYzFYNkReCvwylDm19+/eSFU7ellIlQJe8eN33q3YhDUIXf9cwkGyi8MTrhM0chv5pMBXX1LQKbMbgklrcFq3KUoCgqHZg+n/laJy4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:297c3fee-b77b-4c16-ae6a-009ba5b8aab0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:e7eefcd4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 481b42963aa211ef8b8f29950b90a568-20240705
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1467439013; Fri, 05 Jul 2024 15:43:34 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jul 2024 15:43:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jul 2024 15:43:31 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: cancel color change finalize work when link is stopped
Date: Fri, 5 Jul 2024 15:43:26 +0800
Message-ID: <20240705074326.11172-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.518900-8.000000
X-TMASE-MatchedRID: 0ym1mr0sZg+HTNZBcJlnyGBLcedPqO9/GSqdEmeD/nVh2fnHe1cil6cw
	fOzvS1WBIF2TWUCE/QsLcfJ0zamKdCJMyaD9gw+XngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
	Wy9W70AHCttcwYNipX6Lm79W+wVoditB5tUiQftltn0yqSy+1JPdjM3RPIeJUBgAgNR51n4VXbT
	ZTl9nm/U81hg7Kr3qpF3LZQUKUPII7urUQd9+Nu50x7RQB4+7LdmtRsRmKkASJZPT2ZDPuzPD2Q
	fzMDLjho65UufHcDvg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.518900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C03CD16EDCC8427BE143E7E0FDB0BB1CFD1C514B8533379E3A6C1C71A252461F2000:8
X-MTK: N

The color change finalize work might be called after the link is
stopped, which might lead to a kernel crash.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 net/mac80211/link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 2e6e92defbca..1a211b8d4057 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -71,6 +71,8 @@ void ieee80211_link_stop(struct ieee80211_link_data *link)
 		ieee80211_mgd_stop_link(link);
 
 	cancel_delayed_work_sync(&link->color_collision_detect_work);
+	wiphy_work_cancel(link->sdata->local->hw.wiphy,
+			  &link->color_change_finalize_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->csa.finalize_work);
 	ieee80211_link_release_channel(link);
-- 
2.25.1


