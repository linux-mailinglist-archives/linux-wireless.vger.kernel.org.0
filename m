Return-Path: <linux-wireless+bounces-33691-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNtSCTAKwWmtPwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33691-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:38:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC3B2EF331
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A45D302D123
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C44938552C;
	Mon, 23 Mar 2026 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="FvTLhxaB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780EA2DC762
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258404; cv=none; b=j271jFex8CQNcVDoGE5KMGeOIhZkSPFklQ37ksGS1qhI92EnNdFEagpEpGWx67C6FiA8aB7eUC2M7/cfhi41HwaNGVWibNMu9N7K6SBoEHQ2hx7BOvxdxl9kpBa8+IDZSPTFm1ljBkYt1XmoLH0U19UH0/CGWWzikB/HeCLmib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258404; c=relaxed/simple;
	bh=JCdgOxOYioijtO4FKsfO6bPNxvjJZG63dvLITS588Ew=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=UaI4UAO5VxMvu1hMB5EYpDs5HT1DN45m9OA0d7U+Gec0Ygv9ngU7XeXWMSQVcq/cFmmTOFC/Skpp2KXoYvSzdUo93suK3ghFNYgTBWxo2BUiQ8ZV2yGFYzrsiVO9TFAwptookkTFKqy80A4dP0NkF0drQYHF1KmxlVkcte6G6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=FvTLhxaB; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QEe474bMYfDW9GnvAzhQ62In3HQ7a4pWTazMFY02NUA=; b=FvTLhxaB7dxnpROXt5XVaSw3UM
	cnB26NAXzfrGLJopqJPs2ktWU9dIEkGQchHlMsrVBxxcpVqxmOusmdh9OIH7KaUJFWOwPZCgkzrcp
	2GgfWJnN/KQD1hBM9kVShPrioA2tpw4iYIlZNQOX7esOWKaQLxhFkZpbO2JGWK2fyqqo=;
Received: from p5b0151bb.dip0.t-ipconnect.de ([91.1.81.187] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w4bes-00AL0K-2L;
	Mon, 23 Mar 2026 10:33:14 +0100
Message-ID: <bf6858fc-98f0-4523-bca4-8da7ecf3738c@nbd.name>
Date: Mon, 23 Mar 2026 10:33:14 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76-next 2026-03-23
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
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33691-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[nbd.name:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nbd.name:mid]
X-Rspamd-Queue-Id: 5EC3B2EF331
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Here's my mt76 pull request for 7.1

- Felix

The following changes since commit 9ac76f3d0bb2940db3a9684d596b9c8f301ef315:

   Merge tag 'wireless-next-2026-03-19' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-03-19 15:30:20 +0100)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-next-2026-03-23

for you to fetch changes up to 61fe246f396e411b356535a5f8a3ad2412e1dfa8:

   wifi: mt76: mt7996: Destroy active sta links in mt7996_mac_sta_remove() (2026-03-23 09:23:05 +0000)

----------------------------------------------------------------
mt76 patches for 7.1

- fixes
- mt7996/mt7925 MLO fixes/improvements
- mt7996 NPU support
- mt7996 external EEPROM support

----------------------------------------------------------------
Allen Ye (1):
       wifi: mt76: fix backoff fields and max_power calculation

Alok Tiwari (1):
       wifi: mt76: mt7996: fix FCS error flag check in RX descriptor

Chad Monroe (5):
       wifi: mt76: fix deadlock in remain-on-channel
       wifi: mt76: mt7996: reset device after MCU message timeout
       wifi: mt76: mt7996: increase txq memory limit to 32 MiB
       wifi: mt76: fix multi-radio on-channel scanning
       wifi: mt76: support upgrading passive scans to active

Christian Hewitt (1):
       wifi: mt7601u: check multiple firmware paths

Colin Ian King (1):
       wifi: mt76: mt7996: Fix spelling mistake "retriving" -> "retrieving"

David Bauer (2):
       wifi: mt76: mt76x02: wake queues after reconfig
       wifi: mt76: don't return TXQ when exceeding max non-AQL packets

Duoming Zhou (2):
       wifi: mt76: mt7915: fix use-after-free bugs in mt7915_mac_dump_work()
       wifi: mt76: mt7996: fix use-after-free bugs in mt7996_mac_dump_work()

