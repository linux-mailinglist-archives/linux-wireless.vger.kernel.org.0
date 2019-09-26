Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51646BF41D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfIZNgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 09:36:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfIZNgR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 09:36:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B1DC60B72; Thu, 26 Sep 2019 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569504976;
        bh=YuHVzHnU2iBdI6dRQ86mrnB17MCHWfndjfloXSheE/8=;
        h=From:To:Cc:Subject:Date:From;
        b=kJY8LxxqkDD7JZL9rXWrIfvEY43MUCYIEQ+tuA1VheOZHfcXUNlb8jPbaM8NYCBu6
         6AMgvwtlUTjgjUi06JeMjha9Kor+O13FuTGHpQeNZgdzF8yzBLnEqZ2g0UoejNKuK8
         uLdxBHnb/JMqwQ3mC0Jo5iMPTFEn7Fvwt/pK7Irs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D60A460128;
        Thu, 26 Sep 2019 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569504975;
        bh=YuHVzHnU2iBdI6dRQ86mrnB17MCHWfndjfloXSheE/8=;
        h=From:To:Cc:Subject:Date:From;
        b=YmGO4WAIubHXOn2jueGRQGy4wZ3tRlJz5LCox+Jty7GFYkNTvwLVm3y1eN8WfNXMh
         k+D7exeoNLnZgnUMFMf+0RMppO41tursHb4RvdFu4lmc7X+n6vKNT3T4PS4IHBKI9N
         HWi7tYP7NZZz+QzAppzHD6Erpt7OTXoZH4WYtskg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D60A460128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 1/2] ath10k: fix IRAM addr in coredump
Date:   Thu, 26 Sep 2019 19:07:00 +0530
Message-Id: <1569505021-20515-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix IRAM start address in coredump.
Tested on: QCA9984, QCA4019
FW version: 10.4-3.9.0.2-00044

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/coredump.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/coredump.c b/drivers/net/wireless/ath/ath10k/coredump.c
index b6d2932383cf..ecd3dd5d8356 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.c
+++ b/drivers/net/wireless/ath/ath10k/coredump.c
@@ -703,7 +703,7 @@
 	},
 	{
 		.type = ATH10K_MEM_REGION_TYPE_REG,
-		.start = 0x98000,
+		.start = 0x980000,
 		.len = 0x50000,
 		.name = "IRAM",
 		.section_table = {
@@ -786,7 +786,7 @@
 	},
 	{
 		.type = ATH10K_MEM_REGION_TYPE_REG,
-		.start = 0x98000,
+		.start = 0x980000,
 		.len = 0x50000,
 		.name = "IRAM",
 		.section_table = {
@@ -891,7 +891,7 @@
 	},
 	{
 		.type = ATH10K_MEM_REGION_TYPE_REG,
-		.start = 0x98000,
+		.start = 0x980000,
 		.len = 0x50000,
 		.name = "IRAM",
 		.section_table = {
-- 
1.7.9.5

