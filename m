Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A37215C0
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjFDJMZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjFDJMY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F41A8
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869935; x=1717405935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IER3USH83s6t6e+RmqeK9sHserWISjxL2Tw65JH/QmI=;
  b=mZTM9NCeoIEmETFeXg6D3h2K1iCM068KcXsDzPoLNLv1+w1viDFRaaBi
   duW68zY4JuKe8dA3DJ1NH2LFfiT0+aj41zaYtIp1rMhDtcW3+PovW77Cz
   xrZutcV6Z6IR/cVd5ReGfIs1N4Ow3E6Jxy9Q3VuVA9Ba/OCbC/ESv048m
   1gwczkQKy3rpjKi6fwrqk0UL8ETdNKP55cajicDwTWtO4dHRUbD1/W8Pm
   wKFzOcRhKqetxHMZm42iuyKLNoxBYz34Com8rya5h7PFs/BILR3OKoT3g
   gqHime+GK2SDNvu5yp6r/bMmvl7nWWpeFqF0ilZZXPcebgnGTQHorq/8g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526544"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526544"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804783"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804783"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/16] wifi: mac80211: remove typecast in a call to ieee80211_config_bw()
Date:   Sun,  4 Jun 2023 12:11:25 +0300
Message-Id: <20230604120651.1b01fef7c81f.Ib6492fe29fe31807b2fe31a84734b55d74b5c314@changeid>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Make "changed" to be u64 as implied by the corresponding enum size.

Fixes: 61513162aa2d ("wifi: mac80211: mlme: shift some code around")
Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c         | 2 +-
 net/mac80211/chan.c        | 2 +-
 net/mac80211/ieee80211_i.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7317e4a5d1ff..49f5122189d3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 77c90ed8f5d7..a7e204de5d54 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * mac80211 - channel management
- * Copyright 2020 - 2022 Intel Corporation
+ * Copyright 2020 - 2023 Intel Corporation
  */
 
 #include <linux/nl80211.h>
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e67c5c754be1..886244d42f04 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #ifndef IEEE80211_I_H
-- 
2.38.1

