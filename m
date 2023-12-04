Return-Path: <linux-wireless+bounces-396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E42803F88
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332271C20B0B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733E364A3;
	Mon,  4 Dec 2023 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWI/33du"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F42381BE;
	Mon,  4 Dec 2023 20:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8650C433CA;
	Mon,  4 Dec 2023 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722041;
	bh=FOc64t4fHgyxWdvlmn76q3awa0mlBnxcSi6kZ/i+JeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWI/33duNEFve0372E7MowYy/6MhzGHvi6XiY0Z4pm9OrkPa17JRNdrrYzpk5Cs6P
	 4dKpkM9PMWlhCsiwk2lw12+/zJKK4x2aNnfQsDV3FQp8EMQE8vIISlEa+ZKCK9X/GI
	 aice+/TY+HFh7sziaaqaTCrWhyLhm/8I+xVEUvEKbjyyDYZSortBbZgLXBoD4aZswL
	 0TwU/xqBgkj0dgCihboveA9PiNphdPEE2uVO1dUlsNXHynXEosL9xHsX4HxECgn08W
	 1rpJpL5gdwD143YtycKi54dOACqnjJ0WntZIMrIft3fIN2RjxddlP4whimnFlSDhB6
	 9fJr9zfYDIcaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	toke@toke.dk,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/32] wifi: mac80211: use wiphy locked debugfs helpers for agg_status
Date: Mon,  4 Dec 2023 15:32:38 -0500
Message-ID: <20231204203317.2092321-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 3d529cd11f2b6c1c3b8e084269152eb30fbb96f5 ]

The read is currently with RCU and the write can deadlock,
convert both for the sake of illustration.

Make mac80211 depend on cfg80211 debugfs to get the helpers,
but mac80211 debugfs without it does nothing anyway. This
also required some adjustments in ath9k.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/Kconfig |  4 +-
 net/mac80211/Kconfig                   |  2 +-
 net/mac80211/debugfs_sta.c             | 72 +++++++++++++++-----------
 3 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/Kconfig b/drivers/net/wireless/ath/ath9k/Kconfig
index e150d82eddb6c..0c47be06c153b 100644
--- a/drivers/net/wireless/ath/ath9k/Kconfig
+++ b/drivers/net/wireless/ath/ath9k/Kconfig
@@ -57,8 +57,7 @@ config ATH9K_AHB
 
 config ATH9K_DEBUGFS
 	bool "Atheros ath9k debugging"
-	depends on ATH9K && DEBUG_FS
-	select MAC80211_DEBUGFS
+	depends on ATH9K && DEBUG_FS && MAC80211_DEBUGFS
 	select ATH9K_COMMON_DEBUG
 	help
 	  Say Y, if you need access to ath9k's statistics for
@@ -70,7 +69,6 @@ config ATH9K_DEBUGFS
 config ATH9K_STATION_STATISTICS
 	bool "Detailed station statistics"
 	depends on ATH9K && ATH9K_DEBUGFS && DEBUG_FS
-	select MAC80211_DEBUGFS
 	default n
 	help
 	  This option enables detailed statistics for association stations.
diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 51ec8256b7fa9..c90e87b9073b1 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -77,7 +77,7 @@ config MAC80211_LEDS
 
 config MAC80211_DEBUGFS
 	bool "Export mac80211 internals in DebugFS"
-	depends on MAC80211 && DEBUG_FS
+	depends on MAC80211 && CFG80211_DEBUGFS
 	help
 	  Select this to see extensive information about
 	  the internal state of mac80211 in debugfs.
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 5a97fb248c85c..da1d16fb9632b 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -312,23 +312,14 @@ static ssize_t sta_aql_write(struct file *file, const char __user *userbuf,
 STA_OPS_RW(aql);
 
 
-static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
-					size_t count, loff_t *ppos)
+static ssize_t sta_agg_status_do_read(struct wiphy *wiphy, struct file *file,
+				      char *buf, size_t bufsz, void *data)
 {
-	char *buf, *p;
-	ssize_t bufsz = 71 + IEEE80211_NUM_TIDS * 40;
+	struct sta_info *sta = data;
+	char *p = buf;
 	int i;
-	struct sta_info *sta = file->private_data;
 	struct tid_ampdu_rx *tid_rx;
 	struct tid_ampdu_tx *tid_tx;
-	ssize_t ret;
-
-	buf = kzalloc(bufsz, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	p = buf;
-
-	rcu_read_lock();
 
 	p += scnprintf(p, bufsz + buf - p, "next dialog_token: %#02x\n",
 			sta->ampdu_mlme.dialog_token_allocator + 1);
@@ -338,8 +329,8 @@ static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
 		bool tid_rx_valid;
 
-		tid_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[i]);
-		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[i]);
+		tid_rx = wiphy_dereference(wiphy, sta->ampdu_mlme.tid_rx[i]);
+		tid_tx = wiphy_dereference(wiphy, sta->ampdu_mlme.tid_tx[i]);
 		tid_rx_valid = test_bit(i, sta->ampdu_mlme.agg_session_valid);
 
 		p += scnprintf(p, bufsz + buf - p, "%02d", i);
@@ -358,31 +349,39 @@ static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 				tid_tx ? skb_queue_len(&tid_tx->pending) : 0);
 		p += scnprintf(p, bufsz + buf - p, "\n");
 	}
-	rcu_read_unlock();
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	return p - buf;
+}
+
+static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
+				   size_t count, loff_t *ppos)
+{
+	struct sta_info *sta = file->private_data;
+	struct wiphy *wiphy = sta->local->hw.wiphy;
+	size_t bufsz = 71 + IEEE80211_NUM_TIDS * 40;
+	char *buf = kmalloc(bufsz, GFP_KERNEL);
+	ssize_t ret;
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = wiphy_locked_debugfs_read(wiphy, file, buf, bufsz,
+					userbuf, count, ppos,
+					sta_agg_status_do_read, sta);
 	kfree(buf);
+
 	return ret;
 }
 
-static ssize_t sta_agg_status_write(struct file *file, const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t sta_agg_status_do_write(struct wiphy *wiphy, struct file *file,
+				       char *buf, size_t count, void *data)
 {
-	char _buf[25] = {}, *buf = _buf;
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = data;
 	bool start, tx;
 	unsigned long tid;
-	char *pos;
+	char *pos = buf;
 	int ret, timeout = 5000;
 
-	if (count > sizeof(_buf))
-		return -EINVAL;
-
-	if (copy_from_user(buf, userbuf, count))
-		return -EFAULT;
-
-	buf[sizeof(_buf) - 1] = '\0';
-	pos = buf;
 	buf = strsep(&pos, " ");
 	if (!buf)
 		return -EINVAL;
@@ -434,6 +433,19 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 
 	return ret ?: count;
 }
+
+static ssize_t sta_agg_status_write(struct file *file,
+				    const char __user *userbuf,
+				    size_t count, loff_t *ppos)
+{
+	struct sta_info *sta = file->private_data;
+	struct wiphy *wiphy = sta->local->hw.wiphy;
+	char _buf[26];
+
+	return wiphy_locked_debugfs_write(wiphy, file, _buf, sizeof(_buf),
+					  userbuf, count,
+					  sta_agg_status_do_write, sta);
+}
 STA_OPS_RW(agg_status);
 
 /* link sta attributes */
-- 
2.42.0


