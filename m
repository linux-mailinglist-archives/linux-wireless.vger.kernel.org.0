Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5BDDDED
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfJTKGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:06:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfJTKGQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:06:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81AF9614BB; Sun, 20 Oct 2019 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565975;
        bh=VeiYsOiJ34C6mK+O1IMpFSujsRltb99Y7wY7+/sOdn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SN4xG3rNN/mRNNxob3z/OG3Fpu8csdw2nBry8mtDGWbtbk3sQ6eJvQoCTijbzjWrj
         Ybv7yCUZcStRwdKfZZ5tRZ+gjZDnYH7m8Vz2O7g2ILB+YEzNhurOytvlJtGkg5A0gF
         FZgAUirpKTa83HXydD2gGoaPV2EnDLNvTqOsTdWc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52D74616E5;
        Sun, 20 Oct 2019 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565969;
        bh=VeiYsOiJ34C6mK+O1IMpFSujsRltb99Y7wY7+/sOdn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCnQ4heKRUL7VjVmkpyAMdqArLL/QQm987KejCo0S3BcUCvOdbbtu1+mQn+RZt0lJ
         urgPvBrmPal+MxoYRpo9y32ISFeQ8ShdF44IC4IIq2Cp/lMDPEjjfYu+rZ3K5UlTnj
         DYpMIhS6xW3cIs1WRvDoMmpa0ZakV2kdQuxrBMG4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52D74616E5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 49/49] MAINTAINERS: add ath11k
Date:   Sun, 20 Oct 2019 13:04:07 +0300
Message-Id: <1571565847-10338-50-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
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

