Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA794059A8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 16:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbhIIOtQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbhIIOtC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 10:49:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF36C06175F
        for <linux-wireless@vger.kernel.org>; Thu,  9 Sep 2021 07:42:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so1271700wmh.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Sep 2021 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k8bZdv5DTLVGkZZdw+ZFnrk/hdYWsN69QWl4r7xO3Rs=;
        b=pEcbWt0wt9p+MeEc03t+K3ZYgt5E5ZiIdHOpTdInAw7p4Z284XCdcnqtuKslX2EKZ0
         ulYG79dfxmzEvbxtO7FSHxO4Pm8yiWdhi1JRCQoKnTnzOLOzEZ4X+VpHrTyoCF9V6WaN
         7OqzdHyEOOEG1uhSMu7tWgK0She63mFdlFPsCY1+/8ebyYjAUoKG+s31glg4X+yJHc3t
         CxnaslvYZzFJPed0Yu/uvk+Py9bjRX4fn36OlqHhRGS4uAdlFLk9s+ecKZMtGJx7LtuW
         HZ1bGCPqXJg5ybY1nZWXFnNstTkKq92lSMZikH85ZfZh1WaFHxKqXuJaWkEDQytdViIb
         I9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k8bZdv5DTLVGkZZdw+ZFnrk/hdYWsN69QWl4r7xO3Rs=;
        b=g4JY+/59IdUj6PPurj7mDYTnM7fBjgnHKd3J4dk1izkN+zDk1XeFPbUEEevOdv8YzQ
         z5zPHZmErlO+MfK2myjyolfNLGDv8F0NAGLXJ2yEyENzbp59pnalpM0jNy+f71g5MOhw
         raiBDnWDdoTqFEgJZB5XAXzgOlLE0BeGCt6uvFh7/usQK7LgEJ9nXPoNm+9AyHRdxYdh
         r8xE7uYMzBLICnO0woUUdM+TYI+Xd7/ou+rYc0XCYFK/88pXy4tkUUwCSwxqTgPNjhon
         pnBxRK/Z8/Xv0as8MjmkSAMnxpGNnHQqQ3SMTjE+H2MZQM/MmgYk/HDcFrkac503E+ih
         m51g==
X-Gm-Message-State: AOAM530AO5JW7YaFQpHV9OOpEiEG8rQS5fmOe7YzvNjYNqTbdUBDYFaB
        785PA/QPAsuYrEhnsv0H3DlPxQ==
X-Google-Smtp-Source: ABdhPJyGLyEsmMuKKQjcgd0gPGogx9B1xtT8qCA8+LhB/nfh58L7TWlX8IPxiQQlzEOaVO1595To3Q==
X-Received: by 2002:a1c:f706:: with SMTP id v6mr3424313wmh.167.1631198554533;
        Thu, 09 Sep 2021 07:42:34 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k29sm1160712wms.24.2021.09.09.07.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:42:34 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/2] wcn36xx: Two one line fixes for Antenna Diveristy Switching
Date:   Thu,  9 Sep 2021 15:44:26 +0100
Message-Id: <20210909144428.2564650-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V2:
Ammends the commit log of the first patch
  - Clarifies NV is the location of antenna GPIO settings
  - Adds some text about feature bit ANTENNA_DIVERSITY_SELECTION
  - Tidies up language around "measured antenna"
  - Adds Tested-by: Benjamin Li <benl@squareup.com>

V1:
Here are two one liners.

The first fixes a fairly major bug that is apparent with Antenna Diveristy
Switching (ADS) but, is not limited to ADS. The bug is a basic firmware
table corruption problem, which just happens to manifest itself clearly
with the ADS logic.

The second fix is a fairly trivial one-liner which prevents us from sending
negative, two's complement integers to the firmware via the SMD backdoor
"dump" command.

Bryan O'Donoghue (2):
  wcn36xx: Fix Antenna Diversity Switching
  wcn36xx: Add ability for wcn36xx_smd_dump_cmd_req to pass two's
    complement

 drivers/net/wireless/ath/wcn36xx/debug.c | 2 +-
 drivers/net/wireless/ath/wcn36xx/main.c  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.33.0

