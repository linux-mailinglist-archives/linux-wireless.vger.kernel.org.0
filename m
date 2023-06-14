Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1228B730230
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbjFNOrM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjFNOrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 10:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4712C
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 07:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D900E64314
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 14:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D943CC433C9
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686754029;
        bh=ReSzPFSuWUFy7IHnjsGle65nSiCmMZbkWceDEaT5htc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qUEDNJE1rTeeT2tfcHTLjxGPiBlnYwNclNaG6+ljDEiu6A6vtndl+QQA0LSqwm5al
         /gSn4PG2KjrgbzGWp2mE7xOEP1W9C2FH+5x/YuLrmqdl3SrJ8nQxCXVVSnGmKz8Axo
         lklmd82G27EwQGZM24X5XxZVXy0HMF8WXb++dYEdndI5SI/9IoUzrNqtWNIqywmLA6
         0Xj2cqUsVNx/9Gytksvwc2vFkGfyG7gawogog2MIvuiyDa1Xl+k2/wL+cSckG9zC3s
         by0Dv+9B6pioesJ1X8jm9auCwKQglNghaRZ/7niJWr7YrQm/VK4z7Dsj9lFq5d/hle
         Lv5K/Qa+9fYIQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] MAINTAINERS: ath9k: add git tree
Date:   Wed, 14 Jun 2023 17:47:03 +0300
Message-Id: <20230614144704.505553-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230614144704.505553-1-kvalo@kernel.org>
References: <20230614144704.505553-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath9k patches go to my ath.git tree, document that.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d7fdf47dd8..ddeae82230c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17371,6 +17371,7 @@ M:	Toke Høiland-Jørgensen <toke@toke.dk>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/
 
-- 
2.30.2

