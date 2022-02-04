Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED114AA2B3
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbiBDWDF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbiBDWDD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:03:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F67C061401
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LGyNf6BgxlrvKAR+8sLbZushnAIRCRUhsJjELPuHaio=;
        t=1644012182; x=1645221782; b=Sr45KLH9GWWXNetMK6/nO1qNT8+XcK3/uopV8yzORv4SObr
        FlueY8VuUDDZqdwO38arxsrSyU1JDplwXk2i9vcUHyGHavK62YEXUDYUSlUTPaJjTzNcxMqIjJ8KK
        T85n2scSkmE9K1xtGufLt9RZnf5SM/NtVvFgme9sllR42JHGhIJkUU98GtmNwZOTgB4TK5yPpcasJ
        BWByfJUKJb+1oF3qNulhGwDkandBx7aVvcgQUnAF4pT3KJ828n10KJmmjNWkNUmYun6SyDgYGQFaY
        1IlAzOEm4vjO+G4Hu+H+EtVzXpUypNY9KtcPzhJvllyIWUBeskM5JUvI02ge+DmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6fU-00EeJL-Gy;
        Fri, 04 Feb 2022 23:03:00 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 03/19] mac80211_hwsim: Add custom regulatory for 6GHz
Date:   Fri,  4 Feb 2022 23:02:39 +0100
Message-Id: <20220204230119.efd25262d8cc.I9507395b64496d96a2276ba8c1e1323e54407aa7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204220255.448224-1-johannes@sipsolutions.net>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
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

From: Ilan Peer <ilan.peer@intel.com>

Add a custom regulatory domain for testing 6 GHz, including
320 MHz bandwidth. This can be used before the regulatory
databases are all updated etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index aa839b395497..ad30fd6beaf1 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -173,9 +173,23 @@ static const struct ieee80211_regdomain hwsim_world_regdom_custom_02 = {
 	}
 };
 
+static const struct ieee80211_regdomain hwsim_world_regdom_custom_03 = {
+	.n_reg_rules = 6,
+	.alpha2 =  "99",
+	.reg_rules = {
+		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
+		REG_RULE(2484 - 10, 2484 + 10, 40, 0, 20, 0),
+		REG_RULE(5150 - 10, 5240 + 10, 40, 0, 30, 0),
+		REG_RULE(5745 - 10, 5825 + 10, 40, 0, 30, 0),
+		REG_RULE(5855 - 10, 5925 + 10, 40, 0, 33, 0),
+		REG_RULE(5955 - 10, 7125 + 10, 320, 0, 33, 0),
+	}
+};
+
 static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
 	&hwsim_world_regdom_custom_01,
 	&hwsim_world_regdom_custom_02,
+	&hwsim_world_regdom_custom_03,
 };
 
 struct hwsim_vif_priv {
-- 
2.34.1

