Return-Path: <linux-wireless+bounces-14766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF579B76C7
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 09:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CCC1F231C9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F67186E2E;
	Thu, 31 Oct 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Mb1XjJQm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE9189905;
	Thu, 31 Oct 2024 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364733; cv=none; b=duq+7LdJXZ2pA8JUS7LQBnf1SYGF1fZnSVY4XGsQrdCe8EYrql5eSCNtHWFn9XPtjVrrqkmnOLwivUO9o49Owrz2n8fhvD886rTYlYhcVg+BWagFXykqfg9T508m79VUFYzMHR3CwbOPTt9VMVIfywcSFHTyB1djbN5++xO6hyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364733; c=relaxed/simple;
	bh=OD4++8eU34WDejznqj4CwWzT9G4WKmpLD/pKO9cIqLs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGQ4FJCbPEXvELDcl/FE7npUEEvx9JE1i2AAQIjbWhts2b/zKXoXyaw3gtnmKUmewI2Z89PFU5HPNOoKjNiBXAvUzyhUfWpiCBTBi1O/q2/tsVutua/XiPq1RBxzxlRoatCQKZFXEEvQn+rw2WQuS0TzP5+KYrh7YRzgfVeTRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Mb1XjJQm; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1730364724;
	bh=RqQzm5njDUt57sj6JFYtgqirZ+wrdPC55MAlo/LsUNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mb1XjJQm3tFHAKWkxOify3o5c5KfjNsbr45z5qErr9bHamhC80KEP2IEmEY8Ik4p6
	 nsJ8eE5vEj7b8XfdcPQAggyt+SkGr9qxDkDmaR1hZkjAoJTI5l7+piEz6oEijsNqZa
	 OcYjNDOwzJUNp8wni8FyD4wDKviKsiqdU2GumdXU=
Received: from localhost ([223.70.160.239])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id D0305C23; Thu, 31 Oct 2024 16:52:03 +0800
X-QQ-mid: xmsmtpt1730364723tmgb6109w
Message-ID: <tencent_7DC9187727BD32FEEC99045E754751A0CA08@qq.com>
X-QQ-XMAILINFO: N+BV1J6/yX+aMZxZEiKGqQ4h2jDUuCJouYph4V3axInhF5Iy1SMAg4HzDuOOz4
	 GKxhbSJnGMz0Ct71kxwxKFzOV3p9pmnb3MihjmnCy8l6gvvNvmn1VNmLx0jmgQWlM36XZrLGUPlj
	 uHD4b/aRFUCRFMQUgc55A8zOzXQMr4Xb0wa2jLjmYYqbnl97kXec7UHfn1I9+wF2ypZI+tFoJai1
	 nSaagm4XbSmK/N4JHS07fevv0SGHAX3ZDNNxvECjfud8EmWOWNtzEvOQUUv4WOtB/8g6qxeRLLNv
	 IhTB5Lf25zYkNeg4fU7lX/WB3Zs0m9wQsVto8VSDZHqOSd+FJbFWYmtV1eCCrFOChSozUdj7ofLF
	 0E9lxqJpxjKlOJ13h0N8b0uViPjA5tKbwpwVuSDkCKLi7fi7FXmeEWS8Zlo4RLt1cnNK90bpGv8x
	 qOOcYKaFj48mRiVkHCBKJG6/WkSP5MiTILARPL0wH6ZJPpKpo9AxHZTgbdax8TEW5nZORD8oDXOh
	 Ka1l3GB82pMRsDQlxYxCzsBMXJ2chYMQ9jZKGCRW5FHq78LC2Q2oPkVxSd7ppBiQ8Ndm6kvKPDrl
	 24SNe+UvrNDwWfCYo+F+zP62SRZkifu9CdHKO9+87KYxurTWdLaYEjb4H60GOIFFpKIF5sZk2Gkv
	 c6RmHbABwXc8cAkFFfTpxnLYOZrmsoaSu8JSDy9ItDjKfXPDwWw4Q4qZDMqeb4zhrTLLw0Tszwp5
	 /+1QOQKoNkmUf2shSJLemfxLd8Bl+Bb12sJp2wphEuBXJWPAgM8F0D4/KMwtgx6HbtFCJO9q8hSb
	 JcB01DPcALPvv06GaGyGfg+69kjwn/02OM9wqPDwZxYxyKwZae6VtFdqGCLvYje93y+W63A2Uvy8
	 Ud5PAPi1q52CWDm9Tc93/ihb6SwM2IaykSZo1pZQmVBOREIARXbVbelL4x28dhAKufOXmNzqYkI2
	 LcbEnIWAzUAz8QtGsjfbfOmONfPplsa8nb7aLG4ec9Xawve5mzqhcnGcjD8lwc
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Date: Thu, 31 Oct 2024 16:52:03 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"miriam.rachel.korenblit" <miriam.rachel.korenblit@intel.com>,
	kvalo <kvalo@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Issue with iwlwifi Firmware Loading When Compiled into the Kernel
X-OQ-MSGID: <ZyNFM9GRPt5x--63@yangang-TM1701>
References: <tencent_2C31282B61589DFCC908B3831384D569440A@qq.com>
 <7100cb98b8e46793cfb1197c3af0f151a9628c9d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7100cb98b8e46793cfb1197c3af0f151a9628c9d.camel@sipsolutions.net>

On Thu, Oct 31, 2024 at 16:37:49AM +0100, Gang Yan wrote:

Hi, Johannes:

Thanks for your reply.
> On Thu, Oct 31, 2024 at 09:06:49AM +0100, Johannes Berg wrote:
> > 
> > To address this issue, I have considered two potential solutions:
> > 
> > 1、Modify the Driver Code: Implement a mechanism, such as delayed_work, to 
> > give iwlwifi another chance to load the firmware after the filesystem has 
> > been mounted. This would involve adding additional logic to the driver to 
> > handle retries for firmware loading.
> > 
> > 2、Modify the Kconfig: Change the configuration to allow iwlwifi to be 
> > compiled only as a module [CONFIG_IWLWIFI=m]. This way, the module can be 
> > loaded after the filesystem is fully mounted, ensuring that the firmware
> >  can be found and loaded successfully.
> 
> Neither of those is going to happen - you should just build the firmware
> into the kernel (or initramfs might be enough?) if you want it built-in.
> Or set up firmware loading userspace, and set it up appropriately to
> only respond after / is mounted.
> 
> In any case, not a kernel problem. You need to fix it on your userspace.
> 
> johannes
In fact, I'm using Ubuntu's userspace, but I've simply replaced Ubuntu's 
kernel with the mainline 6.12.rc2 version (x86_64_defconfig). By merely 
changing CONFIG_IWLWIFI from 'm' to 'y', the network functionality normalized, 
which is inevitably confusing. By the way, both of my computers encountered 
this issue, with network devices being Intel Wireless 8265 and Intel AX210, respectively. 

I still think some clarification will be helpful to make the configuration process 
here clearer.

Thanks.

Gang Yan


