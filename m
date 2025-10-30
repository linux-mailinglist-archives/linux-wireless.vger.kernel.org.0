Return-Path: <linux-wireless+bounces-28403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880EC1FA2B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 11:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A873C18841A5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262733C53C;
	Thu, 30 Oct 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KnRZ5xVc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCBA1EF39E;
	Thu, 30 Oct 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821376; cv=none; b=ZqNXuSHXVITV6syRQSr82ofrQcguFon9q9RQup02fIZm4roV/ztLEiy+DeVUcyleTUCcCrJb3kFN+Lv45ikp1mMucvIcxmOh1z1F2TpI3+yxcR6YctMpwN9f0rB5sXaUah4brM0waioQfT4M3WE+miOU5xZVf6m0/4ML59oObcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821376; c=relaxed/simple;
	bh=QZIq4QpcjCi+U9bq12x/wte+do2PQHZY3yjvYitMMgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIEI/wCs3joL6OdmdNzImUsoylw5SP0n1L6tJLcT0UF4Ofd4VElL27hih4E18XpWd2ZcucX74envDBuhgJaZUFzI/W2URKT7HBuOxna8hTQ/vqxCeYS05bmqN4W4dNE/OMr8t8ffj7CzKrg4Xt3T4dEKx91ofWrRj/NuZgCiKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KnRZ5xVc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=zHfHVPnhSgO0iB2CVKBRrVMgdptuKxMneZV2BdH/BJs=; t=1761821375; x=1763030975; 
	b=KnRZ5xVcapfNGamkRzWRX9/Mc+Y1timWLqIrgTVWechY+gnXocE2JvzaIl/XD05XMJubc0s0zyL
	ea+oWvxMV91hKRkg5uXH1z0GJmFq8zg4pTykzfUUqH3SIwglpQ6ZscVQgjssSHSKE9Dmwv6W5Ytak
	GOrZ0+hWOg+4yR/Z8TGY5gRqb4EOgw4EL8wl+utcbmEaFBj3jdTNIDq63+MbUNsW5n4H6MiGAYJyI
	nZAojBsI1mJ0OufT3cV7DggOJxCUpx+5ab2L6CF+2faDib7QC4Bx/Amu23O6fRF71Cblz2CpZICgG
	+IzlpH2KOZbkRMwjXJkuWI8PObyhvrEpFmFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vEQDe-0000000GLuF-0oFz;
	Thu, 30 Oct 2025 11:49:26 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-10-30
Date: Thu, 30 Oct 2025 11:48:05 +0100
Message-ID: <20251030104919.12871-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the "not quite Halloween" edition, but there's
nothing scary here ;-) The hrtimer work is maybe more
than I'd strictly like, but all of the affected features
turned out to be pretty broken due to long timer slack,
and it doesn't fundamentally change the behaviour apart
from using the more precise timers.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit a83155cc4ec5dd8c99edb541dc12d3bd8e97eae9:

  Merge tag 'wireless-2025-10-23' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-10-23 17:15:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-10-30

for you to fetch changes up to 70e8335485966d7d4ed85976dceab52803b151a2:

  wifi: zd1211rw: fix potential memory leak in __zd_usb_enable_rx() (2025-10-30 08:41:10 +0100)

----------------------------------------------------------------
Couple of new fixes:
 - ath10k: revert a patch that had caused issues on some devices
 - cfg80211/mac80211: use hrtimers for some things where the
                      precise timing matters
 - zd1211rw: fix a long-standing potential leak

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: zd1211rw: fix potential memory leak in __zd_usb_enable_rx()

Baochen Qiang (1):
      Revert "wifi: ath10k: avoid unnecessary wait for service ready message"

Benjamin Berg (4):
      wifi: cfg80211: add an hrtimer based delayed work item
      wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
      wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
      wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work

Johannes Berg (1):
      Merge tag 'ath-current-20251027' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

 drivers/net/wireless/ath/ath10k/wmi.c        | 39 +++++++-------
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c |  1 +
 include/net/cfg80211.h                       | 78 ++++++++++++++++++++++++++++
 net/mac80211/chan.c                          |  2 +-
 net/mac80211/ieee80211_i.h                   |  8 +--
 net/mac80211/link.c                          |  4 +-
 net/mac80211/mlme.c                          | 52 +++++++++----------
 net/wireless/core.c                          | 56 ++++++++++++++++++++
 net/wireless/trace.h                         | 21 ++++++++
 9 files changed, 209 insertions(+), 52 deletions(-)

