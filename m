Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB139658F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfHTPvj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:51:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfHTPvj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:51:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7CF761CEA; Tue, 20 Aug 2019 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316298;
        bh=vpIUBg/nANIwPhSup/mTfrmjsi5diYXgvESg6ENuay0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/KFSsnplFCC02jpa2f/FpKgtzFJiPSj5hZdlKYz9kF4oV7ft1QmSDtHe7Acg7sFL
         O5hz/Je3379HGWmEJ4jBYKN0L9GomXg3PfX9aNR4Yf4SKCqkAH1BYyO2kcUL8AlVKl
         zQ751WgtAr+OSGe0MduPIXsgWn+gt8/oV+t+O91U=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A3C461CB7;
        Tue, 20 Aug 2019 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316233;
        bh=vpIUBg/nANIwPhSup/mTfrmjsi5diYXgvESg6ENuay0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQwU4pRtC+633zhI/4jifVifbbqJhkw8tJ91W+abupyi1WQl6cDwXBXs9OYS+g9TJ
         mFYC37ZTddFMujDftEksD3mkpq0ZKuHN+ZD4R3yHJuvK9Utrcjsd+KgqjN0fdK2LwN
         Y78Ef/8tEdpNQCKBxmUFaMLWdvABb/fEAarYnK4M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A3C461CB7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 49/49] MAINTAINERS: add ath11k
Date:   Tue, 20 Aug 2019 18:48:15 +0300
Message-Id: <1566316095-27507-50-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

