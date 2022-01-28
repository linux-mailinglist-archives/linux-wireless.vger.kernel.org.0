Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B749FB24
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiA1N6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiA1N6r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:58:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47633C061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 05:58:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB86961DB4
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65A8C340EA
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643378326;
        bh=MzNO1CBbAMFkTSk8jH5o4O2KEcuW8YAz7nbf+Via0c4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eEAT2mnnmQ/vUDY4PijhJcOCpkVkwfEGocsChuuFcnFlNaok8KmFJj5MlsO1wJpxR
         1yU41tbViTGC4+2md5FG5wyANbPcl07uIZ8DlVp60RwBGkVzky+tHLbqVdmAkP79Kh
         +f1IwO/F06+8BJO7b0UL6A+0Fngvk4cF6/5jVEaqRlXkD5XqclPCC2O58iJ48kaE7i
         S7DowcQRFj3/aSywH9seRP+WRrcGzMfWWEYpdhhTReEEb7mqbLgUWpc1ZVRIfdyD0k
         2Gq7cwcnpz4sGSqWqfgGTt7ylBhBFwOLI+gwe/17qRKj0KtSyI6viVoKlXW0X093Wl
         dyiZ2CZ1RZijw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH wireless v2 2/4] MAINTAINERS: change Loic as wcn36xx maintainer
Date:   Fri, 28 Jan 2022 15:58:39 +0200
Message-Id: <20220128135841.1926-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128135841.1926-1-kvalo@kernel.org>
References: <20220128135841.1926-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I don't have time for being wcn36xx maintainer but Loic is willing to step up.
Thanks Loic!

Also remove Eugene's old tree, it has not been used for a long time.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
Acked-by: Loic Poulain <loic.poulain@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba8c466a5403..f57dcc8862c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16081,11 +16081,10 @@ F:	Documentation/devicetree/bindings/media/*venus*
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