Felix Fietkau (9):
       wifi: mt76: add offchannel check to mt76_roc_complete
       wifi: mt76: check chanctx before restoring channel after ROC
       wifi: mt76: abort ROC on chanctx changes
       wifi: mt76: optimize ROC for same-channel case
       wifi: mt76: send nullfunc PS frames on offchannel transitions
       wifi: mt76: flush pending TX before channel switch
       wifi: mt76: route nullfunc frames to PSD/ALTX queue
       wifi: mt76: wait for firmware TX completion of mgmt frames before channel switch
       wifi: mt76: add per-link beacon monitoring for MLO

Howard Hsu (1):
       wifi: mt76: mt7996: support critical packet mode for MT7990 chipsets

Leon Yen (5):
       wifi: mt76: mt7925: introduce CSA support in non-MLO mode
       wifi: mt76: mt7925: Fix incorrect MLO mode in firmware control
       wifi: mt76: mt792x: Fix a potential deadlock in high-load situations
       wifi: mt76: mt7921: fix a potential clc buffer length underflow
       wifi: mt76: mt7925: fix tx power setting failure after chip reset

Lorenzo Bianconi (30):
       wifi: mt76: mt7996: Set mtxq->wcid just for primary link
       wifi: mt76: mt7996: Reset mtxq->idx if primary link is removed in mt7996_vif_link_remove()
       wifi: mt76: mt7996: Switch to the secondary link if the default one is removed
       wifi: mt76: mt7996: Clear wcid pointer in mt7996_mac_sta_deinit_link()
       wifi: mt76: mt7996: Reset ampdu_state state in case of failure in mt7996_tx_check_aggr()
       wifi: mt76: Fix memory leak destroying device
       wifi: mt76: mt7996: Fix NPU stop procedure
       wifi: mt76: npu: Add missing rx_token_size initialization
       wifi: mt76: always enable RRO queues for non-MT7992 chipset
       wifi: mt76: mt7996: Fix BAND2 tx queues initialization when NPU is enabled
       wifi: mt76: mt7996: Fix wdma_idx for MT7996 device if NPU is enabled
       wifi: mt76: mt7996: Add mt7992_npu_txrx_offload_init routine
       wifi: mt76: mt7996: Rename mt7996_npu_rxd_init() in mt7992_npu_rxd_init()
       wifi: mt76: mt7996: Add NPU support for MT7990 chipset
       wifi: mt76: mt7996: Integrate NPU in RRO session management
       wifi: mt76: mt7996: Integrate MT7990 init configuration for NPU
       wifi: mt76: mt7996: Integrate MT7990 dma configuration for NPU
       wifi: mt76: mt7996: Add __mt7996_npu_hw_init routine
       wifi: mt76: mt7996: Move RRO dma start in a dedicated routine
       wifi: mt76: Do not reset idx for NPU tx queues during reset
       wifi: mt76: mt7996: Do not schedule RRO and TxFree queues during reset for NPU
       wifi: mt76: mt7996: Store DMA mapped buffer addresses in mt7996_npu_hw_init()
       wifi: mt76: Enable NPU support for MT7996 devices
       wifi: mt76: mt7996: Add missing CHANCTX_STA_CSA property
       wifi: mt76: mt7996: Remove link pointer dependency in mt7996_mac_sta_remove_links()
       wifi: mt76: mt7996: Remove unnecessary phy filed in mt7996_vif_link struct
       wifi: mt76: mt7996: Decrement sta counter removing the link in mt7996_mac_reset_sta_iter()
       wifi: mt76: mt7996: Rely on msta_link link_id in mt7996_vif_link_remove()
       wifi: mt76: mt7996: Destroy vif active links in mt7996_remove_interface()
       wifi: mt76: mt7996: Destroy active sta links in mt7996_mac_sta_remove()

Madhur Kumar (1):
       wifi: mt76: mt7921: Replace deprecated PCI function

MeiChia Chiu (1):
       wifi: mt76: mt7996: Add eMLSR support

Michael Lo (2):
       wifi: mt76: mt7925: Skip scan process during suspend.
       wifi: mt76: mt7921: fix 6GHz regulatory update on connection

Ming Yen Hsieh (3):
       wifi: mt76: mt7925: fix incorrect length field in txpower command
       wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_tx_check_aggr()
       wifi: mt76: mt7925: prevent NULL vif dereference in mt7925_mac_write_txwi

