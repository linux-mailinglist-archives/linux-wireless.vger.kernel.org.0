Return-Path: <linux-wireless+bounces-27327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2019B5781E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 13:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8837C1A253EF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CCE301477;
	Mon, 15 Sep 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="E3CJMnCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411573009D4
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935658; cv=none; b=p/5ya2SoH/vaesGux0phqjfjase0uxlM5J7C9HgoNd650xnAx9Y22SnCdEeqLnVIJvfpGXBm5/umrWVX2wwQ1j+qUBV90DBhgmbGV2hRbd9o/UBcdLn+hpwt2Tt4NTnaLcl0NZztcpxvBrckqmBP/PodM6uuXCDTn0oE/qaZ7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935658; c=relaxed/simple;
	bh=gZ5fzR/9PfJ1DrmXwQ4+fmLX/xLi2wza0z10UydzwCM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=dNfd9ntZC6HyhqQ9RleDaJDwJ7hhhs/uhnyfKuNLtEcxdV3guU0CTdbQrkV+uwGvR+gtLXt/E0XsgsN5gsMsyw5dqgIDlYdYkZIiUdUiZOWqgBUAQmXLUOuGXogGkFdk5S4bCx7/SAovC/rL3o+KaI73UymWjBAC/tkallWAKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=E3CJMnCI; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IjajQBrqHofTgywHY9cj1Tgb6I/fjAiN8/7bEHdSTMc=; b=E3CJMnCI/0wVRBgZ4TC8svluuQ
	577Dp3/CJ+wEV5csNXIm2aJHrXPZv4qF3C4XzMfYNN9LZzq9YN3puL3X0QC58ukgLkhC7ZgwIdlBm
	ZN7SC/MWQ+orSZUZJndl7P/FniqDlnjVkh4PWBem8A6MyqWIrK0MKT/4TJRiv4zUSOoY=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy7Mr-007Cgg-1U;
	Mon, 15 Sep 2025 13:27:33 +0200
Message-ID: <b38b95fa-264b-405e-a566-46a456ebd71c@nbd.name>
Date: Mon, 15 Sep 2025 13:27:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76-next 2025-09-15
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's my mt76 pull request for 6.18

- Felix

The following changes since commit d103f26a5c8599385acb2d2e01dfbaedb00fdc0a:

   Merge tag 'wireless-next-2025-09-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2025-09-11 17:50:46 -0700)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-next-2025-09-15

for you to fetch changes up to b36d55610215a976267197ddc914902c494705d7:

   wifi: mt76: abort scan/roc on hw restart (2025-09-15 13:23:02 +0200)

----------------------------------------------------------------
mt76 patches for 6.18

- fixes
- mt7996 MLO support
- mt7996 hw restart improvements

----------------------------------------------------------------
Abdun Nihaal (1):
       wifi: mt76: fix potential memory leak in mt76_wmac_probe()

Benjamin Lin (1):
       wifi: mt76: mt7996: Temporarily disable EPCS

Felix Fietkau (11):
       wifi: mt76: mt7996: remove redundant per-phy mac80211 calls during restart
       wifi: mt76: mt7996: improve hardware restart reliability
       wifi: mt76: mt7996: decrease timeout for commonly issued MCU commands
       wifi: mt76: mt7996: fix setting beacon protection keys
       wifi: mt76: mt7996: fix memory leak on mt7996_mcu_sta_key_tlv error
       wifi: mt76: mt7996: delete vif keys when requested
       wifi: mt76: mt7996: fix key add/remove imbalance
       wifi: mt76: mt7996: fix updating beacon protection with beacons enabled
       wifi: mt76: use altx queue for offchannel tx on connac+
       wifi: mt76: improve phy reset on hw restart
       wifi: mt76: abort scan/roc on hw restart

Howard Hsu (3):
       wifi: mt76: mt7996: support writing MAC TXD for AddBA Request
       wifi: mt76: mt7996: remove the mem_total field of STA_REC_BF command
       wifi: mt76: mt7996: fill User Priority in skb->priority for rx packets

Jack Kao (1):
       wifi: mt76: mt7925: add pci restore for hibernate

