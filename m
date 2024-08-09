Return-Path: <linux-wireless+bounces-11225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DC294D22F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D075281866
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A5195FEA;
	Fri,  9 Aug 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Biu17mnn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E812197A88
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213748; cv=none; b=D0yQ/Dhk14dlC6iioZc0/ZVE6e+u0G3IpF7YzxvRk/Rd7yebg39a5NHHLfvTDrcp0vyVQOfXSMtfSftANdHqd41Pe/IF4XFh72kwTPPWH9GwqlMycmmX9HSVWbyucalvucHXsUH/tbrkZgGLR+zhpf1fFP9TjBhe4/pKAQ3NgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213748; c=relaxed/simple;
	bh=1DpMIwjYrxzhcdFiyt6vv5L5bslGMP21p/QGue97o+I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ncJa+1ZTcsrfueYT0hTDDA6PamKi2VK7qckghk3j4qiq+J8yADx7NBTnwQVuQOLoUxPvUYfVK3IiB6UINn6c6C3tJz6kywjv+53T6CfH9BnZ61CRIUrOkNg1LUkY9NLN3TxrjYUrZYfxvl7C3mpmN095iCOdexplJocBWCjjrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Biu17mnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D31AC4AF0E;
	Fri,  9 Aug 2024 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723213748;
	bh=1DpMIwjYrxzhcdFiyt6vv5L5bslGMP21p/QGue97o+I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Biu17mnn57A5Mv1km4BvauhVsPdR9zEpZxQ3umEJbDQualSozkC+ddqeJ1vsNhFFb
	 HcehSlbEWiw2UXUc+b0jDxC3P8Suj/eI55geDec3kzup0hL5hfvz/yfCjjrTxonkqA
	 GxzZxLsWPw4ZCTyX/rXVs9RySLMNXbJBl2CLIO+0GjtxP25axl/+VZZg/TQWmyx4Qj
	 wRf0DCGMdxZUNoW0H7ZUR38/ZfEBXFaZj4Ugu1J1b9Yjt572xzFcQgtHzVkigpppr6
	 AtKAOWoY0i0RC8wp8F2eBVRDQ0fLI5ZvqEMaQmA5HM9u5djeujqx6Agd4OSith2uYF
	 Zh8x6wuLeFjkA==
From: Kalle Valo <kvalo@kernel.org>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Sriram
 R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
	<20240711165511.3100433-2-quic_ramess@quicinc.com>
	<87frrj70nz.fsf@kernel.org> <87sevf2seg.fsf@kernel.org>
	<2b78c227-ef2e-4d98-baf3-762e4f5bd155@quicinc.com>
Date: Fri, 09 Aug 2024 17:29:05 +0300
In-Reply-To: <2b78c227-ef2e-4d98-baf3-762e4f5bd155@quicinc.com> (Rameshkumar
	Sundaram's message of "Thu, 8 Aug 2024 22:12:26 +0530")
Message-ID: <87bk213h3i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:

> On 8/8/2024 4:27 PM, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>> 
>>> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
>>>
>>>> Locking:
>>>>   Currently modifications to members of arvif and arsta are
>>>> protected by ar->conf_mutex
>>>>   and it stays as such.
>>>>   Now with these hw level structure (ahvif) being introduced, any modifications
>>>>   to its members and link objects (i.e., arvifs[] which are dynamically allocated)
>>>>   needs to be protected for writing and ah->conf_mutex is used for the same.
>>>>   Also, atomic contexts(say WMI events and certain mac_ops) that
>>>> we currently have in driver
>>>>   will not(shouldn't be allowed) do any modifications but can read them and
>>>>   rcu_read_lock() is used for the same.
>>>
>>> Please elaborate more about your locking design. Because of past bad
>>> contributions from Qualcomm the bar is really high for adding any new
>>> locks. I'm doing the locking analysis right now but it would help a lot
>>> if you could provide your own analysis.
>
> The new ah->conf_mutex is particularly introduced to protect the
> members and dynamically allocated link objects of ahvif and ahsta
> (ahvif/sta->links[]) in process context (i.e. between call backs from
> mac80211 and ath12k's workers)
> The same is protected by rcu in case of atomic contexts(tasklets of
> WMI and in datapath)

I need more info than that. I can't understand which conf_mutex protects
what data exactly, currently it just looks random to me.

Let's take an example:

static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
...
	mutex_lock(&ah->conf_mutex);
	arvif = &ahvif->deflink;
	ar = ath12k_get_ar_by_vif(hw, vif);
	if (!ar) {
		cache = ath12k_arvif_get_cache(arvif);
...

	mutex_lock(&ar->conf_mutex);

	ath12k_mac_bss_info_changed(ar, arvif, info, changed);

So first mac80211 calls ath12k_mac_op_bss_info_changed() with wiphy
mutex held. Then ath12k takes ah->conf_mutex and soon after also
ar->conf_mutex. So we are basically holding three locks and it's not
clear for me the difference between ah and ar mutexes. For example, do
ath12k_get_ar_by_vif() & ath12k_arvif_get_cache() require ah->conf_mutex
to be held? Or why are we taking it here?

I guess ahvif->deflink access does not require any protection because in
ath12k_mac_op_tx() we access ahvif->deflink without any protection:

	struct ath12k_link_vif *arvif = &ahvif->deflink;

Anyway, I just could not understand this locking design and besides it
just looks uncessarily complex. I propose dropping the new conf_mutex in
this patchset altogether and handle the locking in a separate patchset
later on.

AFAICS removing ah->conf_mutex from this patchset should be safe as
mac80211 is holding the wiphy mutex already. Of course I might have
missed something but at least that's what it looks like.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

