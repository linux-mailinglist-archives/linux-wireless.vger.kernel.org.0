Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3C912635F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 14:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSNYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 08:24:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43821 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNYZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 08:24:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so4842377edb.10
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uH+aDS9FUX0GfFwi0ZzL3xSE3Gr6/KDnkMPDTHrbWGU=;
        b=RX/8tecahw1r+PMulH8xINJ4kaoUwAGQs0CjBfHXoXKe+ddKMMVL98ff/55YHZHUpq
         yz1iwfJnQxcCJNookUWotO6cCBnhD+nZMSZJE0Z5Ilyjvz3L/h69HYiuqLMDO2XI7S7e
         QpZw+eRlmNE1IIaLhbIHW6/GkfbfIUQ2+0ftG3TqUgdTDaC1N2aFREZ7IWBaOtJBcQuG
         +kOojnN65cO/XwKn0j/vfRq+wOt66EfKKxIeY2Xupa31oGxOCyxrwIpTpFUrHS/J9E7y
         X1LmQZUJCLAV0DDu8J8k2EgRi2E6DrcR+ccrlhsAMZQ4sqMLtapT4f+0uD/jTxUmw780
         w75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uH+aDS9FUX0GfFwi0ZzL3xSE3Gr6/KDnkMPDTHrbWGU=;
        b=ucoJYR9v9vh++I7qw6dX3zhpjarVBbMi4qd03ST/PY9QpKywOVFKijA8o+yOXqdvJo
         jKcWP9nJCMF+NYAT8wJZDHCtT7yonv7q2HeQKLp2jzABAPHziqzDm6kKdYnnT4OwU/M+
         XONmUCn37m45+VpXtl5QZqCtswNymcc4xn52E+D34GdwGDQPBnFCjwTLCCuVU8OkWoo/
         CfDPuOKo5urTBOKMcbZwz0FtMzICb6Wnm5JOr1ZscsE6eXYgExUCzCjN2gCo2ipWzl0C
         SKaQdQFmDlSX1a8f7eD6wSm69mKWP26uiRp0QjkJV/6QcLKE+D8pRi6Az/jEDf+hUQtw
         oPWw==
X-Gm-Message-State: APjAAAWMounWVGi75wZWAkhT0kahw837XvWQiJJzRG4FhPZo0AY2LBhI
        H337Xal6V5qupo5sIfsYoW0+JNFyTvw=
X-Google-Smtp-Source: APXvYqzllGHKaz42y389MG+UUUFshXZdU8TK+QtM1Os0aRVrOP2s4lubdfeYnEqljWeTGFXE629Dzg==
X-Received: by 2002:a17:906:260b:: with SMTP id h11mr9333551ejc.327.1576761863807;
        Thu, 19 Dec 2019 05:24:23 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id cw15sm410286edb.44.2019.12.19.05.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:24:23 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, akolli@codeaurora.org,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 2/2] ath10k: pci: Fix comment on ath10k_pci_dump_memory_sram
Date:   Thu, 19 Dec 2019 13:15:39 +0000
Message-Id: <20191219131539.1003793-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191219131539.1003793-1-bryan.odonoghue@linaro.org>
References: <20191219131539.1003793-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The description of ath10k_pci_dump_memory_sram() is inaccurate, an error
can never be returned, it is always the length. Update the comment to
reflect.

Fixes: 219cc084c6706 ("ath10k: add memory dump support QCA9984")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/ath10k/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 4822a65f6f3c..ded7a220a4aa 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1578,7 +1578,7 @@ static int ath10k_pci_set_ram_config(struct ath10k *ar, u32 config)
 	return 0;
 }
 
-/* if an error happened returns < 0, otherwise the length */
+/* Always returns the length */
 static int ath10k_pci_dump_memory_sram(struct ath10k *ar,
 				       const struct ath10k_mem_region *region,
 				       u8 *buf)
-- 
2.24.0

