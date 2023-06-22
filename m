Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CAF73A8B4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjFVTAG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 15:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjFVTAC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 15:00:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DA82132;
        Thu, 22 Jun 2023 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=RBjnq2oOvnUS/NwT/+y23MLbYJIvoF63UNbVBEn+fK4=; t=1687460396; x=1688669996; 
        b=RD5KfJ3KnZ49OhnXvKywy7Kyzm5Ik1SdXUgJvl1WAWtkPeDJES1lpnNcaBSqz3LR+9ZExJbHQ2A
        QupewhAfmDKXKVfaTHXQcCG4pP9AwMaYs6rb4EsscCgmiSElHtoBtmYimEIxvziiN62WC7dWPI9VL
        yNXOfKSHvUngoVdAJoQ2x6gxmezy1A7JENmpmFapbX+InS576Mq2m9TcwJnJ2Z+WwDa4ur+2qv9QT
        TNvql5/qvVUE5QnClwhbsUpyn2Zk4oPUXWqtoAeCKN2bjvV4pq5Um2kxCXxoo6kBh0vIPThPhrf8s
        l3j3l97BLh0SV8ICNG0eYgwWkae0eC219Oxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qCPX7-00EsBg-1d;
        Thu, 22 Jun 2023 20:59:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: wireless-next-2023-06-22
Date:   Thu, 22 Jun 2023 20:56:03 +0200
Message-ID: <20230622185602.147650-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Here's another set of updates for -next, almost certainly
the last as we go off into the vacation period soon. Have
a great summer, and already thanks for all the help!

Please pull and let me know if there's any problem. I'll
likely be around a little bit at times if needed.

Thanks,
johannes



