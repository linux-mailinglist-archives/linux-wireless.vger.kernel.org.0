Return-Path: <linux-wireless+bounces-32461-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNnuFowaqGmgnwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32461-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:42:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30321FF2D2
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7005E30D7321
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1F63537CE;
	Wed,  4 Mar 2026 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oyeJI9hm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9713451AE;
	Wed,  4 Mar 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624240; cv=none; b=gftEJtcqWeREmwAQosqSYKUzIRDmnUzbm7frGhS3w1vNa5qFxuc67lcRmoCECwE0exxs9qMa2sYLp6EgubDP+XfJNGmA8W6mUrosSemu4MBeHpJ9pgx1S+VO4tK1PrSMAFBmbvY1DHBXMwWH6klp2KeILcBt8XFQU4pYh9Dz2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624240; c=relaxed/simple;
	bh=Krpcv6miF8gl45b3Vt4q/ZHfpOUkaU9bo3Hrs9wxfzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdBWkC75r1kJIpjsKOgajXEP5BHbZywWFaAOiVjyjscifkt4QSOX/yNH6GuWpwRfCYv64Zbf3v/3UGyTXIJovkdkNe9Gz19jnf5L28KfTeUanG1NpRSg4pDEdaxiIH0gna1nKNUJ1Gs0R4sbGckcma91pZnjB2zBnbU82dX1SOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oyeJI9hm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ETFf/AhR8CekDATOBPSh3wpOHM70Haryt2WxR+arK5o=; t=1772624239; x=1773833839; 
	b=oyeJI9hmmMcqUAbjUHCqvTJj/Exe0S6d1pI64yHN/BoK3lnhjGpbQ0Lbrg2Osm5/GliHP42ojT/
	fz/THhtP556AizROwV5Z2Ol3VfXcsZ2lSAJoIN4UzNNd9zRCAJ6AkKZhJdagZA9qOl6iXqR7amYro
	J1DFBSM6gE2wdKnn/kejvPbn8Nu/1myLoTOGj2JS452agXcD0Zo0kTjCqaKub/6EsfW4oUux2q6bu
	y4kBVnxp5DQQGqBrpRAPKZxM9D3Hgp1fWMSpzJjBWYzSBg/zUtCSynFmnLMCPkN3ZgAZbQlxyPyBF
	KtIY/f+iQHMpuWhmoPbnn8zTlQX8k+MEhqsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxkXV-0000000834E-0vg4;
	Wed, 04 Mar 2026 12:37:17 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-03-04
Date: Wed,  4 Mar 2026 12:34:23 +0100
Message-ID: <20260304113707.175181-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B30321FF2D2
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32461-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

And here's the -next side, since I'll need it all merged up to
net-next as well to get the combination together to avoid the
conflicts I mentioned.

But this time we actually also have a real new feature, notably
support for EPPKE, association frame encryption and  802.1X over
auth frames, from the upcoming 802.11bi amendment. When that'll
be supported on both sides, association request/response will be
encrypted for better privacy and hopefully faster connections
(no more 4-way handshake.) Driver support will need to follow
though.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 0314e382cf02983eb3c33ac537ad9701e7858bc9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-26 10:23:00 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-03-04

for you to fetch changes up to 44d93cf1abb6a85d65c3b4b027c82d44263de6a5:

  wifi: UHR: define DPS/DBE/P-EDCA elements and fix size parsing (2026-03-04 11:50:03 +0100)

----------------------------------------------------------------
Notable features this time:
 - cfg80211/mac80211
   - finished assoc frame encryption/EPPKE/802.1X-over-auth
     (also hwsim)
   - radar detection improvements
   - 6 GHz incumbent signal detection APIs
   - multi-link support for FILS, probe response
     templates and client probling
 - ath12k:
   - monitor mode support on IPQ5332
   - basic hwmon temperature reporting

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: Enable monitor mode support on IPQ5332

Alejandro Colomar (1):
      wifi: ath9k: Fix typo

Avraham Stern (1):
      wifi: cfg80211: support key installation on non-netdev wdevs

Baochen Qiang (1):
      wifi: ath12k: fix indentation in ath12k_qmi_aux_uc_load()

Bjorn Andersson (1):
      wifi: ath11k: Silence remoteproc probe deferral prints

Daniel Hodges (1):
      wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()

Gustavo A. R. Silva (1):
      wifi: iwlegacy: Avoid multiple -Wflex-array-member-not-at-end warnings

Hari Chandrakanthan (1):
      wifi: cfg80211: add support to handle incumbent signal detected event from mac80211/driver

Janusz Dziedzic (4):
      wifi: cfg80211: fix background CAC
      wifi: cfg80211: set and report chandef CAC ongoing
      wifi: cfg80211: events, report background radar
      wifi: mac80211_hwsim: background CAC support

Johannes Berg (2):
      wifi: mac80211: give the AP more time for EPPKE as well
      Merge tag 'ath-next-20260303' of https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Jori Koolstra (1):
      wifi: mac80211_hwsim: change hwsim_class to a const struct

Karthikeyan Kathirvel (1):
      wifi: UHR: define DPS/DBE/P-EDCA elements and fix size parsing

