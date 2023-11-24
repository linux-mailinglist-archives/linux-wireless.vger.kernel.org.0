Return-Path: <linux-wireless+bounces-57-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966D7F7917
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 17:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BBD28144B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2445364AF;
	Fri, 24 Nov 2023 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hui6ohvg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB719AA;
	Fri, 24 Nov 2023 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/IUf3uo2oD/a+xS0yZzjtqpayIwTZ7+Ecxpk1N2XlRA=;
	t=1700843721; x=1702053321; b=Hui6ohvg9kGiiEXql0YQ1U+qOGmEdE5cVpHBLFOapXGTRZ5
	NX5qnKNgs/mo9r5DRavTUsNoOiN+xk3JsFN559kos522SgWpZmdQNxMT7jyl/A1CeZ83P/YU4aBAy
	1NTVJBKIK3GTdF+cWbxeWQKD4ShD9mmB09vp2JuoHxafiIYNrVE840gTDMMwZBZbCLvl1Yp7yRBNI
	AJX6BI5zPsEK/+OYEkCWTfLz7XdTmv0dudXEuNeO7XRWKBjzacLiDeXn/AZSLAKJcekA8Ta6IPGKn
	jh18REJafmqu+Fo4NkLrzHNWrtE3vfsGHUzGzDDOYu5Vl2UheNjeWJiW4UMDUpxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6Z9C-00000002fA8-32NO;
	Fri, 24 Nov 2023 17:35:18 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 5/6] wifi: mac80211: use wiphy locked debugfs helpers for agg_status
Date: Fri, 24 Nov 2023 17:25:28 +0100
Message-ID: <20231124172522.a5e8901f9976.Id4251db174cdd42519a5ef19cbb08d7ed8f65397@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124162522.16344-7-johannes@sipsolutions.net>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The read is currently with RCU and the write can deadlock,
convert both for the sake of illustration.

Make mac80211 depend on cfg80211 debugfs to get the helpers,
but mac80211 debugfs without it does nothing anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - make mac80211 debugfs depend on cfg80211 debugfs, it's
   anyway useless without it
---
 net/mac80211/Kconfig       |  2 +-
 net/mac80211/debugfs_sta.c | 74 +++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 037ab74f5ade..cb0291decf2e 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -88,7 +88,7 @@ config MAC80211_LEDS
 
 config MAC80211_DEBUGFS
 	bool "Export mac80211 internals in DebugFS"
-	depends on MAC80211 && DEBUG_FS
+	depends on MAC80211 && CFG80211_DEBUGFS
 	help
 	  Select this to see extensive information about
 	  the internal state of mac80211 in debugfs.
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 06e3613bf46b..5bf507ebb096 100644
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
@@ -420,7 +419,6 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 	if (ret || tid >= IEEE80211_NUM_TIDS)
 		return -EINVAL;
 
-	wiphy_lock(sta->local->hw.wiphy);
 	if (tx) {
 		if (start)
 			ret = ieee80211_start_tx_ba_session(&sta->sta, tid,
@@ -432,10 +430,22 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 					       3, true);
 		ret = 0;
 	}
-	wiphy_unlock(sta->local->hw.wiphy);
 
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


