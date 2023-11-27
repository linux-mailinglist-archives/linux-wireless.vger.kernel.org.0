Return-Path: <linux-wireless+bounces-107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C75B7FA627
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083C328125E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419436AF8;
	Mon, 27 Nov 2023 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTY5d9bd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CD36AF4;
	Mon, 27 Nov 2023 16:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500F2C43395;
	Mon, 27 Nov 2023 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102025;
	bh=Z3NXOof2eRrfFmizeCVpeB9sXefpEKLjnDTpPAKUtmE=;
	h=From:To:Cc:Subject:Date:From;
	b=QTY5d9bdSSSIFrsCI99T+x4ZtlVlyH+tYoAWxqM28/1oGVAA6Y9G0wh1KPC93PRQg
	 DX4tBfsyZ62TSGRKp+lmp2shWbbj7cd056knxIEGuIdcK5iumFru67i0Mf5OziAMA1
	 t+Xkd1TaJEBkAtna9alo8vp1EO8Qefty+yPCDq/0eGKMim1WkMXjCTEv/HrX866P9Y
	 6N+4mA3g97SbfBavsTr0wt9bACzC+YxFAzSHN5ukKRh1RHnH/NrGjxWoA0ESBkeAef
	 LS3PFiyjt6aOoAe8/PV9Zo5RArQ4sa+SnySTKQU48aEPBFGL+4FI69flPcljhB8KuZ
	 m4IMSzu+/tLLA==
From: Kalle Valo <kvalo@kernel.org>
To: mhi@lists.linux.dev
Cc: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 0/8] wifi: ath11k: hibernation support
Date: Mon, 27 Nov 2023 18:20:14 +0200
Message-Id: <20231127162022.518834-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Currently in ath11k we keep the firmware running on the WLAN device when the
network interface (wlan0) is down. The problem is that this will break
hibernation, obviously the firmware can't be running after the whole system is
powered off. To power down the ath11k firmware for suspend/hibernation some
changes both in MHI subsystem and ath11k is needed.

This patchset fixes a longstanding bug report about broken hibernation support:

https://bugzilla.kernel.org/show_bug.cgi?id=214649

This patchset is marked as RFC as it requires changes in MHI subsystem. Also
this has been tested only on WCN6855, need to test also on more AP based
chipsets like IPQ8074 and QCN9074.

The patches are also available at:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath11k-hibernation-support

Earlier versions of this patchset have been tested by multiple users with
positive results.

v2:

* rebase to ath-202311221826 (6.7.0-rc2-wt-ath+)

* 'bus: mhi: host: add mhi_power_down_no_destroy()': fix null state string for
   DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE

* 'bus: mhi: host: add new interfaces to handle MHI channels
  directly': fix typos in comments

* 'bus: mhi: host: add new interfaces to handle MHI channels directly': honour
   initial autoqueue configuration

* 'bus: mhi: host: add new interfaces to handle MHI channels
   directly': don't prepare/unprepare MHI devices that don't match
   with a MHI client driver

* 'wifi: ath11k: remove MHI LOOPBACK channels': remove LOOPBACK channels for QCN9074 as well

v1: https://lore.kernel.org/mhi/20231110102202.3168243-1-kvalo@kernel.org/

Baochen Qiang (7):
  bus: mhi: host: add mhi_power_down_no_destroy()
  bus: mhi: host: add new interfaces to handle MHI channels directly
  wifi: ath11k: handle irq enable/disable in several code path
  wifi: ath11k: remove MHI LOOPBACK channels
  wifi: ath11k: do not dump SRNG statistics during resume
  wifi: ath11k: fix warning on DMA ring capabilities event
  wifi: ath11k: support hibernation

Kalle Valo (1):
  wifi: ath11k: thermal: don't try to register multiple times

 drivers/bus/mhi/host/init.c               |   1 +
 drivers/bus/mhi/host/internal.h           |   1 +
 drivers/bus/mhi/host/main.c               | 107 ++++++++++++++++++++++
 drivers/bus/mhi/host/pm.c                 |  26 ++++--
 drivers/net/wireless/ath/ath11k/ahb.c     |   8 +-
 drivers/net/wireless/ath/ath11k/core.c    |  44 +++++----
 drivers/net/wireless/ath/ath11k/core.h    |   2 +
 drivers/net/wireless/ath/ath11k/hif.h     |  12 +--
 drivers/net/wireless/ath/ath11k/mhi.c     |  77 ++++------------
 drivers/net/wireless/ath/ath11k/mhi.h     |   4 +-
 drivers/net/wireless/ath/ath11k/pci.c     |  55 +++++++++--
 drivers/net/wireless/ath/ath11k/qmi.c     |   7 +-
 drivers/net/wireless/ath/ath11k/thermal.c |   3 +
 drivers/net/wireless/ath/ath11k/wmi.c     |   1 +
 include/linux/mhi.h                       |  47 +++++++++-
 15 files changed, 285 insertions(+), 110 deletions(-)


base-commit: 16a212b4f33c4edd9ce9a9e0953b5389216e8ed9
-- 
2.39.2


