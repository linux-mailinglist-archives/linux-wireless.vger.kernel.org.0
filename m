Return-Path: <linux-wireless+bounces-5306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E85BE88D2F7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 00:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553E51F329BD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 23:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C5713E059;
	Tue, 26 Mar 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="LHEZM1gJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228D13DDC5
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497507; cv=none; b=nWmnGK7oQTpWpZMhekIQuXx8TEfzHaB4ZJ2NioTAJCpvxgP7eYY5abyCzXK2sBQsZ76ATq3RGQwJrTIRRxcjlldP3lkb3zMC8fcCX+Vh2moj/r3+uG46JLXtZGG+WLCBWIejv1s92hUZCaj4uEZl4PCh9sPV8bBozrkLTJ2GxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497507; c=relaxed/simple;
	bh=P7YrALNN1oYdVzWwojiAItBmxDD29fT4d04FvDYhBqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1ELyiAjhdLY75qD0TZjK7rvb4I5OFbNuaoIT2XQJl2LEDNOsaTzH3lUVtvN3mE0MAQRW6Oj6JhAVFPFEXFDLmWJquiwrwSjO47snjL25OXMzWIN4UkRVo2bkGedpQxxrPC0l2yb8lr2crvOW+Ec/AeEqEyuDNlwRPY8f6z68bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=LHEZM1gJ; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A8CFC2A29AB
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 23:58:19 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 20EA8240071;
	Tue, 26 Mar 2024 23:58:12 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 652BC13C2B0;
	Tue, 26 Mar 2024 16:58:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 652BC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711497491;
	bh=P7YrALNN1oYdVzWwojiAItBmxDD29fT4d04FvDYhBqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LHEZM1gJ+A5TmUqydJDSAMBTk76DPMfRljD7UW21GdChFQmY1K2naVp8N0AC6oM7G
	 i361Y/rWTpOTdk5suHXb6BuL3NQDNGMtYT5w0s/KkkHY6ANRgtMbIo2e9VtZJ2rPB0
	 i9wVjRo9qTdnFU2pntYCkcqyzj0HiEX1B+iHqSzU=
Message-ID: <7dd7ef40-ea25-4c38-a3c4-42262f5d09a9@candelatech.com>
Date: Tue, 26 Mar 2024 16:58:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] wifi: mac80211: simplify non-chanctx drivers
Content-Language: en-MW
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
 <20240129194108.6d0ead50f5cf.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240129194108.6d0ead50f5cf.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711497492-9RadJ2gCWNvS
X-MDID-O:
 us5;ut7;1711497492;9RadJ2gCWNvS;<greearb@candelatech.com>;f1d04f72c2073390392d60b6e12a1708

On 1/29/24 10:34, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are still surprisingly many non-chanctx drivers, but in
> mac80211 that code is a bit awkward. Simplify this by having
> those drivers assign 'emulated' ops, so that the mac80211 code
> can be more unified between non-chanctx/chanctx drivers. This
> cuts the number of places caring about it by about 15, which
> are scattered across - now they're fewer and no longer in the
> channel context handling.

Hello Johannes,

Any reason mtk7915 was skipped in this patch?

I'll test duplicating what was done for 7996, but wanted to make
sure I'm not missing bigger problems.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


