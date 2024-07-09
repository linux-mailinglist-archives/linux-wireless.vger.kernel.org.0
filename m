Return-Path: <linux-wireless+bounces-10136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D4092C51B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 23:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323AB1F22B77
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A617B025;
	Tue,  9 Jul 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JZuwBqIx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443B14D2A7
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559043; cv=none; b=ZGb8IVKh4Nv9O9G6PY4NglG3Nq3e8uWgNiRY3E+MNwOkijdV5IqC66vZPInpJ3D8LOMirHt4fKHj+W7aHSpO+FcpMop3Z8+LpO1loXZU+A2H+aNfg/ZALDrweRwRi5a2VGruuxacwsYfAZc99x2mblB5iwN/7Zolj6nfngVE1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559043; c=relaxed/simple;
	bh=Sye0B1KmHQ8PlProJBxU9MOTjuX/T4ofaLwUTZsyQ4g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ZZGowG756hpnPzuNqTihJzkJjlMU98reV2nwHE6wFo2Z/B/MX1/I9ggb7dKZchJl4OF9gFAgDEWpmdpLIxBeP5C5x8Qt8+sbsRNTLAboiIcfJfgbBg62aMW9oGWeUN17lmu3vai0CaUWIq3+JEcnbTM2tfzyXd+Mbv30/MWdc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JZuwBqIx; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aZc02w3bOioVu8IKfJpd4tQWPc29xYkqWZYKEYoLcxw=; b=JZuwBqIxXxlWXJ7NXl9DiUlOPP
	AA+cBv8j39MDPtJntrbmweBHtGDxxR7QjaL/f1gYl6BOjzp2DunobLXHWlHz/H3JGZE+99crMO74G
	DzH84qmpq2qRHL3J6zU1oyvVpRoTGn+KIziqEdNQeqneZOXCuUVTkdTFtvRcl5XifM0A=;
