Return-Path: <linux-wireless+bounces-3903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E685F2F7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 09:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D1B1F259E4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B7222615;
	Thu, 22 Feb 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXs0Mxbl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB052260B
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590664; cv=none; b=tjVcQpgumAnPvjsjGmyL6/L+ChvEIYi7GlH8zs+sat5x2QSxi06zpBO5gvf3GrVs7Clvqgoe/YROoahR1pUSAxD2gdQUJX9HIkb7krsDer5lkqxgG22nOrGgjan9jtpMOXOsFSeVdTQLbCBek1lPd//bfwPaHbLxgd5m/wuqjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590664; c=relaxed/simple;
	bh=k0DEzDQSLa5M/GLDTtBEZ67yVwcDnrxRQUYOAgzB1Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a/egAPHycRSGQ55MfORx7cA3sJYHhT0lru77CtmP8/FKLadPWd2FeWSkJrfUxdo/Nu4Y+nagkf7I9F8rAWy0q+HIAkdmG+/ULpfqXjV/g+gph+FPtIzTnOtriD105q+rQ3DJ6jJo+y6aueL0Kp4Cl5bsyL8I335D4v4Ij6ziTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXs0Mxbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646F3C433F1;
	Thu, 22 Feb 2024 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708590663;
	bh=k0DEzDQSLa5M/GLDTtBEZ67yVwcDnrxRQUYOAgzB1Ug=;
	h=From:To:Cc:Subject:Date:From;
	b=FXs0MxblGlWpyZkACaFxHffYijg8Ly2azPuFldNHW4UMoAF59GNmxQGUPsMtrFtug
	 XFRPmmLobQklBcC54D6h2RqQCXNLc2NrpiTH9q4o1svWp/2LP7vkvt7Nv962Lu0U4K
	 AqgvUsgAiUGPfyspjFpDA6os1OYQyQznJ5yU2ZNS/JX+2lPotFJ31+4MGXSedHNM8x
	 e1m5zj/MFXRLvDZvS17/X2Gspcz0iBgayp2gZFLtlGkYBj8ow8xqAWDYFmNMTIu0ZE
	 7Gyt6NyIqWr95qIc8dmJR4vilFi2f46KSFsNNfsmYmJmGLVru2O7arJVuT4WQK3shJ
	 CwtcKR/Nlnrhw==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, quic_jjohnson@quicinc.com
Subject: pull-request: ath-next-20240222
Date: Thu, 22 Feb 2024 10:31:00 +0200
Message-ID: <87plwolx2z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Here's an ath-next pull request to wireless-next. More info below.

Kalle

