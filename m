Return-Path: <linux-wireless+bounces-9828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87D923C84
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEF31F22181
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F125D15B543;
	Tue,  2 Jul 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="q7wo4tEs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185A15B104
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920171; cv=none; b=Uob/XDdq0rHNOzkjzBspaX+Nvh9rAl7bLvssgn+NKHwEej5nWbQubNBWcXGBonDn0Eg7wMA5zAAoC8NuuPYrMqhb2fNntK/XBs8nDOvV11js0wmw+Z+M5rrYO4KhsQw6YCVuE0Q/xNjhKQkYAlpAN6K0Fq21mJf2Mtq5pyto4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920171; c=relaxed/simple;
	bh=R5AeBIfYIcz+l5FSqDqfI9uMGsZlLa3sOz0McrICTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTEmVoOMYebuenHMnqPjc91SUgjQLXn4C62+BthLTa9zqcLAfsR7o0rB+8olR3IfkCqOMbAHhSGGAIlNAtSMJr18oT0aWNM6+tOZLyHaHaypX5zAN2B0BMHUbGrOdzxUp65Eb2O8xIaFXZWu+DzC/U6uSY+KpGiawKHBRpsxXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=q7wo4tEs; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jP2Eybihza/RBgEQCv9/PsS0Cokn008GYzz9X6AIvjI=; b=q7wo4tEshVgj7DESAaO0SDeL8w
	DzH25pEkG7SM9AD6NCXfBxZ2LJN5nA0ry0q1DUbWXgBj1Pih0GCeYw0A5Wig6jWUQqxO38Hkijkd6
	c1t41z7q8lTjeKpYVw1F2aAnwbGfaUmLdhJDX6xBtpf7MmoLNrbEXPOXV1hhcnVaF684=;
Received: from p54ae9766.dip0.t-ipconnect.de ([84.174.151.102] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sObnr-001lDm-2n;
	Tue, 02 Jul 2024 13:36:07 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v4 05/10] wifi: mac80211: add support for DFS with multiple radios
Date: Tue,  2 Jul 2024 13:36:00 +0200
Message-ID: <dbef62d963b4cd28246fccefdccadbfb5d14bcd5.1719919832.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.39da4d3b01ce5545ac85da8cab3179f7c7a351a8.1719919832.git-series.nbd@nbd.name>
References: <cover.39da4d3b01ce5545ac85da8cab3179f7c7a351a8.1719919832.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DFS can be supported with multi-channel combinations, as long as each DFS
capable radio only supports one channel.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/main.c | 50 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 7578ea56c12f..4acfb17cf626 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1091,6 +1091,27 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 	return 0;
 }
 
+static bool
+ieee80211_ifcomb_check(const struct ieee80211_iface_combination *c, int n_comb)
+{
+	int i, j;
+
+	for (i = 0; i < n_comb; i++, c++) {
+		/* DFS is not supported with multi-channel combinations yet */
+		if (c->radar_detect_widths &&
+		    c->num_different_channels > 1)
+			return false;
+
+		/* mac80211 doesn't support more than one IBSS interface */
+		for (j = 0; j < c->n_limits; j++)
+			if ((c->limits[j].types & BIT(NL80211_IFTYPE_ADHOC)) &&
+			    c->limits[j].max > 1)
+				return false;
+	}
+
+	return true;
+}
+
 int ieee80211_register_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -1177,17 +1198,20 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			if (comb->num_different_channels > 1)
 				return -EINVAL;
 		}
-	} else {
-		/* DFS is not supported with multi-channel combinations yet */
-		for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
-			const struct ieee80211_iface_combination *comb;
+	}
 
-			comb = &local->hw.wiphy->iface_combinations[i];
+	if (hw->wiphy->n_radio) {
+		for (i = 0; i < hw->wiphy->n_radio; i++) {
+			const struct wiphy_radio *radio = &hw->wiphy->radio[i];
 
-			if (comb->radar_detect_widths &&
-			    comb->num_different_channels > 1)
+			if (!ieee80211_ifcomb_check(radio->iface_combinations,
+						    radio->n_iface_combinations))
 				return -EINVAL;
 		}
+	} else {
+		if (!ieee80211_ifcomb_check(hw->wiphy->iface_combinations,
+					    hw->wiphy->n_iface_combinations))
+			return -EINVAL;
 	}
 
 	/* Only HW csum features are currently compatible with mac80211 */
@@ -1317,18 +1341,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_MONITOR);
 	hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_MONITOR);
 
-	/* mac80211 doesn't support more than one IBSS interface right now */
-	for (i = 0; i < hw->wiphy->n_iface_combinations; i++) {
-		const struct ieee80211_iface_combination *c;
-		int j;
-
-		c = &hw->wiphy->iface_combinations[i];
-
-		for (j = 0; j < c->n_limits; j++)
-			if ((c->limits[j].types & BIT(NL80211_IFTYPE_ADHOC)) &&
-			    c->limits[j].max > 1)
-				return -EINVAL;
-	}
 
 	local->int_scan_req = kzalloc(sizeof(*local->int_scan_req) +
 				      sizeof(void *) * channels, GFP_KERNEL);
-- 
git-series 0.9.1

