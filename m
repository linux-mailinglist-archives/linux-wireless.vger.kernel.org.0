Return-Path: <linux-wireless+bounces-10134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16392C449
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1CA1F22839
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 20:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048AA17B049;
	Tue,  9 Jul 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBAXCfOs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560F17B02B
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555358; cv=none; b=N/W286tf+fR+ucYWQBQDdb0d6nBCz1WpWVmm+rVbxR6WJ5Y2EiEubzcVdZSEv7YDjZQ+/lXK94kVr7oBv4CQ/KX6ugbrf7bGGnD9lx65sGp2EpwR9+vkcHHAkRQd5KYBQxaWlNN3R3eteGaiz9+BQ9NgGszFvwaGoberI9WEyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555358; c=relaxed/simple;
	bh=dieJWblD67X5Sp2dnJ71YOoMDK/m04t1zM+XKjoWsU8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=OPa7AnH05hhjtCDinG5nNAtVGnzUgonyvXK5RhS4uP2hxO0Us/Mayj9/Ah5Cu1Dq6k0EEe4V5iBXElQeAyNkqbiW0uTTJfgOtKdUnvNpNROLq7Mfck9lSkuEnc0Q0vh9ZcInnQmeUdicNwrAMKjijRZAYWvn3LIpBy7aveVvmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBAXCfOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91CDC3277B;
	Tue,  9 Jul 2024 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720555358;
	bh=dieJWblD67X5Sp2dnJ71YOoMDK/m04t1zM+XKjoWsU8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cBAXCfOszQ8fGMSli7qVsrm1iNABHEIpI6yVdjnhzUTGDXL/eCpagbYNuBp0nOnKi
	 7JGXqakOwPu1rYzFgsmQs5hTZnfvUeyzPRoJXOWdpZXB1tluYclpPOKEYJXBpidoY9
	 k1S/7G9YzkhNo+9YXLiEp/275g+MehRWMUcuQOTaoSLPhv+VNdKAstjIckW6+ig8jW
	 xPmDGeAMa/08Ce6nqxQppgmVTiOXCoopgAtpElzvibxyQcU9e3JXiZndaX2nUcltO2
	 LVM29zaQ1ZKDTuAxDJyp10ipX36Eqi3UtUdAFskSMu7P3Pfp3EA3+cfyjrtVAE4Elh
	 dmcVPxHuLSjHw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2024-07-08 v2
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <eb892396-129e-473a-916e-90da59ab386f@nbd.name>
References: <eb892396-129e-473a-916e-90da59ab386f@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172055535619.956518.13634370123776636302.kvalo@kernel.org>
Date: Tue,  9 Jul 2024 20:02:37 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's an update for my first request for 6.11. It fixes the sparse
> errors
> 
> - Felix
> 
> The following changes since commit 1b431ba4ef9a760e7643d6fbc53bf522d59650f3:
> 
>    wifi: iwlwifi: mvm: re-enable MLO (2024-07-04 13:50:10 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-07-08
> 
> for you to fetch changes up to c9e23794c12486851076160656d0d18c3490b956:
> 
>    wifi: mt76: mt792x: fix scheduler interference in drv own process (2024-07-08 11:58:05 -0700)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.11
> 
> - mt7925 MLO support
> - mt7925 fix
> 
> ----------------------------------------------------------------
> Deren Wu (5):
>        wifi: mt76: mt792x: add struct mt792x_bss_conf
>        wifi: mt76: mt792x: add struct mt792x_link_sta
>        wifi: mt76: mt792x: add struct mt792x_chanctx
>        wifi: mt76: mt7925: support for split bss_info_changed method
>        wifi: mt76: mt7925: extend mt7925_mcu_set_tx with for per-link BSS
> 
> Michael Lo (1):
>        wifi: mt76: mt792x: fix scheduler interference in drv own process
> 
> Sean Wang (79):
>        wifi: mt76: mt792x: extend mt76_connac_mcu_uni_add_dev for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_set_timing for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_ifs_tlv for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_color_tlv for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_qos_tlv for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_bmc_tlv for per-link BSS
>        wifi: mt76: mt7925: remove unused parameters in mt7925_mcu_bss_bmc_tlv
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_sec_tlv for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_set_bss_pm for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_[abort, set]_roc for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_bcnft for per-link BSS
>        wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_ps for per-link BSS
>        wifi: mt76: mt7925: add mt7925_mcu_bss_rlm_tlv to constitue the RLM TLV
>        wifi: mt76: mt7925: mt7925_mcu_set_chctx rely on mt7925_mcu_bss_rlm_tlv
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_update for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_state_v2_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_rate_ctrl_tlv with per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_eht_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_he_6g_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_he_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_amsdu_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_vht_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_ht_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_phy_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_get_phy_mode_ext for per-link STA
>        wifi: mt76: mt7925: extend mt7925_get_phy_mode for per-link STA
>        wifi: mt76: mt792x: extend mt76_connac_get_phy_mode_v2 for per-link STA
>        wifi: mt76: mt762x: extend mt76_connac_mcu_sta_basic_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_sta_hdr_trans_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link STA
>        wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link STA
>        wifi: mt76: mt7925: add mt7925_mac_link_sta_add to create per-link STA
>        wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to associate per-link STA
>        wifi: mt76: mt7925: add mt7925_mac_link_sta_remove to remove per-link STA
>        wifi: mt76: mt7925: add mt7925_mac_link_bss_add to create per-link BSS
>        wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link BSS
>        wifi: mt76: mt7925: simpify mt7925_mcu_sta_cmd logic by removing fw_offload
>        wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
>        wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO
>        wifi: mt76: mt7925: set Tx queue parameters according to link id
>        wifi: mt76: mt7925: set mt7925_mcu_sta_key_tlv according to link id
>        wifi: mt76: mt7925: add mt7925_set_link_key
>        wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event
>        wifi: mt76: mt7925: add mt7925_change_vif_links
>        wifi: mt76: mt7925: add mt7925_change_sta_links
>        wifi: mt76: mt7925: add link handling in mt7925_mac_sta_add
>        wifi: mt76: mt7925: add link handling in mt7925_mac_sta_remove
>        wifi: mt76: mt7925: add link handling to txwi
>        wifi: mt76: mt7925: add link handling in mt7925_set_key
>        wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
>        wifi: mt76: mt7925: add link handling in the BSS_CHANGED_PS handler
>        wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
>        wifi: mt76: mt7925: add link handling in mt7925_txwi_free
>        wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
>        wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload
>        wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter
>        wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER handler
>        wifi: mt76: mt7925: add link handling in the mt7925_ipv6_addr_change
>        wifi: mt76: mt7925: update rate index according to link id
>        wifi: mt76: mt7925: report link information in rx status
>        wifi: mt76: add def_wcid to struct mt76_wcid
>        wifi: mt76: mt7925: add mt7925_[assign,unassign]_vif_chanctx
>        wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO
>        wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
>        wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
>        wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
>        wifi: mt76: mt7925: add mt7925_mcu_sta_eht_mld_tlv for MLO
>        wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
>        wifi: mt76: mt7925: update mt7925_mcu_sta_phy_tlv for MLO
>        wifi: mt76: mt7925: update mt7925_mcu_set_timing for MLO
>        wifi: mt76: mt7925: update mt7925_mcu_bss_basic_tlv for MLO
>        wifi: mt76: mt7925: update mt7925_mac_link_bss_add for MLO
>        wifi: mt76: mt7925: remove the unused mt7925_mcu_set_chan_info
>        wifi: mt76: mt7925: enabling MLO when the firmware supports it
> 
>   drivers/net/wireless/mediatek/mt76/mac80211.c        |    5 +
>   drivers/net/wireless/mediatek/mt76/mt76.h            |    8 +
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |   10 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |   58 ++++----
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   30 +++-
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |    6 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |   66 +++++----
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  143 +++++++++---------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |   46 +++---
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |    3 +
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  |    4 +-
>   drivers/net/wireless/mediatek/mt76/mt7925/init.c     |    6 +
>   drivers/net/wireless/mediatek/mt76/mt7925/mac.c      |  141 +++++++++++-------
>   drivers/net/wireless/mediatek/mt76/mt7925/main.c     | 1119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  981 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      |   65 +++++++-
>   drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h   |   31 ++--
>   drivers/net/wireless/mediatek/mt76/mt7925/pci.c      |    3 +
>   drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c  |    6 +-
>   drivers/net/wireless/mediatek/mt76/mt792x.h          |  105 ++++++++++++-
>   drivers/net/wireless/mediatek/mt76/mt792x_core.c     |  111 ++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt792x_mac.c      |    8 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      |    7 +-
>   drivers/net/wireless/mediatek/mt76/pci.c             |   23 +++
>   24 files changed, 2117 insertions(+), 868 deletions(-)

Pulled, thanks.

20db19eae833 Merge tag 'mt76-for-kvalo-2024-07-08' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/eb892396-129e-473a-916e-90da59ab386f@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


