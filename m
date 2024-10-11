Return-Path: <linux-wireless+bounces-13888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C899A436
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A13BB214B6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A592178E6;
	Fri, 11 Oct 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EI00T93Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BFA2141B5
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651157; cv=none; b=dDjeN0JhxC3bdYy4lhXrML8+XyJ097lm6iqoMK2xdwJqFIgHFExsFTzSXGlRFGtfxnaHu1/9BgCs+JpVvaMf4LpnaNcqyWAXketSXb72+ZpepSUbSxhIH/+vFcAirBtRvuXjzm63TrZgvRB2VAmsGGqCmFDx1EnOnEXOlCtnQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651157; c=relaxed/simple;
	bh=bAgAMsKUOVY95yTjJ6AX7JTnb3qDvrUpEYwVLCFgvHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sab/t79fXHE/oDjZFe8Rl1AA1dT5Kfy90/efsPkP7AfM5YPLrQllN/2JuJTO2MXXZOR5Mt8InpMrmOKK4WaDa5bPZaQIydIrtSeefTEHymMOJfLLGWISkFygUHn9CYRgKxTEI0dnVMoeHYN6mv3gGb1cmai2OcV3PAwCXtu3bY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EI00T93Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=WPLTQMjsgbVwoo6y1Kj1Lp3GpLdfHzJlB8NG2ILTrIM=; t=1728651155; x=1729860755; 
	b=EI00T93Y6COthbvyv8rlCpAKjZa5x8Oem28jLFb+d45xKWTHtS//Iuq7LpnrPBD7VFsrzEJzKNd
	py+zU757GV5AVgX6JEWR4wCjj3gk+otE6jcFDmWlnEBwKVOpReElOmJP2Dg5A0JspMZvjg0TiBlet
	im6y95raB0Ul5MgF48kofsz0ihDbTjRQyUrX4DNz3Nz8qKTHm966LBwp05VczyqgTKfrBcc93YGVs
	/+9zL6Wt1l88OAcsfRb2HnQPhlFo4uWR9DMRpbV2cWTblgg+195EXEpRbDns0y3u7SKfN2uP19R6L
	bHPItLdxtNnkOoDfn4mNHGcdEsPDyKbCQiXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1szF8C-00000007CAR-3UEu;
	Fri, 11 Oct 2024 14:52:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+41e4341f493f1155aa3d@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211_hwsim: use hrtimer_active()
Date: Fri, 11 Oct 2024 14:52:30 +0200
Message-ID: <20241011145230.5a4d38d4ff9b.Iac0ec316a0c9a7b2619abe52ddc8e04c25d8c7e1@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of hrtimer_is_queued(), use hrtimer_active() since
it might be running concurrently, and then it's not queued
at that point in time, as suggested by Thomas Gleixner in
https://lore.kernel.org/87plqn5psu.ffs@tglx, I just never
got to this for ages.

I think the concurrency is otherwise fine since we'll get
to cancel if we're actually removing things, and otherwise
we just send a beacon at slightly the wrong time or so.

Reported-by: syzbot+41e4341f493f1155aa3d@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f0e528abb1b4..c1bb825889e6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2442,7 +2442,7 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, u32 changed)
 
 		if (!data->started || !link_data->beacon_int) {
 			hrtimer_cancel(&link_data->beacon_timer);
-		} else if (!hrtimer_is_queued(&link_data->beacon_timer)) {
+		} else if (!hrtimer_active(&link_data->beacon_timer)) {
 			u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
 			u32 bcn_int = link_data->beacon_int;
 			u64 until_tbtt = bcn_int - do_div(tsf, bcn_int);
@@ -2537,7 +2537,7 @@ static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
 			  info->enable_beacon, info->beacon_int);
 		vp->bcn_en = info->enable_beacon;
 		if (data->started &&
-		    !hrtimer_is_queued(&link_data->beacon_timer) &&
+		    !hrtimer_active(&link_data->beacon_timer) &&
 		    info->enable_beacon) {
 			u64 tsf, until_tbtt;
 			u32 bcn_int;
-- 
2.47.0


