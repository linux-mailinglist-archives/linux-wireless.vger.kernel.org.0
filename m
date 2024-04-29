Return-Path: <linux-wireless+bounces-6988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182858B5871
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EFD288409
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470E74BF0;
	Mon, 29 Apr 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfWBlDWb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A83548E8
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393387; cv=none; b=jlyPUcECP66GjYIataT6GoswNRQpHrQmiPhod61Sr+uoJFe/2FM2bpiL7zdkLIVyTbwwT38r7w2/US83UZvK3Zui3L7AJgpwWXzFJF7pfNG2p9iDvAr+H5cG+mTFtg5Z2Xu6R3m/TEYzivOD7jjHyWSGagDtR3+K6crieW58bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393387; c=relaxed/simple;
	bh=NRWzX2QjlWDINijdQ9t0S3/I1bRQCVhBqIirrOAWS0U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mhspPZ/7KFFbFdtg8m1aMvbWWX2oilLw2CiiZ6/IJ9pJl/4zzABEcZVJx2r5FvBcbF7n9+a3cI4dRM2LzwbAxhhKpKJ+k7t4vfZ5qeP4G3QPoySDE5y4h3KHmpdwHYY/p2s/VWstZItiYfxQ8LRvpRPnewx5VG6FcryOxBWLrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfWBlDWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62339C4AF17;
	Mon, 29 Apr 2024 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714393387;
	bh=NRWzX2QjlWDINijdQ9t0S3/I1bRQCVhBqIirrOAWS0U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pfWBlDWbMHf80p6/sEXUcqVLLaZAQMV48lgFzcsnIxLktKPJFLZQ2LBZzH55DKDoa
	 kVPNL/R6maUo457E71W/4eyxfG2aJi+O1Lt9CLxSSjSUasyNzCbLlhyYVt3oHFLWxQ
	 xIqCSDXznYhJ+ZBvup4+h/wO9ltJUgm2nVHY3gokxNTjryBJTpk95dK5Ns7SibalxX
	 +jXuB9PZ8De+v7toNxDzhT1G/o7PpFqMED+JReaY+wEH7Lx0/UCMjq2FN4zzEGzx/V
	 cKALQ7/CxV+IZseqmjYAM71Si49SFN8xzFPqInsGYTQkRVYyBNNbOZe1GfME81j5Su
	 DTCthHyIvxyFA==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: remove some unused includes
References: <20240426141939.3881678-1-kvalo@kernel.org>
	<2a9fdafb5b5843c58cb080f8933b1e0a@realtek.com>
Date: Mon, 29 Apr 2024 15:23:04 +0300
In-Reply-To: <2a9fdafb5b5843c58cb080f8933b1e0a@realtek.com> (Ping-Ke Shih's
	message of "Mon, 29 Apr 2024 02:54:55 +0000")
Message-ID: <87frv4fjdj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Ping-Ke Shih wrote:
>> Kalle Valo <kvalo@kernel.org> wrote:
>> > I noticed by random that rtl8xxxu includes linux/wireless.h even though it
>> > doesn't need it. While investigating a bit more I found even more unused
>> > include files:
>> >
>> > #include <linux/init.h>
>> > #include <linux/sched.h>
>> > #include <linux/ethtool.h>
>> >
>> > It looks like that the includes are just copied to every file without checking
>> > if the file really needs the include. So more includes could be removed but
>> > that would need more careful analysis per each file.
>> 
>> I can do that. My ways will be to create an empty (new) C file to examine
>> every driver's header file can be included individually, and then try-and-error
>> to remove includes from existing C files.
>
> I made a patch [1] followed above ways based on these two patches.

Excellent, thanks Ping.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

