Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0069048ADC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 19:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFQR5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 13:57:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37609 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQR5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 13:57:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id n65so1773964pga.4
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2019 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9pIBJIx5KyoFRd/bdMWO0ltZcMM5qXRNGUXR67YrGQ=;
        b=iN8UJ+1H+LLjCAE7ZOe8TFSmKlR/Zt9Ir81Ky0rIilfvkaD2u5NXfvBjxAkJmMe+g8
         Kdi+mp01jN3oWhOTozGO/8mCtAQv2LGKB+cD4rluMbIwL3l99CPkR9mZpg9u5Z9n3Ytn
         RdVpKZYKwzqy/qahwneUnjr6yugbbjlt4KRjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9pIBJIx5KyoFRd/bdMWO0ltZcMM5qXRNGUXR67YrGQ=;
        b=VHQl4dIj+QCYQhveX8Qt8aoiU9sz273cgs5bthBc2KUA8cPUoTRBL/TwcVsV2165ZA
         SkX4CiGfDeq6Im8XWk6xtU1yXCrv7ZZ5eyBSf3ktg/acQneOj/E1lDYtL/fmFmL3DMiL
         PwAPlgoCBmK70M7C/Ooj1dS9/6Iulvb0AjV+F9ktlxw91LlFA1xxZdYLDCWotd0Diyo2
         MPIgPKN46TFis/cOR7if7dg1c3mWlOm5SwCQa+LkSj14aYt6NDAVhu2I4ifOqvGqrU4f
         jUrI1qAbFJT+EAVxqKP0U8a5m1brrz1aPyQMseGf40wSKze+wQy+XfggPqIBWT1hhewJ
         bNKg==
X-Gm-Message-State: APjAAAVciliNjVy5Zglhyalp7KZZQngseZx8ZW+1CNuSb6qDut6nFhaf
        9/gEqCr6M5eqlTFiyfLIiE4IdA==
X-Google-Smtp-Source: APXvYqwxiy2sTP4aHQThn6yUsnnxea9KMuOdDQS+o1XQ29m7RKGm2fcTiPiFUq9yNh50U8PSmx4rMQ==
X-Received: by 2002:aa7:8202:: with SMTP id k2mr10940559pfi.31.1560794260643;
        Mon, 17 Jun 2019 10:57:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q1sm15145809pfn.178.2019.06.17.10.57.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 10:57:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        Douglas Anderson <dianders@chromium.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Ondrej Jirman <megous@megous.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 0/5] brcmfmac: sdio: Deal better w/ transmission errors related to idle
Date:   Mon, 17 Jun 2019 10:56:48 -0700
Message-Id: <20190617175653.21756-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series attempts to deal better with the expected transmission
errors related to the idle states (handled by the Always-On-Subsystem
or AOS) on the SDIO-based WiFi on rk3288-veyron-minnie,
rk3288-veyron-speedy, and rk3288-veyron-mickey.

Some details about those errors can be found in
<https://crbug.com/960222>, but to summarize it here: if we try to
send the wakeup command to the WiFi card at the same time it has
decided to wake up itself then it will behave badly on the SDIO bus.
This can cause timeouts or CRC errors.

When I tested on 4.19 and 4.20 these CRC errors can be seen to cause
re-tuning.  Since I am currently developing on 4.19 this was the
original problem I attempted to solve.

On mainline it turns out that you don't see the retuning errors but
you see tons of spam about timeouts trying to wakeup from sleep.  I
tracked down the commit that was causing that and have partially
reverted it here.  I have no real knowledge about Broadcom WiFi, but
the commit that was causing problems sounds (from the descriptioin) to
be a hack commit penalizing all Broadcom WiFi users because of a bug
in a Cypress SD controller.  I will let others comment if this is
truly the case and, if so, what the right solution should be.

For v3 of this series I have added 2 patches to the end of the series
to address errors that would show up on systems with these same SDIO
WiFi cards when used on controllers that do periodic retuning.  These
systems need an extra fix to prevent the retuning from happening when
the card is asleep.

I believe v5 of this series is all ready to go assuming Kalle Valo is
good with it.  I've added after-the-cut notes to patches awaiting his
Ack and have added other tags collected so far.

Changes in v5:
- Add missing sdio_retune_crc_enable() in comments (Ulf).
- /s/reneable/re-enable (Ulf).
- Remove leftover prototypes: mmc_expect_errors_begin() / end() (Ulf).
- Rewording of "sleep command" in commit message (Arend).

Changes in v4:
- Moved to SDIO API only (Adrian, Ulf).
- Renamed to make it less generic, now retune_crc_disable (Ulf).
- Function header makes it clear host must be claimed (Ulf).
- No more WARN_ON (Ulf).
- Adjust to API rename (Adrian, Ulf).
- Moved retune hold/release to SDIO API (Adrian).
- Adjust to API rename (Adrian).

Changes in v3:
- Took out the spinlock since I believe this is all in one context.
- Expect errors for all of brcmf_sdio_kso_control() (Adrian).
- ("mmc: core: Export mmc_retune_hold_now() mmc_retune_release()") new for v3.
- ("brcmfmac: sdio: Don't tune while the card is off") new for v3.

Changes in v2:
- A full revert, not just a partial one (Arend).  ...with explicit Cc.
- Updated commit message to clarify based on discussion of v1.

Douglas Anderson (5):
  Revert "brcmfmac: disable command decode in sdio_aos"
  mmc: core: API to temporarily disable retuning for SDIO CRC errors
  brcmfmac: sdio: Disable auto-tuning around commands expected to fail
  mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
  brcmfmac: sdio: Don't tune while the card is off

 drivers/mmc/core/core.c                       |  5 +-
 drivers/mmc/core/sdio_io.c                    | 77 +++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 17 ++--
 include/linux/mmc/host.h                      |  1 +
 include/linux/mmc/sdio_func.h                 |  6 ++
 5 files changed, 99 insertions(+), 7 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

