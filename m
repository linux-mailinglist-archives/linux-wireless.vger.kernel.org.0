Return-Path: <linux-wireless+bounces-9007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9CD9086D8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 10:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E17281FC2
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96519146E;
	Fri, 14 Jun 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HEuozICN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568F188CC1;
	Fri, 14 Jun 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355438; cv=none; b=geC9fOoEXh42yetDMIs2Dtl1vYW5rl2Ddh0rSo2p+6brFKOAYCN+y3Z2lRFmCo2K6j4TZuc55epARLTLNZ4noArIfLwoQjoWJBEJGiqHPIhYIwJeRoJdRbbdJS7yHvH6f6dVZS8FiGF67r8L/sU4rcbBycQHcRhhl2g0qwgHgF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355438; c=relaxed/simple;
	bh=xdriQCpMjpmNVBrCJ1jZItM9KNv2DMY2gtCZacQO0LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELvtqOsf+DNhpGxvPFaIP0/NEhYRoB4+q5YcyS4WYpczBkkSfIA1js1Ca1IfTPseja2z8vKclTTUqmgW5/tLfrhVbIs+VJO/2EwQ9z+ExveDB82lKwAm1hdhFvNIf7y6plxOxx/tQLiFS16Yr1cgwL1mSikv/4Iq3CxzdLuq1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HEuozICN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=oVycumswJpHb/XGD7yqMZ1AATV19rhYlmNYcNDoFmxg=; t=1718355436; x=1719565036; 
	b=HEuozICNQ4y1crtaBu23IzEJCyxoo4oNQBaZ71BXeK/1PnKV5kI9GfgsOOQEvsXjF5HEfKnO1Xv
	8AoVghIOG9x1IXYhTnuGnu3fl2ME2PvNZfUvRZQikUkbaWLsUmcQtA9xzbr8l8hsF8IwOFbgdGlmv
	MhwfY3ql9paUS2bjHuJRWDUEVE5x456/rxpIm3T9QpUYwS8S9G9HRVszfuB5pZIcff6tw301efdmd
	rAUaoTs1/IJR/yK0zWhdM52TApOJ7XUetnQuqqB3ehjvzSUaaa3nRbW2CHLqYirJBJrPPrehhu2ZU
	371Uy1b3Jp0lMSZy96N26CtSaRlEbYq/jqow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sI2kD-0000000DcLz-3Kf6;
	Fri, 14 Jun 2024 10:57:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2024-06-14
Date: Fri, 14 Jun 2024 10:56:44 +0200
Message-ID: <20240614085710.24103-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are a couple of fixes for net, including one for the
monitor mode regression you'd asked about.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 819bda58e77bb67974f94dc1aa11b0556b6f6889:

  wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS (2024-06-01 13:15:26 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-06-14

for you to fetch changes up to 0d9c2beed116e623ac30810d382bd67163650f98:

  wifi: mac80211: fix monitor channel with chanctx emulation (2024-06-14 09:14:08 +0200)

----------------------------------------------------------------
Various fixes:
 * cfg80211: wext scan
 * mac80211: monitor regression, scan counted_by, offload
 * iwlwifi: locking, 6 GHz scan, remain-on-channel

----------------------------------------------------------------
Ayala Beker (1):
      wifi: iwlwifi: scan: correctly check if PSC listen period is needed

Dmitry Antipov (1):
      wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Johannes Berg (2):
      wifi: cfg80211: wext: set ssids=NULL for passive scans
      wifi: mac80211: fix monitor channel with chanctx emulation

Kenton Groombridge (1):
      wifi: mac80211: Avoid address calculations via out of bounds array indexing

Remi Pommarel (1):
      wifi: mac80211: Recalc offload when monitor stop

Shaul Triebitz (2):
      wifi: iwlwifi: mvm: unlock mvm mutex
      wifi: iwlwifi: mvm: fix ROC version check

 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  2 ++
 net/mac80211/driver-ops.c                          | 17 +++++++++++++++++
 net/mac80211/iface.c                               | 22 ++++++++++------------
 net/mac80211/scan.c                                | 17 +++++++++--------
 net/mac80211/util.c                                |  2 +-
 net/wireless/scan.c                                | 12 +++++++++---
 8 files changed, 50 insertions(+), 26 deletions(-)

