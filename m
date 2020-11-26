Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9292C55AF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390355AbgKZNcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390333AbgKZNcS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:18 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0341C061A48
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:17 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so2166705wmg.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxQ9eC4olAQ/BaWiTM/LMUE/iibApHADASIQRVEODWI=;
        b=tlDrq9iIniydmRPORn0GM7r7Sk+AYo81IX40ePvYCs9TvW173vIQNiohrAz4S+p7IW
         fBy7trdzh4ocFFU0zcprItKqpZe37746Y9o6fwQklnx8oZD0QaCeL4XFot4goDfpBwfH
         53tUjsuyWlWwCfrErTH1CbKfH8+iyIVScKIyqgssp2hMAtY1pFUNfnAbC7SKk94sgTKl
         hULP+RETO+bmAWVeli/OjyuI/FEVLsP99k8H47IgkGd1kdhiVrjftx5glDxqkgVGX6nE
         yMPtsfTykIcmWYbEE0peYDfCx3541qvesAGMTauB6RA9nQlWkzMgfwkOyiVKOWHsSFp1
         2CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxQ9eC4olAQ/BaWiTM/LMUE/iibApHADASIQRVEODWI=;
        b=bU2VsFZH12qjyEhhgVWXrmAExXhvSQ/qPQXjKOCIAcPp36G0V0Mr4Q/i7nsB/yyMPL
         Otpz/MXizDMjhBkGUMN+fsW1oYewjWftOERVyltxA2+c4/sQrdTLAjrt7lRLMwwC7KtZ
         Uxlf2sRz4FlcG5n0V2TYK3Eqd2hdnPVbDBa4vzvpkc8nGBmlKLA5HAvTVLL2RPV5Ma0w
         fU/9d0ABuMIjx5XLsHVRQzZIngPygcnx7apw4WY+oHELVajETb5NhR7sqmoGHkGtCwU7
         pJnRuwaFu2SyZnK6zkGpxhUkf8WAUWH+N+nveoHxHnl8PvXvWJhiIQTR4UqPbIXp4UOr
         +D4g==
X-Gm-Message-State: AOAM5337KJD7R4UQsc6j2on5q/7JhXFm3saUr0wDpcdqopnNOddCDI0n
        ZfiUZ3ntHHqxdtRvZb0fpc2APA==
X-Google-Smtp-Source: ABdhPJwctTXOdDqXHc6BgjPWSqBZhBtIxZlS9oZ6ARvk8ICeeOJ9MLAmy1vyiW939ek2VY+8nxU0qQ==
X-Received: by 2002:a1c:c343:: with SMTP id t64mr3467938wmf.140.1606397536471;
        Thu, 26 Nov 2020 05:32:16 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 16/17] iwlwifi: fw: acpi: Demote non-conformant function headers
Date:   Thu, 26 Nov 2020 13:31:51 +0000
Message-Id: <20201126133152.3211309-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c:123: warning: Function parameter or member 'dev' not described in 'iwl_acpi_get_dsm_object'
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c:123: warning: Function parameter or member 'rev' not described in 'iwl_acpi_get_dsm_object'
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c:123: warning: Function parameter or member 'func' not described in 'iwl_acpi_get_dsm_object'
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c:123: warning: Function parameter or member 'args' not described in 'iwl_acpi_get_dsm_object'
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c:142: warning: Function parameter or member 'dev' not described in 'iwl_acpi_get_dsm_u8'
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c:142: warning: Function parameter or member 'rev' not described in 'iwl_acpi_get_dsm_u8'
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c:142: warning: Function parameter or member 'func' not described in 'iwl_acpi_get_dsm_u8'

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 3e5a35e26ad34..ab1d8b18d9976 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -113,11 +113,11 @@ void *iwl_acpi_get_object(struct device *dev, acpi_string method)
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_object);
 
-/**
-* Generic function for evaluating a method defined in the device specific
-* method (DSM) interface. The returned acpi object must be freed by calling
-* function.
-*/
+/*
+ * Generic function for evaluating a method defined in the device specific
+ * method (DSM) interface. The returned acpi object must be freed by calling
+ * function.
+ */
 static void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
 				     union acpi_object *args)
 {
@@ -134,7 +134,7 @@ static void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
 	return obj;
 }
 
-/**
+/*
  * Evaluate a DSM with no arguments and a single u8 return value (inside a
  * buffer object), verify and return that value.
  */
-- 
2.25.1

