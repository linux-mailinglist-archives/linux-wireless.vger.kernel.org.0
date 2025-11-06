Return-Path: <linux-wireless+bounces-28664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F148C39CB9
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 10:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5F6188F4E5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54830B51A;
	Thu,  6 Nov 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MGpMpJEx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C923EAAE
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420924; cv=none; b=EBFHyHsak6vI9dtOKLjYxQ5GpOOD8iDBuRP9XXdyWQvtvxpFSZmOW1LKX+kQSHV7swGJgmnIXv5w+BUm5z9lf1FUW7q2HsLzlcLnmLOvB8cSuMEJKx7oYYFMRHD4qaUH2avvcLFfS97nLK8Cx/4Q7TNy4fgCVbeyq5SLfak97GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420924; c=relaxed/simple;
	bh=Gu2qdBAwIdXUoB7B+dxAS4jHDJ+fUuMwLIEjKuYP3Mw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gl1jaGQyt85B+6jjPDGdY/sSuCz+Zu/ox9xu2/f0jWhvltzuT8028SjcvLrW608UkEAi26omSPEx+SdIWlXuB4X5A4sm1Hbn3VGjTZ+BB29h0R1BFUoqgTQrwrOAmRaC5RV17JnhsAlGV5T/M4ruBVUbSEUF/GTCS2ceFZtOkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MGpMpJEx; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 08e691bcbaf211f0b33aeb1e7f16c2b6-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NMx8D6zSS3pb0cJpJ/BcVu1SlX0wjR/kFyRpaLj1UU4=;
	b=MGpMpJExAz9uNfZuK8UFgJqFSRhZz/a0wT9yHHvRLM7BuZMP2W7hCZ01yjBBjywUDHs7HSxBbkgmSZwcfWWSiG/Lv28eHUFcZh7bEfXyTPJVSSuT1thJmdevDfhxdybs8tbImEDvvKnlFmtsLy2lVnwj2w5a9sDGlDoQFpBwsx4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7b800e5c-3797-4f67-9339-2aceb205e080,IP:0,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:a9d874c,CLOUDID:50f3fc18-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:2,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 08e691bcbaf211f0b33aeb1e7f16c2b6-20251106
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1647701914; Thu, 06 Nov 2025 17:21:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 17:21:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 17:21:52 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: ensure the 6GHz A-MPDU density cap from the hardware.
Date: Thu, 6 Nov 2025 17:21:51 +0800
Message-ID: <20251106092151.1061648-1-mingyen.hsieh@mediatek.com>
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

From: Michael Lo <michael.lo@mediatek.com>

Set the 6GHz HE A-MPDU density from the hardware capability instead of a
hardcoded value, ensuring accurate capability reporting.

Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 0e5a72638746..078c65859339 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -139,10 +139,14 @@ mt7925_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 	}
 
 	if (band == NL80211_BAND_6GHZ) {
+		struct ieee80211_supported_band *sband =
+			&phy->mt76->sband_5g.sband;
+		struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
+
 		u16 cap = IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
 			  IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
 
-		cap |= u16_encode_bits(IEEE80211_HT_MPDU_DENSITY_0_5,
+		cap |= u16_encode_bits(ht_cap->ampdu_density,
 				       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
 		       u16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
 				       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
-- 
2.34.1


