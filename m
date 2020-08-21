Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24324CF06
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHUHVE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgHUHRx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A672CC061373
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so838330wmi.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgDSDnxxHb6CdqHZIC7aOD/OJDoBNFxg2BiYm5Hsnpg=;
        b=l9JQJ99XPxez9JkWo8VlsrRhio4n0f/wMBJAklFsu628Vdg5jdoNSru2u2q1kLiaeX
         8KkRo5pIt1TqI3nhZKIO7fNMxE+9VDt8rzvOtPtnC3141HqYT9+wBhiTajHUKHZsQ8mo
         u/47v0m6PrYBZuFkFGIvhgYQzFV54pCm8UrfyY/3DriX+O4Lt9Ucfv9wmfLPRcPJEMzc
         MTSoGdHtuGGLu5h2xZIYSXbdzIAmcycP1MTRs4Ycyvw89YQ/Q46u9iipuHuazhfw5mMc
         BfmJdShOoNvLpXFiBSlHn5tVzmC6fZgGBYYby7r+jMc3S5M5DESGwUpDXzik2BhKmhP7
         452A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgDSDnxxHb6CdqHZIC7aOD/OJDoBNFxg2BiYm5Hsnpg=;
        b=L7CHLIxjDypsXY3OVxWJv1IB/EcYzbrEMc0pacIIZpbUsfhaq5LrE/us9UhgpaD8Yj
         pg4Z1XQ9UKalbFLevQmLnXJVVAf8dLZbubzzpz5GWaG82CKEED0YB8Z6vz0dun+1ebF2
         ujT/f7aVRBNfgTnPD24/voxKaRmI6ZzfhK5Lz4i/NhYl1l6fixKo0jpbtRUWsABb7CkO
         SHaKRYn8UdMRPkB8W2seoTujDAfVwGT3ce3iz4mobUfutd0ggAHcebNWL2+4OF3V9ziy
         nM4nNlEMWkTkcl6rmWnBFiN6ufNdVVTdI9WWgvoa1D1xJ7xhZdfccf7YK++lCNLh/Cpo
         T9xw==
X-Gm-Message-State: AOAM532XyQKrKBCG8ZcroLFZ7vGAhzynBHXCEjGkoKjJDerz+fbKh3gV
        Z6NzWTy7pga+QvYDptK7wtz7AA==
X-Google-Smtp-Source: ABdhPJzY53nU1v00oz53nICouXe1zYc7XwJWkibuxPP8DTiu/QjLP8XA9ZB5k1kNya32BKTK4y0B2w==
X-Received: by 2002:a1c:e288:: with SMTP id z130mr1745214wmg.32.1597994233221;
        Fri, 21 Aug 2020 00:17:13 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 20/32] wireless: rsi: rsi_91x_debugfs: Source file headers are not suitable for kernel-doc
Date:   Fri, 21 Aug 2020 08:16:32 +0100
Message-Id: <20200821071644.109970-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_debugfs.c:21: warning: Incorrect use of kernel-doc format:  * rsi_sdio_stats_read() - This function returns the sdio status of the driver.
 drivers/net/wireless/rsi/rsi_91x_debugfs.c:28: warning: Function parameter or member 'seq' not described in 'rsi_sdio_stats_read'
 drivers/net/wireless/rsi/rsi_91x_debugfs.c:28: warning: Function parameter or member 'data' not described in 'rsi_sdio_stats_read'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_debugfs.c b/drivers/net/wireless/rsi/rsi_91x_debugfs.c
index c71b41e45423b..24a417ea2ae74 100644
--- a/drivers/net/wireless/rsi/rsi_91x_debugfs.c
+++ b/drivers/net/wireless/rsi/rsi_91x_debugfs.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
-- 
2.25.1

