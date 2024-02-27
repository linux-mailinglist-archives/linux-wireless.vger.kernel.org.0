Return-Path: <linux-wireless+bounces-4091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84D8694FD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8E628E69E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE233140391;
	Tue, 27 Feb 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDX8TSI2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8313F01E;
	Tue, 27 Feb 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042272; cv=none; b=DkyyM5ixahm+ZeQvu1NRlKGd5B7Tdm7OyKhfHlbp7gPZ5nyJe1sG/7afEJhdiKu62jI7ypqzbEjd/RqzoZlwLOE5Oyd9vYyzDnNs6oAyUE7lE2suxbjo11EPWPdcEd3i90ws0PmjJbcy8EXcYF76d5giC1yFLpQ9DpnHw5EA75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042272; c=relaxed/simple;
	bh=biCbZLCy7NySqqV+H6vAkrnFQ5KUncRsBTr63Ei8uJ8=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=kUM+X+MFLKOPrkvSLeeVY1ls9gsd9/i3n6NR0TWRgElfggLAZzyYi+8DIKKcFw+6OA21FEsgsTb3EPGp9zlIr+cxy+Ii8Y23hrk/tU/rpEJGaDQPuv7LKAIcQeMS00sTIDpXMoWacp106Ux+6NMQnnTkY5N26F+JOWFi/H/o5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDX8TSI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EC6C43390;
	Tue, 27 Feb 2024 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709042272;
	bh=biCbZLCy7NySqqV+H6vAkrnFQ5KUncRsBTr63Ei8uJ8=;
	h=From:Subject:To:Cc:Date:From;
	b=UDX8TSI2NC8W4w3xmtJqv6+o40jLQv32R91o38ku4NH3POsVajzYJz1YndQco8h9v
	 jvDozxc0Ye+UGJPgFdoumAanvfbSdC63RVIGrsZk1MoDEUWge9wcBISnJ8g4fy7DOu
	 zAefJWUMcpRHQzEp0yLhxkAQhkD5pPd+NcE418zxIPXh34spdp2SbtYF1uZ4LoBKEG
	 8pQgnLo20uplFRapVUG4vx9iMAeaaUEJNTvwqAU7DQ/GbdaLwHVGC4WRTTXdMuzJtS
	 3sEhztcpzAALp6CyWajYvpnB8MpIgOT4CzUKsS/C0Eo+FYhEzTiA9B4dECum57fwF1
	 MJ+dLfExl0utw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-02-27
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240227135751.C5EC6C43390@smtp.kernel.org>
Date: Tue, 27 Feb 2024 13:57:51 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit b7198383ef2debe748118996f627452281cf27d7:

  wifi: iwlwifi: mvm: fix a crash when we run out of stations (2024-02-08 14:55:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-02-27

for you to fetch changes up to 413dafc8170fcb925fb17af8842f06af305f8e0b:

  wifi: mac80211: only call drv_sta_rc_update for uploaded stations (2024-02-23 09:22:52 +0100)

----------------------------------------------------------------
wireless fixes for v6.8-rc7

Few remaining fixes, hopefully the last wireless pull request to v6.8. Two
fixes to the stack and two to iwlwifi but no high priority fixes this
time.

----------------------------------------------------------------
Benjamin Berg (1):
      wifi: iwlwifi: mvm: ensure offloading TID queue exists

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix the TXF mapping for BZ devices

Felix Fietkau (1):
      wifi: mac80211: only call drv_sta_rc_update for uploaded stations

Jeff Johnson (2):
      MAINTAINERS: wifi: update Jeff Johnson e-mail address
      MAINTAINERS: wifi: Add N: ath1*k entries to match .yaml files

Johannes Berg (1):
      wifi: nl80211: reject iftype change with mesh ID change

 MAINTAINERS                                       | 11 +++++----
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h   | 12 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c       |  9 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 11 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  8 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 28 +++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h      |  3 ++-
 net/mac80211/rate.c                               |  3 ++-
 net/wireless/nl80211.c                            |  2 ++
 9 files changed, 76 insertions(+), 11 deletions(-)


