Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86B72A292D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgKBL0H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgKBLZH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:07 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD6EC061A48
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:25:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n15so14182322wrq.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CShQQ12PBsg4lhgdWNuYQU+7cmtXNk/NI77thbS/j9M=;
        b=JlhFoJuMAj9F/e61O3Mhvl/I2ScHj1PNuWyCQK3xSUVNOZxJDsPtA72x9vNeMaNvtV
         xatTQqTIiNB/CR9h9jS2FMe9ZJflyKbuXb4laQiuFtVx60jyT/Bs30RKUahJeIJyNVFt
         XrRhLSSEPFI6KVksCWt7K+vt7J5jZTHjffUJoYyYxU0DSfrjgBXpggFwOzwudIq4yK2i
         +YfH1kV+6gil38pjYtWr4ibLTbFNPVbhAB9B+Gk2dSp0JtueRe1sxE6C2hmrO13Y9OPO
         ujFzdc0YIP3oJo8Ck3HNP/e6tktwNT8Bn4ZEnRmCghtwB5coRT9Xu8uH15bAEWhHW82s
         qplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CShQQ12PBsg4lhgdWNuYQU+7cmtXNk/NI77thbS/j9M=;
        b=W7ZxeHwD0Jm6D25M8L/TCE7KfMJtY+xv1fxvMFwMsceI24wWNWPDRTanC3AYm5qflG
         qPdv9nxt3Gh/5zhP4J5OU8/cVHnsSd51/cVCyXvKtB5FHlMUy5QRcgBaSZjJOwrBVP32
         DqSXBk9mMADwP3t+WAaUEM7YTs9DKiWeXo6FksGpkuHm+wC84nfGRzDf+BJPEl94RcGJ
         Hb5SdSFRc6CRfifu5pD8ckJ7ZgPIl3Y/UzNCxwFKhrXulTTaa1H8haeOO5APe2u2kz9Q
         b/5s6jWyBLPJNtqlagqChbYFfWnPX7sUK7rQ4NNwoDjbWFyXxIg3WNaKR+DESLf9CPLv
         UyCQ==
X-Gm-Message-State: AOAM530O1CQkhjJwlLrGY1YjhJX4atHWaU2FQLRnT/dA8h69OXyz986T
        Xg2CIY4AMA1OY4M95BSCmx9LYw==
X-Google-Smtp-Source: ABdhPJxBYj5usmi4qGlUfaqjEb9+wgXLgztUDnuNady/I5Qdqzo4kKXtcfwR2Bj62eeSOzRpXaj8bw==
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr20763543wrt.175.1604316304609;
        Mon, 02 Nov 2020 03:25:04 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:25:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Luciano Coelho <luciano.coelho@nokia.com>,
        Juuso Oikarinen <juuso.oikarinen@nokia.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 35/41] wlcore: spi: Demote a non-compliant function header, fix another
Date:   Mon,  2 Nov 2020 11:24:04 +0000
Message-Id: <20201102112410.1049272-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ti/wlcore/spi.c:403: warning: Function parameter or member 'child' not described in 'wl12xx_spi_set_block_size'
 drivers/net/wireless/ti/wlcore/spi.c:403: warning: Function parameter or member 'blksz' not described in 'wl12xx_spi_set_block_size'
 drivers/net/wireless/ti/wlcore/spi.c:440: warning: Excess function parameter 'res' description in 'wlcore_probe_of'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Luciano Coelho <luciano.coelho@nokia.com>
Cc: Juuso Oikarinen <juuso.oikarinen@nokia.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ti/wlcore/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index 18c4d998ce4b9..f26fc150ecd01 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -391,7 +391,7 @@ static int wl12xx_spi_set_power(struct device *child, bool enable)
 	return ret;
 }
 
-/**
+/*
  * wl12xx_spi_set_block_size
  *
  * This function is not needed for spi mode, but need to be present.
@@ -431,7 +431,6 @@ MODULE_DEVICE_TABLE(of, wlcore_spi_of_match_table);
 /**
  * wlcore_probe_of - DT node parsing.
  * @spi: SPI slave device parameters.
- * @res: resource parameters.
  * @glue: wl12xx SPI bus to slave device glue parameters.
  * @pdev_data: wlcore device parameters
  */
-- 
2.25.1

