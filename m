Return-Path: <linux-wireless+bounces-37064-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAk6Nd83GGqkgwgAu9opvQ
	(envelope-from <linux-wireless+bounces-37064-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 14:41:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 389EA5F22F5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C209A301E3E7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2F3ED3BF;
	Thu, 28 May 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FANq9ehg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ADD3E833F;
	Thu, 28 May 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971965; cv=none; b=ulRQtFXSlYI0HX8aNpFNOv4WlP2YomzySTq7mk7/ix7YJW7Hj7GnVOzLiHWU8j+0wm23ciomK9iHiFo/HwoV3Ar37IgCIwVOBA5ttWvTU4La/qmeTywckHou0A/erZOTxQZVhxua+L7emxMRgA68qs9alpFQxcJC/C2ypbUUrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971965; c=relaxed/simple;
	bh=aPZz6A9NKoEhQpUVyZG/GOgEUR2H+fGLrO2aDr8X7j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoIFD8HJdZIh454/UeMQ9p3xBH5GXDGwmrPgd+ikTONJ5We2L3SJ5+qq3IskveLMTLVhV9QBU7+f3TSxif6NxSI8l097W4lE1UHEA4IezcqsU5PcM8II/i9wJxES0EEy/gTIqFIecLY6n+u9w6L1VNMXLeGlIxKydD7CmVZuomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FANq9ehg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=p4JiHdVsFp5oks7xJ6Ga4nove74q/edK5AWj2r0/Yis=; t=1779971963; x=1781181563; 
	b=FANq9ehgGZgfrt9Dgy7UdNcJItE5Hl4sST1h7l7NMOgxCruDo1RkI5y8uuSKW8AmSUJl2eJNZds
	u38KwaNyKDHutXkkrOojfHL5rL8mX6dDjcxMpXB+/bI2dTEudbFSdFI9mQgoN50lFqvAaNrBt+0ZB
	mbbmR3vZ5YC4J4AbHnSF6u/OI0GFO0bpZpE4Awa5Ih35eEJWaBiixiVl4bzAtPo6RYANqeiFUKU8W
	p6ZveBcHPLDM1ihU9tZ1mU3FfeM58Yx6J2mLrppSvQOJvRIy5cczS9JnTsrDQOa9MZRex8avWU1ZC
	bVToKgZx4Jkxb6OASzldCg2Gy0fzibWhMCtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSa15-00000007QRX-2UKF;
	Thu, 28 May 2026 14:39:15 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-05-28
Date: Thu, 28 May 2026 14:37:26 +0200
Message-ID: <20260528123911.284536-26-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-37064-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 389EA5F22F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Here's a new set of changes, mostly ath and iwlwifi
drivers this time.

I have a few more things pending, and I expect a few
more drivers will have pull requests later too.

Please pull and let us know if there's any problem.

And this time that might be more likely because my
nipa server was accidentally destroyed on Monday...

Thanks,
johannes



The following changes since commit 1a1f055318d82e64485a6ff8420e5f70b4267998:

  Merge tag 'wireless-next-2026-05-21' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-05-21 16:00:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-05-28

for you to fetch changes up to 6f5dc19f46f4bd0e104c9a4da2f0a912cdf3bd86:

  Merge tag 'ath-next-20260526' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2026-05-28 10:23:15 +0200)

----------------------------------------------------------------
Mostly driver updates:
 - iwlwifi
   - more UHR support
   - NAN (multicast, schedule improvements, multi-station)
   - cleanups, etc.
 - ath12k
   - thermal throttling/cooling device support
   - 6 GHz incumbent interference detection
   - channel 177 in 5 GHz
 - hwsim: S1G fixes
 - mac80211: NAN channel handling improvements

----------------------------------------------------------------
Aaron Katzin (1):
      wifi: iwlwifi: pcie: add debug print for resume flow if powered off

Aishwarya R (2):
      wifi: ath12k: Add support for handling incumbent signal interference in 6 GHz
      wifi: ath12k: Add debugfs support to simulate incumbent signal interference

Arnd Bergmann (1):
      wifi: ath10k: drop gpio_led reference

Avinash Bhatt (9):
      wifi: iwlwifi: fix buffer overflow when firmware reports no channels
      wifi: iwlwifi: Transition to basic uAPSD with MAC_PM_POWER_TABLE API VER_3
      wifi: iwlwifi: mld: add chan-load hysteresis for MLO scan triggers
      wifi: iwlwifi: mld: add duplicated beacon RSSI adjustment
      wifi: iwlwifi: mld: Add KUnit tests for channel-load thresholds
      wifi: iwlwifi: mld: implement PSD/EIRP RSSI adjustment
      wifi: iwlwifi: mld: update link grading tables per bandwidth
      wifi: iwlwifi: mld: skip MLO scan trigger when AP has no QBSS Load IE
      wifi: iwlwifi: mld: keep healthy link on EMLSR missed beacon exit

