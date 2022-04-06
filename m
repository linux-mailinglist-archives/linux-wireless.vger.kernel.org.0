Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4314F63CE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiDFPjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbiDFPi3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:38:29 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77E22E96F
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:53:01 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nc4TY-000pov-2i;
        Wed, 06 Apr 2022 15:09:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net, kvalo@kernel.org
Cc:     luca@coelho.fi, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed,  6 Apr 2022 15:09:18 +0300
Message-Id: <iwlwifi.20220406145756.40cc8312dd81.I78d5704923b6e1a9f574ad5da1705d276352e298@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406120924.979792-1-luca@coelho.fi>
References: <20220406120924.979792-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 1/7] nl80211: add RX and TX timestamp attributes
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add attributes for reporting hardware timestamps for management frames
RX and TX. These attributes will be used for reporting hardware
timestamps for Timing measurement and Fine timing measurement action
frames, which will allow userspace applications to measure the path
delay between devices and sync clocks.
For TX, these attributes are used for reporting the frame RX time and
the ack TX time. For TX, they are used for reporting the frame TX time
and the ack RX time.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/uapi/linux/nl80211.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0568a79097b8..1554854c03e3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -753,6 +753,9 @@
  *	%NL80211_ATTR_CSA_C_OFFSETS_TX is an array of offsets to CSA
  *	counters which will be updated to the current value. This attribute
  *	is used during CSA period.
+ *	For RX notification, %NL80211_ATTR_RX_HW_TIMESTAMP may be included to
+ *	indicate the frame RX timestamp and %NL80211_ATTR_TX_HW_TIMESTAMP may
+ *	be included to indicate the ack TX timestamp.
  * @NL80211_CMD_FRAME_WAIT_CANCEL: When an off-channel TX was requested, this
  *	command may be used with the corresponding cookie to cancel the wait
  *	time if it is known that it is no longer necessary.  This command is
@@ -763,7 +766,9 @@
  *	transmitted with %NL80211_CMD_FRAME. %NL80211_ATTR_COOKIE identifies
  *	the TX command and %NL80211_ATTR_FRAME includes the contents of the
  *	frame. %NL80211_ATTR_ACK flag is included if the recipient acknowledged
- *	the frame.
+ *	the frame. %NL80211_ATTR_TX_HW_TIMESTAMP may be included to indicate the
+ *	tx timestamp and %NL80211_ATTR_RX_HW_TIMESTAMP may be included to
+ *	indicate the ack RX timestamp.
  * @NL80211_CMD_ACTION_TX_STATUS: Alias for @NL80211_CMD_FRAME_TX_STATUS for
  *	backward compatibility.
  *
@@ -2663,6 +2668,18 @@ enum nl80211_commands {
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
  *	only if %NL80211_STA_FLAG_WME is set.
  *
+ * @NL80211_ATTR_TX_HW_TIMESTAMP: Hardware timestamp for TX operation in
+ *	nanoseconds (u64). This is the device clock timestamp so it will
+ *	probably reset when the device is stopped or the firmware is reset.
+ *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the frame TX
+ *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
+ *	the ack TX timestamp.
+ * @NL80211_ATTR_RX_HW_TIMESTAMP: Hardware timestamp for RX operation in
+ *	nanoseconds (u64). This is the device clock timestamp so it will
+ *	probably reset when the device is stopped or the firmware is reset.
+ *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
+ *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
+ *	the incoming frame RX timestamp.
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3175,6 +3192,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EHT_CAPABILITY,
 
+	NL80211_ATTR_TX_HW_TIMESTAMP,
+	NL80211_ATTR_RX_HW_TIMESTAMP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6172,6 +6192,10 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_RADAR_BACKGROUND: Device supports background radar/CAC
  *	detection.
  *
+ * @NL80211_EXT_FEATURE_HW_TIMESTAMP: Device supports timestamping timing
+ *	measurement and fine timing measurement action frames and their acks
+ *	on TX and RX.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6239,6 +6263,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
+	NL80211_EXT_FEATURE_HW_TIMESTAMP,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.35.1

