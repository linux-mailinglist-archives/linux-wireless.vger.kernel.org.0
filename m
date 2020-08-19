Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E558249715
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHSHY0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgHSHYN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C5C06134B
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so1119751wmi.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaDsSQHVumJ0BUhRTLnjnxnZZONxfiwBrtcxIjkBvh8=;
        b=ziVC/1++Ib88HqfjC3EoHwZGANIpB5jltCZO3nejpCxFeZFY0hEcY9Rt2NkQSgdj4w
         PScZGLSd1YxB9ZlcmgCF6H2voYIxHDd/cvXl3p0RUyBKEHyZvS5kVcOs7ge3aHRXm8k7
         kQe/RrcbOkv1rNeVoVs0Jm6ikRmWm6Gq88oOD1EaPK32bd5MNp6c9EL/5HiGb6/moAqu
         s6PEHHYVzxtJ6ic0sJujck1COtO3EM2AzExF1cilJnPAMr/W40eYKkFsj0ylk2Rfwg4f
         IdlDdqLky+c7ikhRKVfrIoZb1zB0PoDadbiSonR6JWz9mOz9orQIcK/f1FJyLzfm5WPv
         pZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaDsSQHVumJ0BUhRTLnjnxnZZONxfiwBrtcxIjkBvh8=;
        b=bhJAWz3YDkFtqZxufyeygzi4gThPYyYXME1q6JCgM8Lph38KDchV/+OOGrBr68VEmF
         +juSzIVUTxqrlIUg4mvwq11o+pb+vQYtqUNQ7rJ+xd8fZo5kSDHB6nTzpiMVnUJqBskP
         9/XaLHmpOUJGw1Q6dqFAcV5boqwm4fhjU2h8qSSY5dmSxscOdrggBzYTF30JyXsjQf5+
         PGuc5yhZPUVtZmKIAfnoCnq4i5M4Ejy0TUFsrayE3F8kaNA83wMGVpc0TRwOUJ8Ugzm/
         XCTUlzyfkmHq8xmIHARytdixGdV4DUJISrWfP7JJ7Wevd+6ZWHzJ37n8chP1DXGItfdv
         V9OA==
X-Gm-Message-State: AOAM532fKIUKPkB+qB59wtSMYmB7G4g7vX3bdJ4e9RLkqWC9iFb5VuQp
        3a0w8x1u0n1Khs2tZ7+ga4C3Mw==
X-Google-Smtp-Source: ABdhPJzjydxh5RW2AnV46iOp6h8091Mjz/MKc4QW6Xm7U6kw+aXK8DwN977c9dsDaoTBL5nabk1SUA==
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr3452861wmj.74.1597821848883;
        Wed, 19 Aug 2020 00:24:08 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 03/28] wireless: rsi_91x_core: File header should not be kernel-doc
Date:   Wed, 19 Aug 2020 08:23:37 +0100
Message-Id: <20200819072402.3085022-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_core.c:23: warning: Incorrect use of kernel-doc format:  * rsi_determine_min_weight_queue() - This function determines the queue with
 drivers/net/wireless/rsi/rsi_91x_core.c:30: warning: Function parameter or member 'common' not described in 'rsi_determine_min_weight_queue'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_core.c b/drivers/net/wireless/rsi/rsi_91x_core.c
index 3644d7d994638..2d49c5b5eefb4 100644
--- a/drivers/net/wireless/rsi/rsi_91x_core.c
+++ b/drivers/net/wireless/rsi/rsi_91x_core.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
-- 
2.25.1

