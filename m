Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365DE22B7F0
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgGWUmt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWUmt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:49 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49187C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g37so5373936otb.9
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqOHjF3klNx+L4oGCWc1Ee1EwpvEUToDvet6PODYFTo=;
        b=Fv7/EED1pt6AzqJOzQlZlYb61FspOPDY0/h2VhyQipmHF41NOUpWgCWKuFV6H7gkK4
         5mEcHpFYJ+u6Sel5dwbFNRgSIZnCCvz+YXxbF82qc6+1AIdvYDuUgNzWebGvJuAt8oBT
         nbUQgDD2z7p1GJSxqvkrR9lqDmd3bP8UwwPVsjIJ54GDL+4evaG6aKRATsv/Y7QGqstn
         GFq463Oeb9grtIShx3BAWrKbr4gRVQthiwxws4852pQpdmwnNXmEeg4KHqE+t9KxDPpb
         4tkR8iIRui24mtRTy3YFjJTEL7MreC+bO9mP64pGjXQ/ir6VRW+OKo/29rtNgHQrLFU7
         QvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vqOHjF3klNx+L4oGCWc1Ee1EwpvEUToDvet6PODYFTo=;
        b=YbrMOHkKT46o5HhlugkOGtDlRQps/4RxgvkfrUEblmk8Zf7DXQ1Ie61/QjI3WqyS9o
         M6Qvzl8ZSOy0idpCPjuhuuCaFbOi32VvvqOda0YTU0EBfucOQheNsuvP7P/vXmTDhU2Q
         xyluOeBj1MkMwlKx3lZ3YPt+X5sFZykLBelnf+1nCxQjRnF/g12atk/MFykkVyfwH6sw
         iTJlJVSQj0Yo8hx4SNWVJzEJ65E60zv8e0NljKuh3S+dK8ST2zmSY53p94bIMIjR4RbT
         tDXh6CWBXMtiXbqPQeBA0+d+H86eiOKtL3/16PnYhpjMc5hTEeiyy9BsJaDA3nfs5Q15
         XQLQ==
X-Gm-Message-State: AOAM530Ft1Ngjg+f86t+NawYmcjSbt571/TxS7sZCQM1ygXaUf1rvV4/
        QhvmnnZpEnQ6ARWs8/W+6h00z5vW
X-Google-Smtp-Source: ABdhPJzKLYrFZYCZ7sAUG0z9cXMaancbHPnNmFCuVzLrwY9XrDeyxjmeBEvT6/eyiDQ13vZMsGsC7g==
X-Received: by 2002:a05:6830:1ad7:: with SMTP id r23mr5487313otc.96.1595536968611;
        Thu, 23 Jul 2020 13:42:48 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:47 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 00/15] rtlwifi: Change RT_TRACE into rtl_dbg for all drivers
Date:   Thu, 23 Jul 2020 15:42:29 -0500
Message-Id: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
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
rtl_dbg instead.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

v2 - accept Joe Perches suggestion to use rtl_dbg instead of RT_DEBUG
   - original patch is split into two
   - _rtl_dbg_trace is renamed to _rtl_dbg_out

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

