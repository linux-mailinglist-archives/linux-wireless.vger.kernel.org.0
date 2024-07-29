Return-Path: <linux-wireless+bounces-10638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D624193FC7A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9183D28248C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C681204;
	Mon, 29 Jul 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jdYUeCVJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2C5028C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274315; cv=none; b=G4n/XI9Op2TgFE9eLjxG3MLm3n5FBbeQ8KHuba9FFrQ3bExhbYG1T6wS0Y8jznT22LDY3TB6i7FzTa9TnRhpTBYEQ2axXoq/kXN5XDZ/vU+K1ybXmr7RQeKZ5QhTX9CUSp2Dt47b2G9jfS3ZivhxJYR7XP7eausIrcGFeaug0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274315; c=relaxed/simple;
	bh=4kagxN/QA1mE29wM0zSskACI7b/JDPoAltX6MngHAkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mno9uGcPmk2sF5sEWj5Ckk50Uqpxoy9i8wQOxfGjw8HsZNvRZ1Bjynlf3fF75lwJsBY9Bwn+iZcp1Or56Hkz9X02GxBfr4QrFwW04Ad2fjjh6soYvMCKHvebyrno9Ef/IaKd+TOREAhfGnQoE0UtzsfIP8X8DXWJfn2YVmlJlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jdYUeCVJ; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 26B3E30352A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:31:52 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0CE3C8C0090;
	Mon, 29 Jul 2024 17:31:43 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5350513C2B0;
	Mon, 29 Jul 2024 10:31:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5350513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1722274303;
	bh=4kagxN/QA1mE29wM0zSskACI7b/JDPoAltX6MngHAkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jdYUeCVJ+/vYGDc9lYyXBvHjbhDgJIJEkOEiV9rEfm/CxdY/d9x0rU0mfMAZXNLt7
	 H+RV6uCxFFFCh4YGSuLCduiJDU3p1qOcCf/f6sssNbM6m/HqPlR0DMQ/Z+ORWt2nhW
	 O8BeDkqdg66nvwJZ947J6wBC6fFT++esX9oLo0a8=
Message-ID: <eb5c63dc-8934-50fe-3b08-24db25c80bb3@candelatech.com>
Date: Mon, 29 Jul 2024 10:31:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/17] wifi: iwlwifi: mvm: set ul_mu_data_disable when
 needed
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
 <20240729201718.fef270d2995b.I328237837df30e1cb98764987eaaf8e8993e058c@changeid>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240729201718.fef270d2995b.I328237837df30e1cb98764987eaaf8e8993e058c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1722274305-ISB5-UUnAegG
X-MDID-O:
 us5;at1;1722274305;ISB5-UUnAegG;<greearb@candelatech.com>;75a4f4635234d3da72e9a6f449db0bf8

On 7/29/24 10:20, Miri Korenblit wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> The firmware needs to know what we had in the HE CAP, propagate that
> setting to the firmware through the LINK command.

Hello Emmanuel,

Does this happen to fix a firmware crash?  I hit a FW crash when doing
be200 upload test to an mtk7996 testbed AP, and possibly it would
trigger this...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



