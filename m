Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A547D4410
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 02:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjJXAc5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 20:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjJXAc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 20:32:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E2193
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 17:32:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-565e54cb93aso2278807a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 17:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1698107574; x=1698712374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CImcFEtY4x/TIfmFHho06UrL0q3CICIwq81NG9W9NcY=;
        b=R+bvmrd6OXR8oLT2xYgcbM5+C9nn9kiUiowgQjl/OtJKV9KlM4vBezIJgS9wdd2ako
         2AEpyU/B2rgepdJVXAvq1ntXHbG1ykcAgKEdpFUWVxb2ZPofNhhPV/6ZcjQris3CGlRG
         rHZojz+cfd/wxuswCHCbKNzdL0bpoM/C7+OZf6txMQnxpeR/KMCHHh7gLDGUrSV+hVu7
         4YA6VdTOBuwWPFJ19B196O2wjCxcf/syTJ5skhupiofKbKO5NQ7T6rzvTl37+Ui2NE3h
         ZFZg54NbhSBEW0RFx/0eN6b9+S97SZQyQk7N+x/azD7QNtRjxabOysPg8oFEzTigi1Wy
         CzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698107574; x=1698712374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CImcFEtY4x/TIfmFHho06UrL0q3CICIwq81NG9W9NcY=;
        b=lsYPQRM5VgAoxgI/Ebnh6eVI1nVRX5JZOdvkZ7y//Y3H34XtIWVEpLT5cQSuUKHQAz
         59hqBg8zYFvHrkZRRUXGOYCFlhDsZK48v19eeRQ+NOJHwWmlhw/9goDipMrAfjjyzEYo
         a8pu6v9AgPe995m+QCgxkQggRzqOgiUCaizIcjNEni8UIVsFkvMQ9xSQHO0t9x1zHEBp
         IjnY7GQwXIojQ7Qq3HXqVThn265JRHn4dSszMa5+pYwCyh1/92Cr8PrFBSWHCYKgVJxW
         n2jM/M4Rw7B9rVyxhAh17IKCq3rSsIo6bqx6N8Ey6gY7tFBa7+2o7Q1sWd2SnWxxM7Rl
         tXQA==
X-Gm-Message-State: AOJu0Yw3FHE+T3F+9nFmLs7uO9Ud9pNBnVMIsfgzZjm6FTRKyaPR0Ri8
        UJWNEY3AcbprLbG4E3MxIgvLnPcsjNgPF95+Tymh+2zr
X-Google-Smtp-Source: AGHT+IHkphF8zwzcr+TjXul6GJjuWhJXFyF1PZi2K3wLDWK+4FtYWfyg764pU0k5/5fFL+Hy3pFOLw==
X-Received: by 2002:a05:6a20:7d93:b0:17b:2f9:4146 with SMTP id v19-20020a056a207d9300b0017b02f94146mr1451905pzj.43.1698107573864;
        Mon, 23 Oct 2023 17:32:53 -0700 (PDT)
Received: from liam-xps.sydney.mm.lcl (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.googlemail.com with ESMTPSA id e11-20020aa798cb000000b006934a1c69f8sm6695203pfm.24.2023.10.23.17.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:32:53 -0700 (PDT)
From:   Liam Kearney <liam.kearney@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     Liam Kearney <liam.kearney@morsemicro.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ieee80211: fix PV1 frame control field name
Date:   Tue, 24 Oct 2023 11:32:28 +1100
Message-Id: <20231024003228.1711193-1-liam.kearney@morsemicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update PV1 frame control field TODS to FROMDS to match 802.11 standard

Signed-off-by: Liam Kearney <liam.kearney@morsemicro.com>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index bd2f6e19c357..ca46147e6a2d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -176,7 +176,7 @@
 #define IEEE80211_PV1_FCTL_VERS		0x0003
 #define IEEE80211_PV1_FCTL_FTYPE	0x001c
 #define IEEE80211_PV1_FCTL_STYPE	0x00e0
-#define IEEE80211_PV1_FCTL_TODS		0x0100
+#define IEEE80211_PV1_FCTL_FROMDS		0x0100
 #define IEEE80211_PV1_FCTL_MOREFRAGS	0x0200
 #define IEEE80211_PV1_FCTL_PM		0x0400
 #define IEEE80211_PV1_FCTL_MOREDATA	0x0800
-- 
2.39.2

