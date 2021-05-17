Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58738267B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhEQIQK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3780 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbhEQIQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:04 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkBfb3Hjtzmhnl;
        Mon, 17 May 2021 16:11:19 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
Subject: [PATCH 06/11] net: intel: iwlwifi: Demote non-compliant kernel-doc headers
Date:   Mon, 17 May 2021 13:01:36 +0800
Message-ID: <20210517050141.61488-7-shenyang39@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517050141.61488-1-shenyang39@huawei.com>
References: <20210517050141.61488-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema704-chm.china.huawei.com (10.3.20.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c:11: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c:14:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
index 0b818067067c..f1ed73c9f3dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -7,11 +7,11 @@
 #include "fw/api/commands.h"
 #include "fw/api/phy-ctxt.h"

-/**
+/*
  * DDR needs frequency in units of 16.666MHz, so provide FW with the
  * frequency values in the adjusted format.
  */
-const static struct iwl_rfi_lut_entry iwl_rfi_table[IWL_RFI_LUT_SIZE] = {
+static const struct iwl_rfi_lut_entry iwl_rfi_table[IWL_RFI_LUT_SIZE] = {
 	/* LPDDR4 */

 	/* frequency 3733MHz */
--
2.17.1

