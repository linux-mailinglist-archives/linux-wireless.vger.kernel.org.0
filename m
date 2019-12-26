Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0079012AC61
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2019 14:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfLZNbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Dec 2019 08:31:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46000 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZNbM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Dec 2019 08:31:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id j26so24727450ljc.12
        for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2019 05:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6tW3MpiXp4n6fBcBAks9mJm6LC5yRjddUGipJMczjI=;
        b=m8lMsNM7r4cxOpRaMkmyEpaa+mVrnAiRk8rY+e0ImVS2TatM3OckTkCLSZzlJ3Ho9z
         4n07zF8NEtP+ZCxYHf7FzioHc0Bbs7eEXP7tht6GJoa/2ZBr1qCPTVcwyy4SmRyIYepj
         QYiliTvnMpMkQKTVmheoUMx7GfXVSthsbSNoQtJcUH3rCTGf5jkwx2A5kaxqbdKQoxU8
         0CETV6EYYdj3Eg55mJbvhRjANcUSEEALMLCinI6eK4ff4kB+emij5EnH9ULGUyLjPK++
         Hv3eB2Pqz0YLjB/G0eCmffG5iq0HfvG3c8zl8Kq+CMZj2XXMenfQu68/tqkJf2ImmiG/
         6kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6tW3MpiXp4n6fBcBAks9mJm6LC5yRjddUGipJMczjI=;
        b=jMsESi6Jdly6LLk2LbWXiC8sPS8XPk9m19rTqGkcELiJ6uQna2xCl/T9G+Rm2+N5H5
         i9yUrhNRfqZ2bcJ/fgh4EVQZe1qfWF3UImRy1gWyXmblxXgFyH4W1x3HQKGWcHYDJrjY
         uQ1wI91tMcLiwlY4MMtl4ZUCJe9Q3nRiKs3NUzl79B73fimh3KFQTojz2N1lruwmKLrZ
         7E0nctARxtFx7kMxQ0r8J6iuFubMFVf7IOe2scHVJGgzBEujsfpTOZ3/zB2aXq8JjPR/
         Nbx64sGjJLSs39ez8EHwVbzfc35apfo/6lX2gXAkc1bo3U/5BLCHj0YV8ewaP7LYU2nL
         OieQ==
X-Gm-Message-State: APjAAAX9gTY3dXYg855kpEqEuEYsmdoMUYPQDNeQb92fPAbvMi4cEkqe
        IK181Nyx2EZ+KV3JmS0/R8Q=
X-Google-Smtp-Source: APXvYqxyZWozZufsbC9HidJj6icThx5SSjYVs2i8vAli4Z4A+oObRiD/NchyDiZ8/JOtzUFBKiCsFQ==
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr25942295ljh.136.1577367069545;
        Thu, 26 Dec 2019 05:31:09 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id m8sm13106720lfp.4.2019.12.26.05.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 05:31:08 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] brcmfmac: simplify building interface combinations
Date:   Thu, 26 Dec 2019 14:30:49 +0100
Message-Id: <20191226133050.16838-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Move similar/duplicated code out of combination specific code blocks.
This simplifies code a bit and allows adding more combinations later.
A list of combinations remains unchanged.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 43 ++++++-------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 6eb3064c3721..3ecb91aa765e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6547,12 +6547,13 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 	struct ieee80211_iface_limit *c0_limits = NULL;
 	struct ieee80211_iface_limit *p2p_limits = NULL;
 	struct ieee80211_iface_limit *mbss_limits = NULL;
-	bool mbss, p2p, rsdb;
+	bool mbss, p2p, rsdb, mchan;
 	int i, c, n_combos;
 
 	mbss = brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MBSS);
 	p2p = brcmf_feat_is_enabled(ifp, BRCMF_FEAT_P2P);
 	rsdb = brcmf_feat_is_enabled(ifp, BRCMF_FEAT_RSDB);
+	mchan = brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MCHAN);
 
 	n_combos = 1 + !!(p2p && !rsdb) + !!mbss;
 	combo = kcalloc(n_combos, sizeof(*combo), GFP_KERNEL);
@@ -6562,6 +6563,10 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				 BIT(NL80211_IFTYPE_ADHOC) |
 				 BIT(NL80211_IFTYPE_AP);
+	if (p2p)
+		wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					  BIT(NL80211_IFTYPE_P2P_GO) |
+					  BIT(NL80211_IFTYPE_P2P_DEVICE);
 
 	c = 0;
 	i = 0;
@@ -6573,48 +6578,28 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 		c0_limits = kcalloc(2, sizeof(*c0_limits), GFP_KERNEL);
 	if (!c0_limits)
 		goto err;
-	if (p2p && rsdb) {
-		combo[c].num_different_channels = 2;
-		wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
-					  BIT(NL80211_IFTYPE_P2P_GO) |
-					  BIT(NL80211_IFTYPE_P2P_DEVICE);
-		c0_limits[i].max = 2;
-		c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
+
+	combo[c].num_different_channels = 1 + (rsdb || (p2p && mchan));
+	c0_limits[i].max = 1 + rsdb;
+	c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
+	if (p2p) {
 		c0_limits[i].max = 1;
 		c0_limits[i++].types = BIT(NL80211_IFTYPE_P2P_DEVICE);
-		c0_limits[i].max = 2;
+		c0_limits[i].max = 1 + rsdb;
 		c0_limits[i++].types = BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				       BIT(NL80211_IFTYPE_P2P_GO);
+	}
+	if (p2p && rsdb) {
 		c0_limits[i].max = 2;
 		c0_limits[i++].types = BIT(NL80211_IFTYPE_AP);
 		combo[c].max_interfaces = 5;
 	} else if (p2p) {
-		if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MCHAN))
-			combo[c].num_different_channels = 2;
-		else
-			combo[c].num_different_channels = 1;
-		c0_limits[i].max = 1;
-		c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
-		wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
-					  BIT(NL80211_IFTYPE_P2P_GO) |
-					  BIT(NL80211_IFTYPE_P2P_DEVICE);
-		c0_limits[i].max = 1;
-		c0_limits[i++].types = BIT(NL80211_IFTYPE_P2P_DEVICE);
-		c0_limits[i].max = 1;
-		c0_limits[i++].types = BIT(NL80211_IFTYPE_P2P_CLIENT) |
-				       BIT(NL80211_IFTYPE_P2P_GO);
 		combo[c].max_interfaces = i;
 	} else if (rsdb) {
-		combo[c].num_different_channels = 2;
-		c0_limits[i].max = 2;
-		c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
 		c0_limits[i].max = 2;
 		c0_limits[i++].types = BIT(NL80211_IFTYPE_AP);
 		combo[c].max_interfaces = 3;
 	} else {
-		combo[c].num_different_channels = 1;
-		c0_limits[i].max = 1;
-		c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
 		c0_limits[i].max = 1;
 		c0_limits[i++].types = BIT(NL80211_IFTYPE_AP);
 		combo[c].max_interfaces = i;
-- 
2.21.0