Received: from p54ae937c.dip0.t-ipconnect.de ([84.174.147.124] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sRI07-004ZqP-2t;
	Tue, 09 Jul 2024 23:03:51 +0200
Message-ID: <9ed43730-67ff-48d5-a778-ae897ee9295a@nbd.name>
Date: Tue, 9 Jul 2024 23:03:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2024-07-08 v3
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
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

Hi Kalle,

here's another update for my first request for 6.11. It fixes the committer
signed-off-by warning.

- Felix

The following changes since commit 0321e45737b8a1a7571edad9b4173fbb7b86c0ed:

   Merge tag 'rtw-next-2024-07-05' of https://github.com/pkshih/rtw (2024-07-09 13:17:09 +0300)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-07-08

for you to fetch changes up to d53ab629cff57e450fe69fc90eb1ddc372e8da2d:

   wifi: mt76: mt792x: fix scheduler interference in drv own process (2024-07-09 23:02:10 +0200)

----------------------------------------------------------------
mt76 patches for 6.11

- mt7925 MLO support
- mt7925 fix

----------------------------------------------------------------
Deren Wu (5):
       wifi: mt76: mt792x: add struct mt792x_bss_conf
       wifi: mt76: mt792x: add struct mt792x_link_sta
       wifi: mt76: mt792x: add struct mt792x_chanctx
       wifi: mt76: mt7925: support for split bss_info_changed method
       wifi: mt76: mt7925: extend mt7925_mcu_set_tx with for per-link BSS

Michael Lo (1):
       wifi: mt76: mt792x: fix scheduler interference in drv own process

Sean Wang (79):
       wifi: mt76: mt792x: extend mt76_connac_mcu_uni_add_dev for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_set_timing for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_bss_ifs_tlv for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_bss_color_tlv for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_bss_qos_tlv for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_bss_bmc_tlv for per-link BSS
       wifi: mt76: mt7925: remove unused parameters in mt7925_mcu_bss_bmc_tlv
       wifi: mt76: mt7925: extend mt7925_mcu_bss_sec_tlv for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_set_bss_pm for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_[abort, set]_roc for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_bcnft for per-link BSS
       wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_ps for per-link BSS
       wifi: mt76: mt7925: add mt7925_mcu_bss_rlm_tlv to constitue the RLM TLV
       wifi: mt76: mt7925: mt7925_mcu_set_chctx rely on mt7925_mcu_bss_rlm_tlv
       wifi: mt76: mt7925: extend mt7925_mcu_sta_update for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_state_v2_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_rate_ctrl_tlv with per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_eht_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_he_6g_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_he_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_amsdu_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_vht_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_ht_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_phy_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_get_phy_mode_ext for per-link STA
       wifi: mt76: mt7925: extend mt7925_get_phy_mode for per-link STA
       wifi: mt76: mt792x: extend mt76_connac_get_phy_mode_v2 for per-link STA
       wifi: mt76: mt762x: extend mt76_connac_mcu_sta_basic_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_sta_hdr_trans_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link STA
       wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link STA
       wifi: mt76: mt7925: add mt7925_mac_link_sta_add to create per-link STA
       wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to associate per-link STA
       wifi: mt76: mt7925: add mt7925_mac_link_sta_remove to remove per-link STA
       wifi: mt76: mt7925: add mt7925_mac_link_bss_add to create per-link BSS
       wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link BSS
       wifi: mt76: mt7925: simpify mt7925_mcu_sta_cmd logic by removing fw_offload
       wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
       wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO
       wifi: mt76: mt7925: set Tx queue parameters according to link id
       wifi: mt76: mt7925: set mt7925_mcu_sta_key_tlv according to link id
       wifi: mt76: mt7925: add mt7925_set_link_key
       wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event
       wifi: mt76: mt7925: add mt7925_change_vif_links
       wifi: mt76: mt7925: add mt7925_change_sta_links
       wifi: mt76: mt7925: add link handling in mt7925_mac_sta_add
       wifi: mt76: mt7925: add link handling in mt7925_mac_sta_remove
       wifi: mt76: mt7925: add link handling to txwi
       wifi: mt76: mt7925: add link handling in mt7925_set_key
       wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
       wifi: mt76: mt7925: add link handling in the BSS_CHANGED_PS handler
       wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
       wifi: mt76: mt7925: add link handling in mt7925_txwi_free
       wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
       wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload
       wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter
       wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER handler
       wifi: mt76: mt7925: add link handling in the mt7925_ipv6_addr_change
       wifi: mt76: mt7925: update rate index according to link id
       wifi: mt76: mt7925: report link information in rx status
       wifi: mt76: add def_wcid to struct mt76_wcid
       wifi: mt76: mt7925: add mt7925_[assign,unassign]_vif_chanctx
       wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO
       wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
       wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
       wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
       wifi: mt76: mt7925: add mt7925_mcu_sta_eht_mld_tlv for MLO
       wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
       wifi: mt76: mt7925: update mt7925_mcu_sta_phy_tlv for MLO
       wifi: mt76: mt7925: update mt7925_mcu_set_timing for MLO
       wifi: mt76: mt7925: update mt7925_mcu_bss_basic_tlv for MLO
       wifi: mt76: mt7925: update mt7925_mac_link_bss_add for MLO
       wifi: mt76: mt7925: remove the unused mt7925_mcu_set_chan_info
       wifi: mt76: mt7925: enabling MLO when the firmware supports it

  drivers/net/wireless/mediatek/mt76/mac80211.c        |    5 +
  drivers/net/wireless/mediatek/mt76/mt76.h            |    8 +
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |   10 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |   58 ++++----
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   30 +++-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |    6 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |   66 +++++----
  drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  143 +++++++++---------
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |   46 +++---
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |    3 +
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  |    4 +-
  drivers/net/wireless/mediatek/mt76/mt7925/init.c     |    6 +
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c      |  141 +++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7925/main.c     | 1119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  981 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      |   65 +++++++-
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h   |   31 ++--
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c      |    3 +
  drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c  |    6 +-
  drivers/net/wireless/mediatek/mt76/mt792x.h          |  105 ++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt792x_core.c     |  111 ++++++++++----
  drivers/net/wireless/mediatek/mt76/mt792x_mac.c      |    8 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      |    7 +-
  drivers/net/wireless/mediatek/mt76/pci.c             |   23 +++
  24 files changed, 2117 insertions(+), 868 deletions(-)

