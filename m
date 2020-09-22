Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72754273A41
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgIVFhh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:37 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:34096 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729049AbgIVFhh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id A4CAB4F9E12;
        Tue, 22 Sep 2020 05:37:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sID_dVKE6jdE; Tue, 22 Sep 2020 05:37:34 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 06BC04F9E03;
        Tue, 22 Sep 2020 05:37:19 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 12/17] mac80211: avoid rate init for S1G band
Date:   Mon, 21 Sep 2020 19:28:13 -0700
Message-Id: <20200922022818.15855-13-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

