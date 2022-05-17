Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC67529D7E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiEQJII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244368AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10CC23BDA
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778408; x=1684314408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7hqQuWLjGbzwuQc3/hk7pjGIVA3iPZ8N9MJZIMMrtg=;
  b=O1T+UOMoXOMnmaeFiwgNLbjM6U3v+lgA0URwJPXdq5mf9ZaoFM/StABm
   YGypyG7+gQHGvIKEp3CISsthOdCAh3Ag9Q3QVELtvXSxBkTR8s42zsFPr
   UKkiytsUjTG8WweK+VQgzvcj0eXaGyf2HTuGLKjmVk34l5cElU2I+w8IQ
   1zwOl/BkZ5+tZvo/OWYAZFw4qyklSdtLuChs7NHvIblaSJNHfokx8MJZ8
   GcGFp7r+t9t0c7OTGqFvapKvILi985LupCWnZn5FiQ1EMlAtZCTNid4rv
   G0nkpHB3u4DdwfHz04ksMIQ9waqTFPCyqRUAxCE5ofIyizSU5jj5+CvwJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064846"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064846"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679785"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:34 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/10] iwlwifi: mei: fix potential NULL-ptr deref
Date:   Tue, 17 May 2022 12:05:14 +0300
Message-Id: <20220517120045.90c1b1fd534e.Ibb42463e74d0ec7d36ec81df22e171ae1f6268b0@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If SKB allocation fails, continue rather than using the NULL
pointer.

Coverity CID: 1497650

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 3d2eb15a9662..357f14626cf4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1020,6 +1020,8 @@ static void iwl_mei_handle_sap_data(struct mei_cl_device *cldev,
 
 		/* We need enough room for the WiFi header + SNAP + IV */
 		skb = netdev_alloc_skb(netdev, len + QOS_HDR_IV_SNAP_LEN);
+		if (!skb)
+			continue;
 
 		skb_reserve(skb, QOS_HDR_IV_SNAP_LEN);
 		ethhdr = skb_push(skb, sizeof(*ethhdr));
-- 
2.35.1

