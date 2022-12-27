Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D78656B5C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Dec 2022 14:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiL0Ndl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Dec 2022 08:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0Ndj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Dec 2022 08:33:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EBEB1D6
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 05:33:38 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p36so19604682lfa.12
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 05:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+m12+LdV0qVH/ONHii2x67GczAO6pOeoyUweN9nQj+8=;
        b=Yh2pawf3E16eV1eibSejVl52HAL2p7Re5Bms6BZ67c/er5tRGw9XPoJkVNkO311oGU
         f/LDznFLGVyKQg09w34+ObEhk0xhg18/jO0xC9BP6ywqOKLAwKvk45UxdQkY6iiR95tu
         EO9t+XLOXt/gI7wJHPLZkcumb1Y1oyE0TqwcRdTFAeHfBYTheZnmZmz5FFKbpjulhkVR
         NHW1M8dW1qqWAw/3E+8HGi1OkaOTnxRU36hrQrhGY+mmrh/JDfg7ahG5TKjQiIyZ8bnQ
         CghNtcfiZcLKhFum4akDeQxKnqJRGNSRkGwFKC/Lhbx/i0HJBJXEq8DsABTkrpGlyiRc
         J7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+m12+LdV0qVH/ONHii2x67GczAO6pOeoyUweN9nQj+8=;
        b=1q2ETuc85nHiOBRwWNDSlAFwkBeqa7Bn5oIO5CoO4InelDmidWjHHa9NTAthYmlekJ
         IEi4xuphT7aZrUyxv5j2SpwWDYIX/N9q2gXHwU4cF0zBzNgKZf7gPw3G20bzwhmrqdCl
         O0sFEfcx8N3oJ6I9E+jBFfjmLzJYbM6qcQqtkxkoSoIvYlXyUjVIkxB22zni+FB3fY15
         Uh2haXXVjzcw9AJ/tRwV2HG0h4OIwz5Dd0CWPM09ay1KtHkDFpGHVbVpJpWdEaOu25Tf
         JRDu2KPiG/IGqsKUnJCEeAao6ZfLUOVv5Y50mKmcEHVr5VaHb2JNIAQGWz/DKhIg9nmE
         Fh8Q==
X-Gm-Message-State: AFqh2ko7Zfpl28HClpJlrnFr+uu7sicqxhODKMdiAZhGRPZKv3VwZS0S
        /2DG3Rm94GB8t/gwxqHru7OpaQSblc+Ss7Q=
X-Google-Smtp-Source: AMrXdXuxO6chnnW1CFpDhppoRP6ZUm2gWywbV0j5uxW+15wOrdCQBKTWt5D37SBkmP4uw+TlFmRDOQ==
X-Received: by 2002:ac2:4d13:0:b0:4b6:e22f:51a6 with SMTP id r19-20020ac24d13000000b004b6e22f51a6mr6277130lfi.53.1672148016909;
        Tue, 27 Dec 2022 05:33:36 -0800 (PST)
Received: from localhost.localdomain ([95.161.223.113])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b57a810e09sm2268091lfs.288.2022.12.27.05.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 05:33:35 -0800 (PST)
From:   Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To:     linux-wireless@vger.kernel.org
Cc:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH] wifi: orinoco: check return value of hermes_write_wordrec()
Date:   Tue, 27 Dec 2022 16:33:06 +0300
Message-Id: <20221227133306.201356-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is currently no return check for writing an authentication
type (HERMES_AUTH_SHARED_KEY or HERMES_AUTH_OPEN). It looks like
it was accidentally skipped.

This patch adds a return check similar to the other checks in
__orinoco_hw_setup_enc() for hermes_write_wordrec().

Detected using the static analysis tool - Svace.
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/net/wireless/intersil/orinoco/hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intersil/orinoco/hw.c b/drivers/net/wireless/intersil/orinoco/hw.c
index 0aea35c9c11c..4fcca08e50de 100644
--- a/drivers/net/wireless/intersil/orinoco/hw.c
+++ b/drivers/net/wireless/intersil/orinoco/hw.c
@@ -931,6 +931,8 @@ int __orinoco_hw_setup_enc(struct orinoco_private *priv)
 			err = hermes_write_wordrec(hw, USER_BAP,
 					HERMES_RID_CNFAUTHENTICATION_AGERE,
 					auth_flag);
+			if (err)
+				return err;
 		}
 		err = hermes_write_wordrec(hw, USER_BAP,
 					   HERMES_RID_CNFWEPENABLED_AGERE,
-- 
2.25.1

