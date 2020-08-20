Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC9B25EC3C
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Sep 2020 05:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgIFDDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 23:03:20 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:5437 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgIFDDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 23:03:20 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 05 Sep 2020 20:03:19 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Sep 2020 20:03:18 -0700
Received: from tamizhr-linux.qualcomm.com ([10.201.29.73])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Sep 2020 08:33:12 +0530
Received: by tamizhr-linux.qualcomm.com (Postfix, from userid 380741)
        id 5329A2124C; Thu, 20 Aug 2020 08:38:45 +0530 (IST)
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH] iw: print hop_count and path_change info of mpath
Date:   Thu, 20 Aug 2020 08:38:43 +0530
Message-Id: <1597892923-7618-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Print hop_count and path_change info which is already providing
by Driver for all mpath through mpath dump command.

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 mpath.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mpath.c b/mpath.c
index e39c24b..a88f89f 100644
--- a/mpath.c
+++ b/mpath.c
@@ -38,6 +38,8 @@ static int print_mpath_handler(struct nl_msg *msg, void *arg)
 		[NL80211_MPATH_INFO_DISCOVERY_TIMEOUT] = { .type = NLA_U32 },
 		[NL80211_MPATH_INFO_DISCOVERY_RETRIES] = { .type = NLA_U8 },
 		[NL80211_MPATH_INFO_FLAGS] = { .type = NLA_U8 },
+		[NL80211_MPATH_INFO_HOP_COUNT] = { .type = NLA_U8 },
+		[NL80211_MPATH_INFO_PATH_CHANGE] = { .type = NLA_U32 },
 	};
 
 	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
@@ -85,6 +87,12 @@ static int print_mpath_handler(struct nl_msg *msg, void *arg)
 	if (pinfo[NL80211_MPATH_INFO_FLAGS])
 		printf("\t0x%x",
 			nla_get_u8(pinfo[NL80211_MPATH_INFO_FLAGS]));
+	if (pinfo[NL80211_MPATH_INFO_HOP_COUNT])
+		printf("\t%u",
+		       nla_get_u8(pinfo[NL80211_MPATH_INFO_HOP_COUNT]));
+	if (pinfo[NL80211_MPATH_INFO_PATH_CHANGE])
+		printf("\t%u",
+		       nla_get_u32(pinfo[NL80211_MPATH_INFO_PATH_CHANGE]));
 
 	printf("\n");
 	return NL_SKIP;
@@ -218,7 +226,7 @@ static int handle_mpath_dump(struct nl80211_state *state,
 			     enum id_input id)
 {
 	printf("DEST ADDR         NEXT HOP          IFACE\tSN\tMETRIC\tQLEN\t"
-	       "EXPTIME\t\tDTIM\tDRET\tFLAGS\n");
+	       "EXPTIME\t\tDTIM\tDRET\tFLAGS\tHOP_COUNT\tPATH_CHANGE\n");
 	register_handler(print_mpath_handler, NULL);
 	return 0;
 }
-- 
1.9.1

