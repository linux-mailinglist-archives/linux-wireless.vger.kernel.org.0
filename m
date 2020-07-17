Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3832230ED
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgGQCCm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgGQCCJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:09 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CECCC08C5C0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:09 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c25so5786299otf.7
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPDp78kEsFZmtm4OyObQr5U4nAvZIoSUFkMNaG295Vg=;
        b=SYFUWpRhM/rQhvI7Fr6CGh4WDmsjuDUKiD8hcQZbxAVb8EIhaHTeOdXmEAHdPSMlnj
         c6ON7HOs+G2/KTgqW6Xy7QbNVCHCab6k/pN0Dxg9ZsjYWq2sdijxD6s7QSERl0kWMaH4
         3p2FyEB9+qnRngy/tXOHA2h0hGJvk7TZkdiFJMB1q4bkQfxmytE01Ia7/ZAXps04W+ZE
         VhofMvgPM8MvNTWrUwvlMn0MjKqNblvPqiOwKwyQNOI8vxqvvaPgV44NJtTHauRZ596Z
         jimkeDO5fTNLPoVYJ/oJsqrCgrce6HgBHjItKJriGdxhcS6Zm1CPOQokuVEs0PbuJ4aI
         ch+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jPDp78kEsFZmtm4OyObQr5U4nAvZIoSUFkMNaG295Vg=;
        b=bbGkz3+u3lDbkXeOyXsp4Sazvx25GvV6o9YTrWPwlOL0+sdu4jLdi5tVMqxFQ+FtmS
         i3qs0QdDYHqasYlLtu9TvTfu/BSVGWZ4QF/VDL0rcorq+3saImP2+1LbTb7v+vYhO/jP
         PWojfj9ahbfZhAuzLCdeWIxkJDu4jUiHEM/BtI5KVpbfkhlGHf/AUlaxptUTbtwVMzPS
         tEd5MrVEnJ+sQ7kQ+YGo4aRX3acuEidLGXNlYG6o2qwcLTbOCW5i/j6yrtdubr91Z1xM
         m8HDP80ahumLZxlJR5g6aqghgTIlN+kVoFOW1IkdocKn5fq0rX29LXWSI+7u8H35UlX3
         n1gg==
X-Gm-Message-State: AOAM5333y5FTpA1KK2HTGX+RM0QCTws+KcpvYTxNV/rMP1zcU4NWjY2x
        HmzRxPZDVVRVYvv+hhogHMs1KxBG
X-Google-Smtp-Source: ABdhPJxA1bUF9LL0wO52y+/WFUWo+nUJcxpmI+zYHj/hzCjuhlWu13Ag7/8GUylBTyq4dowCNZThoA==
X-Received: by 2002:a05:6830:3110:: with SMTP id b16mr6818711ots.80.1594951328696;
        Thu, 16 Jul 2020 19:02:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:08 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 00/14] rtlwifi: Change RT_TRACE into RT_DEBUG for all drivers
Date:   Thu, 16 Jul 2020 21:01:47 -0500
Message-Id: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The drivers in the rtlwifi family use a macro named RT_TRACE to log
some debugging information. The name choice is unfortunate in that
it suggests tracing, which it does not. Convert each of them to
RT_DEBUG instead.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>