Karthikeyan Periyasamy (1):
      wifi: ath12k: Remove the unused argument from the Rx data path

Kavita Kavita (5):
      wifi: mac80211_hwsim: Advertise support for (Re)Association frame encryption
      wifi: mac80211: Advertise EPPKE support based on driver capabilities
      wifi: cfg80211: add support for IEEE 802.1X Authentication Protocol
      wifi: mac80211: Add support for IEEE 802.1X authentication protocol in non-AP STA mode
      wifi: mac80211: Advertise IEEE 802.1X authentication support

Kexin Sun (1):
      wifi: mac80211: update outdated comment

Maharaja Kennadyrajan (1):
      wifi: ath12k: add basic hwmon temperature reporting

Miri Korenblit (6):
      wifi: nl80211: refactor nl80211_parse_chandef
      wifi: cfg80211: remove unneeded call to cfg80211_leave
      wifi: nl80211/cfg80211: support stations of non-netdev interfaces
      wifi: cfg80211: refactor wiphy_suspend
      wifi: nl80211: don't allow DFS channels for NAN
      wifi: cfg80211: make cluster id an array

Ramya Gnanasekar (1):
      wifi: ath12k: Set up MLO after SSR

Rosen Penev (1):
      wifi: rt2x00: use generic nvmem_cell_get

Sai Pratyusha Magam (1):
      wifi: mac80211: Fix AAD/Nonce computation for management frames with MLO

Sriram R (2):
      wifi: mac80211: fetch FILS discovery template by link ID
      wifi: mac80211: fetch unsolicited probe response template by link ID

Suraj P Kizhakkethil (2):
      wifi: mac80211: set band information only for non-MLD when probing stations using NULL frame
      wifi: mac80211: Set link ID for NULL packets sent to probe stations

Zilin Guan (2):
      wifi: ath11k: fix memory leaks in beacon template setup
      wifi: mwifiex: Fix memory leak in mwifiex_11n_aggregate_pkt()

 drivers/net/wireless/ath/ath11k/ahb.c              |  10 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  32 ++-
 drivers/net/wireless/ath/ath12k/Makefile           |   1 +
 drivers/net/wireless/ath/ath12k/core.c             |  23 +-
 drivers/net/wireless/ath/ath12k/core.h             |   3 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   2 -
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   2 -
 drivers/net/wireless/ath/ath12k/mac.c              |  10 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   2 +-
 drivers/net/wireless/ath/ath12k/thermal.c          | 124 +++++++++
 drivers/net/wireless/ath/ath12k/thermal.h          |  40 +++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |  25 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |   4 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  57 ++---
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |  25 +-
 drivers/net/wireless/ath/ath6kl/main.c             |   4 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |  33 ++-
 drivers/net/wireless/ath/wil6210/main.c            |   3 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |   5 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  41 +--
 drivers/net/wireless/intel/iwlegacy/3945.h         |   4 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |   2 +-
 drivers/net/wireless/intel/iwlegacy/commands.h     |   9 +-
 drivers/net/wireless/intel/iwlegacy/common.h       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c       |   5 +-
 drivers/net/wireless/marvell/libertas/cfg.c        |   8 +-
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c    |   1 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  36 +--
 drivers/net/wireless/marvell/mwifiex/init.c        |   2 +-
 drivers/net/wireless/marvell/mwifiex/uap_event.c   |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   6 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  44 ++--
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |  38 +--
 drivers/net/wireless/quantenna/qtnfmac/event.c     |   6 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   4 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      | 141 ++++++++++-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |   2 +
 drivers/net/wireless/virtual/virt_wifi.c           |  12 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  33 +--
 include/linux/ieee80211-uhr.h                      | 271 +++++++++++++++++++-
 include/linux/ieee80211.h                          |   2 +
 include/net/cfg80211.h                             |  63 +++--
 include/net/mac80211.h                             |  15 +-
 include/uapi/linux/nl80211.h                       |  34 +++
 net/mac80211/cfg.c                                 |  99 +++++---
 net/mac80211/ieee80211_i.h                         |   2 +
 net/mac80211/main.c                                |  10 +
 net/mac80211/mlme.c                                |  81 +++++-
 net/mac80211/rx.c                                  |   5 +
 net/mac80211/sta_info.c                            |   4 +-
 net/mac80211/tx.c                                  |  77 ++++--
 net/mac80211/wpa.c                                 |  55 +++-
 net/wireless/chan.c                                |  29 ++-
 net/wireless/core.c                                |   1 -
 net/wireless/core.h                                |   4 +
 net/wireless/ibss.c                                |   4 +-
 net/wireless/mlme.c                                |  51 ++--
 net/wireless/nl80211.c                             | 279 ++++++++++++++-------
 net/wireless/nl80211.h                             |   5 +-
 net/wireless/pmsr.c                                |   5 +-
 net/wireless/rdev-ops.h                            |  62 ++---
 net/wireless/sme.c                                 |   4 +-
 net/wireless/sysfs.c                               |  33 +--
 net/wireless/trace.h                               | 185 +++++++++-----
 net/wireless/util.c                                |   4 +-
 net/wireless/wext-compat.c                         |  12 +-
 68 files changed, 1628 insertions(+), 584 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.h

