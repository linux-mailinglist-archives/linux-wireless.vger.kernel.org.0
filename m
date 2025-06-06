Return-Path: <linux-wireless+bounces-23799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F2ACFDB7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29ED3A83A3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA52356B8;
	Fri,  6 Jun 2025 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="iNNB/Is1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357DCA2D
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749196170; cv=none; b=DWwnNjpIt/j4h7kYm6u7fUnvPDi3V0A1sW2flwC128sqJUpQMyBrMw17wIfuDlmw7P7IPm323e4mZWxAKacVtj+i7DD3E57i90qslQfSPuNARsRBiVJ7uwqms4tH8f4oP9CjLsOShP6Ll/N6bCq+PYrY2363KYGxl2Li8rfP5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749196170; c=relaxed/simple;
	bh=25GM4Igwkarxsm3y2+2MucOthqoF2cPISskLIrJ4qao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RSRtyk1V0JUX/k52BtC6guRlfalSYwY7kp2A63Paa/n/QZYT2y6NQx/bmrXg4HA62m7o7+WGX44s1R0Gs7PSkavSwSsI+AItfunFpbqnEFy7fbtqQtsh/iVXIuTJqw4/lNhuLHOjzDZXPLLEn9pOOAK4UPK/YVP+81DtVyQkcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=iNNB/Is1; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1749196168; x=1780732168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=25GM4Igwkarxsm3y2+2MucOthqoF2cPISskLIrJ4qao=;
  b=iNNB/Is1dFFYG5cUWdePaaov4DJTCHU+jd35XkrWQVGtPzoihtimbHlv
   44WNA6MZzcrfUhV7VM9rN84zJ5vnjDFXN5GNLKR02SENZF0cg3b/q+QJF
   tbJmHFyIsDqLWTslr3m+y7m5ynbKQdIiOcDbjIIjnzXdwJ5SU4Y8/Y0U4
   M=;
X-CSE-ConnectionGUID: 5PH/3FfJQlqX8IhnZ8oKWw==
X-CSE-MsgGUID: 0ejMI3GlSQC/hodC9iz8qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="87502207"
X-IronPort-AV: E=Sophos;i="6.16,214,1744063200"; 
   d="scan'208";a="87502207"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 09:49:26 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 09:49:26 +0200
Received: from [10.234.36.169] (10.161.6.196) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 09:49:23 +0200
Message-ID: <6b140807-ba0f-41b1-a6a0-a3f72c636159@infineon.com>
Date: Fri, 6 Jun 2025 15:49:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 3/4] wifi: brcmfmac: Improve the delay
 during scan
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>
References: <20250604091629.3943-1-ian.lin@infineon.com>
 <20250604091629.3943-4-ian.lin@infineon.com>
 <b6d38c35-e410-4ea6-94e0-b9f091976953@broadcom.com>
Content-Language: en-US
From: "Lin Ian (CSS ICW ENG WFS SW WFSW 1)" <ian.lin@infineon.com>
In-Reply-To: <b6d38c35-e410-4ea6-94e0-b9f091976953@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE835.infineon.com (172.23.7.107)


On 6/4/2025 5:54 PM, Arend van Spriel wrote:
> Caution: This e-mail originated outside Infineon Technologies. Please 
> be cautious when sharing information or opening attachments especially 
> from unknown senders. Refer to our intranet 
> guide<https://intranet-content.infineon.com/explore/aboutinfineon/rules/informationsecurity/ug/SocialEngineering/Pages/SocialEngineeringElements_en.aspx> 
> to help you identify Phishing email.
>
>
>
> On 6/4/2025 11:16 AM, Ian Lin wrote:
>> From: Kurt Lee <kurt.lee@cypress.com>
>>
>> wpa_supplicant sends NL80211_CMD_GET_SURVEY command every time after
>> normal scan, which causes brcmfmac surveying each channel again.
>> Currently brcmfmac implments brcmf_cfg80211_dump_survey focusing on AP
>> mode, thus this change will return the request other than AP mode.
>
> I am not sure if the driver should make this kind of decision. If
> wpa_supplicant wants to invoke a survey after a scan than we should
> simply comply and give what wpa_supplicant what it requests for. If you
> want to avoid the survey make it a configuration option in
> wpa_supplicant.conf.
>
Got it, ya it's much reasonable to make decision in wpa_supplicant.
We'll check what to do next.
Please abandon the change for now, thank you.

> Regards,
> Arend
>
>> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
>>   1 file changed, 3 insertions(+
Regards,
Ian

