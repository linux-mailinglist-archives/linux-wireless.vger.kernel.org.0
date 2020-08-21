Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8324CEE2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgHUHTb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgHUHSg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1887C0612FA
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so815116wmj.5
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cwQsdufxnc4pN7fsmYo59Iy4Q4AM2Yb3JhbPSf5qiY=;
        b=R+3m+u3poa/Vn29Opfe2sUchJ/dGM0K1IS/sk+C8FAmSIBMOwznaLCE17D5+pFVYA5
         97ua2d/r2BghhczYKv1pFMA6GOoYm2qakrcio4F2sKDZmVcQWQJdeez0Q9cbfOEom3yF
         +p6nO3goFBp6W4KQPfSOxhOqSduWKHh/GCjBWMSC+eKdLvahJBLcukFQ/ZpP12lsLXdJ
         h7iFDxfCHO3/HFCBKIXeJvEgHocUPdzcdilZAR4u61iZysFIZKHbyiSUcEkkQ8YDtqx1
         D/KRsgM29hpq/eCylS7UMa0NrUWR9EngC8SYC7n8pgY0rQaH0Y2gdg72UbzhP5bB6wqH
         aXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cwQsdufxnc4pN7fsmYo59Iy4Q4AM2Yb3JhbPSf5qiY=;
        b=cPeFwumCi5kLQisjRTVuY3GED8pBLFrkTSB25+2YiQ17puPg/9ITFGDmgG6GlNLTGY
         s/EjWj/0nnBYFcwC0h4iQt1WLrzTrHOKFAsU3OH98UZCryI4hWmlGUMbiIdoX9pH1JuO
         UfPWZI3SAQBNtUNGb6XUeCaP1UBY9acz8qTU80H53V06zROazWSOLoQpONYZBActIY08
         +G7xVBH/EDajcFLg7GHHO0Ph/fqbjQHu6wAlzIo4WY7KU5EVtr+/yVpAMwDT6FDxSCQh
         fAn2bo8OhB5KjFwZXKIh5xsPxGpIZO1QsJkBR8nqyGgI/4qhlgIKkVQExnupCFdF0+of
         sISg==
X-Gm-Message-State: AOAM531YBfyTE9tJ/hqf0bVzdGyb+mP2fLWyqzt4xLxG26Z6g5hbyf9C
        u53/uEVTnMTJKZneV1neu4Iaag==
X-Google-Smtp-Source: ABdhPJxnf3HC2s0HKGnW6c6zYLCClp7mgrSXqP4FJ4Vl76ue4Po6Vwg/9QmaJDgogtgQq16QkVswRA==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr2235144wmt.94.1597994245415;
        Fri, 21 Aug 2020 00:17:25 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 30/32] wireless: ath: wil6210: pmc: Demote a few nonconformant kernel-doc function headers
Date:   Fri, 21 Aug 2020 08:16:42 +0100
Message-Id: <20200821071644.109970-31-lee.jones@linaro.org>
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

 drivers/net/wireless/ath/wil6210/pmc.c:43: warning: Function parameter or member 'wil' not described in 'wil_pmc_alloc'
 drivers/net/wireless/ath/wil6210/pmc.c:43: warning: Function parameter or member 'num_descriptors' not described in 'wil_pmc_alloc'
 drivers/net/wireless/ath/wil6210/pmc.c:43: warning: Function parameter or member 'descriptor_size' not described in 'wil_pmc_alloc'
 drivers/net/wireless/ath/wil6210/pmc.c:229: warning: Function parameter or member 'wil' not described in 'wil_pmc_free'
 drivers/net/wireless/ath/wil6210/pmc.c:229: warning: Function parameter or member 'send_pmc_cmd' not described in 'wil_pmc_free'
 drivers/net/wireless/ath/wil6210/pmc.c:307: warning: Function parameter or member 'wil' not described in 'wil_pmc_last_cmd_status'
 drivers/net/wireless/ath/wil6210/pmc.c:320: warning: Function parameter or member 'filp' not described in 'wil_pmc_read'
 drivers/net/wireless/ath/wil6210/pmc.c:320: warning: Function parameter or member 'buf' not described in 'wil_pmc_read'
 drivers/net/wireless/ath/wil6210/pmc.c:320: warning: Function parameter or member 'count' not described in 'wil_pmc_read'
 drivers/net/wireless/ath/wil6210/pmc.c:320: warning: Function parameter or member 'f_pos' not described in 'wil_pmc_read'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/pmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/pmc.c b/drivers/net/wireless/ath/wil6210/pmc.c
index 9b4ca6b256d26..783107cb6f54a 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.c
+++ b/drivers/net/wireless/ath/wil6210/pmc.c
@@ -29,7 +29,7 @@ void wil_pmc_init(struct wil6210_priv *wil)
 	mutex_init(&wil->pmc.lock);
 }
 
-/**
+/*
  * Allocate the physical ring (p-ring) and the required
  * number of descriptors of required size.
  * Initialize the descriptors as required by pmc dma.
@@ -221,7 +221,7 @@ void wil_pmc_alloc(struct wil6210_priv *wil,
 	mutex_unlock(&pmc->lock);
 }
 
-/**
+/*
  * Traverse the p-ring and release all buffers.
  * At the end release the p-ring memory
  */
@@ -299,7 +299,7 @@ void wil_pmc_free(struct wil6210_priv *wil, int send_pmc_cmd)
 	mutex_unlock(&pmc->lock);
 }
 
-/**
+/*
  * Status of the last operation requested via debugfs: alloc/free/read.
  * 0 - success or negative errno
  */
@@ -311,7 +311,7 @@ int wil_pmc_last_cmd_status(struct wil6210_priv *wil)
 	return wil->pmc.last_cmd_status;
 }
 
-/**
+/*
  * Read from required position up to the end of current descriptor,
  * depends on descriptor size configured during alloc request.
  */
-- 
2.25.1

