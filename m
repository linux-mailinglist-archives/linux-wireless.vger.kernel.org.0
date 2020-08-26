Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308EE252A66
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgHZJiv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgHZJeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A5BC061387
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o21so1080699wmc.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCFXUOCpjL2qkM32iJ3lfLLlxWZFDQ/GxhURnAb0nIs=;
        b=uuXN5vpHqutLOzjRFB1LQN4QqACjrZnO3CfhEXTW4uUwpqGnIGyj69aDbqsJqUciec
         sfBjBMD+i20bDh3IFK71nJiZWqu4acSyVq8B9uXpNvZ7s2QuDRUP99eZTilx0r+zMmWm
         AlIo18wNqtkf2Jv2x7dddDChnzjCAZEJCcBRkPXiPQVCrezWhJKm72iYKgmXpYouki8g
         NXFoO964YcHGCkUToo1McIx9Yx8mNGuY3iCaFKBNgWonQQ2SHN/RC1Q4cBKEeyEAC4Fe
         fWn198sSJ2tWARhH24lAubxO3h8RT+rlVh4DCiu9xV2IqguSd1hmH+1IX7CnAJO+JsL7
         nA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCFXUOCpjL2qkM32iJ3lfLLlxWZFDQ/GxhURnAb0nIs=;
        b=USuAUapJeFu/OTBZu5a76wshmvaXGYWTdKwnFfdtk9bljZu4Uwpzap3YMyaW2IZ8GE
         eidEfDjhJT7u628FtslJ2xECNall3t7PKoJN9qVksxIajL5zIzArlVT6CMYEbheU+cfi
         JKYyvg9FGs2rmKXewqNeQF9Y/e6+bwhmYDNhTWKnUMXPmMsqMQx6VeSCFS5MG1DHL+SQ
         ye63zbyZfzerQiWRvr2RmG8EnT++SbFmNXP/a0LOw0+XUaz285ctFsSC8/mCWj0LfoK1
         KXs+g/35mYdqDfYn5Gk1hvhoc8FoYp7MTgqU+vRJlAGRudZkq+yy37tVW4l8mjoDF7N3
         dnfw==
X-Gm-Message-State: AOAM531EWQvNKgxFJTPHd5Fs7Q2VE2BDQ/GBJ1iEW6ZFnP1J0fYSIEoK
        8cJjYvW9WZBwXzs/lzqpP8qpvQ==
X-Google-Smtp-Source: ABdhPJwxuBu8C5NrALO5Op1yXkaQ7ro+gQ2XCRXU+YQcylBxExwx09MilCl67PeIt1bDwVNSeugVAQ==
X-Received: by 2002:a1c:b082:: with SMTP id z124mr2255183wme.108.1598434458762;
        Wed, 26 Aug 2020 02:34:18 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>
Subject: [PATCH 11/30] wireless: zydas: zd1211rw: zd_chip: Correct misspelled function argument
Date:   Wed, 26 Aug 2020 10:33:42 +0100
Message-Id: <20200826093401.1458456-12-lee.jones@linaro.org>
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

 drivers/net/wireless/zydas/zd1211rw/zd_chip.c:1385: warning: Function parameter or member 'status' not described in 'zd_rx_rate'
 drivers/net/wireless/zydas/zd1211rw/zd_chip.c:1385: warning: Excess function parameter 'rx_status' description in 'zd_rx_rate'

Cc: Daniel Drake <dsd@gentoo.org>
Cc: Ulrich Kunitz <kune@deine-taler.de>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/zydas/zd1211rw/zd_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_chip.c b/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
index 0216b1583b48b..3bb51dc8d035f 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
@@ -1376,7 +1376,7 @@ static inline u8 zd_rate_from_ofdm_plcp_header(const void *rx_frame)
 /**
  * zd_rx_rate - report zd-rate
  * @rx_frame: received frame
- * @rx_status: rx_status as given by the device
+ * @status: rx_status as given by the device
  *
  * This function converts the rate as encoded in the received packet to the
  * zd-rate, we are using on other places in the driver.
-- 
2.25.1

