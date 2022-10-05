Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848335F54E8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJENB3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJENA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7000773303
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tek+gBhqRDC/tLMtcDGwvGf9KPohG5ehmzlAhzDqx+Q=;
        t=1664974857; x=1666184457; b=ZEyKmYqsuEoO0NQ7ZOeIBVdgDx5dsq0G44hXlzpEITcRAoM
        XPqiNMCSMcMtxEwEgxNs8QNhLUuJKV9sBb1JWl34VfkyhHXX5uJuRpt2HXq6xsmJcUN/ghobsQSQw
        XLzsmfq1pKLpDvlJobu0bZkhnPnHEso4Up8PDLpzmfyPVxH529r/CPOB5/xRo5BvSmYx6mViIBGpj
        9XjQhvvnPq3/N/ce8EbFIsf9ih9C7AboFy1NqiK7HFkez2b1bVimVqn4wvqxnhhQ5vuPZWLcxh1Vy
        FYV0tCidIuVDtERFOvscL4W+4W3t/icHquLCMH2yCSTacGErB47MTAlDnydfajMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og419-00G2RL-2b;
        Wed, 05 Oct 2022 15:00:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 21/28] wifi: mac80211: check link ID in auth/assoc continuation
Date:   Wed,  5 Oct 2022 15:00:41 +0200
Message-Id: <20221005145226.c6a22c9df471.Ibc1e59b9113255445a9dd4c66246d9805c39c337@changeid>
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

Ensure that the link ID matches in auth/assoc continuation,
otherwise we need to reset all the data.

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 1 +
 net/mac80211/mlme.c        | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 517a50abdb09..b704656027db 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -390,6 +390,7 @@ struct ieee80211_mgd_auth_data {
 	bool done, waiting;
 	bool peer_confirmed;
 	bool timeout_started;
+	int link_id;
 
 	u8 ap_addr[ETH_ALEN] __aligned(2);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1ad0bf3bfcae..c46f355265ee 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6702,6 +6702,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	       req->ap_mld_addr ?: req->bss->bssid,
 	       ETH_ALEN);
 	auth_data->bss = req->bss;
+	auth_data->link_id = req->link_id;
 
 	if (req->auth_data_len >= 4) {
 		if (req->auth_type == NL80211_AUTHTYPE_SAE) {
@@ -6720,7 +6721,8 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	 * removal and re-addition of the STA entry in
 	 * ieee80211_prep_connection().
 	 */
-	cont_auth = ifmgd->auth_data && req->bss == ifmgd->auth_data->bss;
+	cont_auth = ifmgd->auth_data && req->bss == ifmgd->auth_data->bss &&
+		    ifmgd->auth_data->link_id == req->link_id;
 
 	if (req->ie && req->ie_len) {
 		memcpy(&auth_data->data[auth_data->data_len],
@@ -7044,7 +7046,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 		/* keep sta info, bssid if matching */
 		match = ether_addr_equal(ifmgd->auth_data->ap_addr,
-					 assoc_data->ap_addr);
+					 assoc_data->ap_addr) &&
+			ifmgd->auth_data->link_id == req->link_id;
 		ieee80211_destroy_auth_data(sdata, match);
 	}
 
-- 
2.37.3

