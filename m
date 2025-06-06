Return-Path: <linux-wireless+bounces-23798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459E6ACFDA9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BF3189A4AE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F51E832E;
	Fri,  6 Jun 2025 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="iUER11EB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960593BB44
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195950; cv=none; b=YknRaFH4/8o7VqcCL+1hdAqV/GzOuNWGgX71o0NAiBxkdajr4RZqpXetO8ZT8Rw4ERmf8OEfuRY5vBk0D3g4z1WEwhpw8YJD9rE5zjTWAxuXEqq/EmTtiYzf2DPT6WmyhBMRQGJOBhNDvkNz0xZMizuxYqS5NhBegUpHSfAsfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195950; c=relaxed/simple;
	bh=UKBZi2LezTFufgZGHFETQ5oMCVa3iZWeV5a+0BcWAxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q3l1VW3ngyKpGtXO9xeOUsdhqQbehV1Zbmdd5RjbTzme7iUx54PoY/R5CC/XE9xV0rXokE8KvCWlGv0ZWiUUyOlNkjhWsXnkpmvcC028dVGN6jM+pMPTP9mansFRLF3hvkGFf3K9kilZa5XOu8qdTHhrKG5xtFpgAB1nsFlrOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=iUER11EB; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1749195949; x=1780731949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UKBZi2LezTFufgZGHFETQ5oMCVa3iZWeV5a+0BcWAxc=;
  b=iUER11EBzFBn8rVeVkRRTu6PmjMbAeAFmuoBbOR4kHk4lU3S4CKn3Nok
   iHpQBxTeq0qo5ntVDQZ5KBQ7tkFnf/BoIrMQkApA9YJ0wPh1zofrpWTAp
   d0X2rBVg6GioAV44Qe1AmlC7m7HUzCa7AgiELjTImJGuGWEs9lMyD0Ujb
   Q=;
X-CSE-ConnectionGUID: 2TSetDX8RyC80+PMTMhmDQ==
X-CSE-MsgGUID: cRjiHWM7RjygIs0AOdqchg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="87501687"
X-IronPort-AV: E=Sophos;i="6.16,214,1744063200"; 
   d="scan'208";a="87501687"
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 09:45:47 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 6 Jun
 2025 09:45:46 +0200
Received: from [10.234.36.169] (10.161.6.196) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 09:45:42 +0200
Message-ID: <0f2a6df4-0029-43f4-8b7c-0b075a09b62d@infineon.com>
Date: Fri, 6 Jun 2025 15:45:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/4] wifi: brcmfmac: revise SoftAP channel
 setting
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>
References: <20250604091629.3943-1-ian.lin@infineon.com>
 <20250604091629.3943-3-ian.lin@infineon.com>
 <c393c4cb-ac13-46c3-973f-e123f603bdd7@broadcom.com>
Content-Language: en-US
From: "Lin Ian (CSS ICW ENG WFS SW WFSW 1)" <ian.lin@infineon.com>
In-Reply-To: <c393c4cb-ac13-46c3-973f-e123f603bdd7@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MUCSE823.infineon.com (172.23.29.54) To
 MUCSE835.infineon.com (172.23.7.107)


On 6/4/2025 5:38 PM, Arend van Spriel wrote:
> Caution: This e-mail originated outside Infineon Technologies. Please 
> be cautious when sharing information or opening attachments especially 
> from unknown senders. Refer to our intranet 
> guide<https://intranet-content.infineon.com/explore/aboutinfineon/rules/informationsecurity/ug/SocialEngineering/Pages/SocialEngineeringElements_en.aspx> 
> to help you identify Phishing email.
>
>
>
> On 6/4/2025 11:16 AM, Ian Lin wrote:
>> From: Ting-Ying Li <tingying.li@cypress.com>
>>
>> Fmac need to update "chanspec" iovar for each SoftAP creation
>> because firmware will update the chanspec to current bsscfg
>> for each bss. If it doesn't update then the wrong chanspec
>> will be shown on the result of 'wl -i [interface] status'
>> command. No need to handle channel resource reusing for mbss
>> mode by the host driver, it should be covered by firmware.
>
> Sorry, but the wl utility is irrelevant to upstream driver so that does
> not count as argument for this change. What does iw show?
>
The patch is applied to solve problem in multiple AP scenario.
(the problem may be shown in hostapd/wpa_supplicant)
But I found it may be better to include other patches together for the 
scenario.
Let me collect the information and submit another new patch series.

Regards,
Ian

