Return-Path: <linux-wireless+bounces-33935-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHdSJ8//xGkz5gQAu9opvQ
	(envelope-from <linux-wireless+bounces-33935-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:43:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9B33286D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88772308E97B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7BF30594E;
	Thu, 26 Mar 2026 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JIfL9S6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6893148DD;
	Thu, 26 Mar 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517621; cv=none; b=nKtWGAzp6I5Vq/Rzum5sLsRGyhI91wADxJD3peU+TynOia0FffR/R1ZCMdzq8VYYyyC50noXonO+oPl4UQftEvFREGoPDXbln+ytrK1fNOAfVXHoUkeuGoHf7Cs/F6aOYJEU5Y7HeBGi6WohPRLv6QQkscPVGytk0Ta04Fg738M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517621; c=relaxed/simple;
	bh=TlgZPqsifYUNanuJk7ktg2DgD57MAfIdrP8qwPSF/Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dal61+L59LYiRB1D7KoStoRRXCYaYwfUAYj5Ay6bNO/V3LIFN/Cx3yHDSQF+UlQGom4ba2ntuK10k+hDfR9M06L4kKXam6rF8WmgnIvIIhjs+Qc+zBQ43rejq3t+rdu6Xr/ym6bMx7f3faJTyNEoeia9J1CvEkUX7EHvbrfBORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JIfL9S6Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=kpD74HZQXAuyN2XDecX4PjgJkz7NNLyVJZ/YVPKmMoY=; t=1774517620; x=1775727220; 
	b=JIfL9S6QbT7dW93TWHrqbLMJJ256kQAz5x/8WOpv/Nu2P0a+yjcwhqdXmum/ZDTsLAEPLlwpopM
	ZUTHGVXXF8Pd8HbD+nSR6KWIO62i9hBxWpbLvxcI27LK1T36cQ+vpucBfwAgvV9x65NwZGqvhEhk7
	nKsjFB+ck7Zbgg4fIH+6cc+YTFv83QrP7Iw4aejibAue2eYnJTEmoKEnRBLqzN0rURtgLk5GfH0tL
	J0jlWbZn4ijqk4CGsXhV1EVCYr6Q5hCfoJibOuf3NfYd83ba54x+ZiSxNcUwaXH/vBqiyriU1zZgC
	98OGZAxMtijn3Bh1n8GJIhXo/ifNYpjwtaZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w5h5o-0000000CyVs-1pJE;
	Thu, 26 Mar 2026 10:33:32 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-03-26
Date: Thu, 26 Mar 2026 10:31:35 +0100
Message-ID: <20260326093329.77815-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33935-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 2ED9B33286D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

And ... more fixes from drivers came in, notably iwlwifi with
a bunch of things (their maintainer had been on vacation).

I'm going to be on vacation next week, but I'm also not aware
of anything missing from drivers etc. right now, so we'll see.
I doubt this is the _last_ pull request for 7.0, but I think
not much more will come in.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit a1d9d8e833781c44ab688708804ce35f20f3cbbd:

  Merge tag 'net-7.0-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-03-19 11:25:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-03-26

for you to fetch changes up to 789b06f9f39cdc7e895bdab2c034e39c41c8f8d6:

  wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free (2026-03-25 20:46:57 +0100)

----------------------------------------------------------------
Couple more fixes:
 - virt_wifi: remove SET_NETDEV_DEV to avoid UAF on teardown
 - iwlwifi:
   - fix (some) devices that don't have 6 GHz (WiFi6E)
   - fix potential OOB read of firmware notification
   - set WiFi generation for firmware to avoid packet drops
   - fix multi-link scan timing
 - wilc1000: fix integer overflow
 - ath11k/ath12k: fix TID during A-MPDU session teardown
 - wl1251: don't trust firmware TX status response index

----------------------------------------------------------------
Alexander Popov (1):
      wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free

Alexey Velichayshiy (1):
      wifi: iwlwifi: mvm: fix potential out-of-bounds read in iwl_mvm_nd_match_info_handler()

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't send a 6E related command when not supported

Johannes Berg (3):
      wifi: iwlwifi: mld: correctly set wifi generation data
      Merge tag 'iwlwifi-fixes-2026-03-24' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'ath-current-20260324' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mld: Fix MLO scan timing

Pengpeng Hou (1):
      wifi: wl1251: validate packet IDs before indexing tx_frames

Reshma Immaculate Rajkumar (2):
      wifi: ath11k: Pass the correct value of each TID during a stop AMPDU session
      wifi: ath12k: Pass the correct value of each TID during a stop AMPDU session

Yasuaki Torimaru (1):
      wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation

 drivers/net/wireless/ath/ath11k/dp_rx.c            |  15 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |  10 ++
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     | 101 ++++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  19 ++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   5 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |  30 +++++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   3 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   2 +-
 drivers/net/wireless/ti/wl1251/tx.c                |   8 +-
 drivers/net/wireless/virtual/virt_wifi.c           |   1 -
 16 files changed, 163 insertions(+), 56 deletions(-)

