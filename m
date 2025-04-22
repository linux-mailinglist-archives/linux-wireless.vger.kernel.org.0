Return-Path: <linux-wireless+bounces-21842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E85A96C32
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38B217A40B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E69281363;
	Tue, 22 Apr 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmXOG98+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3C27CCE1
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327610; cv=none; b=HGmJpVI3sjuGwd2AEyX8AZR+NwzeFjxPJv9FoSujTVq907Tzj5LcvwRBNT6DtCK3tzToS/1MMwwqi1YO6aB983BY24qNlwjm77c9zLIA9rGBatjnkHXCt7Q1r44zKDMRABRdzPk3HQqZxDbt3/pQjeBnZYgEIeHqbzdS5MKXvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327610; c=relaxed/simple;
	bh=KmWKZnSX3nII8RfgILQPFdNGnmRlvEzjZetTK1UY9aM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8t2uNRnIuGT2gRtoa84apLmQIPc0kINIABb9gmrZYXFWrExhsWUhM4XYZ7goH0PBHm4+eBHzOizheTyGVl/5v2b04Uyo43u+SH8dWZdYAk7a0/nZ5ANf7pd/6pOVsbEKwuLiMQWJaPXTE4omdXFzBly6D2wdqWO54zrCHMI1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmXOG98+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7A6C4CEE9;
	Tue, 22 Apr 2025 13:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745327610;
	bh=KmWKZnSX3nII8RfgILQPFdNGnmRlvEzjZetTK1UY9aM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CmXOG98+5KPwrKa1rPQrg0oLhbirhhUrLukIo5+g0Bmg4LStcoPCAOwbaAw6z8wv/
	 SPnX/pkT/Ys30DvkE6Ws0+JlDpjTs7Ur+9rSmjrvu0sGjfEdFDITh5apt8lbmiGW5I
	 oquDdAnaytqAGBF1hdNzouIFBxjq3+OVpwyEWCt04PSA5yrS9IkQ3D58TwejSUpxcN
	 QadELiJDC5tOWOJ3AmOvKgVQvcPqWLS/pugRaYuAxmUgomf0rziJ7W3t6VwDR3tTP6
	 PtgBOJfT4jOXEiUGbhEREAP0F2yOn8veuCavkmiXLHXMhfgq8DUW1XvzkZwWt7IHQu
	 R9fIlks/etoQQ==
Date: Tue, 22 Apr 2025 06:13:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Kandybka <d.kandybka@gmail.com>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: mt7601u: fix possible index-out-of-bound in
 mt76_init_sband_2g()
Message-ID: <20250422061329.65e179ff@kernel.org>
In-Reply-To: <20250422110728.1274143-1-d.kandybka@gmail.com>
References: <20250422110728.1274143-1-d.kandybka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 14:07:26 +0300 Dmitry Kandybka wrote:
> In 'mt76_init_sband_2g', add return with '-EINVAL' in case of register
> channel start bound exceeds size of 'mt76_channels_2ghz' array.
> Compile tested only.

nack, please try to find real issue instead of wasting people's time

