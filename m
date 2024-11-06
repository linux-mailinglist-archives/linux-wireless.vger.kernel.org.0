Return-Path: <linux-wireless+bounces-14967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FA79BE1CF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648361F2496B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7CE1D9681;
	Wed,  6 Nov 2024 09:04:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915721D9A43
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883896; cv=none; b=HuejNilEODoDtEzDcrv2aqyIctSAIrJ4l+6TlVF8KR5Lnsd0SJmz8QVATCWP4+Fbci2jcjdEyUDuMMOzjWB1YsVTJY/uMUG2vMX0CGHGf+7jtDuUbibJntzQacrdkkpmdxn7k6jqLIUQDlT9iTPV1qi5E26DPdRPdfPJf4/mOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883896; c=relaxed/simple;
	bh=cCAJtGsQuZ8XVXM1LZf7KgNAGUitvkTU/3TZ4tQ/ZWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=by0pA2HTNSBwC9zjYoj5VQSNT+69JyxQfzvEyGCYEonwuKveT9akK/MAvI/sQkVRnWVQNbvoJSXWRzwTckX682aVC4BKZaRzTfHk8JuES0MzE8rMCTNPHccyqNPYQ6MWEuKP8Q2kfNkmOrtf9gbrqN0MJLthQXLUuyVPzI/VLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from localhost (p200300C5970B9290000000000000032b.dip0.t-ipconnect.de [IPv6:2003:c5:970b:9290::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0713BFA181;
	Wed,  6 Nov 2024 10:04:45 +0100 (CET)
From: Issam Hamdi <ih@simonwunderlich.de>
To: ih@simonwunderlich.de
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	mathias.kretschmer@fit.fraunhofer.de,
	se@simonwunderlich.de,
	simon.wunderlich@open-mesh.com,
	sw@simonwunderlich.de
Subject: [PATCH v2 2/2] wifi: ath9k: Reset chip on potential deaf state
Date: Wed,  6 Nov 2024 10:04:39 +0100
Message-Id: <20241106090439.3487958-2-ih@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106090439.3487958-1-ih@simonwunderlich.de>
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
 <20241106090439.3487958-1-ih@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Wunderlich <simon.wunderlich@open-mesh.com>

The chip is switching seemingly random into a state which can be described
as "deaf". No or nearly no interrupts are generated anymore for incoming
packets. Existing links either break down after a while and new links will
not be established.

The driver doesn't know if there is no other device available or if it
ended up in an "deaf" state. Resetting the chip proactively avoids
permanent problems in case the chip really was in its "deaf" state but
maybe causes unnecessary resets in case it wasn't "deaf".

The circumstances leading to this "deafness" is still unclear,
but we see that some particular chips (especially 2-stream 11n
SoCs, but also others) can go 'deaf' when running AP or mesh (or both)
after some time. It's probably a hardware issue, and doing a channel
scan to trigger a chip reset (which one normally can't do on an AP interface)
recovers the hardware. This patch provides a workaround within the kernel.

The idea is that if the radio is idle anyway, a quick reset (which takes a few
tens of ms maximum) doesn't hurt much, and it helps to recover non-functional
APs or mesh points.

This patch originally developed by "Simon Wunderlich <simon.wunderlich@open-mesh.com>"
and "Sven Eckelmann <sven.eckelmann@open-mesh.com>"

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <se@simonwunderlich.de>
Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
---
v2: change the "Co-developed-by" to "Signed-off-by", remove the dependency
on CONFIG_ATH9K_DEBUGFS and add more information in the commit description
---
 drivers/net/wireless/ath/ath9k/ath9k.h |  3 ++
 drivers/net/wireless/ath/ath9k/debug.c |  1 +
 drivers/net/wireless/ath/ath9k/debug.h |  1 +
 drivers/net/wireless/ath/ath9k/link.c  | 48 +++++++++++++++++++++++++-
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index c1ce081445a9..2b98c69fa37f 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -1026,6 +1026,9 @@ struct ath_softc {
 	short nbcnvifs;
 	unsigned long ps_usecount;
 
+	unsigned long last_check_time;
+	u32 last_check_interrupts;
+
 	struct ath_rx rx;
 	struct ath_tx tx;
 	struct ath_beacon beacon;
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 6b2469a01f17..4128cf691166 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -751,6 +751,7 @@ static int read_file_reset(struct seq_file *file, void *data)
 		[RESET_TX_DMA_ERROR] = "Tx DMA stop error",
 		[RESET_RX_DMA_ERROR] = "Rx DMA stop error",
 		[RESET_TYPE_DEADBEEF] = "deadbeef hang",
+		[RESET_TYPE_DEAF] = "deaf hang",
 	};
 	int i;
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.h b/drivers/net/wireless/ath/ath9k/debug.h
index 6ebb6053a8c1..76e27860455c 100644
--- a/drivers/net/wireless/ath/ath9k/debug.h
+++ b/drivers/net/wireless/ath/ath9k/debug.h
@@ -54,6 +54,7 @@ enum ath_reset_type {
 	RESET_TX_DMA_ERROR,
 	RESET_RX_DMA_ERROR,
 	RESET_TYPE_DEADBEEF,
+	RESET_TYPE_DEAF,
 	__RESET_TYPE_MAX
 };
 
diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
index 37438960c278..2700598c6336 100644
--- a/drivers/net/wireless/ath/ath9k/link.c
+++ b/drivers/net/wireless/ath/ath9k/link.c
@@ -162,13 +162,59 @@ static bool ath_hw_hang_deadbeef(struct ath_softc *sc)
 	return true;
 }
 
+static bool ath_hw_hang_deaf(struct ath_softc *sc)
+{
+#ifdef CONFIG_ATH9K_TX99
+	return false;
+#else
+	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
+	u32 interrupts, interrupt_per_s;
+	unsigned int interval;
+
+	/* get historic data */
+	interval = jiffies_to_msecs(jiffies - sc->last_check_time);
+	if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA)
+		interrupts = sc->debug.stats.istats.rxlp;
+	else
+		interrupts = sc->debug.stats.istats.rxok;
+
+	interrupts -= sc->last_check_interrupts;
+
+	/* save current data */
+	sc->last_check_time = jiffies;
+	if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA)
+		sc->last_check_interrupts = sc->debug.stats.istats.rxlp;
+	else
+		sc->last_check_interrupts = sc->debug.stats.istats.rxok;
+
+	/* sanity check, should be 4 seconds */
+	if (interval > 10000 || interval < 1000)
+		return false;
+
+	/* should be at least one interrupt per second */
+	interrupt_per_s = interrupts / (interval / 1000);
+	if (interrupt_per_s >= 1)
+		return false;
+
+	ath_dbg(common, RESET,
+		"RX deaf hang is detected. Schedule chip reset\n");
+	ath9k_queue_reset(sc, RESET_TYPE_DEAF);
+
+	return true;
+#endif
+}
+
 void ath_hw_hang_work(struct work_struct *work)
 {
 	struct ath_softc *sc = container_of(work, struct ath_softc,
 					    hw_hang_work.work);
 
-	ath_hw_hang_deadbeef(sc);
+	if (ath_hw_hang_deadbeef(sc))
+		goto requeue_worker;
 
+	ath_hw_hang_deaf(sc);
+
+requeue_worker:
 	ieee80211_queue_delayed_work(sc->hw, &sc->hw_hang_work,
 				     msecs_to_jiffies(ATH_HANG_WORK_INTERVAL));
 }
-- 
2.39.2