The following changes since commit 2a71528427c635f0a8bff704b2e62ce81c641d6f:

  wifi: brcmfmac: fix copyright year mentioned in platform_data header (202=
4-01-31 18:48:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next=
-20240222

for you to fetch changes up to 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5:

  wifi: ath11k: remove unused scan_events from struct scan_req_params (2024=
-02-15 13:24:18 +0200)

----------------------------------------------------------------
ath.git patches for v6.9

We have support for QCA2066 now and also several new features in ath12k.

Major changes:

ath12k

* firmware-2.bin support

* support having multiple identical PCI devices (firmware needs to
  have ATH12K_FW_FEATURE_MULTI_QRTR_ID)

* QCN9274: support split-PHY devices

* WCN7850: enable Power Save Mode in station mode

* WCN7850: P2P support

ath11k:

* QCA6390 & WCN6855: support 2 concurrent station interfaces

* QCA2066 support

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: fix firmware assert during insmod in memory segment mode

Baochen Qiang (5):
      wifi: ath12k: enable 802.11 power save mode in station mode
      wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use
      wifi: ath11k: initialize eirp_power before use
      wifi: ath11k: move pci.ops registration ahead
      wifi: ath11k: add support for QCA2066

Carl Huang (2):
      wifi: ath11k: support 2 station interfaces
      wifi: ath11k: provide address list if chip supports 2 stations

Colin Ian King (2):
      wifi: ath9k:  remove redundant assignment to variable ret
      wifi: carl9170: Remove redundant assignment to pointer super

Ganesh Babu Jothiram (1):
      wifi: ath12k: Read board id to support split-PHY QCN9274

Harshitha Prem (1):
      wifi: ath12k: add support for peer meta data version

Jeff Johnson (1):
      wifi: ath11k: Really consistently use ath11k_vif_to_arvif()

Kang Yang (11):
      wifi: ath12k: fix broken structure wmi_vdev_create_cmd
      wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
      wifi: ath12k: change interface combination for P2P mode
      wifi: ath12k: add P2P IE in beacon template
      wifi: ath12k: implement handling of P2P NoA event
      wifi: ath12k: implement remain on channel for P2P mode
      wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
      wifi: ath12k: allow specific mgmt frame tx while vdev is not up
      wifi: ath12k: move peer delete after vdev stop of station for WCN7850
      wifi: ath12k: designating channel frequency for ROC scan
      wifi: ath12k: advertise P2P dev support for WCN7850

Karthikeyan Kathirvel (1):
      wifi: ath12k: subscribe required word mask from rx tlv

Karthikeyan Periyasamy (2):
      wifi: ath12k: add MAC id support in WBM error path
      wifi: ath12k: refactor the rfkill worker

Lingbo Kong (2):
      wifi: ath12k: add processing for TWT enable event
      wifi: ath12k: add processing for TWT disable event

Nathan Chancellor (1):
      wifi: ath12k: Fix uninitialized use of ret in ath12k_mac_allocate()

Nicolas Escande (6):
      wifi: ath11k: Do not directly use scan_flags in struct scan_req_params
      wifi: ath11k: Remove scan_flags union from struct scan_req_params
      wifi: ath12k: Do not use scan_flags from struct ath12k_wmi_scan_req_a=
rg
      wifi: ath12k: Remove unused scan_flags from struct ath12k_wmi_scan_re=
q_arg
      wifi: ath12k: remove the unused scan_events from ath12k_wmi_scan_req_=
arg
      wifi: ath11k: remove unused scan_events from struct scan_req_params

P Praneesh (2):
      wifi: ath12k: Add logic to write QRTR node id to scratch
      wifi: ath12k: fix PCI read and write

Raj Kumar Bhagat (5):
      wifi: ath12k: add firmware-2.bin support
      wifi: ath12k: fix fetching MCBC flag for QCN9274
      wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
      wifi: ath12k: remove hal_desc_sz from hw params
      wifi: ath12k: disable QMI PHY capability learn in split-phy QCN9274

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID

Sriram R (1):
      wifi: ath12k: indicate NON MBSSID vdev by default during vdev start

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is com=
plete

Wen Gong (1):
      wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_=
PEER_ASSOC_CMDID

 drivers/net/wireless/ath/ath11k/core.c        | 100 +++++-
 drivers/net/wireless/ath/ath11k/core.h        |   1 +
 drivers/net/wireless/ath/ath11k/hw.c          |   2 +-
 drivers/net/wireless/ath/ath11k/hw.h          |   1 +
 drivers/net/wireless/ath/ath11k/mac.c         | 116 +++++--
 drivers/net/wireless/ath/ath11k/mhi.c         |   1 +
 drivers/net/wireless/ath/ath11k/pci.c         |  43 ++-
 drivers/net/wireless/ath/ath11k/pcic.c        |  11 +
 drivers/net/wireless/ath/ath11k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.h         |  86 +++--
 drivers/net/wireless/ath/ath12k/Makefile      |   4 +-
 drivers/net/wireless/ath/ath12k/core.c        |  55 +++-
 drivers/net/wireless/ath/ath12k/core.h        |  27 ++
 drivers/net/wireless/ath/ath12k/dp.c          |  25 +-
 drivers/net/wireless/ath/ath12k/dp.h          |  17 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 158 ++++-----
 drivers/net/wireless/ath/ath12k/dp_tx.c       |  20 ++
 drivers/net/wireless/ath/ath12k/fw.c          | 171 ++++++++++
 drivers/net/wireless/ath/ath12k/fw.h          |  33 ++
 drivers/net/wireless/ath/ath12k/hal.c         | 415 ++++++++++++++++++++++=
+-
 drivers/net/wireless/ath/ath12k/hal.h         |  20 +-
 drivers/net/wireless/ath/ath12k/hw.c          |  24 +-
 drivers/net/wireless/ath/ath12k/hw.h          |  32 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 443 ++++++++++++++++++++++=
----
 drivers/net/wireless/ath/ath12k/mhi.c         |  52 ++-
 drivers/net/wireless/ath/ath12k/p2p.c         | 142 +++++++++
 drivers/net/wireless/ath/ath12k/p2p.h         |  23 ++
 drivers/net/wireless/ath/ath12k/pci.c         |  84 +++--
 drivers/net/wireless/ath/ath12k/pci.h         |   6 +-
 drivers/net/wireless/ath/ath12k/qmi.c         |  52 ++-
 drivers/net/wireless/ath/ath12k/qmi.h         |   1 -
 drivers/net/wireless/ath/ath12k/rx_desc.h     | 116 ++++++-
 drivers/net/wireless/ath/ath12k/wmi.c         | 230 +++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h         | 202 ++++++++----
 drivers/net/wireless/ath/ath9k/htc.h          |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |   4 +
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |   4 -
 drivers/net/wireless/ath/ath9k/wmi.c          |  10 +-
 drivers/net/wireless/ath/ath9k/xmit.c         |   3 +-
 drivers/net/wireless/ath/carl9170/tx.c        |   2 +-
 41 files changed, 2334 insertions(+), 411 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/fw.h
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h

