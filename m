Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537C96A5D1D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjB1Q3E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 11:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1Q3D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 11:29:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FB7EC46
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677601738; x=1709137738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=odol+JxuQvFhwv30ibTMrdYzc0CJZkzAskFzrU/34ro=;
  b=MCkix5oWriVmLeC/AvaRBvEDeX0OjXV+yJxTeqE7ugoiuU12HUl7+k8+
   rYJuluFyf6bDLBxq+WHg/FSAUnPHY94yLJutdv8Ioze4o7qy2Iky8AUXf
   zXWGLm7rXngPa93le5AGwfAd9tbfOPMApE+kNJUwRUdnj8KQIPquNe/Kz
   4cuXi92oTzax5qJphCFlYUnWzRoXcPyL9gdyxnjpXX9C7E2q6K2OowhV2
   EUAoA3pEpkUQo6LQNYqKGLfCFwgT+UKg3tRfkmjESbGhEU8VcKrshsB3+
   sF3RTCm5OVKyaSaqEApOBMYJHbAszv7+Jq7Ies10tzyq2RWlMhnkii2L/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="398964476"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="398964476"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:28:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="676361741"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="676361741"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:28:33 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 2/3] wifi: cfg80211: use struct_size and size_sub for payload length
Date:   Tue, 28 Feb 2023 08:28:26 -0800
Message-Id: <20230228162827.3876606-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f83
In-Reply-To: <20230228162827.3876606-1-jacob.e.keller@intel.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
-- 
2.39.1.405.gd4c25cc71f83

