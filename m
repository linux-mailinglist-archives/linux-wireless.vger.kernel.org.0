Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065076DCD69
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDJWWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDJWWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 18:22:52 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90761702
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 15:22:50 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so6036896pjb.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 15:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681165370; x=1683757370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bU8i6xNqX1rC88I1pxg7PxRysSK6rvB9vkGorMl32fk=;
        b=rE7mpwCGUZ6Tin3WB7IBix+GAZT9Lp/CqCrkk0XFbQj+rDeF00Ndinst5d/G2yMCBi
         X+teNIXy4lboQ8XfVGXFuvyUDoN3HY2G/I8zXtuqoHeaYnU3Eg9H3IWw2IG6kxgeo+In
         eSqGMxQ8yzvlIT9WiIPYHezcDDqtjJ/CeEHwahlvQVki1iQTbp04t2fNNkdHIERuxeAG
         tDvPwkT5R+/eX466hO0bBSB9IFYEjcAkFboSGq7WYiROyOsU8AKuEdstmWJwDcDe41cq
         lxdwHHlrCVmN12f0KIhvP0Nj3QGjKxA8JZlviHR7e83yCl3fBw4zJbG2mGX6zLgBudiU
         CbRA==
X-Gm-Message-State: AAQBX9fX2g120iDLfyhuq6bBGmwuyV9p371tse/XzzKTqBCcDp1dRpGF
        t5UCsWh5nPVtlUen6Xl/s10xPwmHkNJ29A==
X-Google-Smtp-Source: AKy350by6YPyeedTmkrECeYVqoHBvFFzdUwjU/dlx/N0F8SqqlCJxawVpEpu1nZvqRLNA6b08C/yxw==
X-Received: by 2002:a05:6a20:1a89:b0:d9:e6a9:d3e2 with SMTP id ci9-20020a056a201a8900b000d9e6a9d3e2mr10994688pzb.3.1681165370103;
        Mon, 10 Apr 2023 15:22:50 -0700 (PDT)
Received: from localhost.localdomain (61-230-67-139.dynamic-ip.hinet.net. [61.230.67.139])
        by smtp.gmail.com with ESMTPSA id y2-20020a62b502000000b0063aed005623sm190323pfe.154.2023.04.10.15.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:22:49 -0700 (PDT)
From:   Yi Kuo <yi@yikuo.dev>
To:     gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org, Yi Kuo <yi@yikuo.dev>
Subject: [PATCH] iwlwifi: pcie: add device id 51F1 for killer 1675
Date:   Tue, 11 Apr 2023 06:22:21 +0800
Message-Id: <20230410222221.27587-1-yi@yikuo.dev>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have a Killer AX1675i card with device id 51f1,
showing "No config found for PCI dev 51f1/1672" in dmesg.

Adding the new device id 51F1 for 1675i fixes the issue.
Also adding it for 1675s.

Signed-off-by: Yi Kuo <yi@yikuo.dev>
---
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
2.40.0

