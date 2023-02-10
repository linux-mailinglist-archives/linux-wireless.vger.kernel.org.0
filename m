Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D669242D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Feb 2023 18:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBJRMV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Feb 2023 12:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjBJRMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Feb 2023 12:12:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0261D0B
        for <linux-wireless@vger.kernel.org>; Fri, 10 Feb 2023 09:11:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id da9so5199043edb.12
        for <linux-wireless@vger.kernel.org>; Fri, 10 Feb 2023 09:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01NfPBnPTcvZofX3UEWmR8fA+Ai8KYWuLDueruZXWao=;
        b=aZXxHQTpXPIqpzeMcLiUYkPx9zXaWxH7pjvJALwqP4kP7d/8/RBDA1M8qku98a1QBo
         nT/iiLEEzHWgOjrrOGXf8m/6bELjTLDV7FCae3+KdhCmTNuMgE/v5GZGkAvCwxW+X8GP
         HrwmmmsL2f8JHlaET+ao5Q3NqSzapK70QK3HPmVd+lGu2UPvLUnRofaBjj7kFEomaOOR
         UARF3aVuRKxBgH9r0Qujdqsb8ADwKT3rVvXq8QqxMsbMMet2A6Yr0Ul2IZGLrGc2ujnT
         j4GpsqAajObStKRan+dMoa9mXJZXmf94PlFct/+39G2hSMq7vuMF+PykXyEMWTGib6SZ
         Kolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01NfPBnPTcvZofX3UEWmR8fA+Ai8KYWuLDueruZXWao=;
        b=LBFwAGF8RFrh6J/AXjEghtRamj7i5uvuJ48xdPnYsDPwFoq5iByT582PO7cBYxm8Wv
         vOWNL+l7rc+E0PxLMznIJKGxvVvPX0szvt/mGuNhPIAtI6I5VW1lriLS8wPfjtnomSAV
         gH6Gh0QNDDIbS96on7nCP9VN3jy2FF/YKaFY3YC0zqyHioROlxWvVPHkcenidsTMP1bL
         jxyJ3kLtDr41qoHM8nJns7fGC6BAGOvAuC06+RJd56q41ebgVSj4YNkR8Styb9MRfNyv
         JOZyj84COsky80Prozurjk2w8Qyv7Vu/L6KRiNO4ZnPcgMjPaxSjw8QwTVsfLSysbVdD
         qkxw==
X-Gm-Message-State: AO0yUKVK4KI03R3GLROX2cmhtEUwJVb7qc41iysKcwqWTp7gdmtLSIEX
        I/vbClwT/YTc8rkP1W4YSSKRz780E01Thg==
X-Google-Smtp-Source: AK7set969MNbnlQds2HJCPcn1TD1RP0wULyuTDUGGwDJf4yr+wyWs/UAMnvx69Yb9Unk7rkZWnxGag==
X-Received: by 2002:a50:d656:0:b0:4ab:4641:55fb with SMTP id c22-20020a50d656000000b004ab464155fbmr3473266edj.42.1676049102141;
        Fri, 10 Feb 2023 09:11:42 -0800 (PST)
Received: from e850.lan ([62.141.192.106])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906044d00b0088eb55ed9cbsm2608431eja.187.2023.02.10.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:11:41 -0800 (PST)
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo@kernel.org, nbd@nbd.name,
        Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH] mt7915: handle FIF_MCAST_ACTION
Date:   Fri, 10 Feb 2023 18:11:25 +0100
Message-Id: <20230210171125.2996742-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow to receive Public Action frames when
DPP_LISEN is in progress.

Before we fail for STA interface.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0511d6a505b0..ff678839836e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -542,6 +542,10 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 			       MT_WF_RFCR_DROP_A3_MAC |
 			       MT_WF_RFCR_DROP_A3_BSSID);
 
+	MT76_FILTER(MCAST_ACTION, MT_WF_RFCR_DROP_OTHER_TIM |
+				  MT_WF_RFCR_DROP_A3_MAC |
+				  MT_WF_RFCR_DROP_A3_BSSID);
+
 	MT76_FILTER(FCSFAIL, MT_WF_RFCR_DROP_FCSFAIL);
 
 	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
-- 
2.25.1

