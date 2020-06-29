Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5880A20D53B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbgF2TOW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731749AbgF2TOT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82DDC00875D
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 01:50:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so13218980wrp.10
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wBnwcrwwCg7xzOS/+9Id6g/GU0D6s2nLBw+53T3f4KY=;
        b=qrIVOLnfGmFeeAsI4/tc5uVMYiRAdXj5/RviOcu8CLHA40oDfsUQ+bwS4FEVXea259
         CuPvsW/1g7eJPXtVcboNNJI2Q7F9J88qtKWL8HX6uPVPGvQyA3ximdmlSWzV/7mfgm+D
         JkZLAMJrJG/QVNciVOxRXPBjT3IWqOQBDYwb4oRM6yJRyy8KxDqwcam/Y4aFLlultboT
         WCfbB2xomajW9eShkdjKGvHRaqQQyAnjiInvf2EQgSlKnbt7oIP8AUXiDqhrYMeG7RS9
         v11VLCgvUBa9Zlas2LjOriiDXKLjt+k3CZLUT4qR5bO6xUPB1fHU7F4rk8ldqCjOcnan
         lrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wBnwcrwwCg7xzOS/+9Id6g/GU0D6s2nLBw+53T3f4KY=;
        b=Fdf3aw2NJBsg9XKIpOnVfiKDulUfxNAnHwM5yP1WeBo88OngnGlg0iMiAYjq26r5oY
         eMLMyLi6aPnymvNp+ckVJUjxh5RVcfJF7MK5yLKbWvzk1zGDNAawPpjN8idhkzbQB7E8
         1QEp3Ti52/GxIGkM9v12X2mb3J5f8LNdERbIShi8hA1jkAGZrFQcL3/MS9CcSLGDTwQa
         MuWthrtkw79PPkDJ038hmsbbt4rfhSebvgvMAmdyBB4mjPJiED2jaCU8kd7M+pOCi5Sh
         KJJKS5Kxiuj/0BU5CYclU/ZKBKv0lv8Gi3uCA3I7lR+Ow5htL/r50AM7eQG0OXNCskSF
         B3sQ==
X-Gm-Message-State: AOAM532Bv/QA4DZuP2aH9lONyOnSFTv2MUOC7SEKr6FVOvqtJ9wmV9Yc
        7zii6cjSjDNDyJV55vaZvT5bWQ==
X-Google-Smtp-Source: ABdhPJwOD+oH1zxtW5au5p6Ha2yDHZeZ0sx4AlH/rRqEkE95uqMpZh1L5v+ffyH5U/n4MQ3XIcTFAQ==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr15788239wrl.129.1593420614338;
        Mon, 29 Jun 2020 01:50:14 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id l190sm27094672wml.12.2020.06.29.01.50.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 01:50:13 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] mac80211: Inform AP when returning operating channel
Date:   Mon, 29 Jun 2020 10:55:23 +0200
Message-Id: <1593420923-26668-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Because we can miss AP wakeup (beacon) while scanning other channels,
It's important to inform the AP as soon as possible when returning
to the operating channel. This saves precious time, especially when
we only have 200ms inter-scan period for monitoring the active
connection.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 net/mac80211/ieee80211_i.h |  1 -
 net/mac80211/offchannel.c  | 38 +++++++++-----------------------------
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec1a71a..32bdb16 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1365,7 +1365,6 @@ struct ieee80211_local {
 				*/
 
 	bool pspolling;
-	bool offchannel_ps_enabled;
 	/*
 	 * PS can only be enabled when we have exactly one managed
 	 * interface (and monitors) in PS, this then points there.
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index db3b8bf..5b878d0 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -26,8 +26,7 @@ static void ieee80211_offchannel_ps_enable(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-
-	local->offchannel_ps_enabled = false;
+	bool offchannel_ps_enabled = false;
 
 	/* FIXME: what to do when local->pspolling is true? */
 
@@ -38,12 +37,12 @@ static void ieee80211_offchannel_ps_enable(struct ieee80211_sub_if_data *sdata)
 	cancel_work_sync(&local->dynamic_ps_enable_work);
 
 	if (local->hw.conf.flags & IEEE80211_CONF_PS) {
-		local->offchannel_ps_enabled = true;
+		offchannel_ps_enabled = true;
 		local->hw.conf.flags &= ~IEEE80211_CONF_PS;
 		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
 	}
 
-	if (!local->offchannel_ps_enabled ||
+	if (!offchannel_ps_enabled ||
 	    !ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK))
 		/*
 		 * If power save was enabled, no need to send a nullfunc
@@ -58,38 +57,19 @@ static void ieee80211_offchannel_ps_enable(struct ieee80211_sub_if_data *sdata)
 		ieee80211_send_nullfunc(local, sdata, true);
 }
 
-/* inform AP that we are awake again, unless power save is enabled */
+/* inform AP that we are awake again */
 static void ieee80211_offchannel_ps_disable(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 
 	if (!local->ps_sdata)
 		ieee80211_send_nullfunc(local, sdata, false);
-	else if (local->offchannel_ps_enabled) {
-		/*
-		 * In !IEEE80211_HW_PS_NULLFUNC_STACK case the hardware
-		 * will send a nullfunc frame with the powersave bit set
-		 * even though the AP already knows that we are sleeping.
-		 * This could be avoided by sending a null frame with power
-		 * save bit disabled before enabling the power save, but
-		 * this doesn't gain anything.
-		 *
-		 * When IEEE80211_HW_PS_NULLFUNC_STACK is enabled, no need
-		 * to send a nullfunc frame because AP already knows that
-		 * we are sleeping, let's just enable power save mode in
-		 * hardware.
-		 */
-		/* TODO:  Only set hardware if CONF_PS changed?
-		 * TODO:  Should we set offchannel_ps_enabled to false?
-		 */
-		local->hw.conf.flags |= IEEE80211_CONF_PS;
-		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
-	} else if (local->hw.conf.dynamic_ps_timeout > 0) {
+	else if (local->hw.conf.dynamic_ps_timeout > 0) {
 		/*
-		 * If IEEE80211_CONF_PS was not set and the dynamic_ps_timer
-		 * had been running before leaving the operating channel,
-		 * restart the timer now and send a nullfunc frame to inform
-		 * the AP that we are awake.
+		 * the dynamic_ps_timer had been running before leaving the
+		 * operating channel, restart the timer now and send a nullfunc
+		 * frame to inform the AP that we are awake so that AP sends
+		 * the buffered packets (if any).
 		 */
 		ieee80211_send_nullfunc(local, sdata, false);
 		mod_timer(&local->dynamic_ps_timer, jiffies +
-- 
2.7.4

