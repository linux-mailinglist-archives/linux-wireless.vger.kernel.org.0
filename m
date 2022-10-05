Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2838C5F54ED
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJENBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJENBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:01:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E066E1EEC5
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LJgemMc53fMQH8DyNCNSKfurOl+Pw13ePCGXpV93fPs=;
        t=1664974858; x=1666184458; b=uX2LTN7D6juzDczcP5ONQnIwqNx//ZlTGSmF2wa3BDB4ILl
        +NzZGBlFXAheMQrrrGas+o9gmnUa5dn1Wza055juUSlZS06bFTsiwI6gIEE0QK4kU8EYQYMzinJS8
        uam3hTt5YKGSgfgqYbwAnDPWaTQIyZAjPsm1ghL+WZCW+KmDv4lLxAO/WN33DVUvEfU8BC6zD3szP
        fNhcT/xouPl11vFEiydD/kVp3Xxe32TahKiSQSXaAVmyl6l+YSsfs3wF8UfzhI+Bktu7KelKgGmtv
        mJBSMBYlagSe2hh95g2tJuBhqAPAAMVSWltzsVcQu/mb+b4VXv4WoStfnKq1cIxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og41A-00G2RL-2k;
        Wed, 05 Oct 2022 15:00:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 25/28] wifi: mac80211: prohibit IEEE80211_HT_CAP_DELAY_BA with MLO
Date:   Wed,  5 Oct 2022 15:00:45 +0200
Message-Id: <20221005145226.0381d8226a14.I13b8b159cb3ef31f9718447c81be8f975db2b313@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This won't work right at least with the code as it is, so
at least for now just assume it's never set for MLO. It may
very well never change, almost no drivers support it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 25e72812000e..425793dd7c9c 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1087,6 +1087,16 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 		channels += sband->n_channels;
 
+		/*
+		 * Due to the way the aggregation code handles this and it
+		 * being an HT capability, we can't really support delayed
+		 * BA in MLO (yet).
+		 */
+		if (WARN_ON(sband->ht_cap.ht_supported &&
+			    (sband->ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA) &&
+			    hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO))
+			return -EINVAL;
+
 		if (max_bitrates < sband->n_bitrates)
 			max_bitrates = sband->n_bitrates;
 		supp_ht = supp_ht || sband->ht_cap.ht_supported;
-- 
2.37.3

