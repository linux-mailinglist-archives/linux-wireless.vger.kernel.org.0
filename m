Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7D6CFC91
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 09:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjC3HTO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjC3HTN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 03:19:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42983EC
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 00:19:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t4so12779275wra.7
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680160750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ur2bD4Hn8aSQvv82tzOokqjIow6KIhRlSQadkV1qCA=;
        b=pcTekv7Gx/epCeMGTDWHqtRBdUJv8FZQqxRu0ypYVftTE95k7CrucgXQxZuuiPJchz
         d2hRGUbY5CmxHjHk6hVMBpmf9Srl3hJSNWwgPfXculKLXi24E+mbVS2CIcvvYjPfgGF/
         v73npG8PrRLU4VOwuizsKM+xWeIjdfaSJNhOqRFIHc2WOhtayZHiR3FkZ2LbCkQUeeTS
         9CFg947zrWf0GUh9r41qGCO1PG0SqkpvKB4WVB0r7D7Q0I7PEEI4RipeotWKPRpms2I2
         elsv1iS+ZaOuBFDVD8r3iEoD6ROBEAjBju6bnJn92JQ6UZwEgXDfNaETzG74NqEy6Ovl
         Be+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680160750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ur2bD4Hn8aSQvv82tzOokqjIow6KIhRlSQadkV1qCA=;
        b=2PQqh4v4koLoprJMRh2bw0VaSyV8dcKcseaJs8yikEmXJ4uCJksGh7FtyhBiIc2ImU
         2UzmYI8eyTOiREwR7eG80+gJbjW5AKOb/NrhYLbsFFK0sHCFZDW7N2h3szQjY2GT0FNg
         8uKZng7mJYqLlFqHRtos5ZLYZH81GUYzeJsSHQjYiFQ2+aQyXyykyNYxNWYq4E5Js0o+
         2UHkQr0/uzMEdekJaHqKSHnpXb4T5V8Ts8slTUlJfHUdZ1KvBmN+QlrZKeC39HwGcBj0
         AFoGYXWMo1hCdm6YMfBEE5ZHFumzIak4llI9yz3bEyN6IPsGCOocoSqlxqrx4UN6TG+B
         bmnQ==
X-Gm-Message-State: AAQBX9d6/EVbceCvMpGW7VoJQ290KwwFvKH6DgLGecc6m3rysYsi+m3d
        FzNTWrgbWUj5Y2dOOUW61cABJiXx0uvQLQ==
X-Google-Smtp-Source: AKy350aNyzf178wMYee1By6juNKwqYSCbQ6N5X+/NzISd86CAda2eINZoYwlWGgaTWQVWw+LX/c6Qg==
X-Received: by 2002:a5d:684a:0:b0:2ce:fd37:938c with SMTP id o10-20020a5d684a000000b002cefd37938cmr17541701wrw.50.1680160750479;
        Thu, 30 Mar 2023 00:19:10 -0700 (PDT)
Received: from localhost.localdomain (vdsl-91-137-30-127.net.encoline.de. [91.137.30.127])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600012c700b002e45f6ffe63sm2030531wrx.26.2023.03.30.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 00:19:10 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     thomas.huehn@hs-nordhausen.de, nbd@nbd.name, kvalo@kernel.org,
        johannes.berg@intel.com, lorenzo@kernel.org,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH] ath9k: fix per-packet TX-power cap for TPC
Date:   Thu, 30 Mar 2023 09:18:54 +0200
Message-Id: <20230330071854.757154-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix incorrect usage of plain rate_idx as index into the max (power) per
rate lookup table.

For transmit power control (TPC), the ath9k driver maintains internal
tables (in struct ath_hw) to store the max allowed power level per rate.
They are used to limit a given TX-power according to regulatory and user
limits in the TX-path per packet. The tables are filled in a predefined
order, starting with values for CCK + OFDM rates and followed by the
values for MCS rates. Thus, the maximum power levels for MCS do not
start at index 0 in the table but are shifted by a fixed value.

The TX-power limiting in ath_get_rate_txpower did not apply this shift,
thus retrieved the incorrect maximum power level. For example, the
maximum power for OFDM rate 0 was used for MCS rate 0. If STBC was used,
the power was mostly limited to 0 because the STBC table is zeroed for
legacy CCK/OFDM rates. This patch fixes this table lookup.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 30 +++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index ef9a8e0b75e6..f6f2ab7a63ff 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -34,6 +34,12 @@
 #define NUM_SYMBOLS_PER_USEC(_usec) (_usec >> 2)
 #define NUM_SYMBOLS_PER_USEC_HALFGI(_usec) (((_usec*5)-4)/18)
 
