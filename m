Return-Path: <linux-wireless+bounces-24512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A631AE9464
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 04:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ACC4E1762
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 02:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB571F91C5;
	Thu, 26 Jun 2025 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QLs+eZZz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C312CDBE
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750906122; cv=none; b=i0rdL/tD0oLEXBJEocmeOV0alya5XmlObc0KA/JAYyj1u2l2pF/8V+kOimHvSL4yTnDVfWAuu2jlWl373qJ+950Usj4Vic3WtCL4IWuTyNq5R/GuWQPyrTM7CyTfZI2N+3CHbvqAtDbBCv6TBdLicEfl7Jp6erym+x80d3f+cV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750906122; c=relaxed/simple;
	bh=9dIHx34OloNH/xP1Z89QRJLAEIpIeqRs7pA4nRuDAN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F2CVZHbXyfk0ooq5lyeEO+se71NfoTXBEe6hfSng1GE40HkVmufiz7cqCedG7vv8pnGM5P3E+PSn9BpCYavbnP/13vbTrEiXz7NANhPDKP336HrJPxpXaHPpALHC+JZ0LprcytjLtVxKbZfeS/9QReeV/gNun6yudsjGxJYrJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QLs+eZZz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0c966896523811f0b910cdf5d4d8066a-20250626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=o9zZenT208Kdh9QhO8IBxP3KLL+36xJprHwoxaJOxRs=;
	b=QLs+eZZz5xQ1mWAIQ+2guEJiLu/NSdjyscqY2RKsn0aeH6CEdlxXLf8iKcaFsPHZQjEA9htvRTMiYalGQlnNT+YQzf2OhLY7l3XbG22bOigkPyVodVq29ILW1BsThEjMoEKSZhb2ZTh6dxfXKARbXeCVAuvgg0ENnLCTQpUmaqg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:fc4e34e0-9be8-44f5-bbc6-3ec9955c7236,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:9eb4ff7,CLOUDID:d7353682-cc21-4267-87cf-e75829fa6365,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c966896523811f0b910cdf5d4d8066a-20250626
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1756653006; Thu, 26 Jun 2025 10:48:33 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 26 Jun 2025 10:48:31 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 26 Jun 2025 10:48:31 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: break the outer loop if target nontransmitted BSSID profile is found in ieee802_11_find_bssid_profile()
Date: Thu, 26 Jun 2025 10:48:25 +0800
Message-ID: <20250626024825.2231721-1-michael-cy.lee@mediatek.com>
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

If the target nontransmitted BSSID profile is found, the outer for-loop
should be broken, otherwise the "profile_len" might be incorrectly
overwritten.

Fixes: 5023b14cf4df ("mac80211: support profile split between elements")
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 net/mac80211/parse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 96584b39215e..a985a439051a 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -815,6 +815,9 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 				break;
 			}
 		}
+
+		if (found)
+			break;
 	}
 
 	return found ? profile_len : 0;
-- 
2.25.1


