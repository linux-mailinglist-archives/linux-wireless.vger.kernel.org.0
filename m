Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E160824CC8C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 06:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgHUEUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 00:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUEUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 00:20:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480DC061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kXaNdzZJduRfaOc+V4bsZYNRnkeBw/Drrl0jQEgix/0=; b=T1K/NYOgve0NubyD/nf38NTxdM
        YJ+WpjBjhd7st5klj7H3UUfrGViY83HsTf5gXNKcqNtPztjwXxaBAq7DhLkpIV0saXn4aS/fu1DOC
        kVQCAfakSyC3EyFFD6JmqKyl75aQWp363gob72GnHe8eY+w4s8FCcikbCmt4tvhhpEJQ=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k8yX6-0005s7-7t; Fri, 21 Aug 2020 06:20:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 03/13] mac80211: remove tx status call to ieee80211_sta_register_airtime
Date:   Fri, 21 Aug 2020 06:19:51 +0200
Message-Id: <20200821042001.23388-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821042001.23388-1-nbd@nbd.name>
References: <20200821042001.23388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All drivers using airtime fairness are calling ieee80211_sta_register_airtime
directly

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/status.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index b3c356b3fc78..67df7a5acee5 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -988,12 +988,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			ieee80211_sta_tx_notify(sta->sdata, (void *) skb->data,
 						acked, info->status.tx_time);
 
-		if (info->status.tx_time &&
-		    wiphy_ext_feature_isset(local->hw.wiphy,
-					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
-			ieee80211_sta_register_airtime(&sta->sta, tid,
-						       info->status.tx_time, 0);
-
 		if ((tx_time_est = ieee80211_info_get_tx_time_est(info)) > 0) {
 			/* Do this here to avoid the expensive lookup of the sta
 			 * in ieee80211_report_used_skb().
-- 
2.28.0

