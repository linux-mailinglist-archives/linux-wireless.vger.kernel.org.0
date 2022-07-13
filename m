Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1204F573343
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiGMJps (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiGMJpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4C9ED16E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wd2/qnubEFFzrT6melk17EpX1kKofQeLt5QSjHuNXgg=;
        t=1657705515; x=1658915115; b=RBxhANORrsp68EgpczHXj0fQd4xlwWvEPxK1l0Zj4ZrEhLX
        Dc+kgeddoW2RVaPbeSvZTLNDVon/DLegylv1vco+rb3iDOIJHMW0LM5J/zh9meZtjKWmNbZ5rt5We
        k5BHFn0JJ1/pEV4ct5Jx5ce1Z1wGCe3h2KwRML7THqvxEvK4lBXUluvj4a9zVawX5969yFb87cAPh
        v/feQpikB++I0uZdhBg4hpWnDJ9zoEzOZNelOYIbTc64BDKlAyB3G6ewPOnh2564DAjMwWyjukpbT
        x//BzwdG5V5c/2Konj5id4sie93soo8eBE5IQ46/0DFSny8dJfGuOS9fENM9X6AQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvh-00EgvB-6m;
        Wed, 13 Jul 2022 11:45:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 30/76] wifi: mac80211: remove unused bssid variable
Date:   Wed, 13 Jul 2022 11:44:16 +0200
Message-Id: <20220713114425.be231e650d80.I6d113541aecb6b0750498615b17420a3333494b1@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

This variable is only written to, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0992a3ff3a98..bfb29d09bd1d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6364,7 +6364,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 			   struct cfg80211_disassoc_request *req)
 {
-	u8 bssid[ETH_ALEN];
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
 	/*
@@ -6380,7 +6379,6 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 		   "disassociating from %pM by local choice (Reason: %u=%s)\n",
 		   req->bss->bssid, req->reason_code, ieee80211_get_reason_code_string(req->reason_code));
 
-	memcpy(bssid, req->bss->bssid, ETH_ALEN);
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DISASSOC,
 			       req->reason_code, !req->local_state_change,
 			       frame_buf);
-- 
2.36.1

