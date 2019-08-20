Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717709658B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfHTPvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:51:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53098 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbfHTPvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:51:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 05C3261CA6; Tue, 20 Aug 2019 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316299;
        bh=EVpGFlJ2L8x/uNtoGBy+rwLSlBYLWFAycqzPtk2P2PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6NuRNiqLWUlTiF5L206/d5/LUbW/pWXrDrDP83IxGzH2FK8rEJwsrMOtijBaXgKH
         yptngPq028qJpKy1cGhYyFh+VqAnPZSoGOR65Eqj+JVWZrLjmZf7dyTuby07483/fX
         SEqOcV9n02XGrfqzVCqlrDtMtOM2x/EpY4FY4lh4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CDB661C74;
        Tue, 20 Aug 2019 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316229;
        bh=EVpGFlJ2L8x/uNtoGBy+rwLSlBYLWFAycqzPtk2P2PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzlSYCsvQ6o9/fnK7L81ZzdmhJ+pZ/e53nFZqS6zD0BGK9DSjZatM8mKc6h+4cvFT
         j2ZARJlQ4XxCxkj34sVufYs3RFk64UMxztdBpmHaDgl81ngSPAk1vAZv1dsQl7x5gJ
         iFzF3qIE4RcDla94OckWw5xVf35MxnBrC0GJIaQs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CDB661C74
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 47/49] ath: add ath11k to Makefile
Date:   Tue, 20 Aug 2019 18:48:13 +0300
Message-Id: <1566316095-27507-48-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
 

