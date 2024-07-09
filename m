Return-Path: <linux-wireless+bounces-10110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C559892B246
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1A4282D71
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD5152E0D;
	Tue,  9 Jul 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="qQOOs7Df"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DA15445E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514329; cv=none; b=ucWe9nytUOdqJSM0VUwlYcNaQ91HdKilOWGsIH3qGp5FfsQ0TH/p+MqtxGWAoInODWeve/gd1BENg3rEwNjhhHbg5KZs8m/9fFxNsllQ1q4DRMdFfOt/kuDV0GkPeRrtCVSBedQDK3d/OQo4LmTs5M1IxLnNsnJ9wFOmKlNNpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514329; c=relaxed/simple;
	bh=R5AeBIfYIcz+l5FSqDqfI9uMGsZlLa3sOz0McrICTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9SoVMRb7uw2ApoOp4MNYdtZxJbK7G3Jw9UhgLqJz+ulWjbjmpn6myIFXbN98ni485hqr9rkfQwSYwPJvtFrFxIvTo4fd9o767Rc4DIyuEuOvEytK4hO8wZP7XywvzS6nK+4Ucybz0SQOi/ge7yI3+Tetu0+sHR3Zy/MZQkQgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=qQOOs7Df; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jP2Eybihza/RBgEQCv9/PsS0Cokn008GYzz9X6AIvjI=; b=qQOOs7DfwkKFcD2ZIN8ILaLBqh
	IV4y0f5jKRtf+kLym644jbI68d+B2wW5AM5dVvPVlCcR+D9ww8BcY/NEBFZ1A/JN4zLBxbdOReUcv
	wwErpmJzGkk5NoPpPVkN4mPjSdEC6Au32wr7byX22wTyeWGh1ZDno7iIZtYgVEYZNMkc=;
Received: from p54ae937c.dip0.t-ipconnect.de ([84.174.147.124] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sR6Mz-004Ln4-04;
	Tue, 09 Jul 2024 10:38:41 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v5 05/10] wifi: mac80211: add support for DFS with multiple radios
Date: Tue,  9 Jul 2024 10:38:33 +0200
Message-ID: <4d27a4adca99fa832af1f7cda4f2e71016bd9fda.1720514221.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.8f108602e7f90e91332f131cc9fa115a669a2bf4.1720514221.git-series.nbd@nbd.name>
References: <cover.8f108602e7f90e91332f131cc9fa115a669a2bf4.1720514221.git-series.nbd@nbd.name>
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

