Return-Path: <linux-wireless+bounces-11441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB49520E3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 19:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E6F28A57E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE81BBBCC;
	Wed, 14 Aug 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDu9hroN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530716BE14;
	Wed, 14 Aug 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655768; cv=none; b=HCIavEg1+3lvVyuaKarprUt8wwJnhpJlU7BSpltQ1z0+/TNdXrVCCWkDKPXp7RSIixMqGn3rMgh6vDICT+d1wKPabmMBVDpTMXnCEBvtCNO3Y/Jl0TfE/XMCvMzsTwN01iCde5S+JmE/jV4oAHwwsAUCDOsdnrex1VTar90+cWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655768; c=relaxed/simple;
	bh=DJ3OGZQZDTcW64uk40abaAwztnSLyz6hIkXSoOybgOE=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=BA1aJZ2c5hk0HEyFXT6wITQIHOhZZU4WC1A2Dp/WvqTJSk2PSHnr8OqgFTuQhHExLmE9sp1xx7C+F1C69RPbxtk9gzmUba+aJ0xuWqRsneqprhMcHk1pNJXOv9MtPKmmlzlbPzEukYTfjJ25908PEYNxw9kZRAoEE3aSHGL45E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDu9hroN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14A0C116B1;
	Wed, 14 Aug 2024 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723655767;
	bh=DJ3OGZQZDTcW64uk40abaAwztnSLyz6hIkXSoOybgOE=;
	h=From:Subject:To:Cc:Date:From;
	b=vDu9hroN0qPSu6jjUcZ5RJysCRhIYK/AuNG3Dihfw+Q3kEa1Iz3j28sF5TTRkg57S
	 8fgbqoer+qPHHhFpP1frzgpbIt/dUCpokj9rxNmqDqFsNrzA7YjBSdrJtG1Cx+RjFh
	 59VDNI5m3Bwe7Ks3I1KEcOiwtVWzewn9WMblkC0JgdZlCqqh7jGeHdTiqMG1REKJ06
	 86rymoCmX+fprHr3KTANwifnJQTBNbmvd3r9e3JWMu0m2emyU0mXo/QvCN9zGisLau
	 NyOEVezgZ6z/qpWWpOML4VJuKSO4LxTqBRymi9jhbSZZ7IDDffUlismKK4OPdsu0Si
	 vLJJBwri1aWrQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-08-14
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240814171606.E14A0C116B1@smtp.kernel.org>
Date: Wed, 14 Aug 2024 17:16:06 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-08-14

for you to fetch changes up to e37a9184f27084b891d3617723b9410f8fcaff99:

  Merge tag 'ath-current-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-08-13 12:51:21 +0300)

----------------------------------------------------------------
wireless fixes for v6.11

We have few fixes to drivers. The most important here is a fix for iwlwifi which
caused major slowdowns for several users.

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850

Benjamin Berg (1):
      wifi: iwlwifi: correctly lookup DMA address in SG table

Bert Karwatzki (1):
      wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192du: Initialise value32 in _rtl92du_init_queue_reserved_page

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion

Kalle Valo (1):
      Merge tag 'ath-current-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

 drivers/net/wireless/ath/ath12k/dp_tx.c            | 72 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hw.c               |  6 ++
 drivers/net/wireless/ath/ath12k/hw.h               |  4 ++
 drivers/net/wireless/ath/ath12k/mac.c              |  1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 13 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |  5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 32 +++++++---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192du/hw.c    |  2 +-
 10 files changed, 123 insertions(+), 17 deletions(-)


