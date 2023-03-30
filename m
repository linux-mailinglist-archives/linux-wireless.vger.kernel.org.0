Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055BF6D0670
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjC3NWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjC3NWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 09:22:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE808A6B
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:22:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so11756890wmq.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680182540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3P1ZpZd3x35MeFhuY9cybIx3X0a2qBFzfkxMS+hc0k=;
        b=a8o0sxzwgrTgmXAEF/z9KizW133pua2OkY5MbwMVXchxnH4vCPy7u+kYuhqktdgNk3
         DuOItQxVAgB0j0akZmQIkHeyN82c7ZeAkUHjxLbuWIkQc229ztlIlHkfC418iwXc6TEX
         zAqnRaL5AEYZJCpA/gzZG+hC5BjsmI6rrXmfArFgM3AGuOmDZTVKUFzWspRy6HHHp6zn
         B68+LqtG4uKeypM647tTobCoN1gdbo0ff2lbazgmEg1KMB4Iv3Db4QG1/0IXf8etvtmt
         krkDaIfZvwM5X+i3w/91kUoRmkqtwRgu5yh2wNDEf1E/gESaiNtugbCFKQpo/0YsWup3
         TeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3P1ZpZd3x35MeFhuY9cybIx3X0a2qBFzfkxMS+hc0k=;
        b=zomMI6qA6U0XAe/tGYIiapK1mR9Rw+yV2zRJ5KEeDAa/lhteOREfGKSq0Uy+wTRjwX
         +Mc9jA+gemZO2TcTvXkPYftD/dHI0Eh3k8uJalCkyF2bVBzSkLJBNqa0DLr8IyK7sQZa
         W+y4RGRP6ZTmf3oNh9+uIWhsBqcik2TalhAvz1vLFBPC2Ko1UJCDo7WlMeY+rCOspoaw
         5D3jzPCJm8kWAt7SsE6kjJ+YFNS6g8gMVtbPWKA+Ye7eaon2QbEBvIYe9nq8qggbRjRO
         DrVR3g8TjdW0UvGC1unLGpjYrL5bgb9DDcfBkA93Lsn1CWweLM3kHW+GghVz2gScbfn6
         /AbA==
X-Gm-Message-State: AO0yUKWjisKesmGvNk3MDbBo0JXvajur5VvvnD7HgukNVOklTrWf2JXK
        J5l/1EG9jaHnypjqah1vR5N803CLKsU=
X-Google-Smtp-Source: AK7set881+1+e+H7oD4NwU2e8nlcnvzVbgIdH8VSwsHC7b0zAOsMIhpHVYSJl8iRqQJG7IUDMJ8NHQ==
X-Received: by 2002:a7b:c8c4:0:b0:3ed:ce6f:e86e with SMTP id f4-20020a7bc8c4000000b003edce6fe86emr17805917wml.23.1680182540576;
        Thu, 30 Mar 2023 06:22:20 -0700 (PDT)
Received: from localhost.localdomain (vdsl-91-137-30-127.net.encoline.de. [91.137.30.127])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4c51000000b002c54c9bd71fsm32788906wrt.93.2023.03.30.06.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:22:20 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     thomas.huehn@hs-nordhausen.de, nbd@nbd.name, kvalo@kernel.org,
        johannes.berg@intel.com, lorenzo@kernel.org,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v2] ath9k: fix per-packet TX-power cap for TPC
Date:   Thu, 30 Mar 2023 15:21:59 +0200
Message-Id: <20230330132159.758088-1-jelonek.jonas@gmail.com>
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

The TX-power limiting in ath_get_rate_txpower currently does not apply
this shift, thus retrieves the incorrect maximum power level for a given
rate. In particular for MCS rates, the maximum power levels for CCK/OFDM
rates were used, e.g. maximum power for OFDM 0 was used for MCS 0. If
STBC is used, the power is mostly limited to 0 because the STBC table
is zeroed for legacy CCK/OFDM rates. Encountered this during testing of
our work-in-progress TPC per packet for ath9k.
This only has an effect when TPC is enabled in ath9k (tpc_enabled in
struct ath_hw) which defaults to false. In this case it has a
significant impact on the used TX-power, throughput + RSSI. Otherwise
the affected code is just skipped and TX-power is limited with the
hardware registers only. This patch fixes this table lookup.

Tested on OpenWrt (kernel 5.15.98, but backported ath9k driver) with
small desk setup using ath9k chips AR9280 and AR9580. Cap of TX-power is
working properly for all rates now, throughput and RSSI as expected,
equal to as if TPC was disabled.
Compile-tested with latest 6.3 kernel + allyesconfig.

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

