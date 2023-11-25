Return-Path: <linux-wireless+bounces-72-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB927F8BD1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 15:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CBCB210E1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AF18045;
	Sat, 25 Nov 2023 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WUVq03uz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848DD301
	for <linux-wireless@vger.kernel.org>; Sat, 25 Nov 2023 14:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE4AC433C8;
	Sat, 25 Nov 2023 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700923709;
	bh=lVV3TZ7xcw4MBjj6Q/YGZ61+1phxV7dz1wIibObBG6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUVq03uzYfCozEemk6AIUEc5HiJWqS4DNi7YWjLHAphQrHSfjJ69gnqlVebPkG5lv
	 GkVXql+9UtRCwzeVk/H9e9vGDsEy7fy676YwOq6tlS0OGxnRhIBtXAreoFEs2FUijw
	 dzsRASy5mL4q39c2xTqypGpnqhi69eNctWaE24pk=
Date: Sat, 25 Nov 2023 14:48:26 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 1/6] debugfs: fix automount d_fsdata usage
Message-ID: <2023112519-reprocess-backtrack-0732@gregkh>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
 <20231124172522.01928f127e73.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172522.01928f127e73.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>

On Fri, Nov 24, 2023 at 05:25:24PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> debugfs_create_automount() stores a function pointer in d_fsdata,
> but since commit 7c8d469877b1 ("debugfs: add support for more
> elaborate ->d_fsdata") debugfs_release_dentry() will free it, now
> conditionally on DEBUGFS_FSDATA_IS_REAL_FOPS_BIT, but that's not
> set for the function pointer in automount. As a result, removing
> an automount dentry would attempt to free the function pointer.
> Luckily, the only user of this (tracing) never removes it.
> 
> Nevertheless, it's safer if we just handle the fsdata in one way,
> namely either DEBUGFS_FSDATA_IS_REAL_FOPS_BIT or allocated. Thus,
> change the automount to allocate it, and use the real_fops in the
> data to indicate whether or not automount is filled, rather than
> adding a type tag. At least for now this isn't actually needed,
> but the next changes will require it.
> 
> Also check in debugfs_file_get() that it gets only called
> on regular files, just to make things clearer.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: add missing kfree() pointed out by smatch

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

