Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2661924975A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHSH3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgHSHY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8A1C06135E
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so1088635wme.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpJGFhZ7lq89b4fQU2CLX0YYZznNJZa5+dtW6ao3V6o=;
        b=Iqk00HmxZ8Mpvy4BTJaRHdTxttDSNzpXR+o0P4CYh1ddH0KA4qMBY/RzGUF29Y6aA7
         A1EngZDMXBwYH/uO49VL1P7tk4cjoPr2LJivX3cfMJEE9cb37TfS+Clr2503UX1aQl+F
         BztKMijeXNXYbqsn8QgxrPTs9iF3rNfk7rK8Up7GBPQgp7O4cUj6HDjAvyM44llimqfc
         UL+uVUUxVUCdDdW6Xitpfm1LMVpoxaJHjUpeDmeCUOw1fJSn4zQ7gC7fuOyvjH7TpVrB
         9tjLpn968CSNyPMTI7u576U5AEwLYp3En9kZJYz/djWvK9xYiXX6HNZK4vDruJ//nO7X
         ZzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpJGFhZ7lq89b4fQU2CLX0YYZznNJZa5+dtW6ao3V6o=;
        b=RoE93EFiA3nlDUiPFvhpAXZUl0cld+ygYmZTFVZRR2cFisoFUGrJx8YTMFr87yJP1d
         +eSOwVpzcxGJlfHF6wlo3E4Wl0I2CLCAqVcvCyYgF78ukHIWRrSoQOiI3i7LPp6I2JeP
         Tod0wwLL7alX3bcUUCL4DGteTtw1DPTret0s6/Q0arHJKrVrjwrJ71coIX8fH0B92CgV
         Z3EFetnNlolZu0RElV1dL3BDepAiwMxsJGyHgvs80Out14tKOAoR6+ghXgTEQGcFD8xB
         QmOfg3VLOmXC5zD48qQSdV7HE9b2dETBx8j6am8SEc3qlZutmGzb95lUTXNE6hscZcCg
         9TpA==
X-Gm-Message-State: AOAM532u0zzpO2PLwsHxRZiBbBvCtA8WoSMLRiO60ltae2inCqgCs4om
        +L5uQCump9+Es8jXAOr2drIr4g==
X-Google-Smtp-Source: ABdhPJynxqpv1c3Pu0O7jBCGNAOoBJesUsfT7ytpD9b/jegM7Im9l2oUkdCWae9Niy8MnRKN6umV6A==
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr3410582wmf.31.1597821856532;
        Wed, 19 Aug 2020 00:24:16 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Linux Wireless <ilw@linux.intel.com>
Subject: [PATCH 09/28] wireless: intel: iwlegacy: debug: Demote seemingly unintentional kerneldoc header
Date:   Wed, 19 Aug 2020 08:23:43 +0100
Message-Id: <20200819072402.3085022-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is the only use of kerneldoc in the sourcefile and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlegacy/debug.c:1373: warning: Function parameter or member 'il' not described in 'il_dbgfs_unregister'

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Wireless <ilw@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlegacy/debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/debug.c b/drivers/net/wireless/intel/iwlegacy/debug.c
index 4f741b305d964..d998a3f1b0566 100644
--- a/drivers/net/wireless/intel/iwlegacy/debug.c
+++ b/drivers/net/wireless/intel/iwlegacy/debug.c
@@ -1364,9 +1364,8 @@ il_dbgfs_register(struct il_priv *il, const char *name)
 }
 EXPORT_SYMBOL(il_dbgfs_register);
 
-/**
+/*
  * Remove the debugfs files and directories
- *
  */
 void
 il_dbgfs_unregister(struct il_priv *il)
-- 
2.25.1

