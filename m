Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52937497B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 22:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhEEUaC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 16:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhEEUaB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 16:30:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90DDC061574
        for <linux-wireless@vger.kernel.org>; Wed,  5 May 2021 13:29:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c21so2614663pgg.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 May 2021 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnOnXYlWQVQ/48O6Xp4pLMx8uey0QJZqz7prGw8IU0I=;
        b=NdRsPw/lJJ4AudrLS+tIIGQrtHQweV/wjml3AIJT154GKFvNNfIdPhvYUho9Z8Vv/r
         ERiBOEr8jR/TuiW7yhMbNmXJ7LCLFT8ohVQBLHPEFIssB0G1Gzsq/YIPuUioiDCd3aIH
         lGQzzPaB8P79IxBoX1aBNJQwX6I5z2UWdcoX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnOnXYlWQVQ/48O6Xp4pLMx8uey0QJZqz7prGw8IU0I=;
        b=lCOhyCkYWnrX8/C8SGXqAUP50vcOlswLl+KsbMxeomrwwEugyihZMs4AfwYowLEkR/
         ya9pTcy2Wp4k1jsrC4fXPsMHXXquoa6Dtu9bIKeOKWj7Nm/u3x9MLqwHZWsq1Jd37w+j
         11PLX9jo7ZTcYGsCq8HPDQA823HlWEdthv+qJyMpL1cJNCwGByq+eenzicW2sv2klM+T
         ES7oobPLMBy8drASwfSb98fnkhYndKia17JXYwb4YG2/Pu2BCAhT0gD8YLU/xlORPt7t
         lr9j9/Hsfg4/6j5UnrC77noo/nF5NeToYR5cG3+ZvGNKWmmy2mjy0XJ1P68RIHGRYTE9
         PrnQ==
X-Gm-Message-State: AOAM533ACF5MwQmPHS8jrMPEYr068T5xNe/dgMVcyDxCii4LtI1/OUQD
        yao3I2hVNCGqW8VmAwe2hFPwXg==
X-Google-Smtp-Source: ABdhPJy1CKKT05qEe7l7Oluawo5yFjZuQqggR9VtzYj5bvhv8F1WLVgg24e/lxUpj2v5tHuVsunUiA==
X-Received: by 2002:a05:6a00:2b5:b029:28e:9c4b:b8b4 with SMTP id q21-20020a056a0002b5b029028e9c4bb8b4mr606236pfs.22.1620246544250;
        Wed, 05 May 2021 13:29:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:2dd5:7bcf:c8e4:5147])
        by smtp.gmail.com with ESMTPSA id b7sm104003pfi.42.2021.05.05.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:29:03 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mac80211: correct ieee80211_iterate_active_interfaces_mtx() locking comments
Date:   Wed,  5 May 2021 13:28:29 -0700
Message-Id: <20210505202829.1039400-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit a05829a7222e ("cfg80211: avoid holding the RTNL when calling the
driver") dropped usage of RTNL here and replaced it with
hw->wiphy->mutex. But we didn't update the comments.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 445b66c6eb7e..e7c59b4e2c44 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5537,7 +5537,7 @@ void ieee80211_iterate_active_interfaces_atomic(struct ieee80211_hw *hw,
  *
  * This function iterates over the interfaces associated with a given
  * hardware that are currently active and calls the callback for them.
- * This version can only be used while holding the RTNL.
+ * This version can only be used while holding the wiphy mutex.
  *
  * @hw: the hardware struct of which the interfaces should be iterated over
  * @iter_flags: iteration flags, see &enum ieee80211_interface_iteration_flags
-- 
2.31.1.527.g47e6f16901-goog

