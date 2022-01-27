Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052D149DDEB
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 10:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbiA0J1T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 04:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiA0J1T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 04:27:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21653C061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 01:27:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4568B820FC
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 09:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB168C340EA;
        Thu, 27 Jan 2022 09:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643275636;
        bh=h9theQ1q1rjODJPQVzk4OnfRurNcnLtiX9XPW4wsKSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t05xjepxzs5mhBSzpbqns/774G4O7AFjZjWVgJ7iRyr0ZjYzeTUwJ8HOYdShp25TZ
         DiCwe6T9TRHCC55sEfw1XHN2jSUFzLtcoPHxe3eQFoasxJAFqJBtxTsciN8KnG5tgP
         f75PmG7EIjnxnZhljcH2D5Kn2aB2aKCYJ5bubTMCWNk7ZoqesFHTKtd1SH46r7tumM
         CjiTH4QTKRXgaXIcZJSJ7xiqwxSLXxwj7W1E02ijIAx48kVPYZuIj/86HgmXHEM/Ta
         PO6SM6xC5w5YJM3ECTfxzkWaz6YHVCJdy17hrGGKunEuSbZG0/RS2zVjN0sJVESAJ5
         IGr4wdCPaKNxQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     loic.poulain@linaro.org, toke@toke.dk
Subject: [PATCH 2/4] MAINTAINERS: change Loic as wcn36xx maintainer
Date:   Thu, 27 Jan 2022 11:27:07 +0200
Message-Id: <20220127092709.5203-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220127092709.5203-1-kvalo@kernel.org>
References: <20220127092709.5203-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I don't have time for being wcn36xx maintainer but Loic is willing to step up.
Thanks Loic!

Also remove Eugene's old tree, it has not been used for a long time.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e250736e380e..2bf3b1f7442e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16082,11 +16082,10 @@ F:	Documentation/devicetree/bindings/media/*venus*
 F:	drivers/media/platform/qcom/venus/
 
 QUALCOMM WCN36XX WIRELESS DRIVER
-M:	Kalle Valo <kvalo@kernel.org>
+M:	Loic Poulain <loic.poulain@linaro.org>
 L:	wcn36xx@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wcn36xx
-T:	git git://github.com/KrasnikovEugene/wcn36xx.git
 F:	drivers/net/wireless/ath/wcn36xx/
 
 QUANTENNA QTNFMAC WIRELESS DRIVER
-- 
2.20.1

