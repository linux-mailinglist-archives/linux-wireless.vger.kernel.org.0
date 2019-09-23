Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB1BB37E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393971AbfIWMRq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 08:17:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfIWMRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 08:17:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EBB426074C; Mon, 23 Sep 2019 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569241064;
        bh=4rRHFNSD8gCvw6wMXQkWbkscJNjGPs61D1AvBUKtIuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pMtbSF5Gj6hWY5j84rnuZ8Nb0nUJ/IixgFO6ts1y59XCtjFBgaU2LoXGigYMTNM33
         PX0uB32OAt4may4OuujEhpjmQwchPh18ESf+mm0DrsxmsYyI8azDGX9AWpQBTfqULC
         5kt43zN/iNEo76OhyfoU01CrOjxxf8YKNO7rWNoc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADFC4602F8;
        Mon, 23 Sep 2019 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569241064;
        bh=4rRHFNSD8gCvw6wMXQkWbkscJNjGPs61D1AvBUKtIuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pMtbSF5Gj6hWY5j84rnuZ8Nb0nUJ/IixgFO6ts1y59XCtjFBgaU2LoXGigYMTNM33
         PX0uB32OAt4may4OuujEhpjmQwchPh18ESf+mm0DrsxmsYyI8azDGX9AWpQBTfqULC
         5kt43zN/iNEo76OhyfoU01CrOjxxf8YKNO7rWNoc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADFC4602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v3 1/2] ath10k: add bus type for each layout of coredump
Date:   Mon, 23 Sep 2019 20:17:34 +0800
Message-Id: <1569241055-30816-2-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569241055-30816-1-git-send-email-wgong@codeaurora.org>
References: <1569241055-30816-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For some hw version, it has more than one bus type, it need to add bus
type to distinguish different chip.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00018-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: change code style
v3: split bus type to another patch, 
remove ATH10K_BUS_ANY, 
add bus type for each layout
 drivers/net/wireless/ath/ath10k/coredump.c | 15 ++++++++++++++-
 drivers/net/wireless/ath/ath10k/coredump.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/coredump.c b/drivers/net/wireless/ath/ath10k/coredump.c
index b6d2932..abc133d 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.c
+++ b/drivers/net/wireless/ath/ath10k/coredump.c
@@ -955,6 +955,7 @@
 	{
 		.hw_id = QCA6174_HW_1_0_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw10_mem_regions),
@@ -963,6 +964,7 @@
 	{
 		.hw_id = QCA6174_HW_1_1_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw10_mem_regions),
@@ -971,6 +973,7 @@
 	{
 		.hw_id = QCA6174_HW_1_3_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw10_mem_regions),
@@ -979,6 +982,7 @@
 	{
 		.hw_id = QCA6174_HW_2_1_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw21_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw21_mem_regions),
@@ -987,6 +991,7 @@
 	{
 		.hw_id = QCA6174_HW_3_0_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw30_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw30_mem_regions),
@@ -995,6 +1000,7 @@
 	{
 		.hw_id = QCA6174_HW_3_2_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw30_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw30_mem_regions),
@@ -1003,6 +1009,7 @@
 	{
 		.hw_id = QCA9377_HW_1_1_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA9377,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw30_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw30_mem_regions),
@@ -1011,6 +1018,7 @@
 	{
 		.hw_id = QCA988X_HW_2_0_VERSION,
 		.hw_rev = ATH10K_HW_QCA988X,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca988x_hw20_mem_regions,
 			.size = ARRAY_SIZE(qca988x_hw20_mem_regions),
@@ -1019,6 +1027,7 @@
 	{
 		.hw_id = QCA9984_HW_1_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA9984,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca9984_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca9984_hw10_mem_regions),
@@ -1027,6 +1036,7 @@
 	{
 		.hw_id = QCA9888_HW_2_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA9888,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca9984_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca9984_hw10_mem_regions),
@@ -1035,6 +1045,7 @@
 	{
 		.hw_id = QCA99X0_HW_2_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA99X0,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca99x0_hw20_mem_regions,
 			.size = ARRAY_SIZE(qca99x0_hw20_mem_regions),
@@ -1043,6 +1054,7 @@
 	{
 		.hw_id = QCA4019_HW_1_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA4019,
+		.bus = ATH10K_BUS_AHB,
 		.region_table = {
 			.regions = qca4019_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca4019_hw10_mem_regions),
@@ -1090,7 +1102,8 @@ const struct ath10k_hw_mem_layout *ath10k_coredump_get_mem_layout(struct ath10k
 
 	for (i = 0; i < ARRAY_SIZE(hw_mem_layouts); i++) {
 		if (ar->target_version == hw_mem_layouts[i].hw_id &&
-		    ar->hw_rev == hw_mem_layouts[i].hw_rev)
+		    ar->hw_rev == hw_mem_layouts[i].hw_rev &&
+		    hw_mem_layouts[i].bus == ar->hif.bus)
 			return &hw_mem_layouts[i];
 	}
 
diff --git a/drivers/net/wireless/ath/ath10k/coredump.h b/drivers/net/wireless/ath/ath10k/coredump.h
index 09de419..b191746 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.h
+++ b/drivers/net/wireless/ath/ath10k/coredump.h
@@ -155,6 +155,7 @@ struct ath10k_mem_region {
 struct ath10k_hw_mem_layout {
 	u32 hw_id;
 	u32 hw_rev;
+	enum ath10k_bus bus;
 
 	struct {
 		const struct ath10k_mem_region *regions;
-- 
1.9.1

