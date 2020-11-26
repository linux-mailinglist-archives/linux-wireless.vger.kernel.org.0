Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEAB2C5596
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390147AbgKZNcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390139AbgKZNcA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:00 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D167AC0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:31:58 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so2137642wra.11
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWq4EIZLBdjUFDSSQaVD1PvQUVhVWlX38rMGrIxZmlM=;
        b=V+CXrilhjwCj4T6b2gK0G4kHB+E9WqcoPWO5sHkAO0mYwGJDTwIKysOOcMPrQ7g4ta
         cgZqRm+8L40GIBDP4lC95hryiFriui4GgqEk74cX0RearQVcu/fZv0jdkebEovrh3S5w
         QOW0o82Y4quszQIyb2K9ghJYZIrSe3PXLdd0UL8taINAjjHr3PxIvAtZjMm9fwuvmIwe
         /pGplvmZGDlkOkwfcbkOgZxiY5LuPGM+0Y7Csf5cfKX1JDQKjhiTmMaZmmETXFKVnT/9
         L7qYG3+8mCXHRtjWiQzM1HZx/jwM0EtEMLuuWOCVIjV1GpewSlC8w+BMGxy7y1na56NG
         S+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWq4EIZLBdjUFDSSQaVD1PvQUVhVWlX38rMGrIxZmlM=;
        b=a259P+cfaC4nG3BGX688Fblox6oloq4q0MTFBB/6CmW/DAUtvwR3MSCEjusFo/HzP/
         9UPnuPXINth5rz1LXxrmILZwoX7c9Vq88tcKoXb9sSiBJ8rDxKNUikEnJG4MMt/WjAtR
         OZv2rvBTQxQ5CxZahwhR3M9x0N1zPmCMLm2H0w2yVji1ST83cN/Pw4xhXqT0R8wbsPrG
         1F8X7bXyJkVjSQ9Rl1ivRR9BaIHkRiARElmBsWCmNsM3MUvX9/w9cWJGmSKLSQrmdep/
         FQkeo9CYvAp7C+S5IzWG6lKchdzi9nK7giiXRiumb7mo1GSOFA4reHPFo+k5lW8TpsI1
         eCVw==
X-Gm-Message-State: AOAM533Qw77o+9ugS+5ABgSKn0wx62NkzAB/05rhI9mqdG4mPvakmVaN
        Kyv+asR5Sn8SkMstYplUC42Pzw==
X-Google-Smtp-Source: ABdhPJxVDvRwfMlc/6PaK6IE8voRoyyugVPW9/0sd4X8zJjnzLg8wrJ4D/LuejkqlVFimEpIiqR6Qw==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr3919828wro.197.1606397517455;
        Thu, 26 Nov 2020 05:31:57 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:31:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org
Subject: [PATCH 01/17] wil6210: wmi: Correct misnamed function parameter 'ptr_'
Date:   Thu, 26 Nov 2020 13:31:36 +0000
Message-Id: <20201126133152.3211309-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function parameter or member 'ptr_' not described in 'wmi_buffer_block'
 drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess function parameter 'ptr' description in 'wmi_buffer_block'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 421aebbb49e54..8699f8279a8be 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -262,7 +262,7 @@ struct fw_map *wil_find_fw_mapping(const char *section)
 /**
  * Check address validity for WMI buffer; remap if needed
  * @wil: driver data
- * @ptr: internal (linker) fw/ucode address
+ * @ptr_: internal (linker) fw/ucode address
  * @size: if non zero, validate the block does not
  *  exceed the device memory (bar)
  *
-- 
2.25.1

