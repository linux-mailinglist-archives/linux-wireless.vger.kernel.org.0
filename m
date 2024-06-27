Return-Path: <linux-wireless+bounces-9658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB7591A57D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 13:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394841F25C3B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D4149009;
	Thu, 27 Jun 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XR+dU6NV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065913A409;
	Thu, 27 Jun 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488505; cv=none; b=MUlb8WAvllwcHpqACuDFdQ2f0DIpDwzAZYuYr7a+2OyjrfUixoEO19UqeSfLcxXzeXZ2ID0G6JS7SieqDIWWdDeIMWX0/WUH3UlonGgpTw8sxLycsFyT5HHZveMYVIzta1uQMRdulSmBf97mNK1OzZuRKy+lwi5BNkxG/dpwOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488505; c=relaxed/simple;
	bh=4FXh/TkCMbfPST6Kvpvfp1aFRLzK5IHi8qgZ3RD65eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pbi38cM+XLA0/WsaWKDP9f+auWKgyWO16CYF0GFxBSvxXet6x4hNbN+Gc0WI162bUXLEpwFVJeifgBhYu8t7XaqiROpmpKhBwzctayRuG2nsReEY0WNAJZuGEmBq31Be3Oy5kFzf9b1XVeKF/FNnvmat/m4B8V727Fpfm4ynT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XR+dU6NV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Wo6jmh4rZN5RdKPZa6vSojOHyZEKv95BF7Lc4Il0ido=; t=1719488503; x=1720698103; 
	b=XR+dU6NVe0J2MuDKAW4hTbNGxSHTXsCVW0AvSDIhWEnUX2dF+usJgy8uf8IraZ48c6xQ8rEFelU
	NZVz65yPSiRTX/tFZ/9GoLoURis2zHKeKkCiPjGBxs5JPVeBG9wGHXZGjoF9wDx3pScj71RKGb4A3
	lzzEqLmlmuHgCHCOje8pNmT60mx1Vt803E3A3l6RTAmk8jphcMUvcTcXH/jNJMuK3e1B1U46UKYfF
	XIm+WcxGTBUgpzh+9DXYXUb4h/8G3HDbPnhkrsXwJvRurdmERTETCeO/C6TYjNDEKrvKToAys7Xmi
	894GRQ4JDsuGVHIiHMPUhzqiGayq4GxEJpvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMnVS-000000071by-1b2W;
	Thu, 27 Jun 2024 13:41:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-next-2024-06-27
Date: Thu, 27 Jun 2024 13:40:53 +0200
Message-ID: <20240627114135.28507-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

Hi,

