Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE915261B88
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgIHTEc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:04:32 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52732 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731728AbgIHTDu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id C622C4F9B09;
        Tue,  8 Sep 2020 19:03:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mFQPZHBD0-ED; Tue,  8 Sep 2020 19:03:46 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 34A534F9B0D;
        Tue,  8 Sep 2020 19:03:25 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 17/22] mac80211: avoid rate init for S1G band
Date:   Tue,  8 Sep 2020 12:03:18 -0700
Message-Id: <20200908190323.15814-18-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

minstrel_ht is confused by the lack of sband->bitrates,
and S1G will likely require a unique RC algorithm, so
avoid rate init for now if STA is on the S1G band.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/rate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 63266d73c252..0cba7fed28cf 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -51,6 +51,12 @@ void rate_control_rate_init(struct sta_info *sta)
 
 	sband = local->hw.wiphy->bands[chanctx_conf->def.chan->band];
 
+	/* TODO: check for minstrel_s1g ? */
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		rcu_read_unlock();
+		return;
+	}
+
 	spin_lock_bh(&sta->rate_ctrl_lock);
 	ref->ops->rate_init(ref->priv, sband, &chanctx_conf->def, ista,
 			    priv_sta);
-- 
2.20.1

