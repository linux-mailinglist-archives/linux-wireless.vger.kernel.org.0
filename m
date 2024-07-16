Return-Path: <linux-wireless+bounces-10270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C35932FD9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD741C21CB3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26E1BC43;
	Tue, 16 Jul 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am2WK7N3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC481C6B7;
	Tue, 16 Jul 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154101; cv=none; b=mfE3cCslQLcXoRAK0xZi/4Pj9rc10uQBfKkh9MQQBzTlNV6P2Ka7jEIEIVso5UdGGgD43+i0z6B5yULdZVr6RtvSGswcysXUDgV2PD2BSKk4pzLu6GqtMyP6meksoJNlJ1whxAP2HwLonZg3G6WVg3DuVsCQSG5/wmbk7JTNe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154101; c=relaxed/simple;
	bh=044rSlWGGt25I/jbnoSwX8WDuMMAoxqjcZ+E1O/wNvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFLPwnwQLEqUTm3fdgMxXrzY+MjTHaJUoxpNWCjS+OPhz/U/4Jep3hT4B4kfkSCin9m0KoPrIfLFR2fJnGOch2VzMEsfv1uDvZpll2jvpN4C/mBrNduYFYEhzNHu+lYG8RibmizMgsd8UfHvu1uFZvX0CdXiVlUn2ecAr46pBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am2WK7N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54F3C116B1;
	Tue, 16 Jul 2024 18:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154100;
	bh=044rSlWGGt25I/jbnoSwX8WDuMMAoxqjcZ+E1O/wNvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=am2WK7N3QWAIp5CGIvAxD+NE+BGGP/DQ29eBeLw82stb9MpmI5wd27gB3qowPiqVT
	 yjS5Ed4vIJw5iC9qtwvCB4SG+89KNq99ssD879gmHAxsOoGADHL1q9kVMKF1+1P0of
	 GEoPPm6e4fX2VqqUC1uhX8k/ok8lMjvj7Vyd1IOUWK3JsLbsO+jJTGgwL9btZG3ttx
	 KKTy8RBO1S4n3RppBVXQzbhgXwHb2Tgx1PY9PRT8Ce9zx0WUBsy1yuGeOdziNHRV8x
	 tuNosjuQgkClcNFEQnWgmPMv1MNxlQMUknTVGm96iLp+Hg8TRuDHKJe7I+n2vqjmlj
	 m/CHKVeHlXDig==
Date: Tue, 16 Jul 2024 11:21:40 -0700
From: Kees Cook <kees@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: wireless: fix more UBSAN noise in
 cfg80211_conn_scan()
Message-ID: <202407161121.C00AC44@keescook>
References: <20240716174011.236849-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716174011.236849-1-dmantipov@yandex.ru>

On Tue, Jul 16, 2024 at 08:40:11PM +0300, Dmitry Antipov wrote:
> Looking at https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
> and trying to reproduce it with CONFIG_UBSAN enabled, I've noticed the
> following:
> 
> UBSAN: array-index-out-of-bounds in net/wireless/sme.c:95:3
> index 0 is out of range for type 'struct ieee80211_channel *[]'
> CPU: 3 PID: 4993 Comm: repro Not tainted 6.10.0-01155-gd67978318827 #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS <...>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x1c2/0x2a0
>  ? __pfx_dump_stack_lvl+0x10/0x10
>  ? __pfx__printk+0x10/0x10
>  ? __local_bh_enable_ip+0x12e/0x1c0
>  __ubsan_handle_out_of_bounds+0x127/0x150
>  cfg80211_conn_scan+0xd8e/0xf30
>  cfg80211_connect+0x1400/0x1c30
>  nl80211_connect+0x1549/0x1a70
>  ...<the rest is not too useful...>
> 
> This is very similar to 92ecbb3ac6f3 ("wifi: mac80211: fix UBSAN noise
> in ieee80211_prep_hw_scan()"), so just fix it in the same way by setting
> 'request->n_channels' early to help '__counted_by()' work as expected.
> And the same 'kmalloc()' math adjustment is also applicable.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Nice catch! Yes, this looks correct.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

