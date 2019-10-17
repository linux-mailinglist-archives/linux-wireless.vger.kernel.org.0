Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D515DAEDB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437311AbfJQN54 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 09:57:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35850 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfJQN5z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 09:57:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id u16so1987883lfq.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MPvIgeYyS5sEH2/sdzpYI6YJY72ljFxd5CJtu+IHloQ=;
        b=YMFYY9SOWuw2gCta52O4XJLM08tWAp/9Z2kzoqZLJ/YQ4cX4Spn3oy410avVSqTrMw
         YK4NEVG/uPHsWOYvvrIrZsGN8ISXf+SYEgDbnsuqF/OKiXcI9qHA//el6AZ5DQ7LZCPN
         6DHX9qWhxCEQ6AoBBEMZ4UpjJythPE92PTmADKDtOXqquPiaK6gZzB04gh85tAQvMkmv
         0Eqj7k/oRwQbZA+ViQQPtLonzcIJnULli0n+vAesSX9gPVzipWVx3MaQvnmkesxm9lbP
         L5KssgY0CPwSdejFzqUvC4yyQro28W3uvW45/UZoVG/cku3ZXxv33Zci8NlZMvT+qBMO
         h4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MPvIgeYyS5sEH2/sdzpYI6YJY72ljFxd5CJtu+IHloQ=;
        b=Z6v6TOMOJBmbtTLh/Bh7VWvvcT7BampDGxSlYpBCV0IYQct3bnuzFY8eMYPaH7xPFf
         Ue45vkIO1n2chcvJEWO04AuxydYjgcIBQpp4NmRrx6s3KSu7fpKDcE7ReHY63QUytNDh
         6eXtyPdYoKgVZ05tv/rnGYLZubmjC8rsGEwzIMBHGBKvnYh18H6n8j1Fd4wh8JnZ3LCV
         3AGdhGR7lpK4v/7L7gRHhwDa9f9yBdcV1vHa6QVnKMe3+tAlRem41Bop2PXwvX/QpJKp
         xOUFnKwa9noD5PlmQ+b35/a52cUXKhLvqlMy/JylxP8UkFxLiOMTRuvppZsFJnstredr
         U2xA==
X-Gm-Message-State: APjAAAUTS2R+OEWtsWor2E750Qdy+CctXXjyu386jL3OvYdL1depXUeo
        sF5NMAE8Q14RPadWA0uO7AEQ4w==
X-Google-Smtp-Source: APXvYqzgFfNbRiS1dqPAYHp+u5VFayansAF4dMt2TlvUi3kylGKp6MkSIK6/8d+dmnSpQfZGH71o1w==
X-Received: by 2002:a19:8c05:: with SMTP id o5mr2459368lfd.53.1571320673697;
        Thu, 17 Oct 2019 06:57:53 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x17sm975088lji.62.2019.10.17.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 06:57:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] mmc: core: Fixup HW reset for SDIO cards
Date:   Thu, 17 Oct 2019 15:57:37 +0200
Message-Id: <20191017135739.1315-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It has turned out that it's not a good idea to try to power cycle and to
re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
because there may be multiple SDIO funcs attached to the same SDIO card and
some of the others that didn't execute the call to mmc_hw_reset(), may then
simply experience an undefined behaviour.

The following two patches in this series attempts to address this problem, by
reworking the mmc_hw_reset() behaviour for SDIO.

Note that, the code has only compile tested, so any test on HW is greatly
appreciated.

Kind regards
Uffe


Ulf Hansson (2):
  mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
  mmc: core: Re-work HW reset for SDIO cards

 drivers/mmc/core/core.c | 10 +++-------
 drivers/mmc/core/core.h |  2 ++
 drivers/mmc/core/sdio.c | 11 +++++++++--
 3 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.17.1

