Return-Path: <linux-wireless+bounces-20564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5A0A68E3E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B9F3B4E1F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A034A537F8;
	Wed, 19 Mar 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="F6H7BNHG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DC2FC23
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392299; cv=none; b=Lv0VIu1Km6JGaK0i7qc2nKBr0pGoFE5CTDNojdukv8+9N51s2YN62FSGb9T5BJzDgrtgHreFNv85rFjAv6PlXiOmPABhIe3QsXMrjikvlP94Y0ttasZCWl/lnAHb6sYFjWDy3ZJdpO5QmU0TaBxRbdSffzsYGY3QWRiv9xQUUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392299; c=relaxed/simple;
	bh=IpY4ZcpfEL5JdQrY7WJ/QHzcf1Ypaa7UZ/fDYifvW0w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Nb13AP5CvzW6ZzpiwOKFPXZIPel+/b90gjNQ434QlvAwY201ArybXxxyYBYUa3sVtAEVy6hOyoMenqVPerUutJxenawt7zti3UTAsb9sHvD7NfXUXh30bUJrNdTtiY6lyXbAtmI5AGaglXhFik1vq7BjHhboERFJYvttR/tYP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=F6H7BNHG; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XPiHf7lyw/LJQobiL49jqOrdlQfHxu2cPcAR2dpqr1M=; b=F6H7BNHGVf0NEhr77q/OFhbVCO
	cuZIEk4t/WVdJlOtGaEMZNfkadfTa5ahUij9AixHZapW36/AR/cJ1VFHvj3eg4Q/muGvS4t8iP6HR
	D/O+350/R0dHqfHAcS49fQuSr0QIngDiAsFR/HLHw9JfAdTau+6KLhfFjUyuEvv0WglQ=;
