Return-Path: <linux-wireless+bounces-14642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907E9B4DFC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0831F23A83
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D97194AD6;
	Tue, 29 Oct 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKEDQhhg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D3194AD1
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215777; cv=none; b=fsL6Hrvey3dzVZuh35NuB+IDMAM2g/tXiozRCoGWdz3yt+WwOPv4YgJUk/cg7/CKno1HZNU3AU7LxaymGjcUodtpX7LrB5bavovy0OBPHODaJCV6vbwseLFHbj4Fc6aVQH97roJ7t3MHwmf15IWls4wnvoKAbn5NFQDcVOh1NhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215777; c=relaxed/simple;
	bh=jVF6P/ogG/ibV5uI1RXvZ7DnU+aL+cl/ZwkSts+NohQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kV6Tg05e6RzpTNcu3aFNN/G/tF21XXMDD4M0pg+Xyrp9V+6/Xp5M+LNp5ztxfqJvqyp30E6q/SXaGIgacsc0EEXZT4RE/bUXKCUdReNo7GknmuOeGz3V27Ka9IEYfGF0nmqifwZXknMYTowfyz9RP2kxAgxUr8LFHWIN+kMotKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKEDQhhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8185C4CECD;
	Tue, 29 Oct 2024 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730215776;
	bh=jVF6P/ogG/ibV5uI1RXvZ7DnU+aL+cl/ZwkSts+NohQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fKEDQhhgDmqVAgseHSYznUlusXemNhmPICz1kjOqP7nnqbsnjvdNhCIGkBDiNn+jl
	 3SeIXXcenkeISNrJqmI/hTR4aZ3sHEHPmoi08RgrBduLKWYo7uziGf0ArFVNQp1JQK
	 iPGmeLGwo5xYYEOYsQspsagsAqL5FDQZAeLud/WCP+ouEfRBx8erHXyZsLnacya1ky
	 zeUD9LDhUqHUFIwvZoiiVMXz20dOpkAkjFESP7QmhI4q107bvcN8M8Jwn8FN/oENHS
	 yUuu++lG1y9SETYELq0ccxu0/rFYJWd+YSQwbhnXFoGyVxjAMgXGBzP/UaKCDjFXeB
	 DlbyvGqq9gVJA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/8] wifi: ath12k: Refactor sta state machine
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-4-kvalo@kernel.org>
	<a4b92b80-ec57-4db3-acd7-9c6c7644d7c9@quicinc.com>
Date: Tue, 29 Oct 2024 17:29:33 +0200
In-Reply-To: <a4b92b80-ec57-4db3-acd7-9c6c7644d7c9@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 08:38:09 -0700")
Message-ID: <87a5engc6a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/23/2024 6:29 AM, Kalle Valo wrote:
>
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
>
> I've mentioned this in the past in some internal discussion and seems now is a
> good time to bring this to light.
>
> It concerns me that this happens so late in the process. In theory another
> thread could already have a valid arsta pointer and could be trying to
> dereference that pointer while the code above is destroying underlying data
> (i.e. arsta->rx_stats).
>
> Should we set this to NULL and synchronize RCU at the beginning of the process
> so that we know all access to the struct has finished before we start
> destroying the data?
>
> Or can this not actually happen in practice due to other synchronization
> mechansims? And if so, should we document that somewhere?

I think you are correct, AFAICS the kfree(arsta->rx_stats) should be
after synchronize_rcu(). But this race was already in the code before
this patch so we need to fix in a separate patch. I have added this to
my todo list.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

