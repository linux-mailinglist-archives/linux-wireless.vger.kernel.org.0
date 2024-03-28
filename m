Return-Path: <linux-wireless+bounces-5491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ECF89088F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215F629354D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E7781725;
	Thu, 28 Mar 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUXYyF4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EA374F1;
	Thu, 28 Mar 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651745; cv=none; b=JyUWyhYx73ZLJgAR3WlQID6m8OUv0KYsiVqTe4/AnfYF0mn6sNUJOUFHDXo8kEVLyhLKSRRSGEraKZ90t7SfYvRRm/zwbbMZXf8+Cezp1olACHa0gvx13VgCet6IkVZHW9WlEtDGI8JwmXi7DIA1oEbaU8Xy3lNb42LJi48smyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651745; c=relaxed/simple;
	bh=99VsYl9LLb/Fgf4qp6tFM6y8MYoeu/u9qF5KbrJouGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4pmxSnXiE0/+kzMxgSH+c8B2ycADEmRKhkBvY0iLGJwWzWXPoaiSx1tGEWIOss5QZQAVXqq6pcqhKIdGLwVCUA2+BZLIBlAhUMyNG5/uOftSjo3RuLnrlp2KeeE/JM3QK1WE4k5ATWsJpxrJl+gN+5ZwEcvavB36Gnkai3VU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUXYyF4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D10C433F1;
	Thu, 28 Mar 2024 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711651745;
	bh=99VsYl9LLb/Fgf4qp6tFM6y8MYoeu/u9qF5KbrJouGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pUXYyF4LKffpWAHKSOSBBDM9VU4bzm9YdG/yU93M5ND28v79HezOyMi8jsUvGwCQU
	 FSb7X3GsU1qpKUf92xWygjKSCVFJH1KCnIPHddz6n29IMJQjlh5iQFoJdoAHvgNd0F
	 ZbQ8bVGZPN7+lAd631fadKn/2vb4H2JWCuYRAUwPEW375WyeO9F7ezdqYSsAK2Zc2u
	 Ab/IJ1F8JG8u1ToVTX6xs3vnYIBCh12Fw++nRegRO1lEHcJQOUZUOlNa+k+uU8HicV
	 avyCGlvU8KfrjVuZD0pD/zFTfb6CULhfln/ABODz7VAniRT6sp02fqqG6CqtQ/2nVl
	 n9B0ItU6Q8vfQ==
Date: Thu, 28 Mar 2024 11:49:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, Vasanthakumar
 Thiagarajan  <quic_vthiagar@quicinc.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
Message-ID: <20240328114903.1d0c8af9@kernel.org>
In-Reply-To: <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	<20240328072916.1164195-3-quic_periyasa@quicinc.com>
	<6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	<9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
	<9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 13:01:55 +0100 Johannes Berg wrote:
> If we do that, including NL80211_MULTI_HW_ATTR_IDX for illustrative
> purposes though I think it should be removed, we'd end up with:
> 
> NL80211_ATTR_MULTI_HW
>  - NL80211_MULTI_HW_ATTR_IDX: 0
>  - NL80211_MULTI_HW_ATTR_FREQ: 2412
>  - NL80211_MULTI_HW_ATTR_FREQ: 2417
>  ...
> NL80211_ATTR_MULTI_HW
>  - NL80211_MULTI_HW_ATTR_IDX: 1
>  - NL80211_MULTI_HW_ATTR_FREQ: 5180
>  - NL80211_MULTI_HW_ATTR_FREQ: 5200
>  ...
> 
> which _is_ a lot more compact, and removes all the uninteresting mid-
> level indexing.
> 
> So in that sense, I prefer that, but I'm truly not sure how the (hand-
> written) userspace code would deal with that.

I think the best way today would be two walks:

	for_each_attr() {
		switch (type):
		case THE_A_ARRAY_1:
			cnt1++;
			break;
		case THE_A_ARRAY_2:
			cnt2++;
			break;
	}

	if (cnt1)
		array_1 = calloc();
	cnt1 = 0; /* we'll use it as index in second loop */
	if (cnt2)
		array_2 = calloc();
	cnt2 = 0;

	for_each_attr() {
		/* [ normal parsing, populating array_1[cnt1++] etc. ] */
	}

Compared to "indexed array" the only practical difference I think is
the fact that all attrs are walked. I think you have to count them
either way before parsing.

I was wondering at some point whether we should require that all
multi-attr attributes are grouped together. Or add an explicit "count"
attribute. But couldn't convince myself that such extra rules will
pay off sufficiently with perf and/or ease of use...

