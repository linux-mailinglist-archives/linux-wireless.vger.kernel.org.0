Return-Path: <linux-wireless+bounces-22672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BAAACC74
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A3C50019B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA18284B5B;
	Tue,  6 May 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BK0zt5cW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1606202C26;
	Tue,  6 May 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553630; cv=none; b=Kk0l8TTe4F6No16uKvaG1HoP639e8osbDBKFNKeVc3Ap4Wk+AmpXMLN1HBZgOtaGRggUqdPuQy9aDuipqwMqS874Qe50VQG4Bu+2/aEq237hM54CZDhn2p6758yAs94Lk6lpQ7Cmi3W9XmCadExMiP1Y9xJFJnkSQWMtb/Tnfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553630; c=relaxed/simple;
	bh=gRY5QwmEjxlUtrUic7HyMTHeZFpwaGA2SPrRJCBLF2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NuXoLA8hGTpuZcwe1d/bQQ+71UkfSDP1zkA4ZvGvn8Qfglj8gwm9Tk4D2dWycilGSOQ7Lc8R8u6qMYhSBFJtFnBkpFlmaA0ZtdHTFcVHHzCuZ+q6erqjQJqxaAwNUkNonhkUDfOUlLYky6f/PR6SyeMnTKtnF3+ki6QjzWEbpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BK0zt5cW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XdaizBi98DFTwWY2B+T44w2OJyQ1IyzYlnWIk666EJ4=; t=1746553627; x=1747763227; 
	b=BK0zt5cW7u6ouummVHjuCq2+/JkjUYZjWLg3sv+iRAgY72RtFrlyJdg8HZM3A9zMMe4sIpd4fzU
	tc937jUFJmoJsM6WAB23myFBPZvPT6H5FUusW654EA/VcyQaAd16BgKLYRpdapYa0zGlHzo8GDLg8
	9EVLXTCDptbvzzyv9UHdyHDAA9kHNpu6UZBuGj5NSNXBb2JCOknkspq2kbjWyMed6/pJReWIR8dyd
	Bpa0xFmjUAhGiYkVfYXrt1QRApR1UVobOHBTFuPEidgX3fVjnDsWQgVlEt5fbZM5tmvnh+GBRjHym
	aYLevmdYzA6Sd3STlV9ppNELczA143uBllwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCMNe-00000006GAW-44mq;
	Tue, 06 May 2025 19:46:59 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-05-06
Date: Tue,  6 May 2025 19:45:31 +0200
Message-ID: <20250506174656.119970-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
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

Here's another set of patches for -next, but I know there's
more coming, especially from iwlwifi.

There are some conflicts here in iwlwifi, please just take
the wireless-next version for them.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit b5c6891b2c5b54bf58069966296917da46cda6f2:

  Merge tag 'net-6.15-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-17 11:45:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-05-06

for you to fetch changes up to 885e5cbaa0ee3738fcd99167439459ede2cc102c:

  Revert "wifi: iwlwifi: clean up config macro" (2025-04-25 11:59:54 +0200)

----------------------------------------------------------------
wireless features, notably
 * stack
   - free SKBTX_WIFI_STATUS flag
   - fixes for VLAN multicast in multi-link
   - improve codel parameters (revert some old twiddling)
 * ath12k
   - Enable AHB support for IPQ5332.
   - Add monitor interface support to QCN9274.
   - Add MLO support to WCN7850.
   - Add 802.11d scan offload support to WCN7850.
 * ath11k
   - Restore hibernation support
 * iwlwifi
   - EMLSR on two 5 GHz links
 * mwifiex
   - cleanups/refactoring

along with many other small features/cleanups

----------------------------------------------------------------
Aaradhana Sahu (2):
      wifi: ath12k: Resolve multicast packet drop by populating key_cipher in ath12k_install_key()
      wifi: ath12k: Introduce check against zero for ahvif->key_cipher in ath12k_mac_op_tx()

