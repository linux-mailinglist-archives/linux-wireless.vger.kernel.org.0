Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371FD472FDE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 15:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhLMO6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbhLMO62 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 09:58:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9FC06173F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 06:58:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so11774019wms.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5M/FX/Lk4X9HZwjX8p17fTjxGhNIygu+8QxOAhLyoM=;
        b=b/CBQ4fxNROPTE0ME9Egd/3S2vdUAyrp8KNXCeQcmshQZgBI6PR0CzLUOCcq2hHGXQ
         QDI8UMRtjw1z4Agk72SlJszOdJeZyZnTX0DInLSLyXtfdjNlEjNujep6CTaGkN+loqNs
         w8EYQKH4Jr6Y9uqOVVHGq/xtSf+XRau407NpgOCaWh8uQ8b3qb02TAG6MMHou/MmpHKH
         HaEZnE9Kxy/3shIYFC6C39uFPEpFKDstcc6j6G8r8MiyzWPGcOCYce0w3OtciXEMFQWY
         L0WDPXz63TzMzTjcCRnFqLD2XHLqdi/tKreZxqZXV19ESCcdkhixlTBS3m6BKAtMol11
         6rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5M/FX/Lk4X9HZwjX8p17fTjxGhNIygu+8QxOAhLyoM=;
        b=F4MzgeUIEuRycA+4pfQzrgs91lwIh5CP63ECW85EtEbhT79YyeXxrcRmRUwyLfB7NQ
         lI6w5+9lkyH93+R8pcRoGRiaky2736pCNpLjnaGExmnwp6zbk3koDLtCgcbJD4UVDzLX
         LG0VClxngKc7fcOUM780hfU5KutPRqZiTwwDP+sza7mnQO2WppSZl1LXPKzzoAXW0sa2
         ARa9105BzzIiG3MySvwyO80rgTZ2JB0UovNnB4A/CST8jN+PWxa2noulVMcRArgZgQxs
         2/+ZVx43OmBIiGsuLBtgb2AivDWUfZIxvTSV2jF4OrWOjefyzO3D885XB2Fny50yqhUv
         JDEQ==
X-Gm-Message-State: AOAM533ZX/CAvHDOV08z5KLEp0cdGwdYhWxt0c0mNZmgZVBEOJsXcaPr
        3Zv1KDIGVlNpGTjKi/pk2kb38A==
X-Google-Smtp-Source: ABdhPJwR297FP0mIl5zLL+6hcBqhNKxghUSLppIoRe+jr45VJnSYuiBZnRJnWkaFL1qR8SJtFPigyQ==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr38632625wmb.174.1639407506288;
        Mon, 13 Dec 2021 06:58:26 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o63sm7570112wme.2.2021.12.13.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 06:58:25 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/3] wcn36xx: Implement explicit beacon filter tables
Date:   Mon, 13 Dec 2021 15:00:28 +0000
Message-Id: <20211213150031.1707955-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V2:
Removes duplicate defintion of mask field defines

V1:
Downstream provides the ability to directly program the beacon filter
tables. Currently in upstream we rely on whatever is the default filtration
table in firmware.

A trivial packing fixup is required for the SMD structure. The downstream
filtration table from the Linux driver is applied but, we are not
necessarily constrained to using this table forever.

Tested on wcn3620 and wcn3680b.

Bryan O'Donoghue (3):
  wcn36xx: Fix beacon filter structure definitions
  wcn36xx: Fix physical location of beacon filter comment
  wcn36xx: Implement downstream compliant beacon filtering

 drivers/net/wireless/ath/wcn36xx/hal.h  | 30 +++++++--
 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 87 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 +
 4 files changed, 115 insertions(+), 6 deletions(-)

-- 
2.33.0

