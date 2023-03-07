Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2379B6AFA03
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 00:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCGXDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 18:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCGXDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 18:03:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532E574EB
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 15:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678230152; x=1709766152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q/ICUy6PSJLUvSsnEtQdGUVqw96Dlr68WNvlI8zPf8I=;
  b=nFSVpzd+7VLXZaoUoYesKpzuq/P+JDr9pI2y3yDyCMk43AZjyTUg90mB
   gHjpYfdCQupOCMRPyglAHQtx4B4x0WEgOm3EDzWGCe6OdeCjqdQRP+TFc
   69dxX9KLRlfuoaAOAEdAI+2h8msyXNLGKI3K4opVG0xTXmotfB5ob/ZR5
   qSoWrwo//4CnM7czkE6rQ8fP2HPpATGxjg4Ceqs/y8PNBWNDlSQgX6B4d
   eEhKekhXXcG1YCiSxY6C68VNlfOh4jJ/yFMGEPiScHoD8TAzpgBAThyCV
   Gj0bcvLTbethkfbv67VPprIBRuRcn0FYCeDkRXWIRQa4KuMdjKUdso/ml
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="338319530"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="338319530"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 15:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="1006063535"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="1006063535"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 15:02:17 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2] wifi: qtnfmac: use struct_size and size_sub for payload length
Date:   Tue,  7 Mar 2023 15:02:12 -0800
Message-Id: <20230307230212.3735818-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace the calculations for the payload length in
qtnf_cmd_band_fill_iftype with struct_size() and size_sub(). While
the payload length does not get directly passed to an allocation function,
the performed calculation is still calculating the size of a flexible array
structure (minus the size of a header structure).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Igor Mitsyanko <imitsyanko@quantenna.com>
Cc: Sergey Matyukevich <geomatsi@gmail.com>
---
This was discovered by a coccinelle patch I developed, and submitted at:
  https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/

V1: https://lore.kernel.org/linux-wireless/99a9d4a2-d032-1c9d-90c6-3a68f6b3a092@intel.com/
Changes since v1
* Split series into individual postings to avoid confusion about dependency
* Fixed subject line

 drivers/net/wireless/quantenna/qtnfmac/commands.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index b1b73478d89b..68ae9c7ea95a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1325,9 +1325,10 @@ static int qtnf_cmd_band_fill_iftype(const u8 *data,
 	struct ieee80211_sband_iftype_data *iftype_data;
 	const struct qlink_tlv_iftype_data *tlv =
 		(const struct qlink_tlv_iftype_data *)data;
-	size_t payload_len = tlv->n_iftype_data * sizeof(*tlv->iftype_data) +
-		sizeof(*tlv) -
-		sizeof(struct qlink_tlv_hdr);
+	size_t payload_len;
+
+	payload_len = struct_size(tlv, iftype_data, tlv->n_iftype_data);
+	payload_len = size_sub(payload_len, sizeof(struct qlink_tlv_hdr));
 
 	if (tlv->hdr.len != cpu_to_le16(payload_len)) {
 		pr_err("bad IFTYPE_DATA TLV len %u\n", tlv->hdr.len);

base-commit: 8f9850dd8d23c1290cb642ce9548a440da5771ec
-- 
2.39.1.405.gd4c25cc71f83

