Return-Path: <linux-wireless+bounces-27304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F854B5721D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49F03B9B14
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D792EAB71;
	Mon, 15 Sep 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="t+7c+xG5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CCA2E9EC7
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923162; cv=none; b=jAc9bhfTgdBSRme9CjF5iZpycmeC10U1Q0PIBDt+Npgkb1gaGX02Rn9cVDkbcmX0kM3VmG8r9vfpMGg+GJTcyeZQL303dgZeV5XD0EEibXHjjcIxuXFzskNzjkGkhRA/KFbvfYQ4iphUEM28+B0Y8h9v4pSFAkkjwqwLIYSAqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923162; c=relaxed/simple;
	bh=IHoTs23upt8bdcHkfU1L2CWgbckk7z/0E/hLT6Hu6fQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwJ+rGjC6pJssokfVMx2JJCFoAacNF+FxR42zOyjziXlc54tkNW9Z9UaMRfKbA7ybbfMQgR2H+Cpm4IbMiGNfMYE3KWFTfbUV0wWf8Cm2Qp35aMsI05ZFO6x47pCfU1lQ38B5bKbCrBnykpTdL0AqW6qHmPkOhiZpHv1OBa50ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=t+7c+xG5; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2Sw9Z3pSTe0k5qacJF4IkvAqvoiMfiE8mqFW8KpyJJU=; b=t+7c+xG5XKC55mLc2HrMEE6jon
	8nXlI0a7uTTJTiy1klUtKBHmt+onjQTdS1YTgTwKa2edkCylsfue/LQxhArd+aSFEzjJPT7xggzbS
	vKUQMBA6TwWVOO9rDLyRl8Lslj4qWBsZjsN4lXjFCqMMJzSGd/Ks0T4Tgo2hNo0HxqzI=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47E-0078GN-38
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:13 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 11/15] wifi: mt76: mt7996: remove the mem_total field of STA_REC_BF command
Date: Mon, 15 Sep 2025 09:59:06 +0200
Message-ID: <20250915075910.47558-11-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915075910.47558-1-nbd@nbd.name>
References: <20250915075910.47558-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Howard Hsu <howard-yh.hsu@mediatek.com>

It is not used by the firmware.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 07a1e542571c..0347ee0c2dd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1837,19 +1837,6 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 			bf->mem_20m = bf->nrow < BF_MAT_ORDER ?
 				      matrix[bf->nrow][bf->ncol] : 0;
 	}
-
-	switch (link_sta->bandwidth) {
-	case IEEE80211_STA_RX_BW_160:
-	case IEEE80211_STA_RX_BW_80:
-		bf->mem_total = bf->mem_20m * 2;
-		break;
-	case IEEE80211_STA_RX_BW_40:
-		bf->mem_total = bf->mem_20m;
-		break;
-	case IEEE80211_STA_RX_BW_20:
-	default:
-		break;
-	}
 }
 
 static void
-- 
2.51.0