+/* Shifts in ar5008_phy.c and ar9003_phy.c are equal for all revisions */
+#define ATH9K_PWRTBL_11NA_OFDM_SHIFT    0
+#define ATH9K_PWRTBL_11NG_OFDM_SHIFT    4
+#define ATH9K_PWRTBL_11NA_HT_SHIFT      8
+#define ATH9K_PWRTBL_11NG_HT_SHIFT      12
+
 
 static u16 bits_per_symbol[][2] = {
 	/* 20MHz 40MHz */
@@ -1169,13 +1175,14 @@ void ath_update_max_aggr_framelen(struct ath_softc *sc, int queue, int txop)
 }
 
 static u8 ath_get_rate_txpower(struct ath_softc *sc, struct ath_buf *bf,
-			       u8 rateidx, bool is_40, bool is_cck)
+			       u8 rateidx, bool is_40, bool is_cck, bool is_mcs)
 {
 	u8 max_power;
 	struct sk_buff *skb;
 	struct ath_frame_info *fi;
 	struct ieee80211_tx_info *info;
 	struct ath_hw *ah = sc->sc_ah;
+	bool is_2ghz, is_5ghz, use_stbc;
 
 	if (sc->tx99_state || !ah->tpc_enabled)
 		return MAX_RATE_POWER;
@@ -1184,6 +1191,19 @@ static u8 ath_get_rate_txpower(struct ath_softc *sc, struct ath_buf *bf,
 	fi = get_frame_info(skb);
 	info = IEEE80211_SKB_CB(skb);
 
+	is_2ghz = info->band == NL80211_BAND_2GHZ;
+	is_5ghz = info->band == NL80211_BAND_5GHZ;
+	use_stbc = is_mcs && rateidx < 8 && (info->flags &
+					     IEEE80211_TX_CTL_STBC);
+
+	if (is_mcs)
+		rateidx += is_5ghz ? ATH9K_PWRTBL_11NA_HT_SHIFT
+				   : ATH9K_PWRTBL_11NG_HT_SHIFT;
+	else if (is_2ghz && !is_cck)
+		rateidx += ATH9K_PWRTBL_11NG_OFDM_SHIFT;
+	else
+		rateidx += ATH9K_PWRTBL_11NA_OFDM_SHIFT;
+
 	if (!AR_SREV_9300_20_OR_LATER(ah)) {
 		int txpower = fi->tx_power;
 
@@ -1193,10 +1213,8 @@ static u8 ath_get_rate_txpower(struct ath_softc *sc, struct ath_buf *bf,
 			u16 eeprom_rev = ah->eep_ops->get_eeprom_rev(ah);
 
 			if (eeprom_rev >= AR5416_EEP_MINOR_VER_2) {
-				bool is_2ghz;
 				struct modal_eep_header *pmodal;
 
-				is_2ghz = info->band == NL80211_BAND_2GHZ;
 				pmodal = &eep->modalHeader[is_2ghz];
 				power_ht40delta = pmodal->ht40PowerIncForPdadc;
 			} else {
@@ -1229,7 +1247,7 @@ static u8 ath_get_rate_txpower(struct ath_softc *sc, struct ath_buf *bf,
 		if (!max_power && !AR_SREV_9280_20_OR_LATER(ah))
 			max_power = 1;
 	} else if (!bf->bf_state.bfs_paprd) {
-		if (rateidx < 8 && (info->flags & IEEE80211_TX_CTL_STBC))
+		if (use_stbc)
 			max_power = min_t(u8, ah->tx_power_stbc[rateidx],
 					  fi->tx_power);
 		else
@@ -1319,7 +1337,7 @@ static void ath_buf_set_rate(struct ath_softc *sc, struct ath_buf *bf,
 			}
 
 			info->txpower[i] = ath_get_rate_txpower(sc, bf, rix,
-								is_40, false);
+								is_40, false, true);
 			continue;
 		}
 
@@ -1350,7 +1368,7 @@ static void ath_buf_set_rate(struct ath_softc *sc, struct ath_buf *bf,
 
 		is_cck = IS_CCK_RATE(info->rates[i].Rate);
 		info->txpower[i] = ath_get_rate_txpower(sc, bf, rix, false,
-							is_cck);
+							is_cck, false);
 	}
 
 	/* For AR5416 - RTS cannot be followed by a frame larger than 8K */
-- 
2.30.2

