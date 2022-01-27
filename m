Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A449DDEC
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 10:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbiA0J1V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 04:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiA0J1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 04:27:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288FC061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 01:27:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C74EB61BB6
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 09:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D3EC340E6;
        Thu, 27 Jan 2022 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643275639;
        bh=FrSAdR8rDPRfm4vPu5kU8hQnRj/28R8wG3NbnStzYgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCDFj0c73c02rZKWC+SZXG6GAogDcxi4vuYA+GcqrkX5AnVjLxYqU/7gyeaCCh3Rt
         ACoPXR+Y4UpPiClqjHB+GnYw2bSpWetOxaODT6vW1Ro8YB49MsSa1YfdUyvJdpMyXN
         zJF26ifqlq3l9w9LHc2lGq3TGuCeoGvvIDlYl62/NEhAfM6i99WPg4E9dmDlz8iOvE
         MC3p+5k6vC6Fx6l8+8AK2mzaM7HM1ZMD7PLVMK9pb6XBZobqhUbjsM/6kzhyh7I8/X
         rBZTGHJo2NHZxw/X6CW07tUHyEJE94YYBzQt2d6i51ufKRuRVplgHJSnsVqvhIbHSb
         /He6jSFXCKyKg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     loic.poulain@linaro.org, toke@toke.dk
Subject: [PATCH 4/4] MAINTAINERS: add DT bindings files for ath10k and ath11k
Date:   Thu, 27 Jan 2022 11:27:09 +0200
Message-Id: <20220127092709.5203-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220127092709.5203-1-kvalo@kernel.org>
References: <20220127092709.5203-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The DT bindings files were missing for ath10k and ath11k so add them now.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1251fc9a71d..5b87ce49f786 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15890,6 +15890,7 @@ S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath10k/
+F:	Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
 
 QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
 M:	Kalle Valo <kvalo@kernel.org>
@@ -15897,6 +15898,7 @@ L:	ath11k@lists.infradead.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath11k/
+F:	Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt
 
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
 M:	toke@toke.dk
-- 
2.20.1

