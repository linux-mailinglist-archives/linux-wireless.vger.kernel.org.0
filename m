Return-Path: <linux-wireless+bounces-20221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A4BA5D892
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB3D3B59F0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5E3236A62;
	Wed, 12 Mar 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hGnc6ncO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471DA1B6CF1;
	Wed, 12 Mar 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769261; cv=none; b=tXJHBDVAwp9Kgx7sYfkTb31KEZpPYb0kFe9a3NQmCDKAePtsGt1SiKGFdLup8Yn3Dje2fBdGTZPrOPxL9C3wD+W7ikJ34KqszHSXKyL6dIbkltVkBWcjembyrC3gPwAD/YgbLtRiXH1WQtDV6CW090k9i2nZdZQMsTD7+I/Vcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769261; c=relaxed/simple;
	bh=1tRO4hH37QZmRWi+z2mHv/okE2DMGA9se8JzUfPJ/C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dd82117fA6e3iLlN2kuu2JNhwOHJAgAiVHWKeETgscyl+zsRQua8vIua89cgQId811DuW75lR3nrupqOKPWtb/TjGn146/sAPf+Tt69fmrwQHHoVPISiF3Xp2rgSNUdcEQ879QLN0QTj6HMI5I9MM+dH5Zwm89pLPNcaGyclcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hGnc6ncO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=X95azJM+IT89U4VuWfxRFj2NsUsKwEYbn5FZ+PCLLUA=; t=1741769260; x=1742978860; 
	b=hGnc6ncOy9Rf2id0sdNB5ZhzlIc/P+3PVRU4AmPIm+dPUt8i5ALoSbWZsY8kID0diMNZ11Gub+0
	c52SCajsIlQcETGuEnJOraa5rQiuWhA8QbIPGbbC0YG4oBhMFHRFq9J5PsEtOjGEisn5Gzl6LC/8Y
	+SgUAqYuR2jpVvqX/wiNijxrQBISaAlbvYSn7AXt5z/BV+gyGMOf4oARZlTimqhzkWLfsKrfHJz08
	gR/Sfv/8p7wmYnURkfEet3za/8dzCRgUi5e5cnbU88G3XXyhSoF9esR0r4PiHIF1j5zyaMDLFAKbr
	O1rUhgemUmAeMXP3YEL4+B54EsYTv2Ii2iag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tsHkX-00000008oJ0-3IUZ;
	Wed, 12 Mar 2025 09:47:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2025-03-12
Date: Wed, 12 Mar 2025 09:46:17 +0100
Message-ID: <20250312084733.10574-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Looks like I hae a couple more fixes, but that should be
the last from what I can see now.

FWIW Stephen reported some conflicts between wireless and
wireless-next, so I'll probably pull wireless into -next
to resolve that, once this goes in.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 3c6a041b317a9bb0c707343c0b99d2a29d523390:

  Merge tag 'wireless-2025-03-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-03-04 08:48:34 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-03-12

for you to fetch changes up to 8ae227f8a7749eec92fc381dfbe213429c852278:

  wifi: mac80211: fix MPDU length parsing for EHT 5/6 GHz (2025-03-12 09:29:14 +0100)

----------------------------------------------------------------
Few more fixes:
 - cfg80211/mac80211
   - stop possible runaway wiphy worker
   - EHT should not use reserved MPDU size bits
   - don't run worker for stopped interfaces
   - fix SA Query processing with MLO
   - fix lookup of assoc link BSS entries
   - correct station flush on unauthorize
 - iwlwifi:
   - TSO fixes
   - fix non-MSI-X platforms
   - stop possible runaway restart worker
 - rejigger maintainers so I'm not CC'ed on
   everything

----------------------------------------------------------------
Benjamin Berg (1):
      wifi: mac80211: fix MPDU length parsing for EHT 5/6 GHz

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: fix PNVM timeout for non-MSI-X platforms
      wifi: mac80211: flush the station before moving it to UN-AUTHORIZED state

Ilan Peer (1):
      wifi: iwlwifi: pcie: Fix TSO preparation

Johannes Berg (3):
      wifi: rework MAINTAINERS entries a bit
      wifi: nl80211: fix assoc link handling
      wifi: mac80211: fix SA Query processing in MLO

Miri Korenblit (3):
      wifi: iwlwifi: trans: cancel restart work on op mode leave
      wifi: mac80211: don't queue sdata::work for a non-running sdata
      wifi: cfg80211: cancel wiphy_work before freeing wiphy

 MAINTAINERS                                    | 37 +++++++++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c    |  6 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c   | 11 ++++----
 net/mac80211/eht.c                             |  9 ++++++-
 net/mac80211/rx.c                              | 10 +++----
 net/mac80211/sta_info.c                        | 20 +++++++++++---
 net/mac80211/util.c                            |  8 +++---
 net/wireless/core.c                            |  7 +++++
 net/wireless/nl80211.c                         | 12 ++++++---
 10 files changed, 89 insertions(+), 33 deletions(-)

