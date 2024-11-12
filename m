Return-Path: <linux-wireless+bounces-15211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682AE9C5CD1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 17:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F9283A25
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202C72040AF;
	Tue, 12 Nov 2024 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePK04v5n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE352040AB
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427398; cv=none; b=I8UUl/v3yGtiTHHVDcIy+WuvRPCZ90AT5jTRZ4LsIlb8NmouyUEieQEASe7zKZ4OeIYg4oOEzldVUZQ3726TzUAfwQ69PldlUSzRuvIva0MiWUMBdfz3WDXNd30C6Jma7C7kDcpmSJfhAyTIeKC7D5klMrm99qoWgR7lnAGTNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427398; c=relaxed/simple;
	bh=8G4W4n8t/inFGN91oJVtFV80XrFO1IiQUQJw1iuNLMY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fXeoo9M8wmSg0zYBs9vcZ+pFmo4BMYMBcrYSD4eC0i6AicUMgrGlj7H7Wruy4myuyuAk+OkoatH3FFkyOqfgA/AzVS9E5DoRUtx8T/XUpCPDTtaqaGAghCJjXSRd4NJMgAQ4f40y/kL3upF05/qPNTRCOEvXGTnS+AAMpbPOD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePK04v5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16A6C4CECD;
	Tue, 12 Nov 2024 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731427396;
	bh=8G4W4n8t/inFGN91oJVtFV80XrFO1IiQUQJw1iuNLMY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ePK04v5nYEEI+lmSdA6zIJe3gquqkdyAFnF7LiP9ZS3oRVBhMEkRQgqd3Q3EQypql
	 9hJw/cg2tOZzX+4dEL7RCeSMq7I1EoKzZ07ZD0xPGXJDZ7x4IMseeJwOmhMjhGWL2d
	 cC2HYrNlK3N4l1EqSjOYbqeox+17r09cM0dwAcAx7wMOKBZIMj12dqN1nBfqprM6bv
	 ZKRxgEwYSwUw2C9IKjOyrECSnKR/sQC5br73qnFAnAkDvnhWl3UV3A5Y/E7rob4Flo
	 nsEJGIWbLVCR/YYAzUXD5HksqcqdRfyDUxQiHMFqMkKAQ2P6b3yq+D4NcxMDzsZ/0q
	 WhwbCHTCHUb/w==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
References: <20241106142617.660901-1-kvalo@kernel.org>
	<20241106142617.660901-2-kvalo@kernel.org>
	<f75d7222-514b-4c6f-985d-e6ffd67e317a@quicinc.com>
Date: Tue, 12 Nov 2024 18:03:13 +0200
In-Reply-To: <f75d7222-514b-4c6f-985d-e6ffd67e317a@quicinc.com> (Baochen
	Qiang's message of "Thu, 7 Nov 2024 10:26:56 +0800")
Message-ID: <877c984eym.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 11/6/2024 10:26 PM, Kalle Valo wrote:
>> +static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
>> +				      struct ath12k_sta *ahsta,
>> +				      struct ath12k_link_sta *arsta,
>> +				      struct ath12k_vif *ahvif,
>> +				      u8 link_id)
>> +{
>> +	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
>> +	struct ieee80211_link_sta *link_sta;
>> +	struct ath12k_link_vif *arvif;
>> +
>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>> +
>> +	if (!arsta || link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
>> +		return -EINVAL;
>> +
>> +	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
>> +	if (!arvif)
>> +		return -EINVAL;
>> +
>> +	memset(arsta, 0, sizeof(*arsta));
>> +
>> +	link_sta = wiphy_dereference(ah->hw->wiphy, sta->link[link_id]);
>> +	if (!link_sta)
>> +		return -EINVAL;
>> +
>> +	ether_addr_copy(arsta->addr, link_sta->addr);
>> +
>> +	/* logical index of the link sta in order of creation */
>> +	arsta->link_idx = ahsta->num_peer++;
>> +
>> +	arsta->link_id = link_id;
>> +	ahsta->links_map |= BIT(arsta->link_id);
>
> would be better to put this after rcu_assign_pointer()?

My thinking is that it's racy anyway so it doesn't really matter.
links_map is not really protected properly right now but luckily there's
only one function which accesses outside of the wiphy lock. My plan is
to fix that in a later patch.

>> +	arsta->arvif = arvif;
>> +	arsta->ahsta = ahsta;
>> +	arsta->state = IEEE80211_STA_NONE;
>> +	wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
>> +
>> +	rcu_assign_pointer(ahsta->link[link_id], arsta);
>> +
>> +	synchronize_rcu();
>
> what are we waiting for here?

That's a good question. I didn't analyse that thoroughly but I'm just
making sure here that all readers have access to the new arsta before we
return to mac80211. The delay shouldn't be that long anyway, I hope.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

