Return-Path: <linux-wireless+bounces-16475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D7C9F4CCB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 14:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75F81886757
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FCB1E0490;
	Tue, 17 Dec 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS/IKLra"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4D1EF1D
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443429; cv=none; b=dnzBkA31+VSPCCyb3k8FSWg6sdXeHtTVHONWQ5rBAbiFK8UhzT0LgT5J3JHCQoAHUbnRqV8/RsdvdfxDqjSLaTvdsIJg/jk62a4KWS/EHIUtDYINsM6rsAy85vwTQQ2dSSHEgyj+s6QruNDEWAhTVm/oaB1dAab2bVJ9j7yBYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443429; c=relaxed/simple;
	bh=L6ro/dPVM1xIIqywePkia8CAEFjRHPddQMMlHewnsSA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FOXcCXBKUNTvTux7+gz1UCRhCWHmlZce4xRqIOn/ShI2H0138UwzmCpkDFmNyk+15oN65z8Ch2fvnWhWSJ422AGc7pJ6mANsrvixAOebTH7uQbP3+KDLOOYR0GITlUhzwO6saCKvOVTDYO92o2HwHbiv16TiggfUhOutCJBFIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS/IKLra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2641C4CED3;
	Tue, 17 Dec 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734443427;
	bh=L6ro/dPVM1xIIqywePkia8CAEFjRHPddQMMlHewnsSA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jS/IKLraMi3i3HojpHryX2WTGxWyEFN4KPK58gUZ5PLwotaw/LjLBTLQ7RkrdXqzs
	 6GuSe+Ve2umXcL9k/7GCzz39KrSqf6W1dTGs5tJ7ZtKwQQglZEAs9qlZIsuMcAffUo
	 UIxDoPSRvaYZnnLorxwN7yvDVtxb9SD9EGMPNDLIqH/YFj2IRwJjJ5xxlwHDNDi5Uk
	 SWid9FtRdwxwJ4b0WlA4vpyBTYdUifc93azKOcFFyVkJRFXDAxyDx+TYPV7CK7xeym
	 q+8tzLPUc2srRAhGhOZH3I9IZ4ub4O9MdNhfKTa5P1N/NZkrOtcXpx7FmD2dn8n4/N
	 rNue1qismul2Q==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] wifi: ath11k: add srng->lock for
 ath11k_hal_srng_* in monitor mode
References: <20241008053744.1070-1-quic_kangyang@quicinc.com>
	<20241008053744.1070-3-quic_kangyang@quicinc.com>
	<87ttb9nea6.fsf@kernel.org>
	<79910df2-a7fd-4880-bd32-4f2927341654@quicinc.com>
	<e0d2d1ce-0443-4eea-b3c3-ed7423875d11@quicinc.com>
Date: Tue, 17 Dec 2024 15:50:24 +0200
In-Reply-To: <e0d2d1ce-0443-4eea-b3c3-ed7423875d11@quicinc.com> (Kang Yang's
	message of "Fri, 13 Dec 2024 17:41:41 +0800")
Message-ID: <87a5cus9jz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kang Yang <quic_kangyang@quicinc.com> writes:

>>>> @@ -5623,6 +5625,9 @@ static int
>>>> ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto reap_statu=
s_ring;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 mon_dst_srng =3D &ar->ab->hal.srng_list[dp-
>>>> >rxdma_mon_dst_ring.ring_id];
>>>> +=C2=A0=C2=A0=C2=A0 spin_lock_bh(&mon_dst_srng->lock);
>>>
>>> Why initialise mon_dst_srng differently? The commit message mentions
>>> nothing about this change.
>> Because need to fetch spin lock inside 'struct hal_srng'. If still
>> use 'void *mon_dst_srng', need to perform a variable type cast.
>> Bur 'struct hal_srng' will make this line too long:
>> 'struct hal_srng *mon_dst_srng =3D &ar->ab->hal.srng_list[dp-
>> >rxdma_mon_dst_ring.ring_id];'
>> So I separated the definition and initialization.
>> ath11k_dp_rx_reap_mon_status_ring()/ath11k_dp_process_rx and others
>> ring process function is the same.
>>=20
>
> Do i need to send a new version for this?

Yeah, please mention in the commit message why you mon_dst_srng
initialisation.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

