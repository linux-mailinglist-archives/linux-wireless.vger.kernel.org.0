Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032C2252A70
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgHZJjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgHZJe0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F0AC061574
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so482433wmb.4
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NPqtCpN+MJMO4A/dgMyA434mUf+bmEkPLCWrQ+c5YA=;
        b=wEtprO+kfdTRh0oBj+5B8Yy4ISBKhQwNoTK2RGOv3zTrbnF9ElfliFrU1265sy2Dlk
         X/Ql8tuDk3rwEZ/h46rhTJo/9PJUV7zVajAOJBku2X0uO34M80zXe45EDRxYuRqQleDC
         NAP9JiR0oSCosMNy+oDBMCmD/yLLjTIp8xiMSXLlVqiYG1K+qxxyGamKNF7mIOUuyrb5
         2VSYZ/iMRe2lF+4MMY6QZMN5DYTs+DH4vh/WXqjhBMVd/g37WzOUKzu3gn6NxpqqmLqK
         OxsVrOTqkJx4HfE7sGwpLwgjM/oHqbOrnto26nf/M69S3VNyhRFIPip5KiAAkOn5l5Qw
         D+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7NPqtCpN+MJMO4A/dgMyA434mUf+bmEkPLCWrQ+c5YA=;
        b=GPLs86EyJMSinfYtFXiFqOBYINpZ3UMLiuczQhBJL5pe/zLqqmIefcNL1qzWhlboYA
         HzhBKLz92wCjqYeWD5GyOK9HS++A6DsBQRsI4q6XYCqLnXkekjCpMzRmpmRu/ZrEuFmC
         qpC27bV+leW7D7/qye4NEuCawv1h96PgH8oRAiKbpS3IXJKbRWkyTKl+PleqyKUrU+hL
         4veW82RI4Iw7AUbWIYDYfpLtAP+WmWODcIsjb5DCVPfuVYTp2zgACvsBVOvbk79hSH+Q
         KtoK5lvpRBMCk70RS0w7P8jGpKDdatPq3JS7o5G8cfb4LRDmXPrWfpsKWCmM7e5uN9ZM
         kTAQ==
X-Gm-Message-State: AOAM530RhWK/sAPCxqkGjw4+65MS/gXg4FdSUbswXmGKydgOvFWRPPYf
        K7Jh1N5edMAWQUkwEnLMwz+66A==
X-Google-Smtp-Source: ABdhPJzqT0DyC5PnoSK/CEUmtrG0VP7Wqe/C2ORblcv2v2YKXnDCylYJ3YnwxTiMZT0M3+HT1whIRA==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr6449203wmf.26.1598434453548;
        Wed, 26 Aug 2020 02:34:13 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH 07/30] wireless: intersil: orinoco_usb: Downgrade non-conforming kernel-doc headers
Date:   Wed, 26 Aug 2020 10:33:38 +0100
Message-Id: <20200826093401.1458456-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:434: warning: Function parameter or member 'upriv' not described in 'ezusb_req_queue_run'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'req' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'length' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'rid' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'data' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'frame_type' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'reply_count' not described in 'ezusb_fill_req'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
index 11fa38fedd870..645856bc1796c 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -423,13 +423,13 @@ static void ezusb_ctx_complete(struct request_context *ctx)
 	}
 }
 
-/**
+/*
  * ezusb_req_queue_run:
  * Description:
  *	Note: Only one active CTX at any one time, because there's no
  *	other (reliable) way to match the response URB to the correct
  *	CTX.
- **/
+ */
 static void ezusb_req_queue_run(struct ezusb_priv *upriv)
 {
 	unsigned long flags;
@@ -704,7 +704,7 @@ static inline u16 build_crc(struct ezusb_packet *data)
 	return crc;
 }
 
-/**
+/*
  * ezusb_fill_req:
  *
  * if data == NULL and length > 0 the data is assumed to be already in
-- 
2.25.1

