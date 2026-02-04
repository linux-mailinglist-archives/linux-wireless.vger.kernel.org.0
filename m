Return-Path: <linux-wireless+bounces-31531-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCHDJWg5g2ngjwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31531-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:19:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E5E5B76
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AE78302D319
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF743ED13A;
	Wed,  4 Feb 2026 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PiwPHlZh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BD3ED135;
	Wed,  4 Feb 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207109; cv=none; b=tsUoPQb8Ls7HuqQDy3otKwmtDcETuZqLAlMb0B2i9H9xb+O6+WNgGcj1iB1wyLIsD4oYuncd4aYHg9xvbKLjTmEvIXwH1Lf52v3siS0JZUtNtZfPyUBYK2ULdPTb7I7hIdfNpWAhQ/N/7hml3bg2yvllOcaMmTj3KlQxQ3lGy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207109; c=relaxed/simple;
	bh=E72lRfffrbjsoxsZ1ANDr7CC2jDG0kCBzSXD6YjGVBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzqkiLg/6/U7LpJgfkncqdni+x1M0sy64qaq0IbwvI2U/tXD9kpN3LhKV1GBk9kCAL76Dueo5/9DR9z3rYGKoHALgMSUwMDpqJVqvkmxtgchz+VKwlboK2EvFneYmJ4nEh085nMXoUGanh6aCCA7lOUsEXRyHoycdZhoAR/fFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PiwPHlZh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hBGO24IpX+uijpFKMhhUsPdedoPYdDk1kxAezgTwd3M=; t=1770207108; x=1771416708; 
	b=PiwPHlZhjwlwCWoA4dvWcufeuAtpEHFsbL0qW8rlhy8FmznWaf9pCw/Frojh/dlvpiYgABKidmW
	BiOJiC0rLP8o+tkC2tm2jn/khjn4mtL5iHHtkIjLoTpkghewwjDt3KZ3EO4lp44oBQEZn1WbVpzCU
	OXdAXqFVDHZw+g5PtjPGbBeMCf4EO8QNFieRLCmtzpgHMq1MyQXr0hRbw8BD5xVwOfRGCotywflOH
	LZ8nGxWUzjpp4ReFPCOrsAR36WtoHOd5jvJs8F+6vJvtIyXw1PkCwD7nK6J/YOnu6E7sjyaq7+g0O
	VmUZMzFqBLxueg1tHxrekm4nVHbcA66y2Q3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnbjW-0000000ELjN-2DhJ;
	Wed, 04 Feb 2026 13:11:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-02-04
Date: Wed,  4 Feb 2026 13:09:51 +0100
Message-ID: <20260204121143.181112-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31531-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D82E5E5B76
X-Rspamd-Action: no action

Hi,

And here's a final set of changes for the -next tree.
rtw seems to have the biggest changes, refactoring to
support a new device.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 303c1a66a22068517793284524dd1d24b7316d1b:

  Merge tag 'wireless-next-2026-01-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-01-29 19:17:43 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-02-04

for you to fetch changes up to 9825fa8f49905275acef6c8e7fcd017d04616311:

  wifi: brcmsmac: phy: Remove unreachable error handling code (2026-02-03 13:11:12 +0100)

----------------------------------------------------------------
Some more changes, including pulls from drivers:
 - ath drivers: small features/cleanups
 - rtw drivers: mostly refactoring for rtw89 RTL8922DE support
 - mac80211: use hrtimers for CAC to avoid too long delays
 - cfg80211/mac80211: some initial UHR (Wi-Fi 8) support

----------------------------------------------------------------
Aaradhana Sahu (4):
      wifi: ath12k: Fix index decrement when array_len is zero
      wifi: ath12k: Add support RX PDEV stats
      wifi: ath12k: Add support TX hardware queue stats
      wifi: ath12k: clear stale link mapping of ahvif->links_map

Amith A (1):
      wifi: mac80211: use wiphy_hrtimer_work for CAC timeout

