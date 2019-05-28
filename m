Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6F2D273
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfE1XgY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 19:36:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfE1XgX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 19:36:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 370626087F; Tue, 28 May 2019 23:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559086583;
        bh=SAziLiwc/zmzv4vvBRkWvufiGXRFXuS8IJknu7nOAlE=;
        h=From:To:Cc:Subject:Date:From;
        b=VlfwZ5qZ514xVQ/8VRxuauNatgdOoLeR5QOJhZQyyVa69ZpMuRwDJbMUmRZvB7i8X
         L70FTkP9mInzE+Dae7sK34YOpojDSclYg6jGK5Hke2UoJQjVEc1M71+3QkofXdCwS+
         vWy1bqoBnXLalRr29Bh+SdpsrYsR3z+5/TCKn5mM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A08660795;
        Tue, 28 May 2019 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559086582;
        bh=SAziLiwc/zmzv4vvBRkWvufiGXRFXuS8IJknu7nOAlE=;
        h=From:To:Cc:Subject:Date:From;
        b=QegUidA5+G4KuPHlYOwinlgFIQ7sAYQfjzq/Wbh+O2fYqjG+7bLVdVOE4p9ndAx+J
         ym6i/H3T3ISjztH6CTL0qAkvmeNAGNLuMNlFbTMG5NhZTBlt2fuFeXhLz3y/gAaQY1
         3M16PPxG0YgSXM5O73qMTVkMVVT5/ZtJrsK8rbOE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A08660795
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH] mac80211: free peer keys before vif down in mesh
Date:   Tue, 28 May 2019 16:36:16 -0700
Message-Id: <1559086576-27560-1-git-send-email-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.1.2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

freeing peer keys after vif down is resulting in peer key uninstall
to fail due to interface lookup failure. so fix that.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 net/mac80211/mesh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 766e5e5bab8a..bd68f5a87b26 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -929,6 +929,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 
 	/* flush STAs and mpaths on this iface */
 	sta_info_flush(sdata);
+	ieee80211_free_keys(sdata, true);
 	mesh_path_flush_by_iface(sdata);
 
 	/* stop the beacon */
-- 
2.1.2

