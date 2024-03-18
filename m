Return-Path: <linux-wireless+bounces-4865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9E87EFF5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 19:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322E11F232CC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3AF43ACF;
	Mon, 18 Mar 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgLLG59X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A138DD3
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787780; cv=none; b=bATAW9JclyfG9LFhsFoc1nHKOp3x6qW2uaLe1hTfyPY8KWqoymjLnqd4YTwj5VuQyIRah+07ysjMWRUyToawffBI34b4lJI0LtyTbBJAo1KYdjiOkaWNgbk85bUQ/lZtH0dZ5+f6Yy84wbMxoNfNECPKK0W+0AM3FEIpbClhskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787780; c=relaxed/simple;
	bh=EeqLoy972CXIctyyYCv4fLVanv++DUBIP/KXK2igIPY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AjbZK/BlTl/KD60FgYdS3iB0XK/TfgNNDUcxGQ9S+qWWNd73hZyCfVvpZMrqJezZhuPj67vNH6VlG1HrNc02Cj9SoFiSR1aGy8NSIvhZjd9uYi7Is9w0q4p2YIjdQvdMyroFHLN/iWkOJsTXfmYqoWTO50zA5PTX851gG2A0qHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgLLG59X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED36C433F1;
	Mon, 18 Mar 2024 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710787779;
	bh=EeqLoy972CXIctyyYCv4fLVanv++DUBIP/KXK2igIPY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qgLLG59XHcwBB0Ehrd7jAyICGaVuQI/sbLd1nWOw+T4Z+7QkrNTi2DfIaCAGHeqAX
	 8QxZIHMylviaIIIx+YnAHej6/iKSdjPXFwUgpAmxXZjzWxpJvDctsVTELtQaKjpR32
	 553kXW77/uUf8JociB7e1Y6g5yqaPQkHBeUThplkAUSwzoakEpQyr/xsHkc4wUp5Hh
	 7h1h1obyB+ixb6j8/10/EAM6N3hv6ZuV0xCwOfbVJ+/dgmStmvz1vYcUrNeyYMsz7i
	 FjxvoOKdt2d/L5iJcGmRZNoUN3Tr40Rvat3Q9/YN66epG5WGDUUlONXjDL+DFQugV0
	 BG/SGnwXMjHxg==
From: Kalle Valo <kvalo@kernel.org>
To: Aloka Dixit <quic_alokad@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: use correct flag field for 320 MHz
References: <20240314204651.11075-1-quic_alokad@quicinc.com>
	<87sf0nczca.fsf@kernel.org> <878r2fctng.fsf@kernel.org>
	<4940b6cf-a68d-4799-ccf3-f90dcc105e3e@quicinc.com>
Date: Mon, 18 Mar 2024 20:49:37 +0200
In-Reply-To: <4940b6cf-a68d-4799-ccf3-f90dcc105e3e@quicinc.com> (Aloka Dixit's
	message of "Mon, 18 Mar 2024 11:40:02 -0700")
Message-ID: <87v85jbcji.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aloka Dixit <quic_alokad@quicinc.com> writes:

> On 3/18/2024 10:54 AM, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>> 
>>> Aloka Dixit <quic_alokad@quicinc.com> writes:
>>>
>>>> WMI_PEER_EXT_320MHZ (0x2) is defined as an extended flag, replace
>>>> peer_flags by peer_flags_ext while sending peer data.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Fixes: 6734cf9b4cc7 ("wifi: ath12k: peer assoc for 320 MHz")
>>>> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
>>>
>>> What does this fix from user's point of view? Does it mean that 320 MHz
>>> chanels were broken before and this commit fixes that? I can ammend the
>>> commit message.
>> And what about WCN7850? Does it work the same?
>
> 320 MHz association was broken. It was a re-basing error while sending
> the original patch because the correct field was added during testing,
> still used that way internally too. I have not tested WCN7850 on this
> patch but yes will require the same field. Current code was setting
> QOS bit instead of 320MHz.

Thanks, does this look ok:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c4ade6bdf3d1a2d9d05606a85431f154559d5a80

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

