Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059175F28E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjGXKQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGXKQS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7C4C3D
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FF5961004
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22075C433C7
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690193306;
        bh=m9JYSC+5Rp/ldrharwh/9Y6b7HOGHkKkWSyv7YD8AjY=;
        h=From:To:Subject:Date:From;
        b=GyL21Nl0HRlz3ERkvJhKZSjyczfZx9vOJH0DNVMSCdOcTM9L9hUZhd8YUgkFwp/YZ
         lG4M5tf4IOyrtq7NeoklwargmZKRyfdkI/W6wx0ClYw+vcSPv220ZyJ/rX4jYaKOao
         uHRCbQo27NjQ+/ylznsrAdCNVv7CpT3azL6Amwl3Ulybp+sEEWAi/x5mlFqeVq2ciX
         GE/K8n6+FEj/j2e+aAmmQhj1L2eYDeVACFSuuEojivB4OTHf5IQoG5VlRkjxWoG6BT
         syubY3Cm4CgUdOpdTTUwrbbpKFXVgrZAGa8Kh3OIMk6q7xFyN3IGgZR+recJfbxsZD
         K6sPZWJkI3Xxw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] Revert "wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12"
Date:   Mon, 24 Jul 2023 13:08:23 +0300
Message-Id: <20230724100823.2948804-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
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

This reverts commit bd1d129daa3ede265a880e2c6a7f91eab0f4dc62.

The dangling-pointer warnings were disabled kernel-wide by commit 49beadbd47c2
("gcc-12: disable '-Wdangling-pointer' warning for now") for v5.19. So this
hack in ath6kl is not needed anymore.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/Makefile b/drivers/net/wireless/ath/ath6kl/Makefile
index a75bfa9fd1cf..dc2b3b46781e 100644
--- a/drivers/net/wireless/ath/ath6kl/Makefile
+++ b/drivers/net/wireless/ath/ath6kl/Makefile
@@ -36,11 +36,6 @@ ath6kl_core-y += wmi.o
 ath6kl_core-y += core.o
 ath6kl_core-y += recovery.o
 
-# FIXME: temporarily silence -Wdangling-pointer on non W=1+ builds
-ifndef KBUILD_EXTRA_WARN
-CFLAGS_htc_mbox.o += $(call cc-disable-warning, dangling-pointer)
-endif
-
 ath6kl_core-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath6kl_core-$(CONFIG_ATH6KL_TRACING) += trace.o
 

base-commit: ac528649f7c63bc233cc0d33cff11f767cc666e3
-- 
2.39.2