For net-next we have quite a bit of contents, highlights
in the tag message below. No known merge conflicts at this
time.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit bb678f01804ccaa861b012b2b9426d69673d8a84:

  Merge branch 'intel-wired-lan-driver-updates-2024-06-03' (2024-06-10 19:52:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-06-27

for you to fetch changes up to f3f942d6e5889ea9d46cecf8fc0b7893b5ba9792:

  wifi: brcmfmac: of: Support interrupts-extended (2024-06-26 20:50:58 +0300)

----------------------------------------------------------------
Highlights this time are:

 - cfg80211/nl80211:
    * improvements for 6 GHz regulatory flexibility

 - mac80211:
    * use generic netdev stats
    * multi-link improvements/fixes

 - brcmfmac:
    * MFP support (to enable WPA3)

 - wilc1000:
    * suspend/resume improvements

 - iwlwifi:
    * remove support for older FW for new devices
    * fast resume (keeping the device configured)

 - wl18xx:
    * support newer firmware versions

----------------------------------------------------------------
Ajay Singh (1):
      wifi: wilc1000: disable power sequencer

Alex Bee (1):
      wifi: brcmfmac: of: Support interrupts-extended

Alexis Lothoré (5):
      wifi: wilc1000: let host->chip suspend/resume notifications manage chip wake/sleep
      wifi: wilc1000: do not keep sdio bus claimed during suspend/resume
      wifi: wilc1000: move sdio suspend method next to resume and pm ops definition
      wifi: wilc1000: remove suspend/resume from cfg80211 part
      wifi: wilc1000: disable SDIO func IRQ before suspend

Arend van Spriel (1):
      wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Avraham Stern (2):
      wifi: nl80211: remove the FTMs per burst limit for NDP ranging
      wifi: mac80211_hwsim: add 320 MHz to hwsim channel widths

Baochen Qiang (2):
      wifi: cfg80211: fix typo in cfg80211_calculate_bitrate_he()
      wifi: cfg80211: handle 2x996 RU allocation in cfg80211_calculate_bitrate_he()

Benjamin Berg (2):
      wifi: cfg80211: reject non-conformant 6 GHz center frequencies
      wifi: iwlwifi: mvm: don't log error for failed UATS table read

Breno Leitao (2):
      wifi: mac80211: Move stats allocation to core
      wifi: mac80211: Remove generic .ndo_get_stats64

Daniel Gabay (2):
      wifi: iwlwifi: fix iwl_mvm_get_valid_rx_ant()
      wifi: iwlwifi: remove MVM prefix from scan API

Emmanuel Grumbach (7):
      wifi: cfg80211: honor WIPHY_FLAG_SPLIT_SCAN_6GHZ in cfg80211_conn_scan
      wifi: mac80211: inform the low level if drv_stop() is a suspend
      wifi: iwlwifi: pcie: fix a few legacy register accesses for new devices
      wifi: iwlwifi: support fast resume
      wifi: iwlwifi: don't assume op_mode_nic_config exists
      wifi: iwlwifi: trans: remove unused status bits
      wifi: iwlwifi: update the BA notification API

Erick Archer (2):
      wifi: at76c50x: use sizeof(*pointer) instead of sizeof(type)
      wifi: at76c50x: prefer struct_size over open coded arithmetic

Golan Ben Ami (1):
      wifi: iwlwifi: remove AX101, AX201 and AX203 support from LNL

Ilan Peer (2):
      wifi: cfg80211: Always call tracing
      wifi: iwlwifi: mvm: Fix associated initiator key setting

Johannes Berg (46):
      wifi: mac80211: correct EHT EIRP TPE parsing
      wifi: cfg80211: make hash table duplicates more survivable
      wifi: nl80211: expose can-monitor channel property
      wifi: cfg80211: use BIT() for flag enums
      wifi: ieee80211: remove unused enum ieee80211_client_reg_power
      wifi: cfg80211: move enum ieee80211_ap_reg_power to cfg80211
      wifi: mac80211: refactor channel checks
      wifi: cfg80211: refactor 6 GHz AP power type parsing
      wifi: cfg80211: refactor regulatory beaconing checking
      wifi: cfg80211: add regulatory flag to allow VLP AP operation
      wifi: mac80211: fix erroneous errors for STA changes
      wifi: mac80211: clean up 'ret' in sta_link_apply_parameters()
      wifi: iwlwifi: mvm: fix DTIM skip powersave config
      wifi: iwlwifi: move TXQ bytecount limit to queue code
      wifi: iwlwifi: api: fix includes in debug.h
      wifi: iwlwifi: pcie: integrate TX queue code
      wifi: iwlwifi: mvm: separate non-BSS/ROC EMLSR blocking
      wifi: mac80211: refactor CSA queue block/unblock
      wifi: mac80211: restrict public action ECSA frame handling
      wifi: mac80211: handle protected dual of public action
      wifi: mac80211: optionally pass chandef to ieee80211_sta_cap_rx_bw()
      wifi: mac80211: optionally pass chandef to ieee80211_sta_cur_vht_bw()
      wifi: mac80211: make ieee80211_chan_bw_change() able to use reserved
      wifi: mac80211: update STA/chandef width during switch
      wifi: mac80211: add ieee80211_tdls_sta_link_id()
      wifi: mac80211: correcty limit wider BW TDLS STAs
      wifi: mac80211: check SSID in beacon
      wifi: iwlwifi: mvm: unify and fix interface combinations
      wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_remove_interface_common()
      wifi: iwlwifi: mvm: rename 'pldr_sync'
      wifi: iwlwifi: mei: clarify iwl_mei_pldr_req() docs
      wifi: iwlwifi: mvm: enable VLP AP on VLP channels
      wifi: iwlwifi: mvm: don't limit VLP/AFC to UATS-enabled
      wifi: iwlwifi: mvm: don't flush BSSes on restart with MLD API
      wifi: iwlwifi: mvm: use IWL_FW_CHECK for link ID check
      wifi: iwlwifi: mvm: always unblock EMLSR on ROC end
      wifi: iwlwifi: fw: api: fix some kernel-doc
      wifi: iwlwifi: trans: make bad state warnings
      wifi: iwlwifi: dvm: fix kernel-doc warnings
      wifi: iwlwifi: pcie: fix kernel-doc
      wifi: iwlwifi: fix kernel-doc in iwl-trans.h
      wifi: iwlwifi: fix kernel-doc in iwl-fh.h
      wifi: iwlwifi: fix prototype mismatch kernel-doc warnings
      wifi: iwlwifi: fix remaining mistagged kernel-doc comments
      wifi: iwlwifi: fw: api: datapath: fix kernel-doc
      wifi: iwlwifi: mvm: fix rs.h kernel-doc

Miri Korenblit (8):
      wifi: iwlwifi: mvm: remove unneeded debugfs entries
      wifi: iwlwifi: bump minimum API version in BZ/SC to 90
      wifi: iwlwifi: mvm: fix re-enabling EMLSR
      wifi: iwlwifi: bump min API version for Qu/So devices
      wifi: iwlwifi: mvm: remove IWL_MVM_PARSE_NVM
      wifi: iwlwifi: trans: remove unused function parameter
      wifi: iwlwifi: bump FW API to 92 for BZ/SC devices
      wifi: iwlwifi: mvm: remove init_dbg module parameter

Russell King (Oracle) (8):
      wifi: wlcore: correctness fix fwlog reading
      wifi: wl18xx: make wl18xx_tx_immediate_complete() more efficient
      wifi: wlcore: improve code in wlcore_fw_status()
      wifi: wlcore: pass "status" to wlcore_hw_convert_fw_status()
      wifi: wlcore: store AP encryption key type
      wifi: wlcore: add pn16 support
      wifi: wl18xx: add support for reading 8.9.1 fw status
      wifi: wl18xx: allow firmwares > 8.9.0.x.58

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: use ROC for P2P device activities

Wolfram Sang (4):
      wifi: brcmfmac: use 'time_left' variable with wait_event_timeout()
      wifi: mwl8k: use 'time_left' variable with wait_for_completion_timeout()
      wifi: p54: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      wifi: zd1211rw: use 'time_left' variable with wait_for_completion_timeout()

Yedidya Benshimol (1):
      wifi: iwlwifi: remove struct iwl_trans_ops

Zijun Hu (1):
      net: rfkill: Correct return value in invalid parameter case

Zong-Zhe Yang (1):
      wifi: mac80211: fix NULL dereference at band check in starting tx ba session

 drivers/net/wireless/admtek/adm8211.c              |    2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |    2 +-
 drivers/net/wireless/ath/ath10k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath12k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath5k/base.c              |    2 +-
 drivers/net/wireless/ath/ath5k/base.h              |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |    2 +-
 drivers/net/wireless/ath/ath9k/main.c              |    2 +-
 drivers/net/wireless/ath/carl9170/main.c           |    2 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    2 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |   58 +-
 drivers/net/wireless/atmel/at76c50x-usb.h          |    2 +-
 drivers/net/wireless/broadcom/b43/main.c           |    2 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |    2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   10 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |    5 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    3 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965.h         |    2 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h  |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/binding.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h   |   69 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   27 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    3 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   10 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   16 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    2 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    6 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   34 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   23 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  448 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  649 +------
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h   |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    1 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   85 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  221 ---
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  168 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   61 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   66 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  182 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   38 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |    2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   32 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  262 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    9 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   13 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  295 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  | 1130 +++++++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  999 +++++++++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      | 1900 --------------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |  191 --
 drivers/net/wireless/intersil/p54/fwio.c           |    6 +-
 drivers/net/wireless/intersil/p54/main.c           |    2 +-
 drivers/net/wireless/intersil/p54/p54pci.c         |    8 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |   10 +-
 drivers/net/wireless/marvell/libertas_tf/main.c    |    2 +-
 drivers/net/wireless/marvell/mwl8k.c               |   14 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    4 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt7601u/main.c       |    2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   19 -
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    1 -
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   74 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |    8 +-
 drivers/net/wireless/microchip/wilc1000/wlan.h     |    1 -
 drivers/net/wireless/purelifi/plfxlc/mac.c         |    2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.h         |    2 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |    2 +-
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |    2 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |    4 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |    3 +-
 drivers/net/wireless/silabs/wfx/sta.c              |    2 +-
 drivers/net/wireless/silabs/wfx/sta.h              |    2 +-
 drivers/net/wireless/st/cw1200/sta.c               |    2 +-
 drivers/net/wireless/st/cw1200/sta.h               |    2 +-
 drivers/net/wireless/ti/wl1251/main.c              |    2 +-
 drivers/net/wireless/ti/wl18xx/main.c              |  131 +-
 drivers/net/wireless/ti/wl18xx/tx.c                |   13 +-
 drivers/net/wireless/ti/wl18xx/wl18xx.h            |   62 +-
 drivers/net/wireless/ti/wlcore/cmd.c               |    9 +
 drivers/net/wireless/ti/wlcore/event.c             |    2 +-
 drivers/net/wireless/ti/wlcore/main.c              |  103 +-
 drivers/net/wireless/ti/wlcore/wlcore_i.h          |    4 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    3 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |    2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.h       |    2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |   10 +-
 drivers/staging/vt6655/device_main.c               |    2 +-
 drivers/staging/vt6656/main_usb.c                  |    2 +-
 include/linux/ieee80211.h                          |   38 -
 include/net/cfg80211.h                             |  177 +-
 include/net/mac80211.h                             |    2 +-
 include/uapi/linux/nl80211.h                       |    6 +
 net/mac80211/agg-tx.c                              |    4 +-
 net/mac80211/cfg.c                                 |   78 +-
 net/mac80211/chan.c                                |  109 +-
 net/mac80211/driver-ops.c                          |    6 +-
 net/mac80211/driver-ops.h                          |    2 +-
 net/mac80211/ibss.c                                |    3 +-
 net/mac80211/ieee80211_i.h                         |   28 +-
 net/mac80211/iface.c                               |   55 +-
 net/mac80211/mesh.c                                |    2 +-
 net/mac80211/mlme.c                                |  142 +-
 net/mac80211/parse.c                               |    2 +-
 net/mac80211/pm.c                                  |    4 +-
 net/mac80211/rx.c                                  |    1 +
 net/mac80211/spectmgmt.c                           |   15 +-
 net/mac80211/sta_info.h                            |    6 +
 net/mac80211/trace.h                               |   15 +-
 net/mac80211/tx.c                                  |    6 +-
 net/mac80211/util.c                                |    6 +-
 net/mac80211/vht.c                                 |   73 +-
 net/rfkill/core.c                                  |    8 +-
 net/wireless/chan.c                                |  120 +-
 net/wireless/core.h                                |    7 +-
 net/wireless/nl80211.c                             |   35 +-
 net/wireless/pmsr.c                                |   10 +-
 net/wireless/rdev-ops.h                            |   56 +-
 net/wireless/reg.c                                 |    2 +
 net/wireless/scan.c                                |  111 +-
 net/wireless/sme.c                                 |    4 +-
 net/wireless/tests/chan.c                          |   22 +-
 net/wireless/trace.h                               |   15 +-
 net/wireless/util.c                                |    8 +-
 183 files changed, 4727 insertions(+), 4334 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.h

