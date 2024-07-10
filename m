Return-Path: <linux-wireless+bounces-10148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08392D10A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 13:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E42C285F22
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422918FA39;
	Wed, 10 Jul 2024 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqKkzS9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452718F2FB
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612349; cv=none; b=QizVwxzrhthZznBaUZQvvIJGd6ftyaK3X1ZsC/ffhGscH6/h1E1ZAQCZbvZVd8oo7ii+MUiZBpUQt9ncoZZmurx5g4hVLODWVY3njyGL0cZUhzsynl8y2X4IW+mqIgIGh7nGUohbaqTLBj7wv6G9n9UnU7vkSo7WRIBJPKeIkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612349; c=relaxed/simple;
	bh=IsmvNuGBxqIlXerv/h6L/h4/barlgJftR57820v73Vk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=YG1bM0S0R+R8FbWlCLKnLpfHCNsjjmI/xkN8hCdsfOjJu0jB43OtqtZuDauEGpPMbbfCRKdSJZCcksDboaFqOCK9wevsapV2Y7xnkIFxNmj4/b5jdZN7nWeH+0g8Jxd7Y23h7qyYqSRn+La4u4PgEXLFVlNb1Y/LGKThzj1FGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqKkzS9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90A9C32781;
	Wed, 10 Jul 2024 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720612349;
	bh=IsmvNuGBxqIlXerv/h6L/h4/barlgJftR57820v73Vk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=uqKkzS9N2/8mltfcDzC6/MU3fSOr6hT7B2NdNtnciLPgpF34vN3xRvXg8uQ7nUaiE
	 yqH6rmECLSi107e3AlGu3++pgyeRKWTU5zmX5edZNZ0mtb+u5FFa6NmAx/PtHPX4FD
	 o74f4FHCk3l7NAIOLBZB2itKrUYWKqjB8bYPd2BjGNtHwzdrzPOL20vhlPc2kWOHQA
	 ezyroVCQV42dsirbbiKP+lPOVlvILGOwwZMaYj8AnP/x6eC5LyN7IglTdXuLbED8+m
	 vl8OCZGEjw0GhwQdn/hUp4mDjFm2vjfAi0xT65exywueFVlTpWT8oLTdttQOoOnyCH
	 U5fe2Gckb/b6g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2024-07-08 v3
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <9ed43730-67ff-48d5-a778-ae897ee9295a@nbd.name>
References: <9ed43730-67ff-48d5-a778-ae897ee9295a@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172061234688.1132794.1700022662616792081.kvalo@kernel.org>
Date: Wed, 10 Jul 2024 11:52:28 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's another update for my first request for 6.11. It fixes the committer
> signed-off-by warning.
> 
> - Felix
> 
> The following changes since commit 0321e45737b8a1a7571edad9b4173fbb7b86c0ed:
> 
>    Merge tag 'rtw-next-2024-07-05' of https://github.com/pkshih/rtw (2024-07-09 13:17:09 +0300)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-07-08
> 
> for you to fetch changes up to d53ab629cff57e450fe69fc90eb1ddc372e8da2d:
> 
>    wifi: mt76: mt792x: fix scheduler interference in drv own process (2024-07-09 23:02:10 +0200)
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

dabcfd5e1168 Merge tag 'mt76-for-kvalo-2024-07-08' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/9ed43730-67ff-48d5-a778-ae897ee9295a@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


