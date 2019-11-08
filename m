Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D393F57D6
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbfKHTm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:27 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46184 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfKHTm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:27 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6C16813C343;
        Fri,  8 Nov 2019 11:42:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6C16813C343
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242146;
        bh=T8Eu9ww+e9qUtT2KOm46lyoa/qNUUUchUIgt8IP+Iyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtFdXwCIID1evmH7wEbtc2nCvVifHk6friQbp+rQWEr3ClbYYOw3EWO3l5b8dgfV4
         i5AjlVWSVqYl9q1gcv/+7KG642VUiN7NRr8rRg6JCau4FWCnJ6vFatCFc5LOTqEwfv
         h28H6UV/+A8k2zeD6dGkkd3kksx18R2vaeu7vGZw=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 07/10] mac80211: Revert some of e8e4f5, fixes setting single rate in ath10k.
Date:   Fri,  8 Nov 2019 11:42:08 -0800
Message-Id: <20191108194210.23618-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108194210.23618-1-greearb@candelatech.com>
References: <20191108194210.23618-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This lets us successfully set a single rate in ath10k again.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/cfg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 70739e746c13..41d55bd1b43a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2877,8 +2877,10 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 		u32 basic_rates = sdata->vif.bss_conf.basic_rates;
 		enum nl80211_band band = sdata->vif.bss_conf.chandef.chan->band;
 
-		if (!(mask->control[band].legacy & basic_rates))
-			return -EINVAL;
+		if (!(mask->control[band].legacy & basic_rates)) {
+			pr_err("%s:  WARNING: no legacy rates for band[%d] in set-bitrate-mask.\n",
+			       sdata->dev->name, band);
+		}
 	}
 
 	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {
-- 
2.20.1

