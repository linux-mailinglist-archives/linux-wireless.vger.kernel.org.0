Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70F16AAF65
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCEMRT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCEMRS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A9126E8
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018635; x=1709554635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLSxa1Bih4PTyC2OtAp1u7maErNS7W1iqbmEhCfmA+c=;
  b=kR/1OjZMX+Qkd+TB6b0XrPdLnVJq0UdppmvmXxhKezQkHWFlm6qenfjK
   utiqzCPwoAvy3P4YvPeIG+NWWaNcHLyxf8kY4PRmwC6nUvxTAo20uP2bL
   +8/keV+yqBxJzRqvOcwLMP2UTF+OD9oehY1SYGUg86DxvoPJS6WCmK2rb
   xoqHIuOaxnJl4SV9CLIH9SZn+2z2ZloACbsEJBQZ2xv1FVP5qjljOfie7
   kZLh64QTAaOXxMhA2clfZMaukKkqv03fwtyyBCaXQM0oiV97CzRoLWrKY
   c2QGwmrTJZ6yIaIhRZgPk+fd8OElSvZXIfkYi6Ih8491gT7oDJUVl/5NG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193201"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193201"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355089"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355089"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:13 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/21] wifi: iwlwifi: mvm: rename define to generic name
Date:   Sun,  5 Mar 2023 14:16:23 +0200
Message-Id: <20230305124407.e4f51f347e48.I2d6ecb6eadc95666d2ef9794662ee779488ceac1@changeid>
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

The type RX_NO_DATA_INFO_TYPE_HE_TB_UNMATCHED is applied to all TB
frames including EHT mode, so rename accordingly.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 544d22472a6f..0f190266fffd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -726,7 +726,7 @@ struct iwl_rx_mpdu_desc {
 #define RX_NO_DATA_INFO_TYPE_RX_ERR	1
 #define RX_NO_DATA_INFO_TYPE_NDP	2
 #define RX_NO_DATA_INFO_TYPE_MU_UNMATCHED	3
-#define RX_NO_DATA_INFO_TYPE_HE_TB_UNMATCHED	4
+#define RX_NO_DATA_INFO_TYPE_TB_UNMATCHED	4
 
 #define RX_NO_DATA_INFO_ERR_POS		8
 #define RX_NO_DATA_INFO_ERR_MSK		(0xff << RX_NO_DATA_INFO_ERR_POS)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index f6297a05e014..30f2830d66ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2338,7 +2338,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 			IEEE80211_RADIOTAP_ZERO_LEN_PSDU_SOUNDING;
 		break;
 	case RX_NO_DATA_INFO_TYPE_MU_UNMATCHED:
-	case RX_NO_DATA_INFO_TYPE_HE_TB_UNMATCHED:
+	case RX_NO_DATA_INFO_TYPE_TB_UNMATCHED:
 		rx_status->zero_length_psdu_type =
 			IEEE80211_RADIOTAP_ZERO_LEN_PSDU_NOT_CAPTURED;
 		break;
-- 
2.38.1

