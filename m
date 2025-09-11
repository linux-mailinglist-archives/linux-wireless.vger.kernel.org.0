Return-Path: <linux-wireless+bounces-27238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C0B52DE8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 12:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F79E56733B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 10:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236C30DD3F;
	Thu, 11 Sep 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="laMEyXaD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3202E92B0;
	Thu, 11 Sep 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585032; cv=none; b=EtpF/aD4ZyhF3c/WbLemhUXTmuvHA9g5TWS8GplHeFEia6o1YQI/yI1IVmSOgN3PCm2p1Qf3L4TGicjlJldzBudbhTnHv0i8c5ecxIgyhZNb8/NJlkZuK3ZmGHFKFfMhGaa69DYO4twICSHKOtxzZabKrbBoTNr3hYwvFI1VO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585032; c=relaxed/simple;
	bh=JYRExeq40kQZ+yOY6dVTqvarsZ0OR/4fJsER1OWwsSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U48CY2XeUN80pqW6XH/aOMB8WkyOWm2++vv2L4HW7Vw4VNP1HikhWzcYtHiQKxW+wdhKgLIJSTe5MUZ7Yl4qxFUB+hJaRnHnQ/LlnHt128Wbc5YrO1KdDu1v7wJDHvqegcy7jwm5fCgmGDvuRXB+w2B69FArV41J5KJxExaufdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=laMEyXaD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=CQcX/COZClUYhQ3IGx5RnF8jObM4/NILaRwil71giko=; t=1757585030; x=1758794630; 
	b=laMEyXaDcuuLsckAdVs2W+vYvybkYu34bfOgKwMn3vWgTt5xhSfhONHqC2t65JzhfJ4RHxtTlqy
	KQjIwNdV+eSYD/8hwOK2bYrZnVpW+b42VRggMhbj1FyC3E/sc1dmL6Q0vMpX75VOqOMmOlZQKrbZP
	UINJ51jH3DK0dJDCzB4PVwbca9F4plWNyjksr+ybDMjYz+YhpviM2qjWh856goHs9x8vjfvKiQLg5
	LxAmuC10xOB1K5K2X4TURGBmgpWrFSIq696d86FQUJBizNkPwLSU+Do6ZyY3mESImb5/9sSgbFmei
	X0gg04hiAPPBNy2HfFY+0m2rB4BxvZbsmyig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwe9c-0000000F3sD-1Bdy;
	Thu, 11 Sep 2025 12:03:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-09-11
Date: Thu, 11 Sep 2025 12:03:16 +0200
Message-ID: <20250911100345.20025-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Things are getting quieter, but we're still fixing a
few things and here also disable a new feature since
it's broken due to netlink buffer size issues.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit d69eb204c255c35abd9e8cb621484e8074c75eaa:

  Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-04 09:59:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-09-11

for you to fetch changes up to c3f8d13357deab1e04f8a52b499d6b9b704e578e:

  wifi: nl80211: completely disable per-link stats for now (2025-09-11 08:50:31 +0200)

----------------------------------------------------------------
Some more fixes:
 - iwlwifi: fix 130/1030 devices
 - ath12k: fix alignment, power save
 - virt_wifi: fix crash
 - cfg80211: disable per-link stats due
             to buffer size issues

----------------------------------------------------------------
James Guan (1):
      wifi: virt_wifi: Fix page fault on connect

Johannes Berg (4):
      wifi: iwlwifi: fix 130/1030 configs
      Merge tag 'ath-current-20250909' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'iwlwifi-fixes-2025-09-09' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      wifi: nl80211: completely disable per-link stats for now

Miaoqing Pan (2):
      wifi: ath12k: Fix missing station power save configuration
      wifi: ath12k: fix WMI TLV header misalignment

Nithyanantham Paramasivam (1):
      wifi: cfg80211: Fix "no buffer space available" error in nl80211_get_station() for MLO

 drivers/net/wireless/ath/ath12k/mac.c         | 122 ++++++++++++++------------
 drivers/net/wireless/ath/ath12k/wmi.c         |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  26 +++---
 drivers/net/wireless/virtual/virt_wifi.c      |   4 +-
 net/wireless/nl80211.c                        |  13 +--
 5 files changed, 91 insertions(+), 76 deletions(-)

