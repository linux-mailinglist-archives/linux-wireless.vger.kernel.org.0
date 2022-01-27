Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDA49DDED
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 10:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiA0J1W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 04:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiA0J1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 04:27:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC52C06173B
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 01:27:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 239B3B821BF
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 09:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C12BC340E4;
        Thu, 27 Jan 2022 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643275638;
        bh=2AFS6B32nX4fLERjlOI7wBnNXvraqO5Z14/OQId/Dxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tge8UB2zmrNwCEi6VZgWJRM22kne/K0OBRPuhmcfvCDY6q2JAKf3cij8A5Z3XUqoK
         wGdc7tLOcsL6fz58HmeWWN/EOEXuC5rxxVxA3NqTk00iW6fKXTLpLYalI6h9x46MF+
         DDluHu6bbVSNG/6CsV6VtBKZlTGg6tre8Vqi3XfLBDovU3hb6gFY9kAzDrhw4UVpmF
         NW6kWyqKyNzjj87/hIXAmKeZOzaFs4/dDCfTEEpoOEM4/p/cOUsV4T+HhCVJ93vFEQ
         F8/96z37dYMIWpQ9JEN+Mjxthw7yNB77tQ1+DDUqxPNJwik6DbKb5wMECCCZfTv1o/
         HMtgD5oF8nUBA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     loic.poulain@linaro.org, toke@toke.dk
Subject: [PATCH 3/4] MAINTAINERS: hand over ath9k maintainership to Toke
Date:   Thu, 27 Jan 2022 11:27:08 +0200
Message-Id: <20220127092709.5203-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220127092709.5203-1-kvalo@kernel.org>
References: <20220127092709.5203-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In practise I have been the only maintainer for ath9k for some time now but I
don't really have time for it. Luckily Toke is willing to look after so mark
him as maintainer. Thanks Toke!

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2bf3b1f7442e..b1251fc9a71d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15899,9 +15899,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath11k/
 
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
-M:	ath9k-devel@qca.qualcomm.com
+M:	toke@toke.dk
 L:	linux-wireless@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
 F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/
-- 
2.20.1

