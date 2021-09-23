Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD362416130
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbhIWOk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 10:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241697AbhIWOkx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 10:40:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A0C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 07:39:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t10so27639366lfd.8
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0mlMVaXOoaza4zpEQf4QOGWruwL5/rJrTk1sWJXn9w0=;
        b=SLumwzLRNExEFLu9sMs6Cof2q8CRLTDwZU/FIgVtUo2+K8A3mI/o+NU+qD4r3rbluR
         Ps41M/jUqoHkRq2SJk4voYsm/E61AysDXoqtSxAQNeZ2mVmS81NNZv4UN+EGdVPs4sSu
         MEneDnBWHrxkbV6XqXeskpY+RCGTElSeJO1sO6cTWIO5BGy28fTEUTK7DzoPLdxKyo92
         0/bAhp66MLMmKsaYlrP0Zl6WxaTMQ2j8M3aH4KHc/jK5grHjrWv1nEzWGG7koVhcy/Ud
         GL9hTlyg60V2isIkaw+z3UWtBn+lDWKn1b05Cwn8ogFVWtUdqWGScyQEr7XiInwM4cAz
         Ij6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0mlMVaXOoaza4zpEQf4QOGWruwL5/rJrTk1sWJXn9w0=;
        b=e8Er/eKB8LOvaRp4H6nywBlei/J1HYlPEaLC1A+MckdW7UciFIAFIBpvg+76ws10N2
         5ERY8WJqP6nUWNbFDk8IqQSBjg9dYjQ0RJOqO1b5sjpcrzlE5Ux8X3MQxk1c0HV7Z/H7
         4ueU6CEH6PB8YGwLcN1+/isT2Ezk95YpMmX6bpfn8zccm+m2xByliQeWNp7Rxt65cdyj
         y0CeXbHWynYY1kQ9v+AF015LDRim7YQ/ay/SNot/FTtnOXOWaIIpKmdqlugktLldhUFT
         rF6WfzLgvnwxrkBMuZkGIMlNQK8wSVK8PZtuavLXTsVjpJtTwb1GGtOy5Hv6XpUBFgeI
         4tcA==
X-Gm-Message-State: AOAM532MLz8hZgmmwL09c+Zp+020u0WkRQGryjSOf7Gqb3qzYNjBq25D
        7Z5mMBl8Hc3n6eZ6bQ7vqrd2Iw==
X-Google-Smtp-Source: ABdhPJzD1FPkiqvrK8s+G5qLEgUnZEmweTx2/tIRg9JKgc6hWY5ZxQJBv5CyTf+F41BtAiyCcnYclg==
X-Received: by 2002:a05:6512:1189:: with SMTP id g9mr4452916lfr.661.1632407957225;
        Thu, 23 Sep 2021 07:39:17 -0700 (PDT)
Received: from localhost.localdomain (88-112-130-172.elisa-laajakaista.fi. [88.112.130.172])
        by smtp.gmail.com with ESMTPSA id s4sm601513ljp.115.2021.09.23.07.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:39:16 -0700 (PDT)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Julien Wajsberg <felash@gmail.com>
Subject: [PATCH v2] iwlwifi: pcie: add configuration of a Wi-Fi adapter on Dell XPS 15
Date:   Thu, 23 Sep 2021 17:38:40 +0300
Message-Id: <20210923143840.2226042-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is a Killer AX1650 2x2 Wi-Fi 6 and Bluetooth 5.1 wireless adapter
found on Dell XPS 15 (9510) laptop, its configuration was present on
Linux v5.7, however accidentally it has been removed from the list of
supported devices, let's add it back.

The problem is manifested on driver initialization:

  Intel(R) Wireless WiFi driver for Linux
  iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
  iwlwifi: No config found for PCI dev 43f0/1651, rev=0x354, rfid=0x10a100
  iwlwifi: probe of 0000:00:14.3 failed with error -22

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=213939
Fixes: 3f910a25839b ("iwlwifi: pcie: convert all AX101 devices to the device tables")
Cc: Julien Wajsberg <felash@gmail.com>
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
Changes from v1 to v2:
* moved the added lines in a way to preserve a numerical order by devid.

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 61b2797a34a8..3744c5e76519 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -547,6 +547,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
-- 
2.33.0