Chih-Kang Chang (1):
      wifi: rtw89: wow: disable interrupt before swapping FW for 8922D

Dian-Syuan Yang (1):
      wifi: rtw89: pci: restore LDO setting after device resume

Dmitry Baryshkov (1):
      wifi: ath10k: snoc: support powering on the device via pwrseq

Eric Huang (5):
      wifi: rtw89: phy: extend register to read history 2 of PHY env_monitor
      wifi: rtw89: phy: update bb wrapper TPU init
      wifi: rtw89: phy: handle C2H event for PS mode report
      wifi: rtw89: phy: add H2C command to send detail RX gain and link parameters for PS mode
      wifi: rtw89: phy: update edcca log parsing for RTL8922D

Ingyu Jang (1):
      wifi: brcmsmac: phy: Remove unreachable error handling code

Johannes Berg (5):
      Merge tag 'rtw-next-2026-01-30' of https://github.com/pkshih/rtw
      wifi: ieee80211: add some initial UHR definitions
      wifi: cfg80211: add initial UHR support
      wifi: mac80211: add initial UHR support
      Merge tag 'ath-next-20260202' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Lachlan Hodges (1):
      wifi: mac80211: correct ieee80211-{s1g/eht}.h include guard comments

Lorenzo Bianconi (1):
      wifi: mac80211: Add eMLSR/eMLMR action frame parsing support

Marco Crivellari (1):
      wifi: rtw88: add WQ_PERCPU to alloc_workqueue users

Miaoqing Pan (2):
      wifi: ath11k: add usecase firmware handling based on device compatible
      dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name' property

Ping-Ke Shih (22):
      wifi: rtw89: mac: clear global interrupt right after power-on
      wifi: rtw89: phy: add {read,write}_rf_v3 for RTL8922D
      wifi: rtw89: phy: add ops rtw89_phy_gen_be_v1 for RTL8922D
      wifi: rtw89: phy: abstract start address and EHT of PHY status bitmap
      wifi: rtw89: phy: abstract BB wrap registers to share initial flow
      wifi: rtw89: phy: update BB wrapper RFSI
      wifi: rtw89: phy: write BB wrapper registers with flush
      wifi: rtw89: phy: refine initial flow of BB wrapper
      wifi: rtw89: phy: add chip_ops to calculate RX gain from efuse to support PS mode
      wifi: rtw89: phy: add firmware element of digital TX power compensation
      wifi: rtw89: mac: clear DTOP disable excluding CID7090 variant for RTL8922D
      wifi: rtw89: mac: set force MBA duration to 0
      wifi: rtw89: rfk: add firmware command to do TX IQK
      wifi: rtw89: rfk: add to print debug log of TX IQK
      wifi: rtw89: rfk: add firmware command to do CIM3K
      wifi: rtw89: rfk: add to print debug log of CIM3K
      wifi: rtw89: rfk: update RFK report format of IQK, DACK and TXGAPK
      wifi: rtw89: fw: correct content of DACK H2C command
      wifi: rtw89: phy: add PHY C2H event dummy handler for func 1-7 and 2-10
      wifi: rtw89: pci: validate release report content before using for RTL8922DE
      wifi: rtw89: mac: set MU group membership and position to registers
      wifi: rtw89: pci: warn if SPS OCP happens for RTL8922DE

Po-Hao Huang (3):
      wifi: rtw89: phy: fix incorrect power limit by mac_id
      wifi: rtw89: fix unable to receive probe responses under MLO connection
      wifi: rtw89: 8922a: add digital compensation for 2GHz

Shin-Yi Lin (1):
      wifi: rtw89: Add default ID 28de:2432 for RTL8832CU

Wei Zhang (2):
      wifi: ath12k: add WMI support for spatial reuse parameter configuration
      wifi: ath12k: support OBSS PD configuration for AP mode

Zilin Guan (1):
      wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()

