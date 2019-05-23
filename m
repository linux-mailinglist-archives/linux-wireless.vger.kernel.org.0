Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABCB276BF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 09:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfEWHPj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 03:15:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34510 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEWHPj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 03:15:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so2656276pgt.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2019 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9OT0uMo2PLy/8Ny1z6314ZNN5qG1WmUaXU15heD0YiU=;
        b=k53+//cRJz7YPDv+aEa18jB6qXw903+O5JuPI862LkUkOybM4JYnvmRX1fdzyLEbcl
         Nt1wXS2auGLJkyQcVPddgugt37yG6X7IbbUrca1dLrVZascWqbGiGm3TK8yaARD0kVs2
         7DiQL+1zScCzIAoGzY8TZ12WVUr73KoBt4W7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9OT0uMo2PLy/8Ny1z6314ZNN5qG1WmUaXU15heD0YiU=;
        b=RRac8HDlMsVsp8qPuie4Q1+TMGJRFEF0q731S4PKYzL85o+Q5sZ3P2UFBi+b/0GZx7
         J0bGhy6haDJ7z3J1wMtV4uF2oUkL5HVTbDuClFEwKAtKUJAVpzG0LFg3NFBCxn+04SVR
         zd6gOBPxS7KbH7nqR7DMHfmU3cr2l8cwUniwLf66IxnM8V0CnL3cSTQ3jwrgYWVvwas8
         ptB3+YcwD0ShyJGTxFnLjZQToypLyJS+TcuVsI/SwzBLo5RQ9oRfh2mIXkHafDwd4MbW
         v56JoL7Wt2msmC4uwLhKeNAZgD/Z48n0tlNdke1gfwV2fLuvtlAYcJ9lokLry89HC4JY
         b1hA==
X-Gm-Message-State: APjAAAUQj/3az2/zCI/9R1yzda5aFmW+ixcXffyCo8RRlErpgluKnbRF
        23SYiEqMRUWcwM6SZrw3Ls+owiv6Xmr99A==
X-Google-Smtp-Source: APXvYqwXEqV/cFGWL26K2VAmarTTpWfYld85TN3rtFXREFCWg6WfpZed4VY54Odis9qxvITM5vQxgQ==
X-Received: by 2002:a62:8893:: with SMTP id l141mr44178300pfd.261.1558595738659;
        Thu, 23 May 2019 00:15:38 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id m12sm23566432pgi.56.2019.05.23.00.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 00:15:38 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     kvalo@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org, Claire Chang <tientzu@chromium.org>
Subject: [PATCH] ath10k: add missing error handling
Date:   Thu, 23 May 2019 15:15:34 +0800
Message-Id: <20190523071534.254611-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In function ath10k_sdio_mbox_rx_alloc() [sdio.c],
ath10k_sdio_mbox_alloc_rx_pkt() is called without handling the error cases.
This will make the driver think the allocation for skb is successful and
try to access the skb. If we enable failslab, system will easily crash with
NULL pointer dereferencing.

Call trace of CONFIG_FAILSLAB:
ath10k_sdio_irq_handler+0x570/0xa88 [ath10k_sdio]
process_sdio_pending_irqs+0x4c/0x174
sdio_run_irqs+0x3c/0x64
sdio_irq_work+0x1c/0x28

Fixes: d96db25d2025 ("ath10k: add initial SDIO support")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 9bbd5b54b8ca..4b7f1c6f13e2 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -607,6 +607,10 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 						    full_len,
 						    last_in_bundle,
 						    last_in_bundle);
+		if (ret) {
+			ath10k_warn(ar, "alloc_rx_pkt error %d\n", ret);
+			goto err;
+		}
 	}
 
 	ar_sdio->n_rx_pkts = i;
-- 
2.21.0.1020.gf2820cf01a-goog

