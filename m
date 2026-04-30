Return-Path: <linux-wireless+bounces-35708-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F7uCg9F82kMzAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35708-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 14:03:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C914A287F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28891300F13C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9423FA5EB;
	Thu, 30 Apr 2026 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u9L8uAZ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FB34D4FE;
	Thu, 30 Apr 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550596; cv=none; b=m4PS4Ph5uR+9EiZczPs2MavchyR0y1SVMQLwyyBOSi3UGWFWXKVww5w24S9kMTRCjO6GfGd+P53ZNDNU0R9tPH2s1be+EwHmubg5OS3MMf+8OvKTYX1qnFzQqHc7KsAxp7706mViDmk46Iysv8mU7sT8rsJcscn4gmabYRo4g5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550596; c=relaxed/simple;
	bh=oqH/TzhTT03Of6M4qkf7c0ltPQFrF6NXGN0yOYx2zGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTj6r9Qs2Oyy3a9ygOFxSf/a2zdbeVgvRQmCuPfer+IBH/W7WWSGJRukMBzBye40X6MP4WTve20m7g4aySWWjy3cS8Xupl2/MQpUuESvnDJfmDztzAstPKRM5u66yVzUk0//7m0CqGWxvAaUgB3Xmtv7CjM3xzrqAfpPrQEnwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u9L8uAZ+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=t+DvBOGzPWBuWr/pBIp/1hzWZV+hVGJabWeUs2exuzo=; t=1777550594; x=1778760194; 
	b=u9L8uAZ+q648z354hBjcmwiLOo1oBbpav/5c7FbUjw+xCi2dVQXI8i/l2/A6FJf7bbrpb5x+bg9
	SwdlpQpngnSMRoFWYdU82yAzQvnAHdvvD9Ltj4Ns3kEmDVMUE8csmbZMnjQsFMTi1aLHZKCR0x+Gu
	0SuNEB+ijgb0g38o8BQAhShr/Y2lQr2cYckheghIDx1+7BPVzwEvHwkIkIeSwSCkKEgwYBCKMC2Ha
	8bCy6PSjdn+TQR5lH5JoG8V+84qWASNN35QhrHd3IRe+GaQ1hcvI/VMy3tyffBgIgal6uXV8nCf5d
	m0YZ9BRAqejwvlafPoB7BmvE0aWmF85/T0Vw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wIQ6m-000000053Vp-1L5f;
	Thu, 30 Apr 2026 14:03:08 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-04-30
Date: Thu, 30 Apr 2026 14:02:12 +0200
Message-ID: <20260430120304.249081-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4C914A287F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35708-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi,

Looks like 7.2 is going to be interesting with NAN and UHR
both getting major work, but for now we have some (relatively)
minor things - the biggest is the station bandwidth rework,
which is needed en route to UHR.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-04-30

for you to fetch changes up to 7baf5857e15d722776898510a10546d6b2f18645:

  wifi: brcmsmac: phy_lcn: Remove dead code in wlc_lcnphy_radio_2064_channel_tune_4313() (2026-04-28 10:43:27 +0200)

----------------------------------------------------------------
Some new content already, notably:
 - mac80211: major rework of station bandwidth handling,
             fixing issues with lower capability than AP
 - general: cleanups for EMLSR spec issues (drafts differed)
 - ath9k: GPIO interface improvements
 - ath12k: replace dynamic memory allocation in WMI RX path

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: Fix invalid IRQ requests during AHB probe

Chelsy Ratnawat (1):
      wifi: brcmsmac: phy_lcn: Remove dead code in wlc_lcnphy_radio_2064_channel_tune_4313()

Daniel Gabay (1):
      wifi: cfg80211: validate cipher suite for NAN Data keys

Dmitry Antipov (1):
      wifi: mac80211: use kstrtobool_from_user() in debugfs callbacks

Jeff Johnson (3):
      wifi: ath12k: Fix HTC prototype ath12k_base parameters
      wifi: ath12k: Fix ath12k_dp_htt_tlv_iter()'s iter() signature
      wifi: ath12k: Remove macro HAL_RX_EHT_SIG_OFDMA_EB2_MCS

