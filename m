Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76A6A6A90
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCAKKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCAKKO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1848F36FE3
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665414; x=1709201414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=My9Fqvg66rpR/nMzOmPdqh1Vi9L15vgnhhoKkkfZhYI=;
  b=aVEai99P9uJn3UMd7VOnMfcPtvAPEN0lwKW1MkPJ/L1sOgFj60sE6+/+
   Ki1lq7aNaRqGujWFfa2P9/KUa9lcjZplrnCZLfx1qr3JKGHsrceeFsTyW
   04cvio38S1kWWNcEZT8sD4oPR6w7HfhCmm4psclR/33UUDb7gaavuhQf3
   Jns0SydGQEh6/ZCOtZwzIW3xH8cg1J48DiZYI2eiuP04e/caPX4Hh599i
   wE7hFct0oV1C20pHabc5AW5SgxujdllJl7Npqy3IHEPE15v8FLifinwm0
   RHCS7+h6h2+Cfeluh/+nte/arkDwcAGN81X4dQpaoK+myYIdfijyMsl9g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662813"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589036"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589036"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:07 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 06/23] wifi: wireless: return primary channel regardless of DUP
Date:   Wed,  1 Mar 2023 12:09:18 +0200
Message-Id: <20230301115906.66d7f05f7d11.I5e0add054f72ede95611391b99804c61c40cc959@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently in case DUP bit is not set we don't return the primary
channel for 6Ghz Band (UHB), but from spec seems that
DUP has no affect on primary channel for UHB,

9.4.2.249 HE Operation element:
The Duplicate Beacon subfield is set to 1 if the AP transmits
Beacon frames in non-HT duplicate PPDU with a TXVECTOR parameter
CH_BANDWIDTH value that is up to the BSS bandwidth and is set to
0 otherwise.

So remove the condition for returning primary channel based on DUP.

About RSSI for DUP beacon no need to mark it as invalid, due to the
code calling the function check marks signal invalid in case beacon
freq is not the freq we received it on, which is the case for DUP beacon
on non primary channels.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 790bc31cf82e..72e9af6158ef 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1830,9 +1830,7 @@ int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
 			if (!he_6ghz_oper)
 				return -1;
 
-			if (ftype != CFG80211_BSS_FTYPE_BEACON ||
-			    he_6ghz_oper->control & IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON)
-				return he_6ghz_oper->primary;
+			return he_6ghz_oper->primary;
 		}
 	} else if (band == NL80211_BAND_S1GHZ) {
 		tmp = cfg80211_find_elem(WLAN_EID_S1G_OPERATION, ie, ielen);
-- 
2.38.1

