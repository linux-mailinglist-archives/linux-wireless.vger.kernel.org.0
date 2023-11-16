Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78A7EE926
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 23:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjKPWSl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 17:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWSk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 17:18:40 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C49B2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 14:18:37 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso1270152b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700173117; x=1700777917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fut2D9PGkyHE9fjVYm7r2SdMYSbTSM2K3xqc3g+d5jg=;
        b=dxA8uGCQDvqm/0UJHMK9oTcoSJRFO14H1o/qLYEgcOyhQgeK+3sl42xZCDDYTYwjBE
         UeH1lwmJYxmzRqNBw15Lxl1T9AXsnF+RNBXKosBWsELnc5y5LYy19GOUSrdxBoCG5N6Z
         9gP4ESErNLKx/UDz+ijvl8nfF0oeBsAdkngNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173117; x=1700777917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fut2D9PGkyHE9fjVYm7r2SdMYSbTSM2K3xqc3g+d5jg=;
        b=NKyXrIoP7ExgPjySK9sM/3csXmjB/DC2k6acZNEAcOFnza4XuRcyVQSQQSu2hj3IGo
         wJYKEXmo/84SFPF1E/47zMsXyEEqbDaeQ7NdvtILerlwhsrUhF9EgHeZu15gTxdTHeeT
         aH5wc3Qy/fvhXtbrSasz5QMtBH70Hod8YY4bf2nSdhr7FYcF88WfjdzIHih9DVDzj6ua
         CNju+phR1pnbknbd6PUEQ2CsvWttcG1CIkLW/+PuLnSh5TVU7VTwhnPxVsw5SRCO+Dav
         psb5nkZDhw6KcBLaIiTcXseaX7dKsIDbROyd/QmK0nIfxLYRf9U7tm8hL/Mwqxm+ESvM
         ypng==
X-Gm-Message-State: AOJu0Yzu8peYucwkpXg/vU4VNBBCrPsy5OkYV3Dd4AaK9E4yIbKkTHr4
        Es8zOZ3mSzGAeO/bnxlE1PH3mzOZ0w9WGmgATbo=
X-Google-Smtp-Source: AGHT+IHXprWETqn+1dWJ7ms6P6MOiPHjoEzUACvXlqz9Dih2wgu+nMjGcURwpRWJ6DJJOTOBm4nEWA==
X-Received: by 2002:a05:6a00:1d92:b0:6c3:60c2:8415 with SMTP id z18-20020a056a001d9200b006c360c28415mr16372044pfw.30.1700173117194;
        Thu, 16 Nov 2023 14:18:37 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:a5db:bb75:e3b:29d])
        by smtp.gmail.com with UTF8SMTPSA id bn2-20020a056a00324200b006c4d4d5a197sm221428pfb.171.2023.11.16.14.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 14:18:36 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@kernel.org>, wireless-regdb@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] wireless-regdb: Makefile: Reproducible signatures
Date:   Thu, 16 Nov 2023 14:18:16 -0800
Message-ID: <20231116221828.301564-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Per openssl-mime(1):

       -noattr
	   Normally when a message is signed a set of attributes are
	   included which include the signing time and supported
	   symmetric algorithms. With this option they are not included.

The signing time hurts reproducibility, even if the same database, key,
and certificate are used.

So, drop the extra attributes from the smime command.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 02176ec7b717..ecd23309efb6 100644
--- a/Makefile
+++ b/Makefile
@@ -69,6 +69,7 @@ regulatory.db.p7s: regulatory.db $(REGDB_PRIVKEY) $(REGDB_PUBCERT)
 		-signer $(REGDB_PUBCERT) \
 		-inkey $(REGDB_PRIVKEY) \
 		-in $< -nosmimecap -binary \
+		-noattr \
 		-outform DER -out $@
 
 sha1sum.txt: db.txt
-- 
2.43.0.rc0.421.g78406f8d94-goog

