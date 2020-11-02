Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917902A291B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgKBLZN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbgKBLZM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:12 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBDDC061A04
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:25:11 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v5so9017530wmh.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxQ9eC4olAQ/BaWiTM/LMUE/iibApHADASIQRVEODWI=;
        b=G2xG8jSv78TeztV0Grp4aYLVnL8EIsekTK4PQNaFJ1PD/Bifzw1BgiGoBfIh46sd2i
         5VxhGqVoywhAUUCsAoHS4ucLYq4s29MqwGT/N2tqi9HdMcQ+t0PxJ+igTiU2vgkufphn
         xxjyHEfsQyXNnRxZ15IIaz+H+uwshzutFWUiV7w8SaonWKX+N0pesrNbpMxFxemGtttC
         jEjerT7AJzXVzj3kFU/gIH7WgEwhQIQS5y5PUlEmOGj8w2BCdLIUPugrDwnBo46+mC7h
         j3/c+cvgNPhz0RhhiW9ECeZ6KxE1j0wj+Ay5ndLTHN/yCOu133IXh3s7Y6ofzn+VRtJf
         q7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxQ9eC4olAQ/BaWiTM/LMUE/iibApHADASIQRVEODWI=;
        b=p6aBpS5ienlFrpJWiN9E7Gv6xoUJMnIUi61liaFHxFRss5iSjeOR7SNsm42IsU4cxV
         aMpRmYBGB6ZqjTmqI1SidSDAhq4dHyL8El19WMVKmfc7rwIQ38kN2prFYiE+vj6UBVlH
         UqOC9uhtv/czb5iEfikSPmEFlpIdtKTs18jO3Dbhr2b732vDx/jVQLpbMhD8K+/Ysrrt
         ALalHkn4bmTMBLBtlo9EwQ+CpGxAUDJO26tLsNpEC+fz0z7NF4VYJT9MRRJNxnDv3RMT
         rxexBzoNjg8p5/Eg1/duPELTRdo6vo89hdqVXp5ipGRv2qEp8/08Z/x0WEdRuWJzqPwe
         3Puw==
X-Gm-Message-State: AOAM533vXy7g/O5iNn2ir5Jkpr0kGlBsFS3IE/7+lXRyqrF9cbD55rGT
        44Sd8/lZcqoLrJj2KM1jc4mQGw==
X-Google-Smtp-Source: ABdhPJwCMJuP6iKz7748GTQUi0E7GtJTNFdsQVnJ0o1+bq2XEggp9w4IThdvwBXsL/BUzRQPQrSaEg==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr11271953wmi.34.1604316310489;
        Mon, 02 Nov 2020 03:25:10 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:25:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 40/41] iwlwifi: fw: acpi: Demote non-conformant function headers
Date:   Mon,  2 Nov 2020 11:24:09 +0000
Message-Id: <20201102112410.1049272-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
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

