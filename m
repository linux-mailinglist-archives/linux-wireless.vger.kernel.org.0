Return-Path: <linux-wireless+bounces-14573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCEE9B166C
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5215281190
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6901C3301;
	Sat, 26 Oct 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjjKXTx0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB61C3038
	for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933789; cv=none; b=cMGNkAkJSL3aZGqonJsT8zXM1haZMrbxJNm0QdoXI3sYy5wvYhprBteHI2yz5w/t72jeJ3jx5ZtqU5gZV44+obb9na3zij0WEEskWFIbJy5JG/QsvUg1afg4JbwuM34UNu/32Oc8NZfEWFb6EYOq+qIns49M25JIXjlIgV8cx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933789; c=relaxed/simple;
	bh=GdSlBnU5mW6xXp7829fFirSG7AH/4sa35q2q65bh1/s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=poU5mOsXh5/vEw7Eh1eOSACLBQQTuNgkOcQq51otKLTGRrdBZ21OQQCh2gRFeX0Cxeux1jlb1rfhm9mywAs6wKGhGAmOlANWFy6tR76GYUd1+qCpSA6zagQ63n9ZoT0H8xMF6RG6XAVfZ3KL2pRgUxfSrwQDWoWMxDspIHP8rF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjjKXTx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AD1C4CEC6;
	Sat, 26 Oct 2024 09:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729933789;
	bh=GdSlBnU5mW6xXp7829fFirSG7AH/4sa35q2q65bh1/s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tjjKXTx0EDLJyDpYwqmlLteJi+DSeja8xk4hYcKLiiSMmkaVGEbnCraatkjjL1zuu
	 imPrDTldw0ciFXEVWEcS70Ub3pSpLp6MSmyIXAEwSzfwICG5gfGypna8FwCntoVYy5
	 dwODwT4cykaZ2sYAwthcqnujcfF+xmEiJzol1KXbMCjx0OQqqCBbjfiU+NksISL6Xc
	 T/huWa0jpcrC56wnd4KpfzNhg0anw2rCWgl0SU7UEJTfrMPO9s9828CAH26eR26P1+
	 Fi3muMxnTIX+iqHE16DZRSodRNPNR9bwoZJU6kQQbZQhdgBOps5Wk7i1S/IpmJslpw
	 DRUqmGJngQujQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/8] wifi: ath12k: Add helpers for multi link peer
 creation and deletion
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-6-kvalo@kernel.org>
	<fdcc379d-b5ac-4554-8963-55653337db61@quicinc.com>
Date: Sat, 26 Oct 2024 12:09:46 +0300
In-Reply-To: <fdcc379d-b5ac-4554-8963-55653337db61@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 08:43:44 -0700")
Message-ID: <87jzdvkz6t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/23/2024 6:30 AM, Kalle Valo wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>> 
>> Add helper functions for multi link peer addition and deletion. And add address
>> validation to ensure we are not creating link peers (belonging to different
>> clients) with same MLD address. To aid in this validation for faster lookup,
>> add a new list of ML peers to struct ath12k_hw::ml_peers and use the same for
>> parsing for the above address validation use cases.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
> ...
>> +int ath12k_peer_mlo_create(struct ath12k_hw *ah, struct ieee80211_sta *sta)
>> +{
>> +	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
>> +	struct ath12k_ml_peer *ml_peer;
>> +
>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>> +
>> +	if (!sta->mlo)
>> +		return -EINVAL;
>> +
>> +	ml_peer = ath12k_ml_peer_find(ah, sta->addr);
>> +	if (ml_peer) {
>> +		ath12k_hw_warn(ah, "ML peer (%d) exists already, unable to add new entry for %pM",
>
> The Linux coding style says:
> Printing numbers in parentheses (%d) adds no value and should be avoided.

Good point, I'll remove them.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

