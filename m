Return-Path: <linux-wireless+bounces-14324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14419AB028
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD86B213F5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2CF19F121;
	Tue, 22 Oct 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yaxHMYBP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9019F110;
	Tue, 22 Oct 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605332; cv=none; b=MIGTQiEQ8xP2G8A7zK1WQ/LxEcQKAl/ldTZjeF8M4Q2EImBy8s0zEzPIKWnz1C7Of3tZ5YRFJ07DuxcR7MfyNvvjTxkMGA2pdiJax74tHS5rksJtyWDv6VMysWX2Y05H4wdCEdiR4/nqR4GEtMFVKOzITxwht3bgYQUHpNwmHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605332; c=relaxed/simple;
	bh=XhHyHOtSwHDDIM0tckjx0so2HvBXf6EjJ+FnZqUiM7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQNBn9KxiGhgdVkJANUZaDNbIPn/ltPRgxlHud8rYAHrb+ZGyauwVtpTNFnIthEKzjzrFoRbWUmz0+tk1hganCkF6CIVTB0IedUS2Am0GjzYBapGVHQ0ZjIv5ndVCh4p4UtakIsybeIXROOS/SsG8rEBboPbSy0m49zHMj9doXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yaxHMYBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C21EC4CEC3;
	Tue, 22 Oct 2024 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729605331;
	bh=XhHyHOtSwHDDIM0tckjx0so2HvBXf6EjJ+FnZqUiM7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yaxHMYBP51cKSnmD7V658l3LTcc7dlfrBkmV4n/LE8RRlVeeXxE90fz2MbCPUAEKu
	 LtJKrCS1ucZqTGnvhUM0VCK1KtwyP32AIqmhmKTrkXev3fZPiCFtFIWuGut+0laVlf
	 GObFqiDCTVFlZoq7MBD6yB8vsV03/5kepQ8B44nA=
Date: Tue, 22 Oct 2024 15:55:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 1/2] debugfs: add small file operations for most files
Message-ID: <2024102201-pummel-mournful-d349@gregkh>
References: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>

On Tue, Oct 22, 2024 at 03:18:34PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As struct file_operations is really big, but (most) debugfs
> files only use simple_open, read, write and perhaps seek, and
> don't need anything else, this wastes a lot of space for NULL
> pointers.
> 
> Add a struct debugfs_short_fops and some bookkeeping code in
> debugfs so that users can use that with debugfs_create_file()
> using _Generic to figure out which function to use.
> 
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

I imagine you want to take this through the wireless tree for the second
patch, so feel free to do that and add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks!

greg k-h

