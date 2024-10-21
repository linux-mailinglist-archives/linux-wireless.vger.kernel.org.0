Return-Path: <linux-wireless+bounces-14277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A09A71F2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 20:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B09E1C21B7A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ADB1FB3F7;
	Mon, 21 Oct 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="babJoFUk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392D1FB3D1;
	Mon, 21 Oct 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533978; cv=none; b=JwJd8F2mH05gkKI0X8tI59yZIYjulCYW+3CznBOXJpqem7B7EJ7ZrmC42i1TcgIivFbDql4psZcrvDGx8nITj5tmO7erJu3rdJSkkwc+pthk6DuOOCTQhJccIVw4z55qqh5+Wp/yipl2b61jREQ6KfYw2FMSlgTjKHCGwUglJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533978; c=relaxed/simple;
	bh=kbQ79oVLqA9EiTmrGftQUF5wI52tyKmDV3jSRmXz67o=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=OZie+mLBt83KTwaTGwZUiJJnnc13BcMp34lhwqLxDNzZtk8Y3ZIdAZXZKBi5e7N9Cm311f9e+VlipkWg/tWvgO8VZQb0y8aC5h9k4KjbJaCPTzbcgFXM2PDrGMMgoPbhXb2E+b79aleQ0Pqud332FyDvjmztfyFfKdxj6fM+KpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=babJoFUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49DAC4CEC7;
	Mon, 21 Oct 2024 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533978;
	bh=kbQ79oVLqA9EiTmrGftQUF5wI52tyKmDV3jSRmXz67o=;
	h=From:Subject:To:Cc:Date:From;
	b=babJoFUktscJToaZS1DkFPx+Pn0T6MrU1lDisBNyX4hplxwML1GpQvtxCrk2O7oLh
	 9DkfHwf+/+uHAoCWEpMpLEGUvqnpH1IoMXklyD0vjOkL20dGE2dzRiRi312JRKzgbP
	 cI1CwK2ymZMM/m7yqZRTnEej8F3y3FGIJtO1JAUIbK4KcEKLVofibhRNZTceYYO6z5
	 g1H9mNl3YWoWj9emZMnj+FJJFZ3M6VQV3yRAU1CbtGx27okm7qeHijG1LLCBPmKRh/
	 N50yDXONyO6ToUP96/CcSZgF8kPxZCDi4a+c0bhTBD058K0mHnScilfsQ05utoGk1T
	 ZzJQDNBVz8deA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-10-21
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20241021180617.B49DAC4CEC7@smtp.kernel.org>
Date: Mon, 21 Oct 2024 18:06:17 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit 9410645520e9b820069761f3450ef6661418e279:

  Merge tag 'net-next-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-09-16 06:02:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-10-21

for you to fetch changes up to a940b3a1ad0f5bab139fd710dd433aec4eeaea85:

  Merge tag 'ath-current-20241016' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-10-17 17:25:37 +0300)

----------------------------------------------------------------
wireless fixes for v6.12-rc5

The first set of wireless fixes for v6.12. We have been busy and have
not been able to send this earlier, so there are more fixes than
usual. The fixes are all over, both in stack and in drivers, but
nothing special really standing out.

----------------------------------------------------------------
Ben Greear (1):
      wifi: mac80211: Fix setting txpower with emulate_chanctx

Ben Hutchings (1):
      wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd()

Bitterblue Smith (2):
      wifi: rtw88: Fix the RX aggregation in USB 3 mode
      wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171

Chenming Huang (1):
      wifi: cfg80211: Do not create BSS entries for unsupported channels

Felix Fietkau (3):
      wifi: mt76: do not increase mcu skb refcount if retry is not supported
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys

Geert Uytterhoeven (2):
      mac80211: MAC80211_MESSAGE_TRACING should depend on TRACING
      wifi: brcm80211: BRCM_TRACING should depend on TRACING

Gustavo A. R. Silva (1):
      wifi: radiotap: Avoid -Wflex-array-member-not-at-end warnings

Kalle Valo (1):
      Merge tag 'ath-current-20241016' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Ping-Ke Shih (2):
      wifi: rtw89: coex: add debug message of link counts on 2/5GHz bands for wl_info v7
      wifi: rtw89: pci: early chips only enable 36-bit DMA on specific PCI hosts

Remi Pommarel (3):
      wifi: cfg80211: Add wiphy_delayed_work_pending()
      wifi: mac80211: Convert color collision detection to wiphy work
      wifi: ath11k: Fix invalid ring usage in full monitor mode

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |  7 +++-
 drivers/net/wireless/ath/ath10k/wmi.c              |  2 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  7 +++-
 drivers/net/wireless/ath/wil6210/txrx.c            |  2 +-
 drivers/net/wireless/broadcom/brcm80211/Kconfig    |  1 +
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |  2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.h       |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.c       | 15 ++++++-
 drivers/net/wireless/intel/iwlegacy/common.h       | 12 ++++++
 drivers/net/wireless/marvell/libertas/radiotap.h   |  4 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |  7 +++-
 drivers/net/wireless/microchip/wilc1000/mon.c      |  4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192du/sw.c    |  1 -
 drivers/net/wireless/realtek/rtw88/usb.c           |  1 -
 drivers/net/wireless/realtek/rtw89/coex.c          |  2 +
 drivers/net/wireless/realtek/rtw89/pci.c           | 48 ++++++++++++++++++----
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  4 +-
 include/net/cfg80211.h                             | 44 ++++++++++++++++++++
 include/net/ieee80211_radiotap.h                   | 37 +++++++++--------
 net/mac80211/Kconfig                               |  2 +-
 net/mac80211/cfg.c                                 | 25 +++++++----
 net/mac80211/ieee80211_i.h                         |  5 ++-
 net/mac80211/key.c                                 | 42 +++++++++++--------
 net/mac80211/link.c                                |  7 ++--
 net/wireless/core.c                                |  7 ++++
 net/wireless/scan.c                                |  4 ++
 26 files changed, 222 insertions(+), 72 deletions(-)


