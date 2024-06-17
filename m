Return-Path: <linux-wireless+bounces-9075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3890AF4C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534B01F211BC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4C1A2C18;
	Mon, 17 Jun 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4s1cADe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FE1A2C12;
	Mon, 17 Jun 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630475; cv=none; b=IBhbTUacpiueXCkajgRYcRrS09Rmo61Ot8hjKpZYXZQd8u7sGwNRqvmCX3ims+mT2z2dqfaVhaGW8nm6zon2OHRybc53wPCzM/L1FUHAzhPBGrt9tgOh3uDoGH23+OuhavUuBudwK59EWk+uSVXEdXZpMtSPjHS9sva6xWz529s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630475; c=relaxed/simple;
	bh=52hQUnLuJuiNCML3vgwh/OQ21gZ95YeT79kztc6LkvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skoCLDVsFmcLPTrwSt6x4b7kuAVgYYDZefPkZXqwATgL7Tg9t/lw39WCflX6JRDqYQUYfyOqhiItLd/fmLujdSuhXNr106d3nEdNXhtZnckraQzUMYNYzt6i5driTRVzMCgfiwkW20GRKKwaL7aqJTyzwvudgzE0sKJ/Rdbis9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4s1cADe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E50C4AF4D;
	Mon, 17 Jun 2024 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630475;
	bh=52hQUnLuJuiNCML3vgwh/OQ21gZ95YeT79kztc6LkvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4s1cADe9gBMEOMkVIM9uPvxvQ+fIS9H9WnuvknXyD/M5f2/3bNlVhvtd+7kHPokz
	 AXe2fXdBwaO95xNzPeZnVF1yZLbCWjc+8il7qDufV6VTy458MVEk1i0amyipVfzRYr
	 0oqqzJvIgHwwSRGVMpjrnptxLJc2jcdvemkiuSshV/sZpA0VFK+HpUJhN4qBkWf91R
	 ygVB8DFlNkK1hcdpLu7rA6ZTCuVq515U56K+CEOcoIcT9SwJeN+ggjWVG6bQP+Cvmz
	 xnTUU+97+LSIm0b+nzT0cqEWqUzWM7HJUkuBzy8pztKeWsdPskYV71teWFtIPUk4x9
	 P+GIl3r8vsxIQ==
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
Subject: [PATCH AUTOSEL 6.9 16/44] wifi: mac80211: handle tasklet frames before stopping
Date: Mon, 17 Jun 2024 09:19:29 -0400
Message-ID: <20240617132046.2587008-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 70c67c860e995..48bf62e92e02e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1841,6 +1841,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 void ieee80211_configure_filter(struct ieee80211_local *local);
 u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
+void ieee80211_handle_queued_frames(struct ieee80211_local *local);
+
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local);
 int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 			     u64 *cookie, gfp_t gfp);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4eaea0a9975b4..1132dea0e290e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -423,9 +423,8 @@ u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
 	       BSS_CHANGED_ERP_SLOT;
 }
 
-static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+void ieee80211_handle_queued_frames(struct ieee80211_local *local)
 {
-	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&local->skb_queue)) ||
@@ -450,6 +449,13 @@ static void ieee80211_tasklet_handler(struct tasklet_struct *t)
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
index a237cbcf7b491..a202be949bfb1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1567,6 +1567,8 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_stop_device(struct ieee80211_local *local)
 {
+	ieee80211_handle_queued_frames(local);
+
 	ieee80211_led_radio(local, false);
 	ieee80211_mod_tpt_led_trig(local, 0, IEEE80211_TPT_LEDTRIG_FL_RADIO);
 
-- 
2.43.0


