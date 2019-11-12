Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378E3F8FC3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 13:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfKLMkc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 07:40:32 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43069 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfKLMkc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 07:40:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id q5so6689471lfo.10
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 04:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GS74KcWU6LWfn4W3TTm7UzKnqVQyh8jB+ckoaJ1dMgM=;
        b=pCOe7wyRI/cR0JLpoqCR+095ml9V6ywoOeHVPRa1ZDghsbWHo0zBTUpMsX2y2U2i0i
         p5jNnnuB6ts0WVHbeepcEjiFL0gsecloM0vep7uc/fg+9d1ICkMZND+dZiQvx2q9CxW4
         zWTYcOdARgEZsW/QWt2rNBBCYKFJjEQVOZCKVzi5uSV3DpUB8t1vKpIpFXPGjW1ilo24
         uo3S7UjB+Lm3CwzSyLQZi32HRTJCPRqzgSLSQfvL5nSNRlp2XyyagtaBYWOPQ4j90Z1J
         Guj7x3T1E9yh7cDiirksjwEU3vtD7CXVwZSFG9kFH2l33n1TwKMsRMhTwKRUxWfuJieQ
         q1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GS74KcWU6LWfn4W3TTm7UzKnqVQyh8jB+ckoaJ1dMgM=;
        b=YA+bqcqv/QWMjaZcY1Jbd+qJWTx6AUE1ruSCt6Y4Dhx9mxT2kdFxCIrGpMXbXo7HmU
         28Wgagvoixyb7FfNPgSM4V0eH11MfrZ5qbqAdHRDGtXe6oa6UjsgtsDL2hEzAbs2Sj0v
         2FZMe7uUWEgybVom11gsGFoR6at3LYjX6BLAqz4a1K6kgl9ai/I0mwi3vpMRvfh7qTBk
         Pei+264ln6+HFDHpSVwREV4SAP1n3DUDaoehO26qF9edEBPkJoAfC27PHfI285vVbODm
         +CXb+Q6hrbsURp6RJAJTcyc9bcO+mEXayKOEyuGgaGMbk2B/6BLn16HesvWwfQT1rRoq
         i3ew==
X-Gm-Message-State: APjAAAXbGw9rUtSGGtvXwoTmV1rttwYq9UVwVcoFCTSZxsd7oj5EHswD
        jmzC2Q6hUkZ9BgZNo5HE43x9fQ==
X-Google-Smtp-Source: APXvYqxt8y7KHTJHTbtSdRPhj/I1Xijzm+O8qoMM4G4ojNcZ23cLClakaiP/lnCeI2YGcQI2kY+eKQ==
X-Received: by 2002:a19:ad43:: with SMTP id s3mr19445105lfd.34.1573562428229;
        Tue, 12 Nov 2019 04:40:28 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z19sm8375096ljk.66.2019.11.12.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 04:40:27 -0800 (PST)
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
Subject: [PATCH v3 0/3] mmc: Fixup HW reset for SDIO cards
Date:   Tue, 12 Nov 2019 13:40:18 +0100
Message-Id: <20191112124021.8718-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Changes in v3:
	- Added tags.
	- Drop unnecessary initialization of variable.
	- Rename adapter->is_adapter_up to adapter->is_up in the mwifiex driver.

Changes in v2:
	- Add adaptations to the mwifiex driver.
	- Keep existing synchronous reset behaviour if the SDIO card has a
	single func driver.

The cover-letter from v2:

It has turned out that it's not a good idea to try to power cycle and to
re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
because there may be multiple SDIO funcs attached to the same SDIO card and
some of the others that didn't execute the call to mmc_hw_reset(), may then
simply experience an undefined behaviour.

The following patches in this series attempts to address this problem, by
reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
mwifiex driver to these changes.

Note that, I don't have the HW at hand so the the code has only compile tested.
Test on HW is greatly appreciated!


Ulf Hansson (3):
  mwifiex: Re-work support for SDIO HW reset
  mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
  mmc: core: Re-work HW reset for SDIO cards

 drivers/mmc/core/core.c                     | 12 +++-----
 drivers/mmc/core/core.h                     |  2 ++
 drivers/mmc/core/sdio.c                     | 28 ++++++++++++++++-
 drivers/mmc/core/sdio_bus.c                 |  9 +++++-
 drivers/net/wireless/marvell/mwifiex/main.c |  5 +++-
 drivers/net/wireless/marvell/mwifiex/main.h |  1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
 include/linux/mmc/card.h                    |  1 +
 8 files changed, 69 insertions(+), 22 deletions(-)

-- 
2.17.1
