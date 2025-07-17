Return-Path: <linux-wireless+bounces-25608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3635B090F5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D4188AC79
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BF2F8C3E;
	Thu, 17 Jul 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crQDMyVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0335963;
	Thu, 17 Jul 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767534; cv=none; b=Zb5nVNkHRDg3JvC3KPG+E20PyIhU94oYEVi2ZiWs33FLpOBv2CFo6y0G5T85o5nDHyXyTF00TTK2HFqRPNO6kbxIt3Ylgz9cgd2btaBGUwEweE6svHEjAswFfjD0/sBv5b0765pZ/XhUi7XoajJPqhj0GWC5dSihM3RZDUVegzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767534; c=relaxed/simple;
	bh=AgrJRTLVseTGYmRuwtZ27uLGDbpYCxJPbcQhkeEmygo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FA4o5v55TjpTZATbWR8j+DnRFfBOW1dE5mHsh30fMey81GNetP+eRZK6H/oylr9Nayufx/exEZN7PhrCzM/DjIA7g/Tb1TyY1q/BlVvlBiraiFEyW8PyTEHQ3suEdP0pc3cmE2Or5ibr9I5T4CJalLPFqMz5Tg8dmXus3wRyuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crQDMyVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338E8C4CEE3;
	Thu, 17 Jul 2025 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752767534;
	bh=AgrJRTLVseTGYmRuwtZ27uLGDbpYCxJPbcQhkeEmygo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crQDMyVNvxPhNHEFVz7Y/fOsMZgSSgcX0C0o4l/GyYtbwN/Sxlqbg+7llFpN7oO29
	 U8mhHjajjX2p1zPMfVsSQyLfgB8wYeBJ3Zs3mQgjkXcQL91vsEmQndhV43p3B8oHV3
	 gl5ye0VgM3DE75+r+qVmzmqXKMGj6DISz1RnLW7gNNpAQIF0eUuXRTkXijqVPpfLF6
	 gQLcmpErJiUOXrd9GwhqueKhghWxoO4qrMHGQL27m7xh+BO1+Uie31yVAe/c3ds/+z
	 f9Bf9Vh5R9XjTqf57wan0cGeLkm3B9717+VhAEXXzXLHvtVdc6/cj1GktQ+qF9s5+S
	 XBuD+WyiVp/HA==
Date: Thu, 17 Jul 2025 08:52:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2025-07-17
Message-ID: <20250717085213.60d5342a@kernel.org>
In-Reply-To: <20250717091831.18787-5-johannes@sipsolutions.net>
References: <20250717091831.18787-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 11:17:10 +0200 Johannes Berg wrote:
> So, I thought we'd not have anything, but clearly wasn't fully
> aware of what the drivers were doing, and then also syzbot came
> up with _another_ complaint about __counted_by(), at which point
> I took a closer look and just removed it there (with all the
> reasons in the commit message.) Fingers crossed that's it :)

Both PRs have been pulled, FWIW!

