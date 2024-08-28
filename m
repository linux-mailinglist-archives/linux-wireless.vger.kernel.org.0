Return-Path: <linux-wireless+bounces-12151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4D96243D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE64F1C20BE7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222BA167DB8;
	Wed, 28 Aug 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vaYSXZ85"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07B16B39D;
	Wed, 28 Aug 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839318; cv=none; b=e0qgPtTSagGH6XHN5GQqakVgFsJYQnanUlrw669u7b3bCWv5y47aKHBOkZtnM/3M++rlekzFc98+2IhJw0hCwgqwDm1TNWu7FxnyyBvuFXn7Dw+t3vtvsof2pbwkgSDbByEDFEJIEokBhzNkusHHwPEH/kAXDH7YKmOaV4J/ZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839318; c=relaxed/simple;
	bh=7qKCrIUJj0rGaHD/WvCEQNJDmi65tOclIB7KMednsp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mf0+8bTMX9vz2g4AekSkJURPZBMjQzhZDYJWSrr17yXvKjCgoIribskP+NB0IPXhVQV0z9rZyU+dMbpKTS0asi1rbufqwNhVvXY8B2yvnHUGAMJfo7IYCXudGMmB180AlOgyH1xByBhxHYRykGqOg/Puiff9IpFQdJwMpTQ2cbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vaYSXZ85; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=kPI0YVoHpejAxcdCD4ytxcFYvbXg3psJnbpC3IIlACI=; t=1724839316; x=1726048916; 
	b=vaYSXZ85xHU7Y7qMTZA9bGN/Fp/P335Vgcj/4PCFQ7SDVZ/MILNSX15AkI1ROGrEuS+jFBnu+Hr
	eZsPjdF0iqiFa5SRvIo/SmjfqfhnUkB2pc1lgO7Isr53xZQMYd6v/VhZNNoY/u/2Ose5Ogn6n1PcV
	aZygm5TCHDLTGHNtkxltoeYF/RGZ+InHOOM2NJ9GmTC2kMe3kW6F+4hBxvJ+BUY2/+mqpI1cEbf7Y
	EC9jEqgWwv6OHfBnbvUVLT3mh47mIKwd81MRzHVAzJr29BzEtYoBb2rvr7bSTkKAnmIbqcehCQHxQ
	AkdCXLnHZ4TnJjjS1YMGRQnpelf+LSgNI0sg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjFUv-00000006uqN-31eQ;
	Wed, 28 Aug 2024 12:01:53 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2024-08-28
Date: Wed, 28 Aug 2024 12:00:33 +0200
Message-ID: <20240828100151.23662-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry this is a bit bigger and/or later than I'd hoped
for, pretty much everyone involved was on vacation for
some time. Still nothing earth shattering here, just
quite a few iwlwifi fixes.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit e37a9184f27084b891d3617723b9410f8fcaff99:

  Merge tag 'ath-current-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-08-13 12:51:21 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-08-28

for you to fetch changes up to 094513f8a2fbddee51b055d8035f995551f98fce:

  wifi: iwlwifi: clear trans->state earlier upon error (2024-08-27 09:54:24 +0200)

----------------------------------------------------------------
Regressions:
 * wfx: fix for open network connection
 * iwlwifi: fix for hibernate (due to fast resume feature)
 * iwlwifi: fix for a few warnings that were recently added
   (had previously been messages not warnings)

Previously broken:
 * mwifiex: fix static structures used for per-device data
 * iwlwifi: some harmless FW related messages were tagged
   too high priority
 * iwlwifi: scan buffers weren't checked correctly
 * mac80211: SKB leak on beacon error path
 * iwlwifi: fix ACPI table interop with certain BIOSes
 * iwlwifi: fix locking for link selection
 * mac80211: fix SSID comparison in beacon validation

----------------------------------------------------------------
Alexander Sverdlin (1):
      wifi: wfx: repair open network AP mode

Anjaneyulu (1):
      wifi: iwlwifi: fw: fix wgds rev 3 exact size

Avraham Stern (1):
      wifi: iwlwifi: mvm: allow 6 GHz channels in MLO scan

Benjamin Berg (1):
      wifi: iwlwifi: lower message level for FW buffer destination

Daniel Gabay (3):
      wifi: mac80211: fix beacon SSID mismatch handling
      wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
      wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()

Dmitry Antipov (1):
      wifi: mac80211: free skb on error path in ieee80211_beacon_get_ap()

Emmanuel Grumbach (5):
      wifi: iwlwifi: mvm: fix hibernation
      wifi: iwlwifi: mvm: take the mutex before running link selection
      wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
      wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
      wifi: iwlwifi: clear trans->state earlier upon error

Sascha Hauer (1):
      wifi: mwifiex: duplicate static structs used in driver instances

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 13 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   | 12 +++++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        | 10 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  9 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       | 21 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      | 42 ++++++++++++++--------
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 41 +++++++++++++++++++--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 32 +++++++++++++----
 drivers/net/wireless/silabs/wfx/sta.c              |  5 ++-
 net/mac80211/mlme.c                                |  2 +-
 net/mac80211/tx.c                                  |  4 ++-
 14 files changed, 161 insertions(+), 37 deletions(-)

