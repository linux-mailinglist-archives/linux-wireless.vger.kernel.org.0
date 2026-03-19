Return-Path: <linux-wireless+bounces-33459-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMCHIgizu2k8mgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33459-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:25:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B42C7D9F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99D3030074CD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6F3A9630;
	Thu, 19 Mar 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eHFitaYc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B73A963A;
	Thu, 19 Mar 2026 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908689; cv=none; b=p91ZYMsDSQ6bwMsIhVUQ+qlQ/q39wx/sNyj+zGj4db7RX0D66kxcIjXd0hQ8mjVbNzXYEasFcPtD29WrBZPkJVm1YwgJVJ0h89WiZTUdM4BGpDFbCVLCCCPv966ri5h7KReBo9RrMJufRl3bjXH3cV4i7n8s67ENPWv/1MWZAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908689; c=relaxed/simple;
	bh=tVW2FmE14niE/0yXM8kkxwftXCnf6jtcChqH29KKe7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOdRTmGNSQsRqCZw3l7HoUKylwwSDqnED9JTJEQbBckzKWOJbeON5gesA2gT5B3VaAU+1FdPm+RR6xw1V8p13FgzCwD/S6N13KskyDFDZPzdbQxxGpjkPNYmWQpslFYHPumXq3Qj3Odn9gQi9RO0f/7ynCrTHAMTCSzhd+R/c2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eHFitaYc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=aYexoGLo0m+sDFQaOMm5wq22P2LNEw+XOi5pCm8DDT0=; t=1773908685; x=1775118285; 
	b=eHFitaYcT6r14fmfVDx2I2akzCc4G8qRWtO7XuV5XxhaB7sp/ZYMvGe8zvp3U8S3mCexuxYPHgi
	k2lXNPF3EZPriMy01983cnbQxeGmadJbeWoZBeMCPd761x9nwR/aJaDBMMreQHGK/5tZ/T4xmXHOn
	J7+eVpRs7fpYsIdjuIU1b02C4mWUmLnfOv0WAxkRZnLae9T65zPFi5YyG7/Cz+x8XKkzd4JCeOUKK
	JXkvGsLdDQZJnIJmBAvUtM0dELarFHD7NHybSC5/TZFN7UHmzeIZwrZHniZBtupQjB2BPjbzKA2Su
	VxmA25uLr87O+E9RTESqIDMLnTIFZsY8XJ1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w38gM-00000005Q5y-2RQ2;
	Thu, 19 Mar 2026 09:24:43 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-03-19
Date: Thu, 19 Mar 2026 09:22:16 +0100
Message-ID: <20260319082439.79875-3-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33459-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 936B42C7D9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

We have only a couple of things for -next right now, though I think
we'll have a bigger pull request soon with NAN and ranging APIs and
likely driver work. But I want to be able to get the cross-merge in
since the ranging will depend on that, so here is this for now.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 0b1324cdd8de9f54f9daf689a4ae59783c333510:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-03-05 12:11:05 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-03-19

for you to fetch changes up to dee55bc7cb8ad70b8c8598df60f378b7aed2e41b:

  qtnfmac: use alloc_netdev macro for single queue devices (2026-03-19 09:08:09 +0100)

----------------------------------------------------------------
Aside from various small improvements/cleanups, not much:
 - cfg80211/mac80211: S1G and UHR improvements
 - hwsim: incumbent signal report test support

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211_hwsim: add incumbent signal interference detection support

Heitor Alves de Siqueira (2):
      wifi: libertas: use USB anchors for tracking in-flight URBs
      wifi: libertas: don't kill URBs in interrupt context

Johan Hovold (5):
      wifi: at76c50x: drop redundant device reference
      wifi: libertas: drop redundant device reference
      wifi: libertas_tf: drop redundant device reference
      wifi: rt2x00: drop redundant device reference
      wifi: mwifiex: drop redundant device reference

Johannes Berg (13):
      wifi: move action code from per-type frame structs
      wifi: mac80211: remove stale TODO item
      wifi: mac80211: remove AID bit stripping for print
      wifi: nl80211: fix UHR capability validation
      wifi: ieee80211: fix UHR operation DBE vs. P-EDCA order
      wifi: nl80211: split out UHR operation information
      wifi: mac80211: validate HE 6 GHz operation when EHT is used
      wifi: mac80211: refactor chandef tracing macros
      wifi: mac80211: always use full chanctx compatible check
      wifi: cfg80211: split control freq check from chandef check
      wifi: nl80211: reject S1G/60G with HT chantype
      wifi: mac80211: fix STA link removal during link removal
      wifi: nl80211: use int for band coming from netlink

