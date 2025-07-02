Return-Path: <linux-wireless+bounces-24763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2EAF1232
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 12:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7991C26B7A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 10:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6A239086;
	Wed,  2 Jul 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cUdV5xN7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFF22AE65
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453128; cv=none; b=tkpSmTdJd5lthm6z9WWnjX8tqrmC7SGxijdmp3+CvVY49Nl+FvJ27hQ4AGYBei2HtboOlZz9akbi274iVlMbRQWYp93Uo6NW7Ce4FyfX0pSe5U3M7O2qbbx+wg2Ha2xDd/KF7CAx811v6wYb1HQMLSlJBf8HmLgF8tyn5ImMK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453128; c=relaxed/simple;
	bh=un0UbUcU6PXOddpq1Eg2MYid8ZFLDGA8mjOrZJpGGqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DncG1N2TXg6yKE7pcbCdumDuL3XqfKvxqPmHnuM8Bk01A/rj/5afGsuzRQ9YwwCV54FH+0568GmPMQ2qoXCliGv4zPIr+LLkeV4mLM0Q6R19kQcJeaq+v3PzDaiRSjc0oMgrtXSD+6tEwLsDtIaCiVdL9qTIlcqz/4YYKwF0uV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cUdV5xN7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a536cd9a573111f0b1510d84776b8c0b-20250702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=u5uiOpHyPLSsv2+8VZ4TMFdbB7Fh6NmSFxifxYc9Wc4=;
	b=cUdV5xN7ik6ZHb7ERPmxy2AQgEqvbSUi7Et9c0t1jMOtUyphGaym+j8MyInXvObHsnGFl6leqasxqeVcuQYPGYETChAdL46FSlx1dUP4KJJqmH1F/s0ipkkp6uNBNgHZ3uYNabShCow5KGDOhezXJuAgcwdWUoG8K6pBs/RxXSk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:6f045e4c-e29d-497c-9824-f58097606c2d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:6532cd73-15a7-4ae6-ad4b-94c27b45c266,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a536cd9a573111f0b1510d84776b8c0b-20250702
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 708484485; Wed, 02 Jul 2025 18:45:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 2 Jul 2025 18:45:16 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 2 Jul 2025 18:45:16 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: disallow AP interface from getting BIGTK in RX path
Date: Wed, 2 Jul 2025 18:45:16 +0800
Message-ID: <20250702104516.2738962-1-michael-cy.lee@mediatek.com>
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

The problem was that when the AP interface with BIGTK set received
beacons with MMIE from other BSSes, it tried to verify the MIC using its
BIGTK, which must fail and be notified to the upper layer by
cfg80211_rx_unprot_mlme_mgmt().

The solution is to prevent the AP interface from getting BIGTK in
the RX path, as the AP should only use the BIGTK to calculate the
beacon's MIC value.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Reviewed-by: Money Wang <money.wang@mediatek.com>
---
 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7671fd39a60e..f2d63a7cc642 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1888,6 +1888,10 @@ ieee80211_rx_get_bigtk(struct ieee80211_rx_data *rx, int idx)
 	 * index (i.e., a key that we do not have).
 	 */
 
+	/* AP interface sould not use BIGTK to decrypt */
+	if (rx->sdata->vif.type == NL80211_IFTYPE_AP)
+		return NULL;
+
 	if (idx < 0) {
 		idx = NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS;
 		idx2 = idx + 1;
-- 
2.25.1


