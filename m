Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58EC256477
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgH2DjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgH2Dig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44370C061232
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so859743wrn.10
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dX/lGSQb/+52DNmRF9sJPcKmKqQ1oW2lYx+J5BfuacQ=;
        b=VxBxsDpc7OYV51xq/MRxalYDJCVagpTLHEVxwzhTPru/wFZQrhX1FF8icUONNKvf/O
         WO3ByjJhhIE23T2v6kPwmjp4udYoZDIqmyhw5UAkDRbDgrb+FND2rZHFGa2q77Go7eSq
         Yzqz7ztFZuB0pcCxbmooVa45TxLsDvezKs6QoPbr7+4o2TaqDUI7TY4YwoWkLxcfpONb
         NPDT+ju6bEkABn0IjBgYcyvOavVvoA+jfuRPmJd70YhZxKG2cBGaX4qkHK55H/oefxSK
         jOXOOWyk3OkjVT0pgj40YcxDHB64+tQC7LDrOlhOe0ucI1vj0OZMgO1zAd8cI9UMsyTp
         S/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dX/lGSQb/+52DNmRF9sJPcKmKqQ1oW2lYx+J5BfuacQ=;
        b=Zfyu//69D2tqXZBtphn7Nh7treOHrhBn//bHQK4mh/UDch+EWxGGY+muvgmKgTyEMK
         fRC0PSoxG+xzRaSeUEO5XpKHprfI1nlgyJsnBLs9GBdmPcVO7ZRz47yRUM0UWsvd2VX/
         6RWoFbuD3iqIFbcFU35LGZrRlmBeN1XOwx/2/0hI+UBGmlAL7oEaxfZGwnes2DQfetXG
         8D9umU/jRp4VOFyBdPFY6Wi+aUvugCfhAxMpp+IAwwITRTBVqNUzMzqxcJTflrnvibDv
         0lkRZiry9falMdORUYrTlSau5drpnVOKfjwVyr7j8N+6y69ugLvjZH8peYZxaSgD0wjL
         32EA==
X-Gm-Message-State: AOAM530f0AxBVfQMMqKQNiLa0bv+oklmHjBrRtYPqx/fnHg8HB4FMmMG
        lVcOry5Tw4O5eBjH2ryUTj7/hQ==
X-Google-Smtp-Source: ABdhPJznSbCSKWbSaBnOf8wB3o6XVedtXSKZnaAbz+m6Nt64CEHb3BxWnAFVtzKqmbYzuZLhpCoEzg==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr1661631wrg.131.1598672313984;
        Fri, 28 Aug 2020 20:38:33 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:33 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 11/12] wcn36xx: Define INIT_HAL_MSG_V1()
Date:   Sat, 29 Aug 2020 04:39:07 +0100
Message-Id: <20200829033908.2167689-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to pass 802.11ac VHT parameters from the SoC to wcn36xx we need to
use the V1 data structures associated with BSS and STA parameters.

The means of identifying a V1 data-structure is via the SMD version field.
This patch defines a INIT_HAL_MSG_V1() which operates the same way as
INIT_HAL_MSG() with the exception that it defines VERSION1 as opposed to
VERSION0.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 86411f3da79d..d9bbbdc8d013 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -355,14 +355,20 @@ static void init_hal_msg(struct wcn36xx_hal_msg_header *hdr,
 	hdr->len = msg_size + sizeof(*hdr);
 }
 
-#define INIT_HAL_MSG(msg_body, type) \
+#define __INIT_HAL_MSG(msg_body, type, version) \
 	do {								\
 		memset(&msg_body, 0, sizeof(msg_body));			\
 		msg_body.header.msg_type = type;			\
-		msg_body.header.msg_version = WCN36XX_HAL_MSG_VERSION0; \
+		msg_body.header.msg_version = version;			\
 		msg_body.header.len = sizeof(msg_body);			\
 	} while (0)							\
 
+#define INIT_HAL_MSG(msg_body, type)	\
+	__INIT_HAL_MSG(msg_body, type, WCN36XX_HAL_MSG_VERSION0)
+
+#define INIT_HAL_MSG_V1(msg_body, type) \
+	__INIT_HAL_MSG(msg_body, type, WCN36XX_HAL_MSG_VERSION1)
+
 #define INIT_HAL_PTT_MSG(p_msg_body, ppt_msg_len) \
 	do { \
 		memset(p_msg_body, 0, sizeof(*p_msg_body) + ppt_msg_len); \
-- 
2.27.0

