Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A702519E6
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHYNkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHYNj7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 09:39:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9101C0617AA
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 06:39:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x9so2137891wmi.2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=No8SyHqzD2caZRXy6mcGyAfPZwJv+oQlCeaNaxA2XHM=;
        b=tERKdQ6v5+RR2fn41t46VA8TynCy8qycPPjbEPvCoLOvI4OuF+A9/nPwrY026piv9z
         2ZG/Z50j3FMtj4UISn/Z5QOaGlsTSMX475k/5HssH6H25jKvAaTsxOCPwzbT1ZuQoRkc
         CyjNWMP95r50xzg245S4kSsGqekdMbHYCM+Qp+mVj/BkEH0QKJj2J4GgkQKMneA00zf2
         ohmK5TyBARa5D8qeSXwJH4rQ7Kbra15HzYOeJpVMu2aH+2C1KcvBQT0MXoTPggIYlGhU
         9xBbFCetxr4lA23iIczGZ3MV0D7NTTXYhxIIHVh//BrPSMIAG/GR0RIit9PYtmE/rnMV
         AAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=No8SyHqzD2caZRXy6mcGyAfPZwJv+oQlCeaNaxA2XHM=;
        b=GWXTVCUJlbAg7bpeRWBVHl2myetifQZ0GNd1opw8/Dd9ULEW8UrXIKAQeijKpD0c0+
         Tk9Tioq/2TwTtVU6Es1MvZm/HU8N6p6I9AeRqWt9GDvhSmVcocSlmvzT3haPv/5AAmLA
         qjeSID6d9epMJn+jNbboDkLfMC40AEjukEO9I/bf1hDV6xOHG0iSlkxI6827EynBa/8j
         8tHMAeplCjM+nU8s+dqHaUjaH//AvI8mqafUXXL7sm5vGTujXt7Mkmb0dK/QdxjhNtM5
         dIm+Y7caveJ1+1hNwZ1prb0osdxAzWXrDL6wXGOZiWanwMl9IfUeZvxwVxLnXX3bLMs9
         dfag==
X-Gm-Message-State: AOAM532fA3NqMTYe74SFBFq8zB5ljs0MAd8yRuQmtiTmrBpKTqEzDc2n
        dyXVr28uo73WUxP5FoK1iqM1wg==
X-Google-Smtp-Source: ABdhPJyEkwMTVeqZM1keZ3bOGyH2UxrU8krRSB7gDr4Nr0EXIod1211RD3mRHQtRLjI3MWPqPFF6wg==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr2087476wmh.23.1598362797214;
        Tue, 25 Aug 2020 06:39:57 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id h11sm31361181wrb.68.2020.08.25.06.39.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 06:39:56 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Disable bmps when encryption is disabled
Date:   Tue, 25 Aug 2020 15:45:27 +0200
Message-Id: <1598363127-26066-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For whatever reason, when connected to an open/no-security BSS,
the wcn36xx controller in bmps mode does not forward 'wake-up'
beacons despite AP sends DTIM with station AID.

Meaning that AP is not able to wakeup the station and needs to wait
for the station to wakeup by its own (TX data, keep alive pkt...),
causing serious latency issues and unexpected deauth.

When connected to AP with encryption enabled, this issue does not occur.
So a simple workaround is to only enable bmps support in that case.

Ideally, it should be propertly fixed to allow bmps support with open
BSS, whatever the issue is at driver or firmware level.

Tested on wcn3620 and wcn3680.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 10 ++++++++++
 drivers/net/wireless/ath/wcn36xx/pmc.c     |  5 ++++-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 2f36656..39d658c 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -610,6 +610,15 @@ static int wcn36xx_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				}
 			}
 		}
+		/* FIXME: Only enable bmps support when encryption is enabled.
+		 * For any reasons, when connected to open/no-security BSS,
+		 * the wcn36xx controller in bmps mode does not forward
+		 * 'wake-up' beacons despite AP sends DTIM with station AID.
+		 * It could be due to a firmware issue or to the way driver
+		 * configure the station.
+		 */
+		if (vif->type == NL80211_IFTYPE_STATION)
+			vif_priv->allow_bmps = true;
 		break;
 	case DISABLE_KEY:
 		if (!(IEEE80211_KEY_FLAG_PAIRWISE & key_conf->flags)) {
@@ -891,6 +900,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 				    vif->addr,
 				    bss_conf->aid);
 			vif_priv->sta_assoc = false;
+			vif_priv->allow_bmps = false;
 			wcn36xx_smd_set_link_st(wcn,
 						bss_conf->bssid,
 						vif->addr,
diff --git a/drivers/net/wireless/ath/wcn36xx/pmc.c b/drivers/net/wireless/ath/wcn36xx/pmc.c
index 2936aaf..2d0780f 100644
--- a/drivers/net/wireless/ath/wcn36xx/pmc.c
+++ b/drivers/net/wireless/ath/wcn36xx/pmc.c
@@ -23,7 +23,10 @@ int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
 {
 	int ret = 0;
 	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
-	/* TODO: Make sure the TX chain clean */
+
+	if (!vif_priv->allow_bmps)
+		return -ENOTSUPP;
+
 	ret = wcn36xx_smd_enter_bmps(wcn, vif);
 	if (!ret) {
 		wcn36xx_dbg(WCN36XX_DBG_PMC, "Entered BMPS\n");
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 3221fed..719a6da 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -122,6 +122,7 @@ struct wcn36xx_vif {
 	enum wcn36xx_hal_bss_type bss_type;
 
 	/* Power management */
+	bool allow_bmps;
 	enum wcn36xx_power_state pw_state;
 
 	u8 bss_index;
-- 
2.7.4