Aditya Kumar Singh (13):
      wifi: ath12k: move firmware stats out of debugfs
      wifi: ath12k: add get_txpower mac ops
      wifi: ath12k: fix SLUB BUG - Object already free in ath12k_reg_free()
      wifi: ath12k: add reference counting for core attachment to hardware group
      wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping
      wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag handling
      wifi: ath12k: fix firmware assert during reboot with hardware grouping
      wifi: ath12k: fix ath12k_core_pre_reconfigure_recovery() with grouping
      wifi: ath12k: handle ath12k_core_restart() with hardware grouping
      wifi: ath12k: handle ath12k_core_reset() with hardware grouping
      wifi: ath12k: reset MLO global memory during recovery
      wifi: ath12k: Fix frequency range in driver
      wifi: ath12k: Update frequency range if reg rules changes

Anjaneyulu (1):
      wifi: iwlwifi: parse active and 20 MHz AP NVM channel flag

Balamurugan Mahalingam (1):
      wifi: ath12k: Add support for link specific datapath stats

Balamurugan S (7):
      wifi: ath12k: fix incorrect CE addresses
      wifi: ath12k: add ath12k_hw_params for IPQ5332
      wifi: ath12k: avoid m3 firmware download in AHB device IPQ5332
      wifi: ath12k: Add hw_params to remap CE register space for IPQ5332
      wifi: ath12k: add AHB driver support for IPQ5332
      wifi: ath12k: enable ath12k AHB support
      wifi: ath12k: Add support to clear qdesc array in REO cache

Baochen Qiang (16):
      wifi: ath12k: don't put ieee80211_chanctx_conf struct in ath12k_link_vif
      wifi: ath11k: determine PM policy based on machine model
      wifi: ath11k: introduce ath11k_core_continue_suspend_resume()
      wifi: ath11k: refactor ath11k_core_suspend/_resume()
      wifi: ath11k: support non-WoWLAN mode suspend as well
      wifi: ath11k: choose default PM policy for hibernation
      Reapply "wifi: ath11k: restore country code during resume"
      wifi: ath12k: introduce ath12k_fw_feature_supported()
      wifi: ath12k: use fw_features only when it is valid
      wifi: ath12k: support MLO as well if single_chip_mlo_support flag is set
      wifi: ath12k: identify assoc link vif in station mode
      wifi: ath12k: make assoc link associate first
      wifi: ath12k: group REO queue buffer parameters together
      wifi: ath12k: alloc REO queue per station
      wifi: ath12k: don't skip non-primary links for WCN7850
      wifi: ath12k: support 2 channels for single pdev device

Bartosz Golaszewski (1):
      bcma: use new GPIO line value setter callbacks

Bhaskar Chowdhury (1):
      wifi: iwlwifi: fw: api: Absolute rudimentary typo fixes in the file power.h

Dan Carpenter (2):
      wifi: ath12k: Fix a couple NULL vs IS_ERR() bugs
      wifi: ath12k: Fix buffer overflow in debugfs

David Heidelberg (2):
      dt-bindings: net: Add generic wireless controller
      dt-bindings: wireless: qcom,wcnss: Use wireless-controller.yaml

Dmitry Antipov (1):
      wifi: rt2x00: remove weird self-assignment in rt2800_loft_search()

Edward Adam Davis (1):
      wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled

Emmanuel Grumbach (3):
      wifi: iwlwifi: mld: remove stored_beacon support
      wifi: iwlwifi: update the PHY_CONTEXT_CMD API
      wifi: iwlwifi: pcie: add support for the reset handshake in MSI

Gustavo A. R. Silva (2):
      wifi: mac80211: Avoid -Wflex-array-member-not-at-end warnings
      wifi: iwlwifi: mvm: Avoid -Wflex-array-member-not-at-end warning

Hari Chandrakanthan (1):
      wifi: ath12k: fix link valid field initialization in the monitor Rx

