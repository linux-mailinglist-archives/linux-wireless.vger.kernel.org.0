Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C89573A36
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiGMPeq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiGMPem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7E3E759
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kE7/DIY7Pnhnm1KcOZPfaD0L7gShX4/QnLHZsFOOwcM=;
        t=1657726481; x=1658936081; b=CGoYPH83juiLLCvp28DTJVLE+VK2Ci2Rb1stp/eHFAIEjzS
        WkhwIrpZyJx/VgeKRKEBd4zUTvfxQIT0RqIvsgfaYIJzkPFFAT+qZfsN0SUeKTALzpQXlG8XXkaEQ
        CpA+E5Rb5FIKh7WqLDIy96U2+5ZaEqwfXEON3lbkXtBjQ+n554mjc4cr2Vzecz84sFwxGZ2qkjqe3
        aBzU+eUJVld6AhFvq/V3ydB55i/PPwnJzR+ejOA2BJSnbKLAR2Xrg/5USBQxQg2qQjqb1saWeMegy
        ifvoNWjm9q1PzhQEH+ABE59V0mc0iyv/AM7IlYbt21XTf4CuHtEql09XvU0sJcfw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNq-00EnaA-OJ;
        Wed, 13 Jul 2022 17:34:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/21] wifi: mac80211: mlme: clean up supported channels element code
Date:   Wed, 13 Jul 2022 17:34:18 +0200
Message-Id: <20220713173301.abefedad549e.Ia7c125ab1274ce850e1c8bf547621275d3294ab1@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Clean up the code building the supported channels element
a little bit by using a local variable instead of the long
line.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f261d42dd59f..042cd5439bb8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1078,8 +1078,9 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		*pos++ = WLAN_EID_SUPPORTED_CHANNELS;
 		*pos++ = 2 * sband->n_channels;
 		for (i = 0; i < sband->n_channels; i++) {
-			*pos++ = ieee80211_frequency_to_channel(
-					sband->channels[i].center_freq);
+			int cf = sband->channels[i].center_freq;
+
+			*pos++ = ieee80211_frequency_to_channel(cf);
 			*pos++ = 1; /* one channel in the subband*/
 		}
 	}
-- 
2.36.1

