Return-Path: <linux-wireless+bounces-24478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F6AE8227
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 13:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E635618938C1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE42609F6;
	Wed, 25 Jun 2025 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l1JjiTMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65B25F971;
	Wed, 25 Jun 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852486; cv=none; b=gj3GaLnOfSg4xQGpf5gUJeZQ6mfBwQRfmwVgLW4Sdpr2j1Dy7yjJXiDY8suobYJgaPCdkfsk7ZKS/PDTkCTi0qxke9YdhqfLQsiRS4/yMgzdziF5FHI8PXFniKIbIjqNB1sjhAdR+b+awr+0gLqvZv/Q91J+9fTJtnOeD8y5jrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852486; c=relaxed/simple;
	bh=fYhqgWcrMDUQh0LcbaY40LxLgotnOxTn/1XEiPONA6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMdmwKkYsgtZwZtP9A3Vpv5bNL0c3KQQnUSV3KfXpXJ38PEqnsvGjjQ+LHxenmd3/hXoMkeXtjE2CUAHrgv9HZLTYfOIcbKweNaX1cY7YwX2W7bTh+T6YkDvkITmzzzFxIjoBNh7Z2WvjartC/73Mim708SltiCXqURZOBSoI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l1JjiTMl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yBa1t/SHtIDzKXtNq3+WIr8qjUOXvNiOwZ9/+bz71Z8=; t=1750852485; x=1752062085; 
	b=l1JjiTMlB5mg6H3Fv4RJWTR9ztIXNNK8rf4HiF+ABl8ta0VbvxPWnfGaOU/XK/VqLjCD9TogSuK
	KYAl0DS5vOLxpFD0dKFvd21SFbRGpg6A7U4VJc4wVZFXfsql7J3yaNBPjXw0ZzpWhH5jIPPcmsl/6
	OR/U3vuAHyRJ7cs2HGseSruonmT+eFhK4C4UntySc1M34+5L6sDfaLohWgHANLv+y1VkV2G4boM1a
	u6dqhzmvOeh7/1E8x5IfgHkICf0ANX8XaPNwJVwhGhqtpDp99RWSjSmx/5LDAQPM7Pjy0W1qk3H/U
	zCh/QxThvtHargiX+yeGm+EPNGLCT+uPhJOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUOi5-00000009wKe-3cvn;
	Wed, 25 Jun 2025 13:54:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-06-25
Date: Wed, 25 Jun 2025 13:54:08 +0200
Message-ID: <20250625115433.41381-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Just a handful of new fixes, nothing stands out. No known
conflicts either.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 5c8013ae2e86ec36b07500ba4cacb14ab4d6f728:

  Merge tag 'net-6.16-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-19 10:21:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-06-25

for you to fetch changes up to 95b922dd04f74a45fb86b34a25cda62f427a2b5c:

  Merge tag 'iwlwifi-fixes-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-06-25 10:20:03 +0200)

----------------------------------------------------------------
Just a few fixes:
 - iwlegacy: work around large stack with clang/kasan
 - mac80211: fix integer overflow
 - mac80211: fix link struct init vs. RCU publish
 - iwlwifi: fix warning on IFF_UP

----------------------------------------------------------------
Arnd Bergmann (1):
      wifi: iwlegacy: work around excessive stack usage on clang/kasan

Johannes Berg (2):
      wifi: mac80211: finish link init before RCU publish
      Merge tag 'iwlwifi-fixes-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Lachlan Hodges (1):
      wifi: mac80211: fix beacon interval calculation overflow

Miri Korenblit (1):
      wifi: iwlwifi: mvm: assume '1' as the default mac_config_cmd version

 drivers/net/wireless/intel/iwlegacy/4965-rs.c    | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 4 ++--
 net/mac80211/link.c                              | 6 +++---
 net/mac80211/util.c                              | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

