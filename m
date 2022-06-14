Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0D54B7C7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jun 2022 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiFNRd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jun 2022 13:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiFNRd5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jun 2022 13:33:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7481237C9
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jun 2022 10:33:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so12420386pjl.4
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jun 2022 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Fx7y7b5NG3L1DrwnfoPrqy653Ut41bmGlxWqY9ODEI0=;
        b=jjiX2M85C4oZsHl2iw7FA+cFr3O+d5SgLOVedx3nFZlnuimQspuG52J1OwJYMorzEC
         t4RziT41LNr+z4f8pI1XdHNHb6KwOquaBLh3QreB6q8mCc1IZanW7n6ljSsVBg0nKZMC
         cp9i3wkff/bIjmETrG3c0E3XP7iMGB5mGhe9JVoNoH/Gp1GzBVhSTjqCEnFqIuvRlcp2
         fsQknH032SJ4FgRMJ07/NfHP0TKSLzpayhGy8p3l4BcL+XeGF4QNjMFqgUi2MD2Lcwdk
         q4YGJKLK+Y4JcddWTSNjzF7VYasp+JUqqiwJ/TyLd4+eZRSx+Drw8Av2NuUw7S0tpdMo
         CFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Fx7y7b5NG3L1DrwnfoPrqy653Ut41bmGlxWqY9ODEI0=;
        b=xL+aXtq6BxtUDjG9TBxAaxwQlqA4JizjwZS+AfGqOpmM8gkZomR9wu8wIA0dPBtTRr
         AxhcX7HVI3mPNL47lNyc8aLauoaQ+pPs1b2uZgqlZZQeDvkEG/nTZm/YyqNm4q4ag63N
         khBb3GE1Ne8HMi6rV5PrvKxu02VlWbkOOOF+bQjjQU1Lxsd6jT18M59XwMuUYf+dHJsV
         4dFTKkWrZvTK6QpyWS1SuHi3dyY4FJEH+Uak/CeOO0tb+ePzyvb1ZqgDaTWwTj8JAIJG
         3k+M0w+Xo0ZzlWy6zGMARztmQdj4mMLwBy4PAF3492pE4tvNMU4C7AjT789ClBT4xUMV
         EojQ==
X-Gm-Message-State: AJIora/96cVbsLR0mrSlQPg7nL3NmjH/9EVN1FVs/i1PGAVlvVQlduBD
        yOp3lwfaosNmm3YNivCm+YZoln5SOAKukw==
X-Google-Smtp-Source: AGRyM1tkjbUAPUK8zTu8hTfFKRpYF2IsR5ekTx9DtS+Ew8+251fcdK6L9yHBG2vhVAPyRKpbwUyhVw==
X-Received: by 2002:a17:90b:240e:b0:1e0:775b:f8fc with SMTP id nr14-20020a17090b240e00b001e0775bf8fcmr5712731pjb.132.1655228036244;
        Tue, 14 Jun 2022 10:33:56 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id ja21-20020a170902efd500b0016632179ecfsm7468049plb.264.2022.06.14.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:33:55 -0700 (PDT)
Date:   Tue, 14 Jun 2022 10:33:52 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     gregory.greenman@intel.com, linux-wireless@vger.kernel.org
Subject: [PATCH] iwlwifi: pcie: Fixed integer overflow in
 iwl_write_to_user_buf
Message-ID: <20220614173352.GA588327@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

An integer overflow occurs in the iwl_write_to_user_buf() function,
   which is called by the iwl_dbgfs_monitor_data_read() function.

static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
				  void *buf, ssize_t *size,
				  ssize_t *bytes_copied)
{
	int buf_size_left = count - *bytes_copied;

	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
	if (*size > buf_size_left)
		*size = buf_size_left;

If the user passes a SIZE_MAX value to the "ssize_t count" parameter,
   the ssize_t count parameter is assigned to "int buf_size_left".
Then compare "*size" with "buf_size_left" . Here, "buf_size_left" is a
negative number, so "*size" is assigned "buf_size_left" and goes into
the third argument of the copy_to_user function, causing a heap overflow.

This is not a security vulnerability because iwl_dbgfs_monitor_data_read()
is a debugfs operation with 0400 privileges.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index bd50f52a1aad..fded5d305b11 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2854,7 +2854,7 @@ static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
 				  void *buf, ssize_t *size,
 				  ssize_t *bytes_copied)
 {
-	int buf_size_left = count - *bytes_copied;
+	ssize_t buf_size_left = count - *bytes_copied;
 
 	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
 	if (*size > buf_size_left)
-- 
2.25.1

