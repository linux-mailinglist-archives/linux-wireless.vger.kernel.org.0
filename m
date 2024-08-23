Return-Path: <linux-wireless+bounces-11870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425B95D554
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 20:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0095B2836A4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FEC757F3;
	Fri, 23 Aug 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="fMGiXcL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73285695
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437989; cv=none; b=Quld5vEZw+BBPcJjDXVILbfOxERtZ7dVLMJixK0I7Y0m89ikHZDCL5TqkNtVD0tbJcBUNL0tgrq7rDus9FHs3mWmOsk8f03u9jV5jbWLRoUyp21WkuNq5CqCahbnn9GpW6ZYhEU31HcB+DExcATJz//DKCdEInMLGOD49nlkgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437989; c=relaxed/simple;
	bh=GVDKpqz9asXtAb16ZdRjB0m7w3T0Vt4WmQ+rQcM9BIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RqTEL2p6TLMpDOPwrMX/rTpyPLWvPxGD/nLRgml8ZcDIS51r3tAgkEy2eB83m+7AlKbpS4d6QXOeRdw6HENcyi7Q3lbj3HrdSA0DZTRVvbC3wd1Tc4QjHh/TfZ2li674ZLJBvFiPQFBF4icCEdd6bMxnrZ+/63VDI9/8n0aSPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=fMGiXcL/; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D8BEF700065;
	Fri, 23 Aug 2024 18:32:58 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3FD6513C2B0;
	Fri, 23 Aug 2024 11:32:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3FD6513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724437978;
	bh=GVDKpqz9asXtAb16ZdRjB0m7w3T0Vt4WmQ+rQcM9BIg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fMGiXcL/sSzVlFl4CoILtaWGr4g3pq2vBzAU6mQBh2j98QD+WZdMA6RV7VhhZMmhZ
	 4AhERwlSgI9qIsN406rrHRNIeeWO68YetGTwrNvqI+1Uhdo9jT0MoqrPKLSn1oHNdm
	 rcNLGMVoEhwVr/5dHHvSRIWj0vl5CytF8sd9SEh8=
Message-ID: <5d8f8702-4804-6fd0-76bf-6d5d0fa5d312@candelatech.com>
Date: Fri, 23 Aug 2024 11:32:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 15/16] wifi: mt76: mt7915: reset the device after MCU
 timeout
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20240816173529.17873-1-nbd@nbd.name>
 <20240816173529.17873-15-nbd@nbd.name>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240816173529.17873-15-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1724437979-AKJrNU22K5AI
X-MDID-O:
 us5;ut7;1724437979;AKJrNU22K5AI;<greearb@candelatech.com>;340f598122f25443170ac9d27e6a82df

On 8/16/24 10:35, Felix Fietkau wrote:
> On MT7915, MCU hangs do not trigger watchdog interrupts, so they can only
> be detected through MCU message timeouts. Ensure that the hardware gets
> restarted when that happens in order to prevent a permanent stuck state.

We applied this to our hacked upon 6.10 kernel, and this patch appears
to cause NPE down in debugfs file removal during radio restart.  We didn't investigate this
closely, but removing this patch fixes the problem.

Also of note, we see the radio have a timeout, but then recover, often
(without this patch).

Did you force/fake this situation to happen and see it actually work?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



