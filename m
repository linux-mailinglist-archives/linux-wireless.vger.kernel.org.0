Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6353BA5FD
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jul 2021 00:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhGBWfI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 18:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhGBWfG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 18:35:06 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A38BC061764
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jul 2021 15:32:33 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id a133so13033428oib.13
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jul 2021 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7q94PMW36yr5rptah60oKyUeqPiKIPlgmyqeUcPJ2o=;
        b=N8Pjyo1OOzX23wODt1rPErvl/FpT0mS4lNO28NqZD6XuBpQWR1M/zhhYe2MxO/4Ecj
         uEaEaRwOPdj+jWA87k9MTe6H7EjatL43D5h0KNP7g67UIWq1uSGnKWBfhyFHX9rEOIzQ
         lw5Yaho2cJOV4wgopZQ4M3R+/FNtOMVHihiJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=f7q94PMW36yr5rptah60oKyUeqPiKIPlgmyqeUcPJ2o=;
        b=ffLreg+MXcFMVdSQPXhHliVWGWGJOc7kmTvhN6KvNdspz23RNq4kvxbZ5N09ix5cFc
         gx+6L8XFeQc5kSN1WHjZNyXHeNvI2pyposf4QN0mykMG5KhIBMU+tn9jm2+qW8Lw1f5+
         mIT96YtL1wC5hIO4t9BnnKH2W8VOcg3DZMyTQLI0iz22pKtmN6B4TBvbSLTH/Hrivl49
         Vae6QEwIf2tzj7NO4C9eR0uT7qmUHXQ6fCUMeUYOpn+weTx5htKyp0vquCQCLvNORqGk
         8NQngh/hwq7eEWfgtCpthowHhGCaCWL74ww8vWGfjJz9KhimeuoTEpIAuq6oQUY9r57A
         EvQg==
X-Gm-Message-State: AOAM531NYHsR5f4wWMfRfGtZ8U1Z1wp3uiJPD1i+7MlfkJCDoF1NgHmm
        iuum3rBUgD3FY6O0RHCUeMRD1Q==
X-Google-Smtp-Source: ABdhPJzRSblwQIZOE085jx9LltD2/8BZnTczDrEP9umQCwCmqWoj1f1S30VWoMDiTYyjGNfTrCNtxw==
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr1577344ois.58.1625265152408;
        Fri, 02 Jul 2021 15:32:32 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id e29sm1007731oiy.53.2021.07.02.15.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:32:31 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matti Gottlieb <matti.gottlieb@intel.com>,
        ybaruch <yaara.baruch@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jforbes@fedoraproject.org, jmforbes@linuxtx.org
Subject: [PATCH] iwlwifi Add support for ax201 in Samsung Galaxy Book Flex2 Alpha
Date:   Fri,  2 Jul 2021 17:31:53 -0500
Message-Id: <20210702223155.1981510-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Samsung Galaxy Book Flex2 Alpha uses an ax201 with the ID a0f0/6074.
This works fine with the existing driver once it knows to claim it.
Simple patch to add the device.

Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 16baee3d52ae..63f5598ebe3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -558,6 +558,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0xA0F0, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x2074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0xA0F0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
+	IWL_DEV_INFO(0xA0F0, 0x6074, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x0070, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x0074, iwl_ax201_cfg_quz_hr, NULL),
 	IWL_DEV_INFO(0x02F0, 0x6074, iwl_ax201_cfg_quz_hr, NULL),
-- 
2.31.1

