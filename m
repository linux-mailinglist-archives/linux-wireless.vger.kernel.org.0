Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B178735B35
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjFSPhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSPhu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 11:37:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3420B10F
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687189069; x=1718725069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0OHx3q1LGXPAT67Bn2EcJhXnc4HAOrfYlM8qGCW0IEA=;
  b=XLst3xw4882pOEQeDtBR0Wat6Jg8aGc9MUG8uQak/u1V74s0cU+UBIj3
   8dS7hGSDLfzS0TJ5T/mqQat4G8v3yKpdmTvKgQQq9R7cG9c1fMNSpfnIC
   pTSAM+8VbMhjI2/YlolrgIV9OKkCiy7i36EjwF2qC3HgXEnGp6OgEOoo0
   D9jfGgdqMIjJEFLiE7+jKYJJsvi2tPNeHzHSbcDC+JEPfyM8Y3B2+jru2
   S56sEH6y1Nh/7jKPJOlLiTV+2czLUtMH+sVb77ROynqrtMxswEyWq/3sL
   ckzxyz8Kb3YO0DYbUZhfGLXaqDti75HMdSU89XfhZcnaeLYmr3a6PzGjz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="388748395"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="388748395"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 08:37:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="743498207"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="743498207"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 08:37:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 1/9] wifi: mac80211: drop unprotected robust mgmt before 4-way-HS
Date:   Mon, 19 Jun 2023 18:37:38 +0300
Message-Id: <20230619183718.cfbefddccd0c.Ife369dbb61c87e311ce15739d5b2b4763bfdfbae@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619161906.e63e7588198f.Ife369dbb61c87e311ce15739d5b2b4763bfdfbae@changeid>
References: <20230619161906.e63e7588198f.Ife369dbb61c87e311ce15739d5b2b4763bfdfbae@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 net/mac80211/rx.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6ebec32b4ebc..1d2e7a6dd2a1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2418,13 +2418,20 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 
 	if (rx->sta && test_sta_flag(rx->sta, WLAN_STA_MFP)) {
 		if (unlikely(!ieee80211_has_protected(fc) &&
-			     ieee80211_is_unicast_robust_mgmt_frame(rx->skb) &&
-			     rx->key)) {
+			     ieee80211_is_unicast_robust_mgmt_frame(rx->skb))) {
 			if (ieee80211_is_deauth(fc) ||
-			    ieee80211_is_disassoc(fc))
+			    ieee80211_is_disassoc(fc)) {
+				/*
+				 * Permit unprotected deauth/disassoc frames
+				 * during 4-way-HS (key is installed after HS).
+				 */
+				if (!rx->key)
+					return 0;
+
 				cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 							     rx->skb->data,
 							     rx->skb->len);
+			}
 			return -EACCES;
 		}
 		/* BIP does not use Protected field, so need to check MMIE */
-- 
2.38.1

