Return-Path: <linux-wireless+bounces-11112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAFF94B6DF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 08:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2471C21638
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 06:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F918785E;
	Thu,  8 Aug 2024 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Rbte1X6j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337018785A;
	Thu,  8 Aug 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099442; cv=none; b=KckdeWTp0b93cM0TGMRpuDb2zxkC6RCx96YViXjo8vM2zJqVWgDD4XMpvXW6Ku/6Q1gpE5uFqWJbTc3cvavK7Xq1c9BtmLmNpt1XD7f0Qr8IdKjIaXtKnfq8wxmHGbYSp30B8mHik24w7VeEmT7BSqltdhn5Xd/hj1brLn79qQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099442; c=relaxed/simple;
	bh=yPACO+Jpk57bGOXKE6eH4KJVxi21a77o4RVFUjZxEII=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u8uQmi84eAPIFVUHCt+wTOVmgmy5Hq3GUbkmjIZaVpKe171uUUe+qmithb6KiaJHua0OHRBTcAKOIEgUeUMt6D5JEZnpXySiJ2ErZU5QoND3JWP+kJZLxgITT3M515bmVciMhpQA0VHfiem8ogX47+eTH5IjQK8SFDC+dW/wFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Rbte1X6j; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=LO0DrB2M3N7hfrUS+mFnSFKIjIfPOXAvmp2wA4sqSDw=;
	t=1723099439; x=1723531439; b=Rbte1X6jdR6OjLsOvOEfZqT5yYETRUbci5tMVspYxWDhL9D
	NYcT13DOn3GHThEV9rSQG08ostJoOgcLQdaCyXqMKHIk7f76eSWg1BUCft/xnXrWoISu1eVt0w94E
	3ebQayFIBv3xtJqas/kH8GykxuxGHgfCCZnMATLQwhRvzSfsSFzVqFbtWQzW4Nsn6LZ4FXdnCKQ1b
	N2uzzA/F1pjGiMy0MJ5/G/S1QSxH2OrV53CpZj+/wAFTeQZ79W/p3eHb7vPRQvNLh00m2D8eBS58G
	Xh6lX7AQy2yJrTD/qyor9oWQqg2IkvVIZht+lUGnCHDPrYMuTv5GQMxVuWxSd/7A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sbwsL-0000ZV-R7; Thu, 08 Aug 2024 08:43:53 +0200
Message-ID: <8e9c5c74-9b36-48bb-b74a-9a209b71a634@leemhuis.info>
Date: Thu, 8 Aug 2024 08:43:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] Significant WiFi Speed Reduction with Kernel
 Versions > 6.8.12 on Intel Wi-Fi 6 AX203
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <7a43d26e-95eb-49d4-bc02-434c239909ff@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <7a43d26e-95eb-49d4-bc02-434c239909ff@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723099439;01696715;
X-HE-SMSGID: 1sbwsL-0000ZV-R7

On 07.08.24 11:12, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> Mukesh Sisodiya, I noticed a report about a regression in
> bugzilla.kernel.org that appears to be caused by a change of yours:
> 
> 099a47dbe71b75 ("wifi: iwlwifi: Add support for new 802.11be device")
> [v6.9-rc1]

For the record, turns out the bisection went a bit sideways and the
problems apparently is caused by 84ec2d2e960f33 ("wifi: iwlwifi: disable
160 MHz based on subsystem device ID") [v6.9-rc1]. For details, see
https://bugzilla.kernel.org/show_bug.cgi?id=219114#c8

Ciao, Thorsten

