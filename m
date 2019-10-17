Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F1DAEDD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437321AbfJQN55 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 09:57:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33701 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437308AbfJQN54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 09:57:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so1995521lfc.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W/IUaSbhHG4wv7nj6S/SBAPb0kMokkckyKlISAFdDyg=;
        b=t+8qBMvE/y8RBPIQXO8pK0OYJq/4UahUSKfRo968q0KRtIBLbZxzfkR8l0K1moMpN2
         kgLf2lJ9VJmqhrDP8vKnut+e46V9D+014tJ53GQNrIB4xCTnXih8D4s56ub1qy2PaS68
         VSHSB0aTl/WObl74yg3tHB++wvXtlOfuV8eHWk0XVAyy+VkHpJn5edYxdECRR23iMru9
         dqfkTPGhjS6pgcu92sKKBpc9SfdSW2PS8a3Ts1q1d4hvNh9BPOhOkbfMTdwNbndTUoD8
         +iMCWx+hfBZHmQvxgKGHfuNzmwIQTldrR8AvzVots22cyjseUcGhRzRp3J6cZ//N2VXU
         IWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W/IUaSbhHG4wv7nj6S/SBAPb0kMokkckyKlISAFdDyg=;
        b=Z/LuEaiDUMtZRzOhPGszSNeZsWl6O4oP1AoXBt6Ayi4EtamEgLoLioZ/Dj4Ilc4YuX
         1+RAka6SevNfyjDT/cKsttIhdzfTazg56xLZswjuImoVM8WLs6/J+iYCT4NTBV3Y3eOQ
         XQs6ZEu4F8VEMq5Ts9sFxUDXvP2rxzKoMKWhQrg6u1dmhlR6JefvQsCUWNGpt/Py0PfI
         MSUSFhwmY5aNCYTYJT+db2ebiAj5NyLtFhM+ZrzoiCjMrAjtFedSFCFMi+jDZ1Kr8OOK
         M+UKEnDgoeoiEyghovMZ7QMnhfhi8dGqPNLJoA2xOGum+2rpFAmY9EZz7dXx+D7bP0Qc
         4sAg==
X-Gm-Message-State: APjAAAXJFymBOfbBMYYzFp5QuRsReNpyz5SL9V0/NCuX75DfsaiXq8+6
        WuU1A0Y7Ob0TLs7T+/6+nbejfw==
X-Google-Smtp-Source: APXvYqwBVphSUSV/EpVwjWyAvyg263gkH8JSDcG/pQR4rUzerRHYeILmO4ZHlINFlt4u0aJj7QmJEg==
X-Received: by 2002:a19:5504:: with SMTP id n4mr2529787lfe.106.1571320675138;
        Thu, 17 Oct 2019 06:57:55 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x17sm975088lji.62.2019.10.17.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 06:57:54 -0700 (PDT)
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
Subject: [PATCH 1/2] mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
Date:   Thu, 17 Oct 2019 15:57:38 +0200
Message-Id: <20191017135739.1315-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017135739.1315-1-ulf.hansson@linaro.org>
References: <20191017135739.1315-1-ulf.hansson@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Upfront in mmc_rescan() we use the host->rescan_entered flag, to allow
scanning only once for non-removable cards. Therefore, it's also not
possible that we can have bus attached, when we are scanning non-removable
cards. For this reason, let' drop the check for mmc_card_is_removable() as
it's redundant.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 221127324709..6f8342702c73 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2297,11 +2297,8 @@ void mmc_rescan(struct work_struct *work)
 
 	mmc_bus_get(host);
 
-	/*
-	 * if there is a _removable_ card registered, check whether it is
-	 * still present
-	 */
-	if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
+	/* Verify a registered card to be functional, else remove it. */
+	if (host->bus_ops && !host->bus_dead)
 		host->bus_ops->detect(host);
 
 	host->detect_change = 0;
-- 
2.17.1

