Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90999D4BE7
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 03:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfJLBod (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 21:44:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34252 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfJLBod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 21:44:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so7102853pfa.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2019 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfZWhCsdhpTvu1J3RYYyWkeimUnBV2W1S5JndhbGX0E=;
        b=OIMF1XQzW6MiZtgScCiYJZn3kGU8cBrahyJ8LCluNQ1LhdqBwMpPNjHGMjNlVnvWwg
         cx/6aYKtjaNkdgjrdd/q9ms7Fs8o9IoGxc812w61DzWTJk+tYxCT6PG+FuVkhNm6d/N7
         bj0rHXYPPsMnZYZpzxx+SO9+zt9O8nDGW2YO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfZWhCsdhpTvu1J3RYYyWkeimUnBV2W1S5JndhbGX0E=;
        b=iNJgeFM34D1G3E0IHY3vZ96rZqSHIhYx4Ur3hyQwy4aLYKqdjl8RiIgP+K79ZwCfRJ
         UtCY0uRUE4fURsr8OwAPEtpBF6T5qrXzMGSDC2GJoyFwPTy/RNEFvl2IG9/GMV4zZZbB
         01KNtmX5FmSA1kDEvmh3nd9c5LWQvbkQ7VUiWFzcVf3X/QNC2Bb4LqIXgBNwLiLAHb82
         WB9AZbfXrfeQYLPAG5O66SRu29nO8ELSvkVJIwRnQyRhsuVpjRijLJNAimCJIHLIyX8j
         z8ZZcY/8VF7HafL59Z05DpX62a3w3AgVhQMW7XXaB6765yWJqhNzDmHV7XDxM+FrwhLu
         U2lw==
X-Gm-Message-State: APjAAAXrnyBm/3ZeBnAYyP950sP/a3dAOe/SHr07efBywgPRjYDZEa7e
        sMp2gswgm7npIpBRHm34p9mf7A4BpO4=
X-Google-Smtp-Source: APXvYqz9lIbaFqHlbM5UNDmxOJNHY26QSGLSmEEsnoOvkmCeFzH2rgz3KFZBZOB4QJwwQ4AGuD9I2w==
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr21846450pjr.132.1570844670636;
        Fri, 11 Oct 2019 18:44:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id q132sm10403835pfq.16.2019.10.11.18.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 18:44:29 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-wireless@vger.kernel.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] rtw88: include interrupt.h for tasklet_struct
Date:   Fri, 11 Oct 2019 18:44:21 -0700
Message-Id: <20191012014421.21592-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Depending on implicit header includes, we might see this compilation
error:

.../main.h:1391:24: error: field has incomplete type 'struct tasklet_struct'
        struct tasklet_struct tx_tasklet;
                              ^

Fixes: 3745d3e550d1 ("rtw88: add driver TX queue support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/realtek/rtw88/main.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index f3eab96dba86..4759d6a0ca6e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -11,6 +11,7 @@
 #include <linux/average.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/interrupt.h>
 
 #include "util.h"
 
-- 
2.23.0.700.g56cf767bdb-goog

