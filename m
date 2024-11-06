Return-Path: <linux-wireless+bounces-14966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C751F9BE1CE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 10:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CF61F23696
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4511D7E4C;
	Wed,  6 Nov 2024 09:04:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091771D5AA8
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883892; cv=none; b=l5srd+6VdypwGYJt+sl/owzM2o8wsVpaW03QTNknbDeJMxuvGaWkNgm3Xe4hLHmLyJCsoMbHGeQin92yQPYlqJ/Ru1j4ELBKK3qMUyq2ubZQJnd29gVKAhpOvHmKvIM2VJa5ouVJEFeJN4Y+BqHu9+Ehv9s1xM0YLeFNA+qKoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883892; c=relaxed/simple;
	bh=4hjDbd/trsCIn2aRjgB2V2YG7yTSRZegeGRPUq5XKTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iv5/NHQM2OZId/SNV1vKo/WIdWOjNOAWF0/U8uAbJO+CP3T3xE59QXXjiQaI7MevC2XflGZXRQbD1Mkwe+xTVP8Us1GGURr7YS7ksEIj1WEZ5MD9Ucsm3rEepV3Y6yg+LuGUy15AAaEavONNc8z0iGMD4xdSu7cvLZf52AK9vQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from localhost (p200300C5970b9290000000000000032B.dip0.t-ipconnect.de [IPv6:2003:c5:970b:9290::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BCDA8FA132;
	Wed,  6 Nov 2024 10:04:41 +0100 (CET)
From: Issam Hamdi <ih@simonwunderlich.de>
To: ih@simonwunderlich.de
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	mathias.kretschmer@fit.fraunhofer.de,
	se@simonwunderlich.de,
	simon.wunderlich@open-mesh.com,
	sw@simonwunderlich.de
Subject: [PATCH v2 1/2] wifi: ath9k: work around AR_CFG 0xdeadbeef chip hang
Date: Wed,  6 Nov 2024 10:04:38 +0100
Message-Id: <20241106090439.3487958-1-ih@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241104171627.3789199-1-ih@simonwunderlich.de>
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Wunderlich <simon.wunderlich@open-mesh.com>

QCA 802.11n chips (especially AR9330/AR9340) sometimes end up in a state in
which a read of AR_CFG always returns 0xdeadbeef. This should not happen
when the power_mode of the device is ATH9K_PM_AWAKE.

This problem is not yet detected by any other workaround in ath9k. No way
is known to reproduce the problem easily.

This patch originally developed by "Simon Wunderlich <simon.wunderlich@open-mesh.com>"
and "Sven Eckelmann <sven.eckelmann@open-mesh.com>"

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <se@simonwunderlich.de>
Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
---
v2: update the Co-developed-by to Signed-off-by
---
 drivers/net/wireless/ath/ath9k/ath9k.h |  3 +++
 drivers/net/wireless/ath/ath9k/debug.c |  1 +
 drivers/net/wireless/ath/ath9k/debug.h |  1 +
 drivers/net/wireless/ath/ath9k/init.c  |  1 +
 drivers/net/wireless/ath/ath9k/link.c  | 31 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath9k/main.c  |  4 ++++
 6 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 29ca65a732a6..c1ce081445a9 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -739,11 +739,13 @@ void ath9k_csa_update(struct ath_softc *sc);
 #define ATH_ANI_MAX_SKIP_COUNT    10
 #define ATH_PAPRD_TIMEOUT         100 /* msecs */
 #define ATH_PLL_WORK_INTERVAL     100
+#define ATH_HANG_WORK_INTERVAL    4000
 
 void ath_hw_check_work(struct work_struct *work);
 void ath_reset_work(struct work_struct *work);
 bool ath_hw_check(struct ath_softc *sc);
 void ath_hw_pll_work(struct work_struct *work);
+void ath_hw_hang_work(struct work_struct *work);
 void ath_paprd_calibrate(struct work_struct *work);
 void ath_ani_calibrate(struct timer_list *t);
 void ath_start_ani(struct ath_softc *sc);
@@ -1044,6 +1046,7 @@ struct ath_softc {
 #endif
 	struct delayed_work hw_check_work;
 	struct delayed_work hw_pll_work;
+	struct delayed_work hw_hang_work;
 	struct timer_list sleep_timer;
 
 #ifdef CONFIG_ATH9K_BTCOEX_SUPPORT
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index eff894958a73..6b2469a01f17 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -750,6 +750,7 @@ static int read_file_reset(struct seq_file *file, void *data)
 		[RESET_TYPE_CALIBRATION] = "Calibration error",
 		[RESET_TX_DMA_ERROR] = "Tx DMA stop error",
 		[RESET_RX_DMA_ERROR] = "Rx DMA stop error",
+		[RESET_TYPE_DEADBEEF] = "deadbeef hang",
 	};
 	int i;
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.h b/drivers/net/wireless/ath/ath9k/debug.h
index 389459c04d14..6ebb6053a8c1 100644
--- a/drivers/net/wireless/ath/ath9k/debug.h
+++ b/drivers/net/wireless/ath/ath9k/debug.h
@@ -53,6 +53,7 @@ enum ath_reset_type {
 	RESET_TYPE_CALIBRATION,
 	RESET_TX_DMA_ERROR,
 	RESET_RX_DMA_ERROR,
+	RESET_TYPE_DEADBEEF,
 	__RESET_TYPE_MAX
 };
 
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index f9e77c4624d9..833474d7281f 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -740,6 +740,7 @@ static int ath9k_init_softc(u16 devid, struct ath_softc *sc,
 	INIT_WORK(&sc->paprd_work, ath_paprd_calibrate);
 	INIT_DELAYED_WORK(&sc->hw_pll_work, ath_hw_pll_work);
 	INIT_DELAYED_WORK(&sc->hw_check_work, ath_hw_check_work);
+	INIT_DELAYED_WORK(&sc->hw_hang_work, ath_hw_hang_work);
 
 	ath9k_init_channel_context(sc);
 
diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
index d1e5767aab3c..37438960c278 100644
--- a/drivers/net/wireless/ath/ath9k/link.c
+++ b/drivers/net/wireless/ath/ath9k/link.c
@@ -142,6 +142,37 @@ void ath_hw_pll_work(struct work_struct *work)
 				     msecs_to_jiffies(ATH_PLL_WORK_INTERVAL));
 }
 
+static bool ath_hw_hang_deadbeef(struct ath_softc *sc)
+{
+	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
+	u32 reg;
+
+	/* check for stucked MAC */
+	ath9k_ps_wakeup(sc);
+	reg = REG_READ(sc->sc_ah, AR_CFG);
+	ath9k_ps_restore(sc);
+
+	if (reg != 0xdeadbeef)
+		return false;
+
+	ath_dbg(common, RESET,
+		"0xdeadbeef hang is detected. Schedule chip reset\n");
+	ath9k_queue_reset(sc, RESET_TYPE_DEADBEEF);
+
+	return true;
+}
+
+void ath_hw_hang_work(struct work_struct *work)
+{
+	struct ath_softc *sc = container_of(work, struct ath_softc,
+					    hw_hang_work.work);
+
+	ath_hw_hang_deadbeef(sc);
+
+	ieee80211_queue_delayed_work(sc->hw, &sc->hw_hang_work,
+				     msecs_to_jiffies(ATH_HANG_WORK_INTERVAL));
+}
+
 /*
  * PA Pre-distortion.
  */
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index b92c89dad8de..024028ce8417 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -186,6 +186,7 @@ static void __ath_cancel_work(struct ath_softc *sc)
 	cancel_work_sync(&sc->paprd_work);
 	cancel_delayed_work_sync(&sc->hw_check_work);
 	cancel_delayed_work_sync(&sc->hw_pll_work);
+	cancel_delayed_work_sync(&sc->hw_hang_work);
 
 #ifdef CONFIG_ATH9K_BTCOEX_SUPPORT
 	if (ath9k_hw_mci_is_enabled(sc->sc_ah))
@@ -208,6 +209,9 @@ void ath_restart_work(struct ath_softc *sc)
 		ieee80211_queue_delayed_work(sc->hw, &sc->hw_pll_work,
 				     msecs_to_jiffies(ATH_PLL_WORK_INTERVAL));
 
+	ieee80211_queue_delayed_work(sc->hw, &sc->hw_hang_work,
+				     msecs_to_jiffies(ATH_HANG_WORK_INTERVAL));
+
 	ath_start_ani(sc);
 }
 

base-commit: 2b94751626a6d49bbe42a19cc1503bd391016bd5
-- 
2.39.2


