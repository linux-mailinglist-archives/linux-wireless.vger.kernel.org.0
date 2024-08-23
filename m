Return-Path: <linux-wireless+bounces-11850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CAF95D089
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36DF285F40
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCE188902;
	Fri, 23 Aug 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noIV3Lqa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FC1C680
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425172; cv=none; b=SZxqaZgNMYV45JJ6oI5ZZ428Lmk1f/jspncaUgxjyv9ztWYo9T1iE06MpoICH5CFS8s3ysG/6InpJilOiz7ToX+XhUfaHRq6EnGL/OK+CoYVqlFJQj0mYUC/Glitll5hkoCOZyD75liJi4kRqOZa6Nt6vMymeMBLnFhBWhoVCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425172; c=relaxed/simple;
	bh=QUh7sAfzuvBr1+nrICscYwROi3icEQB46bBUpWMkOLk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=R+mIk6Cd+wFJtHvOkytoz/w6LjpsLqJ1MUiymOtByIlIBbowxZyIsy7plbCBv9XxWhI0g1T4D8+iwo+cnXVzZC7z2szt9ahKDgytp7frB8ZfGeypmMCJmO1ghVwP/IZGljYLQGtT+PgkPId6AkgkQuxp199McyvA2e+tqekgqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noIV3Lqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD134C32786;
	Fri, 23 Aug 2024 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724425172;
	bh=QUh7sAfzuvBr1+nrICscYwROi3icEQB46bBUpWMkOLk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=noIV3LqaCrjKnrl7j5qjHlSkUBDF4hpKXz90SUojz1AiFjslyAfadAoHUz+oyrBda
	 GfRhDLTHC74JNWiFJtWVYK/LnLLJBxGEoshe1DdhyBZAhnCOVj247rX3wGWFpJPkPO
	 2T5um5tGA3DkRk10TJ/I92Z8XWmW+lz/FijqyNPECxlBlKq10tW/F7oFlVDpnZ1hdv
	 pBbHvtQVtwjVXqGl9NX4hd7Ylrh6ZdNxODlOg/Ha/ZzYjMPFlrhAiriCfpekidRasN
	 +7iBbb3y6u9uVmZ4o7EgwK9XN6j+DIEAL/SM54BoU3JTE5hJsZa0gG4vlIU2CXYLnS
	 AxWSnuwA2YQ8w==
From: Kalle Valo <kvalo@kernel.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: wfx: repair open network AP mode
References: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
	<1926e71dfbe3fd4735db59879211e9d319ea9ddd.camel@siemens.com>
Date: Fri, 23 Aug 2024 17:59:29 +0300
In-Reply-To: <1926e71dfbe3fd4735db59879211e9d319ea9ddd.camel@siemens.com>
	(Alexander Sverdlin's message of "Fri, 23 Aug 2024 13:42:51 +0000")
Message-ID: <87seuvuvxq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sverdlin, Alexander" <alexander.sverdlin@siemens.com> writes:

> Hi!
>
> On Fri, 2024-08-23 at 15:15 +0200, A. Sverdlin wrote:
>> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>> 
>> RSN IE missing in beacon is normal in open networks.
>> Avoid returning -ENODEV in this case.
>
> Oops, this is a typo and should have been "-EINVAL".
> I'm ready to respin with corrected commit message, but
> I'm also OK with a maintainer massaging it.

I can fix the commit message, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

