Return-Path: <linux-wireless+bounces-38822-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NEU/GLKLT2qVjQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38822-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 13:53:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC754730B07
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 13:53:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=ZdkiDX7q;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38822-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38822-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45800302012E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF053A6B81;
	Thu,  9 Jul 2026 11:50:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2E3F44CB;
	Thu,  9 Jul 2026 11:50:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597845; cv=none; b=fMZ40c3psyHCQ73vBlo6onn4eXxxHyJUY0M5FB9rMEdiYP3PzNu1IgITH3fcUIDyezn/Cp1YY7TRfw0KnfHpr0A2Q1HiiE5fJ6p2yKj0w5/opSt+Kq7aSQbPDHxzqxvbS2rBr9lCJscOYUVUHXImb/W0Be5VkUk+DlsViwYkDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597845; c=relaxed/simple;
	bh=Scy4+rg0vTIxg3wclvZ0S92t2IkxBSw1KAgIWFTDo+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iiMqxxKpZ1oKBsy6f1QK+3RAMeRlMivrQWwpZVY/9qu+GM5ln8eRn70zTR/3u2sWev65RZPqQRZxvbL549iDsmWTVJNdQ30RS59LgPa+uw/ct6VGAo3qjZJouRbc1+ebi2bH5ager8YBQwD9nlfpD/+GM4ACJs/vxEBFIoql3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZdkiDX7q; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=1j6EbskDt+ptlASb+nlO0QX7KVjd5G3o+MA0oNSOxlk=; t=1783597844; x=1784807444; 
	b=ZdkiDX7qSSC7w1faIIO8G/HXrS9oJZ8iVk73HcVijcP/ozQZD9dTOysMzsTKw1JNBUZjUs/t3rP
	lYkJucKxA9cL8vlVT2CLUepOmv9FMPpHcdTphUwxF64GPS1afQp8K0TrsfC6aHPbh1oBK+soYCqjW
	1kE4o16IgAixIpwfpV8d17W2/rGB4hcch6xbaqeX+37zoU/JymaZXzD2waPclna6mSTyHpiQXQn14
	Bz5nSQBs5cQ/YaEJHvTH14K9u7Ub3W7US9bCM9Z8og4OnULCdMxd2vsYcWc4MCy2yf20jb97jJ1jL
	3XqBJh8G1qxGwi4CO0S916ZYVz/PJe83+jRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1whnH7-00000008YpN-0AuP;
	Thu, 09 Jul 2026 13:50:41 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-07-09
Date: Thu,  9 Jul 2026 13:49:05 +0200
Message-ID: <20260709115038.243870-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-38822-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC754730B07

Hi,

Sorry, I meant to send this yesterday, hoping it'd get
in/out before netdevconf and all that, because it's
actually really big. Mostly I've now collected many
random LLM-induced robustness fixes (I can't really
call most of them security fixes, though there likely
are a few).

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 87320be9f0d24fce67631b7eef919f0b79c3e45c:

  Merge tag 'net-7.2-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-02 06:01:12 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-07-09

for you to fetch changes up to cb8afea4655ff004fa7feee825d5c79783525383:

  wifi: cfg80211: bound element ID read when checking non-inheritance (2026-07-07 14:00:35 +0200)

----------------------------------------------------------------
Too many robustness fixes to list. Mostly for
 - slight out-of-bounds reads of SKBs,
 - leaks on error conditions, and
 - malformed netlink input rejection.

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()

Arnd Bergmann (1):
      wifi: mac80211: allocate backup ieee80211_nan_sched_cfg off stack

Bryam Vargas (1):
      wifi: mac80211_hwsim: clamp virtio RX length before skb_put

Cen Zhang (3):
      wifi: cfg80211: cancel sched scan results work on unregister
      wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ lock
      wifi: cfg80211: use wiphy work for socket owner autodisconnect

Christophe JAILLET (1):
      wifi: cfg80211: Fix an error handling path in cfg80211_wext_siwscan()

Corentin Labbe (1):
      wifi: ralink: RT2X00: init EEPROM properly

Dawei Feng (2):
      wifi: libertas: fix memory leak in helper_firmware_cb()
      wifi: mac80211: fix memory leak in ieee80211_register_hw()

HE WEI (ギカク) (1):
      wifi: cfg80211: bound element ID read when checking non-inheritance

