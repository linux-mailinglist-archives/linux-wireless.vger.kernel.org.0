Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57184435AB5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 08:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJUGKp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 02:10:45 -0400
Received: from mail.kevlo.org ([220.134.220.36]:6409 "EHLO mail.kevlo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhJUGKp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 02:10:45 -0400
X-Greylist: delayed 1459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Oct 2021 02:10:44 EDT
Received: from localhost (ns.kevlo.org [local])
        by ns.kevlo.org (OpenSMTPD) with ESMTPA id 4386c0a4;
        Thu, 21 Oct 2021 13:44:08 +0800 (CST)
Date:   Thu, 21 Oct 2021 13:44:08 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     linux-wireless@vger.kernel.org
Cc:     Pkshih <pkshih@realtek.com>
Subject: [PATCH wireless-drivers-next] rtw89: remove duplicate register
 definitions
Message-ID: <YXD+KL+xzFsnGShb@ns.kevlo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove duplicate register definitions.

Signed-off-by: Kevin Lo <kevlo@kevlo.org>
---
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 34333c441aea..20e6767ea5c4 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -276,11 +276,6 @@
 #define B_AX_CH10_BUSY			BIT(0)
 
 /* Configure */
-#define R_AX_PCIE_INIT_CFG1	0x1000
-#define B_AX_PCIE_RXRST_KEEP_REG	BIT(23)
-#define B_AX_PCIE_TXRST_KEEP_REG	BIT(22)
-#define B_AX_DIS_RXDMA_PRE		BIT(2)
-
 #define R_AX_PCIE_INIT_CFG2		0x1004
 #define B_AX_WD_ITVL_IDLE		GENMASK(27, 24)
 #define B_AX_WD_ITVL_ACT		GENMASK(19, 16)
