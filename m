Return-Path: <linux-wireless+bounces-26694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A434B37F79
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 12:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DCC189033C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722DB3126CB;
	Wed, 27 Aug 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gr7ETH0E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE192773E0
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289130; cv=none; b=Gdl9gyAUXX5oN/+gTfKI7BOMllUbI712ehhH0hRz5fB9tDIF3yitI224iukwO9o+HoxFVR4DgnDFFPo5FruEznM781ATbj77qyiGB9UTquvo9XerZQOO8hASOK3uUNUn+Z4l8T3jW9539SljfvOPY27Umlq/Bnmv2UnhH6+vm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289130; c=relaxed/simple;
	bh=uDtonrv5F0Tm13HEdeo/NT4DyHYzETvrQtYYJEQ4+Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exspFSduLfTy/VWnhJFL/g55lB8wMd+UJJx7SBxsWXbgEdwnq3BNmm0ui/QgsDXpxDcpn1/OxqPAAlMJa7ijFa9lcQyS4RjLg6zFb6fDhvpoHWIeW98iHZpmg0ReuqL7+EuqY+MUYh+i7kVSb+ZdB+U1RuCbVpY7kz3lq+OIzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=gr7ETH0E; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id rA8YukXQMA2i6rD1zuWmrf; Wed, 27 Aug 2025 10:05:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id rD1yuI1bv1ar9rD1yu3jFt; Wed, 27 Aug 2025 10:05:26 +0000
X-Authority-Analysis: v=2.4 cv=RtrFLDmK c=1 sm=1 tr=0 ts=68aed866
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DR2cKC/DEnBA9KqqjaPhpA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=g_siC_MSOhsqshzUI34A:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6PngVi7LJ4k5lnqjspPjNk39ZzYBo+04kKzgOBdbfns=; b=gr7ETH0EDL2tSYMtLr7QuhmRH1
	bmRGHsxJzzZc6h1l+EqB9Wm9r0iNrukYEB6KLMYBfjkgzgSLk5b3bYfH1oFkR11jR6w3X4uUeb3ws
	Sj+EK+jPwSULVeAC0gCuMZfjFtIW/RNbLQsrgM0UU8hZ3lLoPNMx7qBlA90aIUEFFJlNY8F3oQlab
	35qlvrSGdEXMTgKxDJtWVDTXNXaLptCYQxh5Wck3BdzMqVykMZD1VY2Ey23O6hIMA6FnylpUZues4
	i00Uuy2O21B+2/gh2exX9NpBw1upCuorMeFb6LkOcT0G2f4WVCVEirCFe6dC+JD5O15caXteI6R7x
	pX9QA55Q==;
Received: from static-243-216-117-93.thenetworkfactory.nl ([93.117.216.243]:58552 helo=[10.94.27.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1urD1x-00000003Hmi-2Nz2;
	Wed, 27 Aug 2025 05:05:26 -0500
Message-ID: <2b54967e-bd1f-4ad9-bba7-aa05bf3d1e7c@embeddedor.com>
Date: Wed, 27 Aug 2025 12:05:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iwlegacy: Remove unused structs and avoid
 -Wflex-array-member-not-at-end warnings
To: Johannes Berg <johannes@sipsolutions.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aJl7TxeWgLdEKWhg@kspp>
 <e0aeda2d-931c-49c6-b0d4-dd097e87eae6@embeddedor.com>
 <0ef7587b7ae57d9363312ca130980707a68a3f7e.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <0ef7587b7ae57d9363312ca130980707a68a3f7e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 93.117.216.243
X-Source-L: No
X-Exim-ID: 1urD1x-00000003Hmi-2Nz2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: static-243-216-117-93.thenetworkfactory.nl ([10.94.27.44]) [93.117.216.243]:58552
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCFjgyQaUbxNTJKjn+Dee3Y2B61x42xkN7Mv8sVanRAwc4vzwU8M/DunB4jwnJ4Eo+nCGDxY1Car9uvcl5WMnbpWcaGHowyMbiXb0vsYwj+SmL3/DjUu
 6XnWdJR0f2oUcPJ1lBueyGq4SGXjKCHmaPS34BuxjkYaDFv/Yj8YdNxLTqmzU8J6k8/MfnNQP5EVD7y0sjMAgNsFHMyAlOqw6bDekU332Hzx+BYm1+UfFtZ+



On 27/08/25 11:36, Johannes Berg wrote:
> On Wed, 2025-08-27 at 11:25 +0200, Gustavo A. R. Silva wrote:
>> Friendly
> 
> I contest that. It's been two weeks, while it's still summer with

Sorry, I don't really know when people around the globe are on vacation
or not. I don't think we're based in the same area, so our customs may
vary.

> vacations etc., not long after the merge window closed, with weeks to go
> until the next release comes around. Why are you impatient?

Apparently (and according to git blame), the last person that committed a
change to this file was Greg KH back in 2019, see: commit 16da78b7b580e
("treewide: Replace GPLv2 boilerplate/ reference with SPDX - rule 270").

So, rather than impatience is more about not really knowing who's maintaining
this file.

> 
> I will take it. Eventually, the more you push the less I want to. And

Not sure what to make of this. I'm just doing my work and trying to
collaborate with people. I expect all my comments here clarify the
reason for the ping.

> it'd help if you actually followed our conventions and used 'wifi:'
> prefix.

Related to my comments above, you're not listed as a maintainer of this
file. If you were, I'd have probably remembered that.

scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
Stanislaw Gruszka <stf_xl@wp.pl> (maintainer:INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy))
linux-wireless@vger.kernel.org (open list:INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy))
linux-kernel@vger.kernel.org (open list)
INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy) status: Supported

In any case, thanks for your response.
-Gustavo

