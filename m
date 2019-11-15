Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9EBFD94C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKOJb5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:31:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfKOJb5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:31:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 92A9361645; Fri, 15 Nov 2019 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810316;
        bh=VeiYsOiJ34C6mK+O1IMpFSujsRltb99Y7wY7+/sOdn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLmS5t6Oe1UGFhlMSL+JD2o9UVlRwOOGhkuvrFiYstOYm43UsZrWbG6KEtS3vm72/
         BH098W4SFH2IKKB0t/IVpwGlSBEHUgLFy8xxZZLOJ6CEKeRAMq2FwadNzy71O00yJ8
         b1bkoEFnmCROmtAfKE8o0LLT4XzALjqYjMuQoQ1o=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A09D16189A;
        Fri, 15 Nov 2019 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810284;
        bh=VeiYsOiJ34C6mK+O1IMpFSujsRltb99Y7wY7+/sOdn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5h4JpuNaMXXtLb++thIkG3nO4XA9eoSdhtSuXD41gqAA5jp7B7+zmgDeps/Pf6Ei
         Qw84OwKhopXiK5Zl4yBcO+Opg7oGbfXeeq2QdMkk8VkForqhnJT2y0et8GtTx+hY1K
         VI3+pvRLag1lAIlIQy7Ls8dVunktqqfXOheLtvDY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A09D16189A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 49/49] MAINTAINERS: add ath11k
Date:   Fri, 15 Nov 2019 11:29:13 +0200
Message-Id: <1573810153-29623-50-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add an entry for ath11k to the MAINTAINERS file.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 677ef41cb012..ae00b2c443b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13028,6 +13028,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 S:	Supported
 F:	drivers/net/wireless/ath/ath10k/
 
+QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
+M:	Kalle Valo <kvalo@codeaurora.org>
+L:	ath11k@lists.infradead.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+S:	Supported
+F:	drivers/net/wireless/ath/ath11k/
+
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
 M:	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
 L:	linux-wireless@vger.kernel.org

