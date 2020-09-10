Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE643264F77
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIJToT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbgIJPdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:33:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70822C06138F
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so7062367wrn.10
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZDhnYzdyErEPvOsme5Hsukpib5rwiRrGO2nt/vf1eo=;
        b=YwoOafbEd0HreUrwPkh1owdlBkG4Sxa12QT7PAc8bw7GMj0lqycivp09wabvgKZlMa
         WrrRDnkYrmcQfp7p9TYJMWd4nTQZvgxocDhIvgkOo0CufTcO9rG2LbXajlLluBG/9z5b
         EQCrUKWjhNRFEWJgRDTHGxHXVYHts4lKRFqiyPAx4eiBkUqyMtq1s38cVDKPWaQLW9Zb
         I5aoPgPhAviYHB75ij09wFBA0eWgRTLYPVNEz8y/PayDusYU/SVjOmovv245233U834/
         mC6tBvTqpXx45v9+EyWhee4LENdxEXWkksOA1e5FIyQ1I9Uk/FYHM2H4OEYx1pLb9wxZ
         hAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZDhnYzdyErEPvOsme5Hsukpib5rwiRrGO2nt/vf1eo=;
        b=EwBrOu7Ny/9bC7pUWS7F31OcPyU7s7fSEsXVsls7byByt1fHAc1nJxNCalu5WvtTFy
         SSoLESFeEJkrm3ie232+vxSdwjqjnoKecCt5z816v/yVtuaL3nacnKa28gsIsaEUXciB
         QCdthnVgEzSBa9v/iPzHAek0OzMy9JyA5cLyIdEAC4va/CQiaVXrGOPG5xBP+UofmD7u
         aV3ZMrcCLZqOJUAZs6VOFc2MBvDMvtzEKq+thqXNcIDuao7CvH2Ia2feFSHce6Gce0nh
         D02Pu4sYRGHZnzK48oMGx+ntFTqIaNiskQY10FE07nnFpGNrftnoHMDvJpOM0nNBJ4+N
         wjHw==
X-Gm-Message-State: AOAM531L6x0v8fthzrqnacdj50UR8LCQGhgBT6rhKjLPgkS8R46JpqRZ
        K+s+DWm3CJC8o+HFQ9KV9YcvQmD+fVDOiQ==
X-Google-Smtp-Source: ABdhPJxP2lRuoQTGPV9tg7Onodogf5mDoRs0J95oFaFchPu4PD1qG/3RAoeQ17jHu7t4BsGsHuEEjw==
X-Received: by 2002:adf:e802:: with SMTP id o2mr9271987wrm.309.1599750455136;
        Thu, 10 Sep 2020 08:07:35 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o128sm3895678wmo.39.2020.09.10.08.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:34 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 1/4] wcn36xx: Define INIT_HAL_MSG_V1()
Date:   Thu, 10 Sep 2020 16:08:19 +0100
Message-Id: <20200910150822.2179261-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
References: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
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
index dde43a2b0d81..0f5952003fff 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -466,14 +466,20 @@ static void init_hal_msg(struct wcn36xx_hal_msg_header *hdr,
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

