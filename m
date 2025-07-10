Return-Path: <linux-wireless+bounces-25176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C19CB00192
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 14:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3BE3B1977
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504612512D5;
	Thu, 10 Jul 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oOkRBua1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648B226CFC;
	Thu, 10 Jul 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150144; cv=none; b=Fi531r5MS0eudo9QN5DJQijKPB8CEniAFkqzyIYeNi7VPCn/HL2ZjtwLQ+AYv/LzG01fWZfw+YmNE2WIK/xQ6LUGsGUv3Mns1i6pMiM5kjukOERSsGZBrlmOqGv0OJGCBJqw+yC8kaw4v8xTXAmDIrmOmkDYX3gLcuVCuswnuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150144; c=relaxed/simple;
	bh=NdB7wbqsB1g307z8h8mAp8NQyBypa3IXNIzoHMkODMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vr/EtT3veW2yup8pQvmJlAyI6caSFiD5FuRtDPnwdl9txT6hEIa9pAyPzq1IFhErEMpyWTr4ObG/9pM8KCoUFE1p94qKQLk4qSeaBjWtdiNLo5qJ8McAtoqM6giGFcY2LZTlxjH+3QlCgdhPrh9TOJ+8X5wJkdJTJYOKlTM9ZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oOkRBua1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=r6cpPlRsY6k/wANUJdTvmlu8GuUUvS3y0WGIYPpTNk8=; t=1752150142; x=1753359742; 
	b=oOkRBua13WxfnPxoIx6QyjtULLy9IRhm8seUU5qc5rG74VZXs5qlknJ1D03xaR/kMeVBIpra6Q5
	6ZmnqrYhkAyIjUkM4+lo6b+ooaB3xhSp0wW8k/9mWV1ts3Yq2Cf23LHMuL5YSM5xge5Ggn6HwGlLP
	tRTqK/n/PhslA81jzap0csKnix5SEMp1g692FUBTS6vEp9ea4/qBi+eW98dYdXjNPyW2IxBW1QlAj
	ccv44FaBH8D9tmPzF0iP2n6c3OL22/gU3Cc5KYaSxMGzPSpnLcDnASDPsBWLua/wz7xOpz7kgV/yv
	xuQqpgIehydC+0LMOKY47fI6VFlMDeUAcSHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZqI8-0000000ElRl-0Bld;
	Thu, 10 Jul 2025 14:22:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-07-10
Date: Thu, 10 Jul 2025 14:21:06 +0200
Message-ID: <20250710122212.24272-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So I have more fixes than I'd like at this point, but a few
were under discussion for a while, mt76 fixes were just not
forthcoming until now, and all of them really don't seem
wrong to put into the tree at this point...

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit e34a79b96ab9d49ed8b605fee11099cf3efbb428:

  Merge tag 'net-6.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 09:13:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-07-10

for you to fetch changes up to c07981af55d3ba3ec3be880cfe4a0cc10f1f7138:

  wifi: mac80211: add the virtual monitor after reconfig complete (2025-07-10 13:27:14 +0200)

----------------------------------------------------------------
Quite a number of fixes still:
 - mt76 (hadn't sent any fixes so far)
   - RCU
   - scanning
   - decapsulation offload
   - interface combinations
 - rt2x00: build fix (bad function pointer prototype)
 - cfg80211: prevent A-MSDU flipping attacks in mesh
 - zd1211rw: prevent race ending with NULL ptr deref
 - cfg80211/mac80211: more S1G fixes
 - mwifiex: avoid WARN on certain RX frames
 - mac80211:
   - avoid stack data leak in WARN cases
   - fix non-transmitted BSSID search
     (on certain multi-BSSID APs)
   - always initialize key list so driver
     iteration won't crash
   - fix monitor interface in device restart
   - fix __free() annotation usage

----------------------------------------------------------------
Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

Deren Wu (2):
      wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_sta_set_decap_offload()
      wifi: mt76: mt7921: prevent decap offload config before STA initialization

Felix Fietkau (3):
      wifi: rt2x00: fix remove callback type mismatch
      wifi: mt76: add a wrapper for wcid access with validation
      wifi: mt76: fix queue assignment for deauth packets

Henry Martin (1):
      wifi: mt76: mt7925: Fix null-ptr-deref in mt7925_thermal_init()

Johannes Berg (3):
      wifi: mac80211: clear frame buffer to never leak stack
      wifi: mac80211: fix non-transmitted BSSID profile search
      Merge tag 'mt76-fixes-2025-07-07' of https://github.com/nbd168/wireless

Lachlan Hodges (2):
      wifi: cfg80211: fix S1G beacon head validation in nl80211
      wifi: mac80211: correctly identify S1G short beacon

Leon Yen (1):
      wifi: mt76: mt792x: Limit the concurrent STA and SoftAP to operate on the same channel

Lorenzo Bianconi (5):
      wifi: mt76: Assume __mt76_connac_mcu_alloc_sta_req runs in atomic context
      wifi: mt76: Move RCU section in mt7996_mcu_set_fixed_field()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl_fixed()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl()
      wifi: mt76: Remove RCU section in mt7996_mac_sta_rc_work()

Mathy Vanhoef (1):
      wifi: prevent A-MSDU attacks in mesh networks

Michael Lo (1):
      wifi: mt76: mt7925: fix invalid array index in ssid assignment during hw scan

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: fix the wrong config for tx interrupt
      wifi: mt76: mt7925: fix incorrect scan probe IE handling for hw_scan

Miri Korenblit (2):
      wifi: mac80211: always initialize sdata::key_list
      wifi: mac80211: add the virtual monitor after reconfig complete

Moon Hee Lee (1):
      wifi: mac80211: reject VHT opmode for unsupported channel widths

Pagadala Yesu Anjaneyulu (1):
      wifi: mac80211: Fix uninitialized variable with __free() in ieee80211_ml_epcs()

Vitor Soares (1):
      wifi: mwifiex: discard erroneous disassoc frames on STA interface

 drivers/net/wireless/marvell/mwifiex/util.c        |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  10 ++
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   7 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h       |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   3 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  79 ++++++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |  32 +++-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  52 ++----
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 199 +++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  16 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |  11 +-
 drivers/net/wireless/mediatek/mt76/util.c          |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c     |   4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h     |   2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |   6 +-
 include/linux/ieee80211.h                          |  45 +++--
 net/mac80211/cfg.c                                 |  14 ++
 net/mac80211/iface.c                               |   4 +-
 net/mac80211/mlme.c                                |  12 +-
 net/mac80211/parse.c                               |   6 +-
 net/mac80211/util.c                                |   9 +-
 net/wireless/nl80211.c                             |   7 +-
 net/wireless/util.c                                |  52 +++++-
 39 files changed, 430 insertions(+), 233 deletions(-)

