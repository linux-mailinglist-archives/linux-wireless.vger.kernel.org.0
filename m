Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC8326681
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhBZRxD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 12:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhBZRw7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 12:52:59 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA2C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 09:52:18 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v8so5098360ilh.12
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dY88CmhEdqi8wt/ahIMuuDlu90hzE7DFVh5FsuKso0s=;
        b=GEozSIwSQMHght7BICfIen1ZuqO1Uu8LnD6oos4DAN9zjNzl+T9of+vQKxslcE2Bjl
         B+55kRiyHRj05v6DxQbsCcajyLUzb5WsFfKr2roMoSzknE6EsZ/a5Yc++mYmoMWZoxEj
         pCBOx2bG1l70JBbuNroc8ck/XWt9UWsOLppl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dY88CmhEdqi8wt/ahIMuuDlu90hzE7DFVh5FsuKso0s=;
        b=MuVmYLR+CyTaU+O8rFkU3ZdTrPa3oL4TWlPDTWY4npIeaWK09bZS4JOXwtw14Cj3Hz
         ZmQS1YhZiuqqMdwp0LN0S3bigij8m8TCbKn79mY3LjzUibHVOFjl47vbooNkdX5HkyAq
         F+Nw9mgpqW8BUsoY1AySWWTG3JUkCmG8CGh0UF11wexFrm5ySEDHCc0jDKtyucJ+xktc
         iyvtrcgZcYmsybUo3EwCV1XsGb8RMuQc6Ogz8wyuTKZxg6M7SDyj3JsKTEJv3rtg9Y60
         IQ3J9v07jpEO7OAn9hUBQ81pmCl1M0BaxN8S7JidIFB9nLKl/1xOmtdVgs7KX6xOZSlJ
         MGdQ==
X-Gm-Message-State: AOAM533cPjNYVntiUpoCCeU5/qMW6grZbYpaogOhMiHdvPHmZ5d/pv+9
        /LICAlQi0B4AZ7ggtWaEcmq33g==
X-Google-Smtp-Source: ABdhPJyk6Fd7CHK3TK6ZvIe6aA/9gQV5HhrgT8cwxOjO3hwk/x87J2J5g+K3jvzjCy1GS3+/u9qmFg==
X-Received: by 2002:a05:6e02:881:: with SMTP id z1mr3371733ils.288.1614361938177;
        Fri, 26 Feb 2021 09:52:18 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y25sm5594060ioa.5.2021.02.26.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:52:17 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add lockdep_assert_not_held()
Date:   Fri, 26 Feb 2021 10:52:12 -0700
Message-Id: <cover.1614355914.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some kernel functions must not be called holding a specific lock. Doing
so could lead to locking problems. Currently these routines call
lock_is_held() to check for lock hold followed by WARN_ON.

Adding a common lockdep interface will help reduce the duplication of this
logic in the rest of the kernel.

Add lockdep_assert_not_held() to be used in these functions to detect
incorrect calls while holding a lock.

lockdep_assert_not_held() provides the opposite functionality of
lockdep_assert_held() which is used to assert calls that require
holding a specific lock.

The need for lockdep_assert_not_held() came up in a discussion on
ath10k patch. ath10k_drain_tx() and i915_vma_pin_ww() are examples
of functions that can use lockdep_assert_not_held().

Link: https://lore.kernel.org/lkml/37a29c383bff2fb1605241ee6c7c9be3784fb3c6.1613171185.git.skhan@linuxfoundation.org/
Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/

This patch series adds lockdep_assert_not_held() and uses it in the
second patch in ath10k_drain_tx() function.

Patch 1 incorporates suggestions from Peter Zijlstra on v1 series
to avoid misfires when lockdep_off() is employed.

Patch 2 Johannes Berg's suggestions as it make it easier to read and
maintain the lock states. These are defines and a enum to avoid changes
to lock_is_held_type() and lockdep_is_held() return types.

Patch 2 is a separate patch because it adds defines to lockdep.h and
kernel/locking/lockdep.c now includes lockdep.h - decided make this
a separate patch just in case issues related to header dependencies
pop up. I can combine Patches 1&2 if that is preferred.

Patch 3 uses the new interface in ath10k_drain_tx() function. Added
Kalle Valo's Ack from v1 for this change.

Tested on the mainline from yesterday.

Shuah Khan (3):
  lockdep: add lockdep_assert_not_held()
  lockdep: add lockdep lock state defines
  ath10k: detect conf_mutex held ath10k_drain_tx() calls

 drivers/net/wireless/ath/ath10k/mac.c |  2 ++
 include/linux/lockdep.h               | 18 +++++++++++++++---
 kernel/locking/lockdep.c              |  6 +++++-
 3 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.27.0

