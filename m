Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156F32572DC
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 06:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgHaEel (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 00:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaEek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 00:34:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A71CC061573
        for <linux-wireless@vger.kernel.org>; Sun, 30 Aug 2020 21:34:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so3634528pgl.2
        for <linux-wireless@vger.kernel.org>; Sun, 30 Aug 2020 21:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4Qw+yaV6/XZoNqOusJEyCw5B5YCb/AHTh+H2ex+B/w=;
        b=h7+rKEKnJ5exA94EwMYHCrdqZmiOaEHcgRDboO9J3chWiFZpaZYT0SMKgDtJC8aSnR
         v4+Aedj4j7MNVgPhpt3udtWL/L73JcHkMCtPxZbSFDUhfBhFJw0vGAtA02boLnkZT4Mm
         8ZeJ1gaH8SEQ3SCixqXpD5TaqVfRuiJsG75z4HPTFVr39vsR4vOtFj1WhjUVg/NkOEnt
         cJwWUJJeppda3SgGjo2n/CfNSJdPVQxkGM7vdrhe01Z55m6KHeCLdDSdbnpg4uUo7Cwa
         u8q7I6jcddIWYEF6vGj7uLZxzRreesMfUq8O59WNTm6UDEtTrT8Ny5j84TAvyQnOrA96
         Xn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4Qw+yaV6/XZoNqOusJEyCw5B5YCb/AHTh+H2ex+B/w=;
        b=U5PCkPff/kCyTaCf+45FRDBtWdaECvO20NSWhX5vgxpKGGTN1a6J+hBMni9QxK9ngc
         ioaE5LvoThuRHxRV+oz5qEsAw2ejBoVeZFQ9L7SJF0i2gR9PV1XsR6AOsVzjKYb81Ot2
         0o0b48bbJMPV4VKgS04XdWPiQVeb/KM0znFwCc/lG19QnpSfbDHcjzOdfOdpT7loxLRO
         oD0igEr00IJDVW+Bc0cRBuadxTvTZOumm+4qeqgdgdFabas54pn5qQ1sbnFoOr3+SWNx
         MmHAvvhf9Hu5qOw8J9TkpFGGOELC8hYv9NvXmjlYsc4CNDI6k55pMgl4nP848QA/NxrV
         YbjA==
X-Gm-Message-State: AOAM532oKGBMgXitrM7BuLgsbhA93cPgpWRtSQK3h9C8AwIFKsoWGHGP
        q1bpcOdjVRLLMgGLfODe7J0=
X-Google-Smtp-Source: ABdhPJxwzQKdIuYB+xty1tp/0GzEcvXZZMpn1O7Y3R7wdvPr20+aHaGI9+zGDSkmpze9I2UvaIFRUg==
X-Received: by 2002:aa7:982d:: with SMTP id q13mr5881052pfl.30.1598848479624;
        Sun, 30 Aug 2020 21:34:39 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.143])
        by smtp.gmail.com with ESMTPSA id e13sm2390010pfl.44.2020.08.30.21.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 21:34:39 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     kvalo@codeaurora.org
Cc:     dsd@gentoo.org, kune@deine-taler.de, davem@davemloft.net,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] wireless: zd1211rw: fix build warning
Date:   Mon, 31 Aug 2020 10:04:25 +0530
Message-Id: <20200831043425.281538-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 Tasklet conversion patches intoruced a build warning
in init_usb_rx(), this patch fixes the same.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index 8b3d248ba..71ec3d423 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1178,8 +1178,9 @@ static inline void init_usb_rx(struct zd_usb *usb)
 	}
 	ZD_ASSERT(rx->fragment_length == 0);
 	INIT_DELAYED_WORK(&rx->idle_work, zd_rx_idle_timer_handler);
-	rx->reset_timer_tasklet.func = (void (*)(unsigned long))
+	rx->reset_timer_tasklet.func = (void (*))
 					zd_usb_reset_rx_idle_timer_tasklet;
+	rx->reset_timer_tasklet.data = (unsigned long)&rx->reset_timer_tasklet;
 }
 
 static inline void init_usb_tx(struct zd_usb *usb)
-- 
2.25.1

