Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEE75BC29A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 09:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbfIXH2Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 03:28:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49828 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfIXH2Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 03:28:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F6B360A00; Tue, 24 Sep 2019 07:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569310095;
        bh=gCCH3kgxYXfE0yzGttHg6NiAGgFenwbC/b9xld/tYc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1hAxdRe8YetgLu9VdBXNss+daa1Mht8yTGmj8M6pUR82lQZX1XQVHsy1objyM1RZ
         OC+MLKf4O0NVPS6a0C73BzFoc+uWAX1GUsPTkOtaMjrArzt/8+RYhtv+7JfvHp8riw
         pUg1ir+E6XNYz6oelxupnTRfx+U/G/jFQHXNGRXE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D966E6083C;
        Tue, 24 Sep 2019 07:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569310094;
        bh=gCCH3kgxYXfE0yzGttHg6NiAGgFenwbC/b9xld/tYc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuG5GjOfSnc7mtLl6jpI5ZALar0GGRrsIY+6r44U+6ht3aB1NXplsobEvmesdMODV
         HU8FEbUOxL2JY6yZ9NbY86OO7xdD0ShyJ30lZL7/epdNdu7rdyD6oEHxO0lWy5NCgZ
         Ful9RLI6PLwuJKpOBSv/DjF8kgOQhz/mW+VqWYCA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D966E6083C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v4 1/2] ath10k: add bus type for each layout of coredump
Date:   Tue, 24 Sep 2019 15:27:09 +0800
Message-Id: <1569310030-834-2-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569310030-834-1-git-send-email-wgong@codeaurora.org>
References: <1569310030-834-1-git-send-email-wgong@codeaurora.org>
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

v4: rebase to latest commit
 drivers/net/wireless/ath/ath10k/coredump.c | 16 +++++++++++++++-
 drivers/net/wireless/ath/ath10k/coredump.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/coredump.c b/drivers/net/wireless/ath/ath10k/coredump.c
index de0926c..8860c62 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.c
+++ b/drivers/net/wireless/ath/ath10k/coredump.c
@@ -968,6 +968,7 @@
 	{
 		.hw_id = QCA6174_HW_1_0_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw10_mem_regions),
@@ -976,6 +977,7 @@
 	{
 		.hw_id = QCA6174_HW_1_1_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw10_mem_regions),
@@ -984,6 +986,7 @@
 	{
 		.hw_id = QCA6174_HW_1_3_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw10_mem_regions),
@@ -992,6 +995,7 @@
 	{
 		.hw_id = QCA6174_HW_2_1_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw21_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw21_mem_regions),
@@ -1000,6 +1004,7 @@
 	{
 		.hw_id = QCA6174_HW_3_0_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw30_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw30_mem_regions),
@@ -1008,6 +1013,7 @@
 	{
 		.hw_id = QCA6174_HW_3_2_VERSION,
 		.hw_rev = ATH10K_HW_QCA6174,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw30_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw30_mem_regions),
@@ -1016,6 +1022,7 @@
 	{
 		.hw_id = QCA9377_HW_1_1_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA9377,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca6174_hw30_mem_regions,
 			.size = ARRAY_SIZE(qca6174_hw30_mem_regions),
@@ -1024,6 +1031,7 @@
 	{
 		.hw_id = QCA988X_HW_2_0_VERSION,
 		.hw_rev = ATH10K_HW_QCA988X,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca988x_hw20_mem_regions,
 			.size = ARRAY_SIZE(qca988x_hw20_mem_regions),
@@ -1032,6 +1040,7 @@
 	{
 		.hw_id = QCA9984_HW_1_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA9984,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca9984_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca9984_hw10_mem_regions),
@@ -1040,6 +1049,7 @@
 	{
 		.hw_id = QCA9888_HW_2_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA9888,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca9984_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca9984_hw10_mem_regions),
@@ -1048,6 +1058,7 @@
 	{
 		.hw_id = QCA99X0_HW_2_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA99X0,
+		.bus = ATH10K_BUS_PCI,
 		.region_table = {
 			.regions = qca99x0_hw20_mem_regions,
 			.size = ARRAY_SIZE(qca99x0_hw20_mem_regions),
@@ -1056,6 +1067,7 @@
 	{
 		.hw_id = QCA4019_HW_1_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_QCA4019,
+		.bus = ATH10K_BUS_AHB,
 		.region_table = {
 			.regions = qca4019_hw10_mem_regions,
 			.size = ARRAY_SIZE(qca4019_hw10_mem_regions),
@@ -1064,6 +1076,7 @@
 	{
 		.hw_id = WCN3990_HW_1_0_DEV_VERSION,
 		.hw_rev = ATH10K_HW_WCN3990,
+		.bus = ATH10K_BUS_SNOC,
 		.region_table = {
 			.regions = wcn399x_hw10_mem_regions,
 			.size = ARRAY_SIZE(wcn399x_hw10_mem_regions),
@@ -1111,7 +1124,8 @@ const struct ath10k_hw_mem_layout *ath10k_coredump_get_mem_layout(struct ath10k
 
 	for (i = 0; i < ARRAY_SIZE(hw_mem_layouts); i++) {
 		if (ar->target_version == hw_mem_layouts[i].hw_id &&
-		    ar->hw_rev == hw_mem_layouts[i].hw_rev)
+		    ar->hw_rev == hw_mem_layouts[i].hw_rev &&
+		    hw_mem_layouts[i].bus == ar->hif.bus)
 			return &hw_mem_layouts[i];
 	}
 
diff --git a/drivers/net/wireless/ath/ath10k/coredump.h b/drivers/net/wireless/ath/ath10k/coredump.h
index 8bf03e8..492dddc 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.h
+++ b/drivers/net/wireless/ath/ath10k/coredump.h
@@ -156,6 +156,7 @@ struct ath10k_mem_region {
 struct ath10k_hw_mem_layout {
 	u32 hw_id;
 	u32 hw_rev;
+	enum ath10k_bus bus;
 
 	struct {
 		const struct ath10k_mem_region *regions;
-- 
1.9.1

