Return-Path: <linux-wireless+bounces-14768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF59B7725
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 10:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D78B230D9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028419343F;
	Thu, 31 Oct 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cTxG0950"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D99193427;
	Thu, 31 Oct 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366063; cv=none; b=HKuJPylaaUfLQyJrutCXfK9e98/edCDWmyY/VP9sJ0VIwmw9KGu7BBAfoO4Fmar/ZCqW8J2IMIjY/abJE+Rw9SMm+6tYxWHfXU9L1XZiOqdtgWT5sIvcB2bZbf6Sbd8mJewjvpF56ly81sgxWI3dwmRDrI+Aeq454utWrmFrw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366063; c=relaxed/simple;
	bh=5Q45RTbSjOjBlp3SygGSMuq7WMqUe32chDxswiHpUtI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnELxlU95Xp5q4imsMWedvNqvrt4Pwq00HE04RSJ4X9nkis2vzrBlNtx95kW02PLfJmAsqNKzeKxadVQl15GbY75/EO7NBG6E46NuPO1Ce9T8N3/Ck/yU8FW1TKq8wGQy++EzjxxS8Cke0K6NyhQQ50VCtDrAnBJEaZdAQPqFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cTxG0950; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1730366054;
	bh=jZ7hCTaVut3mZbCJbGFLXFGxd6/H6md/TZ1pj2DkSxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cTxG09503B4E3EcCq4Tlr4SOP5tpNriTxkwdgA9WRfof/7mfXUXVCXoPSxZAD016s
	 pWjLrKck+Fp4TzbNIL8LqUXvy40pyL8aFRU5akeUvgGPLgXbMYo0dGRMEYsP4cM7fX
	 VoWm48I03YvIOT2ZIL3KwES78aJGg64q+qbyXjOs=
Received: from localhost ([223.70.160.239])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 2071D25C; Thu, 31 Oct 2024 17:08:07 +0800
X-QQ-mid: xmsmtpt1730365687ths52uw97
Message-ID: <tencent_9E86EA49928C177B25C1691D4454AAB21106@qq.com>
X-QQ-XMAILINFO: Mv2ulet+XN3NjEpaj3v5W09FCOccoH6qPYx7PV2Ta6BCPoCNWGDsgtWOJkWFfO
	 +d8s0sCqZai/8akJBW/WHSe8TuL+MPd9MtmADoh8r2aO5zjfy8Sw+6rWui8kYRPaYoHG7nJn7A/m
	 WXYxSmIIK6teADp8GBz3H8kpLxl1h6P4Sqm3/8lbrf0fML6ig5nEdkaKin5fRCzVFtSBcHrJTctC
	 Oj+i1zcOIcPxX+sv+C9Ke2ASZZbu6KplOeeXT/1QwUNBOmfNkPhayDZhPkvNm8LNCRff5bF9oXi1
	 JMkKVJeGlLfYbzxGWJnSnNA67UyfXFxqgoFYfr5DzEIa9pmf+CaLB6t5skY094XvJL3J7Z+3+4jY
	 7jL2OokJgGhk915PLRTilKBChtsixZLJS1qi0YoMgzKW2sNEiz5zSrdgLimbqL3gUbJBTUzCFQ9e
	 t6x2WKy458q7RG+K1RRP6/kvXSjjeIfg/Qj3SIirZTCfsqtLRqTIxApGvKQlo43+e8elqyyBMM98
	 yCFPV67gvxNgQMasq7bEfwfAhPolnjfhWYsafeoYUPU8gaFUWek7iJR9/6EgYqzH4CCLyiphTzOB
	 dxJv65VdE4monD2F3BftXEWw/PmfOGtw/KVmV4bxSQcNU7jJeVrGDrd3QHF8QcY9ZCKARMtLU9JB
	 bJxbtORXJMS9PUFpB+upja/MKGSK2bUrIOSGpwzN8tB9OQtPsI9BWzKeEbi8QUI17anhC4AnjzD2
	 qEAc+L++kho0nbq0cvzZUoH/rW9IyNrh4yI0LH8MZeOPz2hLSDCOmLWjSB0L8d9fWbIu4SrFFBN3
	 uYpYYOwF9tWfojTnZ9p7cDxWyQxtW2TtV9phE+1gm1NIYHZjWomZAxGY5GBeNoPrngF6pMAL037k
	 SZGpLxYpMKAVwieQDvnaLJPu9wlToXJy4V+E1IZW5cUc1NQu/LEAyt3vlErw9g51wdAvCvxsBUla
	 E21nUnl+h2V15IrZmV2agFJY6IOsHHhWMn3OCHyXLg4DQiFnEPORQPqtsksk+5DOiZ3G4tcQHtIt
	 xgurRt82qQB1vdiCBUn1mqu1+hskY=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Date: Thu, 31 Oct 2024 17:08:07 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "miriam.rachel.korenblit" <miriam.rachel.korenblit@intel.com>,
	kvalo <kvalo@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Issue with iwlwifi Firmware Loading When Compiled into the Kernel
X-OQ-MSGID: <ZyNI95gdvc-FKXe9@yangang-TM1701>
References: <tencent_2C31282B61589DFCC908B3831384D569440A@qq.com>
 <7100cb98b8e46793cfb1197c3af0f151a9628c9d.camel@sipsolutions.net>
 <tencent_7DC9187727BD32FEEC99045E754751A0CA08@qq.com>
 <5fc092da11b3d81c99fc4bc4b78e87783280414f.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fc092da11b3d81c99fc4bc4b78e87783280414f.camel@sipsolutions.net>

> On Thu, Oct 31, 2024 at 09:57:33AM +0100, Johannes Berg wrote:
> On Thu, 2024-10-31 at 16:52 +0800, Gang Yan wrote:
> > 
> > In fact, I'm using Ubuntu's userspace, but I've simply replaced Ubuntu's 
> > kernel with the mainline 6.12.rc2 version (x86_64_defconfig). By merely 
> > changing CONFIG_IWLWIFI from 'm' to 'y', the network functionality normalized, 
> > which is inevitably confusing. By the way, both of my computers encountered 
> > this issue, with network devices being Intel Wireless 8265 and Intel AX210, respectively. 
> 
> Yeah well, so Ubuntu integrated everything in a certain way, and because
> they build everything as modules they didn't integrated anything to make
> it possible to build modules in the kernel.
> 
> When you change it, you own the integration. I gave you a few ways to
> solve this, simplest is just specifying the firmware to build into the
> kernel in the .config file.
> 
> > I still think some clarification will be helpful to make the configuration process
> > here clearer.
> 
> I don't think we need to change anything. Whoever makes some changes to
> a distro needs to actually do the integration too. This is in no way
> specific to iwlwifi, every other devices with firmware has the problem,
> and generic ways of fixing it already exist.
> 
> Johannes
Thanks a lot, I understand what you mean now.

Gang Yan