Peter Chiu (3):
       wifi: mt76: mt7996: fix RRO EMU configuration
       wifi: mt76: mt7996: update WFSYS reset flow for MT7990 chipsets
       wifi: mt76: mt7996: fix frequency separation for station STR mode

Quan Zhou (3):
       wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
       wifi: mt76: mt7921: fix ROC abort flow interruption in mt7921_roc_work
       wifi: mt76: mt7925: fix incorrect TLV length in CLC command

Rex Lu (1):
       wifi: mt76: mt7996: adjust timeout value for boot-up calibration commands

Rory Little (1):
       wifi: mt76: mt7921: Place upper limit on station AID

Ryder Lee (6):
       wifi: mt76: mt7615: fix use_cts_prot support
       wifi: mt76: mt7915: fix use_cts_prot support
       wifi: mt76: mt7996: add support for ERP CTS & HT protection
       dt-bindings: net: wireless: mt76: add mt79 PCI devices
       dt-bindings: net: wireless: mt76: clarify backoff limit usage
       wifi: mt76: mt7996: Disable Rx hdr_trans in monitor mode

Sean Wang (36):
       wifi: mt76: mt7921: Reset ampdu_state state in case of failure in mt76_connac2_tx_check_aggr()
       wifi: mt76: mt7925: drop puncturing handling from BSS change path
       wifi: mt76: mt7925: fix potential deadlock in mt7925_roc_abort_sync
       wifi: mt76: mt7921: fix potential deadlock in mt7921_roc_abort_sync
       wifi: mt76: connac: use is_connac2() to replace is_mt7921() checks
       wifi: mt76: mt7921: use mt76_for_each_q_rx() in reset path
       wifi: mt76: mt7921: handle MT7902 irq_map quirk with mutable copy
       wifi: mt76: mt7921: add MT7902e DMA layout support
       wifi: mt76: connac: mark MT7902 as hw txp devices
       wifi: mt76: mt792x: add PSE handling barrier for the large MCU cmd
       wifi: mt76: mt792x: ensure MCU ready before ROM patch download
       wifi: mt76: mt7921: add MT7902 MCU support
       wifi: mt76: mt792x: add MT7902 WFDMA prefetch configuration
       wifi: mt76: mt7921: add MT7902 PCIe device support
       wifi: mt76: mt7921: add MT7902 SDIO device support
       wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
       wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
       wifi: mt76: mt7925: pass mlink to sta_amsdu_tlv()
       wifi: mt76: mt7925: pass WCID indices to bss_basic_tlv()
       wifi: mt76: mt7925: pass mlink and mconf to sta_mld_tlv()
       wifi: mt76: mt7925: pass mlink to mcu_sta_update()
       wifi: mt76: mt7925: resolve primary mlink via def_wcid
       wifi: mt76: mt7925: pass mlink to mac_link_sta_remove()
       wifi: mt76: mt7925: pass mlink to sta_hdr_trans_tlv()
       wifi: mt76: mt7925: validate mlink in sta_hdr_trans_tlv()
       wifi: mt76: mt7925: pass mlink to wtbl_update_hdr_trans()
       wifi: mt76: mt7925: pass mlink to set_link_key()
       wifi: mt76: mt7925: resolve link after acquiring mt76 mutex
       wifi: mt76: mt7925: pass mconf and mlink to wtbl_update_hdr_trans()
       wifi: mt76: mt7925: make WCID cleanup unconditional in sta_remove_links()
       wifi: mt76: mt7925: unwind WCID setup on link STA add failure
       wifi: mt76: mt7925: drop WCID reinit after publish
       wifi: mt76: mt7925: move WCID teardown into link_sta_remove()
       wifi: mt76: mt7925: switch link STA allocation to RCU lifetime
       wifi: mt76: mt7925: publish msta->link after successful link add
       wifi: mt76: mt7925: host-only unwind published links on add failure

Shayne Chen (8):
       wifi: mt76: mt7996: extend CSA and CCA support for MLO
       wifi: mt76: mt7996: add duplicated WTBL command
       wifi: mt76: mt7996: fix iface combination for different chipsets
       wifi: mt76: mt7996: add variant for MT7992 chipsets
       wifi: mt76: mt7996: fix wrong DMAD length when using MAC TXP
       wifi: mt76: mt7996: Account active links in valid_links fields
       wifi: mt76: mt7996: Move mlink deallocation in mt7996_vif_link_remove()
       wifi: mt76: mt7996: Add mcu APIs to enable/disable vif links.

