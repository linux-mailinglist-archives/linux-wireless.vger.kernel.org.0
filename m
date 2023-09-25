Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24AC7ADB4F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjIYPYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjIYPYj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 11:24:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED71126
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=nu1oHk7mOs/IaEaiYZpvcooosF+/0ac7p7iyDrmaqDw=; t=1695655473; x=1696865073; 
        b=MjPwkH5JN+F5g3I70CHz1eNhFEQauNFqzWgZ+FmigMlM6BXWn8SMTYuKHvE1HnY2M+TLlmgvLEr
        4XYjtC6YHEKAg7mpUqyxvKViFzn98/IE+x1BXULv5oFi2GnE1t0mlR799hrgeShs6UevE1a42dKSK
        MeDHAmVhzahRlyLV61qFi20q0kcSNegcj751QjD0CW0655w2EBtVYj/Zx2jX7aCaryhnw/KWs7Ptf
        D3Q56fpz8lWve2OIlWG6usA2eZeGZyP2JrPPDSLwi9m0Sj9VxR/4ffOXcYFbKU4FYKkm4BHQloCRG
        N/x9Fe0t6uMYbfGc55RmRwbC01o91DolKzMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qknRm-003klf-2a;
        Mon, 25 Sep 2023 17:24:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: add local_state_change to deauth trace
Date:   Mon, 25 Sep 2023 17:24:28 +0200
Message-ID: <20230925172427.585f4064ef71.If96d19601da29ff57ade59a7e2781be5ac21a549@changeid>
X-Mailer: git-send-email 2.41.0
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

Add the local_state_change request to the deauth trace for
easier debugging.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/trace.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index da2b73951c32..f6667bf3fd12 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1321,16 +1321,18 @@ TRACE_EVENT(rdev_deauth,
 		NETDEV_ENTRY
 		MAC_ENTRY(bssid)
 		__field(u16, reason_code)
+		__field(bool, local_state_change)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(bssid, req->bssid);
 		__entry->reason_code = req->reason_code;
+		__entry->local_state_change = req->local_state_change;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM, reason: %u",
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM, reason: %u, local_state_change:%d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
-		  __entry->reason_code)
+		  __entry->reason_code, __entry->local_state_change)
 );
 
 TRACE_EVENT(rdev_disassoc,
-- 
2.41.0

