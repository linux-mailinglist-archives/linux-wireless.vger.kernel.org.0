Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC575AB43D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiIBOv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbiIBOvK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F989D4BC0
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=weWZ2oVGpywF1ZC9Tl2mHej90snubFfr4KO56uW+2q8=;
        t=1662127996; x=1663337596; b=CyB1VDzqD/zRWwhw500wT6T0UC8RV+WgGLWquVtt+EM9u0G
        mhqmEAO5FPMcxhBOjO+2eJnhwzW6syZe/GZAisuBQ5I9Xc+rS3Krczeb9IqygXEnHTZa4EOWJEeJf
        6KHp1i2Fs2S24CtDtNEy+XYepOBsu6GkpMlbdf67aXiAUyn3VZqHqC7uugP80hwKyT5QTHPwHIa6/
        WlmC3y5LFzmVQjQLs4NG8iLa+cfmFczBB7aei8g/DDcPsSUfxu+vLgx2HHCJ1A93mhKZ+VlSvi1kr
        VQK5O9n1B3iKUus8Ld/bKgbfEhkSSXaDT+tSQZEX3DR2X3ssa0kT6ghIPPy4zbGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Q2-006Ch3-30;
        Fri, 02 Sep 2022 16:13:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 27/27] wifi: mac80211: prevent VLANs on MLDs
Date:   Fri,  2 Sep 2022 16:12:59 +0200
Message-Id: <20220902161144.8c88531146e9.If2ef9a3b138d4f16ed2fda91c852da156bdf5e4d@changeid>
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

Do not allow VLANs to be added to AP interfaces that are
MLDs, this isn't going to work because the link structs
aren't propagated to the VLAN interfaces yet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 30c62b63d179..3ea1f4fbca7b 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -296,6 +296,11 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 							nsdata->vif.type))
 				return -ENOTUNIQ;
 
+			/* No support for VLAN with MLO yet */
+			if (iftype == NL80211_IFTYPE_AP_VLAN &&
+			    nsdata->wdev.use_4addr)
+				return -EOPNOTSUPP;
+
 			/*
 			 * can only add VLANs to enabled APs
 			 */
-- 
2.37.2

