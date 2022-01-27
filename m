Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97649DDEA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 10:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiA0J1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 04:27:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59178 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiA0J1Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 04:27:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC87261BC8
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 09:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B2CC340E4;
        Thu, 27 Jan 2022 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643275635;
        bh=nzJ1ro5dBdB48eYdSdQDNF6B6Ouh5ZfU20PJQx1gEm8=;
        h=From:To:Cc:Subject:Date:From;
        b=OrgermRQF349WTwMes/UvML/tJO1xXAdndfRzMk/3l4fhDDduFkxZltzqOL1+88xB
         MDQFlcjCDYgLKKAXaDMDq5j1+w344voWC6to5X+U8QX2x0OroDjN+NeTIrNtbdSDfY
         m4+dGpJJeXwgdKX8crECcwjRm8W95LAyFcUvp4AGgqK6/8FlOpm3E7sXsp0Hlbi+OI
         riwPdi+DcrILihrXzzb0reBioFpV+fkY3odqKuR8SbplIrPTYeaeHFFiB3wPsQqFFU
         VMT+drFEqSavl+ip+FW65YVM0TGTPsqzLreVJVb/ZqMDpMT9IaTcr2XwBMrSmfajkA
         YMvACCT9BqEog==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     loic.poulain@linaro.org, toke@toke.dk
Subject: [PATCH 1/4] MAINTAINERS: mark ath6kl as orphan
Date:   Thu, 27 Jan 2022 11:27:06 +0200
Message-Id: <20220127092709.5203-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I don't have time to maintain ath6kl anymore so mark it as orphan.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d7883977e9b..e250736e380e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3133,11 +3133,9 @@ W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath5k
 F:	drivers/net/wireless/ath/ath5k/
 
 ATHEROS ATH6KL WIRELESS DRIVER
-M:	Kalle Valo <kvalo@kernel.org>
 L:	linux-wireless@vger.kernel.org
-S:	Supported
+S:	Orphan
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath6kl
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath6kl/
 
 ATI_REMOTE2 DRIVER
-- 
2.20.1

