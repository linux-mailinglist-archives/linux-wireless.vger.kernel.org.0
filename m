Return-Path: <linux-wireless+bounces-5809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54953896D67
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862491C252E3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F9142E77;
	Wed,  3 Apr 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JJCL2n/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1F140E34
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141752; cv=none; b=Nh4J3iOLErA+xfYkL+LAgcCDpASniA6YhbgdEH1+495kdU9Yf/0MvvFXUqEQLGcoy1esnRSywEK65qJ7mtp/aA9jBdlFItc58m6U1ExV3q3UNLy9/JykyFJz27/5nL6P0aqC6IuC3cGxj8pwPrNuO1/YZpITqs5+cIxule/MXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141752; c=relaxed/simple;
	bh=olitPaX7ytx77pT7Rb5XhK6+Ca4NmsrNmSKY6j56B/E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6u4UKX0IOfneQvBG/r8d/nX4q/jK+VhZ+Qaz1s//zR28Fc8o/7N4gPhnxSuWHKT6E0WusQJ7TAa/NXdupxTEbQ6Zi/B0mc3h88zzkzFp+4tdNmNnVWVQfHoJX/FDAOnjqBhIB8GKUvN7qI/T3o3WnmdpfvpFVrGGRItKjVWre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JJCL2n/v; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=z5i8dfIc6UFoXkSbX/8ZtOXqwWbj8eXU/Tal851P0Y4=; b=JJCL2n/vkDYXkE7C+8WgnTBsm4
	R4FyxU1V+boh1QXlU4PX83Q5BNiRE/Ov73HATp3V0QUEH7AzAMM8Pm+LL4qfhoMmol2xcH8kbbSCk
	izIL9s7zelrRej/HvAMzNPc9s/VV/MQU2mBPUHkZqYa4fedWGuqV44sf8W/LZFVR63LU=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt3-00CgfA-LK
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:33 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 06/13] wifi: mt76: mt7915: fix HE PHY capabilities IE for station mode
Date: Wed,  3 Apr 2024 12:30:25 +0200
Message-ID: <20240403103032.54823-6-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Set correct beamformer capabilities for station vif in HE PHY
capabilities IE.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index cea2f6d9050a..d9e391fbb4bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -934,11 +934,10 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 	/* the maximum cap is 4 x 3, (Nr, Nc) = (3, 2) */
 	elem->phy_cap_info[7] |= min_t(int, sts - 1, 2) << 3;
 
-	if (vif != NL80211_IFTYPE_AP)
+	if (vif != NL80211_IFTYPE_AP && vif != NL80211_IFTYPE_STATION)
 		return;
 
 	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
-	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 		       sts - 1);
@@ -947,6 +946,11 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 				sts_160 - 1);
 	elem->phy_cap_info[5] |= c;
 
+	if (vif != NL80211_IFTYPE_AP)
+		return;
+
+	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+
 	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
 	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
 	elem->phy_cap_info[6] |= c;
-- 
2.43.0


