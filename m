Return-Path: <linux-wireless+bounces-327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83C801C75
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 12:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496B91C209B6
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641A1641D;
	Sat,  2 Dec 2023 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FyXjgZb6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE616406;
	Sat,  2 Dec 2023 11:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25429C433C8;
	Sat,  2 Dec 2023 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701516840;
	bh=KEUGCLOiwFkgMJXRlyG+oUNJO9xiK0lczX8NYwcUXKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyXjgZb6IG9Y+hcPdzsjFrlRltKq+ibpmj8imqwkpbGixvOngMaMtkzv+u4cZZbl4
	 nVIeDGSiwZeK0DACYYSJYLvrmeuXoU6Cp4mfA99Pfv4FfnJsK7rs1YG+diwxv7+X36
	 zmw/ge/00UFcbNOIVux0naVpiaZosX9UFqWTQ2ME=
Date: Sat, 2 Dec 2023 12:33:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] Revert "debugfs: annotate debugfs handlers vs. removal
 with lockdep"
Message-ID: <2023120226-cytoplast-purge-bf13@gregkh>
References: <20231202114936.fd55431ab160.I911aa53abeeca138126f690d383a89b13eb05667@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202114936.fd55431ab160.I911aa53abeeca138126f690d383a89b13eb05667@changeid>

On Sat, Dec 02, 2023 at 11:49:37AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This reverts commit f4acfcd4deb1 ("debugfs: annotate debugfs handlers
> vs. removal with lockdep"), it appears to have false positives and
> really shouldn't have been in the -rc series with the fixes anyway.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  fs/debugfs/file.c     | 10 ----------
>  fs/debugfs/inode.c    |  7 -------
>  fs/debugfs/internal.h |  6 ------
>  3 files changed, 23 deletions(-)

Looks good, want me to take this or are you?  If you:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h

