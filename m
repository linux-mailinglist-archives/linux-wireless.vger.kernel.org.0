Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709D97A8BB8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjITS1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjITS1P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:27:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1D135
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234423; x=1726770423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMFIfQcgf3x+UuYJkACjzdW8KVt64vSMABprEsreYfI=;
  b=cQQEvj41aeBn+CMgWh7IJq90BjU3Snk6T698Z6RzFFDAWs0S5soY8U7K
   SyJUQgxajjLVW3jEMvWGOxoGb8ytNJPkmSHWszEGt+Qj70puYAyhWGn8t
   8V1clDpR2yzfh3BAE/9Bd4A0ElGxGifjt82XYF3ux7txFfvCPMQ+01iRa
   uJXJDwNNsw4OYs9K8up/7K855aJ1KOkqdv8oQSxGoSoekJ6Up5G5TgJOM
   8jiIBoo58b4qwm3/JCgJCwpYMWbpfO4OoxIy2Lg3M1GrX1lW6ZP141eoX
   pG5lORT4ZxuON7Z4sBPJ1s/4JkLDljNnZV4YNOXpQ7B+XY74FGBLOh59L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556473"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556473"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424290"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424290"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 17/18] wifi: mac80211: report per-link error during association
Date:   Wed, 20 Sep 2023 21:25:28 +0300
Message-Id: <20230920211508.275fc7f5c426.I8086c0fdbbf92537d6a8b8e80b33387fcfd5553d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

With this cfg80211 can report the link that caused the error to
userspace which is then able to react to it by e.g. removing the link
from the association and retrying.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c1619bb2b11d..a10b9420aa68 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7889,8 +7889,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		/* only calculate the flags, hence link == NULL */
 		err = ieee80211_prep_channel(sdata, NULL, assoc_data->link[i].bss,
 					     &assoc_data->link[i].conn_flags);
-		if (err)
+		if (err) {
+			req->links[i].error = err;
 			goto err_clear;
+		}
 	}
 
 	/* needed for transmitting the assoc frames properly */
-- 
2.38.1

