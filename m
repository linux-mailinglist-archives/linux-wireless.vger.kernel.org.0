Return-Path: <linux-wireless+bounces-460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E988680672D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 07:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DA52819EB
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 06:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F8610978;
	Wed,  6 Dec 2023 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VwPjwfx+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB52D40
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 22:10:39 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:61f:0:640:a9f7:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTP id C2D2E463C7;
	Wed,  6 Dec 2023 09:10:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aAVo4vAXrCg0-w5kjTKdw;
	Wed, 06 Dec 2023 09:10:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1701843036; bh=bHHl20MsGa/zK0CRXkIvj96+AvefUGhmJvDA+EDk0nE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=VwPjwfx+WeEqaTvuJUwG1mELDA7haEae/uZSJR06aHB0CcIjjbSY9dGkRcohk5R4B
	 B5/u10zUOMAvqF1M6ECUodSM6koT5lpEijgzRd/KqL4if0E+0MlVKTf0380aRwfWKL
	 QzPwMc8MeCyRP6cLUuBWCHYRqZooXdc+n3ElcdOY=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mac80211: cleanup airtime arithmetic with ieee80211_sta_keep_active()
Date: Wed,  6 Dec 2023 09:09:27 +0300
Message-ID: <20231206060935.612241-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer native jiffies-wide 'unsigned long' for the 'last_active' field of
'struct airtime_info' and introduce 'ieee80211_sta_keep_active()' for airtime
check in 'ieee80211_txq_keep_active()' and 'ieee80211_sta_register_airtime()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac80211/ieee80211_i.h | 13 ++++++++-----
 net/mac80211/sta_info.c    |  4 +---
 net/mac80211/sta_info.h    |  2 +-
 net/mac80211/tx.c          |  7 ++-----
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 84df104f272b..d284dd570190 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -92,11 +92,14 @@ enum ieee80211_status_data {
 	IEEE80211_STATUS_SUBDATA_MASK	= 0xff0,
 };
 
-/*
- * Keep a station's queues on the active list for deficit accounting purposes
- * if it was active or queued during the last 100ms
- */
-#define AIRTIME_ACTIVE_DURATION (HZ / 10)
+static inline bool
+ieee80211_sta_keep_active(struct sta_info *sta, u8 ac)
+{
+	/* Keep a station's queues on the active list for deficit accounting
+	 * purposes if it was active or queued during the last 100ms.
+	 */
+	return time_before_eq(jiffies, sta->airtime[ac].last_active + HZ / 10);
+}
 
 struct ieee80211_bss {
 	u32 device_ts_beacon, device_ts_presp;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0ba613dd1cc4..27ccdfea5c6a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2268,7 +2268,6 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 	struct ieee80211_local *local = sta->sdata->local;
 	u8 ac = ieee80211_ac_from_tid(tid);
 	u32 airtime = 0;
-	u32 diff;
 
 	if (sta->local->airtime_flags & AIRTIME_USE_TX)
 		airtime += tx_airtime;
@@ -2279,8 +2278,7 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 	sta->airtime[ac].tx_airtime += tx_airtime;
 	sta->airtime[ac].rx_airtime += rx_airtime;
 
-	diff = (u32)jiffies - sta->airtime[ac].last_active;
-	if (diff <= AIRTIME_ACTIVE_DURATION)
+	if (ieee80211_sta_keep_active(sta, ac))
 		sta->airtime[ac].deficit -= airtime;
 
 	spin_unlock_bh(&local->active_txq_lock[ac]);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 7acf2223e47a..5ef1554f991f 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -138,7 +138,7 @@ enum ieee80211_agg_stop_reason {
 struct airtime_info {
 	u64 rx_airtime;
 	u64 tx_airtime;
-	u32 last_active;
+	unsigned long last_active;
 	s32 deficit;
 	atomic_t aql_tx_pending; /* Estimated airtime for frames pending */
 	u32 aql_limit_low;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ed4fdf655343..314998fdb1a5 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4013,14 +4013,13 @@ ieee80211_txq_set_active(struct txq_info *txqi)
 		return;
 
 	sta = container_of(txqi->txq.sta, struct sta_info, sta);
-	sta->airtime[txqi->txq.ac].last_active = (u32)jiffies;
+	sta->airtime[txqi->txq.ac].last_active = jiffies;
 }
 
 static bool
 ieee80211_txq_keep_active(struct txq_info *txqi)
 {
 	struct sta_info *sta;
-	u32 diff;
 
 	if (!txqi->txq.sta)
 		return false;
@@ -4029,9 +4028,7 @@ ieee80211_txq_keep_active(struct txq_info *txqi)
 	if (ieee80211_sta_deficit(sta, txqi->txq.ac) >= 0)
 		return false;
 
-	diff = (u32)jiffies - sta->airtime[txqi->txq.ac].last_active;
-
-	return diff <= AIRTIME_ACTIVE_DURATION;
+	return ieee80211_sta_keep_active(sta, txqi->txq.ac);
 }
 
 struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
-- 
2.43.0


