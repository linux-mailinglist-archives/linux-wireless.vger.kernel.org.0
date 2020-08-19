Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA076249739
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHSH12 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHSH0u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:26:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE2C0612F9
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so20471126wrh.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXrVMXxmwgXJ39Y7aWHGNOyRG8RSZHjpquigiIYkasc=;
        b=KWxezoHUCGlrGQCvXcBhFEgWS2LPvlkk1d5JkmxYWRJuUxk9LWxiqSPTjRP/pTfFO5
         YBzpDzqKpzJp6+A2t0EEwKVqWgkqbMEzHenmeWSSlbpReQXdWwKrnouVMwytE2aG2ZZB
         oHNHdCnTb0wZ5N/xZGjlbPcNzyLBkjrMyk03gb/Z9oQSSAKnwjjpQFGQqTvyUyLlYBMF
         sAvrSW3VPuomjAxIMW66Oy/6ytfWYe9cbITe99uCsdR7IqZqzZV3yNL4JCU88+Kn430F
         23AN/50+wn6/N0reQ3Ve9Xqkjlr4k4UAIBamybp/mbEgVMJ8wtEONIhTHZ4J3UMD48Qr
         j6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXrVMXxmwgXJ39Y7aWHGNOyRG8RSZHjpquigiIYkasc=;
        b=LX7fEr1QeYUlQjqk/jNob/5w5CGvVIz3+pxQXEe5X5wALSRZdtm1cnCMnLw8OwWqNv
         3ytLJF3MoxtV0eroaM/hxly0L7ikNQrnaDApjqM3RwF78QB7nWZ3I3ngR3pKbkaozjJS
         pUGMzDbKjEzJK3z87/5cpfcE5y7aUroh1xG+83bYUcNc2dIXK94Mqf6jqdQkygsCfeL4
         mUOjUS7jVXTEViF4PzjzinsOkIwEuEorUZAG2+WfozYZFJIrZX6lJMfNGVe2p1KjlGqn
         AFprjs2kUGBIRkG/d8JCtER4dvVZTPWkvg0w0MXNyyNdYcBVLZSEfGSY7/n6dHuY12Fb
         XchA==
X-Gm-Message-State: AOAM530d6/vai3J5hpKaAL7pUQmoRj3VM6gKqFBu/5BCaT0bbD35C73w
        HWe7J8EYqfIkYKEnA+3at3b7JQ==
X-Google-Smtp-Source: ABdhPJyIy1C83VytUSZjLTP9jOacbg3bTOc+miIqXPZ3/S7FLn0ZJ/GfyX/76rybwZpj/fQj85EghA==
X-Received: by 2002:adf:c981:: with SMTP id f1mr23429447wrh.14.1597821880409;
        Wed, 19 Aug 2020 00:24:40 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jouni Malinen <j@w1.fi>
Subject: [PATCH 28/28] wireless: intersil: hostap_ioctl: Remove set but unused variable 'hostscan'
Date:   Wed, 19 Aug 2020 08:24:02 +0100
Message-Id: <20200819072402.3085022-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intersil/hostap/hostap_ioctl.c: In function ‘prism2_translate_scan’:
 drivers/net/wireless/intersil/hostap/hostap_ioctl.c:1958:13: warning: variable ‘hostscan’ set but not used [-Wunused-but-set-variable]

Cc: Jouni Malinen <j@w1.fi>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intersil/hostap/hostap_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c b/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
index 1ca9731d9b14b..514c7b01dbf6f 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ioctl.c
@@ -1955,7 +1955,7 @@ static inline int prism2_translate_scan(local_info_t *local,
 					char *buffer, int buflen)
 {
 	struct hfa384x_hostscan_result *scan;
-	int entry, hostscan;
+	int entry;
 	char *current_ev = buffer;
 	char *end_buf = buffer + buflen;
 	struct list_head *ptr;
@@ -1968,7 +1968,6 @@ static inline int prism2_translate_scan(local_info_t *local,
 		bss->included = 0;
 	}
 
-	hostscan = local->last_scan_type == PRISM2_HOSTSCAN;
 	for (entry = 0; entry < local->last_scan_results_count; entry++) {
 		int found = 0;
 		scan = &local->last_scan_results[entry];
-- 
2.25.1

