Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF74CFD94A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfKOJbn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:31:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKOJbm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:31:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE6E761708; Fri, 15 Nov 2019 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810301;
        bh=7yr0h2lx+YiXkiqw/19KA0wgyqVjlnuYE49SnKa4coI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lq/RLOhCPxkaABR95V4Z0ZLunOIyqCAHY5Z1SiaMfMf9Ra4zGK0hqjv0VnTeMqa4s
         BIokCFXf+buvN0UDDWZQof5dZ5ZiQswAE8KktVwxl/eBO5hDism+7ZtKdp7dPxr2B7
         XRT1HFNW3bOOfF64r6mgRjoso4w43e1xK7awPWIM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6124661680;
        Fri, 15 Nov 2019 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810281;
        bh=7yr0h2lx+YiXkiqw/19KA0wgyqVjlnuYE49SnKa4coI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSXRgyRNBBwiVG85k0kV0HdOMsPiwi9JYVk76VSAV7FPTRct6v7lc2KH0y8ItO+lB
         aRgbeAiDj76WKCKGTVlsdUUQfFnQ2KMdhx/iivXWAmH1RVkNXm0RRDtOWr1D3ZeR9z
         TdIE/oqWbpT2DXreEMz7Cx2VM81i6xyDdaflfHaM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6124661680
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 47/49] ath: add ath11k to Makefile
Date:   Fri, 15 Nov 2019 11:29:11 +0200
Message-Id: <1573810153-29623-48-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/Makefile b/drivers/net/wireless/ath/Makefile
index e4e460b5498e..72f8e3a24c67 100644
--- a/drivers/net/wireless/ath/Makefile
+++ b/drivers/net/wireless/ath/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_AR5523)		+= ar5523/
 obj-$(CONFIG_WIL6210)		+= wil6210/
 obj-$(CONFIG_ATH10K)		+= ath10k/
 obj-$(CONFIG_WCN36XX)		+= wcn36xx/
+obj-$(CONFIG_ATH11K)		+= ath11k/
 
 obj-$(CONFIG_ATH_COMMON)	+= ath.o
 

