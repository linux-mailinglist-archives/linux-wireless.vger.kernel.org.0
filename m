Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C313536077F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 12:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhDOKsJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 06:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhDOKsF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 06:48:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA838C061756
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 03:47:38 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p2so1164191pgh.4
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aYENDE1t3vElmJ+PTLiR0xCgqit2MOoeiKicHtSG8Bs=;
        b=PxyIgr/Mywj7RVveOC/cFCkXKnAYFqvlIiPMWzp+9rSYGGFx/O7W5gMoFdPRAMccD4
         nRuOD6God6oDhE/YzsA3UlC+nN0jUYn1lp3aw73GT6v3rjpjRRGU4jMNG9SFfUR4L3C+
         T2BIc8Wtbgo3F8+c1AB9jrbrLcBdSEYbhhvnuTfQ+O0/rxA4yqrh5pMy24Q34YldZEge
         q/L1z3o+Djcp94kZCanF9zP8V36wyFDldbg/LJB0LPzNtXKFAOeAyaswjaQsLMrcczIb
         CDH1bsiK4OcnhNRsARQhg1vKj3uePvZIiYKONgE0NURqgf5+ssbpi7AzYPuONlnVBuzg
         3HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aYENDE1t3vElmJ+PTLiR0xCgqit2MOoeiKicHtSG8Bs=;
        b=Vq/yTTlcj9KWzT54ejq+VWHkK+PGKFhpJnHJmicWYbI7CmD0wZ6BfHWGUa/qeJ9OT9
         j7GiPU3q81wO5qSVnJ4tQWbkT9s3chiG3vxj2OAGOqryt4DRelmPrqWL2XR732oitOFi
         vmZvhMZrlZNsX/S2q0mCBuSvEPktWjoJ24PQ/7zvULmDgJDC8EmlY+GgejCYYczQSNZC
         obBLClNV0c5HMSxdE0VH5z0WM7xaFbRKOK6FfYn+7s7trmNmsQP3G1J/uHIxiZcudL3S
         LTmBs1le2RqDJ+YzcoZ3nrAqzk2GdqMo4M/kTLXOmR3LKTYoOPzjoBzMasZU9+lqpaOW
         bpcA==
X-Gm-Message-State: AOAM5336pHMH3yxOLIIqcU64zNAHW0/9XcdOwaqtFJbAaiYsJQipl0wu
        ffFKvq6hbSs607NwXdfq12bXtw==
X-Google-Smtp-Source: ABdhPJwuv08rkzaEhZc4gHfd8sBnVXQ3KjUdGTmlkrCE2Rz7X2rSfsUXRl85QBxh4keGRCx1g0MlAQ==
X-Received: by 2002:a63:f317:: with SMTP id l23mr2823553pgh.173.1618483658409;
        Thu, 15 Apr 2021 03:47:38 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f65sm2130672pgc.19.2021.04.15.03.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 03:47:37 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] brcmfmac: support parse country code map from DT
Date:   Thu, 15 Apr 2021 18:47:26 +0800
Message-Id: <20210415104728.8471-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a couple of patches adding optional brcm,ccode-map bindings for
brcmfmac driver to parse country code map from DT.

Changes for v2:
 - Rebase bindings patch on top of yaml conversion patch [1].
 - Improve commit log with Arend's explanation on why this data could
   be put in device tree.
 - Use pattern to define mapping string as suggested by Rob.
 - Use brcmf_err() instead of dev_warn() and print error code.
 - Use sscanf() to validate mapping string.
 - Use brcmf_dbg(INFO, ...) to print country code entry.
 - Separate BRCMF_BUSTYPE_SDIO bus_type check from general DT validation.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/20210315105911.138553-1-linus.walleij@linaro.org/


Shawn Guo (2):
  dt-bindings: bcm4329-fmac: add optional brcm,ccode-map
  brcmfmac: support parse country code map from DT

 .../net/wireless/brcm,bcm4329-fmac.yaml       |  8 +++
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 57 ++++++++++++++++++-
 2 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.17.1

