Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1656F4764EF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 22:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhLOVwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 16:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhLOVwN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 16:52:13 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA136C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 13:52:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so1976658wmd.5
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 13:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lo4oo3QOGXKE387FLp62r10ePTuPRwfqozZsRv7vgSE=;
        b=JLGkZAow4HHXvvhusL6C2oMoH9kuOcFcDv6CUCkVkooHfYR07jBLmtxpBqh1RiFDwH
         3E99fPGJFLLvefF+46qq5sG9wD6XNY7FQGatoOFH8BuE43OlciawB+rkXERfBr4vgeEE
         T6Cr7I9D/UbysEYXhCrpFvR3fEzv3jYzagnr3jvDT7smGB/wER0RPqT02VPu6iwI4Qo8
         /PqI3sN96vh0e/Ht5WnqsHM3dDWmcscXgqjJFoivwtbTJG49aHY66ymdT78uQ0l1sbX0
         /wrDZbtCsVC56i7aFaPjtVSRTW5pd+gBH358HYYuQ3dhOmh5EBk3txpZdcCLzhMgWHqh
         jX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lo4oo3QOGXKE387FLp62r10ePTuPRwfqozZsRv7vgSE=;
        b=CL1f18Rt3ZzazpUpGYWv8eoNinHmGN3adNM4u3LnCfU4IF7zXhaS3cepHTPDVhjAJh
         vv60zgLygnWQV6wgFzg2UWOBjgqw7IHGLdMHfQgdbOmUywMyrqBGmjvNR5BIzr3bpy85
         BBXpZLI/i/41h7F5oHh1tNLwHsWdvNEPAc4qi1Ug/WRTW8T+QGN3S23fVfSG6mg3t8oH
         OPuiIPHQvjMusLMu33TAY695OxvXU3i3byIOpZahp9td9Y5BUY3BCKy2zR76rzvBoMwu
         ggRQKJ4XlV7vofFEepZZFdHn2biiZMFke2obHzdOwzM84CF17JUuP2vgjZZy4OnIL8Bd
         a0eg==
X-Gm-Message-State: AOAM531yk3fdnRTnfHlMumh7veabLkpIYIPFUsPEFF4R6whAh6HJouQp
        CXvoBh+XBKkLLIxw9W7pfbhtgj2SM1pOIQ==
X-Google-Smtp-Source: ABdhPJwntiU0UkMooFD1y/hk6Vbu3ZTY0tDz2hJd3aGCCufE3FU7s+5dp4A9B1jSHEUkzT2bAYKVeA==
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr2144265wmm.142.1639605131425;
        Wed, 15 Dec 2021 13:52:11 -0800 (PST)
Received: from build-server.fritz.box (p200300c56f1b6b00880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1b:6b00:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id l15sm2795285wme.47.2021.12.15.13.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:52:10 -0800 (PST)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [PATCH] ath5k: switch to rate table based lookup
Date:   Wed, 15 Dec 2021 22:50:42 +0100
Message-Id: <20211215215042.637-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switching from legacy usage of ieee80211_get_tx_rates() lookup to direct
rate table lookup in struct ieee80211_sta->rates.

The current rate control API allows drivers to directly get rates from
ieee80211_sta->rates. ath5k is currently one of the legacy drivers that
perform translation/merge with the internal rate table via
ieee80211_get_tx_rates provided by rate control API.
For our upcoming changes to rate control API and the implementation of
transmit power control, this patch changes the behaviour. The call to
ieee80211_get_tx_rates and subsequent calls are also avoided. ath5k now
directly reads rates from sta->rates into its internal rate table. Cause
ath5k does not rely on the rate array in SKB->CB, this is not considered
anymore except for the first entry (used for probing).

Tested this on a PCEngines ALIX with CMP9-GP miniPCI wifi card (Atheros
AR5213A). Generated traffic between AP and multiple STAs before and
after applying the patch and simultaneously measured throughput and
captured rc_stats. Comparison resulted in same rate selection and no
performance loss between both runs.

Co-developed-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/wireless/ath/ath5k/base.c | 44 +++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index cef17f33c69e..647b3b76495c 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -727,6 +727,43 @@ ath5k_get_rate_hw_value(const struct ieee80211_hw *hw,
 	return hw_rate;
 }
 
+static bool ath5k_merge_ratetbl(struct ieee80211_sta *sta,
+				struct ath5k_buf *bf,
+				struct ieee80211_tx_info *tx_info)
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
 static int
 ath5k_txbuf_setup(struct ath5k_hw *ah, struct ath5k_buf *bf,
 		  struct ath5k_txq *txq, int padsize,
@@ -753,8 +790,11 @@ ath5k_txbuf_setup(struct ath5k_hw *ah, struct ath5k_buf *bf,
 	if (dma_mapping_error(ah->dev, bf->skbaddr))
 		return -ENOSPC;
 
-	ieee80211_get_tx_rates(info->control.vif, (control) ? control->sta : NULL, skb, bf->rates,
-			       ARRAY_SIZE(bf->rates));
+	if (!ath5k_merge_ratetbl((control) ? control->sta : NULL, bf, info)) {
+		ieee80211_get_tx_rates(info->control.vif,
+			(control) ? control->sta : NULL, skb, bf->rates,
+			ARRAY_SIZE(bf->rates));
+	}
 
 	rate = ath5k_get_rate(ah->hw, info, bf, 0);
 
-- 
2.30.2

