Return-Path: <linux-wireless+bounces-8633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 996828FF444
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B26E1F25E5F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06371199389;
	Thu,  6 Jun 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bzky98Q+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A719923F
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697239; cv=none; b=TQotiw1GFXprKNQfBHcD4mKBO8mG/JKR6adPYPAjl7rAiMSNVOsesWfT8SMvckRGoqcuHVlwPOeS0kdnJKlycdkVT7UJqC486EU9qLaxYA4v+caXc5lL0qXLNnEXlYclPxzFgDxfbRzeKm6zgKJOvz/6qjM/EbdxpSwgUFTgWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697239; c=relaxed/simple;
	bh=Eo5hwNf1jpd2lF8Ue4dQR4kcHfkFnUxOjriSsc+hC90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSJyPusA9KYUQ3DnUQUJUkT2cO3uIkXxmk5TLr0Ui6nIXLW2DEDMAufzDHRvK5KkrG9etgUhdA4wxxJArM/k69hWqDTH9MS8r9Wggc8d5nKshsEtQO2s5wuLgJUk8MWvsLqIucWeUDOtRdg6tWzS2aumqDucOa3UnJp2uHEyKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bzky98Q+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=34pDim3q98b+di9DArDJuxpv+10vrgDHS+iLBvplmv0=; b=bzky98Q+WTq3BbrxQqrynQGjLD
	WgtBYkuIBXJIsewdrSr18yXZ8iN5bOeTEmL41aL7iJbxXzcs/NvrZZF7HEW4rmd1QnLMh7BBOtwk1
	VtZWPjcwTk5GeUAFAjIXvylWr+kN+SK5IWwrvo5K3W0hCGdqOvRRV7fnIeKBOQkcFBuk=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFHW7-008aic-0R;
	Thu, 06 Jun 2024 20:07:15 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v3 4/8] wifi: mac80211: add support for DFS with multiple radios
Date: Thu,  6 Jun 2024 20:07:09 +0200
Message-ID: <7cc3d89225f365c85b363874725cfbc77c9c1db5.1717696995.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
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
 net/mac80211/main.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 40fbf397ce74..e9c4cf611e94 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1084,6 +1084,21 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 	return 0;
 }
 
+static bool
+ieee80211_ifcomb_check_radar(const struct ieee80211_iface_combination *comb,
+			     int n_comb)
+{
+	int i;
+
+	/* DFS is not supported with multi-channel combinations yet */
+	for (i = 0; i < n_comb; i++, comb++)
+		if (comb->radar_detect_widths &&
+		    comb->num_different_channels > 1)
+			return false;
+
+	return true;
+}
+
 int ieee80211_register_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -1173,17 +1188,18 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			if (comb->num_different_channels > 1)
 				return -EINVAL;
 		}
-	} else {
-		/* DFS is not supported with multi-channel combinations yet */
-		for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
-			const struct ieee80211_iface_combination *comb;
-
-			comb = &local->hw.wiphy->iface_combinations[i];
+	} else if (hw->wiphy->n_radio) {
+		for (i = 0; i < hw->wiphy->n_radio; i++) {
+			const struct wiphy_radio *radio = &hw->wiphy->radio[i];
 
-			if (comb->radar_detect_widths &&
-			    comb->num_different_channels > 1)
+			if (!ieee80211_ifcomb_check_radar(radio->iface_combinations,
+							  radio->n_iface_combinations))
 				return -EINVAL;
 		}
+	} else {
+		if (!ieee80211_ifcomb_check_radar(hw->wiphy->iface_combinations,
+						  hw->wiphy->n_iface_combinations))
+			return -EINVAL;
 	}
 
 	/* Only HW csum features are currently compatible with mac80211 */
-- 
git-series 0.9.1