Joshua Peisach (1):
      wifi: b43: use register definitions in nphy_op_software_rfkill

Lachlan Hodges (3):
      wifi: mac80211: don't use cfg80211_chandef_create() for default chandef
      wifi: cfg80211: restrict cfg80211_chandef_create() to only HT-based bands
      wifi: cfg80211: check non-S1G width with S1G chandef

Lorenzo Bianconi (1):
      wifi: mac80211: Remove deleted sta links in ieee80211_ml_reconf_work()

Ria Thomas (1):
      wifi: mac80211: add support for NDP ADDBA/DELBA for S1G

Roi L (1):
      qtnfmac: use alloc_netdev macro for single queue devices

Shayne Chen (1):
      wifi: ieee80211: fix definition of EHT-MCS 15 in MRU

Tim Bird (1):
      wifi: Add SPDX ids to some files in the wireless subsystem

Ville Nummela (1):
      wifi: rsi_91x_usb: do not pause rfkill polling when stopping mac80211

 drivers/net/wireless/ath/ath11k/mac.c              |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   4 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |   2 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |  12 +-
 drivers/net/wireless/broadcom/b43/phy_n.c          |  24 ++--
 drivers/net/wireless/intel/iwlwifi/mld/time_sync.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c |   6 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |  35 ++++--
 drivers/net/wireless/marvell/libertas/if_usb.h     |   3 +
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  |   2 -
 drivers/net/wireless/marvell/mwifiex/tdls.c        |  12 +-
 drivers/net/wireless/marvell/mwifiex/usb.c         |   4 -
 drivers/net/wireless/marvell/mwl8k.c               |   4 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   4 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |   4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |  12 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  14 +--
 drivers/net/wireless/realtek/rtlwifi/base.c        |  28 ++---
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |  17 ++-
 drivers/net/wireless/rsi/rsi_91x_usb.c             |   2 +
 drivers/net/wireless/rsi/rsi_common.h              |   1 +
 drivers/net/wireless/silabs/wfx/data_rx.c          |   8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  64 ++++++++++
 include/linux/ieee80211-eht.h                      |   4 +-
 include/linux/ieee80211-ht.h                       |   3 +
 include/linux/ieee80211-uhr.h                      |   4 +-
 include/linux/ieee80211.h                          |  85 +++++--------
 include/net/mac80211.h                             |   4 +
 include/uapi/linux/nl80211.h                       |   6 +
 net/mac80211/agg-rx.c                              |  49 +++++---
 net/mac80211/agg-tx.c                              |  39 +++---
 net/mac80211/chan.c                                |  90 ++++++--------
 net/mac80211/debugfs.c                             |   1 +
 net/mac80211/eht.c                                 |  21 ++--
 net/mac80211/ht.c                                  |  37 +++---
 net/mac80211/ibss.c                                |  18 +--
 net/mac80211/ieee80211_i.h                         |   6 +-
 net/mac80211/iface.c                               |  21 ++--
 net/mac80211/main.c                                |  18 ++-
 net/mac80211/mesh.c                                |  14 +--
 net/mac80211/mesh_hwmp.c                           |  20 ++-
 net/mac80211/mesh_plink.c                          |  21 ++--
 net/mac80211/mlme.c                                | 113 +++++++++--------
 net/mac80211/rx.c                                  | 134 +++++++++------------
 net/mac80211/s1g.c                                 |  36 +++---
 net/mac80211/spectmgmt.c                           |  31 ++---
 net/mac80211/sta_info.h                            |   3 +-
 net/mac80211/tdls.c                                |  29 ++---
 net/mac80211/trace.h                               |  94 ++++++---------
 net/mac80211/util.c                                |   5 +-
 net/mac80211/vht.c                                 |  10 +-
 net/wireless/chan.c                                | 110 ++++++++++-------
 net/wireless/nl80211.c                             |  37 ++++--
 net/wireless/of.c                                  |  13 +-
 net/wireless/radiotap.c                            |  10 +-
 net/wireless/reg.c                                 |  13 +-
 net/wireless/reg.h                                 |  13 +-
 net/wireless/trace.c                               |   1 +
 net/wireless/wext-core.c                           |   3 +-
 net/wireless/wext-priv.c                           |   3 +-
 net/wireless/wext-proc.c                           |   3 +-
 65 files changed, 733 insertions(+), 680 deletions(-)

