Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770AF720C22
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jun 2023 00:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbjFBW6f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbjFBW6c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 18:58:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB7E40
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 15:58:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b24b878so3553887276.3
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jun 2023 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685746710; x=1688338710;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ZyKSFX9mbFEpxkW7+RsW7XcjXG7U8cVIRswtejyB9g=;
        b=2pzXrZilZ7Bcom6WaEPYFcREl/2z+mMdTIIoCasFOVp9elYTIBqUsvNruRF80xUTQl
         UYILmU4EAjQ/LBj98zr08NdA1slg/dEucypM65FWCKjN4/kmu/x1LttRWgcf5UMI/VXM
         4TGtOTT8so+PXbZU+JvNwM32WfRiVmyGWpS9PZfaCE3/Chv9b9+z02bZdk3wl+5olaj+
         No1xbklWaYq4CvHLQvb73CFx4ybbBq6a8xuFfOOsLPDEXHbKJZKSiXMyP9inSmeIU/Vh
         uleJ3m8sg5mVBnQLbSSn09+BqgcWDzeOFHSPTQwltSAXX2AejOYSeyBKHUo9RiQ9QR6p
         czCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685746710; x=1688338710;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZyKSFX9mbFEpxkW7+RsW7XcjXG7U8cVIRswtejyB9g=;
        b=S0Ads+sBKPOUHRPp3FyDhC65BZm4pEHPfhn7JCXyxqppO3zowvpuLnnGVkG0ugaeWZ
         xkz31wcdIhkB7bKOPpNYYrapChfe8M8MsVFJQ9F4oafiW8XnIDXo9iaUueaZ9vZJ1H8N
         C7QrpbYsA8/r0khhjRcgr+rE8PhHfCjLGeIfPGo/UBPhk9CeRyqHBtqXOQ3Gr/SA9ygH
         sBWTk4rtlugkMMg/bsaKXluC83Jkok2V/8/38nl3whgeaN5KvykLraQHEI7mqck3LIy6
         uOODy+g7/ruEOwsORDtEenqlQV7SGACqmsYMwyMWRC4HrfC67MMyi/sZSscf+OqLyADp
         XVbQ==
X-Gm-Message-State: AC+VfDzCt85qDKRRondye6AVi86vLeX6HeYoAxo0y3xtGur/M6VdiLdR
        w8Qd77c41pWmv6G/krgcTgPxI3OPP7I=
X-Google-Smtp-Source: ACHHUZ5epWr+KLvsq4wxXvbLgvhJs9/CIEEGvPBMJz7lOWLRL813+U+/wlzLqS+S4C/NlymbtACQaVJf4Bk=
X-Received: from kglund1.bld.corp.google.com ([2620:15c:183:200:a5cd:5418:e5f2:aca5])
 (user=kglund job=sendgmr) by 2002:a25:e443:0:b0:ba8:1e5f:850f with SMTP id
 b64-20020a25e443000000b00ba81e5f850fmr1465907ybh.10.1685746710076; Fri, 02
 Jun 2023 15:58:30 -0700 (PDT)
Date:   Fri,  2 Jun 2023 16:57:50 -0600
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602225751.164525-1-kglund@google.com>
Subject: [PATCH 1/2] wifi: cfg80211: Reject (re-)association to the same BSSID
From:   Kevin Lund <kglund@google.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Kevin Lund <kglund@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Within cfg80211_connect, reject the (re-)association request if we are
already connected to the exact BSSID which is being requested. This
prevents an unnecessary attempt to connect which in the best case
leaves us back where we started.

There is precedent for behaving this way over on the userspace SME side
of things in cfg80211_mlme_auth. Further, cfg80211_connect already makes
several basic checks to ensure the connection attempt is reasonable, so
this fits in that context.

Signed-off-by: Kevin Lund <kglund@google.com>
---
 net/wireless/sme.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7bdeb8eea92dc..8f88e66bc85fc 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1442,7 +1442,8 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 
 	/*
 	 * If connected, reject (re-)association unless prev_bssid
-	 * matches the current BSSID.
+	 * matches the current BSSID. Also reject if the current BSSID matches
+	 * the desired BSSID.
 	 */
 	if (wdev->connected) {
 		if (!prev_bssid)
@@ -1450,6 +1451,9 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 		if (!ether_addr_equal(prev_bssid,
 				      wdev->u.client.connected_addr))
 			return -ENOTCONN;
+		if (ether_addr_equal(wdev->current_bss->pub.bssid,
+				     connect->bssid))
+			return -EALREADY;
 	}
 
 	/*
-- 
2.39.2

