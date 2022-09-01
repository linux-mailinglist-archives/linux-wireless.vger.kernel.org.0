Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4985A8F13
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 09:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiIAHC4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 03:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiIAHC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 03:02:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07836124849
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=89XeSP8T3BsfNpJWBy/8NZacz8TzzRo84aSFyOK+BGs=; t=1662015707; x=1663225307; 
        b=xt+RX1QNyPQw3Y2SkMiCT/NqM7A2E2PvhLtzZWRDtrFl1P9jDVddMROAzP0rwbGrhHjFLgP6u1v
        yDYiWkWRDX4lRZ6bGps83H7ZdE+PP7VYqCiZphcp9OKGC+GLWfkpp1yTQXsWbK+yeK2Ko0nRqEfne
        dirbrS7kUlDYEkMEpnax79dWQ5BtEh54BCalZs2F7T8wrL6zzaRrxv3DDKHtXIZj7If0m90nYXg39
        Hsc7kJub01no8aQPJpw9JHgw0jlMEfpYb3lDJKk0QBkfkXd39Yubtw0L0oA1XLohvQCiPR65qaki/
        PbUptuR0E4eA0Jr+wjOuSodWys8zCp2sweFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oTeCn-005CQd-0u;
        Thu, 01 Sep 2022 09:01:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: nl80211: add MLD address to assoc BSS entries
Date:   Thu,  1 Sep 2022 09:01:34 +0200
Message-Id: <20220901090133.10cf17b0508f.Ib53e526afe083c823df54903ce334002a9c27b64@changeid>
X-Mailer: git-send-email 2.37.2
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

Add an MLD address attribute to BSS entries that the interface
is currently associated with to help userspace figure out what's
going on.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 573db20403dc..ac31fbd84402 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4959,6 +4959,7 @@ enum nl80211_bss_scan_width {
  *	using the nesting index as the antenna number.
  * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
  * @NL80211_BSS_MLO_LINK_ID: MLO link ID of the BSS (u8).
+ * @NL80211_BSS_MLD_ADDR: MLD address of this BSS if connected to it.
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4985,6 +4986,7 @@ enum nl80211_bss {
 	NL80211_BSS_CHAIN_SIGNAL,
 	NL80211_BSS_FREQUENCY_OFFSET,
 	NL80211_BSS_MLO_LINK_ID,
+	NL80211_BSS_MLD_ADDR,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index dad88d231d56..8ab4c907e284 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10182,8 +10182,10 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 			    (nla_put_u32(msg, NL80211_BSS_STATUS,
 					 NL80211_BSS_STATUS_ASSOCIATED) ||
 			     (wdev->valid_links &&
-			      nla_put_u8(msg, NL80211_BSS_MLO_LINK_ID,
-					 link_id))))
+			      (nla_put_u8(msg, NL80211_BSS_MLO_LINK_ID,
+					  link_id) ||
+			       nla_put(msg, NL80211_BSS_MLD_ADDR, ETH_ALEN,
+				       wdev->u.client.connected_addr)))))
 				goto nla_put_failure;
 		}
 		break;
-- 
2.37.2

