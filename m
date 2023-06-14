Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394D6730231
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbjFNOrN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbjFNOrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 10:47:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A845107
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 07:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B84636F6
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 14:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3FFC433CB
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686754030;
        bh=TBMehHk6esWKTvB9WJckmGaUwFBGSOmjgnWwa452Dww=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aKqXqWJuDP5kYtCu0ZLUe0GLSkILyQqVr1V1zPR+fT9yDswgjTpKqSiKQHbLmpPM1
         mIgy/ax2oVgmLd2EQFIRt9jZw3Dif2S17BD6bK5W8BuTH+2ZaDYnM9YQqxC2XW4BW/
         /kiwy9CYow7nf38+g5Y3szBcomuSwHvyQbNeGt/NDJVR1oNih0HcAeJUbBSMmssMuW
         kM1tj9FD27t45n7hEulaYMVL90ZCTyqIdm67jfzpzWPgE0v3Tot2xXxU4qyozmQj+G
         K+fJycONRl0fk7xhCgTOy6vaJqLBc9/JBSIl2OOBVim/nGZEiip3KnHJWWJFeKH0Cn
         kxsEx5OCoDk3A==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: ath11k: add wiki and bugreport page
Date:   Wed, 14 Jun 2023 17:47:04 +0300
Message-Id: <20230614144704.505553-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230614144704.505553-1-kvalo@kernel.org>
References: <20230614144704.505553-1-kvalo@kernel.org>
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

ath11k has a wiki and a separate page about reporting bugs, add those so
hopefully people find them easier.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddeae82230c6..ac365fc4ea6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17362,6 +17362,8 @@ QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
 M:	Kalle Valo <kvalo@kernel.org>
 L:	ath11k@lists.infradead.org
 S:	Supported
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k
+B:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k/bugreport
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
 F:	drivers/net/wireless/ath/ath11k/
-- 
2.30.2

