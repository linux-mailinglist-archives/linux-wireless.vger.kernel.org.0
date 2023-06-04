Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826257215C2
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjFDJMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjFDJMe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06CED
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869944; x=1717405944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D4JGyonbHwsNgfZLbAYoPEbrTPtTh2H+jY5Som0s7+o=;
  b=cWLUD8oK44sW4nOOfGtSu3O3qlpDQBFwFF38DvdGchqONDdkDwbO+3wz
   lA3xdjD+4LO9w1FFl1v7hsvHSr637YGp6UNdWBa2iDVa+AqU+0bnsWzeE
   M0buWB0ejyQMQ7TUNKx2OqSKaEKGYH+e/KXHA9xo/c5f33J5U+frPJyIE
   AZl7ETBsgH0FFQ19CxcWkYhI7GMOcIsts4lizqEZyo4GboZB3yVUmLwsU
   WG+ADVgdd3b7/EXRfE+Rw3X6A26oVRGyd7uHh/X4EdErBipQyP3XNWz13
   dLnfr4ZDmkIf9B2j7s/BQoylR0WcdWqu3J6ooLP1oZ9WyLLdR3oZ9ejcz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526555"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526555"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804828"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804828"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/16] wifi: mac80211_hwsim: Fix possible NULL dereference
Date:   Sun,  4 Jun 2023 12:11:27 +0300
Message-Id: <20230604120651.f4d889fc98c4.Iae85f527ed245a37637a874bb8b8c83d79812512@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

In a call to mac80211_hwsim_select_tx_link() the sta pointer might
be NULL, thus need to check that it is not NULL before accessing it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index b06a6e78169d..c706abbdaa17 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 /*
@@ -1865,7 +1865,7 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 
 	WARN_ON(is_multicast_ether_addr(hdr->addr1));
 
-	if (WARN_ON_ONCE(!sta->valid_links))
+	if (WARN_ON_ONCE(!sta || !sta->valid_links))
 		return &vif->bss_conf;
 
 	for (i = 0; i < ARRAY_SIZE(vif->link_conf); i++) {
-- 
2.38.1

