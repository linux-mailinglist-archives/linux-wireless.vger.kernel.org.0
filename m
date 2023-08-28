Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E1C78B093
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjH1Mgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjH1MgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1729511A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FDED646D1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5CBC433C8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226170;
        bh=sJrZoAuchfnCdB+PMm55PvUXQMCF0CMDe0HOGp6ONyU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cmFhaujJ0pC0sV7sEJuhnfXIrU/eu6MIO1/w38snyrmCsmpv3AaoUKrKLWZd6f9W7
         pqiyWuc2ctnvWT1SMopUS+PEcGTY8AjRuVFLLz040XSrR2ZK/AsCZeQy2jjGUe7DpC
         GNK/P5/F4HgsB1QHHmU3/12gB4anohsPO9FY+8d5m0zFX5IsOLw0HDnE0K1OovraZP
         E7QHHXIUy6AisvwROBiiFg16ne3dqwy/oKuxglVieHJeNSm9CFEbi8DF+CRVrsmLWX
         tZrp1GcJWtImAPmEewduUAP+Yj7Muq8CXPSeVfrVdh5usi2F/T2oBgyNQDqtVcNTQM
         3KHUMbivWYgAQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/5] MAINTAINERS: wifi: hostap: remove maintainer and web page
Date:   Mon, 28 Aug 2023 15:36:03 +0300
Message-Id: <20230828123603.87621-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828123603.87621-1-kvalo@kernel.org>
References: <20230828123603.87621-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As hostap is marked as obsolete there's no need to have a maintainer. Also
remove the link to the web page.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 22187d5401cc..b7c44aa55bf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9476,10 +9476,8 @@ F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 F:	drivers/iio/pressure/mprls0025pa.c
 
 HOST AP DRIVER
-M:	Jouni Malinen <j@w1.fi>
 L:	linux-wireless@vger.kernel.org
 S:	Obsolete
-W:	http://w1.fi/hostap-driver.html
 F:	drivers/net/wireless/intersil/hostap/
 
 HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
-- 
2.39.2

