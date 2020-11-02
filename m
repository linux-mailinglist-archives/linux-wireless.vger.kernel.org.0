Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE32A2980
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgKBL3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbgKBLYW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29DC061A47
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id i16so8723999wrv.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWq4EIZLBdjUFDSSQaVD1PvQUVhVWlX38rMGrIxZmlM=;
        b=x2UW17qR4c0kvXf/+l7qSJedHq1o8V2vl+ISBbFylFtvk2vUKWFFpdTfou1B8He+Q0
         c+EyGOB8XIf0ZxnaJhpyHhEd7SQSHc9aQMv4SMKIg/qaImxtSbTN6yHfSvo32N3zZtMk
         hHi62B9axAABq+Q0CPfoGb/WgA5XJaLhXqCdkiIKH25TgmhbwN9Dw+6Sxd4+QQlBdM1T
         PA2IqSCyqLG7ebal/2RFDCJe+6tyKItzL5qw9Yz70AjrsRf0DmARk71ZPY06Png1aycE
         /HyfpVe2jMrIWISBydC5ez8ffVW0P5z9PiFIqkhYIxziqjqKTD72SZTffs8zm4WgVA0G
         Jq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWq4EIZLBdjUFDSSQaVD1PvQUVhVWlX38rMGrIxZmlM=;
        b=YTM22cvg0cpJA+XtyB1cTiG3oJhbiuAKuopCSsc90FOMb1OW+Wr+ToLPczlyjDz0fg
         /ohrY9wnARGUZfKDTWfR4b76Ah/9uTbARu7oPk1lmBYybqVGLZe4TeKVBL6pcpOvrP6K
         0Wkayczwstb+xy8cy30mBfzPdKJmsi9BstJCwzGDaoo2US/bzV1BIasG47opjnADZrSH
         staZA+iFG7inlWw7qzoTTRUzAMa7BGVq+8+eAzVoDXo9lrZeqmrqAGasqaqXzLV+VLZb
         pV4yZpaPaKMB26EWQakXHzCi9hWnpQFyZLTW+LBgCki2UwBDoxxp6D28AEBsbtB4zf6W
         m0jw==
X-Gm-Message-State: AOAM533sGQD1Lj/5C/hu3mbROYz3WkG+HcQglKYcaaSY7r1bA74eUVwH
        VQrqpF+SdNJk6JCkQ180BFvbFQ==
X-Google-Smtp-Source: ABdhPJzTs3Su8jafA1/QFINA6CLlvpL8pFXQ+/MTGhpyj+hXg91Kpda51zuYKkZ+k1gKCcylqLCg+g==
X-Received: by 2002:adf:82a7:: with SMTP id 36mr19854627wrc.1.1604316259365;
        Mon, 02 Nov 2020 03:24:19 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        netdev@vger.kernel.org
Subject: [PATCH 01/41] wil6210: wmi: Correct misnamed function parameter 'ptr_'
Date:   Mon,  2 Nov 2020 11:23:30 +0000
Message-Id: <20201102112410.1049272-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
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

