Return-Path: <linux-wireless+bounces-23796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D4DACFD9E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 09:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847F4189880E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413025F98C;
	Fri,  6 Jun 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="IjRi0i1m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B956E7FD
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195689; cv=none; b=UBM6ZcDXbBE9dDuPBq+pq1oFdmlJBzmlBljQd7PAoDNIxy0Bh1gPPgRUgvaANz3GSegECq72gF14BdoozQCGw0eS1veHaAZEcoROACwk/nPrQCegWYihb/+xG3JpM24yZBOUls0mNVKt4oGVktpQ5hTQjuEiFT7Nn+Rjl7/x0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195689; c=relaxed/simple;
	bh=Tl8unUclP/TwV/43wO20oqS3Oa3GYTY5ZBrBU8p/eC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VG2qoYP3/J1SJoXeKnf/Buj8a5AFaYKyaun+7dnqFfM/1i2/omZfWTYgATlSqOk9ovZpTbZQF8dhSvOuOGx1z3DHQNNcFFKTJJwhscFckeUFHzbwLebE46aLmrkOLZkw0E/BBknL91jQS86gBq+voNmvdYYaoUsSZci5p8oSD3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=IjRi0i1m; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1749195688; x=1780731688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tl8unUclP/TwV/43wO20oqS3Oa3GYTY5ZBrBU8p/eC0=;
  b=IjRi0i1mpMvPZhTkVkFDzrpxCT1Yr2yv7VbrAMt7VzPnJOaeIY2XfJJa
   8Ej/lRom+U64ZdGxlNMzSwrnzNYJln8zp0VLONA46/e4onoqKfOA0ikjX
   9owAXeOPO6fUcmLscWZuBQCz9ht2KQ8SwRGpOEm1/1bN1T2wy9yr7b5ZW
   I=;
X-CSE-ConnectionGUID: Z5lSI9CqQgqWG+LtXEuH3g==
X-CSE-MsgGUID: l0mlQQ+aS3y0md31pNdUUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="87501200"
X-IronPort-AV: E=Sophos;i="6.16,214,1744063200"; 
   d="scan'208";a="87501200"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 09:41:13 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 6 Jun
 2025 09:41:12 +0200
Received: from [10.234.36.169] (10.161.6.196) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 09:41:10 +0200
Message-ID: <81d02ac4-d1d8-4368-889c-60758b8ce59c@infineon.com>
Date: Fri, 6 Jun 2025 15:41:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 4/4] wifi: brcmfmac: prevent disable
 controller in apmode stop
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>
References: <20250604091629.3943-1-ian.lin@infineon.com>
 <20250604091629.3943-5-ian.lin@infineon.com>
 <1b15a15d-d02c-42af-a628-a8543ffdf528@broadcom.com>
Content-Language: en-US
From: "Lin Ian (CSS ICW ENG WFS SW WFSW 1)" <ian.lin@infineon.com>
In-Reply-To: <1b15a15d-d02c-42af-a628-a8543ffdf528@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MUCSE806.infineon.com (172.23.29.32) To
 MUCSE835.infineon.com (172.23.7.107)


On 6/4/2025 6:25 PM, Arend van Spriel wrote:
> Caution: This e-mail originated outside Infineon Technologies. Please 
> be cautious when sharing information or opening attachments especially 
> from unknown senders. Refer to our intranet 
> guide<https://intranet-content.infineon.com/explore/aboutinfineon/rules/informationsecurity/ug/SocialEngineering/Pages/SocialEngineeringElements_en.aspx> 
> to help you identify Phishing email.
>
>
>
> On 6/4/2025 11:16 AM, Ian Lin wrote:
>> From: Ian Lin <ian.lin-ee@infineon.com>
>>
>> Wpa_supplicant will firstly call scan before start apmode.
>> In mbss case, controller will be disabled during stop apmode
>> so next time it reports fail in starting apmpde.
>> Fix by removing the disable operation.
>
> The function brcmf_cfg80211_stop_ap() is a bit tricky. The flag
> ifp->vif->mbss is set to true only when there are multiple AP interface
> and only for subsequent AP interface. For the first AP interface being
> created the flag is false.
>
> Now looking at the function I suspect there is an assumption that each
> AP interface will be stopped. So for a subsequent AP interfaces is will
> do a BRCMF_C_DOWN and for the first interface it will do other stuff
> below the if statement follwed by BRCMF_C_UP.
>
> Clearly you are solving another scenario here so could you elaborate on
> that?
>
The patch is applied to solve problem in multiple AP scenario.
But I found it may be better to include other patches together for the 
scenario.
Let me collect the information and submit another new patch series.

> Regards,
> Arend
>
>> Signed-off-by: Ian Lin <ian.lin-ee@infineon.com>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git 
>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index e23cd6fc0f56..b4078e74f135 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -5392,11 +5392,6 @@ static int brcmf_cfg80211_stop_ap(struct wiphy 
>> *wiphy, struct net_device *ndev,
>>                       profile->use_fwauth = 
>> BIT(BRCMF_PROFILE_FWAUTH_NONE);
>>               }
>>
>> -             if (ifp->vif->mbss) {
>> -                     err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_DOWN, 1);
>> -                     return err;
>> -             }
>> -
>>               /* First BSS doesn't get a full reset */
>>               if (ifp->bsscfgidx == 0)
>>                       brcmf_fil_iovar_int_set(ifp, "closednet", 0);
>
Regards,
Ian



