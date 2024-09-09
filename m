Return-Path: <linux-wireless+bounces-12712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A297244E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 23:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30C5284C99
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397CD18A6B1;
	Mon,  9 Sep 2024 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="W8Vlm5Uw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE418A92E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916365; cv=none; b=GF1uVfZVT7F5f3UUbtOt7HM/c3kQKRhEYCtIcj3JkgolnwDcHnkfRQqn283GdPvK004SIQZM+S9lLWKWDppQWjKYgvmoMiWHP1omzUYwMeO0tcbUhvNjiIeJCIj/tYlr2o00gEzxE6j4yxmFsOf8ELseAU22akGA1inlb83roK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916365; c=relaxed/simple;
	bh=Jv4Pp2gd5XXSCNpOlXV4YGwBjjimYRFNHQFk2s1XqE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBe/xJ4uJByud/mfp6NNOb2ULGJKU7uqkKU+fzVGSjxAzSzT35jO5oSjXx2s+DpUwP49FZIpzaDXnN7UlmGkqSXqiodit6bGbKcEtqvPgGA80B7U+ISYfv2yfwAexIi5FEqgQ54qwUNdy9pkldF+7/36ZATKi2totFbTWMlYGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=W8Vlm5Uw; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DEDECAC007E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:12:41 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 70DEA13C2B0;
	Mon,  9 Sep 2024 14:12:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 70DEA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1725916361;
	bh=Jv4Pp2gd5XXSCNpOlXV4YGwBjjimYRFNHQFk2s1XqE4=;
	h=From:To:Cc:Subject:Date:From;
	b=W8Vlm5UwRc3nVZhyPRKPFVwXV1TlL037+KB67fLKQsqJlZqQWS6833id87zb5u3bd
	 JC5XXAaXGV/4nEbgg2P1X3754sqbH5d1WspP2vypEqJsl5k2+i4nM2lsik6kadajzp
	 G589+7mbEQtTxlbJBiflHOyZEJ8EgWYt284MXSjg=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] wifi: mt76: mt7996: Add eht radiotap tlv
Date: Mon,  9 Sep 2024 14:12:37 -0700
Message-ID: <20240909211238.3237111-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1725916362-zyiYSd8_EH3h
X-MDID-O:
 us5;ut7;1725916362;zyiYSd8_EH3h;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

This duplicates what the 7925 driver is doing, wireshark seems to
at least mostly decode it as expected.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index bc7111a71f98..e3ebdb1f7e9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -679,14 +679,25 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 			if (ieee80211_has_a4(fc) && is_mesh && status->amsdu)
 				*qos &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 		}
+		skb_set_mac_header(skb, (unsigned char *)hdr - skb->data);
 	} else {
 		status->flag |= RX_FLAG_8023;
 		mt7996_wed_check_ppe(dev, &dev->mt76.q_rx[q], msta, skb,
 				     *info);
 	}
 
-	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt76_connac3_mac_decode_he_radiotap(skb, rxv, mode);
+	if (rxv && !(status->flag & RX_FLAG_8023)) {
+		switch (status->encoding) {
+		case RX_ENC_EHT:
+			mt76_connac3_mac_decode_eht_radiotap(skb, rxv, mode);
+			break;
+		case RX_ENC_HE:
+			mt76_connac3_mac_decode_he_radiotap(skb, rxv, mode);
+			break;
+		default:
+			break;
+		}
+	}
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc) || hw_aggr)
 		return 0;
-- 
2.42.0


