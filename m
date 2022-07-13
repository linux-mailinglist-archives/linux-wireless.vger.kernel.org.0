Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF295573336
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiGMJpi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiGMJpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03146EEAB6
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bN1O9RYWnDxvqRmINA80nozgfqSNrt4VcbHV3moRdYM=;
        t=1657705513; x=1658915113; b=Co9A5g9HkGlL6vErtaR1s9A/rireGZcPmchCFKhb9euATrA
        kN6g/ZgFjRg4ji+msfTsLkx1AI7IVnRMxUO+KoVTRcJaDuqx+veWeyKbMtXrXXDlngsWvZLBN6WpR
        eMPfNZT7l1dnGvVi8rv11Rh/MHgEP24/dMouns8FjQsgYnCZuDGmldvIkC3v1eKY2h/7lxbZBYW2x
        KNPcIsbCiftwM/Cl6Mgy2cUlMWlzKYSuMuwSmP+1GUOs+DE3jd0SVoz1adNrBCmqgEBJKgTbn04AM
        PQywJinyYsQbAbu3f2LsM5+43XfvZIO8one224ljU4Ot4hVK0Q6FXzPeqclDSKcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvf-00EgvB-Aj;
        Wed, 13 Jul 2022 11:45:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 23/76] wifi: nl80211: acquire wdev mutex for dump_survey
Date:   Wed, 13 Jul 2022 11:44:09 +0200
Message-Id: <20220713114425.144225d04e6e.I8aec1b25f42c4977ab5f4e4a0286eba551d3e13f@changeid>
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

At least the quantenna driver calls wdev_chandef() here
which now requires the lock, so acquire it.

Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b50ba1803595..886d964242ae 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10233,7 +10233,9 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	while (1) {
+		wdev_lock(wdev);
 		res = rdev_dump_survey(rdev, wdev->netdev, survey_idx, &survey);
+		wdev_unlock(wdev);
 		if (res == -ENOENT)
 			break;
 		if (res)
-- 
2.36.1

