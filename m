Return-Path: <linux-wireless+bounces-9176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48390CCF8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1A1281DD3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68D1A256D;
	Tue, 18 Jun 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSAzaS6U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E61A256A;
	Tue, 18 Jun 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714442; cv=none; b=ZoFd75yYlKjKYyzE2nTX21MqzWsmaUyfgQVGbGzdF+Xzfgoqej/Sx+dvc9SZCDzWN0ChVhmA/+Awgn2SMzyAhDsHgO78MwGun936vYiJzYIg1quTllx827Knz+W10Q3mASxbkjd2ucehG7lqqwMBmImKi/e+e7iTP+hruk5jPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714442; c=relaxed/simple;
	bh=t+VJMoHbS5aMzSdzqTh+8YeLJC/JfqfBNiQW1Ei54KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PajOWP+3tEdwflSdiQMyjSKnW38Eb9tlvoGKB1rwPSYegT0DrcOBz8P9ZvWVhySyQC+vtBE5JZgPHCGQBa2Hj6CUjvK6SbWtL9gzoaZn+YrZMYq2ZfdRIWuRfMELAvFCHfHhq8prvAPBAMlTVLWsoNiJf5/bU23WGpK0c0i7DJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSAzaS6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA5DC4AF1D;
	Tue, 18 Jun 2024 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714442;
	bh=t+VJMoHbS5aMzSdzqTh+8YeLJC/JfqfBNiQW1Ei54KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSAzaS6USsE2Ymep2pGf65BRACRUL5WMFdh1pnvn955vgWF1PZBmK5+RxjzuDeUSH
	 jgUvDwhRPLwA9jcIS627hFh8D4n915ofaNHmumc/1Bmuws2Msmq5O71KfISrRqwFcA
	 r342BsRlpFw+CTruclLVgr6LPgGPpzIgcFuQQiyQ5yokoN6WSOAuwo4xc9hetSLSGU
	 2Cc3okik6vFOOmD03TWr+yYRC3bVJFAwJPwLyWIVzBdWLD8Ioyas/iexdc0cuh/pE4
	 4Pi5PTxZ9/7R+QftfqTGn23zyQvn3hVYhjmpLxsZQd/r0/cL+dz0mNz4yokQO9+Zsr
	 2YLReZY2NoK+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+8830db5d3593b5546d2e@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/29] wifi: mac80211: handle tasklet frames before stopping
Date: Tue, 18 Jun 2024 08:39:39 -0400
Message-ID: <20240618124018.3303162-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 177c6ae9725d783f9e96f02593ce8fb2639be22f ]

The code itself doesn't want to handle frames from the driver
if it's already stopped, but if the tasklet was queued before
and runs after the stop, then all bets are off. Flush queues
before actually stopping, RX should be off at this point since
all the interfaces are removed already, etc.

Reported-by: syzbot+8830db5d3593b5546d2e@syzkaller.appspotmail.com
Link: https://msgid.link/20240515135318.b05f11385c9a.I41c1b33a2e1814c3a7ef352cd7f2951b91785617@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/main.c        | 10 ++++++++--
 net/mac80211/util.c        |  2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3e14d5c9aa1b4..0d8a9bb925384 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1782,6 +1782,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 void ieee80211_configure_filter(struct ieee80211_local *local);
 u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
+void ieee80211_handle_queued_frames(struct ieee80211_local *local);
+
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local);
 int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 			     u64 *cookie, gfp_t gfp);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6faba47b7b0ea..89771f0e0ae70 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -300,9 +300,8 @@ u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
 	       BSS_CHANGED_ERP_SLOT;
 }
 
-static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+void ieee80211_handle_queued_frames(struct ieee80211_local *local)
 {
-	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&local->skb_queue)) ||
@@ -327,6 +326,13 @@ static void ieee80211_tasklet_handler(struct tasklet_struct *t)
 	}
 }
 
+static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+{
+	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
+
+	ieee80211_handle_queued_frames(local);
+}
+
 static void ieee80211_restart_work(struct work_struct *work)
 {
 	struct ieee80211_local *local =
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1088d90e355ba..08e6691cdc4a4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2207,6 +2207,8 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_stop_device(struct ieee80211_local *local)
 {
+	ieee80211_handle_queued_frames(local);
+
 	ieee80211_led_radio(local, false);
 	ieee80211_mod_tpt_led_trig(local, 0, IEEE80211_TPT_LEDTRIG_FL_RADIO);
 
-- 
2.43.0


