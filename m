Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE175261F2B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgIHPff (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 11:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbgIHPek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 11:34:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42924C061368
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kXaNdzZJduRfaOc+V4bsZYNRnkeBw/Drrl0jQEgix/0=; b=J/kyG2paoAWSk6r1v00NwLVvmq
        /JAHljzmi+z9+pIJIYhbdZylzVbGBRuONso/gqUDbWj5TYejKkk2epgyKhkdrXgiI0XgVV3P5i5lE
        6jh0pUqd5xhgt1dlabvOF8yngcYwfFxZNYzlzYPC35MW7zLXAoMb8qwzkcBWzTz9L0Do=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcrx-00050i-Qf; Tue, 08 Sep 2020 14:37:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 07/14] mac80211: remove tx status call to ieee80211_sta_register_airtime
Date:   Tue,  8 Sep 2020 14:36:55 +0200
Message-Id: <20200908123702.88454-8-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908123702.88454-1-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
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