Lorenzo Bianconi (22):
       wifi: mt76: mt7996: Overwrite unspecified link_id in mt7996_tx()
       wifi: mt76: mt7996: Fix mt7996_mcu_sta_ba wcid configuration
       wifi: mt76: mt7996: Fix mt7996_mcu_bss_mld_tlv routine
       wifi: mt76: mt7996: Set def_wcid pointer in mt7996_mac_sta_init_link()
       wifi: mt76: mt7996: Set proper link destination address in mt7996_tx()
       wifi: mt76: mt7996: Use deflink for AMPDU rx reordering
       wifi: mt76: Remove dead code in mt76_scan_work
       wifi: mt76: mt7996: Use proper link_id in link_sta_rc_update callback
       wifi: mt76: mt7996: Check phy before init msta_link in mt7996_mac_sta_add_links()
       wifi: mt76: mt7996: Use proper link info in mt7996_mcu_add_group
       wifi: mt76: mt7996: Add all active links to poll list in mt7996_mac_tx_free()
       wifi: mt76: mt7996: Set EML capabilities for AP interface
       wifi: mt76: mt7996: Enable MLO support for client interfaces
       wifi: mt76: Add reset_idx to reset_q mt76_queue_ops signature.
       wifi: mt76: Remove q->ndesc check in mt76_dma_rx_fill()
       wifi: mt76: Do not always enable NAPIs for WED RRO queues
       wifi: mt76: mt7996: Fix tx-queues initialization for second phy on mt7996
       wifi: mt76: mt7996: Fix RX packets configuration for primary WED device
       wifi: mt76: mt7996: Convert mt7996_wed_rro_addr to LE
       wifi: mt76: Add rx_queue_init callback
       wifi: mt76: Add mt76_dma_get_rxdmad_c_buf utility routione
       wifi: mt76: Convert mt76_wed_rro_ind to LE

Ming Yen Hsieh (3):
       wifi: mt76: mt7925: add MBSSID support
       wifi: mt76: mt7921: add MBSSID support
       wifi: mt76: mt7925: refine the txpower initialization flow

Nick Morrow (2):
       wifi: mt76: mt7925u: Add VID/PID for Netgear A9000
       wifi: mt76: mt7921u: Add VID/PID for Netgear A7500

Peter Chiu (2):
       wifi: mt76: mt7996: disable promiscuous mode by default
       wifi: mt76: mt7996: set VTA in txwi

Quan Zhou (1):
       wifi: mt76: mt7921: Add 160MHz beamformee capability for mt7922 device

Rex Lu (8):
       wifi: mt76: Differentiate between RRO data and RRO MSDU queues
       wifi: mt76: mt7996: Initial DMA configuration for MT7992 WED support
       wifi: mt76: mt7996: Enable HW RRO for MT7992 chipset
       wifi: mt76: mt7996: Introduce the capability to reset MT7992 WED device
       wifi: mt76: mt7996: Enable WED for MT7992 chipset
       wifi: mt76: mt7996: Introduce RRO MSDU callbacks
       wifi: mt76: mt7996: Decouple RRO logic from WED support
       wifi: mt76: mt7996: Add SW path for HW-RRO v3.1

Rosen Penev (1):
       wifi: mt76: mt76_eeprom_override to int

Shayne Chen (3):
       wifi: mt76: mt7996: Fix mt7996_reverse_frag0_hdr_trans for MLO
       wifi: mt76: mt7996: Implement MLD address translation for EAPOL
       wifi: mt76: mt7996: Export MLO AP capabilities to mac80211

Zhi-Jun You (1):
       wifi: mt76: mt7915: fix mt7981 pre-calibration

  drivers/net/wireless/mediatek/mt76/agg-rx.c           |   2 +
  drivers/net/wireless/mediatek/mt76/channel.c          |  13 ++-
  drivers/net/wireless/mediatek/mt76/dma.c              | 231 ++++++++++++++++++++++++++++++++--------
  drivers/net/wireless/mediatek/mt76/dma.h              |  29 +++++-
  drivers/net/wireless/mediatek/mt76/eeprom.c           |   9 +-
  drivers/net/wireless/mediatek/mt76/mac80211.c         |  59 +++++++++++
  drivers/net/wireless/mediatek/mt76/mt76.h             |  75 ++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c    |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7603/soc.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7615/init.c      |   5 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |   7 ++
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  25 +++++
  drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c    |   6 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c    |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7915/init.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  29 ++----
  drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      |   2 +
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |   3 +
  drivers/net/wireless/mediatek/mt76/mt7925/init.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c       |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7925/main.c      |  67 +-----------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       |  28 ++++-
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |  26 ++++-
  drivers/net/wireless/mediatek/mt76/mt7925/usb.c       |   3 +
  drivers/net/wireless/mediatek/mt76/mt792x.h           |   1 -
  drivers/net/wireless/mediatek/mt76/mt792x_core.c      |   6 +-
  drivers/net/wireless/mediatek/mt76/mt792x_dma.c       |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c       | 324 ++++++++++++++++++++++++++++++++++++++++++++------------
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c    |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7996/init.c      | 358 +++++++++++++++++++++++++++++++++++++++++++++-----------------
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 799 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c      | 521 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       | 308 +++++++++++++++++++++++++++---------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h       |  17 +--
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |  89 ++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    | 106 ++++++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7996/pci.c       |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h      |  32 +++++-
  drivers/net/wireless/mediatek/mt76/scan.c             |  13 +--
  drivers/net/wireless/mediatek/mt76/tx.c               |   3 +-
  drivers/net/wireless/mediatek/mt76/wed.c              |   8 +-
  46 files changed, 2325 insertions(+), 935 deletions(-)