Janne Grunau (3):
      dt-bindings: net: Add network-class schema for mac-address properties
      dt-bindings: wireless: bcm4329-fmac: Use wireless-controller.yaml schema
      dt-bindings: wireless: silabs,wfx: Use wireless-controller.yaml

Jeff Johnson (2):
      wifi: ath12k: Fix misspelling "upto" in dp.c
      wifi: ath12k: ahb: Replace del_timer_sync() with timer_delete_sync()

Jiri Slaby (SUSE) (1):
      irqdomain: ssb: Switch to irq_domain_create_linear()

Johan Hovold (1):
      wifi: ath12k: extend dma mask to 36 bits

Johannes Berg (18):
      wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
      wifi: cfg80211/mac80211: remove more 5/10 MHz code
      wifi: iwlwifi: mvm: remove IWL_EMPTYING_HW_QUEUE_DELBA state
      wifi: iwlwifi: fw: do reset handshake during assert if needed
      wifi: iwlwifi: mld: remove P2P powersave tracking
      wifi: iwlwifi: mld: tests: simplify le32 bitfield handling
      Merge tag 'ath-next-20250418' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next
      wifi: iwlwifi: mld: clarify variable type
      wifi: iwlwifi: mld: fix iwl_mld_emlsr_disallowed_with_link() return
      wifi: iwlwifi: mld: use cfg80211_chandef_get_width()
      wifi: iwlwifi: mld: allow EMLSR on separated 5 GHz subbands
      wifi: iwlwifi: define API for external FSEQ images
      wifi: iwlwifi: mld: skip unknown FW channel load values
      wifi: iwlwifi: clean up band in RX metadata
      wifi: iwlwifi: mld: rx: simplify channel handling
      wifi: iwlwifi: mld: simplify iwl_mld_rx_fill_status()
      wifi: iwlwifi: clean up config macro
      Revert "wifi: iwlwifi: clean up config macro"

Julian Vetter (1):
      wifi: mac80211: Replace __get_unaligned_cpu32 in mesh_pathtbl.c

Karthikeyan Kathirvel (1):
      wifi: ieee80211: define beacon protection bit field

Karthikeyan Periyasamy (4):
      wifi: ath12k: Replace band define G with GHZ where appropriate
      wifi: ath12k: fix NULL access in assign channel context handler
      wifi: ath12k: Refactor the monitor channel context procedure
      wifi: ath12k: Move to NO_VIRTUAL monitor

Kees Cook (1):
      wifi: carl9170: Add __nonstring annotations for unterminated strings

Maharaja Kennadyrajan (3):
      wifi: ath12k: Fix spelling errors in mac.c file
      wifi: ath12k: Prevent sending WMI commands to firmware during firmware crash
      wifi: ath12k: fix node corruption in ar->arvifs list

Miri Korenblit (11):
      wifi: iwlwifi: re-add IWL_AMSDU_8K case
      wifi: iwlwifi: mld: avoid memory leak if mcc_init fails
      wifi: iwlwifi: mld: stop hw if mcc_init fails
      wifi: iwlwifi: mld: don't do iwl_trans_stop_device twice
      wifi: iwlwifi: mld: refactor purging async notifications
      wifi: iwlwifi: mld: properly handle async notification in op mode start
      wifi: iwlwifi: mld: inform trans on init failure
      wifi: iwlwifi: set step_urm in transport and not in the opmodes
      wifi: iwlwifi: add definitions for iwl_mac_power_cmd version 2
      wifi: iwlwifi: pcie: make sure to lock rxq->read
      wifi: iwlwifi: move phy_filters to fw_runtime

Muna Sinada (4):
      wifi: ath12k: remove open parenthesis
      wifi: mac80211: Add link iteration macro for link data
      wifi: mac80211: Create separate links for VLAN interfaces
      wifi: mac80211: VLAN traffic in multicast path

Nithyanantham Paramasivam (1):
      wifi: ath12k: Enable REO queue lookup table feature on QCN9274

