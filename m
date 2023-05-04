Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D86F6D26
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjEDNpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjEDNpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311847DB3
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207940; x=1714743940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UirbkUlSIYRHUfGjTqLTiQ+5nyU8MCfx894kcZ0O/1U=;
  b=dEs9NWzLJ7sR+J1R3H5FGenQJJccUPNTlkmK30yeDdTaifxY+5w57fkW
   Kkc+hAduizkg7ZfmbNndm4C8zq0aP/P8O+qeMC8spM3kHg9xQc3eRBXCd
   QZbDcAd6ytPiGg57LmUito3w8FLPHKxl2+xAQ5qxhfrumpUfoT08zxGse
   yzVnwwGUynfNU40CJmqzSCL0ikmbMPB3EDD144nFQhIOXITVmo37omSIM
   faj1oNQqZPOtvy0EORz1ZrJxOY0JxWP1wDZN882R8xdAapil5+dVWIfrR
   8COzDxRNI/rTnXZ/TtcfNmr+EAUTMXiuiGIPqZptQptsVrf0bzc5UOqpB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242637"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242637"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591757"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591757"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/11] wifi: mac80211: Fix elements scratch buffer allocation
Date:   Thu,  4 May 2023 16:45:06 +0300
Message-Id: <20230504134511.828474-7-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504134511.828474-1-gregory.greenman@intel.com>
References: <20230504134511.828474-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Current code allocated a scratch buffer that is the length
of the elements. However this is not sufficient as the
defragmentation can happen in the following places concurrently:

- MBSSID element defragmentation
- EHT ML element defragmentation
- EHT ML element sub element defragmentation

Fix the length and the scratch buffer allocation to allow
up to 3 defragmentations.

While at it remove the 'scratch_len' field from
'struct ieee80211_elems_parse_params' as it is not
really needed or used.

Fixes: ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h | 3 ---
 net/mac80211/util.c        | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b0372e76f373..e67c5c754be1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2269,8 +2269,6 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
  *	(or re-association) response frame if this is given
  * @from_ap: frame is received from an AP (currently used only
  *	for EHT capabilities parsing)
- * @scratch_len: if non zero, specifies the requested length of the scratch
- *      buffer; otherwise, 'len' is used.
  */
 struct ieee80211_elems_parse_params {
 	const u8 *start;
@@ -2281,7 +2279,6 @@ struct ieee80211_elems_parse_params {
 	struct cfg80211_bss *bss;
 	int link_id;
 	bool from_ap;
-	size_t scratch_len;
 };
 
 struct ieee802_11_elems *
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ead4b095cc4d..b0c035cf13da 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1604,7 +1604,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	const struct element *non_inherit = NULL;
 	u8 *nontransmitted_profile;
 	int nontransmitted_profile_len = 0;
-	size_t scratch_len = params->scratch_len ?: 3 * params->len;
+	size_t scratch_len = 3 * params->len;
 
 	elems = kzalloc(sizeof(*elems) + scratch_len, GFP_ATOMIC);
 	if (!elems)
-- 
2.38.1