Ziyi Guo (2):
      wifi: ath10k: fix lock protection in ath10k_wmi_event_peer_sta_ps_state_chg()
      wifi: ath10k: sdio: add missing lock protection in ath10k_sdio_fw_crashed_dump()

Zong-Zhe Yang (6):
      wifi: rtw89: phy: update TSSI flow for RTL8922D
      wifi: rtw89: 8922a: configure FW version for SIM_SER_L0L1_BY_HALT_H2C
      wifi: rtw89: get designated link to replace link instance 0
      wifi: rtw89: regd: update regulatory map to R73-R54
      wifi: rtw89: debug: rename mac/ctrl error to L0/L1 error
      wifi: rtw89: debug: tweak Wi-Fi 7 SER L0/L1 simulation methods

 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   1 +
 drivers/net/wireless/ath/ath10k/sdio.c             |   6 +
 drivers/net/wireless/ath/ath10k/snoc.c             |  53 +-
 drivers/net/wireless/ath/ath10k/snoc.h             |   3 +
 drivers/net/wireless/ath/ath10k/wmi.c              |   4 +-
 drivers/net/wireless/ath/ath11k/core.c             |  27 +
 drivers/net/wireless/ath/ath11k/core.h             |   4 +
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 197 ++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  81 +++
 drivers/net/wireless/ath/ath12k/mac.c              | 174 ++++++-
 drivers/net/wireless/ath/ath12k/mac.h              |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c              | 142 ++++++
 drivers/net/wireless/ath/ath12k/wmi.h              |  47 ++
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |   9 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   3 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  31 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  40 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  99 +++-
 drivers/net/wireless/realtek/rtw89/debug.h         |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c            | 297 ++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h            | 188 ++++++-
 drivers/net/wireless/realtek/rtw89/mac.c           |  23 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |  23 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   4 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  23 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  17 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   2 +
 drivers/net/wireless/realtek/rtw89/phy.c           | 381 ++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h           |  36 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        | 563 ++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/ps.c            |   2 +
 drivers/net/wireless/realtek/rtw89/reg.h           | 368 +++++++++++++-
 drivers/net/wireless/realtek/rtw89/regd.c          |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  58 ++-
 drivers/net/wireless/realtek/rtw89/wow.c           |   6 +-
 include/linux/ieee80211-eht.h                      |  13 +-
 include/linux/ieee80211-s1g.h                      |   2 +-
 include/linux/ieee80211-uhr.h                      | 220 ++++++++
 include/linux/ieee80211.h                          |  39 +-
 include/net/cfg80211.h                             |  58 ++-
 include/net/mac80211.h                             |  67 ++-
 include/uapi/linux/nl80211.h                       |  30 ++
 net/mac80211/Makefile                              |   2 +-
 net/mac80211/cfg.c                                 |  24 +-
 net/mac80211/driver-ops.h                          |  21 +
 net/mac80211/eht.c                                 | 175 +++++++
 net/mac80211/ieee80211_i.h                         |  23 +-
 net/mac80211/iface.c                               |  12 +-
 net/mac80211/link.c                                |   4 +-
 net/mac80211/main.c                                |  15 +-
 net/mac80211/mlme.c                                | 115 ++++-
 net/mac80211/parse.c                               |  22 +-
 net/mac80211/rx.c                                  |  34 ++
 net/mac80211/sta_info.c                            |  13 +-
 net/mac80211/sta_info.h                            |  80 ++-
 net/mac80211/trace.h                               |  32 ++
 net/mac80211/uhr.c                                 |  30 ++
 net/mac80211/util.c                                |  38 +-
 net/wireless/nl80211.c                             | 102 +++-
 net/wireless/reg.c                                 |   4 +-
 net/wireless/util.c                                | 101 +++-
 68 files changed, 3973 insertions(+), 247 deletions(-)
 create mode 100644 include/linux/ieee80211-uhr.h
 create mode 100644 net/mac80211/uhr.c

