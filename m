Return-Path: <linux-wireless+bounces-14572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF089B1662
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 11:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA941C20DB9
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772A3178CEC;
	Sat, 26 Oct 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij1JNBhb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3D217F5E
	for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933722; cv=none; b=ubjki/2U0lmzr0QeKcbqoCvTaliL6broZfXfGcF3r1iKVI6OsZegH1z5/fP0E6m3H/CVe84fnRWwspMSfO5GW/8YaImSlEyw0Wzznc8+CKjrGQMnxa0Sj4v2vBM2fEXTj9nZ1l7Cfqkm/BhFntwaShJHhmM0SE34fRyP3+QUWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933722; c=relaxed/simple;
	bh=MbVYq5hP582/qyZUS1tqQD3SG2ii9UrEUkQvpbS/jLE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mPkqOYnsGS3ZprJ7vBc9br206O+ptQJ/39iVzWiZfolRy0Wz3JhapA3FDzNSQsvzkaD5er8RNnw/USr3FuCR5w8FFF9Nbc8+0ghmI9h59tAgU12OjWAaPTer2S07378fFZydqaW1wMV4+kTEbXeB4+lswFGleaMnQcSa6GNvFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij1JNBhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B517C4CEC6;
	Sat, 26 Oct 2024 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729933721;
	bh=MbVYq5hP582/qyZUS1tqQD3SG2ii9UrEUkQvpbS/jLE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ij1JNBhb2toHdck78qZ13KU3D4f0OmZljPlCtnHY4Rm0piNHUzBQLKSvWMMkYQfxz
	 DNq2wg+6RZvO64GD63O+gQjoT0DEaFwfXed1L7UeANUeIJVCE4LdyMDCV9zKKC4sJb
	 B7kKkVxum1wgwJONabJWoigxFNd/MaejU2eZZmx4hRxM3MtKtBmnSL9IxE/fYfifxc
	 y31C/z1Gi7XHFrvJf11J1U3iU2nnksPbVOal8qQoMBXe8NPBTYMKzppuItFbjRK+a1
	 78dEAkBanNccZUpOeDVR5LY9k/A/klay3Sv3tqdnNvgNRPnc2UMPaBqJMyutC4Llnm
	 5ps7oIBRdeltg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/8] wifi: ath12k: Refactor sta state machine
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-4-kvalo@kernel.org>
	<e886a4c0-14f9-4299-97ef-f8cd811c94e6@quicinc.com>
Date: Sat, 26 Oct 2024 12:08:39 +0300
In-Reply-To: <e886a4c0-14f9-4299-97ef-f8cd811c94e6@quicinc.com> (Baochen
	Qiang's message of "Thu, 24 Oct 2024 10:58:56 +0800")
Message-ID: <87o737kz8o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 10/23/2024 9:29 PM, Kalle Valo wrote:
>> +static void ath12k_mac_station_post_remove(struct ath12k *ar,
>> +					   struct ath12k_link_vif *arvif,
>> +					   struct ath12k_link_sta *arsta)
>> +{
>> +	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
>> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
>> +	struct ath12k_sta *ahsta = arsta->ahsta;
>> +	struct ath12k_peer *peer;
>> +
>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>> +
>> +	ath12k_mac_dec_num_stations(arvif, arsta);
>> +
>> +	spin_lock_bh(&ar->ab->base_lock);
>> +
>> +	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
>> +	if (peer && peer->sta == sta) {
>> +		ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
>> +			    vif->addr, arvif->vdev_id);
>> +		peer->sta = NULL;
>> +		list_del(&peer->list);
>> +		kfree(peer);
>> +		ar->num_peers--;
>> +	}
>> +
>> +	spin_unlock_bh(&ar->ab->base_lock);
>> +
>> +	kfree(arsta->rx_stats);
>> +	arsta->rx_stats = NULL;
>> +
>> +	if (arsta->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
>> +		rcu_assign_pointer(ahsta->link[arsta->link_id], NULL);
>> +		synchronize_rcu();
>> +		ahsta->links_map &= ~(BIT(arsta->link_id));
>
> should we put this ahead of rcu_assign_pointer()?

I agree, I'll do that in v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

