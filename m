Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B883F5800
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 08:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhHXGOd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhHXGOc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 02:14:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384BC061575;
        Mon, 23 Aug 2021 23:13:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l24so15904410qtj.4;
        Mon, 23 Aug 2021 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LYMxCJ4NBxu4794/UcP4AF44CQQd5Z0ZA0goB99hB8Q=;
        b=AMmwa2GbLa99YuQo8zpiaZ3wEM5kwlTCUn9oS++wBiimHnZc+PhfyCEGIJsAf8WfyT
         rCYKiqSXhoFRJgiG5Jh7nE6fF7qLL98RPJ0TsIhEfBNxCP5LrlK5N/vUgMh0v5LZnjMg
         heXzGpmbRlrzdpZuDW1ttqrQWMac9u/Y2ysloLT6Uf8kFWbBqkULvFlxQfuGuQ5vxeep
         0Ni6uyQQC/zmr1QRv5NHS+CH1MFPFpJ6K0xa1jz5fgfFeazPjPH5nDDI/UIYO3l+BLIQ
         y5ePNSfYvIA8WHzisuJiiiFoWeE0k+ogpqIEaDcn0z7lg5Izcm0339AM1IvJz2wEly5C
         4nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LYMxCJ4NBxu4794/UcP4AF44CQQd5Z0ZA0goB99hB8Q=;
        b=uE2gpDqiuA9RLj6yHS3R7LL11b8QmOvJZbQpy2zJRboeP4Mp/sekaFvvsKjkEaug2x
         8A583tpkOBrab8xAD0TvRAFegMuG4r+o9rO5F9WYjMKkEnSRdnLbHR8f5ppRPubuTGlG
         MeYBbApZVd8RYfTMtYhCjvhDwB4wtrMix6PhHZriw2fBpxCFXzAys1txDNyypk7pkekh
         si7aKS17m3h0dVwfcFNCA0umYgtV3A1Viwu5RAiMXVhyp+xLs6fYBmUbLZbKsh8Pnis5
         Sr0aNMb/pQK2nF9B6V0DulP2/fu527JaEhwm8UB6hfDzG0+CLWr5DlXa2FUDfLk1NSTe
         jEBw==
X-Gm-Message-State: AOAM532y1U3lkQore+onRpbjFMn2l4xXvgyAM155lzv2+RoqnGTIQRAl
        XLMvFFaU4pX65yu/+7ho3qM=
X-Google-Smtp-Source: ABdhPJyh/3lx6D3q+Qhwu3WRz2GJgfCb4NapeerV/M39V/W1gHZuNNM/MYIN6K99qq4k10rDsjZazQ==
X-Received: by 2002:a05:622a:9:: with SMTP id x9mr1831730qtw.134.1629785628186;
        Mon, 23 Aug 2021 23:13:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i16sm7757412qtq.52.2021.08.23.23.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 23:13:47 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] include:ssb: fix boolreturn.cocci warnings
Date:   Mon, 23 Aug 2021 23:13:41 -0700
Message-Id: <20210824061341.59255-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

./include/linux/ssb/ssb_driver_extif.h:200:8-9:WARNING: return of 0/1 in
function 'ssb_extif_available' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Generated by: scripts/coccinelle/misc/boolreturn.cocci

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 include/linux/ssb/ssb_driver_extif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ssb/ssb_driver_extif.h b/include/linux/ssb/ssb_driver_extif.h
index 3f8bc97..19253bf 100644
--- a/include/linux/ssb/ssb_driver_extif.h
+++ b/include/linux/ssb/ssb_driver_extif.h
@@ -197,7 +197,7 @@ struct ssb_extif {
 
 static inline bool ssb_extif_available(struct ssb_extif *extif)
 {
-	return 0;
+	return false;
 }
 
 static inline
-- 
1.8.3.1