Avraham Stern (5):
      wifi: iwlwifi: mld: call iwl_mld_free_ap_early_key() for AP only
      wifi: iwlwifi: mld: add support for nan schedule config command version 2
      wifi: iwlwifi: mld: add handler for NAN ULW attribute notification
      wifi: iwlwifi: mld: nan: add availability attribute to schedule config
      wifi: iwlwifi: mld: add support for deferred nan schedule config

Dan Carpenter (1):
      wifi: mwifiex: remove an unnecessary check

Daniel Gabay (4):
      wifi: iwlwifi: mld: fix NAN DW end notification handler
      wifi: iwlwifi: mld: add NULL check for channel in DW end handler
      wifi: iwlwifi: mld: validate aux sta before flush in stop_nan
      wifi: iwlwifi: print UHR rate type

Daniel Lezcano (2):
      wifi: ath: Use the unified QMI service ID instead of defining it locally
      wifi: ath: Fix the license marking

Dongyang Jin (1):
      wifi: iwlwifi: mld: fix indentation in iwl_mld_fill_supp_rates()

Emmanuel Grumbach (15):
      wifi: iwlwifi: fix the access to CNVR TOP registers
      wifi: iwlwifi: mld: honor BSS_CHANGED_BEACON_ENABLED
      wifi: iwlwifi: mld: move iwl_mld_link_info_changed_ap_ibss to ap.c
      wifi: iwlwifi: rename iwl_system_statistics_notif_oper
      wifi: iwlwifi: introduce iwl_system_statistics_notif_oper version 4
      wifi: iwlwifi: mld: support the new statistics APIs
      wifi: iwlwifi: remove nvm_ver for devices that don't need it
      wifi: iwlwifi: implement the new RSC notification
      wifi: iwlwifi: led_compensation is needed for iwldvm only
      wifi: iwlwifi: shadow_ram_support is needed for iwldvm only.
      wifi: iwlwifi: max_event_log_size is needed for iwldvm only
      wifi: iwlwifi: smem_offset smem_len are not needed from 22000 and up
      wifi: iwlwifi: reduce the log level of firmware debug buffer size mismatch
      wifi: iwlwifi: move pcie content to pcie internal transport
      wifi: iwlwifi: move iwl_trans_activate_nic to iwl-trans.c

Ilan Peer (7):
      wifi: iwlwifi: mld: Fix number of antennas in NAN capabilities
      wifi: iwlwifi: mld: Do not declare support for NDPE
      wifi: iwlwifi: mld: Do not declare NAN support for Extended Key ID
      wifi: iwlwifi: mld: Add support for multiple NAN Management stations
      wifi: iwlwifi: mld: Replace static declarations of IWL_MLD_ALLOC_FN
      wifi: iwlwifi: mld: Add support for NAN multicast data
      wifi: iwlwifi: mld: Disallow using a per-STA GTK for Tx

Israel Kozitz (1):
      wifi: iwlwifi: mld: fix NAN max channel switch time unit

Jay Ng (1):
      wifi: iwlwifi: remove unused header inclusions

