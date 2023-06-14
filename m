Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C199773022F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 16:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbjFNOrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 10:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244306AbjFNOrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 10:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBF1BEC
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 07:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8040612DC
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 14:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9F1C433C8
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686754028;
        bh=dpcDNIpTrTbOc5wKVbpx4QHCZoYUc3e6lgeVOh1bFlk=;
        h=From:To:Subject:Date:From;
        b=hYGchH8vALWFojpkS1+y9iNhjYDqO4LmpnWC9a5xx6x7QFa3PN93GYOPT2Pvz7ybS
         ja83mfKoy3DCt8DonMjfbl9b8cUPSY/5X4nQc24wdqy/zsd+GyOJnHxfm7TdeSUyic
         Qm6usQXyQoTNHkoESpHz3x5gZIliddstuKK9bCVGGXSA9nQiMTLGfZAHh7erW8Mx0T
         Ue7/yRkWJCkAkLWGJHI/7VzMyMsYRoINlzdOkG0Xxm8KrTqEk+Ujg3NmmVbemvtVdD
         q3+sdD4hkIDQWkPzGfjFYXFU2kOIa8m5ugF6t9Ku4dE3NO9UJLfmHv73KQzxlkYivv
         t/wt+ZRDy74+A==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] MAINTAINERS: mt76: add git tree
Date:   Wed, 14 Jun 2023 17:47:02 +0300
Message-Id: <20230614144704.505553-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix has a git tree for mt76 patches, document that.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0971854323a7..f7d7fdf47dd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13212,6 +13212,7 @@ R:	Shayne Chen <shayne.chen@mediatek.com>
 R:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
+T:	git https://github.com/nbd168/wireless
 F:	Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
 F:	drivers/net/wireless/mediatek/mt76/
 

base-commit: 93ae81454b1107843ad36dcdc457dd10ee0f2cbe
-- 
2.30.2

