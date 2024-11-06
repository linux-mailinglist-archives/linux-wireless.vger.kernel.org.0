Return-Path: <linux-wireless+bounces-14982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B419BEB38
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 13:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2231C1F26F12
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C81DFD82;
	Wed,  6 Nov 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="pB0yd+JM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B721E25F7
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896923; cv=none; b=pWmyEiFNKmJX1viBc/jakzSmhC9sQxjKsKwP4b7ojqlnFjc+1NxcpKuv+YOzzpBpAoZnp7H38D6WKpJWMxsJ3H6/kVxFmiV6kk8WhH379iyYhp0r94W4HVvxDRG5IvU72oyzKHqK3Ga+59kEsqZhPOlMc6bpzaNEtnjjQJUqslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896923; c=relaxed/simple;
	bh=T4VWyZsgw+hitCvPDpvITeuF/jU8pEbu8awzoyJ90EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IwdEz6KzSxAF2rGDFtJIosnP9N1oEFgHT41PD88c1O1EdR0Rj4eCJlpm7jyUPtT/o2LPEggLPRs6HCHUYRhqUaOjGs03rEtFuoK5YyUQa3HJqvlPFqaCeraxaVLA8heQTdCdrycNv3kshcYASp0ZjvWeVHwyniYPIb2fVGDmnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=pB0yd+JM; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1730896918; bh=T4VWyZsgw+hitCvPDpvITeuF/jU8pEbu8awzoyJ90EE=;
	h=From:Date:Subject:To:Cc:From;
	b=pB0yd+JM1U26zHs0c6R0ucTX9N2di44TvCs69xpjz7bxTJdVhKx5UDrOnD8XraFPK
	 1m0uS0Xc0rQL8lT7R7oZMy76r4B7DoQEWB2g0k2zU+84oAUI+agpRUgTpBr4tzJy0b
	 RqiZ4jTDOmLW3J4R3Wp1oOfSKOElChrVEz1YHLxEHd3qiKW+RHaFovYCXsfnl9CVkD
	 PqXYewO7VbJ4e0eQzzAB+/1MXVzXBRtLzho4P+ztLABsaTr4cFfI09EqrXygDS1iJZ
	 Q+aQcr3rCtRXkQb1PUXsexaIjeiUtYTp0tQ59ltxf1xY5+0PUWJ5DC4GWeXC8dPYv8
	 yKJ0xfQ6tdgDw==
Date: Wed, 06 Nov 2024 13:41:44 +0100
Subject: [PATCH] ath9k: Add RX inactivity detection and reset chip when it
 occurs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAdkK2cC/x2MQQqAIBAAvyJ7TlCzoL4SHczWWgILlQikv7d0G
 ZjDTIWMiTDDKCokvCnTGVl0I8DvLm4oaWUHo4zVWnXSlX045IouMAr6woFUaPplaY1tXQ+cXgk
 DPf92mt/3A1BZZJNmAAAA
X-Change-ID: 20241105-ath9k-deaf-detection-0e26bb3243a6
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Sven Eckelmann <se@simonwunderlich.de>, Felix Fietkau <nbd@nbd.name>

Some ath9k chips can, seemingly at random, end up in a state which can
be described as "deaf". No or nearly no interrupts are generated anymore
for incoming packets. Existing links either break down after a while and
new links will not be established.