Johannes Berg (24):
      wifi: mac80211: remove NAN guards on ieee80211_sta_cur_vht_bw() calls
      wifi: mac80211: set cur_max_bandwidth to maximum
      wifi: mac80211: use max BW for HT channel width update
      wifi: mac80211: use chandef in ieee80211_get_sta_bw()
      wifi: mac80211: use chandef in TDLS chanctx handling
      wifi: mac80211: remove ieee80211_sta_cap_chan_bw()
      wifi: nl80211: document channel opmode change channel width
      wifi: mac80211: simplify ieee80211_sta_rx_bw_to_chan_width()
      wifi: mac80211: clean up STA NSS handling
      wifi: mac80211: clean up initial STA NSS/bandwidth handling
      wifi: mac80211: clean up ieee80211_sta_cap_rx_bw()
      wifi: mac80211: remove ieee80211_sta_cur_vht_bw()
      wifi: cfg80211: remove HE/SAE H2E required fields
      wifi: nl80211: reject beacons with bad HE operation
      wifi: cfg80211: move AP HT/VHT/... operation to beacon info
      wifi: nl80211: reject too short HT/VHT/HE/EHT capability/operation
      wifi: cfg80211: provide HT/VHT operation for AP beacon
      wifi: nl80211: always validate AP operation/PHY regulatory
      wifi: mac80211: clarify per-STA bandwidth handling
      wifi: mac80211: fix per-station PHY capability bandwidth
      wifi: mac80211: clarify an 802.11 VHT spec reference
      wifi: nl80211: check link is beaconing for color change
      wifi: mac80211: always allow transmitting null-data on TXQs
      Merge tag 'ath-next-20260427' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Linus Walleij (1):
      wifi: ath9k: Obtain system GPIOS from descriptors

Louis Kotze (1):
      wifi: cfg80211: fix grammar in MLO group key error message

Nicolas Escande (1):
      wifi: ath12k: avoid dynamic alloc when parsing wmi tb

Pablo Martin-Gomez (4):
      wifi: Remove invalid 128TU transition timeout constant
      wifi: Remove EMLMR Delay subfield definitions
      wifi: Rename EMLSR delay constants and add EMLMR helpers and definitions
      wifi: Update EML function documentation to remove EMLSR-specific references

Ping-Ke Shih (1):
      wifi: mac80211: add __packed to union members of struct ieee80211_rx_status

Yuqi Xu (1):
      wifi: cfg80211: reject duplicate wiphy cipher suite entries

 drivers/gpio/gpio-ath79.c                          |  57 +++-
 drivers/net/wireless/ath/ath12k/ahb.c              |  25 +-
 drivers/net/wireless/ath/ath12k/core.c             |   6 +
 drivers/net/wireless/ath/ath12k/dp_htt.c           |   2 +-
 drivers/net/wireless/ath/ath12k/dp_htt.h           |   2 +-
 drivers/net/wireless/ath/ath12k/htc.h              |   8 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     |   1 -
 drivers/net/wireless/ath/ath12k/wmi.c              | 217 +++++--------
 drivers/net/wireless/ath/ath12k/wmi.h              |   3 +
 drivers/net/wireless/ath/ath9k/hw.c                |  33 +-
 drivers/net/wireless/ath/ath9k/hw.h                |   3 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |  13 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   4 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c  |   4 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |   2 +-
 include/linux/ieee80211-eht.h                      | 115 +++++--
 include/net/cfg80211.h                             |  25 +-
 include/net/mac80211.h                             |  10 +-
 include/uapi/linux/nl80211.h                       |  10 +-
 net/mac80211/cfg.c                                 | 136 +++++++-
 net/mac80211/chan.c                                |  66 ++--
 net/mac80211/debugfs.c                             |  47 +--
 net/mac80211/eht.c                                 |  11 +-
 net/mac80211/he.c                                  |   9 +-
 net/mac80211/ht.c                                  |  59 +---
 net/mac80211/ibss.c                                |   3 +
 net/mac80211/ieee80211_i.h                         |  28 +-
 net/mac80211/mesh_plink.c                          |   3 +
 net/mac80211/mlme.c                                |  25 +-
 net/mac80211/ocb.c                                 |   5 +-
 net/mac80211/rate.c                                |   4 +-
 net/mac80211/sta_info.c                            | 294 ++++++++++++++++-
 net/mac80211/sta_info.h                            |  16 +-
 net/mac80211/tdls.c                                |  24 +-
 net/mac80211/tx.c                                  |   2 +-
 net/mac80211/util.c                                |  23 +-
 net/mac80211/vht.c                                 | 350 +--------------------
 net/wireless/core.c                                |  21 ++
 net/wireless/core.h                                |   3 +-
 net/wireless/nl80211.c                             | 260 +++++++++------
 net/wireless/util.c                                |  10 +
 net/wireless/wext-compat.c                         |   3 +-
 45 files changed, 1097 insertions(+), 859 deletions(-)

