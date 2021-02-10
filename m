Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F33315B98
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 01:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhBJAsg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 19:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhBJApw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 19:45:52 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9105EC06121C
        for <linux-wireless@vger.kernel.org>; Tue,  9 Feb 2021 16:42:37 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id h6so200391oie.5
        for <linux-wireless@vger.kernel.org>; Tue, 09 Feb 2021 16:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVSZTT1h7rg/Bji9PEZgBTdOFc1Uv4h/Ji7bDyaOHUI=;
        b=b2vrzFxHfxSWjiku00Fz3a6ecUxKY3t2TA0ZzSD7MG6YCM8ajrR7O2gxN7GLKC0rrC
         FVbuFVlPE0yeTOQlclSOdWDAZdh2akjPV49OJuSExxHxugqDN4N8XLofPBw9tHtZ205Y
         S3uPZv6Ya+G7CILfj3nxGLLgYE/xenGdXkgrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVSZTT1h7rg/Bji9PEZgBTdOFc1Uv4h/Ji7bDyaOHUI=;
        b=LmrGrOAsht7N9Gi+PItUIOrz9fzfrETeYJDGuQYHUNUKILvYVCK8cLQG4U7GwAbSEx
         iYnDUvmT5Oy1LYrK/EOkKQCeVcYdRXht9/k/SZ8QE5GuaqVP/xFtxRW5n/Dg7l5t2dAa
         dupMcNGoO/d8HA6Jdjskm05vNqdqzc9M9SomSG4NWqW7cRFIICUlT9UsImBeVxUVcGAD
         /ZG5cbo+ZrLQohn4i5Q7vm5cBqZBtfgaasnKFXBAWyNAj8BcefP3SDR85Wj/mqIARVeS
         PDSYe1/4EWtsLR1NJmbPjRTHEeadLBxxNOage41OFt+tArlAGLaDA5uSC1eo1Nx4WXZf
         GyAw==
X-Gm-Message-State: AOAM531eeEYE7MLWvbm46cSMCKKD2PJsjCk8SmwuGr9hTwvMgZIyUyZE
        CrR1td6gyIBS9A6f09KaQlA7dw==
X-Google-Smtp-Source: ABdhPJzy8O/u6gQ1mql56Asz4MrIdqm2ujZLVWA9B95vdv7w6LIFLxn2QJpAEovPx21tylnZEk7yJA==
X-Received: by 2002:aca:8d0:: with SMTP id 199mr294690oii.94.1612917756994;
        Tue, 09 Feb 2021 16:42:36 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s123sm103060oos.3.2021.02.09.16.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:42:36 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ath10k: detect conf_mutex held ath10k_drain_tx() calls
Date:   Tue,  9 Feb 2021 17:42:25 -0700
Message-Id: <a980abfb143f5240375f3f1046f0f26971c695e6.1612915444.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1612915444.git.skhan@linuxfoundation.org>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k_drain_tx() must not be called with conf_mutex held as workers can
use that also. Add check to detect conf_mutex held calls.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 53f92945006f..3545ce7dce0a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4566,6 +4566,7 @@ static void ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
 /* Must not be called with conf_mutex held as workers can use that also. */
 void ath10k_drain_tx(struct ath10k *ar)
 {
+	WARN_ON(lockdep_is_held(&ar->conf_mutex));
 	/* make sure rcu-protected mac80211 tx path itself is drained */
 	synchronize_net();
 
-- 
2.27.0

