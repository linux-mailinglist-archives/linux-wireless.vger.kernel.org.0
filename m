Return-Path: <linux-wireless+bounces-13253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB927987FBF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CAA284B2C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07D8178376;
	Fri, 27 Sep 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ba6FvxG4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825431891A8;
	Fri, 27 Sep 2024 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423375; cv=none; b=k4+I1AT6si8u3Dmc7O+I+i3K6t4A5EUagNV5922u6MeG/L60V6E7Td9kJEBhD+l+HZdswYgR6rycT8tZFQU40EQ87SvqCSTgiWeKRAQP90BXIkDWL1lIeH70VLGKNeMC8Kr48niu8WsfPqnJeRidkuKS9/FRVNITM7wTl/DsSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423375; c=relaxed/simple;
	bh=PVYfKoUUtEkUNbIQT3g+yTd9FcU2E/Br4LwF1UWSOc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hwuhkqv6bmxu0siWtLz5LajkkeNHCWc66uvf6nMR52SqSjKmAqPtpS5pRtGiQvFgQpG3K/7FF/Dw9iQvQKIWxO7Mw5csKgHdLq3GTt+nyPIhA1uvxr5fmgu7ocwbJo6a0qvHOJ4hrU3l9LoZlvAuqWX/g62ZPLfS3GukanECLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ba6FvxG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A5AC4CEC4;
	Fri, 27 Sep 2024 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727423374;
	bh=PVYfKoUUtEkUNbIQT3g+yTd9FcU2E/Br4LwF1UWSOc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ba6FvxG4lkBqH7rR5v0RseuPNGtvnx73lYD7wGCkx7W8Aw9drbdT12mNwVh3DG9KH
	 eu9IdmwkZ+fz6xD1CkZ3eWQ8sYGCDXjrMz/R+AZ3o9vrVxtiCLjrFVJjFqrTYFbVYb
	 PU1s/v8ed+6rmKUI2yZ/aJYMEvNm82MCyy9+XNSk=
Date: Fri, 27 Sep 2024 09:49:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: stable@vger.kernel.org, linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Subject: Re: [PATCH stable 6.6] Revert "wifi: cfg80211: check wiphy mutex is
 held for wdev mutex"
Message-ID: <2024092714-prepaid-rarity-0a1c@gregkh>
References: <20240926003017.5427-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926003017.5427-1-pkshih@realtek.com>

On Thu, Sep 26, 2024 at 08:30:17AM +0800, Ping-Ke Shih wrote:
> This reverts commit 268f84a827534c4e4c2540a4e29daa73359fc0a5.
> 
> The reverted commit is based on implementation of wiphy locking that isn't
> planned to redo on a stable kernel, so revert it to avoid warning:
> 
>  WARNING: CPU: 0 PID: 9 at net/wireless/core.h:231 disconnect_work+0xb8/0x144 [cfg80211]
>  CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.6.51-00141-ga1649b6f8ed6 #7
>  Hardware name: Freescale i.MX6 SoloX (Device Tree)
>  Workqueue: events disconnect_work [cfg80211]
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x58/0x70
>   dump_stack_lvl from __warn+0x70/0x1c0
>   __warn from warn_slowpath_fmt+0x16c/0x294
>   warn_slowpath_fmt from disconnect_work+0xb8/0x144 [cfg80211]
>   disconnect_work [cfg80211] from process_one_work+0x204/0x620
>   process_one_work from worker_thread+0x1b0/0x474
>   worker_thread from kthread+0x10c/0x12c
>   kthread from ret_from_fork+0x14/0x24
> 
> Reported-by: petter@technux.se
> Closes: https://lore.kernel.org/linux-wireless/9e98937d781c990615ef27ee0c858ff9@technux.se/T/#t
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Now queued up, thanks.

greg k-h

