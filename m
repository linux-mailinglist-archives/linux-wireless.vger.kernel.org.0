Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001FB20699
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfEPME0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 08:04:26 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:50296 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbfEPME0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 08:04:26 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7438830C028;
        Thu, 16 May 2019 05:04:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7438830C028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558008264;
        bh=dBQ7wOWb8vHyzDFjehrxS5D9D4zyA2ZgYyo5CQsISQU=;
        h=From:To:Cc:Subject:Date:From;
        b=VZIxYZ1kONcsFcYCd2c6Ihqr6ZvlT3GEc5H1g6vJ8vYioUicGNLY+DQjPITHEVY1r
         DiMcfSayLr+iwEgzdvBGTc506LUdioCtSRFmGM6Y8WLpXrHqMqx42Tg1slmDaaJt5m
         JPR02cPn4tSh2KBzqkZQbeegSL+1AE8FkevkX1tA=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id A358160D5E;
        Thu, 16 May 2019 05:04:24 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 56426B036B8; Thu, 16 May 2019 14:04:23 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 0/7] brcm80211: SPDX tags and Kconfig cleanup
Date:   Thu, 16 May 2019 14:04:04 +0200
Message-Id: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series consist of:
* adding SPDX identifiers.
* clean Kconfig files.

The patches apply to the master branch of the wireless-drivers-next
repository.

Arend van Spriel (7):
  brcm80211: switch common header files to using SPDX license identifier
  brcmutil: switch source files to using SPDX license identifier
  brcmsmac: switch source files to using SPDX license identifier
  brcmsmac: switch phy source files to using SPDX license identifier
  brcmfmac: switch source files to using SPDX license identifier
  brcmfmac: use separate Kconfig file for brcmfmac
  brcm80211: select WANT_DEV_COREDUMP conditionally for brcmfmac

 drivers/net/wireless/broadcom/brcm80211/Kconfig    | 52 +---------------------
 drivers/net/wireless/broadcom/brcm80211/Makefile   | 14 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/Kconfig   | 50 +++++++++++++++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/Makefile  | 14 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/bcdc.c    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/bcdc.h    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c  | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.h  | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h | 13 +-----
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 13 +-----
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/chip.h    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/common.h  | 16 ++-----
 .../broadcom/brcm80211/brcmfmac/commonring.c       | 16 ++-----
 .../broadcom/brcm80211/brcmfmac/commonring.h       | 16 ++-----
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/debug.c   | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/debug.h   | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/feature.h | 13 +-----
 .../broadcom/brcm80211/brcmfmac/firmware.c         | 13 +-----
 .../broadcom/brcm80211/brcmfmac/firmware.h         | 13 +-----
 .../broadcom/brcm80211/brcmfmac/flowring.c         | 16 ++-----
 .../broadcom/brcm80211/brcmfmac/flowring.h         | 16 ++-----
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.c    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    | 13 +-----
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       | 13 +-----
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         | 13 +-----
 .../broadcom/brcm80211/brcmfmac/fwsignal.h         | 14 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  | 16 ++-----
 .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.h  | 16 ++-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 16 ++-----
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.h    | 16 ++-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/pno.c | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/pno.h | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/proto.c   | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/proto.h   | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.h    | 13 +-----
 .../broadcom/brcm80211/brcmfmac/tracepoint.c       | 13 +-----
 .../broadcom/brcm80211/brcmfmac/tracepoint.h       | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.h | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/vendor.c  | 13 +-----
 .../wireless/broadcom/brcm80211/brcmfmac/vendor.h  | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/Makefile  | 15 +------
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.c | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.h | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.h   | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/antsel.c  | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/antsel.h  | 13 +-----
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac.h      | 13 +-----
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h  | 13 +-----
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_tx.h   | 13 +-----
 .../brcm80211/brcmsmac/brcms_trace_events.c        | 13 +-----
 .../brcm80211/brcmsmac/brcms_trace_events.h        | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/channel.c | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/channel.h | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmsmac/d11.h | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/debug.c   | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/debug.h   | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmsmac/led.c |  5 ++-
 .../net/wireless/broadcom/brcm80211/brcmsmac/led.h | 13 +-----
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      | 13 +-----
 .../broadcom/brcm80211/brcmsmac/mac80211_if.h      | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/main.h    | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c      | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h      | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h      | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.h      | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_qmath.c    | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_qmath.h    | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phy_radio.h    | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phyreg_n.h     | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c   | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.h   | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phytbl_n.c     | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy/phytbl_n.h     | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy_shim.c         | 13 +-----
 .../broadcom/brcm80211/brcmsmac/phy_shim.h         | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmsmac/pmu.c | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmsmac/pmu.h | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmsmac/pub.h | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/rate.c    | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/rate.h    | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmsmac/scb.h | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmsmac/stf.c | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmsmac/stf.h | 13 +-----
 .../wireless/broadcom/brcm80211/brcmsmac/types.h   | 13 +-----
 .../broadcom/brcm80211/brcmsmac/ucode_loader.c     | 13 +-----
 .../broadcom/brcm80211/brcmsmac/ucode_loader.h     | 13 +-----
 .../wireless/broadcom/brcm80211/brcmutil/Makefile  | 13 +-----
 .../net/wireless/broadcom/brcm80211/brcmutil/d11.c | 13 +-----
 .../wireless/broadcom/brcm80211/brcmutil/utils.c   | 13 +-----
 .../broadcom/brcm80211/include/brcm_hw_ids.h       | 13 +-----
 .../broadcom/brcm80211/include/brcmu_d11.h         | 13 +-----
 .../broadcom/brcm80211/include/brcmu_utils.h       | 13 +-----
 .../broadcom/brcm80211/include/brcmu_wifi.h        | 13 +-----
 .../broadcom/brcm80211/include/chipcommon.h        | 13 +-----
 .../net/wireless/broadcom/brcm80211/include/defs.h | 13 +-----
 .../net/wireless/broadcom/brcm80211/include/soc.h  | 13 +-----
 116 files changed, 190 insertions(+), 1418 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig

-- 
1.9.1

