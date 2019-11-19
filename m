Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D087101824
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 07:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfKSGFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 01:05:55 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:43012 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfKSFfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 00:35:47 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id 600EE2F03E3;
        Tue, 19 Nov 2019 05:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dqCji8icNOc5; Mon, 18 Nov 2019 21:35:40 -0800 (PST)
Received: from tractor.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id AD6ED2F03E4;
        Mon, 18 Nov 2019 21:35:39 -0800 (PST)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 2/3] mac80211: expose HW conf flags through debugfs
Date:   Mon, 18 Nov 2019 21:35:37 -0800
Message-Id: <20191119053538.25979-3-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119053538.25979-1-thomas@adapt-ip.com>
References: <20191119053538.25979-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is useful during testing to eg. check the currently
configured HW power save state.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 568b3b276931..5c52429038c3 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -59,6 +59,8 @@ static const struct file_operations name## _ops = {			\
 	debugfs_create_file(#name, mode, phyd, local, &name## _ops);
 
 
+DEBUGFS_READONLY_FILE(hw_conf, "%x",
+		      local->hw.conf.flags);
 DEBUGFS_READONLY_FILE(user_power, "%d",
 		      local->user_power_level);
 DEBUGFS_READONLY_FILE(power, "%d",
@@ -433,6 +435,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_ADD(hwflags);
 	DEBUGFS_ADD(user_power);
 	DEBUGFS_ADD(power);
+	DEBUGFS_ADD(hw_conf);
 	DEBUGFS_ADD_MODE(force_tx_status, 0600);
 
 	if (local->ops->wake_tx_queue)
-- 
2.20.1

