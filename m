Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D997279EA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 10:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjFHI1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjFHI1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 04:27:33 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8E2700
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 01:27:31 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-33b00ce51caso779285ab.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jun 2023 01:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686212851; x=1688804851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9jye5icd0SA3XBgaC6DaCkAP0nKThPrL/EpO4QRLn4=;
        b=MW+T7MVJU1XMCDjmmrl+ui9J325OJrpvDLVR1sRRGFLvW6idwK83G1FdqhBVLZU4sG
         FVFYGBu2WfSkdUHjMCoG4vVwX+kKoJenR9mP3h9YFQdcgnvtRgwDRZ4WNuGJ9Yeb0lEE
         1hJOm3RdU17plDpz5/vd/p4D3dF3liRcXBMnYzOt71SuZchi/8KExAfFHOv8mpsiRmLr
         6SSshJqOYrqngqh1C8ZbojpqL6FtsTqVUq/MvLc4pBCJrg+7mfoRJTMb3t3HYp8LIqYP
         MwuzxLWyywdGblyxPiumbuSyKNKvN24tPvMxcOrffwosOSbkSq0ps9Bk2HvxwL6mkGec
         PUig==
X-Gm-Message-State: AC+VfDyGiuvPafNu/OIikghrnw9mm8ygyAQYdbtHXY/MOllmRMf9DBwG
        q7MEuYK/tfGAl2onBkjaZE8=
X-Google-Smtp-Source: ACHHUZ59yVHLlIlY0r3Xc7hKeE1hVc3HgpE9NfGMfs/30AjzqA1gwuKg+a8pc2W10rcZMrCx+Y3gOQ==
X-Received: by 2002:a92:ce85:0:b0:33d:6536:46e1 with SMTP id r5-20020a92ce85000000b0033d653646e1mr8397779ilo.23.1686212850700;
        Thu, 08 Jun 2023 01:27:30 -0700 (PDT)
Received: from YNB.cs.nthu.edu.tw (v385-gateway.cs.nthu.edu.tw. [140.114.87.235])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78d58000000b00654228f9e93sm586768pfe.120.2023.06.08.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:27:30 -0700 (PDT)
From:   Yi Kuo <yi@yikuo.dev>
To:     kvalo@kernel.org, gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org, Yi Kuo <yi@yikuo.dev>
Subject: [PATCH v2] wifi: iwlwifi: pcie: add device id 51F1 for killer 1675
Date:   Thu,  8 Jun 2023 16:27:25 +0800
Message-Id: <20230608082725.353150-1-yi@yikuo.dev>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Intel Killer AX1675i/s with device id 51f1 would show "No config found for PCI dev 51f1/1672" in dmesg and refuse to work.
Adding the new device id 51F1 for 1675i/s fixes the issue.

Signed-off-by: Yi Kuo <yi@yikuo.dev>
---

 v2: add the 'wifi:' prefix to the title

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 99768d6a6..34592d8cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -679,6 +679,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2726, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x51F0, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
 	IWL_DEV_INFO(0x51F0, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
+	IWL_DEV_INFO(0x51F1, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
+	IWL_DEV_INFO(0x51F1, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x54F0, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
 	IWL_DEV_INFO(0x54F0, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x7A70, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
-- 
2.40.1

