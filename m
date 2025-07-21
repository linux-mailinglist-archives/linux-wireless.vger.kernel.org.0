Return-Path: <linux-wireless+bounces-25713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225BB0BC81
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6643AB17B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF2B26E700;
	Mon, 21 Jul 2025 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B2ZZvsF4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D42AD04
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079401; cv=none; b=lo/VWOLVP9VJq9wmKskcHGsh9BtmCosDdCm/Slv8xHXtRwFIRSDYiKQOeJH3XaoAnu4jybFFvKw0I/UmbRNWsz/VT5IYOfBSGsnYQM5HORYalfRegb6Ed+jqNh4TaQrj+3Vc/QBsNDP/c3FHzirKh5oPz7rGvfZhQ7BPY9sPfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079401; c=relaxed/simple;
	bh=SRwR9OMjhQkfEUfExDSBzoq5qxpvRQNusnayBTYx1dQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SXn3EFkjuwdfZgkwm3y9iNA+NLsBRTStTSrJZUGBYpBXzAnnTwBDKOpq8yl4jns9GKFu6gDTrpO4s8LdMmfxHuDbzl2eVzdG6FyG5skudaUlmX1weeiGbJ5FSZztA+YhcCvNvCx8Jjs9dHV1deBOTNbjunTCjBZnZUsJIGx5bHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B2ZZvsF4; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 18a36b6665fc11f08b7dc59d57013e23-20250721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ejOCHf77d+DjOE4ApvpfLpumIkFayGw7G+IOfOQkomY=;
	b=B2ZZvsF43eCnqOuC/a4H4P/5YClJgkNzTihDqORJU239GNta1fEDur2tv4+CXt2RsftKTG1kgMEyJ8/XXG+b8/z5MZ00O6+xIAnAHU14JX/SPsNT4erT5qvkb2aoaCy/LavGUTeOzJ6KN38lIW9zK+yZd/A3AqwYxuHhvroj+AM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:f0683237-628f-4ab1-887a-f54f06a1725e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:c7d5ff0e-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 18a36b6665fc11f08b7dc59d57013e23-20250721
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1232205285; Mon, 21 Jul 2025 14:29:46 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 21 Jul 2025 14:29:43 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 21 Jul 2025 14:29:43 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau
	<nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH wireless-next v2] wifi: mac80211: determine missing link_id in ieee80211_rx_for_interface() based on frequency
Date: Mon, 21 Jul 2025 14:29:29 +0800
Message-ID: <20250721062929.1662700-1-michael-cy.lee@mediatek.com>
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

For broadcast frames, every interface might have to process it and
therefore the link_id cannot be determined in the driver.

In mac80211, when the frame is about to be forwarded to each interface,
we can use the member "freq" in struct ieee80211_rx_status to determine
the "link_id" for each interface.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Reviewed-by: Money Wang <money.wang@mediatek.com>
---
v2:
  - use frequency instead of band
---
 net/mac80211/rx.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index b414c9e6e61b..2ac8ccb838ff 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5106,8 +5106,29 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
 		sta = sta_info_get_bss(rx->sdata, hdr->addr2);
-		if (status->link_valid)
+		if (status->link_valid) {
 			link_id = status->link_id;
+		} else if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
+			   status->freq) {
+			struct ieee80211_link_data *link;
+			struct ieee80211_chanctx_conf *conf;
+			int i;
+
+			for_each_valid_link(&rx->sdata->wdev, i) {
+				link = rcu_dereference(rx->sdata->link[i]);
+				if (!link || !link->conf)
+					continue;
+
+				conf = rcu_dereference(link->conf->chanctx_conf);
+				if (!conf || !conf->def.chan)
+					continue;
+
+				if (status->freq == conf->def.chan->center_freq) {
+					link_id = i;
+					break;
+				}
+			}
+		}
 	}
 
 	if (!ieee80211_rx_data_set_sta(rx, sta, link_id))
-- 
2.25.1


