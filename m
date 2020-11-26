Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1D2C55A4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390290AbgKZNcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390243AbgKZNcL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:11 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124FC0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:09 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so2184024wrt.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkVHgZnw6Lei6IsVvRK9pUiVE1+hhckfR+9Br4cSPrE=;
        b=zuKRkBMwy4QWvvpBfeIKLgYNHdWx20GaFtYVQXPS2ejG2VPOKyj03aNPOtjX+Fj0zi
         txJPDSzeDZUh8AxFzvuhREUkFOifNLME+G4mGIh1qsRZlj5ZKR4ZZ5TKLfU33wAjw49O
         WHNRmyDRN5QZytnQ0PNHwhnOaSyWjF+hyxH4DGD7epSjYqZRKDYoriPREbd1hMOTSQXz
         X39+Qobaoshhe8lrepXEoh9tQzPEaKyKazBTzHf8K6VTgHfQDPuKuB6Pt8ZRe8KKms2d
         tOq/lR/1+QXwebzXTbyIR41NGMNjl1b0m/NmtJh7lY4y8UPHc4VZST5te0Z0b/N2Qk3b
         ir4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkVHgZnw6Lei6IsVvRK9pUiVE1+hhckfR+9Br4cSPrE=;
        b=grEyaXrBmyrpeC/JHtW9tB/25wrMqxoX6/su8QLTXWFbdc/7yyTfxVT6w/mqpAhPKc
         PzfyPr0njLXE1AjNl0+1Gl31CqMz42bnKe4dSjzj7pcJoQLIFXVUxQgX6ilOIxoWl4VS
         FgirynA2GJcVmqqsFU9VhKQOiMpFkdLsgq/ZFurUQlQMRO9hV1tyxqQouMU/ZavEl9Yx
         5e1IozkO8cyXqzWCy4U1g7Ro/TLBDclB42VvHQz/M7t6NPzxbii66ZrFg5Ro1IKLtThP
         WmWovamWmatb8qSSgMmtkaeiDhqRaFdYkZApNDXeB8trLQi1FzEvhBCGLrbSWAHHkjsX
         BWgw==
X-Gm-Message-State: AOAM531eowb4QjptUG1AHFkFhdOYSNzLHPnMwL/j/SBId+GjGCGOy59v
        menE+fFpL4/d9ylb6Oo7PjtZ6w==
X-Google-Smtp-Source: ABdhPJyn9GVZS822IZ4IVqcmFXjk4DgG4O/j+RPa4fPxVi5KBq5hEWqL5eq0BDDYukOyzKbs/qm8dQ==
X-Received: by 2002:adf:e801:: with SMTP id o1mr3900099wrm.3.1606397527585;
        Thu, 26 Nov 2020 05:32:07 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 09/17] ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg' param
Date:   Thu, 26 Nov 2020 13:31:44 +0000
Message-Id: <20201126133152.3211309-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/regd.c:378: warning: Function parameter or member 'reg' not described in 'ath_reg_apply_ir_flags'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/regd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/regd.c
index bee9110b91f38..b2400e2417a55 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -360,6 +360,7 @@ ath_reg_apply_beaconing_flags(struct wiphy *wiphy,
 /**
  * ath_reg_apply_ir_flags()
  * @wiphy: the wiphy to use
+ * @reg: regulatory structure - used for country selection
  * @initiator: the regulatory hint initiator
  *
  * If no country IE has been received always enable passive scan
-- 
2.25.1

