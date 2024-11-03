Return-Path: <linux-wireless+bounces-14846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C197D9BA591
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 14:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418DC1F21822
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA87170A01;
	Sun,  3 Nov 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZQ/ZSqq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931C23774;
	Sun,  3 Nov 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730639388; cv=none; b=ZjL+2fn5DMECUOF6H2S6fbNPCpOW5jBLMrvFiMfGzf2eZj1+kpIbOxjmi+zG2FkRUQvbhiGzovtab2VSUFtZ2G3GWPEYrY5YTV2pAz+vuTXBinz3UsZdPtaC4chJ44RE0T/iFF9G7Q/9EjTVr6vOCUnLmOITBombxFzCcdJdbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730639388; c=relaxed/simple;
	bh=L3pgofmdiA7tjgITv7rLbTAHmux1ivEfS0QEv3RG7tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aSC9DvwIYPjRY0xjUAm3puNGXDu0b9VXU8woJxPBBATJTRw9LnVeIPY7j4gV4CYQwsLFmmxNYyXbh6i0CxUFyc3h96kuy08A7xCgECuZcPB6coXrBgkzqnxnZk9cygyen429sEgTA91o/pFy1/KpjUfSI4J8mSpLCpCrUiAVagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZQ/ZSqq0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A3D9Ra9082650;
	Sun, 3 Nov 2024 07:09:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730639367;
	bh=tDopgh4KdYRpAzlB5JsSw+mCUcM9+OGO/0EE4Ka23cM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZQ/ZSqq0POaerMmnaiag9ze/9ac0RApfooVg52gS05roM1M0HNqvRbwxu/rvz9YtG
	 BPO+l99cu3gY8tZno4yi4/8QH0yTUHbG/+lIBo8/GfYrC17huJcqGcdIKGSeFzwaln
	 RFws86DuBNGFSZRSsNkeEL34YUlr25L0TCrIwrZQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A3D9R45029020
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 3 Nov 2024 07:09:27 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Nov 2024 07:09:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Nov 2024 07:09:26 -0600
Received: from [10.250.202.81] ([10.250.202.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A3D9N8B007694;
	Sun, 3 Nov 2024 07:09:24 -0600
Message-ID: <d9640623-4b93-4fce-991f-f881a230b143@ti.com>
Date: Sun, 3 Nov 2024 15:09:22 +0200
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
 <33f3b6a4-f907-4374-90ac-d81a81700936@ti.com>
 <20241102120030.GG1838431@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <20241102120030.GG1838431@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/2/2024 2:00 PM, Simon Horman wrote:

...

> 
> I'm a but unsure why you see that, but what I was referring to is this:
> 
> $ ./scripts/kernel-doc -none drivers/net/wireless/ti/cc33xx/scan.h
> drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_ssid_list'
> drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'scan_type' not described in 'cc33xx_cmd_ssid_list'
> drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'n_ssids' not described in 'cc33xx_cmd_ssid_list'
> drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'ssids' not described in 'cc33xx_cmd_ssid_list'
> drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_ssid_list'
> drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Excess struct member 'num_of_ssids' description in 'cc33xx_cmd_ssid_list'
> drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Excess struct member 'ssid_list' description in 'cc33xx_cmd_ssid_list'
> drivers/net/wireless/ti/cc33xx/scan.h:149: warning: bad line:
> drivers/net/wireless/ti/cc33xx/scan.h:177: warning: cannot understand function prototype: 'struct sched_scan_plan_cmd '
> drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Function parameter or struct member 'u' not described in 'scan_param'
> drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Excess struct member 'one_shot' description in 'scan_param'
> drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Excess struct member 'periodic' description in 'scan_param'
> drivers/net/wireless/ti/cc33xx/scan.h:269: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_scan_params'
> drivers/net/wireless/ti/cc33xx/scan.h:269: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_scan_params'
> drivers/net/wireless/ti/cc33xx/scan.h:295: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_set_ies'
> drivers/net/wireless/ti/cc33xx/scan.h:319: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_scan_stop'
> drivers/net/wireless/ti/cc33xx/scan.h:319: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_scan_stop'

Right, fixed in v4, thanks.

In general, all of those structs are internal to scan.c and not part of 
an interface so I think I'll move them there and drop the comments.

Regards,
Michael.

