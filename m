Return-Path: <linux-wireless+bounces-3244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1684BAD3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA3C1F252F1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F3134CE7;
	Tue,  6 Feb 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGvelH+6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EB134CE6
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236662; cv=none; b=KE0Kpg1nBFsoTsB5BPv9B0oktZAG0TuY3mrblABUs7Ki9C+6b+95Uy7A1ELlDMb+urHcgQb6ZcV2mXCB+va8ue/lKu/upmjQqDoKC2UJDpn6myBTKorBJtyqkoT12q7eUD9uK9iVbXWuSiP23CfxMLzeB5uOR01QaKcMgNFWXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236662; c=relaxed/simple;
	bh=mRnyrMkY2nLwbDxUm7UrZ9ceTa8DXc5KnOeL2gxvfrk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CivJBtrAb8/0uI32EqXp7dwhEozmXMvYq/CRX/KXG+Lgsycvn8g8kMg0x12h5ReNOegu4UOh85HEFHt+IEXH2dgiK3wWqpiORiZGPQieWJmXy+BZZ9UafUIU8vp8kAeSNzz3wt7CNWb5QC7tq8OybN4562c60TBZg98crI87tCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGvelH+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B7FC433F1;
	Tue,  6 Feb 2024 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707236662;
	bh=mRnyrMkY2nLwbDxUm7UrZ9ceTa8DXc5KnOeL2gxvfrk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fGvelH+6oeq9Ef1QlS5DtzCWQhQax7xFHfNWN1hkOsg0JGN1Re4JiuOGQCoeyVfst
	 KNbsEda3Nua0ZfVSO9YteVNw3f2rcHMWWh3c+MqPZ2RXmjM9UiXjwaFGb4RIdlQ+QS
	 oy6JN6qpbWQu7WvUbcAMwFEGfdwu/UT3IxlzATj7ZUBIIW/01k+sLcwmT/u0W2pLh2
	 0jXT5Gd94DUxibYtyh2KJFZW6pxMxLG2J7wI8zBzVL77MEGswgIp88Fb5HJ++rRTNw
	 0UyFOWSH83S7WnleZUpEN59QD2OerTbTAXA1wRAR1i4kXxv7sKy5anBN1jBhi+JKi0
	 3Z5S7AfS8yseA==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] wifi: ath12k: allow specific mgmt frame tx
 while vdev is not up
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-9-quic_kangyang@quicinc.com>
Date: Tue, 06 Feb 2024 18:24:19 +0200
In-Reply-To: <20240130040303.370590-9-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Tue, 30 Jan 2024 12:03:00 +0800")
Message-ID: <87il31r26k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> In current code, the management frames must be sent after vdev is started.
> But for P2P device, vdev won't start until P2P negotiation is done. So
> this logic doesn't make sense for P2P device.
>
> Also use ar->conf_mutex to synchronize ar to avoid potential conflicts.

Please do locking changes in a separate followup patch, I removed this
in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=d357dcb3cd0cd3bf57064dc673b5477d884454b3

I assume you are referring to ar->allocated_vdev_map and access to that
indeed doesn't look consistent. Most of the places take conf->mutex but
I see some places which it's accessed without the mutex, for example
ath12k_mac_get_arvif_by_vdev_id() and ath12k_mac_get_ar_by_vdev_id().

I recommend in the followup patch checking all the access to
ar->allocated_vdev_map, fixing that if needed and adding documentation
to struct ath12k::allocated_vdev_map how it's supposed to be protected.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

