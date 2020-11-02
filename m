Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB292A295A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgKBLYj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgKBLYg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:36 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D7C061A4F
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:36 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so1044401wmg.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TWZsEGtPpD8oYutyQ+ByJgl7e2tHiSuw7AnOdGhaOYA=;
        b=hFXbZ1f+fWwg8BDaATDVbFNgYfjTpm2jUunOGVTBBDhXImU7Zwj8JQnvdOC2AUg9ZS
         YmqUwf0ic58JzBEJ/LFibaPpsMy4yfNMxHbWruFczeqOHf57MVJaZOU7V/l0AKdSXqzk
         niABLQHDofBK96LSXmBQPJhsJvEtLnPtGPZmtmo3xRMnUZE/A5EcpNeMdI9XO3Y4xrgj
         jpiWQUO96pIezVsQZ8g2DfBIvw/ow++tyske4avK9i8UUxDnbL85bzJh16ElPjUJbe7W
         X8UcJRBMNNaxzVO+pCaAC8t02qoPC4EWRGQywewqdNlbO5InWl25p/PxEXYyXH1UJy1L
         sXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWZsEGtPpD8oYutyQ+ByJgl7e2tHiSuw7AnOdGhaOYA=;
        b=UdyP+e0qOpe8bvc31MEmpxhzSgg2dEgdGuBkdFeJ+9TZdUwE+KV714VLeYKy7MajVb
         hI2ICvhcQw6/+4PMJfp5Ml/fjveImy7obLHIcboKSay5vafdiYmLgjLFZb+wYnt3zSQQ
         dD4gZqeIQgPTeNN364qcwR5mPHNGiHGCI9uVOqxM0cVF900yBsIAQSEsLSco854I4NRi
         vNVUGFyzgbISWLW6b6CzA6pYCLa2uN85/J0kZlshfpdxkiNMf7d9D5apKIgCkq+f1hdj
         Dg2aRt0n4X4OnzsesHaO3ZKZ5kxQldUpzI0ldj41FsWYQnFxjV4rUc94P6q63AHKTU2T
         Ov2Q==
X-Gm-Message-State: AOAM531fQEfRu6ArO69XOJBmeisRRcETfNaW+lchXZAb3UnvbamNl1V3
        Kf6b267jK4j38hrSlvjtfcM/IQ==
X-Google-Smtp-Source: ABdhPJxnMBOyspeV/rBPZ2r4TYoe+sbZEYC71PJjAKrIj7pjBYiPN/3y1BdtLLn8vX/7pFSEGIz2zA==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr16054124wme.53.1604316275243;
        Mon, 02 Nov 2020 03:24:35 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aurelien Alleaume <slts@free.fr>, Valerio Riedel <hvr@gnu.org>,
        "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 14/41] prism54: isl_ioctl: Fix one function header and demote another
Date:   Mon,  2 Nov 2020 11:23:43 +0000
Message-Id: <20201102112410.1049272-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/net/wireless/intersil/prism54/isl_ioctl.c:22:
 inlined from ‘prism54_get_name’ at drivers/net/wireless/intersil/prism54/isl_ioctl.c:283:2:
 drivers/net/wireless/intersil/prism54/isl_ioctl.c:68: warning: Function parameter or member 'priv' not described in 'prism54_mib_mode_helper'
 drivers/net/wireless/intersil/prism54/isl_ioctl.c:68: warning: Excess function parameter 'mib' description in 'prism54_mib_mode_helper'
 drivers/net/wireless/intersil/prism54/isl_ioctl.c:127: warning: Function parameter or member 'priv' not described in 'prism54_mib_init'

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Aurelien Alleaume <slts@free.fr>
Cc: Valerio Riedel <hvr@gnu.org>
Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intersil/prism54/isl_ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intersil/prism54/isl_ioctl.c b/drivers/net/wireless/intersil/prism54/isl_ioctl.c
index 2076f449b6e25..5e5ceafe098b9 100644
--- a/drivers/net/wireless/intersil/prism54/isl_ioctl.c
+++ b/drivers/net/wireless/intersil/prism54/isl_ioctl.c
@@ -54,7 +54,7 @@ static const unsigned char scan_rate_list[] = { 2, 4, 11, 22,
 
 /**
  * prism54_mib_mode_helper - MIB change mode helper function
- * @mib: the &struct islpci_mib object to modify
+ * @priv: the &struct islpci_private object to modify
  * @iw_mode: new mode (%IW_MODE_*)
  *
  *  This is a helper function, hence it does not lock. Make sure
@@ -114,14 +114,13 @@ prism54_mib_mode_helper(islpci_private *priv, u32 iw_mode)
 	return 0;
 }
 
-/**
+/*
  * prism54_mib_init - fill MIB cache with defaults
  *
  *  this function initializes the struct given as @mib with defaults,
  *  of which many are retrieved from the global module parameter
  *  variables.
  */
-
 void
 prism54_mib_init(islpci_private *priv)
 {
-- 
2.25.1

