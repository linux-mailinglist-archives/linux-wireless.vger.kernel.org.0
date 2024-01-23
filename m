Return-Path: <linux-wireless+bounces-2362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154388386FF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 06:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23D028647F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1146AB;
	Tue, 23 Jan 2024 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KTgVAgRm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D24EB20
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988898; cv=none; b=rGOH9vm8MXqthGFBdvgywOSuGA+OiKjw3iEqP2uzMlYdWt7BO4n2Kgahom98flNt93rdWI2CWWHHlxEAANgV0UpDqvb0EjAdmYL3DdR5/+7R/eG/P5FQ6zvzYdMRH6Bm30h9Sq7ZIZr74m9XC/oBWdBrlRCWlmfhUMQfeqdHVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988898; c=relaxed/simple;
	bh=J26b4Ntt1d0Gl6BKM0xylllItSX8RHfySLX2YE4eZ2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PrnuUbeb7rLrMPzPfbvfS9t0eIrEmQc/1wao3CjLaOddIz05e6KqkY87g1YqHEReLClK6j5hlkq4PpNEkPlJl0hjv2NlDSjePbdk9zZNavDZcqot2/MEW3zFrNiDMkBMa3tDfEUoc/eo5oudYi8R6tNpey125Epxm0Xtt8RCM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KTgVAgRm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fdfd6d80b9b211eea2298b7352fd921d-20240123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bPxRxUZ+oqA+o7sYWwaUKD66vQMoVKVjNA4iAjZv5pg=;
	b=KTgVAgRmF3u7YEMbp3b1YKxcH9rKqCThWDfQCic+dJDPUKQMTe6Sduz88kXLSFHxhFbVxIamaE7YwEyXw1bVIy9C+9xEwCc6G/IloA2sGmTWju/ySgLdoi852AVXJq4jgpnrlr3Abm8ndD9xrtlMSJbL09BO7C8jJosi1OSO6yk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:5d12bdb6-bfe5-4e97-93b5-bb49ac78c022,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:94268d8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fdfd6d80b9b211eea2298b7352fd921d-20240123
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 188397378; Tue, 23 Jan 2024 13:48:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 Jan 2024 13:48:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 Jan 2024 13:48:09 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: apply duration for SW scan
Date: Tue, 23 Jan 2024 13:47:52 +0800
Message-ID: <20240123054752.22833-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This patch makes duration in scan request be applicable when using
SW scan, but only accepts durations greater than the default value for
the following reasons:
1. Most APs have a beacoon interval of 100ms.
2. Sending and receiving probe require some delay.
3. Setting channel to HW also requires some delays

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 net/mac80211/scan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 645355e5f1bc..8adcb23262f5 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -671,7 +671,10 @@ static void ieee80211_scan_state_send_probe(struct ieee80211_local *local,
 	 * After sending probe requests, wait for probe responses
 	 * on the channel.
 	 */
-	*next_delay = IEEE80211_CHANNEL_TIME;
+	*next_delay = msecs_to_jiffies(scan_req->duration) >
+		      IEEE80211_PROBE_DELAY + IEEE80211_CHANNEL_TIME ?
+		      msecs_to_jiffies(scan_req->duration) - IEEE80211_PROBE_DELAY :
+		      IEEE80211_CHANNEL_TIME;
 	local->next_scan_state = SCAN_DECISION;
 }
 
@@ -994,7 +997,10 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	 */
 	if ((chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR)) ||
 	    !scan_req->n_ssids) {
-		*next_delay = IEEE80211_PASSIVE_CHANNEL_TIME;
+		*next_delay = msecs_to_jiffies(scan_req->duration) >
+			      IEEE80211_PASSIVE_CHANNEL_TIME ?
+			      msecs_to_jiffies(scan_req->duration) :
+			      IEEE80211_PASSIVE_CHANNEL_TIME;
 		local->next_scan_state = SCAN_DECISION;
 		if (scan_req->n_ssids)
 			set_bit(SCAN_BEACON_WAIT, &local->scanning);
-- 
2.25.1


