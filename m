Return-Path: <linux-wireless+bounces-10311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E76934195
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 19:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEB51C214B3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125031822D8;
	Wed, 17 Jul 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="BAJwYaO8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD7469D;
	Wed, 17 Jul 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238253; cv=none; b=uhB+bIMt3HQFGWMrrHpL3dmKdcZ516BrcZqUfuSqkgi14sJ78YYfIlzKFGyl30gZzEdf3Tj35A7rTggatgHtCrkSaEWdS1lF4m2y7GtIi7dhfLc/Wu+JWHAbewnUUknI+zydzrbyifnLWZ/HJ4F/CV8GoHZQ6N1AsLCoDEU5tuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238253; c=relaxed/simple;
	bh=mxCslIPQ4pBRmAUslsNEMWM9B+45EdqosSyr1tui4ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBdWwDfnO3P4JX47THIt+3tLrcBXJapmr7lb8yls4l2kLGmYfT0h+8katKILS6ZWApLdo6lyPI21X9v0nVtiQDyl11tlvayUPzu5XsdT8nsUwBkLN7nf880o2Jq7l3btKlU3/aro+0lU8XNyK7qnyk+Gh7/5bVfZwDRLZbe0v9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=BAJwYaO8; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DE03F2C497E;
	Wed, 17 Jul 2024 17:44:08 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D16C8AC0083;
	Wed, 17 Jul 2024 17:43:59 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 130AA13C2B0;
	Wed, 17 Jul 2024 10:43:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 130AA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1721238239;
	bh=mxCslIPQ4pBRmAUslsNEMWM9B+45EdqosSyr1tui4ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BAJwYaO84eiNShYU6d6l/12Db/WJ/FPDK5cl+9O2JazeNbNykamYjuh88+Vg3UzQC
	 a8p9W/fFkQbhEJoaV3urzNkQsrw6DK85urjZ3gJp5dKicmzGOwBEAeI78EYxJBlKpm
	 YRrRuvAEnQFhY2+ark33sOtNORYfSOULRVWJNUD4=
Message-ID: <852afe85-8f06-d48c-c8e9-485a2ea2dd5c@candelatech.com>
Date: Wed, 17 Jul 2024 10:43:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] thermal: core: Allow thermal zones to tell the core to
 ignore them
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 Eric Biggers <ebiggers@kernel.org>, Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <12488450.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <12488450.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1721238241-866koxsj9n-m
X-MDID-O:
 us5;ut7;1721238241;866koxsj9n-m;<greearb@candelatech.com>;ecbc05c8e1648c7ed03b6bc7e6c22a70

On 7/16/24 12:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The iwlwifi wireless driver registers a thermal zone that is only needed
> when the network interface handled by it is up and it wants that thermal
> zone to be effectively ignored by the core otherwise.

This appears to work fine on my system with lots of Intel radios in it.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



