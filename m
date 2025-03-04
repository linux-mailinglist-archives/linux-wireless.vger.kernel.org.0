Return-Path: <linux-wireless+bounces-19759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F0A4DE2E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 13:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F57E3AD5DF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D566202976;
	Tue,  4 Mar 2025 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nPF8Zdsn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F648472;
	Tue,  4 Mar 2025 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092284; cv=none; b=hAwdsxjH1VTFwdtMHTGCVRFAqxmx0fUMoS7fwmdjGFL5mQ06DsYLwpg/81R/L0tUie9Pm0wGIylz574trQZue8ay3C9ZvhtWV/Z39Jcv3sQ3yxTh8HJy5wt0xwDI7O9U8isFNTebPjM7rYEHVSAraY32TC8zPPPQhXpVvDuA+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092284; c=relaxed/simple;
	bh=XEvvVwt2G5MZoqyN++xcMmzwL9nv97rZFKIS+i/NyeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXL+nMSLNPEcvYX3P5w7bMmO4AvjC9TJtyRgMUsGLgavsdP+8iuZ44aY48VSrnvVH125OjZBXC5n0ifGbb1blPL5bhJNlpdvRtg1/7HY4Cl+0pHoHSacZrwF3tPB6KiT2oUSu5WmJzTBAMFRGwep8RWp/u5+iKHMaAnUT54fhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nPF8Zdsn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=alnDlK3Jo4/jWHg0ZREeZpdX2eyO5TjSDiNCNdsWgDc=; t=1741092282; x=1742301882; 
	b=nPF8ZdsnJCjv95HLKP2HADV1YcX0BruqHqIWyGBszdzf3opPAAFK89b07D/Y/eC9FGe9Z0cVYG9
	t9sRA3bcMMdDvMSMw1uxFlyovpYI/gnxVJLvd2CAYikgvtIttSRKsA2Xti8hTnqDKn8SEMMkIUwVG
	rRhmSodz6sh2xakgPu1jtZiB/NP/Lf/b/dZs/VDGMktMkvE5O23zNJokdPVoKnvLVXaaMZlID5GJJ
	IyXWIL/4zx18PWjTEu3vtw7ajf5jjFw1TcYBvZtO2t3uQTxo2E87JNLVpRgttl7CzoGC1IBbKVfMc
	7LejDmvYfQvOx79KzALR0n8ZRcxdigjBmnnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tpRdY-00000000hAz-0L6B;
	Tue, 04 Mar 2025 13:44:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2025-03-04
Date: Tue,  4 Mar 2025 13:43:18 +0100
Message-ID: <20250304124435.126272-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here's another set of fixes, sorry for the delay.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit b76adb9758f8eaaf22b824d0bcdd694551ce0557:

  MAINTAINERS: wifi: remove Kalle (2025-02-06 22:30:26 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-03-04

for you to fetch changes up to 1f860eb4cdda634589d75e78ff586d5dff20b8af:

  wifi: nl80211: disable multi-link reconfiguration (2025-03-04 12:50:25 +0100)

----------------------------------------------------------------
bugfixes for 6.14:
 * regressions from this cycle:
   - mac80211: fix sparse warning for monitor
   - nl80211: disable multi-link reconfiguration (needs fixing)
 * older issues:
   - cfg80211: reject badly combined cooked monitor,
               fix regulatory hint validity checks
   - mac80211: handle TXQ flush w/o driver per-sta flush,
               fix debugfs for monitor, fix element inheritance
   - iwlwifi: fix rfkill, dead firmware handling, rate API
              version, free A-MSDU handling, avoid large
              allocations, fix string format
   - brcmfmac: fix power handling on some boards

----------------------------------------------------------------
Alexander Wetzel (3):
      wifi: mac80211: Cleanup sta TXQs on flush
      wifi: mac80211: remove debugfs dir for virtual monitor
      wifi: mac80211: Fix sparse warning for monitor_sdata

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't dump the firmware state upon RFKILL while suspend
      wifi: iwlwifi: mvm: don't try to talk to a dead firmware
      wifi: iwlwifi: mvm: use the right version of the rate API

Ilan Peer (2):
      wifi: iwlwifi: Free pages allocated when failing to build A-MSDU
      wifi: iwlwifi: Fix A-MSDU TSO preparation

Johannes Berg (6):
      wifi: iwlwifi: fw: allocate chained SG tables for dump
      wifi: iwlwifi: mvm: clean up ROC on failure
      wifi: iwlwifi: limit printed string from FW file
      wifi: mac80211: fix MLE non-inheritance parsing
      wifi: mac80211: fix vendor-specific inheritance
      wifi: nl80211: disable multi-link reconfiguration

Matthias Proske (1):
      wifi: brcmfmac: keep power during suspend if board requires it

Miri Korenblit (1):
      wifi: iwlwifi: fw: avoid using an uninitialized variable

Nikita Zhandarovich (1):
      wifi: cfg80211: regulatory: improve invalid hints checking

Vitaliy Shevtsov (1):
      wifi: nl80211: reject cooked mode if it is set along with other flags

 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  20 +--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  86 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   3 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  77 ++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   7 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   2 +
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  20 +--
 net/mac80211/driver-ops.c                          |  10 +-
 net/mac80211/iface.c                               |  11 +-
 net/mac80211/mlme.c                                |   1 +
 net/mac80211/parse.c                               | 135 ++++++++++++++-------
 net/mac80211/util.c                                |   5 +-
 net/wireless/nl80211.c                             |   7 +-
 net/wireless/reg.c                                 |   3 +-
 18 files changed, 274 insertions(+), 134 deletions(-)