The circumstances leading to this "deafness" is still unclear, but some
particular chips (especially 2-stream 11n SoCs, but also others) can go
'deaf' when running AP or mesh (or both) after some time. It's probably
a hardware issue, and doing a channel scan to trigger a chip
reset (which one normally can't do on an AP interface) recovers the
hardware.

The only way the driver can detect this state, is by detecting if there
has been no RX activity for a while. In this case we can proactively
reset the chip (which only takes a small number of milliseconds, so
shouldn't interrupt things too much if it has been idle for several
seconds), which functions as a workaround.

OpenWrt, and various derivatives, have been carrying versions of this
workaround for years, that were never upstreamed. One version[0],
written by Felix Fietkau, used a simple counter and only reset if there
was precisely zero RX activity for a long period of time. This had the
problem that in some cases a small number of interrupts would appear
even if the device was otherwise not responsive. For this reason,
another version[1], written by Simon Wunderlich and Sven Eckelmann, used
a time-based approach to calculate the average number of RX interrupts
over a longer (four-second) interval, and reset the chip when seeing
less than one interrupt per second over this period. However, that
version relied on debugfs counters to keep track of the number of
interrupts, which means it didn't work at all if debugfs was not
enabled.

This patch unifies the two versions: it uses the same approach as Felix'
patch to count the number of RX handler invocations, but uses the same
time-based windowing approach as Simon and Sven's patch to still handle
the case where occasional interrupts appear but the device is otherwise
deaf.

Since this is based on ideas by all three people, but not actually
directly derived from any of the patches, I'm including Suggested-by
tags from Simon, Sven and Felix below, which should hopefully serve as
proper credit.

[0] https://patchwork.kernel.org/project/linux-wireless/patch/20170125163654.66431-3-nbd@nbd.name/
[1] https://patchwork.kernel.org/project/linux-wireless/patch/20161117083614.19188-2-sven.eckelmann@open-mesh.com/

Suggested-by: Simon Wunderlich <sw@simonwunderlich.de>
Suggested-by: Sven Eckelmann <se@simonwunderlich.de>
Suggested-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 drivers/net/wireless/ath/ath9k/ath9k.h |  2 ++
 drivers/net/wireless/ath/ath9k/debug.c |  1 +
 drivers/net/wireless/ath/ath9k/debug.h |  1 +
 drivers/net/wireless/ath/ath9k/link.c  | 33 +++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath9k/main.c  |  1 +
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 29ca65a732a66c9452b19ad184f513f92e4c8c2c..bcfc8df0efe5b2c5510230e7f59592d51df8365e 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -1018,6 +1018,8 @@ struct ath_softc {
 
 	u8 gtt_cnt;
 	u32 intrstatus;
+	u32 rx_active_check_time;
+	u32 rx_active_count;
 	u16 ps_flags; /* PS_* */
 	bool ps_enabled;
 	bool ps_idle;
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 51abc470125b3cc4e773f5272e2394c8f790a32e..a1e3bcf796f27fd58f5ab307a198927274f8f321 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -750,6 +750,7 @@ static int read_file_reset(struct seq_file *file, void *data)
 		[RESET_TYPE_CALIBRATION] = "Calibration error",
 		[RESET_TX_DMA_ERROR] = "Tx DMA stop error",
 		[RESET_RX_DMA_ERROR] = "Rx DMA stop error",
+		[RESET_TYPE_RX_INACTIVE] = "Rx path inactive",
 	};
 	int i;
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.h b/drivers/net/wireless/ath/ath9k/debug.h
index 389459c04d14a5215783b916519d05419b970c20..cb3e75969875afed282b09ff2458dd8ca286d5b1 100644
--- a/drivers/net/wireless/ath/ath9k/debug.h
+++ b/drivers/net/wireless/ath/ath9k/debug.h
@@ -53,6 +53,7 @@ enum ath_reset_type {
 	RESET_TYPE_CALIBRATION,
 	RESET_TX_DMA_ERROR,
 	RESET_RX_DMA_ERROR,
+	RESET_TYPE_RX_INACTIVE,
 	__RESET_TYPE_MAX
 };
 
diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
index d1e5767aab3cbc2ee91018edadf89a223cf1d759..d078a59d7d3cdbe623b507d29cc974b801f2deaf 100644
--- a/drivers/net/wireless/ath/ath9k/link.c
+++ b/drivers/net/wireless/ath/ath9k/link.c
@@ -50,7 +50,36 @@ static bool ath_tx_complete_check(struct ath_softc *sc)
 		"tx hung, resetting the chip\n");
 	ath9k_queue_reset(sc, RESET_TYPE_TX_HANG);
 	return false;
+}
+
+#define RX_INACTIVE_CHECK_INTERVAL (4 * MSEC_PER_SEC)
+
+static bool ath_hw_rx_inactive_check(struct ath_softc *sc)
+{
+	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
+	u32 interval, count;
+
+	interval = jiffies_to_msecs(jiffies - sc->rx_active_check_time);
+	count = sc->rx_active_count;
+
+	if (interval < RX_INACTIVE_CHECK_INTERVAL)
+		return true; /* too soon to check */
 
+	sc->rx_active_count = 0;
+	sc->rx_active_check_time = jiffies;
+
+	/* Need at least one interrupt per second, and we should only react if
+	 * we are within a factor two of the expected interval
+	 */
+	if (interval > RX_INACTIVE_CHECK_INTERVAL * 2 ||
+	    count >= interval / MSEC_PER_SEC)
+		return true;
+
+	ath_dbg(common, RESET,
+		"RX inactivity detected. Schedule chip reset\n");
+	ath9k_queue_reset(sc, RESET_TYPE_RX_INACTIVE);
+
+	return false;
 }
 
 void ath_hw_check_work(struct work_struct *work)
@@ -58,8 +87,8 @@ void ath_hw_check_work(struct work_struct *work)
 	struct ath_softc *sc = container_of(work, struct ath_softc,
 					    hw_check_work.work);
 
-	if (!ath_hw_check(sc) ||
-	    !ath_tx_complete_check(sc))
+	if (!ath_hw_check(sc) || !ath_tx_complete_check(sc) ||
+	    !ath_hw_rx_inactive_check(sc))
 		return;
 
 	ieee80211_queue_delayed_work(sc->hw, &sc->hw_check_work,
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index b92c89dad8deac7281e0165c9e1a566ba99ece65..998f717a1a86eee539058f6f4d9318dd459fc8dd 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -453,6 +453,7 @@ void ath9k_tasklet(struct tasklet_struct *t)
 			ath_rx_tasklet(sc, 0, true);
 
 		ath_rx_tasklet(sc, 0, false);
+		sc->rx_active_count++;
 	}
 
 	if (status & ATH9K_INT_TX) {

---
base-commit: c33f9c2728d0ccc7472e6239346c0fb3de556e0f
change-id: 20241105-ath9k-deaf-detection-0e26bb3243a6


