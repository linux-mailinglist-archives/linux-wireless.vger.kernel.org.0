Return-Path: <linux-wireless+bounces-10804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA336944167
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 04:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814F1B23C59
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5C131BDD;
	Thu,  1 Aug 2024 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FDyUwx8K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E913210A
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480230; cv=none; b=AydtrakCkAaPUvuQ7HEqx0ackaQ137GJxwNDpKMK5Za107mBqfsNyEwMhPMDe7rD+rj5H8R45JD/CqpcgTePtebU16e/M8+KACsfHyK79RzGMegdO1lDkzLr9fBrSJBVou9+nPPMWxMhYzH1PLL1yEio6PsThnRfmN+bL/cO9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480230; c=relaxed/simple;
	bh=Q+JOCpa+rZIih/jbx1Dw3gIWThrdHwAJnf3dFFPDthQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C7yNdr04s2EIphqNrObHgPMNzzOP6czKrIm5SC8jr7JkhL+HQdJms95BmpkStP9hi+ENAluVOZeVtPnAKfsTITYgemYHTGLJjFxr8BIWcqb2eGKSzIqSlqIX2eaod2WI6U6/Ghnx1tREcmPumcjPQ2J+zpCjOmae3ZfQhNoeqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FDyUwx8K; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dbf0811c4faf11ef9a4e6796c666300c-20240801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZlbCm7uef4/UrVlLEM/AL2L33IhcxVN5qA+lZPThapo=;
	b=FDyUwx8Ke0tE2jDHLl/ri/SQqX5YDRWegyK0j1aQybahdXAVSlsV1HV6VcqpMpbAdKs8uWAHfYr5R1jg0eo9H8faoWC2H31xw6zmrw/uRa27a6wICGKV3Qwgx9NwqgdhQ/OhpQuLfM8VPkUuzxpTeiMA7ie0rhA96ydt2VTlvjQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:90587eaa-1540-4f24-8043-239bdd91d6a6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:fb171f0e-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dbf0811c4faf11ef9a4e6796c666300c-20240801
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1579982689; Thu, 01 Aug 2024 10:43:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Aug 2024 10:43:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Aug 2024 10:43:37 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.
Date: Thu, 1 Aug 2024 10:43:35 +0800
Message-ID: <20240801024335.12981-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.054900-8.000000
X-TMASE-MatchedRID: Pjd+1EAfy9OCa0Vj3N+Gfh3EEAbn+GRbsf4f4CxxueTKP6Yywb5aNpta
	BHqjRFBGd1ipXxYWqcLx1S0rgG1nwJCoy9iDotiw1yMJs9mBCcUF15s6prCIu+LsQIDmr3S5j43
	o0FlG3q3i8zVgXoAltsIJ+4gwXrEtwrbXMGDYqV9/FUQjcNJIgx+5JIYu1yGn02DURdY8xg8mvg
	12NZLwyw/wmuAAOEmUVh2w4hUGtnIfkChiPoQbEkaBbOhsUDoXpx3ZVH0eE9I1EPsh9ihYYHZrU
	bEZipAEiWT09mQz7szw9kH8zAy44SIduk5Jkjd3wL6SxPpr1/I=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.054900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3ABD420CA82E1364BBC214BA4E1A5C17B1E218DA297A1687CF250AFCA6B384C12000:8

From: Michael Lo <michael.lo@mediatek.com>

To avoid incorrect cipher after disconnection, we should
do the key deletion process in this case.

Fixes: e6db67fa871d ("wifi: mt76: ignore key disable commands")
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2e6268cb06c0..4f4577b7e544 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -537,7 +537,13 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	} else {
 		if (idx == *wcid_keyidx)
 			*wcid_keyidx = -1;
-		goto out;
+
+		/* For security issue we don't trigger the key deletion when
+		 * reassociating. But we should trigger the deletion process
+		 * to avoid using incorrect cipher after disconnection,
+		 */
+		if (vif->cfg.assoc)
+			goto out;
 	}
 
 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
-- 
2.18.0


