Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3515178AF99
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjH1MGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjH1MFp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF6B11A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rz6SCg6cXxMCDgr1u3i7EAf/eYCNI80vu6z808viA2I=;
        t=1693224343; x=1694433943; b=n7q3L6hSwD2D25ClEqoYZ4fcnuqftz30hMEbiIzmJDo5X/H
        lBsn6hcZzU68sV1SJewC1emRatQvB0G+sG9SvHt6+87hIYarNrt+nn3KnS6Th/6m8kCnvB4W9Ytpu
        1aqGZg2GmTHQUlzB+Biyv0amfNTohp5y8nEgpz8nkLrmcMpK5B2swI+JBfMiLudbzl1zPVTS3nMsE
        kZS92znEbIAtnm6uGoYQR8whdA/IHYaSQxmMrhuZkdjWdbHk5sn5twY2g1uAUEAHNgNWcHEdRuX85
        758TXTEI7gG5H726hxvkQrnrz3GpwIL0cDG+NC/ttS9pC97pVF8AEKyGHXeIyDWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab00-00Gjgt-28;
        Mon, 28 Aug 2023 14:05:40 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 26/40] wifi: cfg80211: sme: hold wiphy lock for wdev iteration
Date:   Mon, 28 Aug 2023 13:59:54 +0200
Message-ID: <20230828135928.1189e740f153.I098fcd58f32968aee65b4876c2cfef7fcedaf160@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since we will want to remove the wdev lock in the future,
lock the wiphy here to iterate and for checking the status
of the connections.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/sme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 53ba46f85ceb..c271f30b58fa 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -703,6 +703,7 @@ static bool cfg80211_is_all_idle(void)
 	 * as chan dfs state, etc.
 	 */
 	for_each_rdev(rdev) {
+		wiphy_lock(&rdev->wiphy);
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 			wdev_lock(wdev);
 			if (wdev->conn || wdev->connected ||
@@ -710,6 +711,7 @@ static bool cfg80211_is_all_idle(void)
 				is_all_idle = false;
 			wdev_unlock(wdev);
 		}
+		wiphy_unlock(&rdev->wiphy);
 	}
 
 	return is_all_idle;
-- 
2.41.0

