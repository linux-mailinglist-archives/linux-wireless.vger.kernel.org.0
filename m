Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47580261A57
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbgIHSey (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731688AbgIHScm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46621C0617BF
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so229737wrs.5
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmVal2o6VpsWzwKLRZjrXBlSLBI0SBy7tb3BPEz/CLk=;
        b=ucbxdG9jo8AxIkmpSyk1lJzUMR1qpq377fkvPUy95Z5BY9M43XEk0bDqmkj6hF/ONo
         Gm2R62JXAd37VC74H5HD7x8VIaWjal5eJ+eSV3u4e8bMn9o+H1uuh4weU94oTXW2F0RE
         eqf5AkEtgiaS7PwmKd8ISGfGRCiWXfdGLhXFgmpxitYUZhCp/1jYt9fx3epMncYJzFtJ
         AwZfPVpnhatddsLW4VSQPMk/l6bwxWZeCs9cwUPOvur2KCA4781fw0o7iOFVdZaDnStt
         yq8q3LXVuCttV/lKYN2/z5TW73o104MqXiRkKnsLDpkZqi0UmTR8IfPXlujnScg1SeoS
         lEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmVal2o6VpsWzwKLRZjrXBlSLBI0SBy7tb3BPEz/CLk=;
        b=mnTKW0i2EqpDQuqNXijBvqhJK+dT3V/JJLjUe+Py5dIXyU3qm2AR/j07AqFcTx5dmY
         FopVaQ8kafNXv4wKLSNJ8LVEaOC/jmnp5/hzLoTXOdAU994dp0gEAjfQ6DaLKHO9Y5nd
         moGQD40GoMj22/sXyIUN/WwrmZOxg3QRxE5j6+gJH92QyPxQNhN7XDOEdS/sjV0qB2GY
         xoUco1avYjYMo4isyJvalgKNDGMV5sZpZpoRGDjOzTytukKFF+tHyVd7WHxzkARuphQH
         6f1yWZ0BoPeW0iUctlcfX9elCCie11izVKtEAfZe1IrVQNJ0+C5FBgFy9b1//7SCCRg0
         iBiQ==
X-Gm-Message-State: AOAM532wkm4SxIH5AIjWFg5hABIiOl82M+0PiXnbgx0EiLqMjTpoFbkB
        V1V22Y9jk4HFruEtTYaqs8D4nw==
X-Google-Smtp-Source: ABdhPJxa9L/LsbYhU4fEEieNGVMqiGDuOgtLKlokgTMtjYASkZwSch99zR06gdW0rvdHSnVgdonXiw==
X-Received: by 2002:adf:e601:: with SMTP id p1mr1011172wrm.172.1599589481964;
        Tue, 08 Sep 2020 11:24:41 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b84sm381427wmd.0.2020.09.08.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:41 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 0/4] wcn36xx: Update firmware config to support wcn3680
Date:   Tue,  8 Sep 2020 19:25:25 +0100
Message-Id: <20200908182529.2870478-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is five in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

This series is about providing a parameters to firmware to get us up onto
802.11ac data-rates finally.

Once the firmware config is provided to the chip and VHT parameters are
populated we are good to go in terms of the higher data-rate for the
wcn3680.

I get typical data-rates of:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-320.00 sec  4.93 GBytes   132 Mbits/sec  445     sender
[  5]   0.00-320.14 sec  4.93 GBytes   132 Mbits/sec          receiver

Downstream 3.10 prima is getting I'm told 180-200 Mbits/sec on the same
hardware so with time and effort there's certainly some performance gain to
be squeezed out of this silicon yet.

However as a first pass, I believe this is good enough and useful enough to
others to submit for upstream inclusion.

An interesting project and a medium term goal would be to have a unified
configuration for all three supported chipsets.

For now suggesting a separate firmware configuration to make sure the
existing lower-speed 802.11n and higher-speed 802.11ac chips don't step on
each other's toes vis-a-vis firmware parameters.

V3:
No difference between V3 and V2 below
https://lore.kernel.org/linux-wireless/20200829034002.2167878-1-bryan.odonoghue@linaro.org/T/#t

V2:
- Sets the default data-rate for wcn3680 to MCS8
- Zapps a few firmware settings for power-saving
  Powersave configuration as a specific wcn3680 topic is WIP on my end
  and I think therefore better left out of an intiial submission.

V1:
https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t

Bryan O'Donoghue (4):
  wcn36xx: Extend HAL param config list
  wcn36xx: Define wcn3680 specific firmware parameters
  wcn36xx: Add ability to download wcn3680 specific firmware parameters
  wcn36xx: Latch VHT specific BSS parameters to firmware

 drivers/net/wireless/ath/wcn36xx/hal.h | 124 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/wcn36xx/smd.c | 114 ++++++++++++++++++++++-
 2 files changed, 234 insertions(+), 4 deletions(-)

-- 
2.27.0

