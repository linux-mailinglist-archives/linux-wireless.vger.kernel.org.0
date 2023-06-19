Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6F73587A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjFSN1J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFSN1I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA01127
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181228; x=1718717228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8TrFGxNGF3jBksj/k+F4zykFcZbf5mLMgL6XZNi5N+0=;
  b=k2MR0a24BND7V48p2JDhKho5AFX9cnQFKRFCxZwq25An0cLIWKXRaLHf
   2/qCp2uCpoBY3Qc6smC2NNgtaqp/tMIyrfkKeDhgjXA+MLYx0cze4PU51
   KyRI691t4j4Z+Bjv08IOsORjFSexnkhoA5FipnG4KyW8/Q08XhsIZ+97M
   hWshGdqu/TI81yknuG8aCzMhKOhZCHPf8WfjtUTZYiwrWtak1/jY4jUPF
   T2+GbExDqZmYaQK+1vKHi4+nYKzobbgp2MWMKvAvfScDChFDQcv/2T2Dv
   UWH2kYHwdbGhADNPfazBh2N65j60tR/DRgkbCLVzAHn8Wk7drPr1FawOY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240643"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240643"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871696"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871696"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/9] wifi: mac80211: drop unprotected robust mgmt before 4-way-HS
Date:   Mon, 19 Jun 2023 16:26:45 +0300
Message-Id: <20230619161906.e63e7588198f.Ife369dbb61c87e311ce15739d5b2b4763bfdfbae@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619132653.902084-1-gregory.greenman@intel.com>
References: <20230619132653.902084-1-gregory.greenman@intel.com>
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

From: Alon Giladi <alon.giladi@intel.com>

When MFP is used, drop unprotected robust management frames also
before the 4-way handshake has been completed, i.e. no key has
been installed yet.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/rx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6ebec32b4ebc..a2109d61487f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2418,8 +2418,7 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 
 	if (rx->sta && test_sta_flag(rx->sta, WLAN_STA_MFP)) {
 		if (unlikely(!ieee80211_has_protected(fc) &&
-			     ieee80211_is_unicast_robust_mgmt_frame(rx->skb) &&
-			     rx->key)) {
+			     ieee80211_is_unicast_robust_mgmt_frame(rx->skb))) {
 			if (ieee80211_is_deauth(fc) ||
 			    ieee80211_is_disassoc(fc))
 				cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
-- 
2.38.1

