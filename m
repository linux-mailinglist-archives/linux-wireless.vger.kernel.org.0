Return-Path: <linux-wireless+bounces-9087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2AD90AFF7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAC9B36779
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4D1BE842;
	Mon, 17 Jun 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/4prwen"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1481BE25D;
	Mon, 17 Jun 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630613; cv=none; b=F+sBG+ex/l2ADvBzDEdeRuwNtwxTxWkS7QulW62iHM9txGTEW2zTmSRkJrEFt01Jh0WQPjI+4balDfiGxur6xhLp+4Xi2R3oUd4/eLvY4QilfPRhBTB3HTOrKj7MV1L7EbsigRv3SXBwFGBKr4e28sxP415Z8/i8Ds8DGDX/J0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630613; c=relaxed/simple;
	bh=Zj9d84qwyrY4m2ytLMJ7KkWT6CrOEfG4t29RPvVaUJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3GbbCpNRq9kfH7U8VeE3CVdekjPHVu9dUm2kYdGW0fp6JozxjSmh20lyfhikof+I00WtM55FOZ/POoaxJbKy79YemjEaUFAtujmhm1QahcHQzTz1WihsVr+VCg9u3/6V9i3tP1HQvg1xgfyXUM1MSSPgO60KxCPSNsWrbZIKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/4prwen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49618C4AF48;
	Mon, 17 Jun 2024 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630613;
	bh=Zj9d84qwyrY4m2ytLMJ7KkWT6CrOEfG4t29RPvVaUJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/4prwenZAruqCyD6J6cKkzQvYcO2pC8fY8VNX78ZGfqzN5+zieEDWebaOlwibtQ+
	 vcE2KkdVwpor0n0qlhzD9elcXYHie6/5YYzmQgBCdDpQpJF0BON5LcQt1Wk04sPlfR
	 7CopTWhpfc/qH4ZN8nWr31Htv5x4xhWyrbEvkiFqzQUMWuIu4Rr4L3KzEVSe0/Atm4
	 6yIv/Y1XAPB16JzTbxK46E5wuddqhOe0JHjfGN/s1oPyAkHT2rHWZrwFoXXtg4cmKN
	 oK6mU7buXRt+H8GmihQLnz/TfuVgk9DLbMEZypfz8LxP9ZYNIBe+yIPRcg4Iu0ZGOK
	 8NUkW+dsEwlKw==
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
Subject: [PATCH AUTOSEL 6.6 13/35] wifi: mac80211: handle tasklet frames before stopping
Date: Mon, 17 Jun 2024 09:22:11 -0400
Message-ID: <20240617132309.2588101-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index fefaa9e902a2f..fb55014c0e898 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1846,6 +1846,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 void ieee80211_configure_filter(struct ieee80211_local *local);
 u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
+void ieee80211_handle_queued_frames(struct ieee80211_local *local);
+
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local);
 int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 			     u64 *cookie, gfp_t gfp);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4548f84451095..d7f67d81d5af9 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -301,9 +301,8 @@ u64 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
 	       BSS_CHANGED_ERP_SLOT;
 }
 
-static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+void ieee80211_handle_queued_frames(struct ieee80211_local *local)
 {
-	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&local->skb_queue)) ||
@@ -328,6 +327,13 @@ static void ieee80211_tasklet_handler(struct tasklet_struct *t)
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
index 172173b2a9eb8..62c8b4342136e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2313,6 +2313,8 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_stop_device(struct ieee80211_local *local)
 {
+	ieee80211_handle_queued_frames(local);
+
 	ieee80211_led_radio(local, false);
 	ieee80211_mod_tpt_led_trig(local, 0, IEEE80211_TPT_LEDTRIG_FL_RADIO);
 
-- 
2.43.0


