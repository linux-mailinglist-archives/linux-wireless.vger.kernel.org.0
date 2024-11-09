Return-Path: <linux-wireless+bounces-15154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FB9C2EA7
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Nov 2024 18:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B521F21834
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Nov 2024 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728EF19D09F;
	Sat,  9 Nov 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RwrgkLVu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9329CF4;
	Sat,  9 Nov 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731172489; cv=none; b=FhaZylJTiWt2GnrPdmRFzr2k8we8zqhg+J+OTcjNKDYi7zva9zHupcJoJ6kUXNBuGbH6hedyv73/aM5Y/4yEt2yYbCE7Y1fGR3/KdW+e/Hac6R6+GONz7CVNHQaabNqmmYaYydqXsRM7U0QXJUhlUyuSbfBdvTJ2FaCjLunUGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731172489; c=relaxed/simple;
	bh=Wovu9ih3C9MZuJYi2dEKzYwgUF/u3A0dDjfTualSQr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WcDBoL0NtWceC3dkY+wQBiYcrfDVUsvBx1bOvapsI+okbdSyyD74f1MMJmFQKCyPw7LBS43+bY82ldzfTz+Yv5VHcEevamgZR1g/6Wxx7+aFKHgAoAnRkbEpMuPQXMyfzs1S74vLBK/IT036BuC+FcEo6yLVW8GYWT+bCjUeT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RwrgkLVu; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id 208D740B228D;
	Sat,  9 Nov 2024 17:14:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 208D740B228D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731172476;
	bh=c64bpLISVYhDI/BFBOlnF+jAZmezzOvIjc4KEH14RZk=;
	h=From:To:Cc:Subject:Date:From;
	b=RwrgkLVuTIk87/taRBTl78awEZfjhoNG0/FzOkTNTwktkMqMmbZJtdBZSNbvDxZif
	 xD2F9S1fnvt6sq30CzpyAM9Zdz6JS+G8kayd5FWweSwG6CsEbgoY2R0Z2WRJxx+ex/
	 lR/MfHTz3+Bb8gN3NX5NsCyPhaVQVLlduR9oOzQ8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Johannes Berg <johannes@sipsolutions.net>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.6] Revert "wifi: mac80211: fix RCU list iterations"
Date: Sat,  9 Nov 2024 20:14:30 +0300
Message-Id: <20241109171430.1640793-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f37319609335d3eb2f7edfec4bad7996668a4d29 which is
commit ac35180032fbc5d80b29af00ba4881815ceefcb6 upstream.

The reverted commit is based heavily on wiphy locking changes made by the
"wifi: cfg80211/mac80211: locking cleanups" series [1] introduced since
6.7 kernel and not supposed to be backported to old stable branches.

It breaks locking rules in the context of old stables leading e.g. to the
following lockdep splat there - ieee80211_get_max_required_bw() is
actually called under RCU reader lock in 6.1/6.6, not the wiphy mutex.

WARNING: CPU: 3 PID: 8711 at net/mac80211/chan.c:248 ieee80211_get_max_required_bw+0x423/0x4e0 net/mac80211/chan.c:248
Modules linked in:
CPU: 3 PID: 8711 Comm: kworker/u8:6 Not tainted 6.1.113-syzkaller-00105-g9859ec205cfa #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Workqueue: phy155 ieee80211_iface_work
RIP: 0010:ieee80211_get_max_required_bw+0x423/0x4e0 net/mac80211/chan.c:248
Call Trace:
 <TASK>
 ieee80211_get_chanctx_vif_max_required_bw net/mac80211/chan.c:294 [inline]
 ieee80211_get_chanctx_max_required_bw net/mac80211/chan.c:336 [inline]
 _ieee80211_recalc_chanctx_min_def+0x5e6/0xf30 net/mac80211/chan.c:381
 ieee80211_recalc_chanctx_min_def+0x21/0x80 net/mac80211/chan.c:462
 ieee80211_recalc_min_chandef+0x17a/0x590 net/mac80211/util.c:2908
 sta_info_move_state+0x748/0x8c0 net/mac80211/sta_info.c:2301
 ieee80211_assoc_success net/mac80211/mlme.c:5001 [inline]
 ieee80211_rx_mgmt_assoc_resp.cold+0x1335/0x69ec net/mac80211/mlme.c:5201
 ieee80211_sta_rx_queued_mgmt+0x40f/0x2270 net/mac80211/mlme.c:5831
 ieee80211_iface_process_skb net/mac80211/iface.c:1665 [inline]
 ieee80211_iface_work+0xa31/0xd30 net/mac80211/iface.c:1722
 process_one_work+0xa72/0x1590 kernel/workqueue.c:2292
 worker_thread+0x632/0x1240 kernel/workqueue.c:2439
 kthread+0x2e1/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:295

[1]: https://lore.kernel.org/linux-wireless/20230828115927.116700-41-johannes@sipsolutions.net/

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/mac80211/chan.c | 4 +---
 net/mac80211/mlme.c | 2 +-
 net/mac80211/scan.c | 2 +-
 net/mac80211/util.c | 4 +---
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index c09aed6a3cfc..68952752b599 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -245,9 +245,7 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct sta_info *sta;
 
-	lockdep_assert_wiphy(sdata->local->hw.wiphy);
-
-	list_for_each_entry(sta, &sdata->local->sta_list, list) {
+	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
 		if (sdata != sta->sdata &&
 		    !(sta->sdata->bss && sta->sdata->bss == sdata->bss))
 			continue;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b14c809bcdea..42e2c84ed248 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -732,7 +732,7 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 		bool disable_mu_mimo = false;
 		struct ieee80211_sub_if_data *other;
 
-		list_for_each_entry(other, &local->interfaces, list) {
+		list_for_each_entry_rcu(other, &local->interfaces, list) {
 			if (other->vif.bss_conf.mu_mimo_owner) {
 				disable_mu_mimo = true;
 				break;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index d4a032f34577..1726e3221d3c 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -490,7 +490,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	 * the scan was in progress; if there was none this will
 	 * just be a no-op for the particular interface.
 	 */
-	list_for_each_entry(sdata, &local->interfaces, list) {
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (ieee80211_sdata_running(sdata))
 			wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 02b5aaad2a15..d682c32821a1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -745,9 +745,7 @@ static void __iterate_interfaces(struct ieee80211_local *local,
 	struct ieee80211_sub_if_data *sdata;
 	bool active_only = iter_flags & IEEE80211_IFACE_ITER_ACTIVE;
 
-	list_for_each_entry_rcu(sdata, &local->interfaces, list,
-				lockdep_is_held(&local->iflist_mtx) ||
-				lockdep_is_held(&local->hw.wiphy->mtx)) {
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_MONITOR:
 			if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
-- 
2.39.5