Johannes Berg (41):
      wifi: iwlwifi: mld: tlc: separate from link STA
      wifi: iwlwifi: mld: disable queue hang detection for NAN data
      wifi: iwlwifi: mld: support NAN and NAN_DATA interfaces
      wifi: iwlwifi: mld: add NAN link management
      wifi: iwlwifi: add NAN schedule command support
      wifi: iwlwifi: mld: implement NAN peer station management
      wifi: iwlwifi: mld: add peer schedule support
      wifi: iwlwifi: mld: clean up station handling in key APIs
      wifi: iwlwifi: mld: add TLC support for NAN stations
      wifi: iwlwifi: mld: track TX/RX IGTKs separately
      wifi: iwlwifi: mld: don't report bad STA ID in EHT TB sniffer
      wifi: iwlwifi: api: RX: define UHR RX PHY flags
      wifi: iwlwifi: fw: api: fix UHR U-SIG whitespace
      wifi: iwlwifi: fw: api: add/fix some UHR sniffer definitions
      wifi: iwlwifi: pcie: fix ACPI DSM check
      wifi: iwlwifi: advertise UHR capabilities for such devices
      wifi: iwlwifi: print FSEQ sha1 in addition to version
      wifi: iwlwifi: tighten flags in debugfs command sending
      wifi: iwlwifi: define new FSEQ TLV with MAC ID
      wifi: iwlwifi: set state to NO_FW on reset
      wifi: iwlwifi: mld: support NPCA capability for UHR devices
      wifi: iwlwifi: mld: implement UHR DPS
      wifi: iwlwifi: mld: give link STA debugfs files a namespace
      wifi: iwlwifi: mld: set correct key mask for NAN
      wifi: iwlwifi: mld: add UHR DUO support
      wifi: iwlwifi: mld: implement UHR multi-link PM
      wifi: iwlwifi: mld: rename LINK_DEBUGFS_WRITE_FILE_OPS
      wifi: iwlwifi: mld: add link and link station FW IDs to debugfs
      wifi: iwlwifi: api: remove NAN_GROUP
      wifi: iwlwifi: api: clean up/fix some kernel-doc references
      wifi: iwlwifi: pcie: add two LNL PCI IDs
      wifi: iwlwifi: clean up location format/BW encoding
      wifi: iwlwifi: fw: move struct iwl_fw_ini_dump_entry to dbg.c
      wifi: iwlwifi: fw: separate ini dump allocation
      wifi: iwlwifi: fw: dbg: always use non-tracing PRPH access
      wifi: iwlwifi: fw: separate out old-style dump code
      wifi: iwlwifi: dbg: remove unused 'range_len' arg from dump
      wifi: iwlwifi: transport: add memory read under NIC access
      wifi: mac80211_hwsim: add debug messages for link changes
      Merge tag 'iwlwifi-next-2026-05-26' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'ath-next-20260526' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Jose Ignacio Tornos Martinez (1):
      wifi: ath11k: fix warning when unbinding

Junjie Cao (2):
      wifi: iwlwifi: mld: fix race condition in PTP removal
      wifi: iwlwifi: mvm: fix race condition in PTP removal

Junrui Luo (1):
      wifi: iwlwifi: mld: validate sta_mask before ffs() in BA session handlers

Kexin Sun (1):
      wifi: ath10k: update outdated comment for renamed ieee80211_tx_status()

Krzysztof Kozlowski (1):
      wifi: ath: Unify user-visible "Qualcomm" name

Lachlan Hodges (2):
      wifi: mac80211_hwsim: don't run RC update on new STA on S1G vif
      wifi: mac80211_hwsim: modernise S1G channel list

Maharaja Kennadyrajan (5):
      wifi: ath12k: handle thermal throttle stats WMI event
      wifi: ath12k: configure firmware thermal throttling via WMI
      wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
      wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
      wifi: ath12k: add thermal cooling device support

Maoyi Xie (1):
      wifi: nl80211: re-check wiphy netns in testmode and vendor dump continuations

Michael Bommarito (1):
      wifi: mac80211: add KUnit coverage for negotiated TTLM parser

Miri Korenblit (22):
      wifi: iwlwifi: mld: set NAN phy capabilities
      wifi: iwlwifi: mld: use host rate for NAN management frames
      wifi: iwlwifi: mld: extract NAN capabilities setting to a function
      wifi: iwlwifi: mld: don't allow softAP with NAN
      wifi: iwlwifi: bump core version for BZ/SC/DR to 103
      wifi: iwlwifi: mld: allow NAN data
      wifi: iwlwifi: support a TLV indicating num of mgmt mcast keys
      wifi: iwlwifi: mark that we support iwl_rx_mpdu_desc version 7 and 8
      wifi: iwlwifi: stop supporting cores 97 to 100
      wifi: iwlwifi: mld: stop supporting iwl_compressed_ba_notif version 5 and 6
      wifi: iwlwifi: mld: stop supporting MAC_PM_POWER_TABLE version 1
      wifi: iwlwifi: mld: stop supporting TLC_MNG_UPDATE_NTFY_API_S_VER_3
      wifi: iwlwifi: mld: stop supporting rate_n_flags version 2
      wifi: iwlwifi: bump core version for BZ/SC/DR to 104
      wifi: iwlwifi: define MODULE_FIRMWARE with the correct API
      wifi: iwlwifi: mld: evacuate NAN channels on link switch
      wifi: iwlwifi: mld: don't flush async_handlers_wk when canceling notifications
      wifi: iwlwifi: mld: purge async notifications upon nic error
      wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 105
      wifi: mac80211: add an option to filter out a channel in combinations check
      wifi: mac80211: refactor ieee80211_nan_try_evacuate
      wifi: mac80211: fix channel evacuation logic

Nicolas Escande (1):
      wifi: ath12k: unify error handling in some ath12k_wmi_xxx() functions

