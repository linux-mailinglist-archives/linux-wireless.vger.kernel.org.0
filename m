Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE956AAF5E
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCEMQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:16:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4A61258A
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018614; x=1709554614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7G/N8V8v+1rv+PjwaNIi/Xf+ILGGerW30c0fZihVP80=;
  b=Z0x6EvqrHKYYSN3mB3FzW98Mbkt+puLRJGp1+IeQZfr28QqCj/faIw/p
   GiPinnlKcBRX6xB0p7tD34UBkx3McZ05pVrjqRryPm4Ff12vfvjcEhguf
   Woqxwr0qkDq9y9oAKoyhPrEmeZCy4u1ia7PFdrHNYcwAF8ICqhgWrdS6H
   0Wi6FnGwT4Tips4hJeXQ+UAgPc/qxH8M2KrEbFtQ4PZ83KP53pQGMgyDe
   pFvteEqyXpkvila/ep5WsrF0MwYM9fJ5nqsiICHvar0e6jkfonCTWP5yI
   wn5wbnWhqHYKH7bDwyyaJz2Ph1I510Jhv5RZJ7KiGzco58CgSKgC6cSAB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193148"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708354981"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708354981"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:16:52 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/21] wifi: iwlwifi: mvm: add LSIG info to radio tap info in EHT
Date:   Sun,  5 Mar 2023 14:16:15 +0200
Message-Id: <20230305124406.53edcfc049fb.Iec0401faead108aa5130c23c604cfb88ef2943de@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Nothing change with LSIG in EHT so just extend the switch case to
include EHT standard.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index d1769464d75b..3d7717fdb4d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1594,6 +1594,10 @@ static void iwl_mvm_decode_lsig(struct sk_buff *skb,
 	case IWL_RX_PHY_INFO_TYPE_HE_MU:
 	case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
 	case IWL_RX_PHY_INFO_TYPE_HE_TB:
+	case IWL_RX_PHY_INFO_TYPE_EHT_MU:
+	case IWL_RX_PHY_INFO_TYPE_EHT_TB:
+	case IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT:
+	case IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT:
 		lsig = skb_put(skb, sizeof(*lsig));
 		lsig->data1 = cpu_to_le16(IEEE80211_RADIOTAP_LSIG_DATA1_LENGTH_KNOWN);
 		lsig->data2 = le16_encode_bits(le32_get_bits(phy_data->d1,
-- 
2.38.1

