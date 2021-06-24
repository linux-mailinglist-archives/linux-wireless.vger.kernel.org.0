Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6713B26CD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 07:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFXFbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 01:31:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38140 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhFXFbr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 01:31:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624512568; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=auAvLY/EoSHc89PNBAw+/X5rU/rOU8Eut1V9kw65brg=; b=JB+t4OWYWG4MdgMN/NxC/FuryUmkgPjm/KlRetbZfITGv1PZOJ1RouAl3g0jxchK6AVIkGdJ
 vA1o/+C0ZYNbKA3s7PBMxPiYsnMTlWx9TioQpZgoydftz8nC9iCG/Pgg+4Gi+F2cXV2R6Yuv
 Pz/4b0tv+kzLInvf4lQsSdYBqto=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60d41836dc4628fe7e79c122 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 05:29:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6C41C433D3; Thu, 24 Jun 2021 05:29:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED0F6C433F1;
        Thu, 24 Jun 2021 05:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED0F6C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     sfr@canb.auug.org.au, luciano.coelho@intel.com
Subject: [PATCH] iwlwifi: acpi: remove unused function iwl_acpi_eval_dsm_func()
Date:   Thu, 24 Jun 2021 08:29:18 +0300
Message-Id: <20210624052918.4946-1-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen reported a warning:

drivers/net/wireless/intel/iwlwifi/fw/acpi.c:720:12: warning: 'iwl_acpi_eval_dsm_func' defined but not used [-Wunused-function]

The warning is correct and the function is not used anywhere, so let's
just remove it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 7119f02b5d34 ("iwlwifi: mvm: support BIOS enable/disable for 11ax in Russia")
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 36 --------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 8cf7bc3aa09a..34933f133a0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -717,42 +717,6 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 }
 IWL_EXPORT_SYMBOL(iwl_sar_geo_init);
 
-static u32 iwl_acpi_eval_dsm_func(struct device *dev, enum iwl_dsm_funcs_rev_0 eval_func)
-{
-	union acpi_object *obj;
-	u32 ret;
-
-	obj = iwl_acpi_get_dsm_object(dev, 0,
-				      eval_func, NULL,
-				      &iwl_guid);
-
-	if (IS_ERR(obj)) {
-		IWL_DEBUG_DEV_RADIO(dev,
-				    "ACPI: DSM func '%d': Got Error in obj = %ld\n",
-				    eval_func,
-				    PTR_ERR(obj));
-		return 0;
-	}
-
-	if (obj->type != ACPI_TYPE_INTEGER) {
-		IWL_DEBUG_DEV_RADIO(dev,
-				    "ACPI: DSM func '%d' did not return a valid object, type=%d\n",
-				    eval_func,
-				    obj->type);
-		ret = 0;
-		goto out;
-	}
-
-	ret = obj->integer.value;
-	IWL_DEBUG_DEV_RADIO(dev,
-			    "ACPI: DSM method evaluated: func='%d', ret=%d\n",
-			    eval_func,
-			    ret);
-out:
-	ACPI_FREE(obj);
-	return ret;
-}
-
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
 	int ret;
-- 
2.20.1

