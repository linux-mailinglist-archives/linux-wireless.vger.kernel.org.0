Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F546E5B0E
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2019 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfJZNT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Oct 2019 09:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfJZNT6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Oct 2019 09:19:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69392070B;
        Sat, 26 Oct 2019 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095997;
        bh=+RXZgY1pNTGvQ+1526ck6j6FRsdHz9lJ0dRvajUZKyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3v6Mc41BbEypAabo1yxtAw+6e6EMNi14jU0uBfrFJqEOa+Q2UsTQvucounAqySXx
         y+0HWswF1xOI0hsDXMVsoVMFnP9map1xMFtGv7d1G026L4DowXUWEPRi/aeNSA6PDC
         dS/yNFUT7HLiq4+kxVysLnVQBUc4CTglDHhN1AK0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 25/59] iwlwifi: exclude GEO SAR support for 3168
Date:   Sat, 26 Oct 2019 09:18:36 -0400
Message-Id: <20191026131910.3435-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit 12e36d98d3e5acf5fc57774e0a15906d55f30cb9 ]

We currently support two NICs in FW version 29, namely 7265D and 3168.
Out of these, only 7265D supports GEO SAR, so adjust the function that
checks for it accordingly.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: f5a47fae6aa3 ("iwlwifi: mvm: fix version check for GEO_TX_POWER_LIMIT support")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 9cb9f0544c9b1..2eba6d6f367f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -843,15 +843,17 @@ static bool iwl_mvm_sar_geo_support(struct iwl_mvm *mvm)
 	 * firmware versions.  Unfortunately, we don't have a TLV API
 	 * flag to rely on, so rely on the major version which is in
 	 * the first byte of ucode_ver.  This was implemented
-	 * initially on version 38 and then backported to29 and 17.
-	 * The intention was to have it in 36 as well, but not all
-	 * 8000 family got this feature enabled.  The 8000 family is
-	 * the only one using version 36, so skip this version
-	 * entirely.
+	 * initially on version 38 and then backported to 17.  It was
+	 * also backported to 29, but only for 7265D devices.  The
+	 * intention was to have it in 36 as well, but not all 8000
+	 * family got this feature enabled.  The 8000 family is the
+	 * only one using version 36, so skip this version entirely.
 	 */
 	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >= 38 ||
-	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 29 ||
-	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 17;
+	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 17 ||
+	       (IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 29 &&
+		((mvm->trans->hw_rev & CSR_HW_REV_TYPE_MSK) ==
+		 CSR_HW_REV_TYPE_7265D));
 }
 
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
-- 
2.20.1

