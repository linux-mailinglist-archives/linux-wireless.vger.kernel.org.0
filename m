Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A613E7327F7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbjFPGyn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbjFPGyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308101FF5
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898478; x=1718434478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MfgXk0Qpnzmjj1AtNwDZHSZL+YVHc3MLcB69TfsTHNs=;
  b=HoJvrRi8FewHCA9xyQVqKC2fDIFSwuzeW0Rwok76dky2f/bTGeNpDWWB
   a0pYgCquxNJi7HpngFhcpkyp0DJETq/VMRb2r+wUAIC2p512m3RhaBdGP
   WgJ52QSNeA7NxtASpVVI4dP4FjbA8Vd9+4tSPTuEOC8atMsYDQelKG24U
   kAsRCgmoik+IFRs7CY72wLtVh8I9IDjGdHTyFfB+l/a015YwIQXrhzYXH
   NxysaYtrKT+VVZxgBliMU1Zwj+nybwePPRxNbsM7eFubGQVNkjpzvKgNA
   ZSs9qDxeiUfHAt95rW1PwLZ6K+ZWZuaPGiF24iuCHQrAaGnRzOhbqIn8o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078825"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720045"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720045"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/20] wifi: mac80211: stop passing cbss to parser
Date:   Fri, 16 Jun 2023 09:53:55 +0300
Message-Id: <20230616094948.66d2605ff0ad.I7cdd1d390e7b0735c46204231a9e636d45b7f1e4@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

In both of these cases (config_link, prep_channel) it is not needed
to parse the MBSSID data for a nontransmitted BSS. In the config_link
case the frame does not contain any MBSSID element and inheritance
rules are only needed for the ML STA profile. While in the
prep_channel case the IEs have already been processed by cfg80211 and
are already exploded.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 738822b82d3e..171ba9d237c2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4709,7 +4709,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct ieee80211_elems_parse_params parse_params = {
-		.bss = cbss,
 		.link_id = -1,
 		.from_ap = true,
 	};
-- 
2.38.1