P Praneesh (17):
      wifi: ath12k: refactor ath12k_hw_regs structure
      wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
      wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
      wifi: ath12k: change the status update in the monitor Rx
      wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
      wifi: ath12k: add monitor interface support on QCN9274
      wifi: ath12k: Fix memory leak during vdev_id mismatch
      wifi: ath12k: Fix memory corruption during MLO multicast tx
      wifi: ath12k: Fix invalid memory access while forming 802.11 header
      wifi: ath12k: add rx_info to capture required field from rx descriptor
      wifi: ath12k: replace the usage of rx desc with rx_info
      wifi: ath12k: Handle error cases during extended skb allocation
      wifi: ath12k: Refactor tx descriptor handling in tx completion handler
      wifi: ath12k: Fix memory leak during extended skb allocation
      wifi: ath12k: Use skb->len for dma_unmap_single() length parameter
      wifi: ath12k: Add MSDU length validation for TKIP MIC error
      wifi: ath12k: Avoid allocating rx_stats when ext_rx_stats is disabled

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: Fix incorrect rates sent to firmware

Raj Kumar Bhagat (3):
      dt-bindings: net: wireless: describe the ath12k AHB module for IPQ5332
      wifi: ath12k: add support for fixed QMI firmware memory
      wifi: ath12k: fix cleanup path after mhi init

Rajat Soni (1):
      wifi: ath12k: Add helper function ath12k_mac_update_freq_range()

Ramasamy Kaliappan (3):
      wifi: ath12k: Fix the QoS control field offset to build QoS header
      wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
      wifi: mac80211: update ML STA with EML capabilities

Rameshkumar Sundaram (5):
      wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers
      wifi: ath12k: avoid multiple skb_cb fetch in ath12k_mac_mgmt_tx_wmi()
      wifi: ieee80211: Add helpers to fetch EMLSR delay and timeout values
      wifi: nl80211: add link id of transmitted profile for MLO MBSSID
      wifi: mac80211: restructure tx profile retrieval for MLO MBSSID

Ramya Gnanasekar (1):
      wifi: ath12k: Fix WMI tag for EHT rate in peer assoc

Rob Herring (Arm) (1):
      wifi: ath11k: Use of_property_present() to test property presence

Sarika Sharma (3):
      wifi: ath12k: using msdu end descriptor to check for rx multicast packets
      wifi: ath12k: correctly handle mcast packets for clients
      wifi: ath12k: fix invalid access to memory

Sascha Hauer (13):
      wifi: mwifiex: deduplicate code in mwifiex_cmd_tx_rate_cfg()
      wifi: mwifiex: use adapter as context pointer for mwifiex_hs_activated_event()
      wifi: mwifiex: drop unnecessary initialization
      wifi: mwifiex: make region_code_mapping_t const
      wifi: mwifiex: pass adapter to mwifiex_dnld_cmd_to_fw()
      wifi: mwifiex: simplify mwifiex_setup_ht_caps()
      wifi: mwifiex: fix indention
      wifi: mwifiex: make locally used function static
      wifi: mwifiex: move common settings out of switch/case
      wifi: mwifiex: remove unnecessary queue empty check
      wifi: mwifiex: let mwifiex_init_fw() return 0 for success
      wifi: mwifiex: drop asynchronous init waiting code
      wifi: mwifiex: remove mwifiex_sta_init_cmd() last argument

Sidhanta Sahu (1):
      wifi: ath12k: Fix memory leak due to multiple rx_stats allocation

Simon Horman (1):
      wifi: brcmsmac: Spelling corrections

Sowmiya Sree Elavalagan (4):
      wifi: ath12k: Power up root PD
      wifi: ath12k: Register various userPD interrupts and save SMEM entries
      wifi: ath12k: Power up userPD
      wifi: ath12k: Power down userPD

