Return-Path: <linux-wireless+bounces-1046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A68193B5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D851F26110
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 22:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E2626281;
	Tue, 19 Dec 2023 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L1YpC+70"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8A4F5F3;
	Tue, 19 Dec 2023 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=YUz7Dgj7SkYlMYMGXf87eK3PBQ5I5y3wAQX58koo/Dw=; t=1703025158; x=1704234758; 
	b=L1YpC+705Ww0zRMVJms/mACFm9y2Lusyxfq+uXq5IKUL9a+ZYp3iYKOtw+fZD1psv/WivqBzfK5
	By3k5Kf82XER2AUFRmzTbH7B4yT7xz/N+b5BCiRChocPAsjYLMOvzH0ATvw8FaIsptHm/2nWraLyL
	gxl4A08pOxCUjf8KchOqle5YiB5JBEEl4tRaW5co1SJ7FNCsP6SICiESotiv2UNDGggJjBnMSIJsu
	1eP4clUhZj7BkuFsOh9qmxD4H/K+qAe4eDnveV3owxxYZJ9Q9p7I6NhPCys170fcY1MUrM3YZ45cW
	sFDWThwp58SkuBde8SVsPwMsQRfEKGNXRr0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rFidf-00000000N68-2Tgb;
	Tue, 19 Dec 2023 23:32:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2023-12-19
Date: Tue, 19 Dec 2023 23:32:14 +0100
Message-ID: <20231219223233.189152-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are a couple of more fixes, the most important
one really being the iwlwifi rfkill fix.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 3c2a8ebe3fe66a5f77d4c164a0bea8e2ff37b455:

  wifi: cfg80211: fix certs build to not depend on file order (2023-12-14 09:11:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-12-19

for you to fetch changes up to 0a3d898ee9a8303d5b3982b97ef0703919c3ea76:

  wifi: mac80211: add/remove driver debugfs entries as appropriate (2023-12-19 13:08:00 +0100)

----------------------------------------------------------------
Just a couple of things:
 * debugfs fixes
 * rfkill fix in iwlwifi
 * remove mostly-not-working list

----------------------------------------------------------------
Benjamin Berg (2):
      wifi: mac80211: do not re-add debugfs entries during resume
      wifi: mac80211: add/remove driver debugfs entries as appropriate

Johannes Berg (1):
      wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

Lukas Bulwahn (1):
      MAINTAINERS: wifi: brcm80211: remove non-existing SHA-cyfmac-dev-list@infineon.com

 MAINTAINERS                                        |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 17 +++++++++--------
 net/mac80211/debugfs_netdev.c                      |  9 ++++++---
 net/mac80211/driver-ops.c                          | 14 +++++++++-----
 6 files changed, 30 insertions(+), 23 deletions(-)

