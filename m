Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E0E1DC9FB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgEUJ1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:27:18 -0400
Received: from mail-bn8nam12on2119.outbound.protection.outlook.com ([40.107.237.119]:32097
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728686AbgEUJ1R (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:27:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf/uTkf1kpCWsAKluILImvbD9PSGuWSMNFt+3PnGoUJEDXFicGHmqlHVw2R8GMdXXce5KM6g46CN+9xvqfwWlebkEwpDfOh1vHk6mHoB9Who3cLGAlX5OB8+bq55+lVmFGhF9o/EHn733bdPC1Oi6u7a2eCEwnzlCn4IrKb3nFkuThc28bejCqFJhz9eyzjXrbzGp/fExTLg5AQCcw1HENVd8agh+wmgb7DqpnjBiF9VTUQrE9ZlOQ0hYhnQi85GQY5f/essklKBLvublh0EvBIFJ0TL2an8qXYi//u7lOe0CKQu4pvtOvL8BUBTTKYMtkNLXVYg+dXQSiu3zfN2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEAI1vrYW3cM8fnu9FnTObNDI8MoBMbD+dyg44sL3Fc=;
 b=Vk0tHhf+7N6YtOTjShBgZYh2kZArfGJFDamT65sqf9xwB8nJbX5PcxRrmc5yNalBOH3hVOf30E1qdGAW2hBa6eElNZFjrt9xQdq0VRJpFqp9etuv2Sv269VT7Y+4qby10hfbyHEhPFPtM1M75jbH8JEj/xLqNQvkovH8zFN5gCL5/FS8Uk7OP+n5YSHL0uHzssyJFXNgaVcT0XNv42F46yME09uGlVXf/6us4C8u3No8kS+VzKqIGQcFsY7L8ExzZMNmwa1ZwZLVy+19nF8WlVjGHAash/FmHV9MaK8SW/NFyo/6VrVbpKba/aca0kMYUo1/VlQkcck8PU2SI3RdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEAI1vrYW3cM8fnu9FnTObNDI8MoBMbD+dyg44sL3Fc=;
 b=WYExkmXTTlMBYMRlacwLCvpsAMRC6HsuMycoMg/yXoGPi9eQ7qjbLy8eoOOyNVwksJ8rKg4Dvsj1wCVwFkxVL+Yanvl0gqF2OXH+3KIfykD/pHzcpgypB/WivDLzkwJOtjl/52pYtQhLCNeG/fHBmBhOvcx3OXrNhI2TKCet1tA=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5894.namprd06.prod.outlook.com (2603:10b6:a03:157::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 09:27:14 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 09:27:14 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH 3/4] brcmfmac: set net carrier on via test tool for AP
 mode
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Kurt Lee <kurt.lee@cypress.com>
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
 <20200519110951.88998-4-chi-hsien.lin@cypress.com>
 <77e05853-447c-76e2-9d71-a95397c36ff0@broadcom.com>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <376eff3e-4e6f-53f6-d790-ed04bef3953d@cypress.com>
Date:   Thu, 21 May 2020 17:27:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <77e05853-447c-76e2-9d71-a95397c36ff0@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BY5PR20CA0030.namprd20.prod.outlook.com (2603:10b6:a03:1f4::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Thu, 21 May 2020 09:27:12 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7883bcae-5641-4f5a-7a33-08d7fd692584
X-MS-TrafficTypeDiagnostic: BYAPR06MB5894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5894C9AEBAB0355304C99AD4BBB70@BYAPR06MB5894.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pupQDOm3IbBF2o25O+8yj/ZTsPwiX89D0/jO3nlz+UZ6tWyCP/91oVvjpIsMHgdNfram0Fw4rhlKbzhgat74Mzmry1nXWvhK02E8ZKtuEFOSIhZJ5mVKXaGRdHD9Py/8rugXPAzBTnTQESbFzBWnyVfB0uMRiG4shSJYAeICHaAsSAoAC6fvVCb6uM29fpbp4OnFYg9af62tyGUZVSi0v9dopOHdnIyDhgq55XtY82V5p6unyLvMKi9G2itHIbEYArE417R3iOWIbg7DCeQgr8EHKvSkKREDHQfRD7NQCmPw95lwQ3A8v5E5cjpAjf58hEHx+Lodoet6DSwdjdISyFaDMLi+TN1nFfUeLBuppNrUGxILe8Y3mqm826ia9L3s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(39860400002)(346002)(366004)(110136005)(5660300002)(31686004)(31696002)(3450700001)(8676002)(16576012)(316002)(2906002)(54906003)(478600001)(8936002)(6486002)(52116002)(26005)(86362001)(53546011)(186003)(107886003)(956004)(4326008)(36756003)(16526019)(2616005)(6666004)(66476007)(66946007)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PpVcFk7SKcEWjgpU/8iHBRMLE8BJsl9WNKhijnXfLwi6bUKAtm22dYGoiAAS6fwaS2A/7BPKyFMvgQnGe/8NQQR8BdrBfG0TQLnaKB0h2zWKq8qO56X3oKGrMhS5HzQnESKyCyQ6OSelE0PIy0CgvmczHl4Yg9eI8dsLH1s5n02tyl6+IKAhLGNdoYAIaR4lm4TnMyTIDogQO3uArjI5nutfnkvOzijfQrfnNxoiffqQ/UWcFaFKyXiYW/U6dLFveEL1rZ7cKS8gs750L9gV0uL8khNDIlpRcTinEAKxoOp3ph3zkmUmnCt9Kiin1URSGYWcHaHkLo/4a5dmeTSibeeBli4zeKehsvPU0tz8vNPT2pMn1k6nH8JLW7AJKI9eMp38lEMSxDOAoRm/FqGarL0BZ6qXR1AdxiG1u+4vnvUkIqYt4JCKDf7h1HweyoBGOvHT6vs9ZFykbhqF3LRA8TgtWS2mKLQoictClqJBppI=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7883bcae-5641-4f5a-7a33-08d7fd692584
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 09:27:14.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RO6o7+1xqiirN62E57rx6hkojM6QsVqsErxlErPMDdQ1BF+y9V2ZMpUuscyHeHr/fFayyYJtjeACH6NIqyW8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5894
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/19/2020 7:18, Arend Van Spriel wrote:
> On 5/19/2020 1:09 PM, Chi-Hsien Lin wrote:
>> From: Kurt Lee <kurt.lee@cypress.com>
>>
>> In manufacturing line, test tool may be used to enable SoftAP. Such
>> SoftAP can't pass traffic because netif carrier is off by default. To
>> allow such use case, let brcmfmac parse ioctl cmd, and then set iftype
>> to ap mode and report netif_carrier_on to upper layer.
>>
>> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>> ---
>>    .../net/wireless/broadcom/brcm80211/brcmfmac/vendor.c    | 9 +++++++++
>>    1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
>> index d07e7c7355d9..5edf5ac1167a 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
>> @@ -64,6 +64,15 @@ static int brcmf_cfg80211_vndr_cmds_dcmd_handler(struct wiphy *wiphy,
>>                   *(char *)(dcmd_buf + len)  = '\0';
>>           }
>>
>> +       if (cmdhdr->cmd == BRCMF_C_SET_AP) {
>> +               if (*(int *)(dcmd_buf) == 1) {
>> +                       ifp->vif->wdev.iftype = NL80211_IFTYPE_AP;
>> +                       brcmf_net_setcarrier(ifp, true);
>> +               } else {
>> +                       ifp->vif->wdev.iftype = NL80211_IFTYPE_STATION;
>> +               }
>> +       }
>> +
> 
> I prefer to keep this code path as flat as possible so I prefer no
> monitoring of firmware commands issued by user-space. Maybe another
> approach would be to set the carrier on a firmware event?

Event based implementation would be like below:
1. BRCMF_E_IF -> brcmf_fweh_handle_if_event: Change iftype to STA or AP
2. BRCMF_E_LINK -> brcmf_notify_connect_status: Set net carrier on or 
off only in AP mode

Such mechanism could run into race conditions when driver init (triggers 
BRCMF_E_IF with STA role) and start_ap (triggers BRCMF_E_IF with AP 
role) happens close enough. If hostapd sets key before BRCMF_E_IF for AP 
role comes back (iftype is still NL80211_IFTYPE_STATION), 
nl80211_key_allowed() fails with -NOLINK. This is observed when start_ap 
happens right after insmod, or when hostapd disable/enable happens.


> 
> Regards,
> Arend
> 
