Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DCD24971A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgHSHZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgHSHYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB76C061344
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so1085841wmg.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BVsdrFO67l+LY2/RUcOBcwvHM2Wo8sTbd6g8xd/h5g=;
        b=mujsbfdO8EPBn3dEm0AoUidJtUtgMIe3rCiUJTGjLX3Of158SoNm0koW6RMNXvRJ/8
         lmzpDeWgkzzlsBh1dkX94BKJ3fyVLHI4T9Ilj1yREwQ+2unf4WiSBef0NTlTQIBSS52E
         Y+J94jgeNaHh0/B/l2vklzeWB+Sh1oB4lQfFLe/+ItNVTU16zyLGgCkOuuHE+6fExHeF
         Pg0C28K20jhWeJOlMn9pVb9Q/4HMZs0tmZFsGIcuYFOSAcGwBV80k25bzyzxhBkEYzLd
         ixSGSFBGYU2yUcpV/njAISleaur9hsNtMbg1cJ0e5gqoSyLVKFUa/bk2UDRYTEAgllnE
         9KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BVsdrFO67l+LY2/RUcOBcwvHM2Wo8sTbd6g8xd/h5g=;
        b=oFowrkoe9GqUbZQM4L9jw1bklZR25EwsJB06uJkJt5BlljBQUTA1ZgXgPWMqpq/tRc
         5Up5QmPCmY3LZBiAy2CNva84nDWnxkraBrIUcTuVEo7tz84MH36Cq6yib4dsHLsG1/E4
         slMr5Sw2yEr9jjk8o8/DfTfV/VSEja36IXwXnsSNUwl7WDCFDw5qjJuT1AxZUnJsmPZv
         43p0SnckKWnYr7TcKQj1hZCSi9OEoseFU1sJcQRFSA1lmpafGhn7K8OyofyABGLHzBPy
         ntdoqvZc7xJ7+KOXhaD9r9DA6xcqsIMemOyTyaBo5j1L0lAE8k+lghT1hyHzPO4Db2ng
         KBBA==
X-Gm-Message-State: AOAM530nbCmLcwfb/910MxxJPO3niPzodBuaCh3sxpU3PE/5Kn+TPzY6
        Rdt7oKg3KhDTj9rF9p/dewH3Zg==
X-Google-Smtp-Source: ABdhPJxIoUgrKQMpLoNqNQxcmnOWW8PzaBUbxjBOwkWVoTHhuCMKJfEJKdhkN/M7RLhyWURYk4tzzQ==
X-Received: by 2002:a1c:286:: with SMTP id 128mr3361675wmc.37.1597821852427;
        Wed, 19 Aug 2020 00:24:12 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Hari Nagalla <hnagalla@gmail.com>, Guy Mishol <guym@ti.com>,
        Maital Hahn <maitalm@ti.com>,
        Luciano Coelho <luciano.coelho@nokia.com>
Subject: [PATCH 06/28] wireless: ti: wlcore: cmd: Fix some parameter description disparities
Date:   Wed, 19 Aug 2020 08:23:40 +0100
Message-Id: <20200819072402.3085022-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firstly a rename, then a split (there are 2 'len's that need documenting).

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ti/wlcore/cmd.c:832: warning: Function parameter or member 'buf_len' not described in 'wl1271_cmd_test'
 drivers/net/wireless/ti/wlcore/cmd.c:832: warning: Excess function parameter 'len' description in 'wl1271_cmd_test'
 drivers/net/wireless/ti/wlcore/cmd.c:862: warning: Function parameter or member 'cmd_len' not described in 'wl1271_cmd_interrogate'
 drivers/net/wireless/ti/wlcore/cmd.c:862: warning: Function parameter or member 'res_len' not described in 'wl1271_cmd_interrogate'
 drivers/net/wireless/ti/wlcore/cmd.c:862: warning: Excess function parameter 'len' description in 'wl1271_cmd_interrogate'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Hari Nagalla <hnagalla@gmail.com>
Cc: Guy Mishol <guym@ti.com>
Cc: Maital Hahn <maitalm@ti.com>
Cc: Luciano Coelho <luciano.coelho@nokia.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ti/wlcore/cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index 6ef8fc9ae6271..745101633a3f1 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -825,7 +825,7 @@ int wl12xx_cmd_role_start_ibss(struct wl1271 *wl, struct wl12xx_vif *wlvif)
  *
  * @wl: wl struct
  * @buf: buffer containing the command, with all headers, must work with dma
- * @len: length of the buffer
+ * @buf_len: length of the buffer
  * @answer: is answer needed
  */
 int wl1271_cmd_test(struct wl1271 *wl, void *buf, size_t buf_len, u8 answer)
@@ -855,7 +855,8 @@ EXPORT_SYMBOL_GPL(wl1271_cmd_test);
  * @wl: wl struct
  * @id: acx id
  * @buf: buffer for the response, including all headers, must work with dma
- * @len: length of buf
+ * @cmd_len: length of command
+ * @res_len: length of payload
  */
 int wl1271_cmd_interrogate(struct wl1271 *wl, u16 id, void *buf,
 			   size_t cmd_len, size_t res_len)
-- 
2.25.1