Larry Finger (14):
  rtlwifi: Replace RT_TRACE with RT_DEBUG
  rtlwifi: btcoexist: Replace RT_TRACE with RT_DEBUG
  rtlwifi: rtl8188ee: Change RT_TRACE to RT_DEBUG
  rtlwifi: rtl8192c_common: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8192ce: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8192cu: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8192de: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8192ee: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8192se: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8723ae: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8723be: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8723-common: Rename RT_TRACE to RT_DEBUG
  rtlwifi: rtl8821ae: Rename RT_TRACE to RT_DEBUG
  rtlwifi: Remove final instances of RT_TRACE macros

 drivers/net/wireless/realtek/rtlwifi/base.c   |  72 ++--
 .../rtlwifi/btcoexist/halbtc8192e2ant.c       | 286 +++++++--------
 .../rtlwifi/btcoexist/halbtc8723b1ant.c       | 156 ++++-----
 .../rtlwifi/btcoexist/halbtc8723b2ant.c       | 300 ++++++++--------
 .../rtlwifi/btcoexist/halbtc8821a1ant.c       | 286 +++++++--------
 .../rtlwifi/btcoexist/halbtc8821a2ant.c       | 308 ++++++++--------
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c  |  14 +-
 .../realtek/rtlwifi/btcoexist/rtl_btc.c       |   4 +-
 drivers/net/wireless/realtek/rtlwifi/cam.c    |  38 +-
 drivers/net/wireless/realtek/rtlwifi/core.c   | 130 +++----
 drivers/net/wireless/realtek/rtlwifi/debug.c  |   2 +-
 drivers/net/wireless/realtek/rtlwifi/debug.h  |   4 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c  |  38 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c    | 116 +++---
 drivers/net/wireless/realtek/rtlwifi/ps.c     |  40 +--
 drivers/net/wireless/realtek/rtlwifi/regd.c   |   8 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/dm.c   |  76 ++--
 .../wireless/realtek/rtlwifi/rtl8188ee/fw.c   |  44 +--
 .../wireless/realtek/rtlwifi/rtl8188ee/hw.c   |  88 ++---
 .../wireless/realtek/rtlwifi/rtl8188ee/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/phy.c  | 132 +++----
 .../wireless/realtek/rtlwifi/rtl8188ee/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.c  |  12 +-
 .../realtek/rtlwifi/rtl8192c/dm_common.c      |  66 ++--
 .../realtek/rtlwifi/rtl8192c/fw_common.c      |  40 +--
 .../realtek/rtlwifi/rtl8192c/phy_common.c     |  82 ++---
 .../wireless/realtek/rtlwifi/rtl8192ce/dm.c   |  16 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   |  82 ++---
 .../wireless/realtek/rtlwifi/rtl8192ce/led.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/phy.c  |  46 +--
 .../wireless/realtek/rtlwifi/rtl8192ce/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.c  |   8 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/dm.c   |  16 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   |  66 ++--
 .../wireless/realtek/rtlwifi/rtl8192cu/led.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/mac.c  |  30 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/phy.c  |  48 +--
 .../wireless/realtek/rtlwifi/rtl8192cu/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  |  28 +-
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 110 +++---
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   |  46 +--
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   |  98 +++---
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  | 182 +++++-----
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  20 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/dm.c   |  24 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/fw.c   |  48 +--
 .../wireless/realtek/rtlwifi/rtl8192ee/hw.c   | 100 +++---
 .../wireless/realtek/rtlwifi/rtl8192ee/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/phy.c  | 148 ++++----
 .../wireless/realtek/rtlwifi/rtl8192ee/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/trx.c  |  14 +-
 .../wireless/realtek/rtlwifi/rtl8192se/dm.c   |  14 +-
 .../wireless/realtek/rtlwifi/rtl8192se/fw.c   |  14 +-
 .../wireless/realtek/rtlwifi/rtl8192se/hw.c   |  80 ++---
 .../wireless/realtek/rtlwifi/rtl8192se/led.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192se/phy.c  |  88 ++---
 .../wireless/realtek/rtlwifi/rtl8192se/rf.c   |  26 +-
 .../wireless/realtek/rtlwifi/rtl8192se/sw.c   |   2 +-
 .../wireless/realtek/rtlwifi/rtl8192se/trx.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/dm.c   |  58 +--
 .../wireless/realtek/rtlwifi/rtl8723ae/fw.c   |  32 +-
 .../rtlwifi/rtl8723ae/hal_bt_coexist.c        |  72 ++--
 .../realtek/rtlwifi/rtl8723ae/hal_btc.c       | 330 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 112 +++---
 .../wireless/realtek/rtlwifi/rtl8723ae/led.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/phy.c  | 108 +++---
 .../wireless/realtek/rtlwifi/rtl8723ae/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.c  |   8 +-
 .../wireless/realtek/rtlwifi/rtl8723be/dm.c   |  44 +--
 .../wireless/realtek/rtlwifi/rtl8723be/fw.c   |  32 +-
 .../wireless/realtek/rtlwifi/rtl8723be/hw.c   |  88 ++---
 .../wireless/realtek/rtlwifi/rtl8723be/led.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8723be/phy.c  | 130 +++----
 .../wireless/realtek/rtlwifi/rtl8723be/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8723be/trx.c  |  12 +-
 .../realtek/rtlwifi/rtl8723com/fw_common.c    |  10 +-
 .../realtek/rtlwifi/rtl8723com/phy_common.c   |  12 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   | 282 +++++++--------
 .../wireless/realtek/rtlwifi/rtl8821ae/fw.c   |  64 ++--
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 222 ++++++------
 .../wireless/realtek/rtlwifi/rtl8821ae/led.c  |  14 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/phy.c  | 236 ++++++-------
 .../wireless/realtek/rtlwifi/rtl8821ae/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.c  |  24 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c    |   8 +-
 87 files changed, 2847 insertions(+), 2847 deletions(-)

-- 
2.27.0

