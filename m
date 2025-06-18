Return-Path: <linux-wireless+bounces-24256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0473EADF857
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 23:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D2F37A83E3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FECF25F796;
	Wed, 18 Jun 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sdDd0E9C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F421ABB0;
	Wed, 18 Jun 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280810; cv=none; b=lYhy89yRs12IHpZgWNWAJz3atNwa6swuYm3DYdZpcFlnz5+ehCZK7GIz2gnVcRE3RObKrSk6u2t/WerjoZlRKg8OJi/qAeP/b/89jQ6NRLO5MqJLO4bFJE03xuGwVOQUKlv2Mobx0+OoNGEXYP9XJZ+UTrsOcDoIPpO1ij6tzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280810; c=relaxed/simple;
	bh=grGkdX8+pJJ0v7mMhG3dk5V6kRwgjlAGXetVlyBy2GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jO7fdLoil+RdjYbq1kUUyER2TFfOs4A0yDV4bxVCMHXKnktQbSkMQ/qfcHp04jbDNtyjiZYxpusxcPu6gvOTechyxvWj7Pn8s1yzQnd4cEmuXi822QHoL34HqY++UEwr/gLtiQ+KrGopDm3WtoNN4t+wFMfzV28vmHdYJ+Lyrdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sdDd0E9C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=VXrwqF4nzGljRCN8aSjg8iV0NyINyQse2o3LW5XwPfk=; t=1750280808; x=1751490408; 
	b=sdDd0E9CXYs6qTVDsEdpgP+VohsqfxMwEguB6UE2t53CuK65B5ygQAtWqH4Q4kV9e7sH+tzdON8
	uOmdwwFwdczmYgbAcOlWGx1o12zm5vr09yrXMV4QPnUistly9APa0UD0pgDFDfnXFqpiYgKbmzdn+
	rX/MzgnQEj77yd2JyUf825YBPwqFhIu9B2rZA1W/fCMdvuUemR/od2EKGxnIdfBAV6ygZvqrqrBOI
	PRBqc+hV+9IYZFcJ4nSkKhCmO6fufV4ZTcRG3yVDioAX2kQPyZgRi1GG30+oxPSjYLp9inuYKQ80H
	ggNqxCCFrq2qp6KSJWiDuwTI4xGZSqEzvILA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRzzZ-0000000Gybs-18vx;
	Wed, 18 Jun 2025 23:06:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-06-18
Date: Wed, 18 Jun 2025 23:05:56 +0200
Message-ID: <20250618210642.35805-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Another set of fixes, pretty regularly scheduled now it seems.
Mostly ath*k and iwlwifi fallout, but we also have a bunch of
syzbot fixes - seems a few people independently got inspired
to take a look.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 27605c8c0f69e319df156b471974e4e223035378:

  Merge tag 'net-6.16-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-12 09:50:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-06-18

for you to fetch changes up to 68dd8eeb7208f16a0592da3896dd59379d95d553:

  Merge tag 'iwlwifi-fixes-2025-06-18' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-06-18 10:49:16 +0200)

----------------------------------------------------------------
More fixes:
 - ath12k
   - avoid busy-waiting
   - activate correct number of links
 - iwlwifi
   - iwldvm regression (lots of warnings)
   - iwlmld merge damage regression (crash)
   - fix build with some old gcc versions
 - carl9170: don't talk to device w/o FW [syzbot]
 - ath6kl: remove bad FW WARN [syzbot]
 - ieee80211: use variable-length arrays [syzbot]
 - mac80211
   - remove WARN on delayed beacon update [syzbot]
   - drop OCB frames with invalid source [syzbot]

----------------------------------------------------------------
Baochen Qiang (10):
      wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use
      wifi: ath12k: parse and save sbs_lower_band_end_freq from WMI_SERVICE_READY_EXT2_EVENTID event
      wifi: ath12k: update freq range for each hardware mode
      wifi: ath12k: support WMI_MLO_LINK_SET_ACTIVE_CMDID command
      wifi: ath12k: update link active in case two links fall on the same MAC
      wifi: ath12k: don't activate more links than firmware supports
      wifi: ath12k: fix documentation on firmware stats
      wifi: ath12k: avoid burning CPU while waiting for firmware stats
      wifi: ath12k: don't use static variables in ath12k_wmi_fw_stats_process()
      wifi: ath12k: don't wait when there is no vdev started

Bjorn Andersson (1):
      wifi: ath12k: Avoid CPU busy-wait by handling VDEV_STAT and BCN_STAT

Colin Ian King (1):
      wifi: iwlwifi: Fix incorrect logic on cmd_ver range checking

Dmitry Antipov (1):
      wifi: carl9170: do not ping device which has failed to load firmware

Johannes Berg (7):
      wifi: remove zero-length arrays
      wifi: mac80211: drop invalid source address OCB frames
      wifi: mac80211: don't WARN for late channel/color switch
      wifi: ath6kl: remove WARN on bad firmware input
      Merge tag 'ath-current-20250617' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: iwlwifi: dvm: restore n_no_reclaim_cmds setting
      Merge tag 'iwlwifi-fixes-2025-06-18' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Miri Korenblit (1):
      wifi: iwlwifi: restore missing initialization of async_handlers_list (again)

Pei Xiao (1):
      wifi: iwlwifi: cfg: Limit cb_size to valid range

 drivers/net/wireless/ath/ath12k/core.c             |   4 +-
 drivers/net/wireless/ath/ath12k/core.h             |  10 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |  58 --
 drivers/net/wireless/ath/ath12k/debugfs.h          |   7 -
 drivers/net/wireless/ath/ath12k/mac.c              | 394 +++++++++-
 drivers/net/wireless/ath/ath12k/mac.h              |   2 +
 drivers/net/wireless/ath/ath12k/wmi.c              | 829 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h              | 180 ++++-
 drivers/net/wireless/ath/ath6kl/bmi.c              |   4 +-
 drivers/net/wireless/ath/carl9170/usb.c            |  19 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |  11 +-
 include/linux/ieee80211.h                          |  18 +-
 net/mac80211/debug.h                               |   5 +-
 net/mac80211/rx.c                                  |   4 +
 net/mac80211/tx.c                                  |  29 +-
 18 files changed, 1445 insertions(+), 133 deletions(-)

