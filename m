Return-Path: <linux-wireless+bounces-28204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04414C02D8A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 20:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D877C1885B1D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B966134B1AC;
	Thu, 23 Oct 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wmYAcSpf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5575236453;
	Thu, 23 Oct 2025 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242773; cv=none; b=nqGWtTNlmyJHlCtKHobTbLLNoDWHpwRclDYnQ+KMyJ68rtUYdPZyBC7KBxoGFOZujnV1qNaRRVYyBBR+LTXKSDh0UDj9sRe143BZi9K2DDnWoCTK2idrqaNiPpcqua55fKFZGRFhK/vZ/XDUVAbvsV/vZazTWDlktbggBKfQ2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242773; c=relaxed/simple;
	bh=4WS7V+Ar3ZrEzSEP6kk+SJ2RfPh6RA/fmr4gByf8A6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sXAqDGIFAB4y5dJj7cumd2uU2QwLxv0AAh0mPf7CaGaL7kVxTwY6Q8bKySnHV82bLRROKLqnExbaAqvVd1iuXCQEvOcv6fjBi5gu5odkyzqO0HUxA54sVieQ91v0YyrO9ahSvqHaTIxM2o1adUNTxU/2BYFE1Z5V/XR8Rl15IRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wmYAcSpf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=EwqNedB3On+EgqMf/8gkT0TjnyfVJmQtvxMJOxXoqZc=; t=1761242771; x=1762452371; 
	b=wmYAcSpfVZaRsbZUxuw7UpFUWi4/Yfqv1MTGW3sz7Kizngude5z9xWqXABXCoWQrhXYdyJP0Wkr
	/p0bMZ6Snlqjna0NWPcoQNkmsexEqfWSrEtoAD7Hjz/1i/W+0Jab7de2XkNxNuRjc33crKhFvO+Xq
	9goCaa95cK7qOcB5mwjebJkOhh5VgjCAZP6NgBQpO+z97PtrmAYIXroZTpnsrFRj6XTkgV4cZ4Jdv
	JRfjaA99BFkumdXorfET+nnl8dXOfQct/49uMpFBwLbbDjVs6TJRmtEuBJeoHMOQNWmU6gvot4VdB
	uWvspgpnecrFLRgsg8XxKN2a9inhSI9YzfDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBzhQ-00000000UqB-18uc;
	Thu, 23 Oct 2025 20:06:08 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-10-23
Date: Thu, 23 Oct 2025 20:05:04 +0200
Message-ID: <20251023180604.626946-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
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

Sorry, I meant to send this earlier, but ... I guess other
things happened. Luckily none of the below seems really all
that urgent, most issues have been around for a while and
I'm not currently aware of anyone being affected too badly.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 634ec1fc7982efeeeeed4a7688b0004827b43a21:

  Merge tag 'net-6.18-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-16 09:41:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-10-23

for you to fetch changes up to 69e4b75a5b90ef74300c283c0aafe8d41daf13a8:

  Merge tag 'iwlwifi-fixes-2025-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-10-20 13:58:10 +0200)

----------------------------------------------------------------
First set of fixes:
 - brcmfmac: long-standing crash when used w/o P2P
 - iwlwifi: fix for a use-after-free bug
 - mac80211: key tailroom accounting bug could leave
             allocation overhead and cause a warning
 - ath11k: add a missing platform,
           fix key flag operations
 - bcma: skip devices disabled in OF/DT
 - various (potential) memory leaks

----------------------------------------------------------------
Aloka Dixit (1):
      wifi: mac80211: reset FILS discovery and unsol probe resp intervals

Dan Carpenter (1):
      wifi: iwlwifi: fix potential use after free in iwl_mld_remove_link()

Dr. David Alan Gilbert (1):
      MAINTAINERS: wcn36xx: Add linux-wireless list

Emmanuel Grumbach (1):
      wifi: nl80211: call kfree without a NULL check

Gokul Sivakumar (1):
      wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode

Johannes Berg (3):
      Merge tag 'ath-current-20251006' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: fix key tailroom accounting leak
      Merge tag 'iwlwifi-fixes-2025-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Karthik M (1):
      wifi: ath12k: free skb during idr cleanup callback

Loic Poulain (1):
      wifi: ath10k: Fix memory leak on unsupported WMI command

Mark Pearson (1):
      wifi: ath11k: Add missing platform IDs for quirk table

Rafał Miłecki (1):
      bcma: don't register devices disabled in OF

Rameshkumar Sundaram (1):
      wifi: ath11k: avoid bit operation on key flags

 MAINTAINERS                                        |  1 +
 drivers/bcma/main.c                                |  6 +++
 drivers/net/wireless/ath/ath10k/wmi.c              |  1 +
 drivers/net/wireless/ath/ath11k/core.c             | 54 +++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/mac.c              | 10 ++--
 drivers/net/wireless/ath/ath12k/mac.c              | 34 +++++++-------
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 28 ++++-------
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |  3 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  5 +-
 net/mac80211/cfg.c                                 |  3 ++
 net/mac80211/key.c                                 | 11 +++--
 net/wireless/nl80211.c                             |  3 +-
 13 files changed, 106 insertions(+), 56 deletions(-)