The following changes since commit f1a0898b5d6a77d332d036da03bad6fa9770de5b:

  wifi: iwlwifi: mvm: spin_lock_bh() to fix lockdep regression (2023-06-14 09:05:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2023-06-22

for you to fetch changes up to 31b5a547622b3782388eb676081da1eefe5b98d2:

  wifi: ieee80211: fix erroneous NSTR bitmap size checks (2023-06-22 19:52:09 +0200)

----------------------------------------------------------------
Notable changes this time around:

MAINTAINERS
 * add missing driver git trees

ath11k
 * factory test mode support

iwlwifi
 * config rework to drop test devices and
   split the different families
 * major update for new firmware and MLO

stack
 * initial multi-link reconfiguration suppor
 * multi-BSSID and MLO improvements

other
 * fix the last few W=1 warnings from GCC 13
 * merged wireless tree to avoid conflicts

----------------------------------------------------------------
Abhishek Naik (3):
      wifi: iwlwifi: update response for mcc_update command
      wifi: mac80211: handle TDLS data frames with MLO
      wifi: mac80211: Add HE and EHT capa elements in TDLS frames

Alon Giladi (3):
      wifi: iwlwifi: debugfs: add ppag capa to fw info file
      wifi: iwlwifi: improve debug prints in iwl_read_ppag_table()
      wifi: mac80211: drop unprotected robust mgmt before 4-way-HS

Anjaneyulu (6):
      wifi: mac80211: pass roc->sdata to drv_cancel_remain_on_channel()
      wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()
      wifi: iwlwifi: mvm: Validate tid is in valid range before using it
      wifi: iwlwifi: Validate slots_num before allocating memory
      wifi: iwlwifi: add a few rate index validity checks
      wifi: mac80211: add consistency check for compat chandef

Ariel Malamud (2):
      wifi: iwlwifi: mvm: Refactor iwl_mvm_get_lmac_id()
      wifi: iwlwifi: fw: Add new FSEQ defines to fw dump

Arnd Bergmann (1):
      wifi: ath10k: improve structure padding

Avraham Stern (2):
      wifi: iwlwifi: mvm: FTM initiator MLO support
      wifi: iwlwifi: mvm: FTM responder MLO support

Azeem Shaikh (3):
      wifi: cfg80211: replace strlcpy() with strscpy()
      wifi: mac80211: Replace strlcpy with strscpy
      wifi: mt7601u: replace strlcpy() with strscpy()

Balamurugan S (1):
      wifi: ath12k: Avoid NULL pointer access during management transmit cleanup

Baochen Qiang (1):
      wifi: ath12k: Use msdu_end to check MCBC

Ben Greear (1):
      wifi: mac80211: add eht_capa debugfs field

Benjamin Berg (27):
      wifi: mac80211: fix CSA processing while scanning
      wifi: iwlwifi: make debugfs entries link specific
      wifi: mac80211: stop passing cbss to parser
      wifi: cfg80211: move regulatory_hint_found_beacon to be earlier
      wifi: cfg80211: keep bss_lock held when informing
      wifi: cfg80211: add inform_bss op to update BSS
      wifi: mac80211: use new inform_bss callback
      wifi: cfg80211: ignore invalid TBTT info field types
      wifi: cfg80211: rewrite merging of inherited elements
      wifi: cfg80211: drop incorrect nontransmitted BSS update code
      wifi: cfg80211: add element defragmentation helper
      wifi: mac80211: use cfg80211 defragmentation helper
      wifi: ieee80211: add helper to validate ML element type and size
      wifi: ieee80211: use default for medium synchronization delay
      wifi: cfg80211: Always ignore ML element
      wifi: ieee80211: add definitions for RNR MLD params
      wifi: cfg80211: use a struct for inform_single_bss data
      wifi: ieee80211: add structs for TBTT information access
      wifi: cfg80211: use structs for TBTT information access
      wifi: cfg80211: handle BSS data contained in ML probe responses
      wifi: cfg80211: do not scan disabled links on 6GHz
      wifi: mac80211: add ___ieee80211_disconnect variant not locking sdata
      wifi: mac80211: add set_active_links variant not locking sdata
      wifi: cfg80211: stop parsing after allocation failure
      wifi: cfg80211: search all RNR elements for colocated APs
      wifi: mac80211: avoid lockdep checking when removing deflink
      wifi: iwlwifi: mvm: send LARI configuration earlier

Carl Huang (1):
      wifi: ath12k: check hardware major version for WCN7850

Chih-Kang Chang (1):
      wifi: rtw88: process VO packets without workqueue to avoid PTK rekey failed

Christian Lamparter (1):
      dt-bindings: net: wireless: ath10k: add ieee80211-freq-limit property

Deming Wang (1):
      wifi: rt2x00: fix the typo in comments

Dmitry Antipov (7):
      wifi: rtw89: cleanup private data structures
      wifi: rtw89: cleanup rtw89_iqk_info and related code
      wifi: rtw89: fix spelling typo of IQK debug messages
      wifi: iwlwifi: dvm: fix -Wunused-const-variable gcc warning
      wifi: ath9k: convert msecs to jiffies where needed
      wifi: rtlwifi: simplify LED management
      wifi: rtlwifi: cleanup USB interface

Emmanuel Grumbach (5):
      wifi: iwlwifi: pass ESR parameters to the firmware
      wifi: iwlwifi: mvm: allow ADD_STA not to be advertised by the firwmare
      wifi: mac80211: feed the link_id to cfg80211_ch_switch_started_notify
      wifi: iwlwifi: mvm: check the right csa_active
      wifi: iwlwifi: mvm: make iwl_mvm_set_fw_mu_edca_params mld aware

Fedor Pchelkin (1):
      wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Gilad Itzkovitch (1):
      wifi: cfg80211: S1G rate information and calculations

Govindaraj Saminathan (2):
      wifi: ath11k: remove unused function ath11k_tm_event_wmi()
      wifi: ath11k: factory test mode support

Gregory Greenman (5):
      wifi: iwlwifi: bump FW API to 79 for AX devices
      wifi: iwlwifi: mvm: add support for Extra EHT LTF
      wifi: iwlwifi: mvm: fix potential array out of bounds access
      wifi: iwlwifi: bump FW API to 81 for AX devices
      wifi: iwlwifi: bump FW API to 83 for AX/BZ/SC devices

Gustavo A. R. Silva (3):
      wifi: wil6210: fw: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
      wifi: wil6210: wmi: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Haim Dreyfuss (1):
      wifi: iwlwifi: mvm: rename BTM support flag and its TLV

Hari Chandrakanthan (1):
      wifi: ath12k: delete the timer rx_replenish_retry during rmmod

Ilan Peer (19):
      wifi: mac80211: Add getter functions for vif MLD state
      wifi: mac80211_hwsim: Don't access vif valid links directly
      wifi: cfg80211: Support association to AP MLD with disabled links
      wifi: mac80211: Do not use "non-MLD AP" syntax
      wifi: mac80211: Fix permissions for valid_links debugfs entry
      wifi: iwlwifi: mvm: Propagate ERP slot changes to FW
      wifi: mac80211: Support disabled links during association
      wifi: mac80211: Add debugfs entry to report dormant links
      wifi: iwlwifi: Correctly indicate support for VHT TX STBC
      wifi: iwlwifi: mvm: Don't access vif valid links directly
      wifi: iwlwifi: mvm: Add support for SCAN API version 16
      wifi: mac80211: Rename multi_link
      wifi: mac80211: Add support for parsing Reconfiguration Multi Link element
      wifi: mac80211: Rename ieee80211_mle_sta_prof_size_ok()
      wifi: mac80211: Include Multi-Link in CRC calculation
      wifi: ieee80211: Fix the common size calculation for reconfiguration ML
      wifi: mac80211: Support link removal using Reconfiguration ML element
      wifi: cfg80211: Retrieve PSD information from RNR AP information
      wifi: iwlwifi: mvm: Add support for scan version 17

Jiasheng Jiang (1):
      wifi: ath11k: Add missing check for ioremap

Johannes Berg (68):
      wifi: mac80211: add helpers to access sband iftype data
      wifi: mac80211: include key action/command in tracing
      wifi: mac80211: mlme: clarify WMM messages
      wifi: mac80211: don't update rx_stats.last_rate for NDP
      wifi: iwlwifi: unify checks for HW error values
      wifi: iwlwifi: mvm: always set MH len in offload_assist
      wifi: iwlwifi: mvm: support U-SIG EHT validate checks
      wifi: iwlwifi: mvm: put only a single IGTK into FW
      wifi: iwlwifi: dbg-tlv: fix DRAM data init
      wifi: iwlwifi: pcie: clear FW debug memory on init
      wifi: iwlwifi: pcie: remove redundant argument
      wifi: iwlwifi: dbg-tlv: clear FW debug memory on init
      Merge wireless into wireless-next
      wifi: iwlwifi: mvm: remove new checksum code
      wifi: iwlwifi: mvm: correctly access HE/EHT sband capa
      wifi: iwlwifi: fw: make some ACPI functions static
      wifi: iwlwifi: mvm: use iwl_mvm_is_vendor_in_approved_list()
      wifi: iwlwifi: pull from TXQs with softirqs disabled
      wifi: iwlwifi: pcie: double-check ACK interrupt after timeout
      wifi: iwlwifi: mvm: add a NULL pointer check
      wifi: iwlwifi: mvm: check link during TX
      wifi: iwlwifi: mvm: store WMM params per link
      wifi: iwlwifi: use array as array argument
      wifi: iwlwifi: mvm: always send spec link ID in link commands
      wifi: iwlwifi: add some FW misbehaviour check infrastructure
      wifi: iwlwifi: implement WPFC ACPI table loading
      wifi: iwlwifi: mvm: track u-APSD misbehaving AP by AP address
      wifi: cfg80211: fix regulatory disconnect for non-MLO
      wifi: cfg80211: fix regulatory disconnect with OCB/NAN
      wifi: ieee80211: reorder presence checks in MLE per-STA profile
      wifi: mac80211: agg-tx: add a few locking assertions
      wifi: mac80211: agg-tx: prevent start/stop race
      wifi: update multi-link element STA reconfig
      wifi: mac80211: check EHT basic MCS/NSS set
      wifi: mac80211: fix documentation config reference
      wifi: mac80211: move action length check up
      wifi: mac80211: drop some unprotected action frames
      wifi: mac80211: store BSS param change count from assoc response
      wifi: mac80211: always hold sdata lock in chanctx assign/unassign
      wifi: mac80211: fix CRC calculation for extended elems
      wifi: nl80211/reg: add no-EHT regulatory flag
      wifi: iwlwifi: pcie: refactor RB status size calculation
      wifi: iwlwifi: pcie: add size assertions
      wifi: iwlwifi: nvm: handle EHT/320 MHz regulatory flag
      wifi: iwlwifi: mvm: use EHT maximum MPDU length on 2.4 GHz
      wifi: iwlwifi: mvm: use min_t() for agg_size
      wifi: iwlwifi: mvm: add EHT A-MPDU size exponent support
      wifi: iwlwifi: limit EHT capabilities based on PCIe link speed
      wifi: iwlwifi: remove disable_dummy_notification
      wifi: iwlwifi: mvm: support new flush_sta method
      wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection
      wifi: iwlwifi: mvm: avoid baid size integer overflow
      wifi: iwlwifi: mvm: check only affected links
      wifi: iwlwifi: mvm: adjust skip-over-dtim in D3
      wifi: iwlwifi: split 22000.c into multiple files
      wifi: iwlwifi: give Sc devices their own family
      wifi: iwlwifi: don't load old firmware for Sc
      wifi: iwlwifi: don't load old firmware for Bz
      wifi: iwlwifi: don't load old firmware for ax210
      wifi: iwlwifi: don't load old firmware for 22000
      wifi: iwlwifi: remove support for *nJ devices
      wifi: iwlwifi: pcie: also drop jacket from info macro
      wifi: iwlwifi: unify Bz/Gl device configurations
      wifi: iwlwifi: also unify Sc device configurations
      wifi: iwlwifi: also unify Ma device configurations
      wifi: iwlwifi: cfg: remove trailing dash from FW_PRE constants
      wifi: iwlwifi: cfg: clean up Bz module firmware lines
      wifi: ieee80211: fix erroneous NSTR bitmap size checks

Juerg Haefliger (1):
      wifi: p54: Add missing MODULE_FIRMWARE macro

Kalle Valo (23):
      wifi: ath11k: debug: remove unused ATH11K_DBG_ANY
      wifi: ath11k: print debug level in debug messages
      wifi: ath11k: remove manual mask names from debug messages
      wifi: ath11k: add WMI event debug messages
      wifi: ath11k: remove unsupported event handlers
      wifi: ath11k: wmi: cleanup error handling in ath11k_wmi_send_init_country_cmd()
      wifi: ath11k: wmi: use common error handling style
      wifi: ath11k: wmi: add unified command debug messages
      wifi: ath11k: pci: cleanup debug logging
      wifi: ath11k: dp: cleanup debug message
      wifi: ath11k: debug: use all upper case in ATH11k_DBG_HAL
      wifi: ath11k: hal: cleanup debug message
      wifi: ath11k: don't use %pK
      wifi: ath11k: htc: cleanup debug messages
      wifi: ath11k: debug: add ATH11K_DBG_CE
      wifi: brcmfmac: fix gnu_printf warnings
      wifi: brcmsmac: fix gnu_printf warnings
      wifi: hostap: fix stringop-truncations GCC warning
      wifi: ray_cs: fix stringop-truncation GCC warning
      MAINTAINERS: mt76: add git tree
      MAINTAINERS: ath9k: add git tree
      MAINTAINERS: ath11k: add wiki and bugreport page
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

Miri Korenblit (4):
      wifi: mac80211: allow disabling SMPS debugfs controls
      wifi: iwlwifi: fix max number of fw active links
      wifi: iwlwifi: handle eSR transitions
      wifi: iwlwifi: fw: send marker cmd before suspend cmd

Mukesh Sisodiya (13):
      wifi: iwlwifi: mvm: Handle return value for iwl_mvm_sta_init
      wifi: iwlwifi: mvm: fix getting LDPC/STBC support
      wifi: iwlwifi: fw: print PC register value instead of address
      wifi: iwlwifi: mvm: initialize the rx_vec before using it
      wifi: iwlwifi: support version C0 of BZ and GL devices
      wifi: iwlwifi: mvm: Add NULL check before dereferencing the pointer
      wifi: cfg80211: make TDLS management link-aware
      wifi: mac80211: handle TDLS negotiation with MLO
      wifi: mac80211: Extend AID element addition for TDLS frames
      wifi: iwlwifi: Add support for new PCI Id
      wifi: iwlwifi: Add support for new Bz version
      wifi: iwlwifi: Add support for new CNVi (SC)
      wifi: iwlwifi: remove support of A0 version of FM RF

Nicolas Cavallari (1):
      wifi: mac80211: Remove "Missing iftype sband data/EHT cap" spam

Nidhi Jain (1):
      wifi: ath11k: Add HTT stats for PHY reset case

P Praneesh (2):
      wifi: ath12k: Add support to parse new WMI event for 6 GHz regulatory
      wifi: ath11k: fix memory leak in WMI firmware stats

Ping-Ke Shih (6):
      wifi: rtw88: add missing unwind goto for __rtw_download_firmware()
      wifi: rtw89: 8851b: update RF radio A parameters to R28
      wifi: rtw89: 8851b: rfk: add LCK track
      wifi: rtw89: 8851b: rfk: update IQK to version 0x8
      wifi: rtw89: 8851b: configure to force 1 TX power value
      wifi: rtw89: use struct to parse firmware header

Po-Hao Huang (7):
      wifi: rtw88: Fix action frame transmission fail before association
      wifi: rtw88: use struct instead of macros to set TX desc
      wifi: rtw88: Fix AP mode incorrect DTIM behavior
      wifi: rtw88: Skip high queue in hci_flush
      wifi: rtw88: Stop high queue during scan
      wifi: rtw88: refine register based H2C command
      wifi: rtw88: fix not entering PS mode after AP stops

Remi Pommarel (1):
      wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Sowmiya Sree Elavalagan (1):
      wifi: ath11k: Allow ath11k to boot without caldata in ftm mode

Uwe Kleine-König (4):
      wifi: ath10k: Drop cleaning of driver data from probe error path and remove
      wifi: ath10k: Drop checks that are always false
      wifi: ath10k: Convert to platform remove callback returning void
      wifi: atk10k: Don't opencode ath10k_pci_priv() in ath10k_ahb_priv()

Veerendranath Jakkam (1):
      wifi: cfg80211/nl80211: Add support to indicate STA MLD setup links removal

Venkateswara Naralasetty (1):
      wifi: ath11k: update proper pdev/vdev id for testmode command

Wen Gong (2):
      wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855
      wifi: ath12k: fix conf_mutex in ath12k_mac_op_unassign_vif_chanctx()

Yedidya Benshimol (4):
      wifi: mac80211: mark keys as uploaded when added by the driver
      wifi: iwlwifi: mvm: Refactor security key update after D3
      wifi: iwlwifi: mvm: update two most recent GTKs on D3 resume flow
      wifi: iwlwifi: mvm: Add support for IGTK in D3 resume flow

Yi Kuo (1):
      wifi: iwlwifi: pcie: add device id 51F1 for killer 1675

Youghandhar Chintala (1):
      wifi: ath10k: Trigger STA disconnect after reconfig complete on hardware restart

Ziyang Huang (3):
      wifi: ath11k: Add missing ops config for IPQ5018 in ath11k_ahb_probe()
      wifi: ath11k: Restart firmware after cold boot calibration for IPQ5018
      wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018

Zong-Zhe Yang (2):
      wifi: rtw89: 8851b: update TX power tables to R28
      wifi: rtw89: TX power stuffs replace confusing naming of _max with _num

 .../bindings/net/wireless/qcom,ath10k.yaml         |    4 +
 MAINTAINERS                                        |    4 +
 drivers/net/wireless/ath/ath10k/ahb.c              |   20 +-
 drivers/net/wireless/ath/ath10k/core.c             |    9 -
 drivers/net/wireless/ath/ath10k/htt.h              |    6 +-
 drivers/net/wireless/ath/ath10k/mac.c              |    7 +
 drivers/net/wireless/ath/ath10k/snoc.c             |    8 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |    8 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    4 +-
 drivers/net/wireless/ath/ath11k/core.c             |   89 +-
 drivers/net/wireless/ath/ath11k/core.h             |   16 +-
 drivers/net/wireless/ath/ath11k/debug.c            |    2 +-
 drivers/net/wireless/ath/ath11k/debug.h            |   49 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |  114 ++
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |   43 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    8 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   12 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   10 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |   24 +-
 drivers/net/wireless/ath/ath11k/htc.c              |   42 +-
 drivers/net/wireless/ath/ath11k/hw.c               |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  122 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    6 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   25 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |    6 +-
 drivers/net/wireless/ath/ath11k/peer.c             |    4 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   73 +-
 drivers/net/wireless/ath/ath11k/reg.c              |    4 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |  425 ++++++-
 drivers/net/wireless/ath/ath11k/testmode.h         |    6 +-
 drivers/net/wireless/ath/ath11k/testmode_i.h       |   18 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  582 +++++----
 drivers/net/wireless/ath/ath11k/wmi.h              |   22 +
 drivers/net/wireless/ath/ath11k/wow.c              |    3 +-
 drivers/net/wireless/ath/ath12k/core.c             |    1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |    8 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   16 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath12k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   14 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   95 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    8 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |    8 +-
 drivers/net/wireless/ath/ath9k/main.c              |   11 +-
 drivers/net/wireless/ath/wil6210/fw.h              |    4 +-
 drivers/net/wireless/ath/wil6210/wmi.h             |    2 +-
 .../broadcom/brcm80211/brcmfmac/tracepoint.h       |    7 +
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h  |    8 +
 drivers/net/wireless/intel/iwlwifi/Makefile        |    1 +
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c      |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c      |   18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |  846 +------------
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c      |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c      |   18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c      |   22 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |  301 +++++
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  183 +++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |  166 +++
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c        |   43 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  101 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   43 +-
 .../net/wireless/intel/iwlwifi/fw/api/binding.h    |    8 -
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h |   15 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |    8 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   35 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   41 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   13 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   60 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |   18 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   33 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   15 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h       |   24 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   69 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   51 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   75 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  143 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    9 +
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c   |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  430 ++++---
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  204 +++-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   48 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   58 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   31 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   76 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |   74 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   16 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  171 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   74 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   63 +-
 .../net/wireless/intel/iwlwifi/mvm/offloading.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   56 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   77 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |   11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   42 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  163 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   40 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    9 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   91 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  517 ++------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   31 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   13 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   18 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |   12 +-
 .../net/wireless/intersil/hostap/hostap_ioctl.c    |    2 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |    1 +
 drivers/net/wireless/legacy/ray_cs.c               |    2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    8 +-
 drivers/net/wireless/mediatek/mt7601u/trace.h      |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |   10 +
 drivers/net/wireless/realtek/rtlwifi/core.h        |    2 +
 drivers/net/wireless/realtek/rtlwifi/pci.c         |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/led.c   |   40 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/led.h   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/led.c   |   41 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/led.h   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/led.c   |   56 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/led.h   |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    2 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/led.c   |   42 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/led.h   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/led.c   |   40 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/led.h   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192se/hw.c    |   10 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/led.c   |   42 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/led.h   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/led.c   |   42 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/led.h   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/led.c   |   42 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/led.h   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   14 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/led.c   |   60 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/led.h   |    9 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   34 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   16 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |   68 ++
 drivers/net/wireless/realtek/rtw88/fw.h            |   13 +
 drivers/net/wireless/realtek/rtw88/mac.c           |    6 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    9 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   15 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    1 +
 drivers/net/wireless/realtek/rtw88/pci.c           |    5 +-
 drivers/net/wireless/realtek/rtw88/ps.c            |    3 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |   94 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |  124 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   15 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   84 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |   56 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   97 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |    6 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |   44 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   23 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    5 +
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  184 ++-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h  |    2 +
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |  252 ++--
 .../net/wireless/realtek/rtw89/rtw8851b_table.h    |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    1 -
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |   36 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h  |    1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |    8 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.c    |    2 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.h    |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |   11 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    |    2 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.h    |    2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    5 +-
 include/linux/ieee80211.h                          |  252 +++-
 include/net/cfg80211.h                             |   80 +-
 include/net/ieee80211_radiotap.h                   |    2 +
 include/net/mac80211.h                             |   83 +-
 include/net/regulatory.h                           |   13 +-
 include/uapi/linux/nl80211.h                       |   30 +-
 net/mac80211/agg-tx.c                              |   14 +-
 net/mac80211/cfg.c                                 |   25 +-
 net/mac80211/chan.c                                |    5 +
 net/mac80211/debug.h                               |    8 +-
 net/mac80211/debugfs_netdev.c                      |   21 +-
 net/mac80211/debugfs_sta.c                         |  185 +++
 net/mac80211/eht.c                                 |    5 +-
 net/mac80211/he.c                                  |    3 +-
 net/mac80211/ieee80211_i.h                         |   36 +-
 net/mac80211/iface.c                               |   11 +-
 net/mac80211/key.c                                 |    8 +-
 net/mac80211/link.c                                |   55 +-
 net/mac80211/mlme.c                                |  436 +++++--
 net/mac80211/offchannel.c                          |    4 +-
 net/mac80211/rx.c                                  |   45 +-
 net/mac80211/scan.c                                |   93 +-
 net/mac80211/sta_info.c                            |    5 +-
 net/mac80211/tdls.c                                |  272 +++--
 net/mac80211/trace.h                               |   10 +-
 net/mac80211/tx.c                                  |   44 +-
 net/mac80211/util.c                                |  168 ++-
 net/wireless/core.c                                |   16 -
 net/wireless/core.h                                |    1 +
 net/wireless/nl80211.c                             |  113 +-
 net/wireless/rdev-ops.h                            |   27 +-
 net/wireless/reg.c                                 |   20 +-
 net/wireless/scan.c                                | 1283 +++++++++++++-------
 net/wireless/sme.c                                 |   15 +
 net/wireless/trace.h                               |   47 +-
 net/wireless/util.c                                |  110 ++
 net/wireless/wext-core.c                           |    6 +
 243 files changed, 7545 insertions(+), 4678 deletions(-)

