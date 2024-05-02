Return-Path: <linux-wireless+bounces-7115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02E8B9E03
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2D81F249C5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79EC15CD78;
	Thu,  2 May 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzqLAwE8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F115AD83
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665690; cv=none; b=PR9jbQw4pJnriyS0GL20Lms+LqA3ZHKwI5rvHDdMg5kh5fm7as2d2jkvAUs+Xhof/UIK1q9KBVFWXQA1W/9ffA6lO5MR/eW36JODLkC3/p98E3IWmafhkwuzqVpkBIP+1TpiElptMcb114plrUd92PB9PeA2ZSfRsW8Mg7mSyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665690; c=relaxed/simple;
	bh=mAkEKC+KPNUQKffUdp+OAqvjQHSIAy4Tm31PH1AZidw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mS2OXY6V7IdzF2LNXCeXOisaKvdNIbNH3x5qLcGxKgQyPje07nBkJR+KtV/3oLHnTAVGmDaVkQa+DL3Ch0hIvU9E4dVm/ps26iWSSE86/c0aHXn1JcKHaQGRkZp17jOOOy0XBIxwJGGQKlPKXGjvOFnyPvI12aPu3fFGrGyGcqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzqLAwE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBAAC113CC;
	Thu,  2 May 2024 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714665690;
	bh=mAkEKC+KPNUQKffUdp+OAqvjQHSIAy4Tm31PH1AZidw=;
	h=From:To:Cc:Subject:Date:From;
	b=DzqLAwE89Woo7orI5OKHMbaUTLMLjmv4AE9rJuHIKSuhMewy0F/W0deXpEbNzU8mq
	 wicYKRmk7nIzxq6oqedCJHhLWlbCN3CjcsBjClAsszQog6Ju8BGaXrCv2LEY/Uy1ii
	 o6cL/WYuSYSL0lpAx4ABfdaocKZ++prQ9jFW/eNr4gDNB0hgOudFEJpep8VBI+ozeq
	 qfZhg3pSb2ioIvSImNAO+Azge/OQ+deMCatjfUZlghM61Jy8ZtwDwt5E6wd+E12TGJ
	 zqXrPoeiMduRdXfiuMX+nNOATW3M7Gx3fAXt/Z49NkctiJCLs2gVNw4b52oPwA/PI4
	 xMcVTbAUD7uHg==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, quic_jjohnson@quicinc.com
Subject: pull-request: ath-next-20240502
Date: Thu, 02 May 2024 19:01:26 +0300
Message-ID: <87bk5onqy1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Please pull, more information in the tag below.

Kalle

