Return-Path: <linux-wireless+bounces-24032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B048AD679A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160F07A7458
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B5F1DE3C0;
	Thu, 12 Jun 2025 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ujmRRHy5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA609153598;
	Thu, 12 Jun 2025 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708593; cv=none; b=FR4CcYN22nT8melF6i3H9u/mDiHkqNibGakiE0HKa20mGwhyNMsp3/YkUmCHzQEDvyFIc4TeojUYDSr6tCalj0Kxg3aBgJwfw/1ePjImdTPXBpGSyzTC6MAHvY9wrPQUKP6Ur+iYHd3MD39zUcJTrsm0FpHJTQI3pqdkO3LtkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708593; c=relaxed/simple;
	bh=RPYCvGAVPmOnxF5mE8GPAXnDp5Vd7Htjbido3wbk+8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXMOmGRdkRGrdmZoiVVSZ1NMADsEZbWw4u8xd0CAKfwZV9H3yaHrRWecF4HvEICl/BsUJvPeL07y+PwWSMzAZKRvC3lrzD6V4eqT7PvFQ15uDELC8MEr7MZdqf2Gr7vegxrjo20gfSBc15Ak7kEcIitVrLX+P/nIYtKyQrAPvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ujmRRHy5; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d0f9e20c475311f0b33aeb1e7f16c2b6-20250612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BMTmXRh93Y4E4geHiDgflULudSTQePu1g+BOPOBu0To=;
	b=ujmRRHy51wCJrpGrB9IdycAJQWyv5L4I9JYy33kZlhT2xwpJ3+qkToilWDAE7bfY9d0kmUxJisbpBENLGoqEaZa9fOm6FA5nUdA5vo/KpKiy3oP7t6YdtvR/ZYUK6kFYeyHhBf+mNzu3Lln3p0HES0Hu29y7PNaJkO9eN7ftpes=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:05878140-9a9b-4669-84f1-c7f0a5ef1f58,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:09905cf,CLOUDID:6ab49958-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d0f9e20c475311f0b33aeb1e7f16c2b6-20250612
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1659988403; Thu, 12 Jun 2025 14:09:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 12 Jun 2025 14:09:34 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 12 Jun 2025 14:09:34 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH] wifi: mt76: mt7925: fix the wrong config for tx interrupt
Date: Thu, 12 Jun 2025 14:09:31 +0800
Message-ID: <20250612060931.135635-1-mingyen.hsieh@mediatek.com>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

MT_INT_TX_DONE_MCU_WM may cause tx interrupt to be mishandled
during a reset failure, leading to the reset process failing.
By using MT_INT_TX_DONE_MCU instead of MT_INT_TX_DONE_MCU_WM,
the handling of tx interrupt is improved.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 547489092c29..341987e47f67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -58,7 +58,7 @@
 
 #define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WM |	\
 					 MT_INT_TX_DONE_FWDL)
-#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU_WM |	\
+#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU |	\
 					 MT_INT_TX_DONE_BAND0 |	\
 					GENMASK(18, 4))
 
-- 
2.34.1


