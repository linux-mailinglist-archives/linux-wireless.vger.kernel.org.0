Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1244378A0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhJVOFI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 10:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhJVOFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 10:05:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664F4C061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:02:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a16so365773wrh.12
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfwKlOUZ6J1Y06sC6hG1JIGCWd20eVuhbAXjx4dgpXI=;
        b=t0OvHDbmMWCSebeTxabkmmrBpkqN4lXjyPixlVAqWiynfcT3rhwWxq5NLlk0JDHII5
         bW4l1WQYMCM4Baiqw8v+6aRWnu5B74dhmXniWIdCB7kMgWjB3l1SOzKmPBWNTzgBM9kS
         SZ91lCA8AmVwp+4Wasz9QD8NGbgPyGUwPzCnYEow45CdRndG9zTyA8p1pKFB77+6Q6L4
         W3xNzD54rcB6V1eE6I7pSc9k0qVF4a2rnpgX7+FrAyVUZgH+w32VnEIknCCgOq+W9U2n
         ic3JPlXKlOd8KiM7HOvFs1grlDRCinlGwO0zHuB+OkOCvSHL2raQSKRUtlK8HwwPU3SD
         hpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfwKlOUZ6J1Y06sC6hG1JIGCWd20eVuhbAXjx4dgpXI=;
        b=AEjVoJdWl0iIdZuWilEetCdg2lpv9UzLcm+pRNnPrMlN1nT+Kx733k3dImdZwNzBZz
         DfUdr/AlQfGa8FKZIQt0vCcH2HRTzdRvSiS5nK4Qogbv5VNAvltDtOZDySFBM6w2dQ+e
         7ivD38EgzxeUns4C686LpZRmfzxuu/vQCcnFc4Jpse+5bR3O3RJVFi9UtjuwXoC1P6/+
         h++XF/m1rBGFv9cnTZz3Aye7MxAq4brugHUmKO5NGMvy2DRw1clkaYUq1Hu9Py9ypZyL
         WmmzKnE/RU8uMdNCKoOJ3lgJupjhUSmhKSYCppAJqzLapV2c3ub4qxaEEzbUNocGj2pZ
         nm/Q==
X-Gm-Message-State: AOAM533+hFuOZCVRBLPbV/kLoy2zySPfD35lMVOz4/69FJ9yJUu4PozR
        5JxoBIAf4A4bZVLPN+/OkXuDiA==
X-Google-Smtp-Source: ABdhPJx6+dOTFo/qPRuP6cGMXVI9aJJFPbf+tOpJjmZsy+55X642axszt2tMk3W5DUWjgS5Ex7vzZg==
X-Received: by 2002:a5d:6388:: with SMTP id p8mr39390wru.123.1634911369036;
        Fri, 22 Oct 2021 07:02:49 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u10sm4789913wrm.34.2021.10.22.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:02:48 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 0/2] wcn36xx: Fixup BMPS
Date:   Fri, 22 Oct 2021 15:04:45 +0100
Message-Id: <20211022140447.2846248-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a fairly simple set of fixes for BMPS. In the first instance
treating a series of BMPS entry fails as a connection loss. Three
consecutive entry failures are treated a loss-of-signal.

The second is a revert of a disable of BMPS for Open APs. We are finding
that with our latest kernels no longer suffer from this bug.

Bryan O'Donoghue (2):
  wcn36xx: Treat repeated BMPS entry fail as connection loss
  Revert "wcn36xx: Disable bmps when encryption is disabled"

 drivers/net/wireless/ath/wcn36xx/main.c    | 10 ----------
 drivers/net/wireless/ath/wcn36xx/pmc.c     | 14 ++++++++++----
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  3 ++-
 3 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.33.0

