Return-Path: <linux-wireless+bounces-25177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E0B00210
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38493B4C00
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB05257444;
	Thu, 10 Jul 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iJIEyb17"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FB2571CF;
	Thu, 10 Jul 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150679; cv=none; b=EfNW7k37/EI9wo6Vezaceg0eHgsGoiBan6VkaqtPnHBQm9A522uDulJ7FxfdopuCyhPqA9ChC1q0V4VwtWaUgnTuu1qDRiPFK8A7ZjYUIeJrlscH2L41qqck0Ge3tltZMZzuYSqCKNthX2S4ILk/hnmhXOFY39FRIIQB1LW1+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150679; c=relaxed/simple;
	bh=wwleuq+r4O77Z7bgML7ZkfL3hRKXHLUAr1jyPk3ID64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcX+g/ZLrEbq8/SdhmC2S3VTGFeqknsLNS1F+id/Uaivu/STj/TZTbso/wslYlafU3hzvxTsvuD2Ym+e6m52ZzExrKR3h/r3Qef+d+sr0l9OKkA/Q4lIZQjV1pcecNM4eEwBkbgWN3cNB97G06TZHmeibnp5M0g8FMR1j1B1ZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iJIEyb17; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZJDqWFppJ26nq+PPFvY7IkCiKDpbprvS1vtvi+f1TRE=; t=1752150678; x=1753360278; 
	b=iJIEyb17BqJeCToL/elMrX6SL/aFrW/sLuvpv7eAjUscFTThbDVUM+KcnzBaG2ML9TVGPJ3Rmca
	nrLoQRwX5w1HowL41lxJc/qiOZPsflncB/7XUA20Y+aIWRCE/ZG9Gsbi110YF+OrQPs0W8VYc6bMV
	D9yZYpOCj1V16qPlgq+ln0wH1+3y8XKK9f8wwCAAFs1Dc/0RRGZ9Vc7cZUJ8znEdt2z6ybl9vMbwm
	1Y/TPSFyyKwIOfPUF+Omxuom2kkqD9r1lGXPdh8dHuZdLZBMv5UY8el+jZFjusIdQaGY3QH9YtA2V
	kaD1KZrckzKNNiRpzEWgccFNxfYo1WZ0SfGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZqQl-0000000Em66-2raf;
	Thu, 10 Jul 2025 14:31:15 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-07-10
Date: Thu, 10 Jul 2025 14:30:48 +0200
Message-ID: <20250710123113.24878-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

And for -next, some work. There's more pending, but for
now this is what I have today.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 6b9fd8857b9fc4dd62e7cd300327f0e48dd76642:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-04 08:03:18 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-07-10

for you to fetch changes up to 6b04716cdcac37bdbacde34def08bc6fdb5fc4e2:

  wifi: mac80211: don't complete management TX on SAE commit (2025-07-09 11:56:45 +0200)

----------------------------------------------------------------
Quite a bit more work, notably:
 - mt76: firmware recovery improvements, MLO work
 - iwlwifi: use embedded PNVM in (to be released) FW images
            to fix compatibility issues
 - cfg80211/mac80211: extended regulatory info support (6 GHz)
 - cfg80211: use "faux device" for regulatory

----------------------------------------------------------------
Benjamin Berg (3):
      wifi: cfg80211: only verify part of Extended MLD Capabilities
      wifi: cfg80211: add a flag for the first part of a scan
      wifi: mac80211: copy first_part into HW scan

Dan Carpenter (2):
      wifi: iwlwifi: Fix error code in iwl_op_mode_dvm_start()
      wifi: mt76: mt7925: fix off by one in mt7925_mcu_hw_scan()

David Bauer (3):
      wifi: mt76: mt7915: mcu: increase eeprom command timeout
      wifi: mt76: mt7915: mcu: lower default timeout
      wifi: mt76: mt7915: mcu: re-init MCU before loading FW patch

Felix Fietkau (1):
      wifi: mt76: fix vif link allocation

Greg Kroah-Hartman (1):
      wifi: cfg80211: move away from using a fake platform device

Hari Chandrakanthan (1):
      wifi: mac80211: fix rx link assignment for non-MLO stations

