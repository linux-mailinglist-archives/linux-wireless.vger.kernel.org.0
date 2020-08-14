Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F57244919
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHNLmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 07:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgHNLkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C5CC061342
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:40:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so8228757wmc.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/mL6RqaAdBiLmuXVeHhJK3J3fsDrt9yKqZOgLAYFAw=;
        b=QqtBGyrStEAU+EDjLF4EzSj1gEM6DRPMeV7x1903UbO3EpPFG1JFPAQTSze1goS+qq
         XOhkvY830PVDitir20GP91+hgCD9Mwn8MfVpM310mjWrqwZyNZjM6ZX4Q9zGIQYeK8fV
         dwLS3JOv7qVRTh4ccwhI/PRSwDorU+9PlKI7Q3wWtq5LJyj3vJmcdEXOZFka1MhhepBF
         JQGrYsaZL1LP4JCDr+xjUYct0pJRhq7fcR0H4CVYbymxeg7kSyoB0kDWtMJkQt2tz8hW
         /3Roj44jhR0rscPXmkFkOQcloO7ZSVRL7Oj1wk0CElTEQY4yJfszYtqUaP+0mUSGmPUh
         OJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/mL6RqaAdBiLmuXVeHhJK3J3fsDrt9yKqZOgLAYFAw=;
        b=I6nTu8LrGbM7QioBrTwBNYGabezVt3J7IYSqOMVKzAy33WzezDSfrJnYhiugo2R/Hb
         JbJltFRsrIE+D3IwL92M9DcvjHxZgyr6ycUTYl5FK0Vw60AsTJ59/Mkoe4T6w3hayetL
         r85+Fr8sFCQ3zmMRgnU1RCRZw8N/ZBUIB9TnIGDq1WmuUuyVrByyAoGYq/E+ATc0z47K
         Rr8Y9SXshrwl9NHVj48i6nmyibVkuW3f+5CjfXTfdWhnlXFiCE3oBkuhxDbyW/DWMdvD
         zLKEWnGJRaCQagVUbcTgjp1qLUtCRSDsI2SqYrjrAtaL/LFsHY96rUR1vF/FPTk2X4AJ
         N1SA==
X-Gm-Message-State: AOAM532rDT5JwU8sCg+u/YiGqUOnh/OaZpZzaKxxD+B5mMlnVt5CbiBr
        ZDITZqH3hmE7dTpzw5bOUSuKQA==
X-Google-Smtp-Source: ABdhPJwadpwV0cMVShI8hxVfz4uE1ct+D58aY3i6FzV24SvCOAOYjR1k5+EDY64SlNSW+1v2bm9+Nw==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr2372137wmg.91.1597405203683;
        Fri, 14 Aug 2020 04:40:03 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Wireless <ilw@linux.intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 14/30] net: wireless: intel: iwlegacy: common: Remove set but not used variable 'len'
Date:   Fri, 14 Aug 2020 12:39:17 +0100
Message-Id: <20200814113933.1903438-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlegacy/common.c: In function ‘il_enqueue_hcmd’:
 drivers/net/wireless/intel/iwlegacy/common.c:3126:6: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Wireless <ilw@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index f78e062df572a..ff00c50db7c46 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3123,7 +3123,6 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 	struct il_cmd_meta *out_meta;
 	dma_addr_t phys_addr;
 	unsigned long flags;
-	int len;
 	u32 idx;
 	u16 fix_size;
 
@@ -3182,9 +3181,6 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 	    cpu_to_le16(QUEUE_TO_SEQ(il->cmd_queue) | IDX_TO_SEQ(q->write_ptr));
 	if (cmd->flags & CMD_SIZE_HUGE)
 		out_cmd->hdr.sequence |= SEQ_HUGE_FRAME;
-	len = sizeof(struct il_device_cmd);
-	if (idx == TFD_CMD_SLOTS)
-		len = IL_MAX_CMD_SIZE;
 
 #ifdef CONFIG_IWLEGACY_DEBUG
 	switch (out_cmd->hdr.cmd) {
-- 
2.25.1

