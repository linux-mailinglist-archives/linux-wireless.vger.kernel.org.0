Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6D2A2982
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgKBL33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgKBLYW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:22 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF8C0617A6
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:21 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k18so9121761wmj.5
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTiCTwpSeuoC0ZILvau+EWPZDB/8AsBPEAL01U6W1b4=;
        b=mSKuh/oQx2l+5azZ5IH6cLue5yw1lvhVyOtk9XfOR4NLK4Cfn48DDs1VUWdigzZ/oh
         bAkemouy5StWNyflyuH/BRhSA/GHZdyI+I1doII0o+zIRL9pWY08ELzHvboJgjZLRnkt
         sJ1l59vpWGkXCBhLwGE1bqRW1JyUuK+2ccOxyoqoJ57d/14nFshRVVj69RksJ9ctBxyx
         kYTZirub27Ts8fWmFyBhFfe1O12tzRa4jf2FCcb8NJGuNnX0p+LNggbE8PB4OOQquZta
         8gF7AxVGtZY0+RqNapn/npw28v3PtjhDc1ljWTdVlNBLFJUcZce6XwlMDIl4viLfj7r+
         M9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTiCTwpSeuoC0ZILvau+EWPZDB/8AsBPEAL01U6W1b4=;
        b=H1hK/S9J+DPTalHv3RaJuSQoBpf0UIaRmTSx7ScDQwyGDNwhB5AvEBRtkyiYJLCEAk
         /kpGtB1w0e38AwOd675grP39f89YY9tOLljV+9S0BsBNXonaRmTrSTs7FDdWSKoSrxy3
         E0U8lo9caLItvds70Urh/75UoQROG0DQaJ16XzMa6M7FqKNSCdTUuWYTRtJjvb+3WY3q
         N3hGrOLp5tQCZM3sGo9WwsDgGgxg0t6wGDWqpHVqo3SLuvZji8nR6fM259dY/OSTBXJA
         qtMXcT8vJot+CmldhBpDjulkaFpLpFtZWq5BjE5y/ddOHxwpblizHpH+MyZNKZn11x/h
         JStQ==
X-Gm-Message-State: AOAM5302VcTxvyEPoZSAveOcXUBAKuAzPq1MSG6KGkm5mv/PZJJLQTYm
        JcZgbKhz/R7RsIAM4SrAuJ/jZQ==
X-Google-Smtp-Source: ABdhPJysV3sSLjorLpfTTVKOdxO80zr1Or3MAdqQyIDLtjVRp2ORjSI2bSJGUUuC/vYvuQGnFzLCNw==
X-Received: by 2002:a05:600c:2252:: with SMTP id a18mr15786081wmm.139.1604316260550;
        Mon, 02 Nov 2020 03:24:20 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 02/41] rsi_91x_usb: Fix some basic kernel-doc issues
Date:   Mon,  2 Nov 2020 11:23:31 +0000
Message-Id: <20201102112410.1049272-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_usb.c:26: warning: cannot understand function prototype: 'u16 dev_oper_mode = DEV_OPMODE_STA_BT_DUAL; '
 drivers/net/wireless/rsi/rsi_91x_usb.c:88: warning: Function parameter or member 'endpoint' not described in 'rsi_write_multiple'
 drivers/net/wireless/rsi/rsi_91x_usb.c:88: warning: Excess function parameter 'addr' description in 'rsi_write_multiple'
 drivers/net/wireless/rsi/rsi_91x_usb.c:320: warning: Function parameter or member 'ep_num' not described in 'rsi_rx_urb_submit'
 drivers/net/wireless/rsi/rsi_91x_usb.c:320: warning: Function parameter or member 'mem_flags' not described in 'rsi_rx_urb_submit'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_usb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index a62d41c0ccbc0..8928e14671512 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
@@ -75,7 +75,7 @@ static int rsi_usb_card_write(struct rsi_hw *adapter,
  * rsi_write_multiple() - This function writes multiple bytes of information
  *			  to the USB card.
  * @adapter: Pointer to the adapter structure.
- * @addr: Address of the register.
+ * @endpoint: Type of endpoint.
  * @data: Pointer to the data that has to be written.
  * @count: Number of multiple bytes to be written.
  *
@@ -313,6 +313,8 @@ static void rsi_rx_urb_kill(struct rsi_hw *adapter, u8 ep_num)
 /**
  * rsi_rx_urb_submit() - This function submits the given URB to the USB stack.
  * @adapter: Pointer to the adapter structure.
+ * @ep_num: Endpoint number.
+ * @mem_flags: The type of memory to allocate.
  *
  * Return: 0 on success, a negative error code on failure.
  */
-- 
2.25.1