The following changes since commit 57a03d83f229126b0aab6f305821358755c7b130:

  Merge branch 'mlxsw-preparations-for-improving-performance' (2024-04-03 19:50:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next-20240502

for you to fetch changes up to bf76b144fe53c7f0de9e294947d903fc7724776f:

  wifi: ath12k: fix the problem that down grade phy mode operation (2024-05-02 13:15:38 +0300)

----------------------------------------------------------------
ath.git patches for v6.10

ath12k

* debugfs support

* dfs_simulate_radar debugfs file

* disable Wireless Extensions

* suspend and hibernation support

* ACPI support

* refactoring in preparation of multi-link support

ath11k

* support hibernation (required changes in qrtr and MHI subsystems)

* ieee80211-freq-limit Device Tree property support

ath10k

* firmware-name Device Tree property support

----------------------------------------------------------------
Arnd Bergmann (2):
      wifi: carl9170: re-fix fortified-memset warning
      wifi: ath9k: work around memset overflow warning

Baochen Qiang (16):
      bus: mhi: host: Add mhi_power_down_keep_dev() API to support system suspend/hibernation
      net: qrtr: support suspend/hibernation
      wifi: ath11k: support hibernation
      wifi: ath12k: fix kernel crash during resume
      wifi: ath12k: rearrange IRQ enable/disable in reset path
      wifi: ath12k: remove MHI LOOPBACK channels
      wifi: ath12k: do not dump SRNG statistics during resume
      wifi: ath12k: fix warning on DMA ring capabilities event
      wifi: ath12k: decrease MHI channel buffer length to 8KB
      wifi: ath12k: flush all packets before suspend
      wifi: ath12k: no need to handle pktlog during suspend/resume
      wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()
      wifi: ath12k: support suspend/resume
      wifi: ath12k: change supports_suspend to true for WCN7850
      wifi: ath12k: check M3 buffer size as well whey trying to reuse it
      wifi: ath12k: fix flush failure in recovery scenarios

Christian Lamparter (2):
      dt-bindings: net: wireless: ath11k: add ieee80211-freq-limit property
      wifi: ath11k: add support DT ieee80211-freq-limit

Christophe JAILLET (1):
      wifi: ath11k: Fix error handling in ath11k_wmi_p2p_noa_event()

Dmitry Baryshkov (5):
      dt-bindings: net: wireless: ath10k: describe firmware-name property
      wifi: ath10k: support board-specific firmware overrides
      wifi: ath10k: populate board data for WCN3990
      wifi: ath10k: drop chip-specific board data file name
      wifi: ath10k: drop fw.eboard file name

Gustavo A. R. Silva (2):
      wifi: wil6210: cfg80211: Use __counted_by() in struct wmi_start_scan_cmd and avoid some -Wfamnae warnings
      wifi: wil6210: wmi: Use __counted_by() in struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning

Jeff Johnson (3):
      wifi: ath11k: fix hal_rx_buf_return_buf_manager documentation
      wifi: ath12k: fix hal_rx_buf_return_buf_manager documentation
      wifi: ath12k: don't use %pK in dmesg format strings

Kalle Valo (2):
      Merge branch 'mhi-immutable' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into ath-next
      wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT

Kang Yang (2):
      wifi: ath12k: dynamically update peer puncturing bitmap for STA
      wifi: ath12k: add support to handle beacon miss for WCN7850

Karthikeyan Kathirvel (1):
      wifi: ath12k: fix out-of-bound access of qmi_invoke_handler()

Karthikeyan Periyasamy (9):
      wifi: ath12k: extend the link capable flag
      wifi: ath12k: fix link capable flags
      wifi: ath12k: correct the capital word typo
      wifi: ath12k: add multiple radio support in a single MAC HW un/register
      wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path
      wifi: ath12k: avoid redundant code in Rx cookie conversion init
      wifi: ath12k: Refactor the hardware cookie conversion init
      wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion table
      wifi: ath12k: Refactor data path cmem init

Krzysztof Kozlowski (1):
      wifi: ath6kl: sdio: simplify module initialization

Lingbo Kong (5):
      wifi: ath12k: ACPI TAS support
      wifi: ath12k: ACPI SAR support
      wifi: ath12k: ACPI CCA threshold support
      wifi: ath12k: ACPI band edge channel power support
      wifi: ath12k: fix the problem that down grade phy mode operation

Miaoqing Pan (1):
      wifi: ath12k: fix missing endianness conversion in wmi_vdev_create_cmd()

Nikita Zhandarovich (2):
      wifi: carl9170: add a proper sanity check for endpoints
      wifi: ar5523: enable proper endpoint verification

Raj Kumar Bhagat (2):
      wifi: ath12k: read single_chip_mlo_support parameter from QMI PHY capability
      wifi: ath12k: set mlo_capable_flags based on QMI PHY capability

Ramasamy Kaliappan (1):
      wifi: ath12k: initial debugfs support

Ramya Gnanasekar (1):
      wifi: ath12k: debugfs: radar simulation support

Sriram R (11):
      wifi: ath12k: Modify add and remove chanctx ops for single wiphy support
      wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
      wifi: ath12k: vdev statemachine changes for single wiphy
      wifi: ath12k: scan statemachine changes for single wiphy
      wifi: ath12k: fetch correct radio based on vdev status
      wifi: ath12k: Cache vdev configs before vdev create
      wifi: ath12k: Add additional checks for vif and sta iterators
      wifi: ath12k: modify regulatory support for single wiphy architecture
      wifi: ath12k: Modify set and get antenna mac ops for single wiphy
      wifi: ath12k: Modify rts threshold mac op for single wiphy
      wifi: ath12k: support get_survey mac op for single wiphy

Su Hui (1):
      wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

Thiraviyam Mariyappan (1):
      wifi: ath12k: enable service flag for survey dump stats

 .../bindings/net/wireless/qcom,ath10k.yaml         |    6 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |    3 +
 drivers/bus/mhi/host/internal.h                    |    4 +-
 drivers/bus/mhi/host/pm.c                          |   42 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |   14 +
 drivers/net/wireless/ath/ath.h                     |    6 +-
 drivers/net/wireless/ath/ath10k/core.c             |   43 +-
 drivers/net/wireless/ath/ath10k/core.h             |    2 +
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    2 +-
 drivers/net/wireless/ath/ath10k/hw.h               |   14 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   10 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    3 +
 drivers/net/wireless/ath/ath10k/targaddrs.h        |    3 +
 drivers/net/wireless/ath/ath11k/ahb.c              |    6 +-
 drivers/net/wireless/ath/ath11k/core.c             |  113 +-
 drivers/net/wireless/ath/ath11k/core.h             |    6 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath11k/hif.h              |   14 +-
 drivers/net/wireless/ath/ath11k/mac.c              |    1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   12 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |    5 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   44 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   18 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |    9 +
 drivers/net/wireless/ath/ath12k/Makefile           |    2 +
 drivers/net/wireless/ath/ath12k/acpi.c             |  394 +++++++
 drivers/net/wireless/ath/ath12k/acpi.h             |   76 ++
 drivers/net/wireless/ath/ath12k/core.c             |  123 ++-
 drivers/net/wireless/ath/ath12k/core.h             |   95 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   90 ++
 drivers/net/wireless/ath/ath12k/debugfs.h          |   30 +
 drivers/net/wireless/ath/ath12k/dp.c               |   90 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    5 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |    6 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  104 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    4 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hif.h              |   14 +-
 drivers/net/wireless/ath/ath12k/htc.c              |    4 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   12 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    4 +
 drivers/net/wireless/ath/ath12k/mac.c              | 1147 ++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h              |    4 +
 drivers/net/wireless/ath/ath12k/mhi.c              |   92 +-
 drivers/net/wireless/ath/ath12k/mhi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |    3 +-
 drivers/net/wireless/ath/ath12k/p2p.h              |    1 +
 drivers/net/wireless/ath/ath12k/pci.c              |   43 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  109 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    4 +
 drivers/net/wireless/ath/ath12k/reg.c              |   55 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  195 +++-
 drivers/net/wireless/ath/ath12k/wmi.h              |   67 +-
 drivers/net/wireless/ath/ath6kl/sdio.c             |   20 +-
 drivers/net/wireless/ath/ath9k/main.c              |    3 +-
 drivers/net/wireless/ath/carl9170/tx.c             |    3 +-
 drivers/net/wireless/ath/carl9170/usb.c            |   32 +
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   21 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |   19 +-
 drivers/net/wireless/ath/wil6210/wmi.h             |    4 +-
 include/linux/mhi.h                                |   18 +-
 net/qrtr/mhi.c                                     |   46 +
 64 files changed, 2656 insertions(+), 676 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.h

