Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0465D2A28FD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgKBLY0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgKBLYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:24 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265E9C061A4A
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:24 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v5so9015353wmh.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qoHya8gK4WxyN5m7VBMHjfaE3l8Bb6XYk+L0IrwzimU=;
        b=vN7FgK7AgZxvJn6YeBi+P0ktCCfAvqWEQCoVJbdaEPsNdE13QY7S6BlEfbaS0fEltG
         f+r45txAK9RrlAbrSqby3atEOPYqHElzC+0c3YgCRrRmZOXCdFHHzyxCtOcclBAZwMqP
         PaObsX5RsPWYbe2Ak5ToZl2uAH1vIjFasEvv+2ka4Pby17tNAr8WbwZC0AC1Oy+wKLX0
         lwl2TZ/J/0JTNLJlsgcnOdryqmKt1uiqsxCddZdhmhzFJAXtlvYgynCmy/ekRkpl7Wdo
         aaGV538zdcV0sJUcP25b63XiLtpuomauPIXBNf+bDnnYTnPLEdKuleRdnDag9ChGih7/
         spKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoHya8gK4WxyN5m7VBMHjfaE3l8Bb6XYk+L0IrwzimU=;
        b=aKhC2rFT3u5318uD1N6fAnae7r1lG47fWjtYf/cpjFxHFphO7J3c7wTnz48N1Pamw2
         S3Zv1vH8nLI7m6OZWBjKZa2mpJ/25tTTB7nP+ATqaktGBc57/bhbN1LbGOKTYcKG7hS2
         g0uX7azqXWJzTQfv/SPoUW6L1yLqtbNb/Q3IPx4jLiTt+sxeVl9obJo6UOirasA5fQBD
         RtwdN58Ye/ScUofZ5oSO+5cPlY2hrsYea8pEnrJEmeXaNdn/9smMO1mDdcHVP3cLkmvU
         ejvguFrDm4zGCi0egHjVzqv2Dg9h10IaNL3uolCV88gEOtJmgP+8BaeotzPN5qPWeRc0
         d0Ig==
X-Gm-Message-State: AOAM5334evo4bDcx9rmHGS3B6zWS+eflDH2eyeYCc4j9EjcDmdZAKKh6
        TvRuNm1RUOxQhdjqRlRW0xAm6A==
X-Google-Smtp-Source: ABdhPJx6mTU49MwUqogLkMZY5uvxzgmA/bh5y1uIt3JqqILR6MRKRw+wUZnjf7tSRd0Tb2fAAkhcjA==
X-Received: by 2002:a1c:3503:: with SMTP id c3mr16872354wma.43.1604316262903;
        Mon, 02 Nov 2020 03:24:22 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 04/41] rsi_91x_usb_ops: Source file headers are not good candidates for kernel-doc
Date:   Mon,  2 Nov 2020 11:23:33 +0000
Message-Id: <20201102112410.1049272-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_usb_ops.c:22: warning: Incorrect use of kernel-doc format:  * rsi_usb_rx_thread() - This is a kernel thread to receive the packets from
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c:29: warning: Function parameter or member 'common' not described in 'rsi_usb_rx_thread'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb_ops.c b/drivers/net/wireless/rsi/rsi_91x_usb_ops.c
index b1687d22f73f5..4ffcdde1acb1e 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb_ops.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb_ops.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
-- 
2.25.1

