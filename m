Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D18B4171B2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 14:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbhIXMXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 08:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhIXMXg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 08:23:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C274C061574
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 05:22:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z24so40230774lfu.13
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nxac5QYLROyRUMFQp61d5aUplVDEPOjNKkJuYM/lJy8=;
        b=PTAH8WCR6oy8VsihHfSmZWzoecRFWVHUvP1XmrZDBF8PulxjOkk7TS8J9ss7f1PV1l
         +Dj+KmpW6eTl58hKsjY9iY2PboqXBdine0yuo6xqPX2cq1ulK5YXMgpH414JiP+4oaPB
         Y6eoL6WQrRufszk6Zr8tk58nCUuNOfNRPf9mTp6k6daNpRW7Q85frCqN4pn4f3hVgHmD
         TfpMO6nM+IaxY46R3n2P33fEHC5d9jUOjPqIlEUkrY93Rf5fIlWPMywMxAEIvCMMxI2Q
         NDqxXREWWFQhViemsrAgvMzLw2NQSYogU3h2+L6LGsayP1BHZQCoHoTx8Ow94EfTWFM/
         X5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nxac5QYLROyRUMFQp61d5aUplVDEPOjNKkJuYM/lJy8=;
        b=4wQllA+Fsc8gMte+Q9ui2HTftmGuhsottGksnG/ANLfuX1hzN2ukcah2RqMYMtyyOx
         JMVRvYALLGKI+g1slHSyuYBVZ8dpdStpAyKtZX2xDhb6WmON6uhwCjCBlNwEClxqqfo6
         IFYuAlNaXMHk+zl1pVwVNW1yytPoJeJu2EsIJxusbZyVi48HkEouG8X9Yo8jlrtuVQyb
         gvwfaeYOK7MIfnnHXSxOty7V28hFLonA0A+77/S9J9j6fHB/WpHZAkCW31tnhNpncP1c
         BKsa+u1K5FDi6FXC9etd3QFXTMTE7UarPUSXPTp5QFHAenfSLS2wA9uHH5nNCqrq8/85
         qtJw==
X-Gm-Message-State: AOAM532WZW9w6rzg//0RBmVOj+EGdDuXZv6RYCfjj5Dh8AEAsQAir/T6
        UvrX0rSvvsQqMn0gR0CI+C2+zg==
X-Google-Smtp-Source: ABdhPJxzVMBe5XlLzFJTxjx7wrTW2bt544/Wz7Kmhisw8LTiD8f/VMsEYHwXultVAPb5fh+n4Z2Q6A==
X-Received: by 2002:a2e:5111:: with SMTP id f17mr11003691ljb.409.1632486121932;
        Fri, 24 Sep 2021 05:22:01 -0700 (PDT)
Received: from localhost.localdomain (88-112-130-172.elisa-laajakaista.fi. [88.112.130.172])
        by smtp.gmail.com with ESMTPSA id o19sm740508lfg.62.2021.09.24.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:22:01 -0700 (PDT)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Julien Wajsberg <felash@gmail.com>
Subject: [PATCH v3] iwlwifi: pcie: add configuration of a Wi-Fi adapter on Dell XPS 15
Date:   Fri, 24 Sep 2021 15:21:54 +0300
Message-Id: <20210924122154.2376577-1-vladimir.zapolskiy@linaro.org>
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
Changes from v2 to v3:
* specified names to the added wireless adapters.

Changes from v1 to v2:
* moved the added lines in a way to preserve a numerical order by devid.

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 61b2797a34a8..e3996ff99bad 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -547,6 +547,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0078, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x007C, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, iwl_ax201_killer_1650s_name),
+	IWL_DEV_INFO(0x43F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, iwl_ax201_killer_1650i_name),
 	IWL_DEV_INFO(0x43F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
-- 
2.33.0