Sriram R (2):
      wifi: ath12k: Pass correct values of center freq1 and center freq2 for 320 MHz
      wifi: ath12k: Fix the enabling of REO queue lookup table feature

Stone Zhang (1):
      wifi: ath11k: fix node corruption in ar->arvifs list

Suraj P Kizhakkethil (1):
      wifi: ath12k: Pass correct values of center freq1 and center freq2 for 160 MHz

Thomas Weißschuh (5):
      wifi: ath10k: Don't use %pK through printk
      wifi: ath11k: Don't use %pK through printk
      wifi: ath12k: Don't use %pK through printk
      wifi: wcn36xx: Don't use %pK through printk
      wifi: mwifiex: Don't use %pK through printk

Thomas Wu (1):
      wifi: ath12k: Disable broadcast TWT feature in HE MAC capabilities

Toke Høiland-Jørgensen (1):
      Revert "mac80211: Dynamically set CoDel parameters per station"

Víctor Gonzalo (1):
      wifi: iwlwifi: Add missing MODULE_FIRMWARE for Qu-c0-jf-b0

Wen Gong (5):
      wifi: ath12k: add configure country code for WCN7850
      wifi: ath12k: use correct WMI command to set country code for WCN7850
      wifi: ath12k: add 11d scan offload support
      wifi: ath12k: store and send country code to firmware after recovery
      wifi: ath12k: avoid deadlock during regulatory update in ath12k_regd_update()

Wentao Liang (1):
      wifi: brcm80211: fmac: Add error log in brcmf_usb_dl_cmd()

