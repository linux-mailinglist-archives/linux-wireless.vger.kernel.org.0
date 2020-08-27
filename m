Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE948253F5E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgH0Hii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0Hig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 03:38:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F0C06121A
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 00:38:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so3609537wmb.4
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 00:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FRCkyG4TkqvXDMwoou9SdiJxe3ktjDM6K9gTtTQ6FgQ=;
        b=glEvNq1xlRPKfqXkr+8KHjm3OUxLZAKdzG8ZdB+v+oZYQIVjXP3Th+fChzgm6Nz5vp
         zMaYuRm6yICqJjN7MoOirtDQFVvPpcMtJl3PW5hqW1rtQPi/kjZL1LNoH+QgIe609Mwr
         +BJetB3iNYUQ4t+4fTqYBpLXvN3IKqIuKEIQ5qlHvCIrbnwyp4Px6IPNIFjGzqsY7mGe
         OpNplk7cbHdKY+uoD9lpni5B3yl7L8mQch1EzUIDMbJjLt1T6wieEdHiBt8mNaqaj1A2
         Xv25BFfjBLnA76iqGgItTjbhULSwY5pckt9tgNFhyTj+7DRastBnY9pUOBjwBPez7JAw
         8fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRCkyG4TkqvXDMwoou9SdiJxe3ktjDM6K9gTtTQ6FgQ=;
        b=TcFu+eIJgeFfZvunV0qrMje8T47TwJmARdcCbS/a6ZBiBAOoDhUAmpWS/N3NZTI2jZ
         atJzG15KtFEBEgbf+vq7vQQqzIMrk9ZTlVptpr6Hles3kV3BnOD9RKdYOAWSorVVtbsU
         lM5OYiHYDqj0w8GU6MgmH6Fl/K9YxMZ3KMPcvXoTexhOasdM97YWmelu/HcP8eF5nJy6
         5k5KQhH1LFEPtcUKSnZ7DjHuDfVEJT6h4wGgnzWt+WYhhN+64s2kFlCL9fmqjvBO6w8A
         LpLjas4ZaIKB7SQb5Hkxd/ZJP/vgjTFOeGO8zOsIPSAv8qjRV+Yw4cMaxpSPRRqoJa1V
         sxbw==
X-Gm-Message-State: AOAM532UvXFdrqiqjg08MvSaHVVwNGmRraTV45mSnGIDF97eh/anjtjW
        zHCb41NmDFUYL9w2C9gn7uT4zg==
X-Google-Smtp-Source: ABdhPJxNJHB/jkwvt3SnOEVnLx8LyaGLXWzXbT0AoU60y8LsDP2V8voSbM57BvSGE3BP19PVCuAX/w==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr10240105wmc.179.1598513914406;
        Thu, 27 Aug 2020 00:38:34 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id f16sm3655012wrw.67.2020.08.27.00.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:38:33 -0700 (PDT)
Date:   Thu, 27 Aug 2020 08:38:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        wil6210@qti.qualcomm.com
Subject: [PATCH v2 31/32] wireless: ath: wil6210: wil_platform: Demote
 kernel-doc header to standard comment block
Message-ID: <20200827073832.GW3248864@dell>
References: <20200821071644.109970-1-lee.jones@linaro.org>
 <20200821071644.109970-32-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821071644.109970-32-lee.jones@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There has been no attempt to document any of the function parameters here.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'dev' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'ops' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'rops' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'wil_handle' not described in 'wil_platform_init'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/wil_platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wil_platform.c b/drivers/net/wireless/ath/wil6210/wil_platform.c
index 10e10dc9fedfb..e152dc29d177b 100644
--- a/drivers/net/wireless/ath/wil6210/wil_platform.c
+++ b/drivers/net/wireless/ath/wil6210/wil_platform.c
@@ -15,8 +15,7 @@ void wil_platform_modexit(void)
 {
 }
 
-/**
- * wil_platform_init() - wil6210 platform module init
+/* wil_platform_init() - wil6210 platform module init
  *
  * The function must be called before all other functions in this module.
  * It returns a handle which is used with the rest of the API
-- 
2.25.1
