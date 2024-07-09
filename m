Return-Path: <linux-wireless+bounces-10135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB6A92C452
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD28C1C220A6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BCB182A7B;
	Tue,  9 Jul 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwHAPkty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB966182A7A
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555681; cv=none; b=HB4JsImnFg5U7v9ysYJH/0ebJcE63bq6lyBvryyHhJJq+rud2Hsch6M7B2ejkZHAYg1IwitGhF4nMxEOeDVojDgQDInI2uhZrpYGYtCP5VGuUKveQwTUnsqmsY+Z6gA6H2Z9qve35QDJjZZV00QBLeIlvk7PWmv3rS0tIGkOSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555681; c=relaxed/simple;
	bh=Tw/01zxCmta7SGCzMkX8NN9K7f5rLHKfOOnDI07TxAo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Yp8RiJIK1tH6/LMKX3TJfbQISKXvOL168MvsZiyjZy3zZenHm6KNtnsamwaH1qRD602X5B5kvPooruJUjU1ukPwnPc4jQNgFFJv8k9QBdMee8b2kM6jEOPN59SvgUqSV9LGe672PIZZMAxFDOKO80PqoE6xJjSttJ45SjG6NMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwHAPkty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F9C3277B;
	Tue,  9 Jul 2024 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720555681;
	bh=Tw/01zxCmta7SGCzMkX8NN9K7f5rLHKfOOnDI07TxAo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PwHAPktyjzQycrZl3FPsVTaIk7GGQjKvsh9WudThiBX6W9c8DLuNPUH2J9VK26iwa
	 ywaol5BfMgZCoLgiOIcjiZpWBkD4e2Up3CUAF8Vm6oGz23a9xRhnKAXZIDUWLYbdms
	 zRbxBwkzRf+P8CzBZZa6Kh72ku1+KHXASzNlyYisbhHYec3pKG/zJ/vyevNFx9Ywdp
	 6oDlxAYyU87kVnMzKlbctsBHDZYk3BKkSh71pmo4alpqXFU8PlMexiy2wItqbdRk9S
	 mvuyUVcwgkxx+Jh5ZVO2d2iPUr76lzykGyA8E6a9wEmqTTWgeAOqSHmo7E8xipJme+
	 bvzBfzAN13bvw==
From: Kalle Valo <kvalo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2024-07-08 v2
References: <eb892396-129e-473a-916e-90da59ab386f@nbd.name>
	<172055535619.956518.13634370123776636302.kvalo@kernel.org>
