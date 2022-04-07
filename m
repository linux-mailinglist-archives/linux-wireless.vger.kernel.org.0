Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B44F7D1B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbiDGKjU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 06:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbiDGKjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 06:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2010F3B2AC
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 03:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB4C61DCD
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 10:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D777C385A0;
        Thu,  7 Apr 2022 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649327834;
        bh=XllP2YEwaqN7vVQ+F8Fo0krkOL7zmoJdkW181d2G/O8=;
        h=From:To:Cc:Subject:Date:From;
        b=PzWv+JY8VtawrCVUUDtvpT/40IGXqctoz1lUkNvVrEgDOcK+AkwFBuRpGJH776tHB
         bzx61tnjbJT0PJkLrxi9ifsJVIlMsoDZvgYLlR0Y0+Qj/aJ+/zyKFVVWhAXfDtgO6x
         rrV/cz1Azb939tiCejYvK2XAnD8ngWC9TkOzp7jC2u/G/QJd7pGXs+dFk3AsFFu9yL
         0Mct9uRA0TBinnEFDim21ALTzlRCK/WTHWaZzIkB20KvHep2jQyHSGFrFqi01SYbyb
         08e+Pq3APMjStwa9y9q52QCRIWopeMwvKR9EZhSxeWsZrmpau+s33nJUmRYJPnt2vy
         gkgAVnHLVhn6w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH wireless-next] mac80211: protect ieee80211_assign_beacon with next_beacon check
Date:   Thu,  7 Apr 2022 12:36:58 +0200
Message-Id: <041764ed7e9781bcee66c33b41f1365aa4205932.1649327683.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even if it is not a real issue since ieee80211_set_after_csa_beacon()
or ieee80211_set_after_color_change_beacon() are run only when csa or bcc
is active, move next_beacon check before running ieee80211_assign_beacon
routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/cfg.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ba752539d1d9..8e14ff53e4bd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3306,13 +3306,14 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
+		if (!sdata->u.ap.next_beacon)
+			return -EINVAL;
+
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL, NULL);
-		if (sdata->u.ap.next_beacon) {
-			kfree(sdata->u.ap.next_beacon->mbssid_ies);
-			kfree(sdata->u.ap.next_beacon);
-			sdata->u.ap.next_beacon = NULL;
-		}
+		kfree(sdata->u.ap.next_beacon->mbssid_ies);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
 
 		if (err < 0)
 			return err;
@@ -4314,13 +4315,14 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_AP: {
 		int ret;
 
+		if (!sdata->u.ap.next_beacon)
+			return -EINVAL;
+
 		ret = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL, NULL);
-		if (sdata->u.ap.next_beacon) {
-			kfree(sdata->u.ap.next_beacon->mbssid_ies);
-			kfree(sdata->u.ap.next_beacon);
-			sdata->u.ap.next_beacon = NULL;
-		}
+		kfree(sdata->u.ap.next_beacon->mbssid_ies);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
 
 		if (ret < 0)
 			return ret;
-- 
2.35.1

