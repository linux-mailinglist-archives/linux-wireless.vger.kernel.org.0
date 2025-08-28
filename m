Return-Path: <linux-wireless+bounces-26755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A4B39D40
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BE03A81AC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6D30C605;
	Thu, 28 Aug 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KvQuquVg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF723597A;
	Thu, 28 Aug 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384022; cv=none; b=FbVHzmUJYsblVC9kg/tPS69D52s8HYmrHAAZynvG+FMy+fIEH98M89b/Y8X5+7mClAv1mNuyDBaJ/cD8fpKDK0mRXE8n1FMU6SowY4/yhNxaWwTzL+60SbPWtV4jzpprBzHrQQjj7Pq7jLQ2EBejAxw5CDGbWwExXj7PmIjSJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384022; c=relaxed/simple;
	bh=G0Ya/rkZOqFLIubv7JSwNnANgiW3TGI9H3KLop0bf94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YECZdcLQ5DrtXBtifZrsOsODqsg0NeNuMt2EsOelOWj2dGVCRyyLPIeDjN+wZ0PoFukFw3Vma0WchTcJ44nMod1uJmmmYbO++JbPYmqjh32gS97kffGZWn1rJX6UD6HxTByAMve5nkVKBcZUINObQn64hKWFd/uD4wEWa/4KWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KvQuquVg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8DIgSq5j3BwhjRCYiSPt1y0uheSYrcaJJ9gV/K/2uSc=; t=1756384020; x=1757593620; 
	b=KvQuquVgmoiJDbzxiKIEghQLh8n0YEHclHJYPds62zkgGVpGofuSRlqdo4qaSZw10NCLxtkqVWM
	YLDgULSB9/0z9/foCf3+m4MJd6SexJxV1WwipHmOU/OGwiZ2Gm+JOL8M5Tf9ECCCeiXMf+W3YQmZM
	or1eEIJD+Y5KvrI/z+2DsS/bKNHxRm01z/CqZzUNxzb8gevTUTXzmmbzbhq1bku28LukrHtvN1fpa
	J7+XSNf0f3iC1ToUuAOP581bzd2mfQZ1ZVZp6szUseM2sJa0Bg+v8c06sp8omDR/XOTpdduAdGrNA
	ClELtvtBqHKsWzFVrAZ60kU/0/Gc2mIHDEsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urbiT-00000007XpG-3evY;
	Thu, 28 Aug 2025 14:26:58 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-08-28
Date: Thu, 28 Aug 2025 14:25:58 +0200
Message-ID: <20250828122654.1167754-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Back from vacation, and a bunch of things accumulated
for everyone. Nothing really stands out much though,
except perhaps the various iwlwifi regressions for old
devices, which were all my fault...

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 6439a0e64c355d2e375bd094f365d56ce81faba3:

  Merge tag 'net-6.17-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-08-21 13:51:15 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-08-28

for you to fetch changes up to 2c72c8d356db40178be558bbbd43a1d0b5bd0c27:

  Merge tag 'iwlwifi-fixes-2025-08-28' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-08-28 14:03:32 +0200)

----------------------------------------------------------------
Some fixes for the current cycle:
 - mt76: MLO regressions, offchannel handling, list corruption
 - mac80211: scan allocation size, no 40 MHz EHT, signed type
 - rt2x00: (randconfig) build
 - cfg80211: use-after-free
 - iwlwifi: config/old devices, BIOS compatibility
 - mwifiex: vmalloc content leak

----------------------------------------------------------------
Arnd Bergmann (2):
      wifi: rt2800: select CONFIG_RT2X00_LIB as needed
      wifi: rt2x00: fix CRC_CCITT dependency

Benjamin Berg (1):
      wifi: mac80211: do not permit 40 MHz EHT operation on 5/6 GHz

Chad Monroe (1):
      wifi: mt76: mt7996: use the correct vif link for scanning/roc

Dmitry Antipov (1):
      wifi: cfg80211: fix use-after-free in cmp_bss()

Duoming Zhou (1):
      wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work

Emmanuel Grumbach (1):
      wifi: iwlwifi: if scratch is ~0U, consider it a failure

Felix Fietkau (8):
      wifi: mt76: prevent non-offchannel mgmt tx during scan/roc
      wifi: mt76: mt7996: disable beacons when going offchannel
      wifi: mt76: mt7996: fix crash on some tx status reports
      wifi: mt76: do not add non-sta wcid entries to the poll list
      wifi: mt76: mt7996: add missing check for rx wcid entries
      wifi: mt76: mt7915: fix list corruption after hardware restart
      wifi: mt76: free pending offchannel tx frames on wcid cleanup
      wifi: mt76: fix linked list corruption

Harshit Mogalapalli (1):
      wifi: mt76: mt7925: fix locking in mt7925_change_vif_links()

Janusz Dziedzic (1):
      wifi: mt76: mt7921: don't disconnect when CSA to DFS chan

Johannes Berg (7):
      wifi: iwlwifi: acpi: check DSM func validity
      wifi: iwlwifi: uefi: check DSM item validity
      Merge tag 'mt76-fixes-2025-08-27' of https://github.com/nbd168/wireless
      wifi: iwlwifi: cfg: restore some 1000 series configs
      wifi: iwlwifi: fix byte count table for old devices
      wifi: iwlwifi: cfg: add back more lost PCI IDs
      Merge tag 'iwlwifi-fixes-2025-08-28' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Lachlan Hodges (1):
      wifi: mac80211: increase scan_ies_len for S1G

Liao Yuanhong (1):
      wifi: mac80211: fix incorrect type for ret

Ming Yen Hsieh (3):
      wifi: mt76: mt7925: fix the wrong bss cleanup for SAP
      wifi: mt76: mt7925u: use connac3 tx aggr check in tx complete
      wifi: mt76: mt7925: skip EHT MLD TLV on non-MLD and pass conn_state for sta_cmd

Nathan Chancellor (1):
      wifi: mt76: mt7996: Initialize hdr before passing to skb_put_data()

Qianfeng Rong (1):
      wifi: mwifiex: Initialize the chan_stats array to zero

 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c  |  6 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 25 ++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |  8 +++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  6 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 22 ++++++--
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |  3 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  5 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |  4 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      | 43 +++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 12 ++---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  7 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 12 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 60 ++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  5 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 15 ++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c            | 12 ++---
 drivers/net/wireless/ralink/rt2x00/Kconfig         |  4 +-
 net/mac80211/driver-ops.h                          |  2 +-
 net/mac80211/main.c                                |  7 ++-
 net/mac80211/mlme.c                                |  8 +++
 net/mac80211/tests/chan-mode.c                     | 30 +++++++++--
 net/wireless/scan.c                                |  3 +-
 26 files changed, 232 insertions(+), 76 deletions(-)

