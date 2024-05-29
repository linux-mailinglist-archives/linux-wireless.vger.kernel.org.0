Return-Path: <linux-wireless+bounces-8256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F08D2DB1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9225DB22EE9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6DF1607A0;
	Wed, 29 May 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="lu11T4Yo";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="UN7acJL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i84.smtp2go.com (e3i84.smtp2go.com [158.120.84.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0FDDC3
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965830; cv=none; b=HvzcFRMvB2hAmdEoeYsQpU+cxBTUnSnjY8QN5NLbT5Mcod5gF25URnWNTA3SCsRJjgnMYV/5JjfFyl7oeeqEtDwYI2sN/1Yf/gGrtRb8txkn+UcO2UrtF0KLKQpWmuYiDKXBmqG/lszCxPPhbZSYY60VkQwYDF7HPQOAJUuI6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965830; c=relaxed/simple;
	bh=bOeSZdmBwsNitFB+etEOBIX7vNxYqj75SIjFwIErgSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DzXJr2zqdMqsBbXVTUNfhMzCJHZn4z0KDc9bEQOWrwMGaYtwCDJ9rxwM6B/Dtab83Ooawzrz6507y6NXWlH3uBoKVuiN+/3yNzMXRAOgN8gPyQmVcC4YNXADSa9p1W3dgV+1lAtFM6oaA5Cfu7V1gsqW6wtVlIS8yDoZukxt3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=lu11T4Yo; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=UN7acJL1; arc=none smtp.client-ip=158.120.84.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1sCDEk-4o5NDgrmVFt-pPXg;
	Wed, 29 May 2024 06:56:38 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()
Date: Wed, 29 May 2024 08:57:53 +0200
Message-Id: <8e36fe07d0fbc146f89196cd47a53c8a0afe84aa.1716910344.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s_HaTRL7zn
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-smtpcorp-track: zczgVMNRLEXB.a3mgoNjOcXsR.1HHtNA9qvUX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1716965816; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=UbyaOHOiUST4mImhXXu+03xsYYW4FuYClhsIqgPQ0Bw=;
 b=lu11T4YoBLQ1rgSe+x4QkBBbxq42V1vs+DlGY5CDfE3GpK6PpMVPdbeA47iJNg925o21e
 1D+b2iYjmnhD79MOmGB9ux9okA4DjW9LCA54ZfZnz6pKuYENa4AOVjya2/ePgo+Ee93JWdK
 1OAaqrxkPrBAYb59OSc1sL9eJQphspKk9YmNCNldF9FYbX8m/n5gZI25d4D2Bn6byT8oHWW
 XkqUcOcMTqCgqN7Dzzi6SSElinbtYvyMcRvWepPpIlrYYPnCzQuTrU6mgBuwWko28drZLfO
 5T7UBHJiXiPXEKpDuJvcv/eZB43XpQBjA+hxn/KhIgtiY7guqB6Mn6IsGBhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1716965816; h=from : subject
 : to : message-id : date;
 bh=UbyaOHOiUST4mImhXXu+03xsYYW4FuYClhsIqgPQ0Bw=;
 b=UN7acJL1QS4N+D8VFsFod3lHOY2OSWU5lXQf7oVcZBlqT0rcst4wu8/g/ZPfMDs9L+a/E
 5HZ4oybQTRyy35GuyOzQisAuE4SAAnBJedkHWNk6AvAgUEzrCwQe793f+WIVQkWggvUvjve
 CTzOrapydbyIKkTusoohEyHjOLtOVZ+60lLEflMWj6bm+B/NQzxKtuPBF22NLcGZ5snznad
 4geTsPPNo09z+M3ItkltTH+9mvXzBQI/ExXaPU+FoIjq9Dq/y6S6Tms5z5gvyBks7GFv061
 1OxLPh7T/logNlfiYSMRyKDWdjz/rzqYib/bb47mUCBRfx7QoHcU+MuoxmqQ==

