Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD487347C7
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFRSux (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjFRSuv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853C1B4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114245; x=1718650245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cyzQNaQVOvPw8BlNvCP05w9HpuLfECh6xXiYqQlqhAQ=;
  b=aJUr0Glyu97ap/PcRKZxEu9kNFhqM+kkNRIoGvVfX1oVnpp4yzhjlBXe
   Nvy2jWY0zqmtUIlGHY1K8vRnqjNlkvYcr6+50CjfH2LLnhhKNxHzauaXf
   8MkLqgjLhh5fuD/gbTMonDKOTU8yChvj5HBjJ3rOpByCZkwR5d8YwCsnn
   26X+mMFVvc70ASa+tlXrettZnXyRu99r2CrrKigF35ZPODDyXsY7r78YJ
   YZ5k+3bmWYso2kX8C04APpngZ8DlQ51XHb+xj8UNdBLfbM6A5jtut8fhP
   iRtScB6GZMDsEFOmQMJgoP0G6fCivWaXldoTtpusPudTn06QiD8IKqbDQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116658"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116658"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:45 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234037"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234037"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/20] wifi: cfg80211: do not scan disabled links on 6GHz
Date:   Sun, 18 Jun 2023 21:49:54 +0300
Message-Id: <20230618214436.4f7384006471.Iff8f1081e76a298bd25f9468abb3a586372cddaa@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

If a link is disabled on 6GHz, we should not send a probe request on the
channel to resolve it. Simply skip such RNR entries so that the link is
ignored.

Userspace can still see the link in the RNR and may generate an ML probe
request in order to associate to the (currently) disabled link.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 46488650ecbc..cf0ad544cb99 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -587,6 +587,13 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 		entry->short_ssid_valid = true;
 
 		bss_params = tbtt_info->bss_params;
+
+		/* Ignore disabled links */
+		if (length >= offsetofend(typeof(*tbtt_info), mld_params)) {
+			if (le16_get_bits(tbtt_info->mld_params.params,
+					  IEEE80211_RNR_MLD_PARAMS_DISABLED_LINK))
+				return -EINVAL;
+		}
 	} else {
 		struct ieee80211_tbtt_info_7_8_9 *tbtt_info = (void *)pos;
 
-- 
2.38.1

