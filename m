Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BDA24CF22
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgHUHWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgHUHRE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC3EC06134F
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so1003977wrm.6
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePe6weLeORKQn1kjGoGA+hXrLyzhTEFalZVJmLc5XBY=;
        b=GApq0ETO5ZH0/lqVZB+qyfEb/xueGwiJDvz7ILu3q2Fk+VYDnrX5Ro8ZOXabhujwzQ
         P7o6wiNPlc9WW9fzFVz+75rs5Lu9s1hLERwVbh9s9IFfYkZX+EBxZVhEZAIwpYXE3Gi/
         adVSHUfsRhW9pIzkQKhGqoq1EJYchyBbjt0kI5Yqe6X/Xw2KL+vxevPlEo2arezHIiBs
         D3ObLaz9i3MzIqtP7aQ3pEQvAtddrmzjj+mqrgn4TLUX35pKjQ8PToJvskWzWcs/P05k
         CG/jQdiaI2AE/dRDdgPEDxq564aK9j3eQA6hNbV/gfXeH05l70LInADc+Dr00o6gYdwi
         Swag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePe6weLeORKQn1kjGoGA+hXrLyzhTEFalZVJmLc5XBY=;
        b=JcQcSWUf5NIQxjOiBk3CO+VznOXWd/kgosbJJAeErztE+wVclijbTVQh3fz+hU+UAC
         qxam6EswQ0Cm4luYe4dcXq3LtYtaThU4yEOfnHn6G3q0koAyYaqsnTqKYzCTu8I1zY1E
         noaBCtwFIwwJaf5rQElchSRTgAEJud+uUMUz1a9PHnB5fSMZbuCjBfdalVgYU8o6KJ1l
         Cs2ULrkvFcUzsCI/8qT/5l8D6Y+jd7bVjiEUbJTqzUEKzGyXUg1v2fnOtiUw1n01UvVv
         MEM4DOmiIXQEabetk+ynGVSaVshpSNss8aaiopouE7LuP4rQlVziS6ALk21fxDXqlVsP
         L1nw==
X-Gm-Message-State: AOAM5309MTPc5lo7SJ2401wqiZ7MPcLAs4GGKbBksE9HI1xYxqXFdNW3
        NN3lzm305w5PSGGW8xu7kkpW2w==
X-Google-Smtp-Source: ABdhPJxoFebcmcu4cK83ANrkpCcLdWEdbrXuuGl+2NTHdEzpvzoiiO6Qd5WRSwT/+N7tZ6OHsMbjDg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr1375083wrm.113.1597994221040;
        Fri, 21 Aug 2020 00:17:01 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 10/32] wireless: rsi: rsi_91x_ps: Source file headers do not make good kernel-doc candidates
Date:   Fri, 21 Aug 2020 08:16:22 +0100
Message-Id: <20200821071644.109970-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_ps.c:26: warning: Function parameter or member 'state' not described in 'str_psstate'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_ps.c b/drivers/net/wireless/rsi/rsi_91x_ps.c
index 01472fac8b9ae..fdaa5a7260dd8 100644
--- a/drivers/net/wireless/rsi/rsi_91x_ps.c
+++ b/drivers/net/wireless/rsi/rsi_91x_ps.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
-- 
2.25.1

