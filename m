Return-Path: <linux-wireless+bounces-18956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643FBA35AD2
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 10:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BC33AF0D5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E97260A29;
	Fri, 14 Feb 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="kaQz8gT8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267D625EF86
	for <linux-wireless@vger.kernel.org>; Fri, 14 Feb 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526547; cv=none; b=N56FBk5cBbNZKkCl/cdaWm8huFIpS3h8SJdjv8iZ6A/LPT/2Sh42Qg5TDJC08SFWlCnVy+SIrpApIIcR/6glmuhT3rTomloki98+O7gu5yUbi/NeYs+MrRRlBhRgMzUo5yZVUExHxH8hFeidghgSo74QELfDPSVYICgOHxsmUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526547; c=relaxed/simple;
	bh=RUIV9j9FtpKEBJ6e+9yDZmtglHpS2aW5CuMqiv2nVCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKnaIVBb3E9U7JXSIDODiucbAVIMGlL0u67aknEQWJLMjNWXfrs4zisUA6tq5lrSdvN0kpm9cG0aBDXnyiLMGJ0TSK1jbrOR/gSixOy3nmNmmHGnH4AN8XGFKbmmRDfZ2Yx7hvsBiwilrMzuwhv6Sq5dwi6iGfUR/uR50iJRyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=kaQz8gT8; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <ae3d7e06-2ce0-443b-9de9-9b3e814f4deb@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739526541;
	bh=RUIV9j9FtpKEBJ6e+9yDZmtglHpS2aW5CuMqiv2nVCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kaQz8gT8/GJmpneYMfMuSBa8q9R3ltQn9fwizfjXWidG8qiXzSTmI4YtX8JdhERnS
	 Nbm59l0IX7x3aW/BTaOQX4ZPDkkxyF4XtI6Uiaxwo5Qtahj1gmIbXe6GUCXIbVWmkb
	 Q6Ra/Iiv4tbf1TH4oqB4kTPhe0J+00MXA8lzUOcY=
Date: Fri, 14 Feb 2025 10:49:01 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [wifi] be22179cfb:
 hwsim.monitor_iface_multi_bss.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org
References: <202502141548.e1f3f465-lkp@intel.com>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <202502141548.e1f3f465-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.25 08:56, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "hwsim.monitor_iface_multi_bss.fail" on:
> 
> commit: be22179cfb2fb1164004b70b33a4bdf67e6dd349 ("wifi: nl80211/cfg80211: Stop supporting cooked monitor")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 7b7a883c7f4de1ee5040bd1c32aabaafde54d209]
> 
> in testcase: hwsim
> version: hwsim-x86_64-c8c7d56a3-1_20250209
> with following parameters:
> 
> 	test: monitor_iface_multi_bss

I was expecting something like that:-)

Cooked monitor interfaces were required for hostapd versions less than 
1.0 (released May 2012) for running an AP. Starting with v1.0 hostapd 
prefers the cfg80211/nl80211 API, while still be able to use the old one.

This patch here now drops cooked monitor interface support, preventing 
hostapd to be able to use the old cooked monitor method.

Any kernel with this patch must fail this and any other test using 
cooked monitor mode (driver_params = "use_monitor=1").


Alexander

