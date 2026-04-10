Return-Path: <linux-wireless+bounces-34567-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAghHfec2GkgfggAu9opvQ
	(envelope-from <linux-wireless+bounces-34567-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:47:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F273D2EC3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6D71300F19E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 06:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630E38B124;
	Fri, 10 Apr 2026 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ac6rA6Te"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4951299929;
	Fri, 10 Apr 2026 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803633; cv=none; b=qbsLauIboy/izEIuUE29fSy5QT/tnGuJA7FdlwIOL62O0WaSzMBl7rnuYNUMrLIDO1zjqjm7pIf4Ej3WsADhGUH3Y2CXbvAiIx7YtAIQYZJsyy+rcqdVjuIJnbgj5fBmB+lc7/CgojeG0dGmnL1K5P4RUbhAldoPdTDV949Yk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803633; c=relaxed/simple;
	bh=qwQvZmNjnak5eSS9pTvUMeSjTOxppy9KRkvW2P79XHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txCG5u398aKn9A6arBDpMfw3NAJVBhimEpk/pmjrWCmbPlNBU+7wVawff0EC1mO2dFLhhKg6b+buIRmHFOOCxppeBkKQ04N1E6LChK/TWJlIwRSEgRx4yDlso49fsGpP0eckZq+AosHXwFBs10lJNQo+R6csNhWXj0SdkULBwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ac6rA6Te; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=BU6g6kKfL3bsWDvMZDyukxert9xZsjq7HbC8FX/kH1E=; t=1775803628; x=1777013228; 
	b=Ac6rA6TeCQbdn1vv0K4Iag+YB0S2iw0GWkniqLXfm0eYK9pf0c6ZGq8/y0IIXRcsDI4Tv27BPv9
	4IlGTM4/oSP69Fk4+YGUmGbaqXJVuMFDM7bzdKCHDOLfbHvatsdRk8j2ZXPhchage+ZLK1J6Nh3IS
	xwzEyumVFJi96I/LMCYrdnNYv+Y/f652OOhua1irIrf03YKw1JkDh3Zt5mxgxiBQfp6lRMIUKOfBV
	TYn6p/0q+T2+IxTrowWzpFXWPvneZTDkzvDU8rTNLsZqcbK3IsOTxYvY6LOA0DplAM8GOL62Vk0tI
	tofSbEttFIJ5OMy45D8F8xG+8WjXoixIQIyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wB5dx-0000000H6DX-36TB;
	Fri, 10 Apr 2026 08:47:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-04-10
Date: Fri, 10 Apr 2026 08:44:33 +0200
Message-ID: <20260410064703.735099-3-johannes@sipsolutions.net>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34567-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24F273D2EC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Final (obviously) pull request for now, the only thing to
note is the crypto changes, FWIW the change touching crypto
was acked by Herbert and he asked me to take it:
https://lore.kernel.org/r/adYNVB3n358xm_s8@gondor.apana.org.au/

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 8ffb33d7709b59ff60560f48960a73bd8a55be95:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-04-02 11:03:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-04-10

for you to fetch changes up to fa489a77e3267e05df95db96ba98e141ec07cbd9:

  wifi: cfg80211: Explicitly include <linux/export.h> in michael-mic.c (2026-04-09 08:54:43 +0200)

----------------------------------------------------------------
Final updates, notably:
 - crypto: move Michael MIC code into wireless (only)
 - mac80211:
   - multi-link 4-addr support
   - NAN data support (but no drivers yet)
 - ath10k: DT quirk to make it work on some devices
 - ath12k: IPQ5424 support
 - rtw89: USB improvements for performance

----------------------------------------------------------------
Alexander Stein (1):
      wifi: brcmfmac: silence warning for non-existent, optional firmware

Alexey Velichayshiy (1):
      wifi: rtw89: phy: fix uninitialized variable access in rtw89_phy_cfo_set_crystal_cap()

Amit Pundir (2):
      dt-bindings: wireless: ath10k: Add quirk to skip host cap QMI requests
      wifi: ath10k: Add device-tree quirk to skip host cap QMI requests

Avraham Stern (1):
      wifi: mac80211: allow add_key on NAN interfaces

Avula Sri Charan (1):
      wifi: ath12k: Skip adding inactive partner vdev info

Baochen Qiang (1):
      wifi: ath10k: fix station lookup failure during disconnect

Benjamin Berg (3):
      wifi: mac80211: add a TXQ for management frames on NAN devices
      wifi: ieee80211: add more NAN definitions
      wifi: mac80211: export ieee80211_calculate_rx_timestamp

Bitterblue Smith (5):
      wifi: rtw89: Turbo mode for RTL8851BU/RTL8852BU
      wifi: rtw88: TX QOS Null data the same way as Null data
      wifi: rtw88: coex: Ignore BT info byte 5 from RTL8821A
      wifi: rtw88: Fill fw_version member of struct wiphy
      wifi: rtw89: Fill fw_version member of struct wiphy

Brendan Jackman (2):
      wifi: iwlegacy: Fixup allocation failure log
      wifi: iwlegacy: Fix GFP flags in allocation loop

Chin-Yen Lee (3):
      wifi: rtw89: wow: add retry for ensuring packet are processed
      wifi: rtw89: wow: use struct style to fill WOW wakeup control H2C command
      wifi: rtw89: wow: enable MLD address for Magic packet wakeup

Ching-Te Ku (1):
      wifi: rtw88: coex: Solve LE-HID lag & update coex version to 26020420

Christian Hewitt (1):
      wifi: rtw89: retry efuse physical map dump on transient failure

Christos Longros (1):
      wifi: rtw89: fix typo "frome" -> "from" in rx_freq_frome_ie

Duoming Zhou (1):
      wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet

Eric Biggers (7):
      wifi: ipw2x00: Rename michael_mic() to libipw_michael_mic()
      wifi: mac80211, cfg80211: Export michael_mic() and move it to cfg80211
      wifi: ath11k: Use michael_mic() from cfg80211
      wifi: ath12k: Use michael_mic() from cfg80211
      wifi: ipw2x00: Use michael_mic() from cfg80211
      crypto: Remove michael_mic from crypto_shash API
      wifi: cfg80211: Explicitly include <linux/export.h> in michael-mic.c

Eric Huang (1):
      wifi: rtw89: phy: expand PHY page for RTL8922D

Ethan Tidmore (1):
      wifi: brcmfmac: Fix error pointer dereference

Fedor Pchelkin (1):
      wifi: rtw88: check for PCI upstream bridge existence

Harish Rachakonda (1):
      wifi: ath12k: Support channel change stats

J. Neuschäfer (1):
      wifi: rtl8xxxu: Mark RTL8188ETV (0bda:0179) as tested

Jaime Saguillo Revilla (1):
      wifi: rtlwifi: rtl8192d: fix typo in H2C wait counter names

Jiajia Liu (1):
      wifi: mac80211: remove unused variables in minstrel_ht_alloc_sta

Johan Hovold (8):
      wifi: rtl818x: drop redundant device reference
      wifi: rtl8xxxu: drop redundant device reference
      wifi: rtw88: fix device leak on probe failure
      wifi: rtw89: drop redundant device reference
      wifi: rtlwifi: usb: drop redundant device reference
      wifi: at76c50x: refactor endpoint lookup
      wifi: libertas: refactor endpoint lookup
      wifi: libertas_tf: refactor endpoint lookup

Johannes Berg (3):
      Merge tag 'rtw-next-2026-04-02' of https://github.com/pkshih/rtw into wireless-next
      Merge tag 'ath-next-20260407' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'ath-next-20260408' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Kuan-Chung Chen (1):
      wifi: rtw89: add H2C command to protect TX/RX for unused PHY

Lucid Duck (1):
      wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs

Miri Korenblit (11):
      wifi: mac80211: run NAN DE code only when appropriate
      wifi: mac80211: add NAN local schedule support
      wifi: mac80211: support open and close for NAN_DATA interfaces
      wifi: mac80211: handle reconfig for NAN DATA interfaces
      wifi: mac80211: support NAN stations
      wifi: mac80211: add NAN peer schedule support
      wifi: mac80211: update NAN data path state on schedule changes
      wifi: mac80211: add support for TX over NAN_DATA interfaces
      wifi: mac80211: Accept frames on NAN DATA interfaces
      wifi: mac80211: allow block ack agreements in NAN Data
      wifi: mac80211: report and drop spurious NAN Data frames

Nicolas Escande (1):
      wifi: mac80211: handle VHT EXT NSS in ieee80211_determine_our_sta_mode()

Ping-Ke Shih (29):
      wifi: rtw89: fw: add fw_def struct to put firmware name and format version
      wifi: rtw89: fw: recognize firmware type B by AID
      wifi: rtw89: 8852b: update supported firmware format to 2
      wifi: rtw89: rfk: add hardware version to rtw89_fw_h2c_rf_pre_ntfy_mcc for new WiFi 7 firmware
      wifi: rtw89: pci: update SER parameters for suspend/resume
      wifi: rtw89: mac: remove A-die off setting for RTL8852C and RTL8922A
      wifi: rtw89: phy: limit AMPDU number for RA try rate
      wifi: rtw88: add quirks to disable PCI ASPM and deep LPS for HP P3S95EA#ACB
      wifi: rtw88: validate RX rate to prevent out-of-bound
      wifi: rtw89: 8922d: add definition of quota, registers and efuse block
      wifi: rtw89: 8922d: add power on/off functions
      wifi: rtw89: 8922d: define efuse map and read necessary fields
      wifi: rtw89: 8922d: read and configure RF by calibration data from efuse physical map
      wifi: rtw89: 8922d: add set channel of MAC part
      wifi: rtw89: 8922d: add set channel of BB part
      wifi: rtw89: 8922d: add set channel of RF part
      wifi: rtw89: pci: clear SER ISR when initial and leaving WoWLAN for WiFi 7 chips
      wifi: rtw89: mac: add specific case to dump mac memory for RTL8922D
      wifi: rtw89: mac: disable pre-load function for RTL8922DE
      wifi: rtw89: phy: load RF parameters relying on ACV for RTL8922D
      wifi: rtw89: 8922d: BB hardware pre-/post-init, TX/RX path and power settings
      wifi: rtw89: 8922d: add set channel with pre-/post- helpers
      wifi: rtw89: 8922d: add RF calibration ops
      wifi: rtw89: 8922d: add set TX power callback
      wifi: rtw89: 8922d: configure TX/RX path assisting in BT coexistence
      wifi: rtw89: 8922d: add RF ops of init hardware and get thermal
      wifi: rtw89: 8922d: add ops related to BT coexistence mechanism
      wifi: rtw89: 8922d: add chip_info and chip_ops struct
      wifi: rtw89: 8922d: add PCI ID of RTL8922DE and RTL8922DE-VS

Po-Hao Huang (2):
      wifi: rtw89: Drop malformed AMPDU frames with abnormal PN
      wifi: rtw89: Recalculate station aggregates when AMSDU length changes for MLO links

Raj Kumar Bhagat (2):
      dt-bindings: net: wireless: add ath12k wifi device IPQ5424
      wifi: ath12k: add ath12k_hw_version_map entry for IPQ5424

Ronald Claveau (1):
      dt-bindings: net: wireless: brcm: Add compatible for bcm43752

Roopni Devanathan (2):
      wifi: ath12k: Rename hw_link_id to radio_idx in ath12k_ah_to_ar()
      wifi: ath12k: Create symlink for each radio in a wiphy

Rosen Penev (2):
      wifi: brcmfmac: of: defer probe for MAC address
      wifi: wilc1000: use kzalloc_flex

Saravanakumar Duraisamy (3):
      wifi: ath12k: Add ath12k_hw_params for IPQ5424
      wifi: ath12k: add ath12k_hw_regs for IPQ5424
      wifi: ath12k: Add CE remap hardware parameters for IPQ5424

Shin-Yi Lin (1):
      wifi: rtw89: usb: Rx aggregation for RTL8832CU/RTL8851BU

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: Enable IPQ5424 WiFi device support

Tamizh Chelvam Raja (3):
      wifi: mac80211: synchronize valid links for WDS AP_VLAN interfaces
      wifi: mac80211: use ap_addr for 4-address NULL frame destination
      wifi: mac80211: enable MLO support for 4-address mode interfaces

Yi Cong (1):
      wifi: rtl8xxxu: fix potential use of uninitialized value

Zenm Chen (3):
      wifi: rtw89: Add support for TP-Link Archer TX50U
      wifi: rtw89: Add support for Buffalo WI-U3-2400XE2
      wifi: rtw89: Add support for Elecom WDC-XE2402TU3-B

Zong-Zhe Yang (14):
      wifi: rtw89: add general way to generate module firmware string
      wifi: rtw89: 8852a: move DIG tables to rtw8852a.c
      wifi: rtw89: 8852a: update supported firmware format to 1
      wifi: rtw89: 8851b: update supported firmware format to 1
      wifi: rtw89: debug: add SER SW counters to count simulation
      wifi: rtw89: ser: Wi-Fi 7 reset HALT C2H after reading it
      wifi: rtw89: ser: post-recover DMAC state to prevent LPS
      wifi: rtw89: move disabling dynamic mechanism functions to core
      wifi: rtw89: tweak settings of TX power and channel for Wi-Fi 7
      wifi: rtw89: chan: simplify link handling related to ROC
      wifi: rtw89: chan: recalc MLO DBCC mode based on current entity mode
      wifi: rtw89: replace RF mutex with wiphy lock assertion
      wifi: rtw89: debug: simulate Wi-Fi 7 SER L0/L1 without PS mode
      wifi: rtw89: fw: load TX power elements according to AID

 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    1 +
 .../bindings/net/wireless/qcom,ath10k.yaml         |   11 +
 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |    1 +
 arch/arm/configs/omap2plus_defconfig               |    1 -
 arch/arm/configs/spitz_defconfig                   |    1 -
 arch/arm64/configs/defconfig                       |    1 -
 arch/m68k/configs/amiga_defconfig                  |    1 -
 arch/m68k/configs/apollo_defconfig                 |    1 -
 arch/m68k/configs/atari_defconfig                  |    1 -
 arch/m68k/configs/bvme6000_defconfig               |    1 -
 arch/m68k/configs/hp300_defconfig                  |    1 -
 arch/m68k/configs/mac_defconfig                    |    1 -
 arch/m68k/configs/multi_defconfig                  |    1 -
 arch/m68k/configs/mvme147_defconfig                |    1 -
 arch/m68k/configs/mvme16x_defconfig                |    1 -
 arch/m68k/configs/q40_defconfig                    |    1 -
 arch/m68k/configs/sun3_defconfig                   |    1 -
 arch/m68k/configs/sun3x_defconfig                  |    1 -
 arch/mips/configs/bigsur_defconfig                 |    1 -
 arch/mips/configs/decstation_64_defconfig          |    1 -
 arch/mips/configs/decstation_defconfig             |    1 -
 arch/mips/configs/decstation_r4k_defconfig         |    1 -
 arch/mips/configs/gpr_defconfig                    |    1 -
 arch/mips/configs/ip32_defconfig                   |    1 -
 arch/mips/configs/lemote2f_defconfig               |    1 -
 arch/mips/configs/malta_qemu_32r6_defconfig        |    1 -
 arch/mips/configs/maltaaprp_defconfig              |    1 -
 arch/mips/configs/maltasmvp_defconfig              |    1 -
 arch/mips/configs/maltasmvp_eva_defconfig          |    1 -
 arch/mips/configs/maltaup_defconfig                |    1 -
 arch/mips/configs/mtx1_defconfig                   |    1 -
 arch/mips/configs/rm200_defconfig                  |    1 -
 arch/mips/configs/sb1250_swarm_defconfig           |    1 -
 arch/parisc/configs/generic-32bit_defconfig        |    1 -
 arch/parisc/configs/generic-64bit_defconfig        |    1 -
 arch/powerpc/configs/g5_defconfig                  |    1 -
 arch/powerpc/configs/linkstation_defconfig         |    1 -
 arch/powerpc/configs/mvme5100_defconfig            |    1 -
 arch/powerpc/configs/powernv_defconfig             |    1 -
 arch/powerpc/configs/ppc64_defconfig               |    1 -
 arch/powerpc/configs/ppc64e_defconfig              |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/powerpc/configs/ps3_defconfig                 |    1 -
 arch/s390/configs/debug_defconfig                  |    1 -
 arch/s390/configs/defconfig                        |    1 -
 arch/sh/configs/sh2007_defconfig                   |    1 -
 arch/sh/configs/titan_defconfig                    |    1 -
 arch/sh/configs/ul2_defconfig                      |    1 -
 arch/sparc/configs/sparc32_defconfig               |    1 -
 arch/sparc/configs/sparc64_defconfig               |    1 -
 crypto/Kconfig                                     |   12 -
 crypto/Makefile                                    |    1 -
 crypto/michael_mic.c                               |  176 --
 crypto/tcrypt.c                                    |    4 -
 crypto/testmgr.c                                   |    6 -
 crypto/testmgr.h                                   |   50 -
 drivers/net/wireless/ath/ath10k/qmi.c              |   13 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    3 +
 drivers/net/wireless/ath/ath10k/snoc.h             |    1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   26 +-
 drivers/net/wireless/ath/ath11k/Kconfig            |    1 -
 drivers/net/wireless/ath/ath11k/dp.c               |    2 -
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   60 +-
 drivers/net/wireless/ath/ath11k/peer.h             |    1 -
 drivers/net/wireless/ath/ath12k/Kconfig            |    1 -
 drivers/net/wireless/ath/ath12k/ahb.c              |   36 +-
 drivers/net/wireless/ath/ath12k/ahb.h              |    1 +
 drivers/net/wireless/ath/ath12k/ce.h               |   13 +-
 drivers/net/wireless/ath/ath12k/core.c             |    4 +-
 drivers/net/wireless/ath/ath12k/core.h             |   13 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   29 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |   72 +
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |   26 +
 drivers/net/wireless/ath/ath12k/dp.c               |    2 -
 drivers/net/wireless/ath/ath12k/dp_peer.h          |    1 -
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   55 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    4 -
 drivers/net/wireless/ath/ath12k/mac.c              |    4 +-
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |    8 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |    7 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |    7 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |    3 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |   88 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |    1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |   97 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |   22 +-
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |   15 +
 .../broadcom/brcm80211/brcmfmac/firmware.c         |   17 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |    4 +-
 drivers/net/wireless/intel/ipw2x00/Kconfig         |    1 -
 .../wireless/intel/ipw2x00/libipw_crypto_tkip.c    |  120 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    7 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |   39 +-
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  |   48 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |    8 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    4 -
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   40 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |    1 +
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.c  |   12 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |    4 -
 drivers/net/wireless/realtek/rtw88/coex.c          |   47 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    6 +
 drivers/net/wireless/realtek/rtw88/main.h          |    6 +
 drivers/net/wireless/realtek/rtw88/pci.c           |   34 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    5 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    5 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    7 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    7 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    5 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    5 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |    8 +
 drivers/net/wireless/realtek/rtw88/tx.c            |    2 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |   72 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  155 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  105 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   53 +-
 drivers/net/wireless/realtek/rtw89/efuse.c         |   23 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  161 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |  134 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   69 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   34 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   11 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    2 +
 drivers/net/wireless/realtek/rtw89/pci.h           |    7 +
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  104 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |   71 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    5 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |    2 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |    2 +
 drivers/net/wireless/realtek/rtw89/reg.h           |  285 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   49 +-
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   68 +-
 .../net/wireless/realtek/rtw89/rtw8852a_table.c    |   51 -
 .../net/wireless/realtek/rtw89/rtw8852a_table.h    |    1 -
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   41 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   15 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |    7 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   18 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c      | 3093 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.h      |   83 +
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c  |  372 +++
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h  |   22 +
 drivers/net/wireless/realtek/rtw89/rtw8922de.c     |  119 +
 drivers/net/wireless/realtek/rtw89/ser.c           |    4 +-
 drivers/net/wireless/realtek/rtw89/usb.c           |  107 +-
 drivers/net/wireless/realtek/rtw89/usb.h           |   15 +
 drivers/net/wireless/realtek/rtw89/util.h          |   17 +
 drivers/net/wireless/realtek/rtw89/wow.c           |    2 +
 drivers/net/wireless/realtek/rtw89/wow.h           |    7 -
 include/linux/ieee80211-nan.h                      |   37 +
 include/linux/ieee80211.h                          |    6 +
 include/net/mac80211.h                             |  157 +-
 net/mac80211/Makefile                              |    3 +-
 net/mac80211/agg-tx.c                              |    3 +-
 net/mac80211/cfg.c                                 |  269 +-
 net/mac80211/chan.c                                |  140 +-
 net/mac80211/driver-ops.h                          |   21 +
 net/mac80211/he.c                                  |    7 +-
 net/mac80211/ht.c                                  |   19 +-
 net/mac80211/ibss.c                                |    2 +-
 net/mac80211/ieee80211_i.h                         |   52 +-
 net/mac80211/iface.c                               |  113 +-
 net/mac80211/link.c                                |   45 +-
 net/mac80211/main.c                                |    4 +-
 net/mac80211/mesh_sync.c                           |    2 +-
 net/mac80211/michael.h                             |   22 -
 net/mac80211/mlme.c                                |   11 +-
 net/mac80211/nan.c                                 |  710 +++++
 net/mac80211/rc80211_minstrel_ht.c                 |   15 +-
 net/mac80211/rx.c                                  |   61 +-
 net/mac80211/scan.c                                |    2 +-
 net/mac80211/sta_info.c                            |   29 +-
 net/mac80211/sta_info.h                            |    3 +-
 net/mac80211/trace.h                               |   31 +
 net/mac80211/tx.c                                  |   52 +-
 net/mac80211/util.c                                |  146 +-
 net/mac80211/vht.c                                 |   16 +-
 net/mac80211/wpa.c                                 |    1 -
 net/wireless/Makefile                              |    2 +-
 net/{mac80211/michael.c => wireless/michael-mic.c} |    6 +-
 185 files changed, 7462 insertions(+), 1301 deletions(-)
 delete mode 100644 crypto/michael_mic.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922de.c
 delete mode 100644 net/mac80211/michael.h
 create mode 100644 net/mac80211/nan.c
 rename net/{mac80211/michael.c => wireless/michael-mic.c} (95%)

