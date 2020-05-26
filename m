Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9F1C99D4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgEGSvE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 14:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgEGSvE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 14:51:04 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC93A2495A;
        Thu,  7 May 2020 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877463;
        bh=dVZVU3NDS8wD8l/CPk72dFvVmkwIyU9kfIuksk0czLo=;
        h=Date:From:To:Cc:Subject:From;
        b=DxyNfXLQfIx4viNfDXKjhhEIfNqpgB/PyqZZY+EwpuAeOlvfzztXwgjnVuOeuscTz
         ha5VrAl0RAQqW0DfsE+U7Scq4YEWRLEqvRYY8iQa/5w1zUFxoti8LvZ5mUBnmrdjJJ
         R7fqGE8CpVnqEPDap9DpskCQ/+J0Li4dHVogac60=
Date:   Thu, 7 May 2020 13:55:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlegacy: Replace zero-length array with flexible-array
Message-ID: <20200507185529.GA14639@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/commands.h     |   22 ++++++++++-----------
 drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h |    4 +--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
index dd744135c956..89c6671b32bc 100644
--- a/drivers/net/wireless/intel/iwlegacy/commands.h
+++ b/drivers/net/wireless/intel/iwlegacy/commands.h
@@ -203,7 +203,7 @@ struct il_cmd_header {
 	__le16 sequence;
 
 	/* command or response/notification data follows immediately */
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /**
@@ -1112,7 +1112,7 @@ struct il_wep_cmd {
 	u8 global_key_type;
 	u8 flags;
 	u8 reserved;
-	struct il_wep_key key[0];
+	struct il_wep_key key[];
 } __packed;
 
 #define WEP_KEY_WEP_TYPE 1
@@ -1166,7 +1166,7 @@ struct il3945_rx_frame_stats {
 	u8 agc;
 	__le16 sig_avg;
 	__le16 noise_diff;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct il3945_rx_frame_hdr {
@@ -1175,7 +1175,7 @@ struct il3945_rx_frame_hdr {
 	u8 reserved1;
 	u8 rate;
 	__le16 len;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct il3945_rx_frame_end {
@@ -1211,7 +1211,7 @@ struct il4965_rx_non_cfg_phy {
 	__le16 ant_selection;	/* ant A bit 4, ant B bit 5, ant C bit 6 */
 	__le16 agc_info;	/* agc code 0:6, agc dB 7:13, reserved 14:15 */
 	u8 rssi_info[6];	/* we use even entries, 0/2/4 for A/B/C rssi */
-	u8 pad[0];
+	u8 pad[];
 } __packed;
 
 /*
@@ -1409,7 +1409,7 @@ struct il3945_tx_cmd {
 	 * length is 26 or 30 bytes, followed by payload data
 	 */
 	u8 payload[0];
-	struct ieee80211_hdr hdr[0];
+	struct ieee80211_hdr hdr[];
 } __packed;
 
 /*
@@ -1511,7 +1511,7 @@ struct il_tx_cmd {
 	 * length is 26 or 30 bytes, followed by payload data
 	 */
 	u8 payload[0];
-	struct ieee80211_hdr hdr[0];
+	struct ieee80211_hdr hdr[];
 } __packed;
 
 /* TX command response is sent after *3945* transmission attempts.
@@ -2520,7 +2520,7 @@ struct il3945_scan_cmd {
 	 * for one scan to complete (i.e. receive N_SCAN_COMPLETE)
 	 * before requesting another scan.
 	 */
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct il_scan_cmd {
@@ -2564,7 +2564,7 @@ struct il_scan_cmd {
 	 * for one scan to complete (i.e. receive N_SCAN_COMPLETE)
 	 * before requesting another scan.
 	 */
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /* Can abort will notify by complete notification with abort status. */
@@ -2664,7 +2664,7 @@ struct il3945_tx_beacon_cmd {
 	__le16 tim_idx;
 	u8 tim_size;
 	u8 reserved1;
-	struct ieee80211_hdr frame[0];	/* beacon frame */
+	struct ieee80211_hdr frame[];	/* beacon frame */
 } __packed;
 
 struct il_tx_beacon_cmd {
@@ -2672,7 +2672,7 @@ struct il_tx_beacon_cmd {
 	__le16 tim_idx;
 	u8 tim_size;
 	u8 reserved1;
-	struct ieee80211_hdr frame[0];	/* beacon frame */
+	struct ieee80211_hdr frame[];	/* beacon frame */
 } __packed;
 
 /******************************************************************************
diff --git a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
index a3b490501a70..1e8ab704dbfb 100644
--- a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
+++ b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
@@ -53,7 +53,7 @@ struct ieee80211_measurement_params {
 struct ieee80211_info_element {
 	u8 id;
 	u8 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct ieee80211_measurement_request {
@@ -61,7 +61,7 @@ struct ieee80211_measurement_request {
 	u8 token;
 	u8 mode;
 	u8 type;
-	struct ieee80211_measurement_params params[0];
+	struct ieee80211_measurement_params params[];
 } __packed;
 
 struct ieee80211_measurement_report {

