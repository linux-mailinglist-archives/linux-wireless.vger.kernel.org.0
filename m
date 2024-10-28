Return-Path: <linux-wireless+bounces-14615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 802659B3671
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27A4B26834
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C11DE896;
	Mon, 28 Oct 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k9rdmnsQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5A18B48C;
	Mon, 28 Oct 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132826; cv=none; b=YOFtVFgLrGAvk13dQRkbpo66kXl7y8hnPNmO/80NEaIzF2WniEYE/lp2W/3KCHkboyzrRNIGMYOw+MLjpJK1me4RaED6c9XhgAuu8AN21xRbiDzoWLVWlaR3yksLAH4j96rYII6/FaoUWvaFLg1KnCu1Pi4AwAqJDlSCucsC0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132826; c=relaxed/simple;
	bh=qReZpycw9EEg3x9B00NH9Cf0otAKN/LgaoaGyoMOg1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lkjya48sqlE2g0arGD3k+8+kxrjISPh95lg9ub/wrEHU3H/1ZtHQ92IKk6/qqheL4iYYfnRQz5GqBwmgDOKNEVQmiRpFlTh1GSDnoPsbeRAPX0K/cqvYH7qNX4C2aAqVLGOd3uo1MfFxEDWz1vKZRC0Yy8tciUs8Spg7ZRhBl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k9rdmnsQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SGQtO5048725;
	Mon, 28 Oct 2024 11:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730132815;
	bh=jm8nliQ9ZSkhaHEqD8mj6U5Gqh4xXJKU1bvnESYYMic=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=k9rdmnsQ+q+KzBEe8t8WZfc7evxhT2486xYSVk1OmgM6DH5HgATHvyf/Q7Vcsd3EC
	 BxUUplzOz4viktU0QM9cxevM3YzKyTOf263MN5ytUwrzjPT34lLVhoGd2hHXPo7G4O
	 HvU8ZyLyEZ0YwNk3fwzv8jV1EkwnIXi6fBFxuYVs=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49SGQtZV101413
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 11:26:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 11:26:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 11:26:54 -0500
Received: from [137.167.6.238] (lt5cg1094w5k.dhcp.ti.com [137.167.6.238])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SGQps4016257;
	Mon, 28 Oct 2024 11:26:52 -0500
Message-ID: <33f3b6a4-f907-4374-90ac-d81a81700936@ti.com>
Date: Mon, 28 Oct 2024 18:26:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] wifi: cc33xx: Add scan.c, scan.h
To: Simon Horman <horms@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sabeeh Khan
	<sabeeh-khan@ti.com>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
 <20240806170018.638585-13-michael.nemanov@ti.com>
 <20240809160355.GD1951@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <20240809160355.GD1951@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/9/2024 7:03 PM, Simon Horman wrote:
> On Tue, Aug 06, 2024 at 08:00:13PM +0300, Michael Nemanov wrote:
> 
> ...
> 
>> diff --git a/drivers/net/wireless/ti/cc33xx/scan.h b/drivers/net/wireless/ti/cc33xx/scan.h
> 
> ...
> 
>> +/**
>> + * struct cc33xx_cmd_ssid_list - scan SSID list description
>> + *
>> + * @role_id:            roleID
>> + *
>> + * @num_of_ssids:       Number of SSID in the list. MAX 16 entries
> 
> @num_of_ssids -> @n_ssids
> 
>> + *
>> + * @ssid_list:          SSIDs to scan for (active scan only)
> 
> @ssid_list -> @ssids
 >

Thanks for the feedback, will fix.

> Please document all non-private fields,
> and annotate those that are private.
> 

Not sure I follow. You mean mark private vs. non private members in the 
documentation? If so, private to what (the CC33xx driver or the 
underlying HW)?

> There are a number of similar minor Kernel doc problems with this patch.
> Please consider using W=1 builds or ./scripts/kernel-doc -none
> (bonus points for -Wall)
> 

Ran both, got warning for "no structured comments found" on multiple 
files. Is that it?

Thanks and regards,
Michael.






