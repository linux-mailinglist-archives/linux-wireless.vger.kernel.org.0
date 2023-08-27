Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAA789D1B
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjH0LGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjH0LFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:05:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEA139
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134350; x=1724670350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZMWuzhO7nZDmFP1RE624Y3du2iYFBiIh9dSLBuL3GNc=;
  b=cxanXvLv6P6Ul0q2UTGQmBZi2+ZZJrMRCUQR9H5y4fSxjgEhvvlbAWjD
   cyUPPXZT3CBgJQSA3hDht8VTEhMqKL00pIll8EfBopU330run05iAODBG
   +7g6JgWwKkWncACVDY+xu6F0y3zSo3iHnBh1oFKiDJKx0/msaFM8ZFXt9
   fmSq+OGQ9bVOa1IYjzYPWaX0gfJhDAe0rYC7f2JF6r5CWmyYKQo9MKo38
   TF0x+/Eyvdi1jSZGSWPn7fyT21+dyZ7GOHxd6a8QTq4eNEMXwrU/+9hw9
   AQJY4+CbNGhB82NrlfEH+X46DcjU8lKPwhuJoV1uPeRqisNYu7xrxJHna
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301537"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632950"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:54 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: cfg80211: fix off-by-one in element defrag
Date:   Sun, 27 Aug 2023 14:05:19 +0300
Message-Id: <20230827135854.adca9fbd3317.I6b2df45eb71513f3e48efd196ae3cddec362dc1c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If a fragment is the last element, it's erroneously not
accepted. Fix that.

Fixes: f837a653a097 ("wifi: cfg80211: add element defragmentation helper")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 0cf1ce7b6934..19516073c6d5 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2354,8 +2354,8 @@ ssize_t cfg80211_defragment_element(const struct element *elem, const u8 *ies,
 
 	/* elem might be invalid after the memmove */
 	next = (void *)(elem->data + elem->datalen);
-
 	elem_datalen = elem->datalen;
+
 	if (elem->id == WLAN_EID_EXTENSION) {
 		copied = elem->datalen - 1;
 		if (copied > data_len)
@@ -2376,7 +2376,7 @@ ssize_t cfg80211_defragment_element(const struct element *elem, const u8 *ies,
 
 	for (elem = next;
 	     elem->data < ies + ieslen &&
-		elem->data + elem->datalen < ies + ieslen;
+		elem->data + elem->datalen <= ies + ieslen;
 	     elem = next) {
 		/* elem might be invalid after the memmove */
 		next = (void *)(elem->data + elem->datalen);
-- 
2.38.1

