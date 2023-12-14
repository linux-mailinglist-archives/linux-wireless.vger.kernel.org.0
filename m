Return-Path: <linux-wireless+bounces-788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E8812E58
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DDA2826F6
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0983F8ED;
	Thu, 14 Dec 2023 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DFC8+J8a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667948E;
	Thu, 14 Dec 2023 03:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=HpQxZhm8d6LKtqLRDNiB4jTiJNh2mIFp64Hs6+a2K2A=; t=1702552521; x=1703762121; 
	b=DFC8+J8aGm8X2v/5PF25U4O11YsqcCTCwrpJwOBfxXZhIOWPPJQ2WuHs4qrsdDpYAuUvfBU4qOR
	K5t6n0Q+76mWhesB7QIQ60LiyWyynoGuwHuqZ0VV1AnPJ8/k8nVlQTRCjyYGMcrx9XQo9OtRkQQO0
	Ru1tAzHStl2L/epiKrOtBceER0Eu1ucbOuzq7fAe/x84ZBctPy9Bqo8iqQt83pIX+7Inyfl9QdvI5
	epwC3FMVoaxRc/vVLnE0Sdah6bR04FbbHxU3DqzGUCFAFNJSU77PZtBO+i9kxXyQ04zJkFHtw5D6Z
	Sg8GJhtDlp1gGB2FgIXSvakITrPtXvX8AtXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rDjgU-0000000Amjs-2rid;
	Thu, 14 Dec 2023 12:15:18 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2023-12-14
Date: Thu, 14 Dec 2023 12:13:56 +0100
Message-ID: <20231214111515.60626-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So more stragglers than I'd like, perhaps, but here we are.
A bunch of these escaped Intel's vault late though, and we're
now rewriting our tooling so should get better at that...

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 91fdb30ddfdb651509914d3ed0a0302712540fed:

  net: libwx: fix memory leak on msix entry (2023-11-29 20:13:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-12-14

for you to fetch changes up to 3c2a8ebe3fe66a5f77d4c164a0bea8e2ff37b455:

  wifi: cfg80211: fix certs build to not depend on file order (2023-12-14 09:11:51 +0100)

----------------------------------------------------------------
 * add (and fix) certificate for regdb handover to Chen-Yu Tsai
 * fix rfkill GPIO handling
 * a few driver (iwlwifi, mt76) crash fixes
 * logic fixes in the stack

----------------------------------------------------------------
Avraham Stern (1):
      wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Edward Adam Davis (1):
      wifi: mac80211: check if the existing link config remains unchanged

Felix Fietkau (1):
      wifi: mt76: fix crash with WED rx support enabled

Johannes Berg (7):
      wifi: ieee80211: don't require protected vendor action frames
      wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
      wifi: mac80211: don't re-add debugfs during reconfig
      wifi: mac80211: check defragmentation succeeded
      wifi: mac80211: mesh: check element parsing succeeded
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |  4 +-
 drivers/net/wireless/mediatek/mt76/dma.c        | 10 +--
 include/linux/ieee80211.h                       |  3 +-
 net/mac80211/cfg.c                              |  4 +-
 net/mac80211/driver-ops.c                       |  6 +-
 net/mac80211/mesh_plink.c                       | 16 +++--
 net/mac80211/mlme.c                             |  4 +-
 net/rfkill/rfkill-gpio.c                        |  8 +++
 net/wireless/certs/wens.hex                     | 87 +++++++++++++++++++++++++
 10 files changed, 125 insertions(+), 19 deletions(-)
 create mode 100644 net/wireless/certs/wens.hex