---
Larry Finger (15):
  rtlwifi: Start changing RT_TRACE into rtl_dbg
  rtlwifi: Replace RT_TRACE with rtl_dbg
  rtlwifi: btcoexist: Replace RT_TRACE with rtl_dbg
  rtlwifi: rtl8188ee: Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8192-common: Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8192ce: Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8192cu: Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8192de: Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8192ee: Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8192se Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8723ae Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8723be Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8723-common: Rename RT_TRACE to rtl_dbg
  rtlwifi: rtl8821ae: Rename RT_TRACE to rtl_dbg
  rtlwifi: Remove temporary definition of RT_TRACE

 drivers/net/wireless/realtek/rtlwifi/base.c   | 144 +--
 .../rtlwifi/btcoexist/halbtc8192e2ant.c       | 712 +++++++--------
 .../rtlwifi/btcoexist/halbtc8723b1ant.c       | 354 ++++----
 .../rtlwifi/btcoexist/halbtc8723b2ant.c       | 720 +++++++--------
 .../rtlwifi/btcoexist/halbtc8821a1ant.c       | 668 +++++++-------
 .../rtlwifi/btcoexist/halbtc8821a2ant.c       | 756 ++++++++--------
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c  |  28 +-
 .../realtek/rtlwifi/btcoexist/rtl_btc.c       |   6 +-
 drivers/net/wireless/realtek/rtlwifi/cam.c    |  82 +-
 drivers/net/wireless/realtek/rtlwifi/core.c   | 259 +++---
 drivers/net/wireless/realtek/rtlwifi/debug.c  |   4 +-
 drivers/net/wireless/realtek/rtlwifi/debug.h  |  14 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c  |  72 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c    | 282 +++---
 drivers/net/wireless/realtek/rtlwifi/ps.c     |  98 +--
 drivers/net/wireless/realtek/rtlwifi/regd.c   |  18 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/dm.c   | 192 ++--
 .../wireless/realtek/rtlwifi/rtl8188ee/fw.c   |  90 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/hw.c   | 194 ++--
 .../wireless/realtek/rtlwifi/rtl8188ee/led.c  |  20 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/phy.c  | 385 ++++----
 .../wireless/realtek/rtlwifi/rtl8188ee/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.c  |  24 +-
 .../realtek/rtlwifi/rtl8192c/dm_common.c      | 224 ++---
 .../realtek/rtlwifi/rtl8192c/fw_common.c      |  88 +-
 .../realtek/rtlwifi/rtl8192c/phy_common.c     | 258 +++---
 .../wireless/realtek/rtlwifi/rtl8192ce/dm.c   |  40 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   | 176 ++--
 .../wireless/realtek/rtlwifi/rtl8192ce/led.c  |  12 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/phy.c  | 121 ++-
 .../wireless/realtek/rtlwifi/rtl8192ce/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.c  |  14 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/dm.c   |  38 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 152 ++--
 .../wireless/realtek/rtlwifi/rtl8192cu/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/mac.c  |  64 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/phy.c  | 134 +--
 .../wireless/realtek/rtlwifi/rtl8192cu/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  |  58 +-
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 312 +++----
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   | 116 +--
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 206 ++---
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  | 414 ++++-----
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  30 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  20 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/dm.c   |  66 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/fw.c   | 102 +--
 .../wireless/realtek/rtlwifi/rtl8192ee/hw.c   | 208 ++---
 .../wireless/realtek/rtlwifi/rtl8192ee/led.c  |  18 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/phy.c  | 358 ++++----
 .../wireless/realtek/rtlwifi/rtl8192ee/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/trx.c  |  32 +-
 .../wireless/realtek/rtlwifi/rtl8192se/dm.c   |  42 +-
 .../wireless/realtek/rtlwifi/rtl8192se/fw.c   |  40 +-
 .../wireless/realtek/rtlwifi/rtl8192se/hw.c   | 157 ++--
 .../wireless/realtek/rtlwifi/rtl8192se/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8192se/phy.c  | 211 +++--
 .../wireless/realtek/rtlwifi/rtl8192se/rf.c   |  70 +-
 .../wireless/realtek/rtlwifi/rtl8192se/sw.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8192se/trx.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/dm.c   | 162 ++--
 .../wireless/realtek/rtlwifi/rtl8723ae/fw.c   |  64 +-
 .../rtlwifi/rtl8723ae/hal_bt_coexist.c        | 150 ++--
 .../realtek/rtlwifi/rtl8723ae/hal_btc.c       | 649 +++++++-------
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 232 ++---
 .../wireless/realtek/rtlwifi/rtl8723ae/led.c  |  12 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/phy.c  | 357 ++++----
 .../wireless/realtek/rtlwifi/rtl8723ae/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.c  |  14 +-
 .../wireless/realtek/rtlwifi/rtl8723be/dm.c   | 118 +--
 .../wireless/realtek/rtlwifi/rtl8723be/fw.c   |  66 +-
 .../wireless/realtek/rtlwifi/rtl8723be/hw.c   | 202 ++---
 .../wireless/realtek/rtlwifi/rtl8723be/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8723be/phy.c  | 310 +++----
 .../wireless/realtek/rtlwifi/rtl8723be/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8723be/trx.c  |  24 +-
 .../realtek/rtlwifi/rtl8723com/fw_common.c    |  22 +-
 .../realtek/rtlwifi/rtl8723com/phy_common.c   |  36 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   | 826 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8821ae/fw.c   | 130 +--
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 458 +++++-----
 .../wireless/realtek/rtlwifi/rtl8821ae/led.c  |  32 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/phy.c  | 530 +++++------
 .../wireless/realtek/rtlwifi/rtl8821ae/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.c  |  56 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c    |  18 +-
 87 files changed, 6732 insertions(+), 6735 deletions(-)

-- 
2.27.0

