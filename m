Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC9472DC5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 14:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhLMNtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 08:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhLMNtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 08:49:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C5C06173F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 05:49:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o13so27085588wrs.12
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 05:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QECQ6kqhHviAQtdtRKaAbYshAGcjCs6cTEfH6Tz7Hwo=;
        b=KzwC1FA5zu+86ujmBvGnpIVdk/Ci5O1hqkruifGFiHvYRWJ0vQPA9CEjOj/BJyWAug
         YbFxIeh/nE79CSUJYEJAz7FvGBesjKYAVbQUtP7szPFJe2gQAMbOFIYDCyNgPUK+tusr
         LHWBPbO8pS8uFMfUVgPeMUTRDggr+pNjsQKMbexc/xiwlzvn2uGlngVfCsWmImkLFT07
         jeNDpcv4SXgB0MBCq5xAG9iBwqoOfn9L3cQPgg/WJ75IHLfjTWp+BStrXjw5BTeCsp9l
         ZdmdsQ0FjvN3lYJ2DMaEqHyaNKPNK6/fcuE8nh70Ce9vp+MklkWJRTkq29Ot1u2i4fNm
         ieug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QECQ6kqhHviAQtdtRKaAbYshAGcjCs6cTEfH6Tz7Hwo=;
        b=xvo/1vrtT0PNPhHeK2hZrWgRerCl70bF5k6PbPXCFcX1s1W3NVC5MyisB0vSZXQydw
         5st3c9iYnhEGGXlqxeH/iwwNVUM5DXJ5nPvmfBKz4Jr6ExvkOTJ/bpPQ5w5xdMGrP6D+
         MYZCIcCqB4ekULZ3O3564pNWuGNz6zczU9+A4a6xZ/A/tqgDT8hBHrpj+QZIsGPGOc48
         K+U116FwmfVT2vLSlQTKtr7G2/TkSn2YAStkapc3tR1RUyHpap17agy2iM7Vgdc9syfy
         e5/qVFs9sJMwqFGoHE7VRz/D60GbaSFXal3avXQo+bBrz3T1UsJjomjootfgRkTCnAqQ
         ZYDQ==
X-Gm-Message-State: AOAM533IhPmGj7LWW8YQdoZ3sAhjKWsx0aGHQVe6499nR/Q3WyOx4uAB
        VGPyqTgi4dhTBfqGBBy8qEYRaA==
X-Google-Smtp-Source: ABdhPJxXiPHuwOEG2QN2S/5NByN4OIph8gXGV26HqIsalSKcPXhIFq71jLKc/T5LFynHe5foFfyXAg==
X-Received: by 2002:a5d:59a2:: with SMTP id p2mr31987440wrr.252.1639403361952;
        Mon, 13 Dec 2021 05:49:21 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m9sm7366621wmq.1.2021.12.13.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 05:49:21 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH 0/3] wcn36xx: Implement explicit beacon filter tables
Date:   Mon, 13 Dec 2021 13:51:24 +0000
Message-Id: <20211213135127.1656258-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

 drivers/net/wireless/ath/wcn36xx/hal.h  |  29 +++++--
 drivers/net/wireless/ath/wcn36xx/main.c |   1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 104 ++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |   3 +
 4 files changed, 131 insertions(+), 6 deletions(-)

-- 
2.33.0

