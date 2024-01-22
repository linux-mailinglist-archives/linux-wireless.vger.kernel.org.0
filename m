Return-Path: <linux-wireless+bounces-2344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD607837229
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 20:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1816D1C299B2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824B148CEC;
	Mon, 22 Jan 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLmD4P0t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9F48CEB;
	Mon, 22 Jan 2024 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949830; cv=none; b=Lh5D2dIPaDRNQQMaPEEQS/fhz79S7NYvgi7ZRffT0aMct8ilA13BM+i0Bwaa6NmtHC5WeC+33y5dLSZXIxqy+581CEmppcRKyA4rMW9hfQucsAzYMEWKOzeagwpAetJFBsuOlh1/w+w98NeW3802zJ1t8xykJ2nmVMEqPUZtirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949830; c=relaxed/simple;
	bh=vyqCHCVkxZc4mewYX9ZYzwM6NCh+uuSn5s1asYmojSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWQs05cCi7Tm1qiIKW5B8XeJlITjyVyfQd9UGq2ET812FHkwk7ufr/xPzo/oytXKZs/osqIh/PBlIwVTddaGpQhNQkhjbO17ME7MbxyPYLy4tAaklUH8VQEIutTMVA9kB+XvkJRuJPM8Zby1VeUtDAHnuzKvz+4e2slJvk+StDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLmD4P0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729E9C433F1;
	Mon, 22 Jan 2024 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705949829;
	bh=vyqCHCVkxZc4mewYX9ZYzwM6NCh+uuSn5s1asYmojSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lLmD4P0tNl0o0gh3vByD8UHHW6JqrrzdTWd47ERfCmT3xDj6XamBCgDCR+U1/nL2J
	 XaXVsx6QqEjyrDae1ryOoTndDOKAwKa6UpgllxCI770uymxwhwDXoN1AgJd6T3L8Hi
	 tultJBysdA0Lnvup6z3HhvrfIMS93p00JpK3WQOplmwDgF4TSwW6Zne+tv8R9tNvOW
	 5HC99rSDnBmI88kdMEmjpj2hqqIy3kLe2xm/DHKPtScFlv3rqq/TvtidgeXyddSV6n
	 1GiWUEhfchZYxum2Zru8yw1m0buBgFeh0MdYb30GzsFGiRF3YX/6qVrC4GXY2fW0Ee
	 mRtW7XH4eqGPA==
Date: Mon, 22 Jan 2024 10:57:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, abeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, weiwan@google.com, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 00/22] Fix MODULE_DESCRIPTION() for net (p2)
Message-ID: <20240122105708.52d33fa0@kernel.org>
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 10:45:21 -0800 Breno Leitao wrote:
>   net: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
>   net: fill in MODULE_DESCRIPTION()s for wlcore
>   net: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx

Thanks for making progress on these!

When you repost:
 - please send these 3 to linux-wireless as a separate series
 - make sure mailing lists are CCed on the cover letter
   (yes, get_maintainer is embarrassingly bad at its job)
 - please send 10 at-a-time, it's probably a good tradeoff
   between series size and reposting risk
 - please target net, I hope I convinced Paolo that it's okay :)

