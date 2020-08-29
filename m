Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B6925648A
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgH2Dj3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgH2DjS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B254C061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so900375wrw.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BeopINcH5vrrIy/IFq7Ef3qxAxmwlwpRdpz51J2al0=;
        b=miS5bnFOnQu6gfgUI3bESIhf9w0O35rIsXfTvkauy9rWAGMwAKoPaXhDF3OyYfzem6
         kSgs1gr0Oslgr5LSGeiYM8b5lCVI5BSs3uAnVl76V3MUzohXVjpFPmPI5eNFV5JpRsq4
         zxrsFq53MfiB+zkOP3ksIMTylYXiBXM8qT1vfjikNB/ZCtAB6LIqZp9S+YK5ermNf3Kn
         KamEJmt0NE/bCb72GIEPIOl+gFyzK8qKzHzH+TtB/oaasabvwAwnjmhFQyI2QYoodL5o
         bIbukS3uNvSiSJvumeqaa7ote0qY3vcP52ZDPt3k6+FBj881x+AOsqODXg7CHhmAYzfc
         GELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BeopINcH5vrrIy/IFq7Ef3qxAxmwlwpRdpz51J2al0=;
        b=n5f8MT9S6CDg17VDVrcvmIBNG2tpVvKtZK2YZ6yDUbzRk80ulI8axg19u9JkPVUZeH
         6UcC/XBVo8FycZH/97izx3unIeSIXewbGpXzxozEpDa0KoDO5nB1BPt6kEy2nwYe+ktK
         ULDVY7ldvYzRgwaV+Q3R9oH2JV2F7htBfQUj7H1Iysl5KzIuWGpuijgNz9Ax0JP7xbuP
         fmOpsE8lk9G/4rOhHLQ+V8qwPXsooPhquUmD0byebNBccEHfMkaHLjhdKisIwYGt/C+t
         jN1JLY/4SWN1ZUgatUFAI6z9YwIkzwC5Y8/xd/9PC8dH7cPw1uMClwZam8baIr9sld6u
         SOVg==
X-Gm-Message-State: AOAM530HFZ29em1Ug7FHAifKacXhnTJTxf8Ul2SXXkqlNsnWqpbH0vPk
        zC4kUcALTkG/xnf/XHUeyZe67w==
X-Google-Smtp-Source: ABdhPJxSObmvqqIUqyaO8bckPQPwosFevcqzTsh/6pHi7EUtRb/75dw4Xhrj0P6SHQfE69PXc3m4vg==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr1639272wrp.387.1598672355845;
        Fri, 28 Aug 2020 20:39:15 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v3sm1735083wmh.6.2020.08.28.20.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 0/4] wcn36xx: Update firmware config to support wcn3680
Date:   Sat, 29 Aug 2020 04:39:58 +0100
Message-Id: <20200829034002.2167878-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is five of a set of five to add support for wcn3680 at 802.11ac
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

