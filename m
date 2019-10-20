Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3BDDDE5
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfJTKGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:06:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfJTKGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:06:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ABD596124D; Sun, 20 Oct 2019 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565972;
        bh=1v6TLeEtmhwNqEaAwzgjYBDH5RMoH2RrcEvrvQrbMK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mou8xUqzXtArFBIzwd8JSzGqJPWWK9B7DO6jYBtaljAIiUnv/v6qQuNDbDxWdQplJ
         7LzkDRA5pVHqrsoJcztnNZ+vnXYSu2uhfxqjz84GmTcKy2ussPWDg8+TzO34CUMbfm
         TG2rlir12omhcUoDTfvyEbQR66y0bffyvIASi2BY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A805F614B8;
        Sun, 20 Oct 2019 10:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565967;
        bh=1v6TLeEtmhwNqEaAwzgjYBDH5RMoH2RrcEvrvQrbMK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8+aBExbbekhzV1VLaodlBfV5RshVwcVZLcvMfW6tYi5vMXPgTvH94KVgXKkNfmmK
         UfyNY6YyE8bFIhf0eg4nIEycnKGn1P8CW0NTfbwxgAbN6Jrs4mj/QbK12MF7ZODT/J
         L9h1sry+Esyft2omxH/1nA8/CYv8i8Ri9y2hk9lc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A805F614B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 48/49] ath: add ath11k to Kconfig
Date:   Sun, 20 Oct 2019 13:04:06 +0300
Message-Id: <1571565847-10338-49-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
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

