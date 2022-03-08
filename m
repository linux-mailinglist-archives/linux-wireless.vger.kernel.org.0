Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD194D2138
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Mar 2022 20:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346787AbiCHTRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Mar 2022 14:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346125AbiCHTRc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Mar 2022 14:17:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF784EF43;
        Tue,  8 Mar 2022 11:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 488D4616FC;
        Tue,  8 Mar 2022 19:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ECCC340EB;
        Tue,  8 Mar 2022 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646766994;
        bh=Fu2+du27mPeyWB/PDbKYvuwCo7ltPFwmx06XNnyZY7A=;
        h=From:To:Cc:Subject:Date:From;
        b=o/hlIdKYRrTyc6h6rR1yLHYhJHy4QtreQbhoyXan55QuGi6iVoZX9/uP3JndCqRgn
         xjElT/x8orFiyhATdmy0N+RBd6ri0OnostODBMT060IEV/9Gq1sHlFz4y3qwMwMrNI
         5PikzG/r1+XU0JxUcyW00rcOec4S8CUGfoyd85BpMYUtqV6B6gztwN8YL1Vn/yggTY
         uZo/7PN3/cDYDbx+CmDMoKnkiuaclJ/3yGFqtAx6PwGij7EIl2Kz1d7WC+zcsqZQ60
         w2mDO/qCYZsmQ87qq5BK38hivXJkQ5wGqet827vn2DjO7IUcB6CBvHqhpAdN3DQ1kL
         HZvoLtTimiVCA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: [PATCH] MAINTAINERS: add devicetree bindings entry for mt76
Date:   Tue,  8 Mar 2022 20:16:13 +0100
Message-Id: <8cbfeceef642ede408b4922c363953cb243cd87f.1646766851.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Specify devicetree bindings entry for mt76 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25eb3097baae..6074f0cea715 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12152,6 +12152,7 @@ R:	Shayne Chen <shayne.chen@mediatek.com>
 R:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
 F:	drivers/net/wireless/mediatek/mt76/
 
 MEDIATEK MT7601U WIRELESS LAN DRIVER
-- 
2.35.1

