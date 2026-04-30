Return-Path: <linux-wireless+bounces-35707-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMYyEFY882n7ygEAu9opvQ
	(envelope-from <linux-wireless+bounces-35707-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 13:26:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CB14A2141
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 13:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A70B30EF849
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED4401A32;
	Thu, 30 Apr 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OZ3ccfxo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D653D7D6F;
	Thu, 30 Apr 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547919; cv=none; b=UI3U4CWeOmk/yKS3Zyh+sAx8WI6FmAVl0LqeG9SS2ZSiouWiuowySHdt4bId+iHn/CeObhNcCwFUXxXL1GegPhUzEbTYpquGf6OVhgdVj49kmk8WldtLgXV0C/NvQdI4WnEdWBYND1c+PX3R0j+pjRLLBrY0y0JNzDPbhthckyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547919; c=relaxed/simple;
	bh=p9NL97L6xmc9S0MTy8CwV7RV9FdFFQdDFxbjuyettUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZo97Ek7qbxYmjlZ3frBn6CKj2gBYb/hUQmhEMoG4mZSAEsvXHhT/mrLsXh4Bc0MllHlDsnTCjJoa9bgahwKENFpuxBW7d4ZYjZalFZkl178lbP8WL0Ge+KpQKECEqkwZ2PMICmH2rJx6JjpuKZkMp4imEzkUp10nUVk2QkbvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OZ3ccfxo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=UbRaRtq2a7pZA3RreHbHdtDjYoq4z3G/zxcyONkxg8Q=; t=1777547917; x=1778757517; 
	b=OZ3ccfxo9tOy1IatM7yBw11ZtdP5HoCgi/JmU7O3Jivy/Jhu7t5uM3olGRjIqmXnxvTYdIJXccX
	pEshgRITD7Yp9Ff3f7giBev06OjE/mR5c/aSBMQ9hbYI7ZoFIcInLhAkDTcoKZuGniZm8Kmc2FqCf
	/USfgl8Wp3ZuLKfZwKtgOjhYPP4lNRWdsef7z0XKROz6Y/NCoa0TzZ1WiHrq+dZLuAs8uA+3RHxmx
	I3JEo8hLE2tP6fYyXYNbNKe8UYmc4d12KxOcDhbF4vBbnCESxK2PdIUun9hdNPztxiMvUfUX7/O+O
	nzWAa9dct1rCXgzRjGjpluCYmXUC9X+qROSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wIPPe-00000004zeX-1Zk2;
	Thu, 30 Apr 2026 13:18:34 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-04-30
Date: Thu, 30 Apr 2026 13:17:52 +0200
Message-ID: <20260430111831.219242-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3CB14A2141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-35707-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

Hi,

So the LLM floodgates are starting to open ;-) But I'm somewhat
happy that so far we haven't gotten any really critical reports.
Here's a couple of first fixes though.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-04-30

for you to fetch changes up to d997c32157d2ca06e9f3f00ba6c4bf06593b49e7:

  Merge tag 'ath-current-20260427' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2026-04-28 10:41:51 +0200)

----------------------------------------------------------------
Couple of initial fixes:
 - mac80211
   - remove HT NSS validation to work with broken APs
   - remove 'static' that could cause races
   - check station link lookup before further processing
 - ath12k
   - fix OF node refcount imbalance
   - fix queue flush ("REO update") in MLO
   - fix RCU assert
 - ath12k: fix Kconfig with POWER_SEQUENCING
 - rsi: fix thread lifetime race
 - brcmfmac: fix potential UAF
 - nl80211: require admin permissions for PMK management
 - various fixes to not trust values from firmware

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: fix OF node refcount imbalance in WSI graph traversal

Amir Mohammad Jahangirzad (1):
      wifi: libertas: fix integer underflow in process_cmdrequest()

Baochen Qiang (1):
      wifi: ath12k: prepare REO update element only for primary link

Catherine (1):
      wifi: mac80211: drop stray 'static' from fast-RX rx_result

Dmitry Baryshkov (1):
      wifi: ath10k: snoc: select POWER_SEQUENCING

Jeongjun Park (1):
      wifi: rsi: fix kthread lifetime race between self-exit and external-stop

Johannes Berg (1):
      Merge tag 'ath-current-20260427' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task

Michael Bommarito (2):
      wifi: nl80211: require admin perm on SET_PMK / DEL_PMK
      wifi: mac80211: check ieee80211_rx_data_set_link return in pubsta MLO path

Rio Liu (1):
      wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode

Tristan Madani (2):
      wifi: b43: enforce bounds check on firmware key index in b43_rx()
      wifi: b43legacy: enforce bounds check on firmware key index in RX path

Yu-Hsiang Tseng (1):
      wifi: ath12k: use lockdep_assert_in_rcu_read_lock() for RCU assertions

 drivers/net/wireless/ath/ath10k/Kconfig            |  1 +
 drivers/net/wireless/ath/ath12k/core.c             | 77 ++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  3 +
 drivers/net/wireless/ath/ath12k/mac.c              |  2 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |  2 +-
 drivers/net/wireless/broadcom/b43/xmit.c           |  3 +-
 drivers/net/wireless/broadcom/b43legacy/xmit.c     |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |  6 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |  5 +-
 drivers/net/wireless/rsi/rsi_common.h              |  5 +-
 net/mac80211/mlme.c                                |  9 +++
 net/mac80211/rx.c                                  |  6 +-
 net/wireless/nl80211.c                             |  2 +
 13 files changed, 82 insertions(+), 42 deletions(-)

