Return-Path: <linux-wireless+bounces-23800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720BBACFDF4
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 10:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5FA175332
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BEB27A915;
	Fri,  6 Jun 2025 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="CrxYVxra"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334E24EF6B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749197351; cv=none; b=I2tzY2fd9tnF7pmAiHprhdI7onri/vRII5ro1UKwTCFBreOX1NVm7jvNSazHHRNqQBhxmdbQY57s6oV9rj8sUfMUqVpkzNXiv1HNqFHh8+CjLNWrg01/CRoAtm8HR1ACZ0qRdbDuE8ljRi9lhyg+05IxFjyXTYDDaNgauuhnPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749197351; c=relaxed/simple;
	bh=K7R/Wqfq7XQj0i4H8oZwlD67b4eQiLOe5ig4Pvyn+ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KcepNraucmGvNSxQS6wM2bL0uZmpgE+FeRUU7uV+BhowO8Nqvq+Ogw7/7emHCpUJVsBThx721Hbo21Sh6uoM4bY130TAKYkUOu2BM15dGZJuZblufUCoRWtA7++I60nypHX+A4PtuSnyA3iQc68h3zF9E/RC+LSdpfNVsVbrnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=CrxYVxra; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1749197349; x=1780733349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K7R/Wqfq7XQj0i4H8oZwlD67b4eQiLOe5ig4Pvyn+ng=;
  b=CrxYVxrapWoQzSC2UGyM0aVequkG9IPCl2K2ev3Tioir5CHS01636U1h
   dFyF8GTV0sZbF1VX88/QdE8t9DzL+M23ZB3S2tyaDI25OvUI5tPdgu4gt
   kuPWjSic/aLwQUdVc/dXuY5SrLRUALA3lATYY+KwAdwt87o8vrziW4nYO
   s=;
X-CSE-ConnectionGUID: aMX4KNG6SZ2mvndOz8fknw==
X-CSE-MsgGUID: AxtbjXdRRe+EnjrPluhBFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="53836411"
X-IronPort-AV: E=Sophos;i="6.16,214,1744063200"; 
   d="scan'208";a="53836411"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:09:01 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 6 Jun
 2025 10:09:00 +0200
Received: from [10.234.36.169] (10.161.6.196) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 10:08:58 +0200
Message-ID: <5ea555b2-d952-42dd-baad-11acafad5697@infineon.com>
Date: Fri, 6 Jun 2025 16:08:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/4] wifi: brcmfmac: don't allow arp/nd
 offload to be enabled if ap mode exists
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>
References: <20250604091629.3943-1-ian.lin@infineon.com>
 <20250604091629.3943-2-ian.lin@infineon.com>
 <1122ef86-c43b-4d39-aebb-e69a1150f61b@broadcom.com>
Content-Language: en-US
From: "Lin Ian (CSS ICW ENG WFS SW WFSW 1)" <ian.lin@infineon.com>
In-Reply-To: <1122ef86-c43b-4d39-aebb-e69a1150f61b@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MUCSE806.infineon.com (172.23.29.32) To
 MUCSE835.infineon.com (172.23.7.107)


On 6/4/2025 6:01 PM, Arend van Spriel wrote:
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
>> Add a check to determine whether arp/nd offload enabling
>> request is allowed. If there is any interface acts as ap
>> mode and is operating, reject the request of arp offload
>> enabling from cfg80211.
>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 ++++++++++++++++-
>>   .../broadcom/brcm80211/brcmfmac/cfg80211.h      |  1 +
>>   .../wireless/broadcom/brcm80211/brcmfmac/core.c |  5 +++++
>>   3 files changed, 22 insertions(+), 1 deletion(-)

Across the patch set, the 3 can be regarded as abandoned
  - [PATCH wireless-next 4/4] wifi: brcmfmac: prevent disable controller 
in apmode stop --> plan to submit new patch set
  - [PATCH wireless-next 3/4] wifi: brcmfmac: Improve the delay during 
scan --> plan to submit new patch set
  - [PATCH wireless-next 2/4] wifi: brcmfmac: revise SoftAP channel 
setting --> abandon

May I ask if this one is regarded as ack to merge?
  - [PATCH wireless-next 1/4] wifi: brcmfmac: don't allow arp/nd offload 
to be enabled if ap mode exists

Regards,
Ian


