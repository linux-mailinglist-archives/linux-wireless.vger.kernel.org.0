Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB34749FB25
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiA1N6s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiA1N6r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:58:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E115C06173B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 05:58:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF3F61CE5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B5AC340E7
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643378325;
        bh=v8V5E8zZluPmzvxgsEWYR2/GukmwQuO3+9l/5hYqPiA=;
        h=From:To:Subject:Date:From;
        b=mJVV0Z1rufcmRk2+CwtS89SQSQKemMfsi4fZRxJPUSZaC9imBU/4+Z/rx5A7/zBP9
         qiyv/iyGBOnzPqJSiJiONn78Khtv5dYBffmngyiEfG8maali4wZcLm/p0A74Ohta4f
         VpUuVmOOOo1BWkFbRq1gIwGNIbkBp9fIYduKSIQQGVX+WqpiFuroj/Z289swQ0N1Id
         xBMSVKkLZkjHbqzonG4uaNWWBscRe2vL5PLncCZcMhxlXpWs66jrkqAavF+Gk0xg4J
         4lQ3SA+BE4KxxgcUmPQjZpl8hudjw3zRiSVwKxmvAw4FvMja6U9wg28fpDy9lnPMzv
         bOjDbBW5o4MRg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH wireless v2 1/4] MAINTAINERS: mark ath6kl as orphan
Date:   Fri, 28 Jan 2022 15:58:38 +0200
Message-Id: <20220128135841.1926-1-kvalo@kernel.org>
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
index f41088418aae..ba8c466a5403 100644
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

