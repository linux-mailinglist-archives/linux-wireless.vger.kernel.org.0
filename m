Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9805372423B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjFFMfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbjFFMey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:34:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D3210C6
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=06+UhoP5TamLGqopMxPqWomezmwFuSmat4VeYHN/CYo=; t=1686054893; x=1687264493; 
        b=cKgTQ0GoIF9HJebTE7Gh6eFoja8QwqP6ko8ky+/0lUsFmrNHLRwDNguRin2tbCZuTLGfkpB1CPB
        2FhaVUslvJD3BcWlh7FuUBG+HoIMcZnqT70qeEm0VuRl9vGwbnVTppbRmV949Dv52NWfSDILC6va6
        SCjW64Lwc0WOnF4i+O9HHeqlsL1x40RAyz915TeG6DLnJAX97p9QYUdXOvKO1ExBGEFDJLYeBgBog
        /HwHKxGL0aXgXhfmSoAjKwxzjXstkNQ2sLXV6aoHbt7na24Uyob3pHvZUd4DXHF2td2EcibSIUxiS
        gu0lGQ4y+ak/8k7uWTYDFjQfJG6+63XMv9/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6Vti-00FYss-1Z;
        Tue, 06 Jun 2023 14:34:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: cfg80211: fix locking in sched scan stop work
Date:   Tue,  6 Jun 2023 14:34:47 +0200
Message-Id: <20230606143447.3fb899fe7aba.I16cd047ee371b7ea34822cc84fd51a09e9778d8f@changeid>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This should use wiphy_lock() now instead of acquiring the
RTNL, since cfg80211_stop_sched_scan_req() now needs that.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 5b0c4d5b80cf..b3ec9eaec36b 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -368,12 +368,12 @@ static void cfg80211_sched_scan_stop_wk(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			   sched_scan_stop_wk);
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	list_for_each_entry_safe(req, tmp, &rdev->sched_scan_req_list, list) {
 		if (req->nl_owner_dead)
 			cfg80211_stop_sched_scan_req(rdev, req, false);
 	}
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 static void cfg80211_propagate_radar_detect_wk(struct work_struct *work)
-- 
2.40.1

