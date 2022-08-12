Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B825913B2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiHLQLW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbiHLQLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E98A5719
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52C661579
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B308AC433C1;
        Fri, 12 Aug 2022 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320659;
        bh=BEx0VdeZ1XIdZPpAz33Ip1VWpLLqTaOVhzeD8qXteLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcbPUu1LH4vjwpBpXS1+SaM7npSknnXMJwifvAUutZQjdSMrBIcuT+h2+MOSKfn9P
         S7iy/LwevzaDccLU4mIZcdI2DS8BEhZuTgt6iY9j8To2oo7X7qnz+DRQ6Cl+8I92zz
         GlJvxhKXNE7VjIV2eMnN2NoVFWKWYpSz6dKqa++9WyUupoOcWbTyl2ntf+eYOLuWou
         /oFAgC1yQpd4ogzUYqTR/kQpQOZmaDAdvhlbCFPX4/yYcWtgV4foKOQUbUfd/SFTA7
         sI2KFk1RpLFuz0wXtPRvEwOJbn3TscUYoTrCAAnORmz1OXqMJDN3FkxAEk8wdgrKM7
         rOQzD2VGBAZpA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 50/50] MAINTAINERS: add ath12k
Date:   Fri, 12 Aug 2022 19:10:03 +0300
Message-Id: <20220812161003.27279-51-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Add an entry for ath12k to the MAINTAINERS file.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66738c8330db..98d7b5ba058b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16571,6 +16571,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
 F:	drivers/net/wireless/ath/ath11k/
 
+QUALCOMM ATH12K WIRELESS DRIVER
+M:	Kalle Valo <kvalo@kernel.org>
+L:	ath12k@lists.infradead.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+F:	drivers/net/wireless/ath/ath12k/
+
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
 M:	Toke Høiland-Jørgensen <toke@toke.dk>
 L:	linux-wireless@vger.kernel.org

