Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6646F6D24
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjEDNpi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjEDNpg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57777AB7
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207935; x=1714743935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KC9L5ErI7nijlqB2E+vMtqE4fAy4G28d5MNnEPbh7JU=;
  b=mKguJVI25lpJuw2IEsT9kuTY5edV2kWrgtVTQ3EFvWKeTwIjDd7mAOCI
   yi1k7ifGxtvnrOaXTj8FV99KilvXyM9bo9RcjVRw0tMFR+dJsphVAw1vK
   eLYofIMm/SoqHx2vu6JC0igMnxeUlzz8eU0zDTu9AG1EnydU6NjvOYGZj
   pEZ5jIppurmD2QuGtZUW1CqGZaFp8RDTe4NMdRVPKBrAvI/w9BESakcCm
   jRXfQj9GFvRJuiH74A/fe7BJniaPUhIXuZfl3OfVq//cgxdqjItugQJQ+
   nWI8UvudSqKGm/T/vSi2riWIkVG+WWvG+Pqw4quA3ZMkM+OufUGxIFPau
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242612"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242612"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591720"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591720"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/11] wifi: mac80211: recalc chanctx mindef before assigning
Date:   Thu,  4 May 2023 16:45:04 +0300
Message-Id: <20230504134511.828474-5-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

When we allocate a new channel context, or find an existing one
that is compatible, we currently assign it to a link before its
mindef is updated. This leads to strange situations, especially
in link switching where you switch to an 80 MHz link and expect
it to be active immediately, but the mindef is still configured
to 20 MHz while assigning.  Also, it's strange that the chandef
passed to the assign method's argument is wider than the one in
the context.

Fix this by calculating the mindef with the new link considered
before calling the driver.

In particular, this fixes an iwlwifi problem during link switch
where the firmware would assert because the (link) station that
was added for the AP is configured to transmit at a bandwidth
that's wider than the channel context that it's configured on.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/chan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 1b182cf9d661..77c90ed8f5d7 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -871,6 +871,9 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	}
 
 	if (new_ctx) {
+		/* recalc considering the link we'll use it for now */
+		ieee80211_recalc_chanctx_min_def(local, new_ctx, link);
+
 		ret = drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
 		if (ret)
 			goto out;
-- 
2.38.1

