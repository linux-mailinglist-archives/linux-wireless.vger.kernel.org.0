Return-Path: <linux-wireless+bounces-13810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C49969CD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 14:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2AF28485B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0863192B86;
	Wed,  9 Oct 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nb6Ss+xw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842BA1922DE
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476318; cv=none; b=csoWzCUxSZM7WqCN6GKf4+X3arVBSEs6vMHV/GaZxyqn5uMeBuhHWcpQuhAH0Y9Q5Gp9Lbwvl2JPICiP0EjgxBVWezgVOI40t1t9rCX+Sb5L0IJxm9ZmTj5Qx9C0MLK4HgWyZjRaZeUignmfRjNahJ4L7QKd6soVWeVxnpwmBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476318; c=relaxed/simple;
	bh=nLFkV+VU4fDUlVJ+3PL3H7j50tasXNAd+fBmdy37D04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qNT0y4yfjaXU8nD8vHT+AnlO7E6OmfIFYcKjICVQHkduC3m7/QNA0ZzAJNEPDY1LhgcBtc8wIJ5hSgUeMPvJUD7qLbZi6hAu0Oc3qM8VKrhWOfVMB5OTz+slU8DUkox579dp52HUUZrnqwcDZYXrY8W5zIGAaHcHbyj3NPDTl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nb6Ss+xw; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 96a4252c863811ef8b96093e013ec31c-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NQTKdM4vZyZcthviWc61hdQAhVA9NguzLocJ/FEkpcI=;
	b=nb6Ss+xwcHjwytPEwmPBRpmsE4zAMtLSaQO0iyO7YZH5IZwULx6FjDc9K+Br+UzeRclb8ZPaY/S43zV0y+IAePd2QmVX02mj+ILVoIIF4FmLWR3xzxrK10CiH+GaBV/HiPA6RHHvE0g/cF2AKxg+u4XU2XjqiDEHzTBrILzN3P8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ebab5cd1-78e7-42bf-9f8a-b2a66c3da1c8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:99eefe64-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 96a4252c863811ef8b96093e013ec31c-20241009
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1069558276; Wed, 09 Oct 2024 20:18:27 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 20:18:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 20:18:24 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: refactor BW limitation check for CSA parsing
Date: Wed, 9 Oct 2024 20:18:12 +0800
Message-ID: <20241009121812.2419-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.819000-8.000000
X-TMASE-MatchedRID: oFaSmDF7GFm1Hdke1yr598u00lnG8+PWLJXjpJzQSNN794qAHfSq0o5J
	LmS6k5zEhuKFbyQqx0iUTQ2JYQzY21Vju37PDEAuRsqQuQlRTh/DHSNFHFxB82I4wQ1Yq/d0KLW
	rCrDVHUni8zVgXoAltsIJ+4gwXrEtwrbXMGDYqV8HTT+SR4FPAPOmsX18iyZqunJ293L/ptLw0l
	qvYKUL4cw9+0ZIYtPR7XInbTZpCJ+scJGZeOwhv3UJZ1ah02UmpryvLF/ssNilMM+FiTXvu3ZrU
	bEZipAEiWT09mQz7szw9kH8zAy44aOuVLnx3A74
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.819000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A1A985D773F6CBC2510A9CEADC8631F410762FC13E17CD4588541A99D275A3052000:8
X-MTK: N

Refactor the BW limitation check to a more general format when
parsing CSA. Also, the original BW check did not account for BW
less than 160 MHz.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 net/mac80211/spectmgmt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 073ff9e0f397..c6015cd00372 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -377,13 +377,8 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 		/* capture the AP chandef before (potential) downgrading */
 		csa_ie->chanreq.ap = new_chandef;
 
-		if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320 &&
-		    new_chandef.width == NL80211_CHAN_WIDTH_320)
-			ieee80211_chandef_downgrade(&new_chandef, NULL);
-
-		if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_160 &&
-		    (new_chandef.width == NL80211_CHAN_WIDTH_80P80 ||
-		     new_chandef.width == NL80211_CHAN_WIDTH_160))
+		while (conn->bw_limit <
+			       ieee80211_min_bw_limit_from_chandef(&new_chandef))
 			ieee80211_chandef_downgrade(&new_chandef, NULL);
 
 		if (!cfg80211_chandef_compatible(&new_chandef,
-- 
2.25.1


