Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21546B9D92
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCNRyO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCNRyN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:54:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46BF16319
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816415; x=1710352415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4We5YXMQ+IxcpChlrcLTedueAH0Kh4W4/AFCj6UAeU=;
  b=SetE6aJpdlEE224uueLBEJ+rY/ypV8lCQSPsNzNfKtPasgG8PpON2oGp
   a3qNVqggi5ntj/Kl0unAo9LxJ6gJpggZvQo8+Yk60Vw6pMMjiVv/2sm2C
   DTNOEbo1+OdCjiZXv6o/Z4VeaNdezbmN7S2/owR12k/qZq6b0vGQ8e1lG
   +oj8IANTWHg9TQ1YtSLm6MUW1vW+gZ5orXgrFQprIDM8wmRYLGi9Oocye
   3WqXHXCiWWEqScp9ElLVeNEDwf/+DgS2b3UW1y8hCrXxkxGaPEOkqE+iD
   OhgOeHmibDS1lf8y6IfON0vwIblEetApyXQH5UW7/ltzaBKq4EFo2lyVG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149677"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149677"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200572"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200572"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/22] wifi: iwlwifi: fix typos in comment
Date:   Tue, 14 Mar 2023 19:49:28 +0200
Message-Id: <20230314194113.fb2fc470e949.I1f3a347b533bcdb6bcd310f752ab3349800efb49@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Julia Lawall <Julia.Lawall@inria.fr>

Spelling mistakes (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/img.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index f878ac508801..f5c4d93d1033 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -182,10 +182,10 @@ struct iwl_dump_exclude {
  * @enhance_sensitivity_table: device can do enhanced sensitivity.
  * @init_evtlog_ptr: event log offset for init ucode.
  * @init_evtlog_size: event log size for init ucode.
- * @init_errlog_ptr: error log offfset for init ucode.
+ * @init_errlog_ptr: error log offset for init ucode.
  * @inst_evtlog_ptr: event log offset for runtime ucode.
  * @inst_evtlog_size: event log size for runtime ucode.
- * @inst_errlog_ptr: error log offfset for runtime ucode.
+ * @inst_errlog_ptr: error log offset for runtime ucode.
  * @type: firmware type (&enum iwl_fw_type)
  * @human_readable: human readable version
  *	we get the ALIVE from the uCode
-- 
2.38.1

