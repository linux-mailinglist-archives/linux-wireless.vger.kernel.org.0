Return-Path: <linux-wireless+bounces-9184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E4B90CFE7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF6BB265D0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4BE1AD3E6;
	Tue, 18 Jun 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwOtBF7P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2F13C801;
	Tue, 18 Jun 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714515; cv=none; b=kx3zo/Suw/ehFQZh4uNcSaQn8hb1t4atWpPWiRf/T/zlBsyqVWx66T0qYIdS6m6Rdy+KBtqf4d4a2EOFzNGWdYS084Za8VbiumioRpbIsOIR7+sXTBjYrbJ+IlmLZdaFs3pOHivP0nnNzkkc1kibMDc32sSpvW3p96APCAiFvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714515; c=relaxed/simple;
	bh=/Wi55a5hsYvtldVFwu4hzRH0299rWjheTH4KjtzzCzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI5ILJAooJcmFJDsCOdtlPZglW9+KE72UtkXQeyl/bFCvZXhkfQ/br7TIsCKCiyeiGUYHlEk/F9rZkij/4rBPjP+ptg3kFPAy1POhEYXPSPQTWa4xVbPYf/TS7VxD+M2XXaNU4vzlpp1LHx9PUNzwykIS+GRT1v234r7wOL90UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwOtBF7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F6C4AF50;
	Tue, 18 Jun 2024 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714515;
	bh=/Wi55a5hsYvtldVFwu4hzRH0299rWjheTH4KjtzzCzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwOtBF7PlTYiabzFBgWf8VMrcfwsEvs/XwhLTTS9t7tjVNxSi+xZAKip5JjNzqKg8
	 +SZlO7MpC9LWvrZSMM7cOMKk7Q8cjlq7FpK5rC7Opb5WmMta5mRFp5/4uuxlOzPi5a
	 Yow0jgirmoDLOIWPH2UUjDxyB0gd9QDcJC8OZysyqfJ/2SHwkcmWrdFCeAzMnnQv1U
	 AbPBPc3Y+9lt8sJ5b9IQoPNwoyQG6Tm1C30l+OeC11OsoHSxcJU/UWKU9kYBboIPrC
	 FWZqHXDo4h9ng827zyRsmxwtl4QIOvgorkMsEz1mmHUf5qJtvsF9g6k9mPsBP4IdQS
	 KXFew47nlimgg==
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
Subject: [PATCH AUTOSEL 5.15 09/21] wifi: mac80211: handle tasklet frames before stopping
Date: Tue, 18 Jun 2024 08:41:08 -0400
Message-ID: <20240618124139.3303801-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124139.3303801-1-sashal@kernel.org>
References: <20240618124139.3303801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 03f8c8bdab765..03c238e68038b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1803,6 +1803,8 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 void ieee80211_configure_filter(struct ieee80211_local *local);
 u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
+void ieee80211_handle_queued_frames(struct ieee80211_local *local);
+
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local);
 int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 			     u64 *cookie, gfp_t gfp);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 9617ff8e27147..7d62374fe727b 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -220,9 +220,8 @@ u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
 	       BSS_CHANGED_ERP_SLOT;
 }
 
-static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+void ieee80211_handle_queued_frames(struct ieee80211_local *local)
 {
-	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&local->skb_queue)) ||
@@ -247,6 +246,13 @@ static void ieee80211_tasklet_handler(struct tasklet_struct *t)
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
index 354badd32793a..3d47c2dba39da 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2146,6 +2146,8 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_stop_device(struct ieee80211_local *local)
 {
+	ieee80211_handle_queued_frames(local);
+
 	ieee80211_led_radio(local, false);
 	ieee80211_mod_tpt_led_trig(local, 0, IEEE80211_TPT_LEDTRIG_FL_RADIO);
 
-- 
2.43.0


