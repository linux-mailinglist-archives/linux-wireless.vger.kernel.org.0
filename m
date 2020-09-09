Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D812630BF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIIPlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgIIPgu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C5EC061757
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so2710818wme.5
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+yPlB3SpPWTohvuvahTspwiXrquAXLGYj1ufX7tRac=;
        b=T/XA15q3JEw64vle/SJDqe2cwhx5Ytuoy9tyFKBx6FYJOXSiQlk43e+9oTrc7yBX9R
         UD9ZbP7voxpFd0QAH2NXBx5kOEodqH1tyt/kxtKDmIRE2Gq5GoYyoX+LpE/0V9H80nGP
         dsSTRSUbWchmawOSL9PwcvMCtMkq6jJjedmtW2Hhrb7f7kOEdUgfk4ljYxxiW4Sfsr59
         Kp1ZJHrrhMQ8q0aMfTCDs2w2reeU1h2r45Uh9/Cw0wN2t37YqnVtId6LXtSxncFNXEE5
         jQolc1vhsTpFb32XbtIjieUZtcovZ1M7UU2PHNqDMArCLW99paU3XRDsJ9xnq3CpbkV3
         KB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+yPlB3SpPWTohvuvahTspwiXrquAXLGYj1ufX7tRac=;
        b=f6GzQIff4Eu7ukAJ0W7oGZWcM6Art1Ow1Ahu+GPfDQBF91UNxZLkL45y/o5BFkCFMP
         XXFODl/2uhSvBCEsYq6MoCMCxgJr0iJtGD1ZU5NgPd6HkgDpjw2YQcLSIjiXzaM3eGlM
         DrJeI01lTikhl4GlY0fqv5bRirxNyJeigBMbwNF9+U6gi1KgNHp0rMOW2oG1KsmFGuOS
         IkBugdMTHXyi3TbMDVdztCbEkTYXKvZHFN83mA+B0b85s2r703Dhez3RrqXgtkyGyJYb
         vjv+0BH/ssogWbI1WO2IKSSDF+o7OD3lXujaizekOmHqtCMOQq0lh+VCLjOeskEcYApM
         gXiQ==
X-Gm-Message-State: AOAM5333oR97Sltg4oMYOr+aAsMyHJlOp2HlYfW+iHvY0RqGRTqnKLuw
        3ctb/evhRgEF4LZ049ojic0vkwMjVzcxrQ==
X-Google-Smtp-Source: ABdhPJwaWbjB6dWq1VBH9CdEs4zed5EcAALfs7E84jp9ii9BNOXRbNxk3DcUeoBwvR35GrEJlu/3UA==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr3912572wmh.80.1599665809048;
        Wed, 09 Sep 2020 08:36:49 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 128sm4470602wmz.43.2020.09.09.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:48 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 1/4] wcn36xx: Define INIT_HAL_MSG_V1()
Date:   Wed,  9 Sep 2020 16:37:33 +0100
Message-Id: <20200909153736.2905114-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
References: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
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
index ad36d6e744a6..3adb744b093d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -453,14 +453,20 @@ static void init_hal_msg(struct wcn36xx_hal_msg_header *hdr,
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

