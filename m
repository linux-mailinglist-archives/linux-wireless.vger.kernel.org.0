Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB97E6348
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 06:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjKIFkh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 00:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjKIFkg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 00:40:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25526A4
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 21:40:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso421544b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Nov 2023 21:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1699508433; x=1700113233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+FHdZF3sFLXj1T2gOt36GY0NN8x4phIIx2zZGGAMY4=;
        b=WK8yA8++wEy+jv6G3eJ28lo4pMSxsN7IZcujFRMnjfNuuCRKU2okNCOFKaEbDMp5I7
         q6bSwlGTH464J4QNytoZaEAiv5BXhAPSmYLQmWn5OdLPLrDVwBfHW5g30EdaoSFfMzdl
         1W8EwCc+q4+mmJNWVHDTXYXvOpl9v7w69AH8JbP6zS/yvchMF+s6iGbAFCgwVylgJEAr
         7vCHV2pRBxKqfsAEqm+QGjEvzTTB14ClWtMbUxk3dFvVTtWmOiNaD3myi8FK5AcL67uO
         z3nxhYyqFsfpkS0eXK4j50WpRXleQwctslKNLnIW6ut7WrWZTySiCxv5u6bqZJR+aUXn
         n86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699508433; x=1700113233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+FHdZF3sFLXj1T2gOt36GY0NN8x4phIIx2zZGGAMY4=;
        b=uFsRmUvSu4o5mQz4KzzJUNhpswh3jCUt+y754MJiha+dIq/kYf/Qgi91zKENJTxjXJ
         fuMS/TqdvoQnHIFc4bcSt3YP1g/yIsTwDK6fsEX2kHhMbZNgzdmwqHXdasfwMnqePRBL
         3kcI+gqsppHg6bh6wD1Tmm9IFHn/zTcAbBW2/YH8EtWP0uWw/rUsh+G0EeXVlmVSw6NL
         0LQF36D/RbB7yMQt+eFMqZsiGI9MuIZVDLgeUoav6P1HuyUPb0vyiHVJ6+siPIz6B0Sj
         IFoBiFHiUgZgPPTQHRoPNn1HeYG6W1Hwz+7TEDfrj4KSIM7Lz5XSLSx/wKgu9eAXQsAV
         N/5Q==
X-Gm-Message-State: AOJu0YynmHTJvPRV7O41nvddojIExyMnpfKAs16dMIRTbW4gIGwMtAw+
        uJjmU01erng06cAZEAByuxh4af9oMSsmAhWV5Lbbgw==
X-Google-Smtp-Source: AGHT+IE4UkcBr6tMTo6FqJiCC3Ud1887+chtdZNocbxL55RmsFfHnRNfpT8nFq16fY+O/HLhVnW3tw==
X-Received: by 2002:a05:6a20:4e15:b0:137:514a:984f with SMTP id gk21-20020a056a204e1500b00137514a984fmr3368835pzb.35.1699508433126;
        Wed, 08 Nov 2023 21:40:33 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ab88700b00280cd4fbd83sm426109pjr.55.2023.11.08.21.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 21:40:32 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] wifi: iwlwifi: Fix warning by adding dependency on DMI
Date:   Thu,  9 Nov 2023 11:10:27 +0530
Message-Id: <20231109054027.2870124-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This driver currently assumes CONFIG_DMI is enabled along with ACPI.
This may not be true. Due to this, the kernel test bot reports new
warning like below for RISC-V allyesconfig builds.

>> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25:
warning: '%s' directive argument is null [-Wformat-overflow=]

1190 | "System vendor '%s' is not in the approved list, disabling PPAG.\n",

Fix the warning by adding dependency on CONFIG_DMI.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311040602.sCjU3UXr-lkp@intel.com/
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 20971304fdef..cbcd1dcced4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IWLWIFI
 	tristate "Intel Wireless WiFi Next Gen AGN - Wireless-N/Advanced-N/Ultimate-N (iwlwifi) "
-	depends on PCI && HAS_IOMEM && CFG80211
+	depends on PCI && HAS_IOMEM && CFG80211 && DMI
 	depends on IWLMEI || !IWLMEI
 	select FW_LOADER
 	help
-- 
2.39.2