Received: from p4ff1342a.dip0.t-ipconnect.de ([79.241.52.42] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tutpP-001Vm8-2S
	for linux-wireless@vger.kernel.org;
	Wed, 19 Mar 2025 14:51:27 +0100
Message-ID: <559c5a84-6e90-46a5-8fd4-052f382902c4@nbd.name>
Date: Wed, 19 Mar 2025 14:51:27 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2025-03-19
To: linux-wireless <linux-wireless@vger.kernel.org>
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

Here's my mt76 pull request for 6.15

- Felix

The following changes since commit 3fd552b2658eb6bf2a3b531553fe563340d37fdf:

   Merge tag 'rtw-next-2025-03-13' of https://github.com/pkshih/rtw (2025-03-19 09:36:47 +0100)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-next-2025-03-19

for you to fetch changes up to 06cccc2ebbe6c8a20f714f3a0ff3ff489d3004bb:

   wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table (2025-03-19 14:47:07 +0100)

----------------------------------------------------------------
mt76 patches for 6.15

- preparation for mt7996 mlo support
- fixes

----------------------------------------------------------------
Benjamin Lin (1):
       wifi: mt76: mt7996: revise TXS size

Felix Fietkau (5):
       wifi: mt76: scan: set vif offchannel link for scanning/roc
       wifi: mt76: mt7996: use the correct vif link for scanning/roc
       wifi: mt76: only mark tx-status-failed frames as ACKed on mt76x0/2
       wifi: mt76: mt7996: implement driver specific get_txpower function
       wifi: mt76: scan: fix setting tx_info fields

Haoxiang Li (1):
       wifi: mt76: Add check for devm_kstrdup()

Icenowy Zheng (1):
       wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Lorenzo Bianconi (18):
       wifi: mt76: mt7996: Add change_vif_links stub
       wifi: mt76: mt7996: Introduce mt7996_sta_link container
       wifi: mt76: mt7996: Add mt7996_sta_link struct in mt7996_vif_link
       wifi: mt76: mt7996: Add vif_cfg_changed callback
       wifi: mt76: mt7996: Add link_info_changed callback
       wifi: mt76: mt7996: Add mt7996_sta_state routine
       wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks
       wifi: mt76: mt7996: Support MLO in mt7996_mac_sta_event()
       wifi: mt76: mt7996: Rely on mt7996_vif/sta_link in twt teardown
       wifi: mt76: mt7996: Add mt7996_sta_link to mt7996_mcu_add_bss_info signature
       wifi: mt76: mt7996: rework mt7996_sta_hw_queue_read to support MLO
       wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO
       wifi: mt76: mt7996: rework mt7996_mac_sta_poll to support MLO
       wifi: mt76: mt7996: rework mt7996_update_mu_group to support MLO
       wifi: mt76: mt7996: rework mt7996_net_fill_forward_path to support MLO
       wifi: mt76: mt7996: set vif default link_id adding/removing vif links
       wifi: mt76: mt7996: rework mt7996_ampdu_action to support MLO
       wifi: mt76: mt7996: Update mt7996_tx to MLO support

Michael-CY Lee (1):
       wifi: mt76: mt7996: remove unnecessary key->cipher check for BIP frames

Ming Yen Hsieh (16):
       wifi: mt76: mt7925: introduce MLO capability control
       wifi: mt76: mt7925: ensure wow pattern command align fw format
       wifi: mt76: mt7925: fix country count limitation for CLC
       wifi: mt76: mt7921: fix kernel panic due to null pointer dereference
       wifi: mt76: mt7925: fix the wrong link_idx when a p2p_device is present
       wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
       wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
       wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
       wifi: mt76: mt7925: update the power-saving flow
       wifi: mt76: mt7925: load the appropriate CLC data based on hardware type
       wifi: mt76: mt7925: add EHT control support based on the CLC data
       wifi: mt76: mt7925: update the channel usage when the regd domain changed
       wifi: mt76: mt7925: remove unused acpi function for clc
       wifi: mt76: mt792x: extend MTCL of APCI to version3 for EHT control
       wifi: mt76: mt7925: add MTCL support to enhance the regulatory compliance
       wifi: mt76: mt792x: re-register CHANCTX_STA_CSA only for the mt7921 series

Nikita Zhandarovich (1):
       wifi: mt76: mt7915: fix possible integer overflows in mt7915_muru_stats_show()

Quan Zhou (2):
       wifi: mt76: mt7925: fix fails to enter low power mode in suspend state
       wifi: mt76: mt7925: Simplify HIF suspend handling to avoid suspend fail

Razvan Grigore (3):
       wifi: mt76: add mt76_get_power_bound helper function
       wifi: mt76: mt7915: cleanup mt7915_get_power_bound
       wifi: mt76: mt7996: cleanup mt7996_get_power_bound

Rex Lu (1):
       wifi: mt76: mt7996: fix SER reset trigger on WED reset

Sean Wang (1):
       Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"

Shayne Chen (16):
       wifi: mt76: mt7996: Add mt7996_mac_sta_change_links callback
       wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()
       wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support
       wifi: mt76: mt7996: Rely on mt7996_vif_link in mt7996_mcu_twt_agrt_update signature
       wifi: mt76: mt7996: Update mt7996_mcu_add_rate_ctrl to MLO
       wifi: mt76: mt7996: Add mt7996_mcu_sta_mld_setup_tlv() and mt7996_mcu_sta_eht_mld_tlv()
       wifi: mt76: mt7996: Add mt7996_mcu_teardown_mld_sta rouine
       wifi: mt76: mt7996: rework mt7996_mac_write_txwi() for MLO support
       wifi: mt76: mt7996: Rely on wcid_to_sta in mt7996_mac_add_txs_skb()
       wifi: mt76: mt7996: rework mt7996_rx_get_wcid to support MLO
       wifi: mt76: mt7996: rework mt7996_sta_set_4addr and mt7996_sta_set_decap_offload to support MLO
       wifi: mt76: mt7996: rework mt7996_set_hw_key to support MLO
       wifi: mt76: mt7996: remove mt7996_mac_enable_rtscts()
       wifi: mt76: mt7996: rework mt7996_mcu_add_obss_spr to support MLO
       wifi: mt76: mt7996: rework mt7996_mcu_beacon_inband_discov to support MLO
       wifi: mt76: mt7996: rework set/get_tsf callabcks to support MLO

Thorsten Blum (1):
       wifi: mt76: mt7925: Remove unnecessary if-check

  drivers/net/wireless/mediatek/mt76/channel.c          |   3 +
  drivers/net/wireless/mediatek/mt76/eeprom.c           |   4 +
  drivers/net/wireless/mediatek/mt76/mac80211.c         |  16 ++-
  drivers/net/wireless/mediatek/mt76/mt76.h             |   8 ++
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |   3 +
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |   6 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |   3 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   3 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |   3 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |  53 ++++----
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |  12 --
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt7925/init.c      |  96 ++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7925/main.c      | 164 ++++++++++++++++--------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       | 274 ++++++++++++++++++++++-----------------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h       |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h    |  36 +++++-
  drivers/net/wireless/mediatek/mt76/mt792x.h           |  19 ++-
  drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c  | 123 ++++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h  |  18 ++-
  drivers/net/wireless/mediatek/mt76/mt792x_core.c      |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   |  56 +++++---
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 305 +++++++++++++++++++++++++++++---------------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c      | 984 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       | 638 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h       |  47 +++++--
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    |  79 ++++++++----
  drivers/net/wireless/mediatek/mt76/scan.c             |  21 +--
  drivers/net/wireless/mediatek/mt76/tx.c               |   3 +-
  32 files changed, 2056 insertions(+), 944 deletions(-)

