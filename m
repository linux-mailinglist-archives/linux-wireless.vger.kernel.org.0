Return-Path: <linux-wireless+bounces-3214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E64984B1B3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BB5285DC6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265A12D777;
	Tue,  6 Feb 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HErc9xaB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBEF12D75C;
	Tue,  6 Feb 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213444; cv=none; b=tMVMTBgAlSIQtYYLpg4Iq0knHHY07dH3jZcSDEDhGJdyT8xnsqjtJYVuOVos5uNifYc4/VE1tnI5RYly47eB1Jdys//aC3mxjKDwwIT6DCHHzYuFUyD5PyHeC0NHa1Yd+nwsHCt+/5bTefcHSSsmJFC6nkrAW5bJaTjFXS4+qY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213444; c=relaxed/simple;
	bh=BV60uJJEOLl64kdc0nfcK/o6eoOdfETmPsoBrcGKdU8=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=k1ni/zn2OsVv7bayBh+yUEozaCR9CSpnAkbt7qOHxaFVgH2I42A9djw7QAbToQPboYB1cEiZwAjdcGJrtFou8f1BNi/4hKvAaBKBbSWwWfoGGJTDRw945c/zxHUw+uag43rdx9jCF+WcurcNNxWanC9ZTz5CKfxAILE0k5N91vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HErc9xaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9D2C433F1;
	Tue,  6 Feb 2024 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707213443;
	bh=BV60uJJEOLl64kdc0nfcK/o6eoOdfETmPsoBrcGKdU8=;
	h=From:Subject:To:Cc:Date:From;
	b=HErc9xaBY75qYJ6ImtYh3kYt4fub9BnHlR9Z1lhSunbl/VEJicMGXlrq/XxDdF8ek
	 wNavgTDX/DGBY8dZeyVncDYWxZCN6dqfVo6HaUjVhgmVC/fIGahmrAZiMXFXSh7XNW
	 IkHkDiP/iXGUB5S3f/UqF/1Q4zMlZlKREiXITYLnd9xuNsttxP4JtO/M3Uo3WAA85m
	 bs1Ak4lIv17eu57wRal367aCX1xxupPPaNDrttUabRzo8VYar5WmK9gKpZYhcQ7PPG
	 l6B84bSNUn5wHc0Fm24i9WjceDVOYzWxVPJVFKjg4+s87020NCmS0m5yXAbtx2KsZI
	 9vmQUuvGGRDvg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-02-06
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240206095722.CD9D2C433F1@smtp.kernel.org>
Date: Tue,  6 Feb 2024 09:57:22 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7:

  Merge tag 'net-6.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-01-25 10:58:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-02-06

for you to fetch changes up to 0647903efbc84b772325b4d24d9487e24d6d1e03:

  wifi: mt76: mt7996: fix fortify warning (2024-02-05 20:00:45 +0200)

----------------------------------------------------------------
wireless fixes for v6.8-rc4

This time we have unusually large wireless pull request. Several
functionality fixes to both stack and iwlwifi. Lots of fixes to
warnings, especially to MODULE_DESCRIPTION().

----------------------------------------------------------------
Arend van Spriel (1):
      MAINTAINERS: wifi: brcm80211: cleanup entry

Benjamin Berg (2):
      wifi: iwlwifi: mvm: skip adding debugfs symlink for reconfig
      wifi: iwlwifi: do not announce EPCS support

Breno Leitao (9):
      wifi: fill in MODULE_DESCRIPTION()s for wlcore
      wifi: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx
      wifi: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
      wifi: fill in MODULE_DESCRIPTION()s for ar5523
      wifi: fill in MODULE_DESCRIPTION()s for wcn36xx
      wifi: fill in MODULE_DESCRIPTION()s for p54spi
      wifi: fill in MODULE_DESCRIPTION()s for wl18xx
      wifi: fill in MODULE_DESCRIPTION()s for wilc1000
      wifi: fill in MODULE_DESCRIPTION()s for mt76 drivers

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix a battery life regression

Felix Fietkau (1):
      wifi: mt76: mt7996: fix fortify warning

Gregory Greenman (1):
      MAINTAINERS: remove myself as iwlwifi driver maintainer

Johannes Berg (13):
      wifi: iwlwifi: fix double-free bug
      wifi: cfg80211: fix wiphy delayed work queueing
      wifi: iwlwifi: remove extra kernel-doc
      wifi: cfg80211: detect stuck ECSA element in probe resp
      wifi: mac80211: improve CSA/ECSA connection refusal
      wifi: mac80211: fix RCU use in TDLS fast-xmit
      wifi: mac80211: set station RX-NSS on reconfig
      wifi: mac80211: fix driver debugfs for vif type change
      wifi: mac80211: initialize SMPS mode correctly
      wifi: mac80211: fix unsolicited broadcast probe config
      wifi: mac80211: fix waiting for beacons logic
      wifi: mac80211: adding missing drv_mgd_complete_tx() call
      wifi: mac80211: accept broadcast probe responses on 6 GHz

Kees Cook (1):
      wifi: brcmfmac: Adjust n_channels usage for __counted_by

Mario Limonciello (1):
      wifi: mac80211: Drop WBRF debugging statements

Miri Korenblit (1):
      wifi: iwlwifi: exit eSR only after the FW does

 MAINTAINERS                                        |   9 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |   1 +
 drivers/net/wireless/ath/wcn36xx/main.c            |   1 +
 .../broadcom/brcm80211/brcmfmac/bca/module.c       |   1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   6 +-
 .../broadcom/brcm80211/brcmfmac/cyw/module.c       |   1 +
 .../broadcom/brcm80211/brcmfmac/wcc/module.c       |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   9 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |   1 +
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |   1 +
 .../net/wireless/mediatek/mt76/mt7615/usb_sdio.c   |   1 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |   1 +
 .../net/wireless/mediatek/mt76/mt76x02_usb_mcu.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/sdio.c          |   1 +
 drivers/net/wireless/mediatek/mt76/usb.c           |   1 +
 drivers/net/wireless/mediatek/mt76/util.c          |   1 +
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   1 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   1 +
 drivers/net/wireless/microchip/wilc1000/spi.c      |   1 +
 drivers/net/wireless/ti/wl1251/sdio.c              |   1 +
 drivers/net/wireless/ti/wl1251/spi.c               |   1 +
 drivers/net/wireless/ti/wl12xx/main.c              |   1 +
 drivers/net/wireless/ti/wl18xx/main.c              |   1 +
 drivers/net/wireless/ti/wlcore/main.c              |   1 +
 drivers/net/wireless/ti/wlcore/sdio.c              |   1 +
 drivers/net/wireless/ti/wlcore/spi.c               |   1 +
 include/net/cfg80211.h                             |   4 +
 net/mac80211/cfg.c                                 |  16 +--
 net/mac80211/debugfs_netdev.c                      |   4 +-
 net/mac80211/debugfs_netdev.h                      |   5 -
 net/mac80211/iface.c                               |   2 +-
 net/mac80211/mlme.c                                | 114 +++++++++++++++------
 net/mac80211/scan.c                                |  30 +++---
 net/mac80211/tx.c                                  |   7 +-
 net/mac80211/wbrf.c                                |   2 -
 net/wireless/core.c                                |   3 +-
 net/wireless/scan.c                                |  59 ++++++++++-
 65 files changed, 247 insertions(+), 88 deletions(-)


