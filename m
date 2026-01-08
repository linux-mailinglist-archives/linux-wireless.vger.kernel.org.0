Return-Path: <linux-wireless+bounces-30576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3124AD043BD
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DA4F3014E8A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178101684B4;
	Thu,  8 Jan 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QuGZqFvY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2008500959;
	Thu,  8 Jan 2026 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888183; cv=none; b=Nc9szDX+1mj9B3uGiYrnw24FvnVhg/syltHXmDBCXKR9ErRpA2K1f+NBOXx2ZTQmSwpKAz0VmRfc2c4fgnz74pPrzgho6725fOu0ovCJmkITVyov5+Wcg3drRNWXo5HsoEsdJDysi5XqWnhil0JR0gBsdDDM6dcAvxLj2IYCj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888183; c=relaxed/simple;
	bh=VVa10yDP3+sz5jV1kNGi/Xl3ROqentBFcU3hNw2zCsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUzjrmdNSs4Ef+6sQ6ke0jzzvA6Vdjt/Q5FnJHsOUOd7lEbn9AaTjj+/8VsyS7tclfKlsoziOvLce+Knl0clEzDeZhp+cwyrzsldF+L1/uJLfG4hCV74YCQS+Kh40bzJvaMGhjkAYXmjDEecfwQg55SVm4itKQmSjUEAz95IiF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QuGZqFvY; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 85DF324009A;
	Thu,  8 Jan 2026 16:02:52 +0000 (UTC)
Received: from [192.168.101.118] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id F03B713C2B0;
	Thu,  8 Jan 2026 08:02:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F03B713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1767888170;
	bh=VVa10yDP3+sz5jV1kNGi/Xl3ROqentBFcU3hNw2zCsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QuGZqFvY9IjJeqJot0/vmtn4Iol44bf/+smnpMElqzjUZe5I2fj517l+BIFAU5HrC
	 05cXepY0hQsDk+8NcftvQByDizncs1x2o1m1dq+xIRL2iAcBYhvujCVw5we4ODx4C6
	 AMUzgZd5PFa7U5r3Y8a5GpCqqt6eJmN/SB58rmrg=
Message-ID: <2cc64750-e740-4d4f-9e23-c0c0e148ca8c@candelatech.com>
Date: Thu, 8 Jan 2026 08:02:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG 6.18.2] Null Pointer Exception in Fair Scheduler
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, sashal@kernel.org, jjohnson@kernel.org
References: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
 <e5cba37b-2bb5-46fb-b414-5cc6b2e894cf@candelatech.com>
 <2026010836-pony-driveway-65ab@gregkh>
Content-Language: en-US
From: "Dylan E." <dylan.eskew@candelatech.com>
In-Reply-To: <2026010836-pony-driveway-65ab@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1767888173-lD3EvAV8N4D3
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1767888173;lD3EvAV8N4D3;<dylan.eskew@candelatech.com>;6d78aa1bc4c2468e9f5ce884163e871b
X-PPE-TRUSTED: V=1;DIR=OUT;

Hi Greg,

 > I don't think the fix landed in 6.18.3, can you try 6.18.4? At least 
with cursory effort, I can't reproduce with 6.18.4 (or with the 
previously suggested patch applied to 6.18.3). Will update if I do see 
anything though. Thanks! -- Dylan


