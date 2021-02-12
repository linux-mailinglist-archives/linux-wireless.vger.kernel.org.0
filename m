Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B359031A852
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 00:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBLX3g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 18:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhBLX31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 18:29:27 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914EFC0613D6
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 15:28:47 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id f2so943195ioq.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ly2pdmyYXxhtuoCSAgENg5OM8ycLhypf9tqgVFI+2u4=;
        b=Quwx0P+JxiRRGABjyX8i1pZUR+H9o5Hl34uy0BwJ7eFj4lvVU96Vykv/nM2Dydp3ML
         G/yDWtiOunz2xOr0YULsBP7PFBcOIt5N6bt2iOF78QXuanm0WPWyH/bvm4HAXhjJWllG
         nDCORLO4+L50RQF0iD9IeL2GARF74lzgtxyaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ly2pdmyYXxhtuoCSAgENg5OM8ycLhypf9tqgVFI+2u4=;
        b=lpltuq65BN5vdikinAXwoBez4VRc60Po7Sm8jc9sYA7HzvatsvvUw44fu6XUm28Scw
         GMgVQa5ku7FZwS665CF19xDttdsN9j7lx3VhI5T5EzCwxA/efldmGtOe7v/6JfvmIjlb
         AiVDZFi4RyPKTrRi8e4kxSC4oBD5SeIm+nrsT9aRcDC1H+pnmcL0Hnh8ueXUk5mBhjJJ
         wZ7rMawxLQRQAEU9QosMqONepfZ8vHOr5rSYTETAW1WrKOCN9xRRkBHNjkNI+Z7uCFCC
         x/HsgLIsy0mfLXsvn875PZTmqNP60O2MG/ewshDRZ9cOTfufO/+BpGaRxMYJM94DWDqV
         +Qmg==
X-Gm-Message-State: AOAM533IikTGLAC2c3OvF3G3e1Di0gEZm1anr8zmtE8kr+dI0wxR5QsM
        30DOwx0hJa4qI5iiwSXrx/fcoQ==
X-Google-Smtp-Source: ABdhPJx5/tVjrSIJi6dtsF0msO8kox5c0tpNk2scRoWwMHOQysCBrTJMjAFHSVV4uHQd7THpyBdRHA==
X-Received: by 2002:a02:9042:: with SMTP id y2mr4808243jaf.94.1613172526761;
        Fri, 12 Feb 2021 15:28:46 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i20sm5180328ilc.2.2021.02.12.15.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 15:28:46 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add lockdep_assert_not_held()
Date:   Fri, 12 Feb 2021 16:28:41 -0700
Message-Id: <cover.1613171185.git.skhan@linuxfoundation.org>
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

Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/

This patch series adds lockdep_assert_not_held() and uses it in the
second patch in ath10k_drain_tx() function.

Shuah Khan (2):
  lockdep: add lockdep_assert_not_held()
  ath10k: detect conf_mutex held ath10k_drain_tx() calls

 drivers/net/wireless/ath/ath10k/mac.c | 2 ++
 include/linux/lockdep.h               | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.27.0

