Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EB5239DB4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHCDLK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgHCDLJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDCCC061756
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so32820304wrw.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYD10FZO8KhccbIhk1uqysdR2q5fPg1Yg+7P+eySpwo=;
        b=I9ASwBhwfZb3DoiFraFPtPwchqSItIhD79zECvHvQTdoVCkO8EwPvAXUmK9/KGGAtg
         jTXHThmWJXorf/ar5noQYN2/L5bvzKq/pXQqiDMZ+1hbzHA5+ZCU5kpEPR7gInQEuB5i
         JzFbcxOCpuNsUi6cQa8ABQYM/5Qc8Po9ntduUTg7kveLycm9eC+lbeFbv1hxZcDAhl1a
         mB2SyDxYBibgjEPofx/lcaVRG4SIN4zgm8xnH9GTIN4qVbRprhNcqb4pxrYgOjPHWSjM
         jJre9aZF2ldPMFbMUStMGv1n/RFFr5OXLd4+mcJxaiRcXSRL5g6VfYBXeH6kf9acBpCU
         Kmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYD10FZO8KhccbIhk1uqysdR2q5fPg1Yg+7P+eySpwo=;
        b=UiSP5Ig9NgWcD3soLXyhZwFlRFbZDzlejFEjeTesdlGEGc9OZBMd+ibpu2lZU0Warp
         VoAWPkj6/UuZkgPsx/ZkpeiE4Tso2eqIb/lx4BxZZmRwcwhPFsolMXHk5tbXcF9cxOEa
         EuiMi2VssHPxZvmAkospyNutAHF3SS+pZRMaTYrw/hK9JnU8SugBdM7u1YfC676sbSTO
         Jn49A9RRY2+d34Y1BCva63NukUkcQU2zzGe1V1uXd7LEaSeIVorF+ZOQWR7KwsTIk5SP
         VPzHvASrmEyjirK/xjzqmoIXuZPekUjvdXNrMjM2YZe0Bcc5Wv95+uhpgKUu6L9iYN9T
         GBkA==
X-Gm-Message-State: AOAM531gZvPg6X2wCxPUB+k9DbIl18kU9vyVY4b3zuv1K2mrZJlDNEMl
        yRaUefamyJyIkj4uaaaRk1WH3w==
X-Google-Smtp-Source: ABdhPJwZkJWZxJoaH4alTXKRcy9FS1Usey7pRhjXNDwb2OndQZvlINcGG0SbZW15MPYw4zRZcphPHQ==
X-Received: by 2002:adf:fe0a:: with SMTP id n10mr12660332wrr.125.1596424267660;
        Sun, 02 Aug 2020 20:11:07 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:06 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 19/36] wcn36xx: Define INIT_HAL_MSG_V1()
Date:   Mon,  3 Aug 2020 04:11:15 +0100
Message-Id: <20200803031132.1427063-20-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index f61516988953..6a03d5956fc2 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -349,14 +349,20 @@ static void init_hal_msg(struct wcn36xx_hal_msg_header *hdr,
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