Johannes Berg (14):
      Merge tag 'mt76-next-2025-07-07' of https://github.com/nbd168/wireless
      wifi: iwlwifi: use PNVM data embedded in .ucode files
      wifi: iwlwifi: mvm/mld: make PHC messages debug messages
      wifi: iwlwifi: remove Intel driver load message
      wifi: iwlwifi: match discrete/integrated to fix some names
      wifi: iwlwifi: pcie: rename iwl_pci_gen1_2_probe() argument
      Merge tag 'iwlwifi-next-2025-07-09' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      wifi: mac80211: remove spurious blank line
      wifi: mac80211: fix deactivated link CSA
      wifi: cfg80211: hide scan internals
      wifi: nl80211: make nl80211_check_scan_flags() type safe
      wifi: mac80211: remove DISALLOW_PUNCTURING_5GHZ code
      wifi: mac80211: send extended MLD capa/ops if AP has it
      wifi: mac80211: don't complete management TX on SAE commit

Leon Yen (1):
      wifi: mt76: mt7921s: Introduce SDIO WiFi/BT combo module card reset

Lorenzo Bianconi (9):
      wifi: mt76: mt7996: Fix secondary link lookup in mt7996_mcu_sta_mld_setup_tlv()
      wifi: mt76: mt7996: Rely on for_each_sta_active_link() in mt7996_mcu_sta_mld_setup_tlv()
      wifi: mt76: mt7996: Do not set wcid.sta to 1 in mt7996_mac_sta_event()
      wifi: mt76: mt7996: Fix mlink lookup in mt7996_tx_prepare_skb
      wifi: mt76: mt7996: Fix possible OOB access in mt7996_tx()
      wifi: mt76: mt7996: Fix valid_links bitmask in mt7996_mac_sta_{add,remove}
      wifi: mt76: mt7996: Add MLO support to mt7996_tx_check_aggr()
      wifi: mt76: mt7996: Move num_sta accounting in mt7996_mac_sta_{add,remove}_links
      wifi: mt76: Get rid of dma_sync_single_for_device() for MMIO devices

Ming Yen Hsieh (1):
      wifi: mt76: mt792x: improve monitor interface handling

Miri Korenblit (9):
      wifi: iwlwifi: bump FW API to 102 for BZ/SC/DR
      wifi: iwlwifi: pcie move common probe logic
      wifi: iwlwifi: trans: remove iwl_trans_init
      wifi: iwlwifi: mvm: remove MLO GTK rekey code
      wifi: iwlwifi: mvm: remove unneeded argument
      wifi: iwlwifi: bump minimum API version in BZ
      wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v4
      wifi: mac80211: avoid weird state in error path
      wifi: mac80211: verify state before connection

Rotem Kerem (1):
      wifi: iwlwifi: Add an helper function for polling bits

Somashekhar Puttagangaiah (2):
      wifi: mac80211: add mandatory bitrate support for 6 GHz
      wifi: cfg80211/mac80211: implement dot11ExtendedRegInfoSupport

Yedidya Benshimol (2):
      wifi: iwlwifi: pcie move gen1_2 probe to gen1_2/trans.c
      wifi: iwlwifi: pcie: Move txcmd size/align calculation to callers

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |  21 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   3 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |  32 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h       |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |  11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |   9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  37 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        | 232 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 352 ++----------------
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |   8 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 413 ++++++++++++++++++---
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |  45 ++-
 drivers/net/wireless/mediatek/mt76/channel.c       |   4 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |  11 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |   4 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  30 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   2 +
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   2 +
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |  58 +++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  48 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  80 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  17 +-
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c     |   6 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |   6 +-
 include/linux/ieee80211.h                          |  43 ++-
 include/net/cfg80211.h                             |  12 +-
 include/net/mac80211.h                             |   7 +-
 net/mac80211/debugfs.c                             |   3 +-
 net/mac80211/ieee80211_i.h                         |   2 +
 net/mac80211/link.c                                |   9 +-
 net/mac80211/mlme.c                                | 148 ++++++--
 net/mac80211/rx.c                                  |  12 +-
 net/mac80211/scan.c                                |   3 +-
 net/mac80211/sta_info.c                            |   3 +-
 net/mac80211/util.c                                |  17 +
 net/wireless/core.c                                |   4 +-
 net/wireless/core.h                                |  11 +-
 net/wireless/mlme.c                                |  21 +-
 net/wireless/nl80211.c                             | 144 +++----
 net/wireless/rdev-ops.h                            |   6 +-
 net/wireless/reg.c                                 |  28 +-
 net/wireless/scan.c                                | 204 +++++-----
 net/wireless/sme.c                                 |  40 +-
 net/wireless/trace.h                               |  23 +-
 61 files changed, 1221 insertions(+), 1056 deletions(-)

