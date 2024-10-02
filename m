Return-Path: <linux-wireless+bounces-13409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDEB98D1CF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 12:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7059E1F234AA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 10:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8181E767F;
	Wed,  2 Oct 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3H9I6p/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6B1E767E
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866699; cv=none; b=fTkEf5K/IAtCfO48aee+7lrv201ps+aZuSU3dnXts+kxVzkr0lqmGv51HBp6H7HuLL+kTl2Egdonjdf15krDh5ronfDUZh1IcbePG0RUYCRukXRz5eUrSp12dsNduvxQv1WFfznawO+pqBaBW4wi8jD3PEVVqhMZ4olbg5rYoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866699; c=relaxed/simple;
	bh=QYzEODDbfD/4xRiXL5Sl4SU6AqLpXLCW7+mKlh/WDI4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dsOEyYidnqxsyKElRg1TEOBujV00uux0h1ECgWAPdE0x2qGpp52bJqQT8IQ4Z5iECXQzPstrD2K+0j6k+x2TVFSm69qfL8Z+bFopyVQE/ALVzHs38LXqKryrmWJqQQCEgLMTI2sJw7EdhDxKoSTKmGxzpFhqgUH/A8eglTPPrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3H9I6p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10434C4AF50;
	Wed,  2 Oct 2024 10:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866699;
	bh=QYzEODDbfD/4xRiXL5Sl4SU6AqLpXLCW7+mKlh/WDI4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=r3H9I6p/RKToDdQiaIJq0zuBGioEY7X44nVQDIWQkVINtz3L7xllSOjFiPpEo4qA5
	 y2dotK7J3Tclz0heck3K/IbhLpnY/NBUm0T0D/kKRR9QloY9/wmC2HO+V8L4KK3nr+
	 cgCYwXNU+O7I9A0JkkufeDsKHSOcLzlnkexE8MLzbFqC2AxWh4QL/XtczjnNhYVKYY
	 kitEETQCwFHPkFzm1ntbWlZgTHREaKINf/gM7RnzqQnzwGNNLwWWb2ezGnuSD6h/UU
	 Z0oTZ0SvyZ8IIVDAwq5b2FQdwAcfiEb80tSPVnSVrkBvY3aTH0PCpvviWsx5kguUmG
	 ocqIjDj8wV4rA==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Ping-Ke Shih <pkshih@realtek.com>,  Sascha Hauer <sha@pengutronix.de>
Subject: Re: rtw88: alloc_skb(32768, GFP_ATOMIC) fails, driver gets stuck
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
	<baca0d5d-072e-4003-ab4a-ecc524d6b89b@gmail.com>
Date: Wed, 02 Oct 2024 13:58:16 +0300
In-Reply-To: <baca0d5d-072e-4003-ab4a-ecc524d6b89b@gmail.com> (Bitterblue
	Smith's message of "Mon, 30 Sep 2024 23:56:09 +0300")
Message-ID: <878qv693g7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> I still don't know why qBittorrent is required to trigger this bug,
> but I found the problem.
>
> alloc_skb fails (silently) therefore the RX URB is not submitted
> ever again. There are only 4 RX URBs.

Why is alloc_skb() failing silently? Or is that by design? I was under
impression that we should not have error messages for allocation
failures but is that only for kmalloc() & co?

I did a quick look and in wireless drivers some of the alloc_skb()
callers print an error and some fail silently. I think we should start
printing errors for all alloc_skb() calls. Thoughts?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

