Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F175F3B5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjGXKpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjGXKpx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2717E6
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665BF61073
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707E0C433C8
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195551;
        bh=ZJIbpRmHAQ/GRLtdtgPoqwrI+BJlmJv8VBjgsy5ceg8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JMKwVYT7dc7YZjVrZwpd7cEqzN9bRAKLOO1Ir8BaywK47421JqmcDUiVf5XVNCsDj
         tqNGz6pjsiHdUcXCgyj1jpfOx+YqHamUszMI2RtqjRMHrDXR56fytQ9dHMM3YACnrz
         Tr30Euo/AiEI/kt3jBZIR9ozGKwQXReJJK9k+oEWHl5t3ejpRfOa6Fjegg4Cak36zL
         H/fycXRff0zvAN3TXqV6+5aCDNUkmxUUCmwGkNf9AYWNDrEGc15CGzN2kd4jX4WXaK
         fTpVPo6sJNsoq23zfgRFI+5e0tX8+o2FIPPsmzIpySb0BYGgDVJVzX4+2AbfMIwbDS
         Ar4M3ahmB9Zxw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/9] MAINTAINERS: wifi: atmel: mark as orphan
Date:   Mon, 24 Jul 2023 13:45:40 +0300
Message-Id: <20230724104547.3061709-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724104547.3061709-1-kvalo@kernel.org>
References: <20230724104547.3061709-1-kvalo@kernel.org>
MIME-Version: 1.0
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

Last activity from Simon is from 2005 so mark the driver is orphan.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b61f43595e8d..ea84170767d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3260,9 +3260,8 @@ F:	Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 
 ATMEL WIRELESS DRIVER
-M:	Simon Kelley <simon@thekelleys.org.uk>
 L:	linux-wireless@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.thekelleys.org.uk/atmel
 W:	http://atmelwlandriver.sourceforge.net/
 F:	drivers/net/wireless/atmel/atmel*
-- 
2.39.2

