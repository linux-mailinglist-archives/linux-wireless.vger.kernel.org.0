Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB224972D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgHSH0c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgHSHZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:25:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B78C06136E
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so20427518wrs.11
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rLwtBvMkow5I5GDEjyJuOU5JzSfmTUQSvGDHlfWV2k=;
        b=p2YS8erqOU/gjRtz4iVLLaMMKfXmVFvrRVi+3sc8ekfq/H7rh07Ky8kWW8qm0xOl7H
         gICMIUqThUQIq3Aj/P84e9220rP4seaClfp6TMWzMKTx9I2Ety6ePlpWYYv/utFTZsu1
         f2/fvNKQsuhAz2wlvL7xLEdinCCwVSsBIgKuCbEhIC7LAQAIFGEZi70S8Rdrn96JDPUK
         f9hnU3tzZ923q8b5VmYM+HniJ0SpwLYOmE+L+Fbo/pgx6qnGENDwbVdr+zRlE/ilG9bN
         SuntGeq2+BPuuCZAszBdrXBYL7/mzh8XwphBNHQCuRc9i0ANcXv3Xhp1njCVJTMkztza
         Mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rLwtBvMkow5I5GDEjyJuOU5JzSfmTUQSvGDHlfWV2k=;
        b=p7B3gKr2vxtyoxPRLpRfHo9MQALVSt3a3yQP8G8KcIhxhzEZbuMoT7qkKpoY6FP70+
         jySwrB5PiM40weTL4uGfkGXlPFthPF54lvN3YuQxTsLhKKCNNpPlYv8Sgjvx4XYJjqbk
         rbYusJdhk5pox8x7VtcXH1pH0hFyb7HwhrPA5sEq0OKGCohMojXzf0SB/PDdXV2V9gL3
         0mYwQtMMjHyy7rTQOuvwkiXuF/Hj6M3+0s+xV2EjodEyPE4ZO7et3WmGj9xADiaEPG6K
         3nUC6d+xZI8SGF0Xg0kPgbgA2uJ1ReUtkAjmmtPn0nEKjMjtv2qxyNFFbPRnSAs4NWka
         ABKw==
X-Gm-Message-State: AOAM532ysQG8eH2tBnDewVOnO+SlLgBZ814d81le4lc6KzWl9LRW0dbz
        ijYn5g/6Bnr7JPwlrCRvmHAxEwS465s5fQ==
X-Google-Smtp-Source: ABdhPJzXBn1IXHXSUSbWLBLOHC10XUr5FZWPQa6flhRI76F8vknBKoswuQD38N8iOhXv4eE0P0x7Og==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr22292936wrh.381.1597821865954;
        Wed, 19 Aug 2020 00:24:25 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 17/28] wireless: rsi: rsi_91x_main: Fix misnamed function parameter 'rx_pkt'
Date:   Wed, 19 Aug 2020 08:23:51 +0100
Message-Id: <20200819072402.3085022-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_main.c:157: warning: Function parameter or member 'rx_pkt' not described in 'rsi_read_pkt'
 drivers/net/wireless/rsi/rsi_91x_main.c:157: warning: Excess function parameter 'rcv_pkt' description in 'rsi_read_pkt'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 576f51f9b4a7e..9a3d2439a8e7a 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -148,7 +148,7 @@ static struct sk_buff *rsi_prepare_skb(struct rsi_common *common,
 /**
  * rsi_read_pkt() - This function reads frames from the card.
  * @common: Pointer to the driver private structure.
- * @rcv_pkt: Received pkt.
+ * @rx_pkt: Received pkt.
  * @rcv_pkt_len: Received pkt length. In case of USB it is 0.
  *
  * Return: 0 on success, -1 on failure.
-- 
2.25.1

