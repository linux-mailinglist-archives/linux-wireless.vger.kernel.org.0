Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEEB460F7C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 08:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbhK2HpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 02:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbhK2Hm6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 02:42:58 -0500
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12792C061756
        for <linux-wireless@vger.kernel.org>; Sun, 28 Nov 2021 23:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1638171580; x=1669707580;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k4AUhcboLLiIOw8Vkl5LZaCo9iZ6vCWFAshx1kwwsMM=;
  b=dOKw3QhqVLdvvsh3H3wB+oP46pHbwtN3RVr06BAwyd19CEKMtWf75Ji2
   dXWCGC9Ai7vCcjCwsm8U4qLnQkNaKb1mWD4r33SmL/ccFXODwo4rYvull
   hc4ceaTwn2CjzxcZf/DgFBviv2ceRP7AQfhWcwd2O5J1lL5TKf9udVv4N
   U=;
IronPort-SDR: j99viM6tM9Nmwo05gj0Pol7cdCeQMKllyEAAfXy1VFsygMxQy/7Q4Yc+boZVzDRy+co5thp7PW
 xdK3RuZP73g49Dbn8pQSOBU0lhNL/Hm/rqe49AAh9vbPCIhYJJckvfdnHrUD1c2g3lLaO9o3Ye
 6wHtMIHoJ3BtxmQLKYDeeHIvEABioNyp89tin+lJABmoLUadqRtmoCn7oiVODz/7VTClIHanIa
 +5dDGVCgFwhFo6FdIraWrFhtgCNZ7P8n0zgwOyC9rg20rBEfo/VvJpFI9KJxmYZ7NNwUZKKieK
 H2c=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="100395375"
X-IronPort-AV: E=Sophos;i="5.87,272,1631570400"; 
   d="scan'208";a="100395375"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 08:39:40 +0100
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 29 Nov 2021 08:39:39 +0100 (CET)
Received: from MUCSE704.infineon.com (172.23.7.78) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.15; Mon, 29 Nov
 2021 08:39:39 +0100
Received: from [10.234.36.221] (10.234.36.221) by MUCSE704.infineon.com
 (172.23.7.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2176.14; Mon, 29
 Nov 2021 08:39:37 +0100
Message-ID: <402a2e58-3bf2-1c9d-02b6-2c256500d161@infineon.com>
Date:   Mon, 29 Nov 2021 15:39:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] brcmfmac: add CYW43570 PCIE device
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        <Chi-Hsien.Lin@infineon.com>, <Wright.Feng@infineon.com>,
        <Double.Lo@infineon.com>
References: <3f57f2b0-82c2-e339-ee6a-1569186143d6@infineon.com>
 <d7d7c3dc-d8bb-e9ab-8357-f8c921fcdd75@broadcom.com>
 <ca0b63d7-b50b-748e-1a3f-e07464eb3949@infineon.com>
 <ac096741-70d1-9ecd-00fe-9182ace525d3@broadcom.com>
From:   "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin-ee@infineon.com>
In-Reply-To: <ac096741-70d1-9ecd-00fe-9182ace525d3@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.234.36.221]
X-ClientProxiedBy: MUCSE717.infineon.com (172.23.7.74) To
 MUCSE704.infineon.com (172.23.7.78)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/25/2021 5:44 PM, Arend van Spriel wrote:
> On 11/25/2021 10:29 AM, Lin Ian (CSSITB CSS ICW SW WFS / EE) wrote:
>>
>>
>> On 11/23/2021 8:32 PM, Arend van Spriel wrote:
>>> On November 23, 2021 7:24:32 AM "Lin Ian (CSSITB CSS ICW SW WFS / 
>>> EE)" <ian.lin-ee@infineon.com> wrote:
>>>
>>>> From: Soontak Lee <soontak.lee@cypress.com>
>>>>
>>>> CYW43570 is a 3-antenna, 2x2 MIMO,802.11a/b/g/n/ac, PCIe 3.0 for WLAN.
>>>> It is BT/WIFI combo.
>>>>
>>>> Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
>>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>>>
>>> Missing signoff
>>>
>>>> Jira:SWLINUX-1213
>>>
>>> Meaningless to the public so remove it when submitting to the 
>>> community.
>> I will send a new patch mail that modified the commit message, thank 
>> you.
>
> great.
>
>>>> ---
>>>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 1 +
>>>>  drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
>>>>  2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>>> index 8b149996fc00..ceeb1f10752a 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>>>> @@ -2106,6 +2106,7 @@ static const struct pci_device_id
>>>> brcmf_pcie_devid_table[] = {
>>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID),
>>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID),
>>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID),
>>>> +    BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_RAW_DEVICE_ID),
>>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4358_DEVICE_ID),
>>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4359_DEVICE_ID),
>>>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_DEVICE_ID),
>>>> diff --git
>>>> a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>>> b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>>> index 9d81320164ce..3bbe2388ec54 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>>>> @@ -71,6 +71,7 @@
>>>>  #define BRCM_PCIE_4356_DEVICE_ID    0x43ec
>>>>  #define BRCM_PCIE_43567_DEVICE_ID    0x43d3
>>>>  #define BRCM_PCIE_43570_DEVICE_ID    0x43d9
>>>> +#define BRCM_PCIE_43570_RAW_DEVICE_ID    0xaa31
>>>
>>> It is just a name, but what does RAW mean here? Also 0xaa31 is 43569 
>>> in decimal. Is this really a valid device ID or is this an 
>>> unprogrammed device (without valid devid in OTP).
>> It's a unprogrammed device, basically 0xaa31 is the id with blank OTP.
>
> So do we expect linux end-users to come across such a device. As far 
> as I know a device with unprogrammed OTP will use the chip id as the 
> PCI devid. If this is needed to enable development with unprogrammed 
> devices I would suggest to have these under Kconfig option.
Some end-users use the driver to do MFG process, so the RAW device ID is 
supposed to be supported.
We don't expect user should modify kconfig for this, so directly add in 
driver is reasonable.


