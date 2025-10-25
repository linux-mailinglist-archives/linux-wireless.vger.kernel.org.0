Return-Path: <linux-wireless+bounces-28267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B23C09C9E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 832A0565A6B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6A930FC0C;
	Sat, 25 Oct 2025 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhYQ2WOT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B72304BD8;
	Sat, 25 Oct 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409674; cv=none; b=AV91qIqAM92n4H+FlV0NhLCqKNp8LAZ1pdz4+i/W6QiTPm1rk4zcbsdw0Wcc9qDfDC5VwRFXkQ+smBEDkqVg2oBE8UycPLWPyQ1t4sxZ7k2vYXdphPJtzujA2zIiFLsJK9an4jVqEQH/6EZg9rdI1gHpyaW6RApQaLViHakjqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409674; c=relaxed/simple;
	bh=aP3V15lk+TbrRjFG+Wj9Cb4LCF+DIpiIR3kSIbcNLHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkTrWhFq2kP/QT4rgh6F4XbS1PWdqP3eH6hom2N7jd8w6gYhTyfWYsOdOdtmCOmaT73gfH8rNJm9Bh5CJ9IN8ALkV6XJGeToV7egK+w8qeNunXd8gtIt9py60bovw2eAENpK71Pke7/BVHopz8DP9EeJygGUvUSeHCAt8vQvGy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhYQ2WOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814AFC113D0;
	Sat, 25 Oct 2025 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409673;
	bh=aP3V15lk+TbrRjFG+Wj9Cb4LCF+DIpiIR3kSIbcNLHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhYQ2WOTKV+K53s4+isUuo9BPyWsFu7y7O35U3jfDMmMiOMxBp9MboCxiJYb34tAR
	 PGkPz3xoaES3RDesknsvTwvj4nY2J+wvdqJpdjtKZpfDzTG2lCj7CnrylgcIGFgmbN
	 qFvSqALf+hdvG3tq62GXOLtnESPFXXGoB0l3+p1z2bO2cnUKpOz/Kh489RS4Ix2weB
	 55XOtKaE65FPa040Yq35dkFvzb4GmAwuf+Yn7ZXsgT0h1XKD037o4GrCg+HM6Ng/tI
	 uqD9PLZQKAdX1pL44lVJC0yJvWtZmQFwuEorDohhV/q/xOQVL9oYElN4AG8R1y0W3G
	 YRf4RPm98ny2A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] wifi: mac80211: Track NAN interface start/stop
Date: Sat, 25 Oct 2025 12:00:46 -0400
Message-ID: <20251025160905.3857885-415-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 8f79d2f13dd3b0af00a5303d4ff913767dd7684e ]

In case that NAN is started, mark the device as non idle,
and set LED triggering similar to scan and ROC. Set the
device to idle once NAN is stopped.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250908140015.2711d62fce22.I9b9f826490e50967a66788d713b0eba985879873@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `ieee80211_start_nan()` now flips a dedicated `started` flag and
  immediately calls `ieee80211_recalc_idle()` once NAN activation
  succeeds (`net/mac80211/cfg.c:323-345`). Without this, the hw stays
  flagged idle (`IEEE80211_CONF_IDLE`) after mac80211 opens the
  interface, so drivers may power down the radio and NAN
  discovery/advertisement stops working despite reporting success. The
  new `-EALREADY` guard also prevents double starts that would otherwise
  re-run the driver callback on an already-open interface.
- `ieee80211_stop_nan()` symmetrically checks the flag, calls the driver
  stop hook, clears `started`, and recalculates idle
  (`net/mac80211/cfg.c:349-360`). This guarantees the device returns to
  idle only after NAN really terminates, fixing the stale “busy”/LED
  state left behind today.
- `__ieee80211_recalc_idle()` now marks the device “working” whenever
  any interface of type `NL80211_IFTYPE_NAN` is flagged as started
  (`net/mac80211/iface.c:105-146`). This ties NAN activity into the
  existing idle/LED machinery instead of relying on ROC/scan
  bookkeeping, which never covered NAN and is why the hw incorrectly
  entered idle before this change.
- A new `bool started` in `struct ieee80211_if_nan`
  (`net/mac80211/ieee80211_i.h:985-999`) is the only state carried
  across, fits the existing zero-initialized lifetime of `sdata->u.nan`,
  and does not affect other interface types sharing the union. The rest
  of the logic and cfg80211 NAN APIs stay untouched, so drivers see no
  interface changes.

The regression being fixed is user-visible (NAN sessions silently stall
because hw is left in idle), the patch is small and self-contained in
mac80211, and the new state bit is initialized automatically. No
architectural churn or external dependencies are introduced, making this
a low-risk, high-value candidate for stable backporting.

 net/mac80211/cfg.c         | 20 +++++++++++++++++---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/iface.c       |  9 +++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7609c7c31df74..42539c3b4f282 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -320,6 +320,9 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
+	if (sdata->u.nan.started)
+		return -EALREADY;
+
 	ret = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
 	if (ret < 0)
 		return ret;
@@ -329,12 +332,18 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
 		return ret;
 
 	ret = drv_start_nan(sdata->local, sdata, conf);
-	if (ret)
+	if (ret) {
 		ieee80211_sdata_stop(sdata);
+		return ret;
+	}
 
-	sdata->u.nan.conf = *conf;
+	sdata->u.nan.started = true;
+	ieee80211_recalc_idle(sdata->local);
 
-	return ret;
+	sdata->u.nan.conf.master_pref = conf->master_pref;
+	sdata->u.nan.conf.bands = conf->bands;
+
+	return 0;
 }
 
 static void ieee80211_stop_nan(struct wiphy *wiphy,
@@ -342,8 +351,13 @@ static void ieee80211_stop_nan(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
+	if (!sdata->u.nan.started)
+		return;
+
 	drv_stop_nan(sdata->local, sdata);
+	sdata->u.nan.started = false;
 	ieee80211_sdata_stop(sdata);
+	ieee80211_recalc_idle(sdata->local);
 }
 
 static int ieee80211_nan_change_conf(struct wiphy *wiphy,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 140dc7e32d4aa..7d1e93f51a67b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -977,11 +977,13 @@ struct ieee80211_if_mntr {
  * struct ieee80211_if_nan - NAN state
  *
  * @conf: current NAN configuration
+ * @started: true iff NAN is started
  * @func_lock: lock for @func_inst_ids
  * @function_inst_ids: a bitmap of available instance_id's
  */
 struct ieee80211_if_nan {
 	struct cfg80211_nan_conf conf;
+	bool started;
 
 	/* protects function_inst_ids */
 	spinlock_t func_lock;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index abc8cca54f4e1..a7873832d4fa6 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -107,6 +107,7 @@ static u32 __ieee80211_recalc_idle(struct ieee80211_local *local,
 {
 	bool working, scanning, active;
 	unsigned int led_trig_start = 0, led_trig_stop = 0;
+	struct ieee80211_sub_if_data *iter;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -117,6 +118,14 @@ static u32 __ieee80211_recalc_idle(struct ieee80211_local *local,
 	working = !local->ops->remain_on_channel &&
 		  !list_empty(&local->roc_list);
 
+	list_for_each_entry(iter, &local->interfaces, list) {
+		if (iter->vif.type == NL80211_IFTYPE_NAN &&
+		    iter->u.nan.started) {
+			working = true;
+			break;
+		}
+	}
+
 	scanning = test_bit(SCAN_SW_SCANNING, &local->scanning) ||
 		   test_bit(SCAN_ONCHANNEL_SCANNING, &local->scanning);
 
-- 
2.51.0


