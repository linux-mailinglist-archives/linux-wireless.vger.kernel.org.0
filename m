Return-Path: <linux-wireless+bounces-13823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BF99731A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 19:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E912856E4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C211A2846;
	Wed,  9 Oct 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btUJKN+I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2215445B;
	Wed,  9 Oct 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495235; cv=none; b=hL7WVLwe6NAtc/AstGsVFFbOFOplvFZdvJTez8KMfkxt7jgh/cHfTmM8GqMJI/njwh1tterbCqkoYmAoQ9leRa3UaEpGRoxiYRbQob97uPrSjvUFt796ZUBBf6KlqHqT2+ip8xi4xpyzN/lw94Ttm2EY4zy5mCm7wb4CLOqD28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495235; c=relaxed/simple;
	bh=PBvrZObEvZf+D5grl8OSo9HeGv9ki/K+1uQRDCSA5Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR19xCBbokGITfpt70/uAYK1gZapAiVWZ8x3k4ULV6/9IWI2DUtY2Aai/PA78d6mMwZ7AGVln7JQ+jIamHC08zd8neo/A7hTNnuWCmm3dcwTYME7ZsvHsuSiF/6McB3fi2gV+WoM6cO2KL7upq7Um6udldjn/WKges8A0N4PJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btUJKN+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969FCC4CEC3;
	Wed,  9 Oct 2024 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728495235;
	bh=PBvrZObEvZf+D5grl8OSo9HeGv9ki/K+1uQRDCSA5Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btUJKN+ImNhsW+PhDEpD+gi5D0Avf8hdj7Bk4k+ibfXYpIkid5aSt5zB9QL6JckOB
	 A6ZJFeVmyNwmceoS23zh2flgoknGyd8X2M+eN1/a3unmZrq2U0Jgol2E2CsLdPzQK+
	 zq2Fxcks9bb08DIHfypJ9M6HzTBbE1ypTrmAcji4=
Date: Wed, 9 Oct 2024 19:33:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 1/2] debugfs: add small file operations for most files
Message-ID: <2024100943-snuggle-undoing-811b@gregkh>
References: <20241009181339.0b1a6eaef573.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009181339.0b1a6eaef573.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>

On Wed, Oct 09, 2024 at 06:13:39PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As struct file_operations is really big, but (most) debugfs
> files only use simple_open, read and write, and don't need
> anything else, this wastes a lot of space for NULL pointers.

You added llseek too, I'm guessing you need/want that?

> Add a struct debugfs_short_fops and some bookkeeping code in
> debugfs so that users can use that with debugfs_create_file()
> using _Generic to figure out which function to use.

That's crazy, but nice work!

> Converting mac80211 to use it where possible saves quite a
> bit of space:
> 
> 1010127  205064    1220 1216411  128f9b net/mac80211/mac80211.ko (before)
>  981199  205064    1220 1187483  121e9b net/mac80211/mac80211.ko (after)
> -------
>  -28928 = ~28KiB
> 
> With a marginal space cost in debugfs:
> 
>    8701	    550	     16	   9267	   2433	fs/debugfs/inode.o (before)
>   25233	    325	     32	  25590	   63f6	fs/debugfs/file.o  (before)
>    8914	    558	     16	   9488	   2510	fs/debugfs/inode.o (after)
>   25380	    325	     32	  25737	   6489	fs/debugfs/file.o  (after)
> ---------------
>    +360      +8
> 
> (All on x86-64)
> 
> A simple spatch suggests there are more than 300 instances,
> not even counting the ones hidden in macros like in mac80211,
> that could be trivially converted, for additional savings of
> about 240 bytes for each.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  fs/debugfs/file.c       | 100 ++++++++++++++++++++++++++++------------
>  fs/debugfs/inode.c      |  63 +++++++++++--------------
>  fs/debugfs/internal.h   |   6 +++
>  include/linux/debugfs.h |  60 ++++++++++++++++++++++--
>  4 files changed, 159 insertions(+), 70 deletions(-)

That's real savings so I'm all for it unless someone else objects?

thanks,

greg k-h

