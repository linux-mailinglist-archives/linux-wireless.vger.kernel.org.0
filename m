Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349BD32668B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBZRyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 12:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhBZRxm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 12:53:42 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3117FC061794
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 09:52:21 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id n14so10499273iog.3
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yytI7x7nMwQqYfkH8zJk8MWsbajZm7+7KB4c/JWojUI=;
        b=AFIgbIR9M1LUoj6H3z378i+R7QUdBO3CwFoWO44Dx08yOT0wGXel220fIR+hJZ9bC5
         qhTaPNWmINhWlJDPNGmD3tn2Dy+m2DB4wl7DnYLCKPjmGJBk4X+F7WdaV00KhPSZeVOW
         4OXK8iZYoHlSc9Z+QLSm0BfI+yujpjqT4QNJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yytI7x7nMwQqYfkH8zJk8MWsbajZm7+7KB4c/JWojUI=;
        b=V0krsO5qHRtYLEAD2pWukj6+q/tV8uW2Yccz+QfeNhyAImyWwaw7zHmQGEE43jKlL0
         ABhPdM+bwuvJNtlR8kqiE7+jK9ceCJ3Xf+3D/m6vhzWB8J5P4wpNDKQKBR0aPWfZ2I7y
         pYNl3spwxy8imknh+LtCO7QNT6l8sigOfMY2faiI1jpkWMeUOTcQNfpRvI0W/SYQTix3
         EHcsxmZuVr3fw2j8otOc69X5x9zx67CEc7zyKICbgbJFh8oYs7QZ2rGORYWx3od1TSmc
         IL2ufFgDDMI5viASkCJe+2PbQPG1iSZZUbZnUtSEcDg9ZmEiJQZNMeImSyLvI3jaeUQn
         4hig==
X-Gm-Message-State: AOAM532aCeky0g1jtL9PtTZHZtz6ZyhgP5cNQJ9FaY38tajMbjtdxfId
        OQzAwYs2Jfx1FNR7PqhQcp+ilA==
X-Google-Smtp-Source: ABdhPJzDvP35cqoe+MlNhyNJMg/N0vt8re7YhfzdHlkeva41movmV4gDLh1tDN7Jsfz/AJTW9RmZeA==
X-Received: by 2002:a5e:8f0a:: with SMTP id c10mr3842450iok.192.1614361940631;
        Fri, 26 Feb 2021 09:52:20 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y25sm5594060ioa.5.2021.02.26.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:52:20 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ath10k: detect conf_mutex held ath10k_drain_tx() calls
Date:   Fri, 26 Feb 2021 10:52:15 -0700
Message-Id: <38eef822d97917db50068eb65eb71ae3b83eb43e.1614355914.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1614355914.git.skhan@linuxfoundation.org>
References: <cover.1614355914.git.skhan@linuxfoundation.org>
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
index 7d98250380ec..a595ff4f0843 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4567,6 +4567,8 @@ static void ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
 /* Must not be called with conf_mutex held as workers can use that also. */
 void ath10k_drain_tx(struct ath10k *ar)
 {
+	lockdep_assert_not_held(&ar->conf_mutex);
+
 	/* make sure rcu-protected mac80211 tx path itself is drained */
 	synchronize_net();
 
-- 
2.27.0

