Return-Path: <linux-wireless+bounces-14879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD319BB519
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 13:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA284B244ED
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335C1B3936;
	Mon,  4 Nov 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="c4/LBGY7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03F469D;
	Mon,  4 Nov 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724775; cv=none; b=VcbC7V5frz3x9MfQuGdh4x+Yv9n02eLAARzKb53PJehkfMn0DPELqrcVdGzmB9RJWRh6kEIPDAFEbI7x530mzuNVuDhQp7ouW+eo7cN3M7WNDC17mXNLkY5XrxzTFXe8KYDbrui7m4vn9VkE6d0vPXmCwvO6hPxllkuUxEOPFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724775; c=relaxed/simple;
	bh=ANTbVCW0p743koiKmSwP6yybPkRApgMTvYOFrIgxO78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAbvrq8gtLMWQPSbPdeGWjVpEYpW8fHEL9UsmWrVOzIHKXOv2JakQkAG+RLwChczUNMxWA4mI1QrsVfKqkt7Hb4POLh6hFTa602le7D75pEBA8PBOOc21SbmlPAjbm/XqYtxTf2hYtlyvXX/YGXSxRLZjJmSpohXm8ejKYFQ9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=c4/LBGY7; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=kADjd8kqhUMSYcoq7QoZ4zsjQnCSkY2oLGDs2k8/ZTw=; b=c4/LBGY7fiL13fAD
	N4K+Xsn7zJd1CpCwHNxm9LXWSU3JZp6gfZWccHQWhuQsRjoowM/SbqIxGLgBau9ndwkWf7VAnyFVe
	iJYP/JAa3uHZi+iyAt+LeGPjwj7+TXa8gvaqj/qY9KW6QFwX5L2WKSLBL5P0R9fKaPL65XBld+qKs
	4x9Amy9jxlYdRHI2M4yhgVJyV+lDo8Ua9kbdRHJZ2dm+NtO+U5iNP25GL8c/kd+3P4ae17yMH9m+J
	TitjipHbjeDjSEv2j+TL/eh2W+JHtzUOf7/1EZYhbqIJefmOmVpNYoL+8Y6FnwZmBs1YC0Y4Z5Pw4
	kuJ9yXWKUedthU2yqg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t7wZb-00FJyz-1v;
	Mon, 04 Nov 2024 12:52:47 +0000
Date: Mon, 4 Nov 2024 12:52:47 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: pkshih@realtek.com, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtlwifi: Remove more unused functions
Message-ID: <ZyjDn0R7gzDQ4jnT@gallifrey>
References: <20241103153857.255450-1-linux@treblig.org>
 <20241103153857.255450-3-linux@treblig.org>
 <87y11zxwlr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87y11zxwlr.fsf@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:50:18 up 180 days, 4 min,  1 user,  load average: 0.03, 0.04,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kalle Valo (kvalo@kernel.org) wrote:
> linux@treblig.org writes:
> 
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > exhalbtc_dbg_control(), exhalbtc_stack_update_profile_info(),
> > exhalbtc_set_hci_version(), and exhalbtc_set_bt_patch_version() are
> > unused since their addition in 2014 by
> > commit aa45a673b291 ("rtlwifi: btcoexist: Add new mini driver")
> >
> > Remove them.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> 'wifi:' missing.

Oops, can add that.

> Also in both patches the subject could be more unique.

Do you have suggestions? I don't know the code to give good titles.
They're both 'btcoexist'; I could merge them into one

wifi: wtlwifi: Remove btcoexist deadcode

Dave

> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

