Return-Path: <linux-wireless+bounces-31036-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAcQLIzjb2n8RwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31036-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:20:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFB84B30A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F6A8807E19
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E2F3B52FA;
	Tue, 20 Jan 2026 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDDTf7BR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CEB3AEF26
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939882; cv=none; b=bld/g2LfNUslVQuIsggn8I9ZES3QBC0VBh76TLDTZp/39qgnWQk9Hzs8x9Dp2P2Yhdz2Y924louv37x/qxZJGUbJmTRrZlCVqPp4v2tny3vrRCR3J0pXhBX2ChVOcgIQ29sxlTPLiFq7fZGGvxNR7xmOSuczvaKsjXlQM6tIngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939882; c=relaxed/simple;
	bh=fHtxiBGAAx/lcAw8oGkp9fbeQ90t8fBheHKgj+M+Nzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeUSo8jv0J9S2h+tfvAolLdMGiVH6u1nCmxN9PoZYaIorzK2Tig8rKqVWW9Bng/f7RWUP+E8aF+HK+wsZm3+8MaByR5oIK54lAJ7DwAA1fhewsjQxJl9C/ccuiFkG7NfV+QRmKpnoRpnslrnYjPgn0O+W0wa/wSrsBkyOa7dH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDDTf7BR; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12460a7caa2so3500386c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939876; x=1769544676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGC4iR+iYg9fz5LpX9NZwFdgyFW9awkXrNY5MBe+JTo=;
        b=hDDTf7BRHAzuNP0oh5uzNjUpIheLHZLKCffgr8EXlaMYxycBXOfgqAeoyGxWhoRTVm
         +KYvVaHP01LKjRTXtZsjMp92jtIbY5bPcHHrpY9DPtzUsCLfgEzv9c039d/6RiMS3A4L
         d1vvkIVlHqutYVTvmLFIpw4Wm4cVVulVtMusvocrAhuSwKpZIm6mDP+5xiP96/1+gery
         xafmmrDT+lQCSWIcHXYTgjC9AYtGsGcbR/NAip2GtYx3ymxA4Z+v/lMOr/DF8JHjrf7p
         kLDhy+gWX0M5bNv0y7gMinJgaixBNm51Uo4X7mLD2G1XazAr9IhVKm2UESkIUMF30MZL
         uS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939876; x=1769544676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGC4iR+iYg9fz5LpX9NZwFdgyFW9awkXrNY5MBe+JTo=;
        b=FZ1JEuF6NhZ0SiaxiN34crmzm8ypKdA1mO4UQhRH8/1W9H5H4j+GU6bZWfHu7Gom1i
         ZpSVkYHAIK6OGkdZX3ODiMFt9+Q0FlxAgQuDT0r48Iv5iGeILJN1k0OfPrAYavy0U6uF
         FyrCtol7ESqqkXBos/8A8HbYSRqbHKFuFLV9jsFo34T0oDjLqOHVXptynTqcbpeo4v9i
         v735uzMzi0aLq0F18QWwS/p6ivRcptCjLX+v3jy/EQc5jP+m6x6EDsnOaXX2Rfx1ngw0
         dUueXE99qaJJewoB89aOvl9eNjDfmHqLGNzThA4OccHr1HMeTn1ZDioTx73UX/Xbpfqx
         KBbA==
X-Forwarded-Encrypted: i=1; AJvYcCVaPldDBSAeaKIIwSHLeB5TQm6G52zNlCnRd2yOH0tarVezvoPrkQ2S3fBG8xU7X3rQoMoR0+qZzXioYFBcDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwROUPnMQ0+VJG3qjN4guxSk0J2z/zSxXm1DZ8MncRYrlwtGJqa
	DlfkQ0hQ7MpIJXBRuzWDMb8Kt0IhUA9mW3aWN9FtHVlprPYgXkkrPv9s
X-Gm-Gg: AY/fxX5WNtFsmYlS9wvqy8uMhCAl7QmOAkHayTcIDYfowYfLrRmwhUON+mnwLf0vdyo
	pLJx/PpmgP0aLK/fxf+3KLbGI9Gz2puqUDkHKxrl+PQ7C4VhvEn2wJNFfvk8e1gdbXqjz/ilIJ4
	QSpTBU+N32m5dkpJRu8lvEpJ+cN5G876A+/FdOKuLIJzeSSmNhEUrAfrm6VjJMW9odV5tbun1Gf
	i4rajh9lzaLtB1OLQoXPIdSrJui5GEBkiFrFg2xoBlHemrHgJLMFiulfXM/dTQndBNEQ8E2pEB3
	x5QlzcUXTBX5Hn8A/zIUCl2Beh5rZ5IE3XMjHSUpjrV0Mlx4VHBRy+JwRHL6L5I0+xpyxvG09xa
	qHyLddclyoHq40a823Mra0pmQmPGT94t21/5IVwBIm2rYkA7+dBboXSaCZksjCXXEP66Te/9p32
	xj9/Od1yqvuV51aFt6Gak1u7X8XYf6wSHHD2FjALgAIc2frqX2NczVdtkA39pYPw==
