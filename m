Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D968AC39
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Feb 2023 21:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjBDUJ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Feb 2023 15:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBDUJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Feb 2023 15:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC224C8D
        for <linux-wireless@vger.kernel.org>; Sat,  4 Feb 2023 12:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675541352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/WaCBskwLyuFZAeD+BROUlg6POGlmNuR7JtD/rOXxGw=;
        b=UlV+z+UGvFNxHNAl2WV1vUhn7lLe0WiLg4Jp23v5Yxrz/VDNmq2WErTkNvxfxnU0LKq6V+
        EFT8cKuFEqPZpW0AgLKD25zAUkKjdrJMV/GSumEXZK/nSA+N2v6lY7wvnv3sUC4+0K4FoB
        rR37w8KFh7hqtjlZoERcGfP8OGbNfe4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-h0ijN0vSMiKTJRtL6WtJeA-1; Sat, 04 Feb 2023 15:09:08 -0500
X-MC-Unique: h0ijN0vSMiKTJRtL6WtJeA-1
Received: by mail-qv1-f69.google.com with SMTP id px22-20020a056214051600b00537657b0449so4444432qvb.23
        for <linux-wireless@vger.kernel.org>; Sat, 04 Feb 2023 12:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WaCBskwLyuFZAeD+BROUlg6POGlmNuR7JtD/rOXxGw=;
        b=Umn8wVqJJJuKV1TVkrsIDyYOnnSd8cFavC/7Olvy7VA5bwEw7JTy0nhu9i4SGrjxIR
         9WRYjWVON+O2jjvUMzzfBnVDHy3j1uWZDaVqzfMRvYrcmk+8ynSQgvX0XU8z/cQSrDfF
         3hOYrtybVL6fbPSz4L9EVbqYytgR1SIhdavoSkWmt6S295O37F79zgtCVOc3db+G3eAD
         XQL7jUZHIpcQuPMhQUTryKUSKhQ5gIuNYQA/GWS2O/OtnsTQ/0LdKzsoZ1hOFwx5HsYC
         bDmY68/PSlsokqegWqj6TJZgKUfAnf0m/tmVJ2kxvNn8sQ1En2Xox0dF+l5K6Wvou+69
         ebuQ==
X-Gm-Message-State: AO0yUKW1oQkdWX12RX4F/yOao6hndDab8cEhMb12yU5hHfCp7OT5/54c
        C/YNDepPoUujAZVKtKFn5sucnRI7T4SJVVxji9WWb7CwlfEpeBgHGxfQq1Tadu25JOOf8YDi0Ta
        dBtCiUSRMpnxDAifLuzC3d/Ax15U=
X-Received: by 2002:ac8:5756:0:b0:3ba:19e5:3e45 with SMTP id 22-20020ac85756000000b003ba19e53e45mr3388193qtx.13.1675541347777;
        Sat, 04 Feb 2023 12:09:07 -0800 (PST)
X-Google-Smtp-Source: AK7set8A94jVY4UFhKq+MGGkEfrBwfqPSgkhmWjhq+AOIShxahEwEUVaVYuzs1h1UCXCT1EJocHikg==
X-Received: by 2002:ac8:5756:0:b0:3ba:19e5:3e45 with SMTP id 22-20020ac85756000000b003ba19e53e45mr3388168qtx.13.1675541347551;
        Sat, 04 Feb 2023 12:09:07 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v11-20020a05620a122b00b0070648cf78bdsm4230548qkj.54.2023.02.04.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 12:09:07 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     kune@deine-taler.de, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: wireless: zd1211rw: remove redundant decls
Date:   Sat,  4 Feb 2023 12:09:02 -0800
Message-Id: <20230204200902.1709343-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

building with W=2 has these errors
redundant redeclaration of ‘zd_rf_generic_patch_6m’ [-Werror=redundant-decls]
redundant redeclaration of ‘zd_rf_patch_6m_band_edge’ [-Werror=redundant-decls]

Remove the second decls.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/zydas/zd1211rw/zd_rf.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_rf.h b/drivers/net/wireless/zydas/zd1211rw/zd_rf.h
index 8bfec9e75125..9ca69df3d288 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_rf.h
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_rf.h
@@ -85,9 +85,6 @@ static inline int zd_rf_should_patch_cck_gain(struct zd_rf *rf)
 	return rf->patch_cck_gain;
 }
 
-int zd_rf_patch_6m_band_edge(struct zd_rf *rf, u8 channel);
-int zd_rf_generic_patch_6m(struct zd_rf *rf, u8 channel);
-
 /* Functions for individual RF chips */
 
 int zd_rf_init_rf2959(struct zd_rf *rf);
-- 
2.26.3

