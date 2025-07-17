Return-Path: <linux-wireless+bounces-25592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC5B0891C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E36C4A294C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0A4286D79;
	Thu, 17 Jul 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pSKWh3+Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9072F850;
	Thu, 17 Jul 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743928; cv=none; b=WITTxhZ2V2Ph9TFfsqAHBiAum8E7WT5riyhjW3/zAudLd+sBBUd1Xo/YsnJ86b39m3Eh/25EjKMg0z9GfhaRZYKu6r9d7clV1BizeAIGsaSpoItovwzRLJ7aApdYg+S44ArDlqjNH3pmub1ynHOm1JrYiz5HYXbOxHdmOSm32AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743928; c=relaxed/simple;
	bh=Hxeoe/IyZ1r0U3+EapO3WzBH4XGJpbd0CWwOlhq8Km8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+ODC7In2wKI7yw9ZAqbVVoqEKzJkRaEhb02ygFZZ1GMq5vgTdo/s7grlmni7V/h+x0/0c2880AdtJMOKfvx7pWch/v0ETw0z2DkeJ96ohg5ec7VUctZH7M/FNQE/aVkF7q6+an6O0qdy8j+uIRW8Ydd1saXhZHkotVN/cu4xMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pSKWh3+Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=J2DU8BinJtTj6zWNKckPvPSU7LpvWApu/5nBDO4nfpQ=; t=1752743927; x=1753953527; 
	b=pSKWh3+YCIRGGEstI5/rdYvyiz/Meza9uupIsZrPNTIgxXUOW0Z6aek9/nWcQSJx9b6CiTgiSE8
	XjXV8NGskFYauD1lcg+Q91OBq4H3OOQZnSxGbtEfvli1hN6cfcL69WMlcfZtiWl81RkOzW7ob3WF4
	FnQSPyf4JOBkOypGDCuAFXOxz5PZ1b4n0OY/PewJSKfd1+wRt9QfyF4M7XmiRlxFlBtPOmN5eH3X4
	ayFdr4TBvLs+MUqQYwpKVl551fzg8xTtwMFNRUK9Gd3wLUMWDGM+yTdeMNNcZ9BgjpoDIFFxZbuc/
	M6lC4LaizW1yJKFXe1HXBhMqOxQGzJez4kUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucKl9-0000000AFf9-48pq;
	Thu, 17 Jul 2025 11:18:36 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-07-17
Date: Thu, 17 Jul 2025 11:17:10 +0200
Message-ID: <20250717091831.18787-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

Hi,

So, I thought we'd not have anything, but clearly wasn't fully
aware of what the drivers were doing, and then also syzbot came
up with _another_ complaint about __counted_by(), at which point
I took a closer look and just removed it there (with all the
reasons in the commit message.) Fingers crossed that's it :)

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit c7979c3917fa1326dae3607e1c6a04c12057b194:

  Merge tag 'net-6.16-rc6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-11 10:18:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-07-17

for you to fetch changes up to bbc19fef578970158847a41d9b6b6b218034b8c2:

  Merge tag 'iwlwifi-fixes-2025-07-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-07-15 13:07:43 +0200)

----------------------------------------------------------------
Couple of fixes:
 - ath12k performance regression from -rc1
 - cfg80211 counted_by() removal for scan request
   as it doesn't match usage and keeps complaining
 - iwlwifi crash with certain older devices
 - iwlwifi missing an error path unlock
 - iwlwifi compatibility with certain BIOS updates

----------------------------------------------------------------
Johannes Berg (4):
      wifi: iwlwifi: pcie: fix locking on invalid TOP reset
      Merge tag 'ath-current-20250714' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: cfg80211: remove scan request n_channels counted_by
      Merge tag 'iwlwifi-fixes-2025-07-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Nithyanantham Paramasivam (1):
      wifi: ath12k: Fix packets received in WBM error ring with REO LUT enabled

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mask reserved bits in chan_state_active_bitmap

Ville Syrjälä (1):
      wifi: iwlwifi: Fix botched indexing conversion

 drivers/net/wireless/ath/ath12k/dp_rx.c              | 3 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h  | 5 +++--
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c   | 1 +
 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c  | 4 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 6 ++++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c         | 8 ++++----
 include/net/cfg80211.h                               | 2 +-
 7 files changed, 18 insertions(+), 11 deletions(-)