The ieee80211_sta_ps_deliver_wakeup() function takes sta->ps_lock to
synchronizes with ieee80211_tx_h_unicast_ps_buf() which is called from
softirq context. However using only spin_lock() to get sta->ps_lock in
ieee80211_sta_ps_deliver_wakeup() does not prevent softirq to execute
on this same CPU, to run ieee80211_tx_h_unicast_ps_buf() and try to
take this same lock ending in deadlock. Below is an example of rcu stall
that arises in such situation.

 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:    2-....: (42413413 ticks this GP) idle=b154/1/0x4000000000000000 softirq=1763/1765 fqs=21206996
 rcu:    (t=42586894 jiffies g=2057 q=362405 ncpus=4)
 CPU: 2 PID: 719 Comm: wpa_supplicant Tainted: G        W          6.4.0-02158-g1b062f552873 #742
 Hardware name: RPT (r1) (DT)
 pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : queued_spin_lock_slowpath+0x58/0x2d0
 lr : invoke_tx_handlers_early+0x5b4/0x5c0
 sp : ffff00001ef64660
 x29: ffff00001ef64660 x28: ffff000009bc1070 x27: ffff000009bc0ad8
 x26: ffff000009bc0900 x25: ffff00001ef647a8 x24: 0000000000000000
 x23: ffff000009bc0900 x22: ffff000009bc0900 x21: ffff00000ac0e000
 x20: ffff00000a279e00 x19: ffff00001ef646e8 x18: 0000000000000000
 x17: ffff800016468000 x16: ffff00001ef608c0 x15: 0010533c93f64f80
 x14: 0010395c9faa3946 x13: 0000000000000000 x12: 00000000fa83b2da
 x11: 000000012edeceea x10: ffff0000010fbe00 x9 : 0000000000895440
 x8 : 000000000010533c x7 : ffff00000ad8b740 x6 : ffff00000c350880
 x5 : 0000000000000007 x4 : 0000000000000001 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffff00000ac0e0e8
 Call trace:
  queued_spin_lock_slowpath+0x58/0x2d0
  ieee80211_tx+0x80/0x12c
  ieee80211_tx_pending+0x110/0x278
  tasklet_action_common.constprop.0+0x10c/0x144
  tasklet_action+0x20/0x28
  _stext+0x11c/0x284
  ____do_softirq+0xc/0x14
  call_on_irq_stack+0x24/0x34
  do_softirq_own_stack+0x18/0x20
  do_softirq+0x74/0x7c
  __local_bh_enable_ip+0xa0/0xa4
  _ieee80211_wake_txqs+0x3b0/0x4b8
  __ieee80211_wake_queue+0x12c/0x168
  ieee80211_add_pending_skbs+0xec/0x138
  ieee80211_sta_ps_deliver_wakeup+0x2a4/0x480
  ieee80211_mps_sta_status_update.part.0+0xd8/0x11c
  ieee80211_mps_sta_status_update+0x18/0x24
  sta_apply_parameters+0x3bc/0x4c0
  ieee80211_change_station+0x1b8/0x2dc
  nl80211_set_station+0x444/0x49c
  genl_family_rcv_msg_doit.isra.0+0xa4/0xfc
  genl_rcv_msg+0x1b0/0x244
  netlink_rcv_skb+0x38/0x10c
  genl_rcv+0x34/0x48
  netlink_unicast+0x254/0x2bc
  netlink_sendmsg+0x190/0x3b4
  ____sys_sendmsg+0x1e8/0x218
  ___sys_sendmsg+0x68/0x8c
  __sys_sendmsg+0x44/0x84
  __arm64_sys_sendmsg+0x20/0x28
  do_el0_svc+0x6c/0xe8
  el0_svc+0x14/0x48
  el0t_64_sync_handler+0xb0/0xb4
  el0t_64_sync+0x14c/0x150

Using spin_lock_bh()/spin_unlock_bh() instead prevents softirq to raise
on the same CPU that is holding the lock.

Fixes: 1d147bfa6429 ("mac80211: fix AP powersave TX vs. wakeup race")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/sta_info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index da5fdd6f5c85..aa22f09e6d14 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1724,7 +1724,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	skb_queue_head_init(&pending);
 
 	/* sync with ieee80211_tx_h_unicast_ps_buf */
-	spin_lock(&sta->ps_lock);
+	spin_lock_bh(&sta->ps_lock);
 	/* Send all buffered frames to the station */
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		int count = skb_queue_len(&pending), tmp;
@@ -1753,7 +1753,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
 	 */
 	clear_sta_flag(sta, WLAN_STA_PSPOLL);
 	clear_sta_flag(sta, WLAN_STA_UAPSD);
-	spin_unlock(&sta->ps_lock);
+	spin_unlock_bh(&sta->ps_lock);
 
 	atomic_dec(&ps->num_sta_ps);
 
-- 
2.40.0


