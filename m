Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE5845D9E3
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 13:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhKYMVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 07:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbhKYMUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 07:20:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C719C061574
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 04:17:07 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w1so24873830edc.6
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 04:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4o3C4Sk+V1UppQCjOFwVyndxtOCFD/AG0RzxBZttkCw=;
        b=h4jd43KmnCCXLn/F/DJfRz5oW9KMfPJ5LH0eNzPVZdt1sxlWOmsCuUZTdC6Y0+aY6h
         cF1wdKpLNvUytKvEaD3Pc2saNvIb1LEYtlG9gjlZX3+LAzMXSqEcRPKodRCwe/6Yw7z1
         VU6j53CKANzff8uilDjUui5MI6rUNYy5YVi8dbBLgFSWjYL+9ikteaML0Oppx5GrbojE
         DZDTEwtKUWTGLT69ji0SE5OSIKyUoFjOpSNOMVylUlqMDEANIg8i/PLWmycTR9zm8Re8
         49O3SPQz+EpHzSDmEZ7OSfvkOLalJJHRqn+i6BjsmZ+Zt4CtAIJIZG/UWrlu8oBYoT5v
         /OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4o3C4Sk+V1UppQCjOFwVyndxtOCFD/AG0RzxBZttkCw=;
        b=XyaatJg0I+fNZhVJoC9gbov8WpgSyWAqeWvbHDzbyniUJTARypAKlCRjYB1d0bq5/6
         ZsJ4KmkzPal/35JCbnNPWioFH2p9NsUR4h+RnPaLqKXklU8GI6wg5okgUmEuAuDE8F2k
         etn36hLlUQAR+hFICXtwbPptQE5oa9Zb3PVAyxiHCSexwYWZyMDLtKKWk271HQhYfIeq
         ykNIpXnHJosoOx2oq3XL9U2aSIg6Uvs4u94//FSMh+c7t2iO2uS4nVeiRvU8uoq93zSN
         QuBYBDqisghiCPKn83bcDKdkQ/Md9kOX+Ul9eNsydAWesOB7EFVa0j2glPa4mvdfyVo7
         ybeQ==
X-Gm-Message-State: AOAM532GWSH3/OxEVc/LQ8Ry1NGbx7YkBtK3nClA9okQR+vrykftQ6Cd
        LkISllYWigcg3F3qrC/axj1dq2TnG+UaiQ==
X-Google-Smtp-Source: ABdhPJxxKg7HKXTYxebSKqeEAGow2UsA+LYlGj9hbplNknK0TS9UmSOy1uxXUsRvVz+qGm5oo56Jqg==
X-Received: by 2002:a17:907:3daa:: with SMTP id he42mr31238020ejc.160.1637842625736;
        Thu, 25 Nov 2021 04:17:05 -0800 (PST)
Received: from build-server.fritz.box (p200300c56f256b00880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f25:6b00:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id b14sm1778853edw.6.2021.11.25.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 04:17:05 -0800 (PST)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [PATCH] ath9k: switch to rate table based lookup
Date:   Thu, 25 Nov 2021 13:16:52 +0100
Message-Id: <20211125121652.6073-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch changes mac80211 rate control for the ath9k driver.
The rate lookup per packet is changed from legacy usage of
ieee80211_get_tx_rates() to the new rate table based lookup
in struct ieee80211_sta.rates.

Co-developed-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Co-developed-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 45 +++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 5691bd6eb82c..d0caf1de2bde 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -154,11 +154,52 @@ static void ath_send_bar(struct ath_atx_tid *tid, u16 seqno)
 			   seqno << IEEE80211_SEQ_SEQ_SHIFT);
 }
 
+static bool ath_merge_ratetbl(struct ieee80211_sta *sta, struct ath_buf *bf,
+			      struct ieee80211_tx_info *tx_info)
+{
+	struct ieee80211_sta_rates *ratetbl;
+	u8 i;
+
+	if (!sta)
+		return false;
+
+	ratetbl = rcu_dereference(sta->rates);
+	if (!ratetbl)
+		return false;
+
+	if (tx_info->control.rates[0].idx < 0 ||
+	    tx_info->control.rates[0].count == 0)
+	{
+		i = 0;
+	} else {
+		bf->rates[0] = tx_info->control.rates[0];
+		i = 1;
+	}
+
+	for ( ; i < IEEE80211_TX_MAX_RATES; i++) {
+		bf->rates[i].idx = ratetbl->rate[i].idx;
+		bf->rates[i].flags = ratetbl->rate[i].flags;
+		if (tx_info->control.use_rts)
+			bf->rates[i].count = ratetbl->rate[i].count_rts;
+		else if (tx_info->control.use_cts_prot)
+			bf->rates[i].count = ratetbl->rate[i].count_cts;
+		else
+			bf->rates[i].count = ratetbl->rate[i].count;
+	}
+
+	return true;
+}
+
 static void ath_set_rates(struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 			  struct ath_buf *bf)
 {
-	ieee80211_get_tx_rates(vif, sta, bf->bf_mpdu, bf->rates,
-			       ARRAY_SIZE(bf->rates));
+	struct ieee80211_tx_info *tx_info;
+
+	tx_info = IEEE80211_SKB_CB(bf->bf_mpdu);
+
+	if (!ath_merge_ratetbl(sta, bf, tx_info))
+		ieee80211_get_tx_rates(vif, sta, bf->bf_mpdu, bf->rates,
+				       ARRAY_SIZE(bf->rates));
 }
 
 static void ath_txq_skb_done(struct ath_softc *sc, struct ath_txq *txq,
-- 
2.30.2

