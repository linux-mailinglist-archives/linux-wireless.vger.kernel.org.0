Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE96789D24
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjH0LGf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjH0LGK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DECE139
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134368; x=1724670368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PcPFXWhZlYlXcPBTNN7scKVW31bxcoltMdM1qSzgoNs=;
  b=I/jOwLLa4r0A10WVRHIwsMEPDDVIi60TSwDSgohXaRBdQHFaZM3rn3sl
   c4Mjt4dyQaAQ7DWibDxoNUWewIViehVHA1bUyOg8xupYqgSQiTswf4bsH
   KmwxNOj51Q/KmFi+ury2CX877TvoR403HpbkWjCpv+Hn3Jn5FlY/raW6x
   oRQcDNRA99oROKncP95N6u8PhP09M+qY2GRyc4LHY0LfoXdlUzjXrBn1q
   Rqrxto/dUiQWLIKlI+qjvXhSqJZWjkinf/c8NAovEk9rR+FstEhFHywMj
   SldINXqwSzG2vmOtrlsMp/+7geLPgNqqKPHRRwQ0fKaMKv1CS/gbaqTel
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301569"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301569"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881633000"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: mac80211_hwsim: clean up kernel-doc
Date:   Sun, 27 Aug 2023 14:05:27 +0300
Message-Id: <20230827135854.6127359dba54.I8a9ab3d5fc0c0041624b96ab7350097f3f60fbe0@changeid>
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

Clean up kernel-doc in hwsim's header file.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index 92126f02c58f..4676cdaf4cfd 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -3,7 +3,7 @@
  * mac80211_hwsim - software simulator of 802.11 radio(s) for mac80211
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
- * Copyright (C) 2020, 2022 Intel Corporation
+ * Copyright (C) 2020, 2022-2023 Intel Corporation
  */
 
 #ifndef __MAC80211_HWSIM_H
@@ -86,7 +86,7 @@ enum hwsim_tx_control_flags {
  *	with %HWSIM_CMD_REPORT_PMSR.
  * @__HWSIM_CMD_MAX: enum limit
  */
-enum {
+enum hwsim_commands {
 	HWSIM_CMD_UNSPEC,
 	HWSIM_CMD_REGISTER,
 	HWSIM_CMD_FRAME,
@@ -117,11 +117,11 @@ enum {
  *	the frame was broadcasted from
  * @HWSIM_ATTR_FRAME: Data array
  * @HWSIM_ATTR_FLAGS: mac80211 transmission flags, used to process
-	properly the frame at user space
+ *	properly the frame at user space
  * @HWSIM_ATTR_RX_RATE: estimated rx rate index for this frame at user
-	space
+ *	space
  * @HWSIM_ATTR_SIGNAL: estimated RX signal for this frame at user
-	space
+ *	space
  * @HWSIM_ATTR_TX_INFO: ieee80211_tx_rate array
  * @HWSIM_ATTR_COOKIE: sk_buff cookie to identify the frame
  * @HWSIM_ATTR_CHANNELS: u32 attribute used with the %HWSIM_CMD_CREATE_RADIO
@@ -140,6 +140,7 @@ enum {
  *	command to force radio removal when process that created the radio dies
  * @HWSIM_ATTR_RADIO_NAME: Name of radio, e.g. phy666
  * @HWSIM_ATTR_NO_VIF:  Do not create vif (wlanX) when creating radio.
+ * @HWSIM_ATTR_PAD: padding attribute for 64-bit values, ignore
  * @HWSIM_ATTR_FREQ: Frequency at which packet is transmitted or received.
  * @HWSIM_ATTR_TX_INFO_FLAGS: additional flags for corresponding
  *	rates of %HWSIM_ATTR_TX_INFO
@@ -156,9 +157,7 @@ enum {
  *	to provide peer measurement result (nl80211_peer_measurement_attrs)
  * @__HWSIM_ATTR_MAX: enum limit
  */
-
-
-enum {
+enum hwsim_attrs {
 	HWSIM_ATTR_UNSPEC,
 	HWSIM_ATTR_ADDR_RECEIVER,
 	HWSIM_ATTR_ADDR_TRANSMITTER,
@@ -259,7 +258,7 @@ enum hwsim_tx_rate_flags {
  * struct hwsim_tx_rate - rate selection/status
  *
  * @idx: rate index to attempt to send with
- * @count: number of tries in this rate before going to the next rate
+ * @flags: the rate flags according to &enum hwsim_tx_rate_flags
  *
  * A value of -1 for @idx indicates an invalid rate and, if used
  * in an array of retry rates, that no more rates should be tried.
@@ -287,7 +286,7 @@ struct hwsim_tx_rate_flag {
  * @HWSIM_VQ_RX: receive frames and transmission info reports
  * @HWSIM_NUM_VQS: enum limit
  */
-enum {
+enum hwsim_vqs {
 	HWSIM_VQ_TX,
 	HWSIM_VQ_RX,
 	HWSIM_NUM_VQS,
-- 
2.38.1

