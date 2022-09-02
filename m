Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E145AB434
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiIBOvy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiIBOvJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FEC9E98
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Fcb7MRhNBRPyuXfJFlok0Kl/XOD0L9kPs1dLRrs+SN8=;
        t=1662127996; x=1663337596; b=aL0NZV4IWD6130p92onIB9cghnYnSWdv7PGtsTaRyef+Rrm
        +KnSzKLkTNxZPjfBWTE0HM1AxP9XdjwO4MOdX/Hj9MXFFwznIg2ww0vc7QF895NzsUKAlKDsAvgGE
        wStLrBkytRqGnaMgnkTADN8qmrD2HwwiPdIqu5rMAe0wNfaB3m+nqfSJqovKv3QAWj4ht0I7iSjDC
        L4E9Oks8fB5wDZ1AUDHS6wSCNY64eiFDiY4rRPQY3Q79lPpTe3mHdSxPXoTYahUFiAQtMRjoPlnMe
        9HfPif6osjb8QCwAViB96osWVxCCEQNdobLV+rESOPFngn2kEVN9gO3IGSO0b2VQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Q2-006Ch3-1P;
        Fri, 02 Sep 2022 16:13:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 25/27] wifi: mac80211_hwsim: always activate all links
Date:   Fri,  2 Sep 2022 16:12:57 +0200
Message-Id: <20220902161143.f532f47ae5aa.I1e04b12b2784ea52f91f4bffb2c4af7686482435@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
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

By default, even in client mode, hwsim always had all links
active, where it then uses them in a round-robin fashion.
Re-enable that by activating all valid links work right after
the connection is authorized.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index f044db1621dd..96f7333f7ce1 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2476,6 +2476,14 @@ static int mac80211_hwsim_sta_state(struct ieee80211_hw *hw,
 	if (old_state == IEEE80211_STA_NOTEXIST)
 		return mac80211_hwsim_sta_add(hw, vif, sta);
 
+	/*
+	 * when client is authorized (AP station marked as such),
+	 * enable all links
+	 */
+	if (vif->type == NL80211_IFTYPE_STATION &&
+	    new_state == IEEE80211_STA_AUTHORIZED && !sta->tdls)
+		ieee80211_set_active_links_async(vif, vif->valid_links);
+
 	return 0;
 }
 
-- 
2.37.2

