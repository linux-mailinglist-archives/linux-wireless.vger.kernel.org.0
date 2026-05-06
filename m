Return-Path: <linux-wireless+bounces-36005-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJq2NwAi+2lvWwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36005-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 13:12:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C32F4D99F5
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 13:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 873F13007504
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 11:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816C3F23C1;
	Wed,  6 May 2026 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RHB6GYfb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF2261B8A;
	Wed,  6 May 2026 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065918; cv=none; b=JZmynwBNXqPbS9a4+7W1+7hE7CZRa+FuduRcnUza7YcRpy9xu6Qruzvpr1TdAHb0B60SI8vwTaUO9/rvclPXfRWq841AR41KjrH26Kaf24Vs0uCubahC1eeYVf6Wmr2UJxl36H+czgPwftgoVVdNbRfnuFbNaJryS6FGe/DhDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065918; c=relaxed/simple;
	bh=5SbMrUO1/BH186Ltdhzmss0ewABnG6zEQjPAfqD3jZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTjvud152iFJFHxnh0GDdmDdCOX9jZQIvsg74GkrkWZJe8ud7ElScpVAsTVlh3v0bBzw6Atnz79qjNC7Gix9DRsWHmHsJPs8cop5bo/b/PHfSnbzVigi6QTxe3ybIxerO7pmqe4Z8ptAnnBgRdOQ8s8TvL7mFXhQDhA69QKkVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RHB6GYfb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=qAU32mP6xDFhYq+ntPKcXAMPvmKgxIkZege7PIzIp7M=; t=1778065916; x=1779275516; 
	b=RHB6GYfb+GhUBAug5dCsoB/NiLi8rJPWKrrd3FlVBYQm8oHcSX0VQBJOj/6AXIDtE7HfdRFIaLR
	SVELyQf3Gu7xmE/JGw4OExidnzR4XkDstNYqSTWymhmQOrG8SsuuzcWpSxEPt1jf/VL4vj47/SZoo
	U0MfMFjJNpYTeQmIpv/1yq6TkFWgkOZO75fTRc/dxBnCCBtvC7zG1q1abZx1fpt9KIa04+01tIgzF
	U8zrs0n+0+jmicxLJgF6dSJgKmh6wOBrlEk2UtpuC1uY8IAxuyO1B9ZEygP5Fx1sPhu/D9slbH3rb
	0eiK15dNIuEKBVXuQKrvrUkoLWwBB6fEs5Ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKaAU-00000000zTw-1c18;
	Wed, 06 May 2026 13:11:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-05-06
Date: Wed,  6 May 2026 13:10:53 +0200
Message-ID: <20260506111147.224296-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C32F4D99F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-36005-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi,

More content for next, as below. I'm sending this now
in hopes that we'll get net merged into net-next after
it all lands, because I'm annoyed by the use-after-free
issue that somehow we never noticed and now hits all
the time.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 6855a52318b3a8c33031209e38bef497c971ef17:

  Merge tag 'wireless-next-2026-04-30' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-04-30 17:10:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-05-06

for you to fetch changes up to 89e367a90c1a877ca9c5d75d3848582d80fd0e60:

  wifi: mac80211: explicitly disable FTM responder on AP stop (2026-05-06 11:52:14 +0200)

----------------------------------------------------------------
Lots of new content in cfg80211/mac80211, notably
 - more NAN work, mostly complete now (also hwsim)
 - more UHR work (e.g. non-primary channel access),
   this will continue for a while
 - FTM ranging APIs

----------------------------------------------------------------
Andrei Otcheretianski (1):
      wifi: mac80211: Fix a kernel panic in ieee80211_encrypt_tx_skb()

Avraham Stern (1):
      wifi: mac80211: accept protected frames for NAN device

Benjamin Berg (13):
      wifi: mac80211_hwsim: remove unused nan_vif struct member
      wifi: mac80211_hwsim: move NAN related variables into a struct
      wifi: mac80211_hwsim: split NAN handling into separate file
      wifi: mac80211_hwsim: rename and switch simulation time to boottime
      wifi: mac80211_hwsim: move timestamp writing later in the datapath
      wifi: mac80211_hwsim: register beacon timer by calculating TBTT
      wifi: mac80211_hwsim: refactor NAN timer handling
      wifi: mac80211_hwsim: switch to use TXQs
      wifi: mac80211_hwsim: limit TX of frames to the NAN DW
      wifi: mac80211_hwsim: select NAN TX channel based on current TSF
      wifi: mac80211_hwsim: only RX on NAN when active on a slot
      wifi: mac80211_hwsim: protect tsf_offset using a spinlock
      wifi: mac80211_hwsim: implement NAN synchronization

Daniel Gabay (7):
      wifi: mac80211_hwsim: add NAN_DATA interface limits
      wifi: mac80211_hwsim: add NAN PHY capabilities
      wifi: mac80211_hwsim: implement NAN schedule callbacks
      wifi: mac80211_hwsim: set HAS_RATE_CONTROL when using NAN
      wifi: mac80211_hwsim: add NAN data path TX/RX support
      wifi: mac80211_hwsim: Declare support for secure NAN
      wifi: mac80211_hwsim: enable NAN_DATA interface simulation support

Emmanuel Grumbach (1):
      wifi: iwlwifi: don't blindly start the responder upon BSS_CHANGED_FTM_RESPONDER

Ilan Peer (4):
      wifi: mac80211: allow userspace TX/RX over NAN Data interfaces
      wifi: mac80211: Allow setting MAC address on interface creation
      wifi: mac80211_hwsim: Do not declare support for NDPE
      wifi: mac80211_hwsim: Support Tx of multicast data on NAN

