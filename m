Return-Path: <linux-wireless+bounces-11011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC896948F07
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 14:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F9C282040
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3C16EB40;
	Tue,  6 Aug 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAUK+xEq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8734545
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947314; cv=none; b=WPLZJamIsHwN1LXWEXWF0n5yff8jVhnpPJf4i+sbjZZTElWkmgrOkG++UUJ8Hw3rvAwYD8PCZpI0cbb3vWPjxaKpLPpcfxfqK3t5Pnsy6vAQ+hDxkRDumXCzQNtfENcZszakmKTd2z7MVuBJORmztIExnDu4mB4amaSoaJPTvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947314; c=relaxed/simple;
	bh=HdTMVRdc12tPj1LHH7gWkcRksixd5PCo1Ix+DBmm/+4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IUG87b0R8HAlERrH+t3Ot250MxQCnPPBGhzVqxm6EL+VcNoI8Q8fq6zEdulTp6mO9wT4ewD2l7WHe7BCouDFQXlg2aBwrDQxKQ4aD1FnWmCbD4VC3plVT/6ZbepQgvTLdRdQ06GlZiEpWLePvPwlZgw14pmk2m4xxj72Z8NVnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAUK+xEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280DAC32786;
	Tue,  6 Aug 2024 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722947314;
	bh=HdTMVRdc12tPj1LHH7gWkcRksixd5PCo1Ix+DBmm/+4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JAUK+xEqzffYMK0JpAmf0IiZmXUkA4DKE0Ed5a0/XqTk5Yfo+R59TUIcJ/XfR4w4O
	 1eyta/Wktf3cPl+SXAgFmJXAlZK0r225qcLDiiQVwDJcpLk6Smb6566pf2CT7JMD6M
	 lXWa7P+4sRA5Nz2v1HCRYA0rShYxh1ZJ1VN0+INFrGeNNFgb6CDkKGD8RL1EHjlNwr
	 4aWz/i+/IR5mockfRaBCauxO6lpaHHmqJYKpK36ZFWAT9i9yhbpTUYgyHhOq9NHu1A
	 j66+kZkz3KLcv8bet3Efh5BMaOOrfREZEeH9POlJx4yKRVsPgT4vbU3bVsVwpN1xXc
	 ksfXUwk1OhN0A==
From: Kalle Valo <kvalo@kernel.org>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Sriram
 R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
	<20240711165511.3100433-2-quic_ramess@quicinc.com>
Date: Tue, 06 Aug 2024 15:28:31 +0300
In-Reply-To: <20240711165511.3100433-2-quic_ramess@quicinc.com> (Rameshkumar
	Sundaram's message of "Thu, 11 Jul 2024 22:25:09 +0530")
Message-ID: <87plql6djk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:

> From: Sriram R <quic_srirrama@quicinc.com>
>
> To prepare the driver for MLO support, split the driver vif
> data structure to scale for multiple links. This requires changing
> the use of arvif to per link and not per hw which can now
> comprise of multiple links.
> Also since most configurations from mac80211 are done per link, do refactoring
> of the driver functions to apply these configurations at link level.

Something I noticed while reviewing this patchset:

>  static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>  				       struct ieee80211_vif *vif)
>  {
> -	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
> +	struct ath12k_link_vif *arvif;
>  	int i;
>  
> -	memset(arvif, 0, sizeof(*arvif));
> +	mutex_lock(&ah->conf_mutex);
> +	memset(ahvif, 0, sizeof(*ahvif));

Here we are we clearing ahvif so ahvif->deflink is NULL.

> -	arvif->vif = vif;
> +	ahvif->ah = ah;
> +	ahvif->vif = vif;
> +	arvif = &ahvif->deflink;

So here we assign arvif to NULL.

> +	arvif->ahvif = ahvif;

And because arvif is NULL this is a null pointer reference, right? Or am
I missing something?

I'm still reviewing the patchset, please don't submit a new version
until I have said that the review is done.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

