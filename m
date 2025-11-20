Return-Path: <linux-wireless+bounces-29210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 672DEC75C1D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 18:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0C8D829679
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AA2E6CC6;
	Thu, 20 Nov 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU04EDir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E7248896;
	Thu, 20 Nov 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660556; cv=none; b=U8KyAARfM+MfjI0gqOOIeg6RcV6RkBHl1mzJQ4frGpKCETkCGwwAyjmMHrk82hEct4mOLr1BQMCnUFYHPcUKsTcw9MZF0R2DLRgplPugKVitUHtYPU+MGQ28ADKIn2tMQMa64e3VX1pzqp9FyQAmjGF6zGMOhdU4KUGAS9DufCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660556; c=relaxed/simple;
	bh=HoNpCchVl9FxkOpbMf4OI4oPnzMOw4ZHwppz7KRzYvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyxdOFlah+qDdiZ5uTz2HdQBi24Ur8yLVvT4koMhhOoR1vHz268svPwJ6ydbruC3oxmM1PJd1Lt590h75lf0WJIWlLuG/mGxKLd0usuVzEYqPWZtEE/oKaVt5Pi/yO7uCiYzad3IRQunerwHqWD0ou8e9VBIVXMuJbFD5h4Is2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU04EDir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AFAC4CEF1;
	Thu, 20 Nov 2025 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763660555;
	bh=HoNpCchVl9FxkOpbMf4OI4oPnzMOw4ZHwppz7KRzYvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gU04EDir8AH2awWzciaF0PDluhnQ/vedijpl9lIAM7C28YGyxdpA40LV+orJspaPi
	 i5e103pKc6+VLhXQZ2fcj8+TfhgjL0Pj4SlcBtrdGPehPXi0Dg7nE009/GOIJWEwMn
	 Q/HH3dR+/V+eoPMYafNDEXM8XM+7ar80aDsFLZmkDvOlvaV30wajij1G6RMxzCEDfC
	 VokQOpBBQSrVuSD9N5BkF14qDB9eDmm11r7Eoqh8rdTqQah1+WGcOjk16rspctMqa3
	 tyudgoq8NFKiDiu1TMz8kF214NgovA7fYFE+5/9ewBD94WdnjDe/J/oR7kYuyqywv5
	 409uR/mzNwuVg==
Date: Thu, 20 Nov 2025 09:42:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2025-11-20
Message-ID: <20251120094234.26285f93@kernel.org>
In-Reply-To: <20251120085433.8601-3-johannes@sipsolutions.net>
References: <20251120085433.8601-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 09:53:10 +0100 Johannes Berg wrote:
> Hi,
> 
> Looks like things are quieting down, I fear maybe _too_ quiet
> since we only have a single fix for rtw89 scanning.

Pulled, thanks!