Israel Kozitz (1):
      wifi: cfg80211: fix max_channel_switch_time documentation unit

Johannes Berg (23):
      wifi: mac80211: move frame RX handling to type files
      wifi: mac80211: update UHR capabilities field order
      wifi: ieee80211: define UHR ML-PM extended MLD capability
      wifi: mac80211: track AP's extended MLD capa/ops
      wifi: cfg80211: ensure UHR ML-PM flag is consistent
      wifi: cfg80211: allow devices to advertise extended MLD capa/ops
      wifi: mac80211: mlme: advertise driver's extended MLD capa/ops
      wifi: mac80211: use struct for ieee80211_determine_ap_chan() args
      wifi: mac80211: move ieee80211_chandef_usable() up
      wifi: mac80211: carry element parsing frame type/from_ap
      wifi: cfg80211: allow representing NPCA in chandef
      wifi: cfg80211: add helper for parsing NPCA to chandef
      wifi: mac80211: use NPCA in chandef for validation
      wifi: mac80211: remove NPCA during chandef downgrade
      wifi: mac80211: add NPCA to chandef tracing
      wifi: mac80211: allow only AP chanctx sharing with NPCA
      wifi: mac80211: mlme: use NPCA chandef if capable
      wifi: mac80211: set AP NPCA parameters in bss_conf
      wifi: cfg80211: separate NPCA validity from chandef validity
      wifi: mac80211: don't parse full UHR operation from beacons
      wifi: mac80211: check AP using NPCA has NPCA capability
      wifi: mac80211_hwsim: claim HT STBC capability
      wifi: mac80211: explicitly disable FTM responder on AP stop

Kavita Kavita (3):
      wifi: cfg80211: indicate (Re)Association frame encryption to userspace
      wifi: mac80211: set assoc_encrypted for EPP associations
      wifi: mac80211_hwsim: Add support for extended FTM ranging

Miri Korenblit (4):
      wifi: mac80211: track the id of the NAN cluster we joined
      wifi: mac80211: avoid out-of-bounds access in monitor
      wifi: mac80211: add NAN channel evacuation support
      wifi: cfg80211: don't allow NAN DATA on multi radio devices

Peddolla Harshavardhan Reddy (12):
      wifi: cfg80211: restrict LMR feedback check to TB and non-TB ranging
      wifi: cfg80211: Add MAC address filter to remain_on_channel
      wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR operations
      wifi: cfg80211: add start/stop proximity detection commands
      wifi: cfg80211: add proximity detection capabilities to PMSR
      wifi: cfg80211: add NTB continuous ranging and FTM request type support
      wifi: cfg80211: extend PMSR FTM response for proximity ranging
      wifi: cfg80211: add role-based peer limits to FTM capabilities
      wifi: cfg80211: add ingress/egress distance thresholds for FTM
      wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
      wifi: cfg80211: allow suppressing FTM result reporting for PD requests
      wifi: cfg80211: add LTF keyseed support for secure ranging

 MAINTAINERS                                        |    2 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    3 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |    4 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    4 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    3 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    3 +-
 drivers/net/wireless/virtual/Makefile              |    2 +
 drivers/net/wireless/virtual/mac80211_hwsim_i.h    |  168 +++
 .../{mac80211_hwsim.c => mac80211_hwsim_main.c}    |  974 +++++++-------
 drivers/net/wireless/virtual/mac80211_hwsim_nan.c  | 1346 ++++++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim_nan.h  |  102 ++
 include/linux/ieee80211-eht.h                      |   14 +-
 include/linux/ieee80211-uhr.h                      |   55 +-
 include/linux/ieee80211.h                          |    1 +
 include/net/cfg80211.h                             |  251 +++-
 include/net/mac80211.h                             |   64 +
 include/uapi/linux/nl80211.h                       |  293 ++++-
 net/mac80211/Makefile                              |    2 +-
 net/mac80211/ap.c                                  |  207 +++
 net/mac80211/cfg.c                                 |   77 +-
 net/mac80211/chan.c                                |  102 +-
 net/mac80211/eht.c                                 |  174 ---
 net/mac80211/ieee80211_i.h                         |   28 +-
 net/mac80211/iface.c                               |   62 +-
 net/mac80211/main.c                                |    7 +-
 net/mac80211/mlme.c                                |  579 +++++----
 net/mac80211/nan.c                                 |  126 ++
 net/mac80211/offchannel.c                          |   13 +-
 net/mac80211/parse.c                               |    3 +
 net/mac80211/rx.c                                  |   33 +-
 net/mac80211/status.c                              |    9 +-
 net/mac80211/trace.h                               |   14 +-
 net/mac80211/tx.c                                  |   18 +-
 net/mac80211/uhr.c                                 |    5 +-
 net/mac80211/util.c                                |   11 +-
 net/wireless/chan.c                                |  124 +-
 net/wireless/core.c                                |   36 +-
 net/wireless/core.h                                |    2 +
 net/wireless/mlme.c                                |   11 +-
 net/wireless/nl80211.c                             |  368 +++++-
 net/wireless/nl80211.h                             |    5 +-
 net/wireless/pmsr.c                                |  190 ++-
 net/wireless/rdev-ops.h                            |   26 +-
 net/wireless/reg.c                                 |    3 +
 net/wireless/sme.c                                 |    1 +
 net/wireless/trace.h                               |   38 +-
 net/wireless/util.c                                |   19 +-
 50 files changed, 4520 insertions(+), 1072 deletions(-)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_i.h
 rename drivers/net/wireless/virtual/{mac80211_hwsim.c => mac80211_hwsim_main.c} (91%)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.c
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.h
 create mode 100644 net/mac80211/ap.c