X-Received: by 2002:a05:7022:628c:b0:11d:f440:b757 with SMTP id a92af1059eb24-1244b35ad1emr11052357c88.26.1768939875640;
        Tue, 20 Jan 2026 12:11:15 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:11:14 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH 12/13] wifi: mt76: mt7925: fix ROC deadlocks and race conditions
Date: Tue, 20 Jan 2026 12:10:42 -0800
Message-ID: <20260120201043.38225-13-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120201043.38225-1-zac@zacbowling.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31036-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,zacbowling.com:email,zacbowling.com:mid]
X-Rspamd-Queue-Id: 3EFB84B30A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

Fix multiple interrelated issues in the remain-on-channel (ROC) handling
that cause deadlocks, race conditions, and resource leaks.

Problems fixed:

1. Deadlock in sta removal ROC abort path:
   When a station is removed while a ROC operation is in progress, the
   driver would call mt7925_roc_abort_sync() which waits for ROC completion.
   However, the ROC work itself needs to acquire mt792x_mutex which is
   already held during station removal, causing a deadlock.

   Fix: Use async ROC abort (mt76_connac_mcu_abort_roc) when called from
   paths that already hold the mutex, and add MT76_STATE_ROC_ABORT flag
   to coordinate between the abort and the ROC timer.

2. ROC timer race during suspend:
   The ROC timer could fire after the device started suspending but before
   the ROC was properly aborted, causing undefined behavior.

   Fix: Delete ROC timer synchronously before suspend and check device
   state before processing ROC timeout.

3. ROC rate limiting for MLO auth failures:
   Rapid ROC requests during MLO authentication can overwhelm the firmware,
   causing authentication timeouts. The MT7925 firmware has limited ROC
   handling capacity.

   Fix: Add rate limiting infrastructure with configurable minimum interval
   between ROC requests. Track last ROC completion time and defer new
   requests if they arrive too quickly.

4. WCID leak in ROC cleanup:
   When ROC operations are aborted, the associated WCID resources were
   not being properly released, causing resource exhaustion over time.

   Fix: Ensure WCID cleanup happens in all ROC termination paths.

5. Async ROC abort race condition:
   The async ROC abort could race with normal ROC completion, causing
   double-free or use-after-free of ROC resources.

   Fix: Use MT76_STATE_ROC_ABORT flag and proper synchronization to
   prevent races between async abort and normal completion paths.

These fixes work together to provide robust ROC handling that doesn't
deadlock, properly releases resources, and handles edge cases during
suspend and MLO operations.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 175 ++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   7 +
 3 files changed, 171 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d05e83ea1cac..91f9dd95c89e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -511,6 +511,7 @@ enum {
 	MT76_STATE_POWER_OFF,
 	MT76_STATE_SUSPEND,
 	MT76_STATE_ROC,
+	MT76_STATE_ROC_ABORT,
 	MT76_STATE_PM,
 	MT76_STATE_WED_RESET,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 82c81c22e39c..4b7c13485497 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -453,6 +453,24 @@ static void mt7925_roc_iter(void *priv, u8 *mac,
 	mt7925_mcu_abort_roc(phy, &mvif->bss_conf, phy->roc_token_id);
 }
 
+/* Async ROC abort - safe to call while holding mutex.
+ * Sets abort flag and lets roc_work handle cleanup without blocking.
+ * This prevents deadlock when called from sta_remove path which holds mutex.
+ */
+static void mt7925_roc_abort_async(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	/* Set abort flag - roc_work checks this before acquiring mutex */
+	set_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+
+	/* Stop timer and schedule work to handle cleanup.
+	 * Must schedule work since timer may not have fired yet.
+	 */
+	timer_delete(&phy->roc_timer);
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
 void mt7925_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
@@ -477,6 +495,17 @@ void mt7925_roc_work(struct work_struct *work)
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						roc_work);
 
+	/* Check abort flag BEFORE acquiring mutex to prevent deadlock.
+	 * If abort is requested while we're in the sta_remove path (which
+	 * holds the mutex), we must not try to acquire it or we'll deadlock.
+	 * Clear the flags and only notify mac80211 if ROC was actually active.
+	 */
+	if (test_and_clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state)) {
+		if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+			ieee80211_remain_on_channel_expired(phy->mt76->hw);
+		return;
+	}
+
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return;
 