Haofeng Li (1):
      wifi: cfg80211: validate EHT MLE before MLD ID read

Maoyi Xie (3):
      wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
      wifi: mac80211: defer link RX stats percpu free to RCU
      wifi: brcmfmac: cyw: fix heap overflow on a short auth frame

Pagadala Yesu Anjaneyulu (1):
      wifi: mac80211: ibss: wait for in-flight TX on disconnect

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: convert pmsr_free_wk to wiphy_work to fix deadlock

Pengpeng Hou (5):
      wifi: rsi: avoid reading TKIP MIC keys for non-TKIP ciphers
      wifi: libertas: reject short monitor TX frames
      wifi: rsi: bound background scan probe request copy
      wifi: libipw: fix key index receive bound checks
      wifi: rsi: validate beacon length before fixed buffer copy

Rafael Beims (2):
      wifi: mwifiex: fix roaming to different channel in host_mlme mode
      wifi: mwifiex: fix permanently busy scans after multiple roam iterations

Runyu Xiao (2):
      wifi: rt2x00: avoid full teardown before work setup in probe
      wifi: brcmfmac: initialize SDIO data work before cleanup

Shahar Tzarfati (1):
      wifi: mac80211: recalculate rx_nss on IBSS peer capability update

Xiang Mei (3):
      wifi: mac80211: fix unsol_bcast_probe_resp double free on alloc failure
      wifi: mac80211: fix fils_discovery double free on alloc failure
      wifi: p54: validate RX frame length in p54_rx_eeprom_readback()

Yousef Alhouseen (1):
      wifi: mac80211_hwsim: avoid treating MCS as legacy rate index

Zhao Li (14):
      wifi: nl80211: free RNR data on MBSSID mismatch
      wifi: mac80211: validate extension-frame layout before RX
      wifi: cfg80211: derive S1G beacon TSF from S1G fields
      wifi: ieee80211: validate MLE common info length
      wifi: nl80211: validate nested MBSSID IE blobs
      wifi: nl80211: constrain MBSSID TX link ID range
      wifi: cfg80211: validate PMSR measurement type data
      wifi: cfg80211: validate PMSR FTM preamble range
      wifi: cfg80211: reject unsupported PMSR FTM location requests
      wifi: cfg80211: reject empty PMSR peer lists
      wifi: mac80211: avoid non-S1G AID fallback for S1G assoc
      wifi: mac80211: validate deauth frame length before reason access
      wifi: cfg80211: validate rx/tx MLME callback frame lengths before access
      wifi: cfg80211: validate assoc response length before status and IE access

Zhiling Zou (1):
      wifi: mac80211: free ack status frame on TX header build failure

 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |   6 ++
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |   8 +-
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |   4 +-
 drivers/net/wireless/intersil/p54/txrx.c           |   8 ++
 drivers/net/wireless/marvell/libertas/firmware.c   |   1 +
 drivers/net/wireless/marvell/libertas/tx.c         |   7 ++
 drivers/net/wireless/marvell/libertas_tf/main.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/join.c        |   1 -
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c     |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c     |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c     |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |  12 ++-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c       |   2 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c             |   8 ++
 drivers/net/wireless/rsi/rsi_91x_mgmt.c            |  12 ++-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |  16 +++-
 include/linux/ieee80211-eht.h                      |  12 +--
 include/net/cfg80211.h                             |   4 +-
 net/mac80211/cfg.c                                 |  11 ++-
 net/mac80211/ibss.c                                |  13 +--
 net/mac80211/iface.c                               |   8 +-
 net/mac80211/main.c                                |   3 +-
 net/mac80211/mlme.c                                |  12 ++-
 net/mac80211/nan.c                                 |  35 +++----
 net/mac80211/rx.c                                  |  34 ++++++-
 net/mac80211/sta_info.c                            |  15 ++-
 net/mac80211/tx.c                                  |  17 +++-
 net/mac80211/util.c                                |   3 +
 net/wireless/core.c                                |  14 +--
 net/wireless/core.h                                |   4 +-
 net/wireless/mlme.c                                | 105 +++++++++++++++------
 net/wireless/nl80211.c                             |  25 +++--
 net/wireless/pmsr.c                                |  34 +++++--
 net/wireless/scan.c                                |  18 ++--
 net/wireless/sme.c                                 |   6 +-
 37 files changed, 336 insertions(+), 134 deletions(-)

