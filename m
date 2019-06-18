Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAD4A57D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 17:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfFRPfD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 11:35:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46337 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfFRPfD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 11:35:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so13575849ljg.13
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2019 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DYh01G4YOAJJOYFXYzW1f6GX4EFwB2UrYsYuTpn+ycI=;
        b=J/MtpnCDLrtQ7KxlyDUgTAqGs3KuQ/4fJwmuU8bU6mB5r9cAat/xZ/DKkI0M65UMB9
         rVcQ5kQBHCpqxA7pFi8Hmq9WF9Gc2q8U72goWwgVUjYR+tHFCwaeCZc5eqrZjnyTwpRT
         HER9nQ5mOeTG0OvpVhqWZE3hf2FRoRbytTwWhMuNamB6rZ4htlVyPNtZGy4viwbHYAep
         pA95TU5DbmdQDKXLH4BfELfKI6DGVW0dB2YOzhcNy6BE41rEl+NNPmmrnHbqfl3cOvMG
         uvzzgko4/X+koH4dR/TvAzwwshOh4rP6+cY5dTximIpVpbFfRAQ/lwMDWV4N7OAKzHk3
         miJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DYh01G4YOAJJOYFXYzW1f6GX4EFwB2UrYsYuTpn+ycI=;
        b=gZU+4nuM1YObFmgkgbLXX6GXhA6kSqOdjlhwRwQPW+Y54leriJcs0Eq1e1ssPJ0c4p
         6HkChvtHF6UDNY1Di8b/6vQjS3ztlvOmEiewb2p7FniLAEVFwefyTDj09Am+yAzglLVO
         pDeHKfYNseyqwdd5U/FekoEDNrLJxAwcsR3SJvg4vW7jrFMAkHD/0H65vmk1aI6VIpiU
         chgacBq+KODHALUW3lsmEX35j/9gu9LZOKnLe1YCKvjYxHmYQ/HhpvxvGA4jMOP1oy8p
         0YSmDczMOEuT5ipGqDKQ2n2uTOIahpAX2bHxOiqV+mgkgYzrFqWgIU1jJULtXA6xs7Uc
         kv4Q==
X-Gm-Message-State: APjAAAWR0oz0WAEdsyW4hN7GgyRmTz2Konvb4Q2DVRavbLdapnKTTdXp
        bWIxnyUV3zx/z3d11aH1x5NLvw==
X-Google-Smtp-Source: APXvYqw5trtqABkhMNMmqPOkzUYmnAODdHE+SClNusmc+GT7Oc0Wvq4MM6vIfnYuKJBTztnp3HM2fA==
X-Received: by 2002:a2e:8650:: with SMTP id i16mr14898729ljj.178.1560872101420;
        Tue, 18 Jun 2019 08:35:01 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d15sm2203121lfq.76.2019.06.18.08.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:35:00 -0700 (PDT)
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
Subject: [PATCH 2/7] mmc: sdio: Drop mmc_claim|release_host() in mmc_sdio_power_restore()
Date:   Tue, 18 Jun 2019 17:34:43 +0200
Message-Id: <20190618153448.27145-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618153448.27145-1-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function mmc_sdio_power_restore() is called either from
mmc_sdio_runtime_resume() or from mmc_sdio_hw_reset(). Both callers either
claims/releases the host or require its callers to do so. Therefore let's
drop the redundant calls to mmc_claim|release_host() in
mmc_sdio_power_restore().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 712a7742765e..b3303b7d9956 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1030,14 +1030,10 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 	 *
 	 */
 
-	mmc_claim_host(host);
-
 	ret = mmc_sdio_reinit_card(host, mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
 
-	mmc_release_host(host);
-
 	return ret;
 }
 
-- 
2.17.1

