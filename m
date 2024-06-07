Return-Path: <linux-wireless+bounces-8707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 223179009F7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CE21F28187
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF319AD40;
	Fri,  7 Jun 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="f2cO4n8d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCED19A2A8
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776358; cv=none; b=Z1RglSe5aZ1lJqef39XrMIPMoM7kktkfQFWDeUs/ew1t8NHijzg4S97DdYOhTBetSaAtk0VKKUH4RzHJqFmA3XmNc6SzdYTpPfpJscXdyUEGUTh+LQvQhbZi8z0q2BV/7ZXHcaZOT36J8kTehMrVftIMInEOxo3Rq7Ct3HRO0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776358; c=relaxed/simple;
	bh=Eo5hwNf1jpd2lF8Ue4dQR4kcHfkFnUxOjriSsc+hC90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnlCFrpaI/nu7W68z0EnM/Ox/T7X/IGIh9alhC8mzbQS3zuY7vR1UP7YdG8fcTyl0yfRe9PnihUEfdbc/2d6ZZt+MsVf2F4XosNasbdwlsMe4mU946s6hP5bJ/pWO3g1nvt5weXhlVnDPZzf/ZbArXLcxhfytcJ3joL/WavblHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=f2cO4n8d; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=34pDim3q98b+di9DArDJuxpv+10vrgDHS+iLBvplmv0=; b=f2cO4n8dkIQHPI+U9ztWTitSRC
	Izf7H7d56GfoFWK9lPjXk7/Faidah4mQOVVGIG0K9Se1kNkoY6Tt2shSI6yv/DapHQB60Mf/YxWIa
	sFON/TSL7XArXmhaB54M81wXQ7tCzfFlG7RYnYZO6EQjazi7ZWni4LxU3KKBCm62O434=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFc6B-008xPc-0I;
	Fri, 07 Jun 2024 18:05:51 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v4 5/9] wifi: mac80211: add support for DFS with multiple radios
Date: Fri,  7 Jun 2024 18:05:44 +0200
Message-ID: <31b407a1a07356e0335dd2604c507f65ddab9615.1717776325.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
References: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
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

