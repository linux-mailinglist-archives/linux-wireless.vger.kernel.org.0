Return-Path: <linux-wireless+bounces-24754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76AAF0A0B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 06:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01B01C06ADF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 04:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452A1DED5B;
	Wed,  2 Jul 2025 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXfnouIV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED531DE4FC
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431989; cv=none; b=RAGzWRgkg0H2yTfAIGqkydpY19iUyRrunHTtVUKoVBUcnnRWJiEV3soxdcBEkVa0S5opeL1mK6Kw6ksGzr5zwQNRwHYsRrV6MuO0IsgeFoSmAE7eWbGfJ36+ZKs1wtNkeJ3ZBBHZrTkQ3y01ySSEQhr53ZQwgRSHF308D1742VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431989; c=relaxed/simple;
	bh=K+a7v7XFsKVYnxpGrqsaLyzKHzYX23MbQzgYUjbYv6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AKhcnaLYnItexK7BK6535CaL5Z1rtVe2FNrt+seowoTnwdSGQJWQOkxvsZX3I/qdIuDKdaOlGqtPguF1IrutOh35HTfUsdTcmu3e9J2ZNZkFhMUfPTqaqhmbIfJ++UD2K3LvGIxfPRI/4NGV7lGg8pdAmW72c121MNLWkDDyMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXfnouIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9187CC4CEF1;
	Wed,  2 Jul 2025 04:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751431988;
	bh=K+a7v7XFsKVYnxpGrqsaLyzKHzYX23MbQzgYUjbYv6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NXfnouIVp4Lpy6ve4ljApPt0JLXpDVVYT9Duhd1++LO3wKMtZRdTkLoZR9b9Tf2y0
	 PpLw7gF1RhzZpBdqUuspBwBfhm4XJ9dmOYrJ/yBWsqmttZVNHNLiGBap2A6dVMHiLg
	 U5OF/HcAG/gBmTROfwc+96soziOHvcv158HMEW08Ku2X3GpESFQ/GdQplOVpgNjjUN
	 nWzL8gyOOlqv1yGWa+TRBw5QDRw4TpH1CLcMBivfs+hUcD6vo05RrA8rXQlmK/jzVR
	 0C602vLpgIa2QUez84DMKzv+SWH9FAuh2kSqo8URdJZx7jIa2rlXLENprrWJ8YNP0i
	 dN2XaK0CyE13w==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id B741B5F71D;
	Wed,  2 Jul 2025 12:53:05 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Marcos Alano <marcoshalano@gmail.com>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20250626102326.3815520-1-marcoshalano@gmail.com>
References: <20250602121434.3011282-1-marcoshalano@gmail.com>
 <20250626102326.3815520-1-marcoshalano@gmail.com>
Subject: Re: [PATCH v4] wireless-regdb: Update regulatory rules for Brazil
 (BR) on 6GHz
Message-Id: <175143198568.473566.2185176281152831539.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 12:53:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 26 Jun 2025 07:23:26 -0300, Marcos Alano wrote:
> Change rules for 6GHz on Brazil removing `NO-IR` since it's
> not mentioned in the normative.
> 
> Change the comment to point to the newer normative.
> 
> 

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/7628ce291d74

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


