Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773446AFA02
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 00:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCGXDX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 18:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCGXDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 18:03:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BF21C589
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678230117; x=1709766117;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NMFFgd/dfwYtUJPj6wj76EkQ/s/ZrzsbXJSv1hnrUMA=;
  b=G85cb9p9HDArDLevNZdYIKHZdLbrobFpr6Cyq7GI7CzEExLOwq14gUyt
   A1nkdV5oCBE+cPbXxd6LtP7SL5oSbrS3YS/DP12UgmPfw6OIlg7NDNyAa
   QQ7jhnI8z/hS0h74evxvnyyLXbuoL6KEWMNOC7DgIC4r0yRMI/U57a46u
   CH6zFcE7Dut18GabaTg6+VnHeCHOipkj766GgNvSX6nNfAVgLbe2HOCTn
   xkNBqZ5i8V6A9//Cu5CyNjig6oQaCwPBQp3o+Vui3mll3Cf6gHUDYJonH
   810ZyPB7eYJWXSlw2Z7KKbL3AQ5N9F8WmcNodH+19Pc1dTEk7kr93DILc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="363632839"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="363632839"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 15:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679121129"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="679121129"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 15:01:56 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
Subject: [PATCH v2] wifi: ipw2x00: convert ipw_fw_error->elem to flexible array[]
Date:   Tue,  7 Mar 2023 15:01:48 -0800
Message-Id: <20230307230148.3735684-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ipw_fw_error structure contains a payload[] flexible array as well as
two pointers to this array area, ->elem, and ->log. The total size of the
allocated structure is computed without use of the <linux/overflow.h>
macros.

There's no reason to keep both a payload[] and an extra pointer to both the
elem and log members. Convert the elem pointer member into the flexible
array member, removing payload.

Fix the allocation of the ipw_fw_error structure to use size_add(),
struct_size(), and array_size() to compute the allocation. This ensures
that any overflow saturates at SIZE_MAX rather than overflowing and
potentially allowing an undersized allocation.

Before the structure change, the layout of ipw_fw_error was:

struct ipw_fw_error {
        long unsigned int          jiffies;              /*     0     8 */
        u32                        status;               /*     8     4 */
        u32                        config;               /*    12     4 */
        u32                        elem_len;             /*    16     4 */
        u32                        log_len;              /*    20     4 */
        struct ipw_error_elem *    elem;                 /*    24     8 */
        struct ipw_event *         log;                  /*    32     8 */
        u8                         payload[];            /*    40     0 */

        /* size: 40, cachelines: 1, members: 8 */
        /* last cacheline: 40 bytes */
};

After this change, the layout is now:

struct ipw_fw_error {
        long unsigned int          jiffies;              /*     0     8 */
        u32                        status;               /*     8     4 */
        u32                        config;               /*    12     4 */
        u32                        elem_len;             /*    16     4 */
        u32                        log_len;              /*    20     4 */
        struct ipw_event *         log;                  /*    24     8 */
        struct ipw_error_elem      elem[];               /*    32     0 */

        /* size: 32, cachelines: 1, members: 7 */
        /* last cacheline: 32 bytes */
};

This saves a total of 8 bytes for every ipw_fw_error allocation, and
removes the risk of a potential overflow on the allocation.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
---
This was discovered by a coccinelle patch I developed, and submitted at:
  https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/

V1: https://lore.kernel.org/linux-wireless/99a9d4a2-d032-1c9d-90c6-3a68f6b3a092@intel.com/
Changes since v1
* Split series into individual postings to avoid confusion about dependency

 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 7 +++----
 drivers/net/wireless/intel/ipw2x00/ipw2200.h | 3 +--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index d382f2017325..b91b1a2d0be7 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -1234,9 +1234,9 @@ static struct ipw_fw_error *ipw_alloc_error_log(struct ipw_priv *priv)
 	u32 base = ipw_read32(priv, IPW_ERROR_LOG);
 	u32 elem_len = ipw_read_reg32(priv, base);
 
-	error = kmalloc(sizeof(*error) +
-			sizeof(*error->elem) * elem_len +
-			sizeof(*error->log) * log_len, GFP_ATOMIC);
+	error = kmalloc(size_add(struct_size(error, elem, elem_len),
+				 array_size(sizeof(*error->log), log_len)),
+			GFP_ATOMIC);
 	if (!error) {
 		IPW_ERROR("Memory allocation for firmware error log "
 			  "failed.\n");
@@ -1247,7 +1247,6 @@ static struct ipw_fw_error *ipw_alloc_error_log(struct ipw_priv *priv)
 	error->config = priv->config;
 	error->elem_len = elem_len;
 	error->log_len = log_len;
-	error->elem = (struct ipw_error_elem *)error->payload;
 	error->log = (struct ipw_event *)(error->elem + elem_len);
 
 	ipw_capture_event_log(priv, log_len, error->log);
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.h b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
index 09ddd21608d4..8ebf09121e17 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -1106,9 +1106,8 @@ struct ipw_fw_error {	 /* XXX */
 	u32 config;
 	u32 elem_len;
 	u32 log_len;
-	struct ipw_error_elem *elem;
 	struct ipw_event *log;
-	u8 payload[];
+	struct ipw_error_elem elem[];
 } __packed;
 
 #ifdef CONFIG_IPW2200_PROMISCUOUS

base-commit: 8f9850dd8d23c1290cb642ce9548a440da5771ec
-- 
2.39.1.405.gd4c25cc71f83

