Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E20326AA2
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 01:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhB0AIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 19:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhB0AIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 19:08:25 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB0C0617A7
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 16:07:07 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q5so9532476ilc.10
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 16:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDyipOQ/zGVT/OsO6YP4rsNag+Kuytihig+gLKvB9Z8=;
        b=LaYZeGozYDZh8m9Zcr5DguvGQyzVvG1qk6+v/7FntdsL/I3sVG06wPjHdPnjcZrUET
         xY5SJ7hU/xLUPFWSmJiJh2JucnddnVTTkkP5NzwA29W6K1xcDQ1SIXbxGUPeBds0IIBb
         /0QQjolx3Ez78Pr0DP8b/cqMkvnkaddIjzBWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDyipOQ/zGVT/OsO6YP4rsNag+Kuytihig+gLKvB9Z8=;
        b=kXAaSxnYqKL2U+RgOdI/LXIvoIuNWY9XqmxJAbAUUQNSv5z4YUCaVRGb7RuWp7U9AV
         2Tx+vKMQdklq08+OBgCwNJXlXgpb7TPtRcCQNyP7B0f5iYDRIjW9SurPwQ5Orycl3GuS
         p3UhbcVA8TgOopIsP2aA5qcg9jKJV9onYhXyeJf4BA1NM5S6nLHRdwyLeHG+3mzuR9T2
         GAnTylfuBpSRNPVgheKib3hMvX64Qw/MaFffWGD+Gfdo4PIReTVyppE0GY441ALwExMv
         Za4ACqgzoktKjZRzRBksHlm4uZYtsm6y7TsKdsfiHY6z/mEEYrp0KKsylepSuUyDR85k
         4VeQ==
X-Gm-Message-State: AOAM533m60aSgaWqdN9Cmyco7xMYmQ/wxKmGnS9KkDlwphqWWKVcXJsH
        PEYOUMWC8Muj/T3yQZ+M3e1ttQ==
X-Google-Smtp-Source: ABdhPJwzOwoAwB9GujMwkiN8ETBH1uSIX3ovqFMW7TfdMkfk0kJBXFE16/UXQm9KzXnBkIgQeIHe0w==
X-Received: by 2002:a92:cd8a:: with SMTP id r10mr4471884ilb.110.1614384427380;
        Fri, 26 Feb 2021 16:07:07 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w16sm5228805ilh.35.2021.02.26.16.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:07:07 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ath10k: detect conf_mutex held ath10k_drain_tx() calls
Date:   Fri, 26 Feb 2021 17:07:00 -0700
Message-Id: <c9c2cd7b79f5551741c063239013919bf0e3f984.1614383025.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1614383025.git.skhan@linuxfoundation.org>
References: <cover.1614383025.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k_drain_tx() must not be called with conf_mutex held as workers can
use that also. Add call to lockdep_assert_not_held() on conf_mutex to
detect if conf_mutex is held by the caller.

The idea for this patch stemmed from coming across the comment block
above the ath10k_drain_tx() while reviewing the conf_mutex holds during
to debug the conf_mutex lock assert in ath10k_debug_fw_stats_request().

Adding detection to assert on conf_mutex hold will help detect incorrect
usages that could lead to locking problems when async worker routines try
to call this routine.

Link: https://lore.kernel.org/lkml/37a29c383bff2fb1605241ee6c7c9be3784fb3c6.1613171185.git.skhan@linuxfoundation.org/
Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index bb6c5ee43ac0..5ce4f8d038b9 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4727,6 +4727,8 @@ static void ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
 /* Must not be called with conf_mutex held as workers can use that also. */
 void ath10k_drain_tx(struct ath10k *ar)
 {
+	lockdep_assert_not_held(&ar->conf_mutex);
+
 	/* make sure rcu-protected mac80211 tx path itself is drained */
 	synchronize_net();
 
-- 
2.27.0