Date: Tue, 09 Jul 2024 23:07:58 +0300
In-Reply-To: <172055535619.956518.13634370123776636302.kvalo@kernel.org>
	(Kalle Valo's message of "Tue, 9 Jul 2024 20:02:37 +0000 (UTC)")
Message-ID: <87a5iqmiqp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Felix Fietkau <nbd@nbd.name> wrote:
>
>> Hi Kalle,
>> 
>> here's an update for my first request for 6.11. It fixes the sparse
>> errors
>> 
>> - Felix
>> 
>> The following changes since commit 1b431ba4ef9a760e7643d6fbc53bf522d59650f3:
>> 
>>    wifi: iwlwifi: mvm: re-enable MLO (2024-07-04 13:50:10 +0200)
>> 
>> are available in the Git repository at:
>> 
>>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-07-08
>> 
>> for you to fetch changes up to c9e23794c12486851076160656d0d18c3490b956:
>> 
>>    wifi: mt76: mt792x: fix scheduler interference in drv own process (2024-07-08 11:58:05 -0700)
>> 
>> ----------------------------------------------------------------
>> mt76 patches for 6.11
>> 
>> - mt7925 MLO support
>> - mt7925 fix
>> 
>> ----------------------------------------------------------------
>> Deren Wu (5):
>>        wifi: mt76: mt792x: add struct mt792x_bss_conf
>>        wifi: mt76: mt792x: add struct mt792x_link_sta
>>        wifi: mt76: mt792x: add struct mt792x_chanctx
>>        wifi: mt76: mt7925: support for split bss_info_changed method
>>        wifi: mt76: mt7925: extend mt7925_mcu_set_tx with for per-link BSS
>> 
>> Michael Lo (1):
>>        wifi: mt76: mt792x: fix scheduler interference in drv own process
>> 
>> Sean Wang (79):
>>        wifi: mt76: mt792x: extend mt76_connac_mcu_uni_add_dev for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_set_timing for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_ifs_tlv for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_color_tlv for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_qos_tlv for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_bmc_tlv for per-link BSS
>>        wifi: mt76: mt7925: remove unused parameters in mt7925_mcu_bss_bmc_tlv
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_sec_tlv for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_set_bss_pm for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_[abort, set]_roc for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_bcnft for per-link BSS
>>        wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_ps for per-link BSS
>>        wifi: mt76: mt7925: add mt7925_mcu_bss_rlm_tlv to constitue the RLM TLV
>>        wifi: mt76: mt7925: mt7925_mcu_set_chctx rely on mt7925_mcu_bss_rlm_tlv
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_update for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_state_v2_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_rate_ctrl_tlv with per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_eht_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_he_6g_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_he_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_amsdu_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_vht_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_ht_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_phy_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_get_phy_mode_ext for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_get_phy_mode for per-link STA
>>        wifi: mt76: mt792x: extend mt76_connac_get_phy_mode_v2 for per-link STA
>>        wifi: mt76: mt762x: extend mt76_connac_mcu_sta_basic_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_sta_hdr_trans_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link STA
>>        wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link STA
>>        wifi: mt76: mt7925: add mt7925_mac_link_sta_add to create per-link STA
>>        wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to associate per-link STA
>>        wifi: mt76: mt7925: add mt7925_mac_link_sta_remove to remove per-link STA
>>        wifi: mt76: mt7925: add mt7925_mac_link_bss_add to create per-link BSS
>>        wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link BSS
>>        wifi: mt76: mt7925: simpify mt7925_mcu_sta_cmd logic by removing fw_offload
>>        wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
>>        wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO
>>        wifi: mt76: mt7925: set Tx queue parameters according to link id
>>        wifi: mt76: mt7925: set mt7925_mcu_sta_key_tlv according to link id
>>        wifi: mt76: mt7925: add mt7925_set_link_key
>>        wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event
>>        wifi: mt76: mt7925: add mt7925_change_vif_links
>>        wifi: mt76: mt7925: add mt7925_change_sta_links
>>        wifi: mt76: mt7925: add link handling in mt7925_mac_sta_add
>>        wifi: mt76: mt7925: add link handling in mt7925_mac_sta_remove
>>        wifi: mt76: mt7925: add link handling to txwi
>>        wifi: mt76: mt7925: add link handling in mt7925_set_key
>>        wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
>>        wifi: mt76: mt7925: add link handling in the BSS_CHANGED_PS handler
>>        wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
>>        wifi: mt76: mt7925: add link handling in mt7925_txwi_free
>>        wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
>>        wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload
>>        wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter
>>        wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER handler
>>        wifi: mt76: mt7925: add link handling in the mt7925_ipv6_addr_change
>>        wifi: mt76: mt7925: update rate index according to link id
>>        wifi: mt76: mt7925: report link information in rx status
>>        wifi: mt76: add def_wcid to struct mt76_wcid
>>        wifi: mt76: mt7925: add mt7925_[assign,unassign]_vif_chanctx
>>        wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO
>>        wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
>>        wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
>>        wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
>>        wifi: mt76: mt7925: add mt7925_mcu_sta_eht_mld_tlv for MLO
>>        wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
>>        wifi: mt76: mt7925: update mt7925_mcu_sta_phy_tlv for MLO
>>        wifi: mt76: mt7925: update mt7925_mcu_set_timing for MLO
>>        wifi: mt76: mt7925: update mt7925_mcu_bss_basic_tlv for MLO
>>        wifi: mt76: mt7925: update mt7925_mac_link_bss_add for MLO
>>        wifi: mt76: mt7925: remove the unused mt7925_mcu_set_chan_info
>>        wifi: mt76: mt7925: enabling MLO when the firmware supports it
>> 
>>   drivers/net/wireless/mediatek/mt76/mac80211.c        |    5 +
>>   drivers/net/wireless/mediatek/mt76/mt76.h            |    8 +
>>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |   10 +-
>>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |   58 ++++----
>>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   30 +++-
>>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |    6 +-
>>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |   66 +++++----
>>   drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  143 +++++++++---------
>>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |   46 +++---
>>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |    3 +
>>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  |    4 +-
>>   drivers/net/wireless/mediatek/mt76/mt7925/init.c     |    6 +
>>   drivers/net/wireless/mediatek/mt76/mt7925/mac.c      |  141 +++++++++++-------
>>   drivers/net/wireless/mediatek/mt76/mt7925/main.c     | 1119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
>>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  981 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------
>>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      |   65 +++++++-
>>   drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h   |   31 ++--
>>   drivers/net/wireless/mediatek/mt76/mt7925/pci.c      |    3 +
>>   drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c  |    6 +-
>>   drivers/net/wireless/mediatek/mt76/mt792x.h          |  105 ++++++++++++-
>>   drivers/net/wireless/mediatek/mt76/mt792x_core.c     |  111 ++++++++++----
>>   drivers/net/wireless/mediatek/mt76/mt792x_mac.c      |    8 +-
>>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      |    7 +-
>>   drivers/net/wireless/mediatek/mt76/pci.c             |   23 +++
>>   24 files changed, 2117 insertions(+), 868 deletions(-)
>
> Pulled, thanks.
>
> 20db19eae833 Merge tag 'mt76-for-kvalo-2024-07-08' of https://github.com/nbd168/wireless

Actually I'll take that back. I see a new warning in v2:

Commit

  c9e23794c124 ("wifi: mt76: mt792x: fix scheduler interference in drv own process")
is missing a Signed-off-by from its committer.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

