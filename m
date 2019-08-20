Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714889658D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfHTPvm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:51:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53184 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbfHTPvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:51:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E9DFC6158B; Tue, 20 Aug 2019 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316300;
        bh=ir5LWdwA1YKq/fZHz8dUvThhjcjbTbTGPAkBODcxRxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mllD6QuFYueqgn+ZZ172CvRgHSzP8HuwHeEA+s0lXiLsqOanfgUlLIJJaFiCxyc1l
         lD6AtWlrT+eFqTJnFIAozyUlsdaMO/mCexzNtHuIM7PTUcPcNuJBgYOm507JsyNEJZ
         D2Bgk1Pg4IeB0L7E9Fc4iq3KmKO6gStgYvNEuSQo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4FEA61C95;
        Tue, 20 Aug 2019 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316231;
        bh=ir5LWdwA1YKq/fZHz8dUvThhjcjbTbTGPAkBODcxRxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mla9wOw4+ZvUZuOZrGERdEddZhTLYbnILS77Sv6BXIL7DPewDOKcPbNZTNieEg8Uo
         tZV/kBH7KAaDC1/r1fDIFXrqv8vd+c6lqd2kXOcFCYpLoGcgCwX9tyJsDKx1iq1Gbw
         V70BorTOU//1xEHPfWlFSHffwhDMo4JCBQlv90BE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4FEA61C95
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 48/49] ath: add ath11k to Kconfig
Date:   Tue, 20 Aug 2019 18:48:14 +0300
Message-Id: <1566316095-27507-49-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/Kconfig b/drivers/net/wireless/ath/Kconfig
index 82ab7c33cf97..88473bcdd196 100644
--- a/drivers/net/wireless/ath/Kconfig
+++ b/drivers/net/wireless/ath/Kconfig
@@ -61,5 +61,6 @@ source "drivers/net/wireless/ath/ar5523/Kconfig"
 source "drivers/net/wireless/ath/wil6210/Kconfig"
 source "drivers/net/wireless/ath/ath10k/Kconfig"
 source "drivers/net/wireless/ath/wcn36xx/Kconfig"
+source "drivers/net/wireless/ath/ath11k/Kconfig"
 
 endif

