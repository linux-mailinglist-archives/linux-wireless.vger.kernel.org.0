Return-Path: <linux-wireless+bounces-28866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08FC5215F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 12:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D31B188F25D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C83A313537;
	Wed, 12 Nov 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OZ6Prb2I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8762D6E7E;
	Wed, 12 Nov 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947991; cv=none; b=puwFANAv8d3UPaS2SJ4OwR+2eWOdCCrxEoJKFkSxs2ZeZPGssgGRcc9wRRKc19ixVpJcws1ThQ+1m8QyNESZEB1JtpZ9sZV9NoQXiSbTXxtiAX4sclTF2qKLB5tcneD04CRNqF199/QOGIihSvuKnLScZx7hKMh8bWbi2sBaxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947991; c=relaxed/simple;
	bh=TKLE4KJ2DnftHA0ZLvrF4UANQmpXCg9qPqzhuwVOhfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPJ419QQXrdh9FqfPMq1ttgTDQdk9Holv5mxypv+ChCLrgVeT6pOk5t0MTd6ca8/BRLjbtT6/pue9cd9CYxFj334PsNrSOOFuxUoBR/4ApW5k9eBzdg/7dwd52ciwYS/uVXazOj/Kro2w1UB/HYheDdj9jawTJr/O0XFUh5/NhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OZ6Prb2I; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=el1H+VwEaoSVHTBYapEN6dATz+Faz5AfCW5KT0gELP8=; t=1762947989; x=1764157589; 
	b=OZ6Prb2I4ld/+H1lpuyrlsdPpoGlPfGMeDsMv4dvS8EyYO/v3yzZa4tUfbQ43Wp+nMrPGCR/BsA
	BapEZpFVGgJR662he8kMiEwEalDq6Gla/r8R8VPz6DZiVUt0Un60FsVw9m7CASBwF6M6fQ/uss1ce
	Dcu1mGYjNsTH0xsl8ENNGJkP71TjFqJrTxVNIfpqKnDb8mkPVr5wbUhcx1b8Ayofhvrh5HIv7nwUI
	+8lizJQtQ23wDO+I9DoxuS24QsuEBnos6Dp06Q64u2Q9RxXDd8FRrxCXKMK+SWqTik+yhKe2JIplp
	nOzpphvdfyKpFc9Tdg+RGfT4BAjkjv4/9qAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vJ9Iu-00000001BZW-2AV2;
	Wed, 12 Nov 2025 12:46:25 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-11-12
Date: Wed, 12 Nov 2025 12:45:38 +0100
Message-ID: <20251112114621.15716-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

And we have another set for net/rc6. Basically just
more driver fixes trickling in, various small issues.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0:

  Merge tag 'net-6.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-06 08:52:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-11-12

for you to fetch changes up to a35f64a216ca1c9e3c3f0f91fdb54ef9515a7fe7:

  Merge tag 'iwlwifi-fixes-2025-11-12' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-11-12 09:51:05 +0100)

----------------------------------------------------------------
Couple more fixes:
 - mwl8k: work around FW expecting a DSSS element in beacons
 - ath11k: report correct TX status
 - iwlwifi: avoid toggling links due to wrong element use
 - iwlwifi: fix beacon template rate on older devices
 - iwlwifi: fix loop iterator being used after loop
 - mac80211: disallow address changes while using the address
 - mac80211: avoid bad rate warning in monitor/sniffer mode
 - hwsim: fix potential NULL deref (on monitor injection)

----------------------------------------------------------------
Benjamin Berg (1):
      wifi: mac80211: skip rate verification for not captured PSDUs

Ilan Peer (1):
      wifi: mac80211_hwsim: Fix possible NULL dereference

Johannes Berg (4):
      wifi: mac80211: reject address change while connecting
      Merge tag 'ath-current-20251110' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: iwlwifi: mvm: fix beacon template/fixed rate
      Merge tag 'iwlwifi-fixes-2025-11-12' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Junjie Cao (1):
      wifi: iwlwifi: fix aux ROC time event iterator usage

Miri Korenblit (1):
      wifi: iwlwifi: mld: always take beacon ies in link grading

Nicolas Escande (1):
      wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()

Pawel Dembicki (1):
      wifi: mwl8k: inject DSSS Parameter Set element into beacons if missing

 drivers/net/wireless/ath/ath11k/wmi.c              |  3 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  7 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  | 13 +---
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    | 14 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     | 12 +++-
 drivers/net/wireless/marvell/mwl8k.c               | 71 ++++++++++++++++++++--
 drivers/net/wireless/virtual/mac80211_hwsim.c      | 14 +++--
 net/mac80211/iface.c                               | 14 ++++-
 net/mac80211/rx.c                                  | 10 ++-
 9 files changed, 117 insertions(+), 41 deletions(-)