StanleyYP Wang (10):
       wifi: mt76: mt7996: fix the behavior of radar detection
       wifi: mt76: mt7996: set specific BSSINFO and STAREC commands after channel switch
       wifi: mt76: mt7996: abort CCA when CSA is starting
       wifi: mt76: mt7996: offload radar threshold initialization
       wifi: mt76: add external EEPROM support for mt799x chipsets
       wifi: mt76: mt7996: apply calibration-free data from OTP
       wifi: mt76: mt7996: fix struct mt7996_mcu_uni_event
       wifi: mt76: avoid to set ACK for MCU command if wait_resp is not set
       wifi: mt76: mt7996: fix queue pause after scan due to wrong channel switch reason
       wifi: mt76: mt7996: fix issues with manually triggered radar detection

Zac Bowling (1):
       wifi: mt76: fix list corruption in mt76_wcid_cleanup

Zilin Guan (1):
       wifi: mt76: Fix memory leak after mt76_connac_mcu_alloc_sta_req()

Ziyi Guo (1):
       wifi: mt76: add missing lock protection in mt76_sta_state for sta_event callback

  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |  21 ++
  drivers/net/wireless/mediatek/mt76/channel.c                      |  39 ++-
  drivers/net/wireless/mediatek/mt76/dma.c                          |  33 +-
  drivers/net/wireless/mediatek/mt76/dma.h                          |   4 +-
  drivers/net/wireless/mediatek/mt76/eeprom.c                       | 154 ++++++---
  drivers/net/wireless/mediatek/mt76/mac80211.c                     | 230 ++++++++++++-
  drivers/net/wireless/mediatek/mt76/mcu.c                          |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76.h                         |  47 ++-
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |  15 -
  drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |  47 +++
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7615/regs.h                  |   2 -
  drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |  11 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c              |  28 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |  46 ++-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  15 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |  13 -
  drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   |  66 +++-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |  11 +
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |   4 +
  drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |  29 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |   3 +
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  16 +
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  70 +++-
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c               |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |   4 +
  drivers/net/wireless/mediatek/mt76/mt7925/init.c                  |   2 +
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c                   |  18 +-
  drivers/net/wireless/mediatek/mt76/mt7925/main.c                  | 394 ++++++++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                   | 194 ++++++-----
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h                   |   7 +
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                |  13 +-
  drivers/net/wireless/mediatek/mt76/mt7925/regd.c                  |   3 +-
  drivers/net/wireless/mediatek/mt76/mt792x.h                       |   7 +
  drivers/net/wireless/mediatek/mt76/mt792x_core.c                  |  14 +-
  drivers/net/wireless/mediatek/mt76/mt792x_dma.c                   |  18 +-
  drivers/net/wireless/mediatek/mt76/mt792x_mac.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_regs.h                  |   6 +
  drivers/net/wireless/mediatek/mt76/mt792x_usb.c                   |  51 ++-
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c               |  36 +-
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c                   | 208 +++++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c                |  64 ++--
  drivers/net/wireless/mediatek/mt76/mt7996/init.c                  | 110 +++++--
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c                   | 161 +++------
  drivers/net/wireless/mediatek/mt76/mt7996/mac.h                   |   5 -
  drivers/net/wireless/mediatek/mt76/mt7996/main.c                  | 439 +++++++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                   | 823 ++++++++++++++++++++++++++++++++++++++--------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                   | 112 ++++++-
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                |  70 +++-
  drivers/net/wireless/mediatek/mt76/mt7996/npu.c                   | 469 ++++++++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h                  |  11 +
  drivers/net/wireless/mediatek/mt76/npu.c                          |  37 ++-
  drivers/net/wireless/mediatek/mt76/scan.c                         |  70 +++-
  drivers/net/wireless/mediatek/mt76/tx.c                           |  34 +-
  drivers/net/wireless/mediatek/mt7601u/mcu.c                       |  15 +-
  drivers/net/wireless/mediatek/mt7601u/usb.h                       |   1 +
  61 files changed, 3368 insertions(+), 969 deletions(-)