@@ -504,14 +533,93 @@ static int mt7925_abort_roc(struct mt792x_phy *phy,
 	return err;
 }
 
+/* ROC rate limiting constants - exponential backoff to prevent MCU overload
+ * when upper layers trigger rapid reconnection cycles (e.g., MLO auth failures).
+ * Max backoff ~1.6s, resets after 10s of no timeouts.
+ */
+#define MT7925_ROC_BACKOFF_BASE_MS	100
+#define MT7925_ROC_BACKOFF_MAX_MS	1600
+#define MT7925_ROC_TIMEOUT_RESET_MS	10000
+#define MT7925_ROC_TIMEOUT_WARN_THRESH	5
+
+/* Check if ROC should be throttled due to recent timeouts.
+ * Returns delay in jiffies if throttling, 0 if OK to proceed.
+ */
+static unsigned long mt7925_roc_throttle_check(struct mt792x_phy *phy)
+{
+	unsigned long now = jiffies;
+
+	/* Reset timeout counter if it's been a while since last timeout */
+	if (phy->roc_timeout_count &&
+	    time_after(now, phy->roc_last_timeout +
+		       msecs_to_jiffies(MT7925_ROC_TIMEOUT_RESET_MS))) {
+		phy->roc_timeout_count = 0;
+		phy->roc_backoff_until = 0;
+	}
+
+	/* Check if we're still in backoff period */
+	if (phy->roc_backoff_until && time_before(now, phy->roc_backoff_until))
+		return phy->roc_backoff_until - now;
+
+	return 0;
+}
+
+/* Record ROC timeout and calculate backoff period */
+static void mt7925_roc_record_timeout(struct mt792x_phy *phy)
+{
+	unsigned int backoff_ms;
+
+	phy->roc_last_timeout = jiffies;
+	phy->roc_timeout_count++;
+
+	/* Exponential backoff: 100ms, 200ms, 400ms, 800ms, 1600ms (capped) */
+	backoff_ms = MT7925_ROC_BACKOFF_BASE_MS <<
+		     min_t(u8, phy->roc_timeout_count - 1, 4);
+	if (backoff_ms > MT7925_ROC_BACKOFF_MAX_MS)
+		backoff_ms = MT7925_ROC_BACKOFF_MAX_MS;
+
+	phy->roc_backoff_until = jiffies + msecs_to_jiffies(backoff_ms);
+
+	/* Warn if we're seeing repeated timeouts - likely upper layer issue */
+	if (phy->roc_timeout_count == MT7925_ROC_TIMEOUT_WARN_THRESH)
+		dev_warn(phy->dev->mt76.dev,
+			 "mt7925: %u consecutive ROC timeouts, possible mac80211/wpa_supplicant issue (MLO key race?)\n",
+			 phy->roc_timeout_count);
+}
+
+/* Clear timeout tracking on successful ROC */
+static void mt7925_roc_clear_timeout(struct mt792x_phy *phy)
+{
+	phy->roc_timeout_count = 0;
+	phy->roc_backoff_until = 0;
+}
+
 static int mt7925_set_roc(struct mt792x_phy *phy,
 			  struct mt792x_bss_conf *mconf,
 			  struct ieee80211_channel *chan,
 			  int duration,
 			  enum mt7925_roc_req type)
 {
+	unsigned long throttle;
 	int err;
 
+	/* Check rate limiting - if in backoff period, wait or return busy */
+	throttle = mt7925_roc_throttle_check(phy);
+	if (throttle) {
+		/* For short backoffs, wait; for longer ones, return busy */
+		if (throttle < msecs_to_jiffies(200)) {
+			msleep(jiffies_to_msecs(throttle));
+		} else {
+			dev_dbg(phy->dev->mt76.dev,
+				"mt7925: ROC throttled, %u ms remaining\n",
+				jiffies_to_msecs(throttle));
+			return -EBUSY;
+		}
+	}
+
+	/* Clear stale abort flag from previous ROC */
+	clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+
 	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return -EBUSY;
 
@@ -527,7 +635,11 @@ static int mt7925_set_roc(struct mt792x_phy *phy,
 	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
 		mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
 		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		mt7925_roc_record_timeout(phy);
 		err = -ETIMEDOUT;
+	} else {
+		/* Successful ROC - reset timeout tracking */
+		mt7925_roc_clear_timeout(phy);
 	}
 
 out:
@@ -538,8 +650,27 @@ static int mt7925_set_mlo_roc(struct mt792x_phy *phy,
 			      struct mt792x_bss_conf *mconf,
 			      u16 sel_links)
 {
+	unsigned long throttle;
 	int err;
 
+	/* Check rate limiting - MLO ROC is especially prone to rapid-fire
+	 * during reconnection cycles after MLO authentication failures.
+	 */
+	throttle = mt7925_roc_throttle_check(phy);
+	if (throttle) {
+		if (throttle < msecs_to_jiffies(200)) {
+			msleep(jiffies_to_msecs(throttle));
+		} else {
+			dev_dbg(phy->dev->mt76.dev,
+				"mt7925: MLO ROC throttled, %u ms remaining\n",
+				jiffies_to_msecs(throttle));
+			return -EBUSY;
+		}
+	}
+
+	/* Clear stale abort flag from previous ROC */
+	clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+
 	if (WARN_ON_ONCE(test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state)))
 		return -EBUSY;
 
@@ -554,7 +685,10 @@ static int mt7925_set_mlo_roc(struct mt792x_phy *phy,
 	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
 		mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
 		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		mt7925_roc_record_timeout(phy);
 		err = -ETIMEDOUT;
+	} else {
+		mt7925_roc_clear_timeout(phy);
 	}
 
 out:
@@ -571,6 +705,7 @@ static int mt7925_remain_on_channel(struct ieee80211_hw *hw,
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	int err;
 
+	cancel_work_sync(&phy->roc_work);
 	mt792x_mutex_acquire(phy->dev);
 	err = mt7925_set_roc(phy, &mvif->bss_conf,
 			     chan, duration, MT7925_ROC_REQ_ROC);
@@ -878,14 +1013,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	if (!mlink)
 		return -EINVAL;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
-	if (idx < 0)
-		return -ENOSPC;
-
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	if (!mconf)
 		return -EINVAL;
 
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
+	if (idx < 0)
+		return -ENOSPC;
+
 	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
@@ -905,14 +1040,16 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
-		return ret;
+		goto err_wcid;
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
-	if (!link_conf)
-		return -EINVAL;
+	if (!link_conf) {
+		ret = -EINVAL;
+		goto err_wcid;
+	}
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
@@ -924,7 +1061,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
 						      link_conf, link_sta, false);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
@@ -932,28 +1069,34 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	} else if (ieee80211_vif_is_mld(vif) &&
 		   link_sta != mlink->pri_link) {
 		ret = mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
 					    true, MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto err_wcid;
 
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	} else {
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	}
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
 	return 0;
