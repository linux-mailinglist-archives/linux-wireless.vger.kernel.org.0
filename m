Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4645D734
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 10:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353956AbhKYJe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 04:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353692AbhKYJc7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 04:32:59 -0500
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65829C061574
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 01:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1637832588; x=1669368588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NmqZsR3oy+T12zFLj/zilhgw7pxvv+BFhIed/PLZDbw=;
  b=ixYsgK0ojx+RnigYfHP4V7hR4QEY0u0EfQ2WWUsId/khIcJiXVuRnCgt
   2CNjLJkP31iwyIA2cuLi8n+fm+gVVrKtqWacD/Xxl5dNDzpAyFlV/eiAg
   kmJrgmfZZVjsPrOFg7pyzj0zfjRckhH+Gmf5To9eKtFdoI2xq9beLn1/7
   0=;
IronPort-SDR: FXcWiabuUypQOIClNs0WpEE/T35ChMW+yUg474Tm0X8TB5EwA1CpfmCGV7B1zVHOHCHuDd2vzV
 ZE1XKA7eTdDfXqxGg3SY33RX2rxRJcc1J70kBfmYtML3qSofpyXi+Uza1DTkyXDBNMq7sgr8fg
 mZYWH7ZhW7okVepZbYLJmAB6cwQibMk4kDqZSg4tef312A9MUvGT9qjD/0GXBq8cyTPCLPexAS
 6nOa9FYpTfEAa/8G13fvW1cjxBZiG6eIPqp4F2jM9usAwtogQl5DmbBq3F1bwJCaU6Y3/XIGIK
 ouA=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="100016138"
X-IronPort-AV: E=Sophos;i="5.87,262,1631570400"; 
   d="scan'208";a="100016138"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 10:29:32 +0100
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Thu, 25 Nov 2021 10:29:32 +0100 (CET)
Received: from MUCSE704.infineon.com (172.23.7.78) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.15; Thu, 25 Nov
 2021 10:29:32 +0100
Received: from [10.234.36.221] (10.234.36.221) by MUCSE704.infineon.com
 (172.23.7.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2176.14; Thu, 25
 Nov 2021 10:29:29 +0100
Message-ID: <ca0b63d7-b50b-748e-1a3f-e07464eb3949@infineon.com>
Date:   Thu, 25 Nov 2021 17:29:27 +0800
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
From:   "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin-ee@infineon.com>
In-Reply-To: <d7d7c3dc-d8bb-e9ab-8357-f8c921fcdd75@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.234.36.221]
X-ClientProxiedBy: MUCSE718.infineon.com (172.23.7.101) To
 MUCSE704.infineon.com (172.23.7.78)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/23/2021 8:32 PM, Arend van Spriel wrote:
> On November 23, 2021 7:24:32 AM "Lin Ian (CSSITB CSS ICW SW WFS / EE)" 
> <ian.lin-ee@infineon.com> wrote:
>
>> From: Soontak Lee <soontak.lee@cypress.com>
>>
>> CYW43570 is a 3-antenna, 2x2 MIMO,802.11a/b/g/n/ac, PCIe 3.0 for WLAN.
>> It is BT/WIFI combo.
>>
>> Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>
> Missing signoff
>
>> Jira:SWLINUX-1213
>
> Meaningless to the public so remove it when submitting to the community.
I will send a new patch mail that modified the commit message, thank you.

>> ---
>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 1 +
>>  drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> index 8b149996fc00..ceeb1f10752a 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> @@ -2106,6 +2106,7 @@ static const struct pci_device_id
>> brcmf_pcie_devid_table[] = {
>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID),
>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID),
>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID),
>> +    BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_RAW_DEVICE_ID),
>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4358_DEVICE_ID),
>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_4359_DEVICE_ID),
>>      BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_DEVICE_ID),
>> diff --git
>> a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> index 9d81320164ce..3bbe2388ec54 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
>> @@ -71,6 +71,7 @@
>>  #define BRCM_PCIE_4356_DEVICE_ID    0x43ec
>>  #define BRCM_PCIE_43567_DEVICE_ID    0x43d3
>>  #define BRCM_PCIE_43570_DEVICE_ID    0x43d9
>> +#define BRCM_PCIE_43570_RAW_DEVICE_ID    0xaa31
>
> It is just a name, but what does RAW mean here? Also 0xaa31 is 43569 
> in decimal. Is this really a valid device ID or is this an 
> unprogrammed device (without valid devid in OTP).
It's a unprogrammed device, basically 0xaa31 is the id with blank OTP.