Yang Li (1):
      wifi: iwlwifi: mvm: Remove duplicated include in iwl-utils.c

 .../bindings/net/ethernet-controller.yaml          |   25 +-
 .../devicetree/bindings/net/network-class.yaml     |   46 +
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    2 +-
 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  315 ++++++
 .../bindings/net/wireless/silabs,wfx.yaml          |    5 +-
 .../bindings/net/wireless/wireless-controller.yaml |   23 +
 .../devicetree/bindings/soc/qcom/qcom,wcnss.yaml   |    5 +-
 drivers/bcma/driver_gpio.c                         |    8 +-
 drivers/net/wireless/ath/ath10k/ahb.c              |    2 +-
 drivers/net/wireless/ath/ath10k/bmi.c              |    6 +-
 drivers/net/wireless/ath/ath10k/ce.c               |    4 +-
 drivers/net/wireless/ath/ath10k/core.c             |    4 +-
 drivers/net/wireless/ath/ath10k/htc.c              |    6 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    2 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   22 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    2 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |    4 +-
 drivers/net/wireless/ath/ath10k/txrx.c             |    2 +-
 drivers/net/wireless/ath/ath10k/usb.c              |    4 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |    4 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |    4 +-
 drivers/net/wireless/ath/ath11k/core.c             |  306 +++++-
 drivers/net/wireless/ath/ath11k/core.h             |   16 +
 drivers/net/wireless/ath/ath11k/hif.h              |   14 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   10 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |   14 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |    4 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   50 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    4 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    2 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |    8 +
 drivers/net/wireless/ath/ath12k/Makefile           |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c              | 1156 ++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h              |   80 ++
 drivers/net/wireless/ath/ath12k/ce.c               |   92 +-
 drivers/net/wireless/ath/ath12k/ce.h               |   18 +-
 drivers/net/wireless/ath/ath12k/core.c             |  292 ++++-
 drivers/net/wireless/ath/ath12k/core.h             |   97 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |  234 ++--
 drivers/net/wireless/ath/ath12k/debugfs.h          |   12 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |    3 +
 drivers/net/wireless/ath/ath12k/dp.c               |   88 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   25 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  377 +++++--
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  424 ++++---
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   33 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  147 ++-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    3 +-
 drivers/net/wireless/ath/ath12k/fw.c               |    9 +-
 drivers/net/wireless/ath/ath12k/fw.h               |    3 +-
 drivers/net/wireless/ath/ath12k/hal.c              |  111 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   76 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |    6 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   19 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   15 +-
 drivers/net/wireless/ath/ath12k/hw.c               |  499 ++++++++-
 drivers/net/wireless/ath/ath12k/hw.h               |   29 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  817 +++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h              |   13 +
 drivers/net/wireless/ath/ath12k/mhi.c              |    9 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   58 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    5 +-
 drivers/net/wireless/ath/ath12k/peer.c             |    5 +-
 drivers/net/wireless/ath/ath12k/peer.h             |    3 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  238 +++-
 drivers/net/wireless/ath/ath12k/qmi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/reg.c              |  177 ++-
 drivers/net/wireless/ath/ath12k/reg.h              |    2 +-
 drivers/net/wireless/ath/ath12k/testmode.c         |    4 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  329 +++++-
 drivers/net/wireless/ath/ath12k/wmi.h              |   55 +-
 drivers/net/wireless/ath/carl9170/fw.c             |    2 +-
 drivers/net/wireless/ath/wcn36xx/testmode.c        |    2 +-
 drivers/net/wireless/ath/wil6210/txrx.h            |    3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   23 +-
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.c |    6 +-
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.h |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |    4 +-
 .../wireless/broadcom/brcm80211/brcmsmac/channel.c |    4 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    4 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |    4 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.h    |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/pmu.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |    3 +
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    8 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   15 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   15 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   28 +
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    6 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |   17 +-
 .../net/wireless/intel/iwlwifi/iwl-context-info.h  |   10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |   20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   36 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-utils.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   48 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |    5 -
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |    9 -
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   25 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |    5 -
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   35 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   51 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   97 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |   14 +-
 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    4 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   14 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   21 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   14 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   23 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |    6 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   42 +-
 drivers/net/wireless/marvell/mwifiex/cfp.c         |    4 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |   74 +-
 drivers/net/wireless/marvell/mwifiex/init.c        |   21 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |   43 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |   13 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |    2 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |   51 +-
 drivers/net/wireless/marvell/mwifiex/txrx.c        |    3 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |   20 +-
 drivers/net/wireless/marvell/mwifiex/wmm.c         |   12 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   12 +-
 drivers/ssb/driver_gpio.c                          |    8 +-
 include/linux/ieee80211.h                          |   77 ++
 include/linux/skbuff.h                             |    3 -
 include/net/cfg80211.h                             |   44 +-
 include/net/mac80211.h                             |   25 +-
 include/net/sock.h                                 |    2 -
 include/uapi/linux/nl80211.h                       |    6 +
 net/mac80211/cfg.c                                 |   67 +-
 net/mac80211/chan.c                                |    3 +
 net/mac80211/debugfs_sta.c                         |    6 -
 net/mac80211/ibss.c                                |   19 +-
 net/mac80211/ieee80211_i.h                         |   16 +-
 net/mac80211/iface.c                               |   87 +-
 net/mac80211/link.c                                |   90 +-
 net/mac80211/mesh.c                                |   10 +-
 net/mac80211/mesh_pathtbl.c                        |    2 +-
 net/mac80211/mesh_plink.c                          |   10 +-
 net/mac80211/mlme.c                                |    4 +-
 net/mac80211/parse.c                               |    3 -
 net/mac80211/rate.c                                |   12 +-
 net/mac80211/rc80211_minstrel_ht.c                 |   13 +-
 net/mac80211/spectmgmt.c                           |   55 +-
 net/mac80211/sta_info.c                            |   28 -
 net/mac80211/sta_info.h                            |   11 -
 net/mac80211/tdls.c                                |    4 +-
 net/mac80211/tx.c                                  |   35 +-
 net/mac80211/util.c                                |   25 +-
 net/wireless/nl80211.c                             |   42 +-
 165 files changed, 6279 insertions(+), 1913 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/network-class.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/wireless-controller.yaml
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h

