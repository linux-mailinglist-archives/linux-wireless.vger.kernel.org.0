Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2A789D20
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjH0LGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjH0LGD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2D183
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134361; x=1724670361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HXyzoUUXxWARbLZH0087T5E/cp4eHT20vq2bjgaEeY=;
  b=jpiEf/qq/4LsM/N1ZFjv1VI8y9TGXJEm8jXJbfxXP7mk2r72NcZKS1Kx
   kJ79pcuOrzsBwLKHc3SBF/5GfkVZWpdKC3XiMMCzhAT8qrQafLx6LlrKP
   YihxxhEdefs4iTEKed1PZ1rqN5feejcCVU/xe+AgXKLa2WB7EFVK9IOT1
   QVxRBZj0+ol/rqHEfs/ggH59tIYB2x2TGu9aFK83SpmEHOlVhqUKlOoXZ
   S1EzebeVb/JyUywpguFZw69RbqnzCfoAaePa62Urr5lruCKujv/9AvMrT
   DUmyKUgUsfSq5X931PChMXybrm8l4OvtIMW30VnIfGLt8plZ4iH4upOco
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301555"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301555"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632981"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: mac80211: remove unnecessary struct forward declaration
Date:   Sun, 27 Aug 2023 14:05:24 +0300
Message-Id: <20230827135854.33a5591dfdeb.If4e7e1a1cb4c04f0afd83db7401c780404dca699@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This just causes kernel-doc to complain at this spot, but
isn't actually needed anyway, so remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8afeb1398b33..a260df25f592 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -619,7 +619,6 @@ struct ieee80211_if_ocb {
  * vendor-specific mesh synchronization
  *
  */
-struct ieee802_11_elems;
 struct ieee80211_mesh_sync_ops {
 	void (*rx_bcn_presp)(struct ieee80211_sub_if_data *sdata, u16 stype,
 			     struct ieee80211_mgmt *mgmt, unsigned int len,
-- 
2.38.1

