Return-Path: <linux-wireless+bounces-9292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6D91027E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AB41C2149A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA11AB8F3;
	Thu, 20 Jun 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Q3hN52i8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF41AB8EE
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882705; cv=none; b=jtqflbX/DPSrQ5aTnJC8Y6/gAMbYeCijtZ7PTf/T9xHsGRQB121zL+AAHBxB8Rn0acuBszbPuhfHPly6GOOybqDykdL+QO5MXqQ6VaiD3IaAv+CQrErq1n18vu0AgbEWoqE+XjZ9B90VRS1Hzl4BnYCO6zxD6WT+RbhAt2rZeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882705; c=relaxed/simple;
	bh=Eo5hwNf1jpd2lF8Ue4dQR4kcHfkFnUxOjriSsc+hC90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF1Mm3ndD3pHHukXedDOrahVy/DHDRzECmzi7y6umnfWtZsZwpgCOHjPfey7P2fg/l9oEoEU9Qeba+OERrirAAo6emJmTUHE3HFt9oUScEWxPpcpPGB2356PjWLbumq8o6PguS/I/6ot4CuN/kkomQzwXxiHRRFQ/SPznxstQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Q3hN52i8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=34pDim3q98b+di9DArDJuxpv+10vrgDHS+iLBvplmv0=; b=Q3hN52i88wV+Zt4M+5OxWRAq/6
	xLKWI9TDAV0w/vbAzlEEQe/iNo1sE2nCuT08Q5SG0yFmzBnho3oDLE7bAS2dk+bqHwR8yCM9S+JEc
	KttzZPtfqF1FQ1FoEtoK8pmQMdnFr9m2sPkpM8n4Nttsa0u+0e3il7J1v6+eZE4DQzNw=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sKFhM-00Ei9k-36;
	Thu, 20 Jun 2024 13:11:25 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH 05/10] wifi: mac80211: add support for DFS with multiple radios
Date: Thu, 20 Jun 2024 13:11:17 +0200
Message-ID: <48c34615b839768f7149180c419c90c0c1f2e27d.1718881762.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
References: <cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
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

