Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E565249712
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHSHYK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHSHYH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA4C061389
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so20426722wrs.11
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsVXzDUh8MSTqm2kJIMH1ILxZMj9Q7PLK1CKvJZ+9l8=;
        b=V5eeAlOUYEHJ8ZrlTU7nUp0JpgbrlR2tFI101pSt4CnefvbR5TwBmuz8VD2aLBVpCI
         3jnZo1rpi4o6b18XdWXe5L3XPeb/B/X54N9sD/8SN8LBn0psS9L1Bxo5JyoYe/2J8xx2
         P1N3C4wIrY8yOVucp3oz+TYyYyEH/rtV/cfSJC4B2VyNWfaCyi0MswYOPP2QxrHGy104
         /PwQmUf3pMslYjRrFAHfUnrj3ytL+ER0VbKeg0gRGwYXWo0SoWEpToJUlU/h7kSt+hP9
         C+wFq3AgJIAe9tR5utusBFOeyza5yUUqF86Vpfwf36lQhXW/WFYqmZfIH9gL14dJ7yvG
         0imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsVXzDUh8MSTqm2kJIMH1ILxZMj9Q7PLK1CKvJZ+9l8=;
        b=SWiJ575CAmVbgQHH0FQIKaj87wsWt/ZCu0WtJ6ErrptdCp2gczIhuTcy5BvXDGHmTU
         SIStJy3j51iWNtRiS0tpGDQbLjctqKw294Tszk1gKVYR9tMG8DXceIerRW1qMlNu8hqb
         TvDM1wDsJ3+rAOUN6tr2fCKPIN2jb9+N0doXUEFw/fW9FwtoDcMzf8soxFd0tZjsGdr2
         AnIz+W7srRW0lMJyVZ6EVe7LMicTA/F4IRAcRdx+9e3na9KS9Bel9BQ3GZGsGMVYHTL2
         /aEg8OKpqm4QM+2qBmjoG5xnDR/65PcmDYJwauo9zsPWXdUW6KLRVDmt28/D5IQ/3PRh
         oD0A==
X-Gm-Message-State: AOAM530gM099gA/CaVyHB8M81PUj7FT36QkYEKzZzoGZifhS/z+m4kYZ
        pLBFD7G0Nx30O0oveRjJrSLSZQ==
X-Google-Smtp-Source: ABdhPJxW3qEO6HuxfNnOg0DDS92mwarpceEYLMHp4h5prZjPvHxa0x42qlIMG/IR4HAdr58OgI2bPw==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr23807713wrv.202.1597821845393;
        Wed, 19 Aug 2020 00:24:05 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/28] Rid W=1 warnings in Wireless
Date:   Wed, 19 Aug 2020 08:23:34 +0100
Message-Id: <20200819072402.3085022-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

There are quite a few W=1 warnings in the Wireless.  My plan
is to work through all of them over the next few weeks.
Hopefully it won't be too long before drivers/net/wireless
builds clean with W=1 enabled.

This set brings the total number of (arm, arm64, x86, mips and
ppc *combined* i.e. some duplicated) warnings down from 6154
to 4983.

Lee Jones (28):
  wireless: intersil: hostap: Mark 'freq_list' as __maybe_unused
  wireless: rsi_91x_main: Fix some kernel-doc issues
  wireless: rsi_91x_core: File header should not be kernel-doc
  wireless: marvell: libertas_tf: Demote non-conformant kernel-doc
    headers
  wireless: intel: dvm: Demote non-compliant kernel-doc headers
  wireless: ti: wlcore: cmd: Fix some parameter description disparities
  wireless: marvell: libertas_tf: Fix a bunch of function doc formatting
    issues
  wireless: intel: iwlwifi: rs: Demote non-compliant kernel-doc headers
  wireless: intel: iwlegacy: debug: Demote seemingly unintentional
    kerneldoc header
  wireless: intel: iwlwifi: dvm: tx: Demote non-compliant kernel-doc
    headers
  wireless: intersil: hostap: hostap_ap: Mark 'txt' as __always_unused
  wireless: intel: iwlwifi: dvm: lib: Demote non-compliant kernel-doc
    headers
  wireless: st: cw1200: wsm: Remove 'dummy' variables
  wireless: marvell: libertas: Fix 'timer_list' stored private data
    related dot-rot
  wireless: mediatek: mt7601u: phy: Fix misnaming when documented
    function parameter 'dac'
  wireless: marvell: mwifiex: init: Move 'tos_to_tid_inv' to where it's
    used
  wireless: rsi: rsi_91x_main: Fix misnamed function parameter 'rx_pkt'
  wireless: rsi: rsi_91x_mac80211: Fix a few kerneldoc misdemeanours
  wireless: intel: iwlwifi: calib: Demote seemingly unintentional
    kerneldoc header
  wireless: rsi: rsi_91x_mgmt: Fix a myriad of documentation issues
  wireless: ath: wil6210: debugfs: Fix a couple of formatting issues in
    'wil6210_debugfs_init'
  wireless: intel: iwlwifi: dvm: sta: Demote a bunch of nonconformant
    kernel-doc headers
  wireless: rsi: rsi_91x_hal: File header comments should not be
    kernel-doc
  wireless: intel: iwlegacy: 4965: Demote a bunch of nonconformant
    kernel-doc headers
  wireless: broadcom: brcmfmac: p2p: Deal with set but unused variables
  wireless: marvell: libertas: firmware: Fix misnaming for function
    param 'device'
  wireless: marvell: libertas_tf: if_usb: Fix function documentation
    formatting errors
  wireless: intersil: hostap_ioctl: Remove set but unused variable
    'hostscan'

 drivers/net/wireless/ath/wil6210/debugfs.c    |  8 ++--
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  6 +--
 drivers/net/wireless/intel/iwlegacy/4965.c    | 25 ++++++-------
 drivers/net/wireless/intel/iwlegacy/debug.c   |  3 +-
 .../net/wireless/intel/iwlwifi/dvm/calib.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 11 +++---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   | 12 +++---
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c  | 22 +++++------
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |  4 +-
 drivers/net/wireless/intersil/hostap/hostap.h |  6 ++-
 .../net/wireless/intersil/hostap/hostap_ap.c  |  2 +-
 .../wireless/intersil/hostap/hostap_ioctl.c   |  3 +-
 .../net/wireless/marvell/libertas/firmware.c  |  4 +-
 drivers/net/wireless/marvell/libertas/main.c  |  6 +--
 .../net/wireless/marvell/libertas_tf/cmd.c    | 22 +++++------
 .../net/wireless/marvell/libertas_tf/if_usb.c | 37 ++++++++++---------
 .../net/wireless/marvell/libertas_tf/main.c   |  6 +--
 drivers/net/wireless/marvell/mwifiex/init.c   | 16 ++++++++
 drivers/net/wireless/marvell/mwifiex/tdls.c   | 16 ++++++++
 drivers/net/wireless/marvell/mwifiex/wmm.h    | 15 --------
 drivers/net/wireless/mediatek/mt7601u/phy.c   |  2 +-
 drivers/net/wireless/rsi/rsi_91x_core.c       |  2 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c        |  2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  9 +++--
 drivers/net/wireless/rsi/rsi_91x_main.c       |  5 ++-
 drivers/net/wireless/rsi/rsi_91x_mgmt.c       | 30 ++++++++++-----
 drivers/net/wireless/st/cw1200/wsm.c          |  6 +--
 drivers/net/wireless/ti/wlcore/cmd.c          |  5 ++-
 29 files changed, 157 insertions(+), 134 deletions(-)

-- 
2.25.1

