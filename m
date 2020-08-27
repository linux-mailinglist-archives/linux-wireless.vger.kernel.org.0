Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5B253F59
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgH0HhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 03:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgH0HhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 03:37:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A0C06121A
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 00:37:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o21so4202950wmc.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urR5WKC0YHrLgprPWWXo12lMVDtV/KRxTWx7J20eMag=;
        b=a0C34Bju6/PtF2HVbGdps+jvjmkH5VX28IIWmXqMUfuYbVudhp2bk8xBwXR8uNKw+o
         E3nFOa10HXBMiVQL1h8zH7EbQtL479qzCL4DwybQfDN2J5VlSTjXBvkkAmD3xryt8vzz
         LynWRE8fIQ0ilNTH7cX9yWUg4A0Yg5fiUbZxeO3DApzgKjBEknECJMkYtso5J8XFoUJK
         6yEua+0LQhd6Chdj/b+NSRM1j2Enmb49/qh158+LRO5YLgiwrO8Jhj6eZcNL9GtMUdOl
         GgcNownqeuRxt4Spk7v03rpkNT7FusZRG/Oms4aC1D7SuT3wr663sfEVdiLo2F7Tq8NX
         Bs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urR5WKC0YHrLgprPWWXo12lMVDtV/KRxTWx7J20eMag=;
        b=ET2JXX45PemeJPacVzATaRgxE1Lg/I4+MC3q5AqDdeIB6AiOa1p78ZLpyDMZxaujRR
         9pVHNAFEAMHKdQ/zA24IENFusabajNj+H+Uqw8eB35dXSiQZjB4xOI1gP+Ot2GFT2SfW
         X7Cz1GFN3i8L4BqeSc8EJR5AwZvJ2do4lKIFmdgAmr/+/FbQsIEq4a1aos557rToC/0K
         NtY8jXxqKJwmnn5zphCDYq5bKhastfaSo+1yMZJiqonpi+awjne3ERONOnfXsW3J5WFR
         jwJ6xO7VdsV1Oc20CInaJ82EnWqBgznDha84gZjAukEVWhc3oLdeRaIBiquv8dztndrE
         zKIg==
X-Gm-Message-State: AOAM533miF0yfcmMyS5LBURPjkeNMEZN4rrxswaMioAQO4Zt7gTQV/pn
        dq3S3PsNPaxBiiYvKKk5IzFXvg==
X-Google-Smtp-Source: ABdhPJycbiZ1USeLkj9x9uqe4lASaNBJMhV+HNneVNbg3x1BAmNoMIpWWjBG8q3tw6SwjrZIdqJysw==
X-Received: by 2002:a1c:1d17:: with SMTP id d23mr9716187wmd.187.1598513840622;
        Thu, 27 Aug 2020 00:37:20 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id n24sm3140608wmi.36.2020.08.27.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:37:20 -0700 (PDT)
Date:   Thu, 27 Aug 2020 08:37:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        wil6210@qti.qualcomm.com
Subject: [PATCH v2 30/32] wireless: ath: wil6210: pmc: Demote a few
 nonconformant kernel-doc function headers
Message-ID: <20200827073718.GV3248864@dell>
References: <20200821071644.109970-1-lee.jones@linaro.org>
 <20200821071644.109970-31-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821071644.109970-31-lee.jones@linaro.org>
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
 drivers/net/wireless/ath/wil6210/pmc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/pmc.c b/drivers/net/wireless/ath/wil6210/pmc.c
index 9b4ca6b256d26..a2f7b4c1da48d 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.c
+++ b/drivers/net/wireless/ath/wil6210/pmc.c
@@ -29,8 +29,7 @@ void wil_pmc_init(struct wil6210_priv *wil)
 	mutex_init(&wil->pmc.lock);
 }
 
-/**
- * Allocate the physical ring (p-ring) and the required
+/* Allocate the physical ring (p-ring) and the required
  * number of descriptors of required size.
  * Initialize the descriptors as required by pmc dma.
  * The descriptors' buffers dwords are initialized to hold
@@ -221,8 +220,7 @@ void wil_pmc_alloc(struct wil6210_priv *wil,
 	mutex_unlock(&pmc->lock);
 }
 
-/**
- * Traverse the p-ring and release all buffers.
+/* Traverse the p-ring and release all buffers.
  * At the end release the p-ring memory
  */
 void wil_pmc_free(struct wil6210_priv *wil, int send_pmc_cmd)
@@ -299,8 +297,7 @@ void wil_pmc_free(struct wil6210_priv *wil, int send_pmc_cmd)
 	mutex_unlock(&pmc->lock);
 }
 
-/**
- * Status of the last operation requested via debugfs: alloc/free/read.
+/* Status of the last operation requested via debugfs: alloc/free/read.
  * 0 - success or negative errno
  */
 int wil_pmc_last_cmd_status(struct wil6210_priv *wil)
@@ -311,8 +308,7 @@ int wil_pmc_last_cmd_status(struct wil6210_priv *wil)
 	return wil->pmc.last_cmd_status;
 }
 
-/**
- * Read from required position up to the end of current descriptor,
+/* Read from required position up to the end of current descriptor,
  * depends on descriptor size configured during alloc request.
  */
 ssize_t wil_pmc_read(struct file *filp, char __user *buf, size_t count,
-- 
2.25.1
