Return-Path: <linux-wireless+bounces-14109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A49A15AF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 00:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EAAB24943
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 22:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8110C1D3573;
	Wed, 16 Oct 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FHaAHRL3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5471D356E
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116662; cv=none; b=hkInBZaznOKCPVcwfHFk1yNTrnFGOemxRWdL1XqI/k/SbeuD0ANgypvgVvObg2iq2VKt7oNKZSjLfrOnLi14S/4b3L8GpSvwM5ARjlIa+UVkRkgfldE6QfhB9OaOXHqHoou/AqYaSboiPbqwN8EK4Rvpq9qjg544rXUbk14qe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116662; c=relaxed/simple;
	bh=LOLVIRp1+lxhHJfPTspYiH0WrKuj143j3MUfYY6Ji1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Erw0VZEfuEoF6PvqcWPSrR6eezaN2lWlUcg1Ut5ywc1oMXpLH5FvlQn93itnkZqfKwuayjCHi+kbvxID+N5GWz38daC0hHnr3Ras8G9AV2yY7Fqh5B8dgY4gDu7EXKRyPEHnAO7Ow9h0uqaIh0ZRnnjZMFLo+1TeaC3PHttbH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FHaAHRL3; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AA526340011;
	Wed, 16 Oct 2024 22:10:52 +0000 (UTC)
Received: from [192.168.101.245] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D9E4B13C2B0;
	Wed, 16 Oct 2024 15:10:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D9E4B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1729116651;
	bh=LOLVIRp1+lxhHJfPTspYiH0WrKuj143j3MUfYY6Ji1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FHaAHRL3Hmi1ZGqi4X0GEXGAYINjxDz1q97Mccubl39/w5dPdCQWnnzgyGA3mdenH
	 sgEGbbUV0O9iwHc+CXbud8yJvFo8i7wYkJMqZqBxFf4SLK5Nj0EfMtMeWWKYOT7DG/
	 MtdpFzgYNx88td6iePNoDWIFgyMsTx7F+sEDAnIQ=
Message-ID: <f2f00f4e-0a57-4a2a-933e-4497353f857c@candelatech.com>
Date: Wed, 16 Oct 2024 15:10:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] wifi: iwlwifi: mvm: handle TPE advertised by AP
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, johannes@sipsolutions.net
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
 <20240527190228.32f1e2e1447c.I58ac91c38585362aa42bb4a8a59c7d88e67bc40b@changeid>
 <ea1eeb13-c568-4381-812a-dec4246a440e@candelatech.com>
 <57d28bcf-8f2b-4755-bf2a-7c9d316e6823@leemhuis.info>
Content-Language: en-US
From: Rory Little <rory@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <57d28bcf-8f2b-4755-bf2a-7c9d316e6823@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1729116653-C2LRLwij_tBL
X-MDID-O:
 us5;ut7;1729116653;C2LRLwij_tBL;<rory@candelatech.com>;9afb24c90898fa38a1d775b75cf58c9a
X-PPE-TRUSTED: V=1;DIR=OUT;

On 9/2/24 05:59, Linux regression tracking (Thorsten Leemhuis) wrote:
> Rory Little: was this ever resolved? I noticed the patch you send to
> which Johannes replied to stating a similar fix is already in -rc1. But
> you reported this a few days after -rc1 was out, which makes me wonder
> if this really is resolved.

It was resolved. We independently pulled in this patch series without 
the earlier fix, which caused an issue only in our forked kernel, and 
the confusion on our end. My mistake for reporting the issue here.

- Rory

