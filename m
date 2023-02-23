Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19A6A05CA
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjBWKM2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjBWKMT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD651912
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147138; x=1708683138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfNSk1dVqOdAcsSzsI3FCNbHkExYJ/PUpNwOIx7vPus=;
  b=Mn/ecldzm2KM/sNMXvW/PTgCvfTtKyDlOF2Z7Xl8pXl468A9+0nuGeyd
   Sf7iBcKJxeXF9W9fCEiUmbduEi/xOzhHgBLTlAghKHfkC5PMy73sso4Yq
   qjmD1Ev/Np4zjhszs+TnQQTEXZOxOIlVknBocQ1zaA8bEzR+ZtIDe+/cY
   GH22PxFh8PBdglVU34sHm30k23kTKc7/C01MBdTu7lFOR/pGQfGDkZUe2
   1Y0oTMHSMFjIDgaouMEq99+lyYGROmnd49R0zoBNGKoJOToWFP3xEdhg5
   h7oD5Onjriz5Ae07pD9s6rsuvxaWfPngaaAxKGV9aCjS8h1zMDYo6Qhf8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396462"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396462"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245644"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245644"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:11:05 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/21] wifi: nl80211: fix NULL-ptr deref in offchan check
Date:   Thu, 23 Feb 2023 12:09:38 +0200
Message-Id: <20230223114629.ef0db7157926.Iee39c0f6c2d3a59a8227674dc55d52e38b1090cf@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

If, e.g. in AP mode, the link was already created by userspace
but not activated yet, it has a chandef but the chandef isn't
valid and has no channel. Check for this and ignore this link.

Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 22dbc30096b2..a42b37de68b0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8909,7 +8909,7 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 		struct cfg80211_chan_def *chandef;
 
 		chandef = wdev_chandef(wdev, link_id);
-		if (!chandef)
+		if (!chandef || !chandef->chan)
 			continue;
 
 		/*
-- 
2.38.1

