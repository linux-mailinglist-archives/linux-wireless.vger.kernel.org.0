Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472A44A578
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfFRPfB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 11:35:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38176 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfFRPfA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 11:35:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so6728ljg.5
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2019 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=55DN6d+B+pg7e71MiWLrpXoV0s9BN53XlvXNxpUQupI=;
        b=DrgDoBRxKnP16NGaLy7spfwZhr/8x9/NKDZr3xH2Q5/KRVrWg2sWs/WmOEw8yDm+Ln
         coRiu7xL4XXtRt619ZKXTLtPjiTA1Kd77vM1N5ObUAUsLHI/oh6Lmnn+F8S1x4Jas7nP
         w0/yggq/nZS/fBv19axBS9/NDVST2Ex5lVUU/U/Nc9AsnFfk03HuurHS/CzmV58chZK4
         WhNHHscnQQnUSVeScx4r+ldP91met+4Jo8mHVwn59SloOh5MSN7+6jFSLDeyvO6NeLRh
         xbcvU/5fcGk6Xj9nzis731sGD+k9C03QfAnMwRYC4/S9hxZ1IA/xHl5BTclTmxR04Q/V
         kHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=55DN6d+B+pg7e71MiWLrpXoV0s9BN53XlvXNxpUQupI=;
        b=DSLXO02UbYIouNXpqK3kBD1hXqQO9bamuTmNuOELNZHBzvYsD/foCe2m5Za2Rj9N6J
         QRl/uEaFzFyeh6s++4BXR5/tGFHhr61Y/3PD8vAYanD3ZVXXzTxn6GgkcUH4R3OCvfvm
         PTt3jrM9yJbSbSGZrDbklJSqr2dNjDU4f6OS3WVyvw8ekYTiTvIzgYDOvrMDos4S/MSf
         dm2LtMNldHmT6JU4BKfOs1UZ48fyATmuM9iFQ5o/Fw31p7zOWyQZ8L9lWDG+poz2xCwZ
         KFf/WPKqBgZjZrFW8clULdT9aYgrgTchgC1XWwraSV+H1DlZe7Ie5em/K7Bs+fAk3Tbs
         EieA==
X-Gm-Message-State: APjAAAVPlswpyFWXtdECmTFSkVFQvcI7188g7ehV3DbQXOZ0eApsOyOu
        d+ddvp4anLHJnxPxLTNF9OBqJQ==
X-Google-Smtp-Source: APXvYqwtQDcofqArZpqRxKTmM0lOXHxtsp/ONLeIb/tzNDhr2o2B/n9E1DN3e5L+tPD7JbDCUG1TLA==
X-Received: by 2002:a2e:3211:: with SMTP id y17mr1794229ljy.86.1560872098639;
        Tue, 18 Jun 2019 08:34:58 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d15sm2203121lfq.76.2019.06.18.08.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:34:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 0/7] mmc: sdio: Various fixes/improvements for SDIO PM
Date:   Tue, 18 Jun 2019 17:34:41 +0200
Message-Id: <20190618153448.27145-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The power management support implemented via system suspend/resume and runtime
suspend/resume for SDIO cards is rather messy, but also fragile.

This series makes some improvement to this code. In particular the so called
powered-on re-initialization of SDIO card is quite questionable, I suspect
it may never really worked well. Therefore this series removes this code, which
helps to prepare for additional improvements on top in a later series.

So far the series has only been compile tested, so any help in testing on HW for
regressions is greatly appreciated.

Kind regards
Uffe

Ulf Hansson (7):
  mmc: sdio: Turn sdio_run_irqs() into static
  mmc: sdio: Drop mmc_claim|release_host() in mmc_sdio_power_restore()
  mmc: sdio: Move comment about re-initialization to
    mmc_sdio_reinit_card()
  mmc: sdio: Drop powered-on re-init at runtime resume and HW reset
  mmc: sdio: Don't re-initialize powered-on removable SDIO cards at
    resume
  mmc: sdio: Drop unused in-parameter to mmc_sdio_reinit_card()
  mmc: sdio: Drop unused in-parameter from mmc_sdio_init_card()

 drivers/mmc/core/sdio.c     | 92 +++++++++++++++----------------------
 drivers/mmc/core/sdio_irq.c |  3 +-
 include/linux/mmc/host.h    |  1 -
 3 files changed, 38 insertions(+), 58 deletions(-)

-- 
2.17.1

