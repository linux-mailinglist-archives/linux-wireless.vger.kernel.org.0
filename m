Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7956415D09
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhIWLvF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 07:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbhIWLvF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 07:51:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139EC061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 04:49:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so25608617lfu.5
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 04:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OP3cZBOFWJ5enkgDFR8z6xkvNfG+FTamWowL85B20oo=;
        b=ybXO6FrLb7Mhr22DoZiXGiXqcIqqZOtD8cM8Mdr3WfKM3N0VnpH8HSGMMK86YISudx
         TxUB3AxCbzJQJi6ZbZXegjydmWr3DmqkQhuVjzYsi3QSsY+1pfzSA9b/Gu5VZJChzi4W
         lpT6MYuUC3S1zoanNutspIP52aI8YdUyFzvmL1K95eAgwUyb9fRIFHKAaO8auw0xbr1x
         UhGI39dlfrI15utMWXsuZgH8FjB81TXRU1OjDsxodGohwBSk51b3/TahN7zA9S/wSpxn
         1NkmByMRC2dsf74yxoZsQ7Y6x6AOQvN1v2DW4EigAbh6jXBxFo20y017ST4HJxTNhlwB
         mPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OP3cZBOFWJ5enkgDFR8z6xkvNfG+FTamWowL85B20oo=;
        b=4teNInXUGZ560yJhrmTBt1/3ChijcLCDb0el8WUzQIDuiRUoDvCbYW4D6nYruI5ppZ
         JIqg/vuL3C9mtDM0MHuM8irR3hDTXUKLDJwYmvtlgqTWBSVCFtYSGAW+TrEa9TsxgghM
         JNm4MXmncbtaY0dG3w4XhZiZZPgX6Pw8u+OMLWRSjYBqbDiNQbs03oQwXLFMjpdZujTB
         GZ/u5I5dGGrRf1LPLiv0OzZY0NlBJBsNqzKyJuSB16tf1lS2DzjPf1UTx8P0fu7HqXIy
         2A1ozZEzFG5e0S7MAz60bSEn83Lua7ArgF7cVg1Gkg4GtQm3jnsFi+AXgTBDZlp7Xf+4
         9Umw==
X-Gm-Message-State: AOAM530IB6rilAXaRS0NLLQWE5PtnRzmGw6atAg/8joOUyzDyp1l2WBF
        GyJLfV6MxnLpKrjw7mhDXXucbg==
X-Google-Smtp-Source: ABdhPJwjkU/bPK0bUudkdduikwiIu+O3B4nNHlhjw85ScZhn+njUmt5C3zcuqsPUXBhbc7nNL5Rm3A==
X-Received: by 2002:a2e:140f:: with SMTP id u15mr2711941ljd.25.1632397771552;
        Thu, 23 Sep 2021 04:49:31 -0700 (PDT)
Received: from localhost.localdomain (88-112-130-172.elisa-laajakaista.fi. [88.112.130.172])
        by smtp.gmail.com with ESMTPSA id d17sm437370lfb.207.2021.09.23.04.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 04:49:31 -0700 (PDT)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Julien Wajsberg <felash@gmail.com>
Subject: [PATCH] iwlwifi: pcie: add configuration of a Wi-Fi adapter on Dell XPS 15
Date:   Thu, 23 Sep 2021 14:49:17 +0300
Message-Id: <20210923114917.2153964-1-vladimir.zapolskiy@linaro.org>
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
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 61b2797a34a8..3e5052ed0c5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -549,6 +549,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x43F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
+	IWL_DEV_INFO(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
-- 
2.33.0

