Return-Path: <linux-wireless+bounces-16075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44A9E9AEA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C34282433
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157878C9C;
	Mon,  9 Dec 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OfGY6kQt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EC13AA2F
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759484; cv=none; b=mQa9j2VwysciOia31YLUTJUK8pLNWzcmbhpSS7pnIgIJWOHsP+xPKLRNaM4aygbM0XoSFc7uF84/vMAG5ReVay5LBixnM2nEHjGtEB5vPQC6i6cbrKcPpXVT7BHjAj0bWHfRk3t+eEnYnLs/ytF7iTl6wiFGYI5UF3wGb477XAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759484; c=relaxed/simple;
	bh=wqjFKAdAnG0NZxt5cG5AoTF/dUAKnDRdDx4MXSO65DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeZqndl9raS5BKGEaPl8tf08JTjh7oVC8QxM7g9yKXXWOHOEsDtcuv0F55fHpGHVwVONuCfjLmeTdsT75n/kUoSsvEIV3rNyJhltRVlYfC9Xfbq2LVp9bzdXKhSnYeKwM8iXD8FuA8Vqz/ud8gWN6vnHic0vZcjUpIgMkU5kFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=OfGY6kQt; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward206d.mail.yandex.net (Yandex) with ESMTPS id A53B5635EC
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:51:13 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:694a:0:640:6efd:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 69AEA608DF;
	Mon,  9 Dec 2024 18:51:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3pnjm14OceA0-WN4tVVy5;
	Mon, 09 Dec 2024 18:51:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733759465; bh=oNqMTNJwhXpTTVbsiR8f0d5CV3X1GXm+Cj9mC99es2U=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=OfGY6kQtXxe6EgRT1Tu2/hC1Jnmrjrwi1/Gfpv+kLOaRSjY7sigMiFD4E/ms+T8LG
	 vU+dnZY3+EusCammRG6zbXNyGF6X9RG4ffDj+P8iKVzaipicAO2EM1k3PgY4S5e+0y
	 ArtF9sIoV9EuiB24JgGaxG6D7LRZjwu1qt4aJrAM=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] wifi: ath9k: simplify internal time management
