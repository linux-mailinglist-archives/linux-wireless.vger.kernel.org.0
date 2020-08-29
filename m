Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964E325646A
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgH2Dij (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgH2DiZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736D6C061232
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x7so890533wro.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKRbJaiUJBWTHctvzCqT4yNeW9TImmNoQUF8BM+9A6g=;
        b=cnJK2eZHANPkj+GbM6nXbMpq+aPoMSySjBIODqupNqQbHo2OC5m1idBt1yw2tBtH02
         NR51GOm11/tJieJkC6oXQjn2FBAKYh7FB2K2CdCrBQfBQ/0NHQJNRMYVGByHLu82eLk2
         UZeny1IexeOiRG05Tr79MtDhmfJu8exMS9W1OWC1N91pmcIp4vRhVjgMaU2gjiKUjhei
         7la8BI/6BXFuQyN33nK5Td7fm4s/DXlkpGc+ggX/qAosxAkLXDhVRMNiXHlz6jjIJ78u
         NqWm116nioy14o1YNeMdkxwFB7jrbAco3i/kpFzS+eXqTogU8K27/qlOu4Ar2rjDBpSE
         F3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKRbJaiUJBWTHctvzCqT4yNeW9TImmNoQUF8BM+9A6g=;
        b=ZYmJTZCZbGhjpoet+qF73rY2+De/b8qiZ6nZJXejdp6H+Gtrk+qnTr48acMpz+i1T/
         Ezq7tOnRTYvVYXz12s4u++TmGsmLBaZmV+ihaU/VKkAvOEP/aTQOWS7LFUE4gJDB5P3t
         x12trx/XfhVuh4mi3XgwKVHRwB1xDu5y+eipDevi6KlB41AECvuFVtjFL2tz/58NQz/Q
         AEuLRdytBs7rV4vC1yBOOl0nA5snxKmxpNcVX1zsDnFFfLzKvUlmFtD2Fu20Xc/OkTQg
         p0/8Y/uGEpv7ekNPquagUldAOwcL6hKk1GCh55P3tzPh3qOaqiCITJnCr6kUm+lcywmP
         swTw==
X-Gm-Message-State: AOAM530nxC77YYG47iq2AgIiSLt1SVgG2VKqWOfwpxSdkrpzeYoJBlV/
        sGaw4DiWyLyTus74kMmUAUg2+w==
X-Google-Smtp-Source: ABdhPJxetE4BdWz9D5jF4lzc/qLSnme3SDfAPn+WsalA4r4Kryr3z7xgq5WFNJtpN93+BjpYRjxQXg==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr1655532wro.319.1598672302169;
        Fri, 28 Aug 2020 20:38:22 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:21 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 00/12] wcn36xx: Add support for extended V1 SMD parameter passing
Date:   Sat, 29 Aug 2020 04:38:56 +0100
Message-Id: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is two of a set of five to add support for wcn3680 at 802.11ac
data-rates.

This set makes a series of modifications to enable passing of an extended
V1 data-structure to the firmware.

A series of of helper functions are added to facilitate the setup.

The final step in the process is enabling the extended data-structure
parameter passing for the wcn3680 only.

Only a firmware that is capable of 80211.ac will accept the larger V1
messages and only after explicitly enabling the DOT11AC firmware feature
bit.

V2:
- No functional difference from V1 for these patches
  Breaking into smaller chunks to enable easier review/merging

V1:

https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t

Bryan O'Donoghue (12):
  wcn36xx: Add VHT fields to parameter data structures
  wcn36xx: Use V1 data structure to store supported rates
  wcn36xx: Add wcn36xx_set_default_rates_v1
  wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
  wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
  wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
  wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
  wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
  wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
  wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()
  wcn36xx: Define INIT_HAL_MSG_V1()
  wcn36xx: Convert to VHT parameter structure on wcn3680

 drivers/net/wireless/ath/wcn36xx/hal.h     |  14 ++-
 drivers/net/wireless/ath/wcn36xx/main.c    |  16 +++
 drivers/net/wireless/ath/wcn36xx/smd.c     | 117 +++++++++++++++++++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   3 +-
 4 files changed, 142 insertions(+), 8 deletions(-)

-- 
2.27.0

