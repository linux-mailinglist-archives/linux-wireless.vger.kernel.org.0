Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D947215B7
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjFDJL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjFDJL4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:11:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506CE3
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869915; x=1717405915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rCuDsU87b4c1bQPJ6a3Kjnnfph40jSykkRNmbCcbc3Y=;
  b=KUmhVFXjYhCLaNomqJ89gEIkCalhS6BB+4sHTZ3t4IsYvhiynq27rJCv
   SHYsDVZH199XU8fePUSg1ddJ2SeZIAFiumBTIHcw7pQElOpeWnLe2AzEg
   Q00rNKUgIrLF2kpW7UXDx9maZxMQA1agiyu+0aO8GgMPPo6CUI1cx++84
   EEhmQB/yDzVNDf1LqUxv3GMk0UvqvSTei3i15P+0xki2W5sh18SPoz4FP
   O1ajwlIwk7kdiN/mvfb8q18LBW1rndjCMcEGifrBUbZ9VIGBwiM2TnAJj
   Y+8WS3WIaOA6/5CvonDF5UQrQV4gTDkXX5tqBj22WCd1OekMZILuu8OI2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526498"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526498"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804434"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804434"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:11:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/16] wifi: mac80211: mlme: fix non-inheritence element
Date:   Sun,  4 Jun 2023 12:11:16 +0300
Message-Id: <20230604120651.3addaa5c4782.If3a78f9305997ad7ef4ba7ffc17a8234c956f613@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There were two bugs when creating the non-inheritence
element:
 1) 'at_extension' needs to be declared outside the loop,
    otherwise the value resets every iteration and we
    can never really switch properly
 2) 'added' never got set to true, so we always cut off
    the extension element again at the end of the function

This shows another issue that we might add a list but no
extension list, but we need to make the extension list a
zero-length one in that case.

Fix all these issues. While at it, add a comment explaining
the trim.

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4ea383aafcac..97671734427c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1217,6 +1217,7 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 					       const u16 *inner)
 {
 	unsigned int skb_len = skb->len;
+	bool at_extension = false;
 	bool added = false;
 	int i, j;
 	u8 *len, *list_len = NULL;
@@ -1228,7 +1229,6 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 	for (i = 0; i < PRESENT_ELEMS_MAX && outer[i]; i++) {
 		u16 elem = outer[i];
 		bool have_inner = false;
-		bool at_extension = false;
 
 		/* should at least be sorted in the sense of normal -> ext */
 		WARN_ON(at_extension && elem < PRESENT_ELEM_EXT_OFFS);
@@ -1257,8 +1257,14 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 		}
 		*list_len += 1;
 		skb_put_u8(skb, (u8)elem);
+		added = true;
 	}
 
+	/* if we added a list but no extension list, make a zero-len one */
+	if (added && (!at_extension || !list_len))
+		skb_put_u8(skb, 0);
+
+	/* if nothing added remove extension element completely */
 	if (!added)
 		skb_trim(skb, skb_len);
 	else
-- 
2.38.1

