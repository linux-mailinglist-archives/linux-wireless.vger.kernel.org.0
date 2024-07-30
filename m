Return-Path: <linux-wireless+bounces-10687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6F94143A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98639B2874A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A521A2542;
	Tue, 30 Jul 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NvbBtKND"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B5522F;
	Tue, 30 Jul 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349409; cv=none; b=uj5zYPV4G2t/USFctbqBAnMp9GqVbsH/h93ZLP32BTk6Qikn0AzmD6bknHFmLzEtDXI8gQ+pjQsfftWWozRI5sjb6Sg1r7YXFoEazV0BfyttZScLuHcTLE1UAoqnUIFLp2aKaj8LvOGeqVos7Na75JL3wrr7NDxwN963mtUwQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349409; c=relaxed/simple;
	bh=i0ER6Tvx6ftHCDdpxoVZ7IFUk+d001vA/10jeF9Jez4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQswvFiOuAeXS6ckBzvtaIJ3rTmSay6glp+J9EJ87cVmWIe+q6fkIC8GuzqJa8tz9nptkf/unxJKVe4m7BqMPU/ZQKizzTGVhSw/yjd02dRII5XjxePZSB68/AZ1QhpXa9ffNMwYdZypPpbGpJ2yHnqbHVeivSy2yFBh3fHuRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NvbBtKND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113F7C4AF0C;
	Tue, 30 Jul 2024 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722349408;
	bh=i0ER6Tvx6ftHCDdpxoVZ7IFUk+d001vA/10jeF9Jez4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvbBtKND9TY0/CkXohua22qv/7FyqryOimZS3JShkq0xtU8zwqgRXGSOUEiFRMGcC
	 GbA8FaZ/zYSw3JycfhyvqJVZW5KIqvczEjIfwcnhzx1Av8VXU2x7koyvSK8eXtLUVr
	 BM5sM31ujzRvHfJb7szLeshP5SZnkw6uZROJ36NQ=
Date: Tue, 30 Jul 2024 16:23:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: johannes@sipsolutions.net, sashal@kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org,
	stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
Subject: Re: [PATCH] wifi: mac80211: check basic rates validity
Message-ID: <2024073014-borrowing-justifier-18c8@gregkh>
References: <20240729134318.291424-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134318.291424-1-vincenzo.mezzela@gmail.com>

On Mon, Jul 29, 2024 at 03:43:18PM +0200, Vincenzo Mezzela wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28 upstream.
> 
> When userspace sets basic rates, it might send us some rates
> list that's empty or consists of invalid values only. We're
> currently ignoring invalid values and then may end up with a
> rates bitmap that's empty, which later results in a warning.
> 
> Reject the call if there were no valid rates.
> 
> [ Conflict resolution involved adjusting the patch to accommodate
> changes in the function signature of ieee80211_parse_bitrates and
> ieee80211_check_rate_mask ]
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reported-by: syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
> Tested-by: syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=07bee335584b04e7c2f8
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
> Hi,
> please note that a backport of the same patch for v5.15 is available at
> [1].

Please resend [1] as it's gone from my queue.

greg k-h

