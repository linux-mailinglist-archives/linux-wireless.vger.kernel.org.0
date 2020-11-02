Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB422A2909
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgKBLYy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgKBLYx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:53 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EEDC061A47
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:52 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c18so9019753wme.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O00sHeoq7zqB2CJlcbUNyhU2GOaz7UJ685HbihqjKQM=;
        b=FxCRoUbjgVNKk7HNy0zfK7Ysq7fk/pGHTzojrVEkM6DLmw3ICYot6hqkuW9TacfsS7
         C1JitGKDV7nsumoh2YZSgBmp8X0Pbhtqo1bcQEHkwWjEDqef70DDjyndMdNy3lv8L8Lv
         CoivpKFBRslyMBL1Ae1LhHyziMeAPQkfdDVoN3iKlIZ/nOat4K8npipMSv6xug2OjzJC
         BoRviZDr/B42KExznjrNo3szFW3PcHnRK553HPrEwFHCh4LZRpO8bODHTJDyDaChy1R1
         ZIwqwnbSJmlup0QvMKaJBM3kKI7rkB0RsVdgF6Dz5Fc/kCoSDGafT72YM6xOf/eiDOze
         yHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O00sHeoq7zqB2CJlcbUNyhU2GOaz7UJ685HbihqjKQM=;
        b=OBj+IEJ/RzJWaOL/if3TSyCxAyxMaAaso/LJFH7hTJ1PPiWc7x9F8RL+0V3LWFy97N
         anPCo0joYi8FGzowIE00JthSwRhZba8X5hcMz54RAGByoAyvFatjBW9Ib1LUJPYAxk0A
         FyPU77gwgksKYKhRgP8p29BhA+Nl4zicifGASdnIaOvvvP3sc7Uo0gDNyNgbVGjiKJPQ
         NRtbHc72FpfXV0sfm1EaAb4qyjEUc2uyfdYrWK1+JpRb4PD6QUJql4eXQV5sI5FGjxD7
         lHSNgGjVCggVqPaUneGZprY2xofDrX451cAgyH+jDutOBRFaBSkT99JAY8a7VjNI7M9D
         cfOQ==
X-Gm-Message-State: AOAM533uE/+ZKOS6VweLVoeWmZdeKLgcY5ui+q7RGFOtIxuPq3/vui2y
        xO9XztsHe+DCkgSNXXeqhXlxjw==
X-Google-Smtp-Source: ABdhPJyeihrNn2QbmDeQeLSXqwCKFnxhucL/uwRzdauxI7/SvxS5e7FnGW8HV/kyWFK/61MdeNRReg==
X-Received: by 2002:a1c:103:: with SMTP id 3mr16981441wmb.81.1604316291370;
        Mon, 02 Nov 2020 03:24:51 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Fox Chen <mhchen@golf.ccl.itri.org.tw>,
        de Melo <acme@conectiva.com.br>,
        Gustavo Niemeyer <niemeyer@conectiva.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 24/41] wl3501_cs: Fix misspelling and provide missing documentation
Date:   Mon,  2 Nov 2020 11:23:53 +0000
Message-Id: <20201102112410.1049272-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/net/wireless/wl3501_cs.c:57:
 drivers/net/wireless/wl3501_cs.c:143: warning: Function parameter or member 'reg_domain' not described in 'iw_valid_channel'
 drivers/net/wireless/wl3501_cs.c:143: warning: Excess function parameter 'reg_comain' description in 'iw_valid_channel'
 drivers/net/wireless/wl3501_cs.c:469: warning: Function parameter or member 'data' not described in 'wl3501_send_pkt'
 drivers/net/wireless/wl3501_cs.c:469: warning: Function parameter or member 'len' not described in 'wl3501_send_pkt'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Fox Chen <mhchen@golf.ccl.itri.org.tw>
Cc: de Melo <acme@conectiva.com.br>
Cc: Gustavo Niemeyer <niemeyer@conectiva.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/wl3501_cs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 026e88b80bfc4..8ca5789c7b378 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -134,7 +134,7 @@ static const struct {
 
 /**
  * iw_valid_channel - validate channel in regulatory domain
- * @reg_comain: regulatory domain
+ * @reg_domain: regulatory domain
  * @channel: channel to validate
  *
  * Returns 0 if invalid in the specified regulatory domain, non-zero if valid.
@@ -458,11 +458,9 @@ static int wl3501_pwr_mgmt(struct wl3501_card *this, int suspend)
 /**
  * wl3501_send_pkt - Send a packet.
  * @this: Card
- *
- * Send a packet.
- *
- * data = Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
+ * @data: Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
  *                                   data[6] - data[11] is Src MAC Addr)
+ * @len: Packet length
  * Ref: IEEE 802.11
  */
 static int wl3501_send_pkt(struct wl3501_card *this, u8 *data, u16 len)
-- 
2.25.1