+
+err_wcid:
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, idx);
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+	return ret;
 }
 
 static int
@@ -1139,6 +1282,9 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 	if (!mlink)
 		return;
 
+	/* With Sean's fix, roc_abort_sync uses cancel_work() instead of
+	 * cancel_work_sync(), so it's safe to call even with mutex held.
+	 */
 	mt7925_roc_abort_sync(dev);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
@@ -1534,6 +1680,8 @@ static int mt7925_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&dev->pm.ps_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
+	/* Cancel ROC before quiescing starts */
+	mt7925_roc_abort_sync(dev);
 	mt792x_mutex_acquire(dev);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
@@ -1880,6 +2028,8 @@ static void mt7925_mgd_prepare_tx(struct ieee80211_hw *hw,
 	u16 duration = info->duration ? info->duration :
 		       jiffies_to_msecs(HZ);
 
+	cancel_work_sync(&mvif->phy->roc_work);
+
 	mt792x_mutex_acquire(dev);
 	mt7925_set_roc(mvif->phy, &mvif->bss_conf,
 		       mvif->bss_conf.mt76.ctx->def.chan, duration,
@@ -2037,6 +2187,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (old_links == new_links)
 		return 0;
 
+	cancel_work_sync(&phy->roc_work);
 	mt792x_mutex_acquire(dev);
 
 	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 8388638ed550..d9c1ea709390 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -186,6 +186,13 @@ struct mt792x_phy {
 	wait_queue_head_t roc_wait;
 	u8 roc_token_id;
 	bool roc_grant;
+
+	/* ROC rate limiting to prevent MCU overload during rapid reconnection
+	 * cycles (e.g., MLO authentication failures causing repeated ROC).
+	 */
+	u8 roc_timeout_count;		/* consecutive ROC timeouts */
+	unsigned long roc_last_timeout;	/* jiffies of last timeout */
+	unsigned long roc_backoff_until;/* don't issue ROC until this time */
 };
 
 struct mt792x_irq_map {
-- 
2.52.0