Date: Mon,  9 Dec 2024 18:50:27 +0300
Message-ID: <20241209155027.636400-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209155027.636400-1-dmantipov@yandex.ru>
References: <20241209155027.636400-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer 'ktime_t' over 'struct timespec64' for 'struct ath_chanctx' and
'struct ath_softc' timestamps, choose standard kernel time API over an
ad-hoc math in 'chanctx_event_delta()' and 'ath9k_hw_get_tsf_offset()',
adjust related users. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/ath9k.h   |  4 ++--
 drivers/net/wireless/ath/ath9k/beacon.c  |  2 +-
 drivers/net/wireless/ath/ath9k/channel.c | 29 ++++++++++--------------
 drivers/net/wireless/ath/ath9k/hw.c      | 25 +++++++-------------
 drivers/net/wireless/ath/ath9k/hw.h      |  2 +-
 drivers/net/wireless/ath/ath9k/main.c    | 12 ++++------
 6 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index f68b96809ffa..ac70036f7f69 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -338,7 +338,7 @@ struct ath_chanctx {
 
 	struct ath_beacon_config beacon;
 	struct ath9k_hw_cal_data caldata;
-	struct timespec64 tsf_ts;
+	ktime_t tsf_ts;
 	u64 tsf_val;
 	u32 last_beacon;
 
@@ -1011,7 +1011,7 @@ struct ath_softc {
 	struct ath_offchannel offchannel;
 	struct ath_chanctx *next_chan;
 	struct completion go_beacon;
-	struct timespec64 last_event_time;
+	ktime_t last_event_time;
 #endif
 
 	unsigned long driver_data;
diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index b399a7926ef5..4a27e3753c03 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -293,7 +293,7 @@ void ath9k_beacon_ensure_primary_slot(struct ath_softc *sc)
 	/* Modify TSF as required and update the HW. */
 	avp->chanctx->tsf_val += tsfadjust;
 	if (sc->cur_chan == avp->chanctx) {
-		offset = ath9k_hw_get_tsf_offset(&avp->chanctx->tsf_ts, NULL);
+		offset = ath9k_hw_get_tsf_offset(avp->chanctx->tsf_ts, 0);
 		ath9k_hw_settsf64(sc->sc_ah, avp->chanctx->tsf_val + offset);
 	}
 
diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 571062f2e82a..499bbf042906 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -232,16 +232,11 @@ static const char *chanctx_state_string(enum ath_chanctx_state state)
 
 static u32 chanctx_event_delta(struct ath_softc *sc)
 {
-	u64 ms;
-	struct timespec64 ts, *old;
+	ktime_t ts = ktime_get_raw();
+	s64 ms = ktime_ms_delta(ts, sc->last_event_time);
 
-	ktime_get_raw_ts64(&ts);
-	old = &sc->last_event_time;
-	ms = ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
-	ms -= old->tv_sec * 1000 + old->tv_nsec / 1000000;
 	sc->last_event_time = ts;
-
-	return (u32)ms;
+	return ms;
 }
 
 void ath_chanctx_check_active(struct ath_softc *sc, struct ath_chanctx *ctx)
@@ -334,8 +329,8 @@ ath_chanctx_get_next(struct ath_softc *sc, struct ath_chanctx *ctx)
 static void ath_chanctx_adjust_tbtt_delta(struct ath_softc *sc)
 {
 	struct ath_chanctx *prev, *cur;
-	struct timespec64 ts;
 	u32 cur_tsf, prev_tsf, beacon_int;
+	ktime_t ts;
 	s32 offset;
 
 	beacon_int = TU_TO_USEC(sc->cur_chan->beacon.beacon_interval);
@@ -346,12 +341,12 @@ static void ath_chanctx_adjust_tbtt_delta(struct ath_softc *sc)
 	if (!prev->switch_after_beacon)
 		return;
 
-	ktime_get_raw_ts64(&ts);
+	ts = ktime_get_raw();
 	cur_tsf = (u32) cur->tsf_val +
-		  ath9k_hw_get_tsf_offset(&cur->tsf_ts, &ts);
+		  ath9k_hw_get_tsf_offset(cur->tsf_ts, ts);
 
 	prev_tsf = prev->last_beacon - (u32) prev->tsf_val + cur_tsf;
-	prev_tsf -= ath9k_hw_get_tsf_offset(&prev->tsf_ts, &ts);
+	prev_tsf -= ath9k_hw_get_tsf_offset(prev->tsf_ts, ts);
 
 	/* Adjust the TSF time of the AP chanctx to keep its beacons
 	 * at half beacon interval offset relative to the STA chanctx.
@@ -691,7 +686,7 @@ void ath_chanctx_event(struct ath_softc *sc, struct ieee80211_vif *vif,
 		 */
 		tsf_time = sc->sched.switch_start_time;
 		tsf_time -= (u32) sc->cur_chan->tsf_val +
-			ath9k_hw_get_tsf_offset(&sc->cur_chan->tsf_ts, NULL);
+			ath9k_hw_get_tsf_offset(sc->cur_chan->tsf_ts, 0);
 		tsf_time += ath9k_hw_gettsf32(ah);
 
 		sc->sched.beacon_adjust = false;
@@ -1230,10 +1225,10 @@ void ath_chanctx_set_next(struct ath_softc *sc, bool force)
 {
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	struct ath_chanctx *old_ctx;
-	struct timespec64 ts;
 	bool measure_time = false;
 	bool send_ps = false;
 	bool queues_stopped = false;
+	ktime_t ts;
 
 	spin_lock_bh(&sc->chan_lock);
 	if (!sc->next_chan) {
@@ -1260,7 +1255,7 @@ void ath_chanctx_set_next(struct ath_softc *sc, bool force)
 		spin_unlock_bh(&sc->chan_lock);
 
 		if (sc->next_chan == &sc->offchannel.chan) {
-			ktime_get_raw_ts64(&ts);
+			ts = ktime_get_raw();
 			measure_time = true;
 		}
 
@@ -1277,7 +1272,7 @@ void ath_chanctx_set_next(struct ath_softc *sc, bool force)
 		spin_lock_bh(&sc->chan_lock);
 
 		if (sc->cur_chan != &sc->offchannel.chan) {
-			ktime_get_raw_ts64(&sc->cur_chan->tsf_ts);
+			sc->cur_chan->tsf_ts = ktime_get_raw();
 			sc->cur_chan->tsf_val = ath9k_hw_gettsf64(sc->sc_ah);
 		}
 	}
@@ -1303,7 +1298,7 @@ void ath_chanctx_set_next(struct ath_softc *sc, bool force)
 		ath_set_channel(sc);
 		if (measure_time)
 			sc->sched.channel_switch_time =
-				ath9k_hw_get_tsf_offset(&ts, NULL);
+				ath9k_hw_get_tsf_offset(ts, 0);
 		/*
 		 * A reset will ensure that all queues are woken up,
 		 * so there is no need to awaken them again.
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index e2bef099adb3..81983062705c 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -1847,20 +1847,11 @@ static int ath9k_hw_do_fastcc(struct ath_hw *ah, struct ath9k_channel *chan)
 	return -EINVAL;
 }
 
-u32 ath9k_hw_get_tsf_offset(struct timespec64 *last, struct timespec64 *cur)
+u32 ath9k_hw_get_tsf_offset(ktime_t last, ktime_t cur)
 {
-	struct timespec64 ts;
-	s64 usec;
-
-	if (!cur) {
-		ktime_get_raw_ts64(&ts);
-		cur = &ts;
-	}
-
-	usec = cur->tv_sec * 1000000ULL + cur->tv_nsec / 1000;
-	usec -= last->tv_sec * 1000000ULL + last->tv_nsec / 1000;
-
-	return (u32) usec;
+	if (cur == 0)
+		cur = ktime_get_raw();
+	return ktime_us_delta(cur, last);
 }
 EXPORT_SYMBOL(ath9k_hw_get_tsf_offset);
 
@@ -1871,7 +1862,7 @@ int ath9k_hw_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 	u32 saveLedState;
 	u32 saveDefAntenna;
 	u32 macStaId1;
-	struct timespec64 tsf_ts;
+	ktime_t tsf_ts;
 	u32 tsf_offset;
 	u64 tsf = 0;
 	int r;
@@ -1917,7 +1908,7 @@ int ath9k_hw_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 	macStaId1 = REG_READ(ah, AR_STA_ID1) & AR_STA_ID1_BASE_RATE_11B;
 
 	/* Save TSF before chip reset, a cold reset clears it */
-	ktime_get_raw_ts64(&tsf_ts);
+	tsf_ts = ktime_get_raw();
 	tsf = ath9k_hw_gettsf64(ah);
 
 	saveLedState = REG_READ(ah, AR_CFG_LED) &
@@ -1951,7 +1942,7 @@ int ath9k_hw_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 	}
 
 	/* Restore TSF */
-	tsf_offset = ath9k_hw_get_tsf_offset(&tsf_ts, NULL);
+	tsf_offset = ath9k_hw_get_tsf_offset(tsf_ts, 0);
 	ath9k_hw_settsf64(ah, tsf + tsf_offset);
 
 	if (AR_SREV_9280_20_OR_LATER(ah))
@@ -1975,7 +1966,7 @@ int ath9k_hw_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 	 * value after the initvals have been applied.
 	 */
 	if (AR_SREV_9100(ah) && (ath9k_hw_gettsf64(ah) < tsf)) {
-		tsf_offset = ath9k_hw_get_tsf_offset(&tsf_ts, NULL);
+		tsf_offset = ath9k_hw_get_tsf_offset(tsf_ts, 0);
 		ath9k_hw_settsf64(ah, tsf + tsf_offset);
 	}
 
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 450ab19b1d4e..7a08b533b8af 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -1066,7 +1066,7 @@ u32 ath9k_hw_gettsf32(struct ath_hw *ah);
 u64 ath9k_hw_gettsf64(struct ath_hw *ah);
 void ath9k_hw_settsf64(struct ath_hw *ah, u64 tsf64);
 void ath9k_hw_reset_tsf(struct ath_hw *ah);
-u32 ath9k_hw_get_tsf_offset(struct timespec64 *last, struct timespec64 *cur);
+u32 ath9k_hw_get_tsf_offset(ktime_t last, ktime_t cur);
 void ath9k_hw_set_tsfadjust(struct ath_hw *ah, bool set);
 void ath9k_hw_init_global_settings(struct ath_hw *ah);
 u32 ar9003_get_pll_sqsum_dvc(struct ath_hw *ah);
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 2f137856a823..cf664a0dedaa 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -247,10 +247,8 @@ static bool ath_complete_reset(struct ath_softc *sc, bool start)
 	if (!sc->cur_chan->offchannel && start) {
 		/* restore per chanctx TSF timer */
 		if (sc->cur_chan->tsf_val) {
-			u32 offset;
-
-			offset = ath9k_hw_get_tsf_offset(&sc->cur_chan->tsf_ts,
-							 NULL);
+			u32 offset = ath9k_hw_get_tsf_offset
+				(sc->cur_chan->tsf_ts, 0);
 			ath9k_hw_settsf64(ah, sc->cur_chan->tsf_val + offset);
 		}
 
@@ -1955,7 +1953,7 @@ static u64 ath9k_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 		tsf = ath9k_hw_gettsf64(sc->sc_ah);
 	} else {
 		tsf = sc->cur_chan->tsf_val +
-		      ath9k_hw_get_tsf_offset(&sc->cur_chan->tsf_ts, NULL);
+		      ath9k_hw_get_tsf_offset(sc->cur_chan->tsf_ts, 0);
 	}
 	tsf += le64_to_cpu(avp->tsf_adjust);
 	ath9k_ps_restore(sc);
@@ -1974,7 +1972,7 @@ static void ath9k_set_tsf(struct ieee80211_hw *hw,
 	mutex_lock(&sc->mutex);
 	ath9k_ps_wakeup(sc);
 	tsf -= le64_to_cpu(avp->tsf_adjust);
-	ktime_get_raw_ts64(&avp->chanctx->tsf_ts);
+	avp->chanctx->tsf_ts = ktime_get_raw();
 	if (sc->cur_chan == avp->chanctx)
 		ath9k_hw_settsf64(sc->sc_ah, tsf);
 	avp->chanctx->tsf_val = tsf;
@@ -1990,7 +1988,7 @@ static void ath9k_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mutex_lock(&sc->mutex);
 
 	ath9k_ps_wakeup(sc);
-	ktime_get_raw_ts64(&avp->chanctx->tsf_ts);
+	avp->chanctx->tsf_ts = ktime_get_raw();
 	if (sc->cur_chan == avp->chanctx)
 		ath9k_hw_reset_tsf(sc->sc_ah);
 	avp->chanctx->tsf_val = 0;
-- 
2.47.1


