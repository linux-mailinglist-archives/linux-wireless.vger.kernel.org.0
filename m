Return-Path: <linux-wireless+bounces-13757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB99995FFD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5334C1C21EE3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D57716BE20;
	Wed,  9 Oct 2024 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qSmpGjfR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F122EEF;
	Wed,  9 Oct 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456220; cv=none; b=GiS7CGZr66RZL9Bj1znqoq9rtNJoQCewzXri/Rm0ciWhZni2A1czyI1maOLPDIlKu3EO14Z59JgMvSAIvQ77TFr8FrezU+i/b4+0bLUK+H1JU9OxKRZfoPSZfWZOw1V8nmWgEBtqOhuy3GjbjmNXAb8iHp9sRmLqqn0egThygG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456220; c=relaxed/simple;
	bh=FBh1CoWJwvrp6dzrhyfNBSTQqgIQukmxvk6C5d4oRpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8AL2QzlV9NtztCTMIoKMfPOgapwqZsXh+j4Hpd7ODXQY1MFFE/HlT3sPu9kVSCBGafNkJpZi7AKjGX8/JoYQLrUy3ESo9oE6fWXqjWc2OXqMKLCXRkOVcUwahXB/A67L5u7vba0KfeIV7ZWuFXRNEDX8xQvrn11iuVtOayvel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qSmpGjfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB9CC4CEC5;
	Wed,  9 Oct 2024 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728456219;
	bh=FBh1CoWJwvrp6dzrhyfNBSTQqgIQukmxvk6C5d4oRpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSmpGjfRlefA//x2elgAFzdpdcwsxuweTrHw29+mYXZeo5PxJfYtZoBheFBYw3HHq
	 2LNL9g45jEcD97AN8/RbBU0nkT5C0XJLQYxeXBVo+sp/LZr8AyMX3XxygHMvsVDiT3
	 pQ5t643HofquB4HOv0jmzTIt0GkTXh/LDr2AYSxo=
Date: Wed, 9 Oct 2024 08:43:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Johannes Berg <johannes.berg@intel.com>,
	Wireless <linux-wireless@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Tree Davies <tdavies@darkphysics.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 tree
Message-ID: <2024100945-engross-appraisal-d1f0@gregkh>
References: <20241009114455.52db31ad@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009114455.52db31ad@canb.auug.org.au>

On Wed, Oct 09, 2024 at 11:44:55AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the wireless-next tree got conflicts in:
> 
>   drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
>   drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
>   drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.h
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
>   drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
>   drivers/staging/rtl8192e/rtl819x_BAProc.c
>   drivers/staging/rtl8192e/rtl819x_HTProc.c
>   drivers/staging/rtl8192e/rtl819x_TSProc.c
>   drivers/staging/rtl8192e/rtllib.h
>   drivers/staging/rtl8192e/rtllib_rx.c
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c
> 
> between commits:
> 
>   5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
>   5e6bf74d63c2 ("Staging: rtl8192e: Rename variable RxDrvInfoSize")
> and many others
> 
> from Linus' tree (pre v6.12-rc2) and commit:
> 
>   be9be9f54f22 ("staging: rtl8192e: delete the driver")
> 
> from the wireless-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Johannes, any objection if I just pull in your wireless-next tree into
my staging-next branch so that we don't get these issues going forward?

It's not going to be rebased, right?

thanks,

greg k-h

