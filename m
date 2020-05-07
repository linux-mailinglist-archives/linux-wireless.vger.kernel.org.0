Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A781C99CB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 20:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgEGSuZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 14:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgEGSuZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 14:50:25 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7229E24957;
        Thu,  7 May 2020 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877424;
        bh=nqOGOlFxuyC6xZdJp9v/9qIDCZ0j/hOOQI15Lck0i2o=;
        h=Date:From:To:Cc:Subject:From;
        b=rKGN1yf2eLyFyXoiJ9HPQgLt8tiaJmevWivWKV5KuOd8WIkrknOwHSkIXqBYryvAl
         1PD1t4LOXnvJjeGZOs1KFrUglNwYlJnNNNMMXbc5BblMdJanv6kJQkYzdDLYtP0OPb
         MoDn81SI8RSYglTAbmXkOvG1iL4zdFYXboWxoRe0=
Date:   Thu, 7 May 2020 13:54:51 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipw2x00: Replace zero-length array with flexible-array
Message-ID: <20200507185451.GA14603@embeddedor>
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
 drivers/net/wireless/intel/ipw2x00/ipw2200.c |    2 -
 drivers/net/wireless/intel/ipw2x00/ipw2200.h |   10 ++++-----
 drivers/net/wireless/intel/ipw2x00/libipw.h  |   28 +++++++++++++--------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 60b5e08dd6df..64563840df00 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -3386,7 +3386,7 @@ struct ipw_fw {
 	__le32 boot_size;
 	__le32 ucode_size;
 	__le32 fw_size;
-	u8 data[0];
+	u8 data[];
 };
 
 static int ipw_get_fw(struct ipw_priv *priv,
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.h b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
index 4346520545c4..09fa7f19050f 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -448,7 +448,7 @@ struct tfd_command {
 	u8 index;
 	u8 length;
 	__le16 reserved;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct tfd_data {
@@ -675,7 +675,7 @@ struct ipw_rx_frame {
 	// is identical)
 	u8 rtscts_seen;		// 0x1 RTS seen ; 0x2 CTS seen
 	__le16 length;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct ipw_rx_header {
@@ -1002,7 +1002,7 @@ struct ipw_cmd {	 /* XXX */
    * Incoming parameters listed 1-st, followed by outcoming params.
    * nParams=(len+3)/4+status_len
    */
-	u32 param[0];
+	u32 param[];
 } __packed;
 
 #define STATUS_HCMD_ACTIVE      (1<<0)	/**< host command in progress */
@@ -1108,7 +1108,7 @@ struct ipw_fw_error {	 /* XXX */
 	u32 log_len;
 	struct ipw_error_elem *elem;
 	struct ipw_event *log;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 #ifdef CONFIG_IPW2200_PROMISCUOUS
@@ -1153,7 +1153,7 @@ struct ipw_rt_hdr {
 	s8 rt_dbmsignal;	/* signal in dbM, kluged to signed */
 	s8 rt_dbmnoise;
 	u8 rt_antenna;	/* antenna number */
-	u8 payload[0];  /* payload... */
+	u8 payload[];  /* payload... */
 } __packed;
 #endif
 
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw.h b/drivers/net/wireless/intel/ipw2x00/libipw.h
index e4a6ab4e8391..e87538a8b88b 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw.h
+++ b/drivers/net/wireless/intel/ipw2x00/libipw.h
@@ -334,7 +334,7 @@ struct libipw_hdr_1addr {
 	__le16 frame_ctl;
 	__le16 duration_id;
 	u8 addr1[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct libipw_hdr_2addr {
@@ -342,7 +342,7 @@ struct libipw_hdr_2addr {
 	__le16 duration_id;
 	u8 addr1[ETH_ALEN];
 	u8 addr2[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct libipw_hdr_3addr {
@@ -352,7 +352,7 @@ struct libipw_hdr_3addr {
 	u8 addr2[ETH_ALEN];
 	u8 addr3[ETH_ALEN];
 	__le16 seq_ctl;
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct libipw_hdr_4addr {
@@ -363,7 +363,7 @@ struct libipw_hdr_4addr {
 	u8 addr3[ETH_ALEN];
 	__le16 seq_ctl;
 	u8 addr4[ETH_ALEN];
-	u8 payload[0];
+	u8 payload[];
 } __packed;
 
 struct libipw_hdr_3addrqos {
@@ -380,7 +380,7 @@ struct libipw_hdr_3addrqos {
 struct libipw_info_element {
 	u8 id;
 	u8 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /*
@@ -406,7 +406,7 @@ struct libipw_auth {
 	__le16 transaction;
 	__le16 status;
 	/* challenge */
-	struct libipw_info_element info_element[0];
+	struct libipw_info_element info_element[];
 } __packed;
 
 struct libipw_channel_switch {
@@ -442,7 +442,7 @@ struct libipw_disassoc {
 struct libipw_probe_request {
 	struct libipw_hdr_3addr header;
 	/* SSID, supported rates */
-	struct libipw_info_element info_element[0];
+	struct libipw_info_element info_element[];
 } __packed;
 
 struct libipw_probe_response {
@@ -452,7 +452,7 @@ struct libipw_probe_response {
 	__le16 capability;
 	/* SSID, supported rates, FH params, DS params,
 	 * CF params, IBSS params, TIM (if beacon), RSN */
-	struct libipw_info_element info_element[0];
+	struct libipw_info_element info_element[];
 } __packed;
 
 /* Alias beacon for probe_response */
@@ -463,7 +463,7 @@ struct libipw_assoc_request {
 	__le16 capability;
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
-	struct libipw_info_element info_element[0];
+	struct libipw_info_element info_element[];
 } __packed;
 
 struct libipw_reassoc_request {
@@ -471,7 +471,7 @@ struct libipw_reassoc_request {
 	__le16 capability;
 	__le16 listen_interval;
 	u8 current_ap[ETH_ALEN];
-	struct libipw_info_element info_element[0];
+	struct libipw_info_element info_element[];
 } __packed;
 
 struct libipw_assoc_response {
@@ -480,7 +480,7 @@ struct libipw_assoc_response {
 	__le16 status;
 	__le16 aid;
 	/* supported rates */
-	struct libipw_info_element info_element[0];
+	struct libipw_info_element info_element[];
 } __packed;
 
 struct libipw_txb {
@@ -490,7 +490,7 @@ struct libipw_txb {
 	u8 reserved;
 	u16 frag_size;
 	u16 payload_size;
-	struct sk_buff *fragments[0];
+	struct sk_buff *fragments[];
 };
 
 /* SWEEP TABLE ENTRIES NUMBER */
@@ -594,7 +594,7 @@ struct libipw_ibss_dfs {
 	struct libipw_info_element ie;
 	u8 owner[ETH_ALEN];
 	u8 recovery_interval;
-	struct libipw_channel_map channel_map[0];
+	struct libipw_channel_map channel_map[];
 };
 
 struct libipw_csa {
@@ -830,7 +830,7 @@ struct libipw_device {
 
 	/* This must be the last item so that it points to the data
 	 * allocated beyond this structure by alloc_libipw */
-	u8 priv[0];
+	u8 priv[];
 };
 
 #define IEEE_A            (1<<0)