Pagadala Yesu Anjaneyulu (3):
      wifi: iwlwifi: add RF name handling for PE chip type for debugfs
      wifi: iwlwifi: add XIAOMI to PPAG approved list
      wifi: iwlwifi: mld: disallow puncturing in US/CA for WH

Ripan Deuri (1):
      wifi: ath12k: fix error unwind on arch_init() failure in PCI probe

Rosen Penev (4):
      wifi: ath9k: use non devm for nvmem_cell_get
      wifi: ath9k: owl: move name into owl_nvmem_probe
      wifi: ath9k: use kmemdup and kcalloc
      wifi: ath12k: use kzalloc_flex

Shahar Tzarfati (2):
      wifi: iwlwifi: mld: expose beacon avg signal
      wifi: iwlwifi: Add names for Killer BE1735x and BE1730x

Tamizh Chelvam Raja (1):
      wifi: ath12k: Handle DP_RX_DECAP_TYPE_8023 type in Rx path

Thorsten Blum (1):
      wifi: cfg80211: use strscpy in cfg80211_wext_giwname

Tristan Madani (1):
      wifi: ath9k: fix OOB access from firmware tx status queue ID

Wei Zhang (1):
      wifi: ath11k: cancel SSR work items during PCI shutdown

Yingying Tang (1):
      wifi: ath12k: add channel 177 to the 5 GHz channel list

pengdonglin (1):
      wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock

 drivers/net/wireless/ath/ath10k/core.h             |    1 -
 drivers/net/wireless/ath/ath10k/htt_tx.c           |    2 +-
 drivers/net/wireless/ath/ath10k/leds.c             |    8 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |    4 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h     |    1 -
 drivers/net/wireless/ath/ath11k/Kconfig            |    2 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |    4 +-
 drivers/net/wireless/ath/ath11k/pci.c              |    8 +
 drivers/net/wireless/ath/ath11k/qmi.c              |    3 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |    1 -
 drivers/net/wireless/ath/ath12k/Kconfig            |    6 +-
 drivers/net/wireless/ath/ath12k/core.c             |   50 +-
 drivers/net/wireless/ath/ath12k/core.h             |   12 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   46 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   68 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  110 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    1 -
 drivers/net/wireless/ath/ath12k/thermal.c          |  252 +++-
 drivers/net/wireless/ath/ath12k/thermal.h          |   35 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  565 ++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  125 +-
 drivers/net/wireless/ath/ath9k/ar9002_hw.c         |    6 +-
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |   31 +-
 drivers/net/wireless/ath/ath9k/common-init.c       |    8 +-
 drivers/net/wireless/ath/ath9k/init.c              |   11 +-
 drivers/net/wireless/ath/ath9k/recv.c              |    4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    7 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |   23 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   38 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   19 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |   19 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |    8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |   17 -
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |   30 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |   22 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c     |    8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   22 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   13 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    9 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |  107 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  184 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   48 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   40 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |   90 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg-old.c    | 1022 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 1298 +++-----------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   15 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   10 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c         |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   25 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  150 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  123 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |    9 +
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |   58 +-
 drivers/net/wireless/intel/iwlwifi/mld/ap.h        |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  166 ++-
 drivers/net/wireless/intel/iwlwifi/mld/d3.h        |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   74 +-
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |   30 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |  187 ++-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   62 +-
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |  168 ++-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  569 ++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   37 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  362 ++++--
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |   13 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   20 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   16 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   36 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c       |  748 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.h       |   41 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   35 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c       |   24 +-
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |  210 +++-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   44 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.h        |    7 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |  247 +++-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h       |   32 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |  108 +-
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |    1 +
 .../intel/iwlwifi/mld/tests/chan_load_thresh.c     |  139 +++
 .../intel/iwlwifi/mld/tests/link-selection.c       |    6 +-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |  410 ++++---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |   51 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   30 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   32 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   14 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |  107 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |    9 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |   93 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |   37 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |   70 +-
 net/mac80211/chan.c                                |   78 +-
 net/mac80211/ieee80211_i.h                         |   71 +-
 net/mac80211/mlme.c                                |    3 +-
 net/mac80211/nan.c                                 |   55 +-
 net/mac80211/tests/.kunitconfig                    |    4 +
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/ttlm.c                          |  175 +++
 net/mac80211/util.c                                |   34 +-
 net/wireless/nl80211.c                             |   19 +
 net/wireless/wext-compat.c                         |    3 +-
 129 files changed, 7083 insertions(+), 2559 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dbg-old.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/chan_load_thresh.c
 create mode 100644 net/mac80211/tests/.kunitconfig
 create mode 100644 net/mac80211/tests/ttlm.c

