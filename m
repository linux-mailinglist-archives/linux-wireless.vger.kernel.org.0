Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542BF460561
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Nov 2021 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhK1JN3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 04:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhK1JL3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 04:11:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86020C061574
        for <linux-wireless@vger.kernel.org>; Sun, 28 Nov 2021 01:08:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso14279707wml.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Nov 2021 01:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXAgGhG647yc4Otg2AuQ1hQA8E2j0zs1n8D1rCLrgvc=;
        b=f+x96dr2Sn17xNZe4HP0CbqazagD58fhwyjTqQh99PiQTZsL5kZETa/Z9lLX/k/ix4
         4DmeUZ//qUr7OnKSYRsXM3j3IPKx//nNecqiCQvTx1s5+gtLy9IL03kb/kHEIazKFsD3
         2av5DCualtJEZ0Amzt1wlnnzSx9l9sYcAqxwS5CkZQONX4CLhv7jNHblxGQ+PWsrxtsH
         nM1E9cc7PYZghUd5/ARdlmxfCiETKzVlcZyx3E15wD8hN2h4DunVkQB/3fuwbFl/VHSu
         0MI2vf+9Xkx5xFCtP+unCBONiHKPrvN2+6jhOQRobzbgbfW8065XnP9KTE0JVszo9JAS
         xwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXAgGhG647yc4Otg2AuQ1hQA8E2j0zs1n8D1rCLrgvc=;
        b=RbZ7DfI8GZgBi3DEottAGy2OGpwsfBlVa2Lxiz4Q5gRHriOTm80W3uOXSw1Zo/tzHo
         H9bML5IwepQzU2W8pbVbe6VMVITpoYbRPwpa/+A5M+8v6lZihvl43AN3le8iU5O8OUhZ
         HHa9QAIFcLPc95XMdxe6k30uy8zTcjn1cMtaWYsxscPl9nJV9HxnD97icWf5+0Vr3Ue6
         o0i6iYM6+hIZoP1kxzXxGIQxK5bWQR1gBEvI3acG/F45r1ESeVpwPmV9srV2aWXfnaaG
         vqe3Zdahaytk4dSmXwHXrrKWKTl+2PH1TKAjpx3+jrG/odjwViJ+GGt1Ocdqm1v+OnNu
         uL6g==
X-Gm-Message-State: AOAM532oV1/8lnrq8Kqt8sJ7zp94/c8wN/2XkkR2822yA4NFuJdV12no
        kk6NOYlSOwESg/JjFm+Tj1Xgx/4AlCA=
X-Google-Smtp-Source: ABdhPJxYubTyBA4Na0TyefpNn5KozzjbAoY51xlea5/6IwqJi3L6mbbbamygLj4zkbkVhzDQ2u2m6w==
X-Received: by 2002:a05:600c:1e06:: with SMTP id ay6mr29029317wmb.64.1638090491734;
        Sun, 28 Nov 2021 01:08:11 -0800 (PST)
Received: from build-server.fritz.box (p200300c56f3f8100880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f3f:8100:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id o12sm14919861wrc.85.2021.11.28.01.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 01:08:11 -0800 (PST)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, nbd@nbd.name, toke@redhat.com,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [PATCH v2] ath9k: switch to rate table based lookup
Date:   Sun, 28 Nov 2021 10:07:53 +0100
Message-Id: <20211128090753.958-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch changes mac80211 rate control for the ath9k driver.
The rate lookup per packet is changed from legacy usage of
ieee80211_get_tx_rates() to the new rate table based lookup in struct
ieee80211_sta->rates.

The most recent rate control API (introduced with
0d528d85c519b755b6f4e1bafa3a39984370e1c1) allows drivers to directly get
rates from ieee80211_sta->rates. This is not used by every driver yet,
the translation/merge is currently performed in ieee80211_get_tx_rates.
This patch changes the behaviour and avoids the call to
ieee80211_get_tx_rates and subsequent calls. ath9k now directly reads
rates from sta->rates into its rate table. Cause ath9k does not
expect rate selection in SKB->CB, the table merge does not consider rate
array in SKB->CB except for the first entry (used for probing).

Tested with a 8devices Rambutan with QCA9558 SoC by performing two
runs, one without the patch and one with. Generated traffic between
AP and multiple STAs in each run, measured throughput and captured rc_stats.
Comparison of both runs resulted in same rate selection and no
performance loss or other negative effects.

Co-developed-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

---
v2: Improved commit message with context information and testing
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

