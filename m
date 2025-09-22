Return-Path: <linux-wireless+bounces-27590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE259B936D8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 00:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE14D1645DA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D58286D52;
	Mon, 22 Sep 2025 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mllkJXzN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE01266EEA
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578656; cv=none; b=bUQH0CG91JSvaTWDQnhVsH34PA6w4QTYV/qCJGPj2/9qduQlTUaz/NxLYQYcPBxhilTO6fR7KkBvrqe3nGNSF4L7WuOEZ7sLO/YcDEQWPxD0mLHgEuYCh4tK0qfeANC/CpZQ+Vt0HT6EaM1HoklPw9/TwBhWxAZeEHjH9t2JMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578656; c=relaxed/simple;
	bh=XvCUfgnEknBZXmTQwyb2em7+BIp2UonWpSfniniS9uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cl2s+LypNteEqMw+hQcIfoOVx5ANhwAiX46Z8loQTDqKsdDvzPbdWsYmVRzvOaCik+HR2e6bpDNVmUo7r3NpFbUAoCVbYv/nxAnW0MfOhbkYgks3cCZM3CpqDhiREGdAKEHkS1rTrArPo2VaU5LAYHUmyuyq1VBXMWbpoOL6CXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mllkJXzN; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1095110a980011f0b33aeb1e7f16c2b6-20250923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0xkXv2rAOqeadwBfbHxi6+JkjJBy+wx/AP8Zs/wjb8c=;
	b=mllkJXzNCHvFnQXs9bIY3G1WY24buZN355wAUINrx5Ta/hv6iAWiMyrns7/FqMtw6iCDoT7Y7+t/wgQs8vv/PRocsDokI38BmRU4V3bag6BWyQoMPNzwJJIFkmoUijjjViWEm4kCt6EmHXJnQgnxhzaHQqjzol4R+m4oXyawf1E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:849c0d45-3b26-4d7f-981d-e535cc9627e2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:a63c1085-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1095110a980011f0b33aeb1e7f16c2b6-20250923
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1953757125; Tue, 23 Sep 2025 06:04:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Sep 2025 06:04:06 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 23 Sep 2025 06:04:05 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: <linux-wireless@vger.kernel.org>
CC: Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Felix Fietkau <nbd@nbd.name>, Ryder Lee
	<ryder.lee@medaitek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: cfg80211: fix width unit in cfg80211_radio_chandef_valid()
Date: Mon, 22 Sep 2025 22:04:03 +0000
Message-ID: <02e27f91195aebcc1d80351fba4a01a719bfeccf.1758577296.git.ryder.lee@medaitek.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Ryder Lee <ryder.lee@medaitek.com>

The original code used nl80211_chan_width_to_mhz(), which returns the width in MHz.
However, the expected unit is KHz.

Fixes: 510dba80ed66 ("wifi: cfg80211: add helper for checking if a chandef is valid on a radio")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index d12d49134c88..55925d6f800f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2992,7 +2992,7 @@ bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
 	u32 freq, width;
 
 	freq = ieee80211_chandef_to_khz(chandef);
-	width = cfg80211_chandef_get_width(chandef);
+	width = MHZ_TO_KHZ(cfg80211_chandef_get_width(chandef));
 	if (!ieee80211_radio_freq_range_valid(radio, freq, width))
 		return false;
 
-- 
2.45.2


