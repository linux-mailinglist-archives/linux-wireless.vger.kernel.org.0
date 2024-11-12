Return-Path: <linux-wireless+bounces-15198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D320B9C5337
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 11:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE871B231BC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DFC20D51D;
	Tue, 12 Nov 2024 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8Z7EnP8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2F4C91;
	Tue, 12 Nov 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406441; cv=none; b=lS/afKQAaxCjQkhxZtqrW5E9K2RitPhRGX8fugnqD/lRHric9uh1zIpJBS4BX1/XtdlyCPRkltPUzlOS+4TITLwYInhwprxwMIRtlttggHA8m+R33Rfj/qGTrY1rHp/47OqLhd1Y6/CLbIZjXQRipiAfbEe0YppQAprLBSnoUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406441; c=relaxed/simple;
	bh=JOL53HhCG+jCAg5RprMfpeMshNGT3dJE9VpaSRZ3Q2I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=n9J5/FvxJQLr6cQYzLXYkICEybJWnIeqrxFLcOSLi4UDrfTogx5WvRJqUDL4HPHsBVdMqVa7qw96n1A1+OwxispDkOPKzif0HOKFRlGFRZwgKZRipA5Fg75j1z0UJdwTmefsUVD6k/a5MnaH+DUnd3WB+XlgERiaT4rdjrFAerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8Z7EnP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9068DC4CECD;
	Tue, 12 Nov 2024 10:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731406440;
	bh=JOL53HhCG+jCAg5RprMfpeMshNGT3dJE9VpaSRZ3Q2I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=k8Z7EnP8E4ROUfNXBXvCffHzpj7zHij1LE1EdzZ+b7eh6cX4QIXc3ZuYLmzKIWQPg
	 swvfUWWdc2zCJi8gmXYVVbUhOcGTfDXXIuyfhDN6rLOJcJYRgRvt4ikBMlFn3ccK77
	 wGoO6bfHuXRgf9gBHstXKHGixFf3OXnIVQnHrNN0+dLiFA+Goo8hUw/yXbMKimkhgc
	 qo1C8hz/kev96vmhcFXb2Y70OiSbEqdvfdWda2i7OvZQqXjZLve3dYvbNRwmdJ1wU2
	 bKcQYkrGxqr3wDDwJCKG6E5ezMcb+vssse06CDjeVjGnHFXDjByg4qCwMrXIVT2xE4
	 wXhgMtY8zMRHg==
From: Kalle Valo <kvalo@kernel.org>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: jjohnson@kernel.org,  linux-wireless@vger.kernel.org,
  ath12k@lists.infradead.org,  linux-kernel@vger.kernel.org,
  skhan@linuxfoundation.org
Subject: Re: [PATCH v3] wifi: ath12k: Fix for out-of bound access error
References: <20241105101132.374372-1-karprzy7@gmail.com>
Date: Tue, 12 Nov 2024 12:13:57 +0200
In-Reply-To: <20241105101132.374372-1-karprzy7@gmail.com> (Karol Przybylski's
	message of "Tue, 5 Nov 2024 11:11:31 +0100")
Message-ID: <87frnwwyhm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karol Przybylski <karprzy7@gmail.com> writes:

> Selfgen stats are placed in a buffer using print_array_to_buf_index() function.
> Array length parameter passed to the function is too big, resulting in possible
> out-of bound memory error.
> Decreasing buffer size by one fixes faulty upper bound of passed array.
>
> Discovered in coverity scan, CID 1600742 and CID 1600758
>
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>

I assume you only compile tested this, it's always good to mention that
in the commit message. But no need resend because of this.

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

