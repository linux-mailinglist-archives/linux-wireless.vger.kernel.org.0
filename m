Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763CA72E54E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbjFMOKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjFMOJx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6021BE5
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CBC635E7
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A2C433F0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686665363;
        bh=uqczZrDZXEPNGEqebmyy1y70gdSr30LkBaW8pslQQVg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BW0Q/kgWBltboi+xnIJPTdZc7j0ew2E+VxY5tFpI96WKE4XwkhvyPGv5rxMuz5Gmh
         ny1bkH/mmVlER4G3vFO+kSnNWLGb+BVDsVwpuB+9uxQVrE4jLNyaWrmDo3WPm4veYR
         3SMDwrvVmWE/eEAUKCd1q86pG7LxVI4R+7mlITfzg+AU59Ab7+qSmezTAYk+cZoEx7
         CkXBylPkEqH5yi7VXu9V/c3rZDAruZdIB0asceHbzBzWfnP/KlYMnCPIChBeKRLZni
         EsRtgM1kto7+P6BG0sNeqVAmJnT15kbywO2Vda7O/LSFf5ne+ig2sqnhA8lo6mUdcL
         H1xu16mkcyIqg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] wifi: hostap: fix stringop-truncations GCC warning
Date:   Tue, 13 Jun 2023 17:09:17 +0300
Message-Id: <20230613140918.389690-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613140918.389690-1-kvalo@kernel.org>
References: <20230613140918.389690-1-kvalo@kernel.org>
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

With GCC 13.1 and W=1 hostap has a warning:

drivers/net/wireless/intersil/hostap/hostap_ioctl.c:3633:17: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]

fortify-string.h recommends not to use strncpy() so use strscpy() which fixes
the warning. Also now it's guarenteed that the string is NUL-terminated.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intersil/hostap/hostap_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c b/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
index 26287b129d18..b4adfc190ae8 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
@@ -3630,7 +3630,7 @@ static int prism2_ioctl_get_encryption(local_info_t *local,
 		param->u.crypt.key_len = 0;
 		param->u.crypt.idx = 0xff;
 	} else {
-		strncpy(param->u.crypt.alg, (*crypt)->ops->name,
+		strscpy(param->u.crypt.alg, (*crypt)->ops->name,
 			HOSTAP_CRYPT_ALG_NAME_LEN);
 		param->u.crypt.key_len = 0;
 
-- 
2.30.2

