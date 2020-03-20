Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E418C89E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 09:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgCTIGU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 04:06:20 -0400
Received: from mail-eopbgr680093.outbound.protection.outlook.com ([40.107.68.93]:43613
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbgCTIGT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 04:06:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTluAaVZRrML0brMpzOxhCsXPLx/7nbvWeK7QYdpAr/MYKwIA3W/9zpjaZXZB6gb9bIgLQy6yy5l3gWr7864j+hZx14Vg89nmVXYX4X94sxLigt4hsPtmCun1Zupfa0sZmUqyaQo6ALER998N447tfYItOfy3+oL5zjfnxeYnf7FUPiKcRfawYLJOHKDQoYxzfkYvpk1OqNFEnZ8MNUS7oLUJNiJHo+5TQQ1ovci0Kwpb+uoycp3usLSaVGmj+MfT37XO4oS+xKmMDrHbLirWiCUHN2K8/flWxJr/oHdtFCZJZ5oxomEZRoLqmwWg3614gE302nUtUqEan+ItG9jdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvHksyWOvuXF389pGRN/ePwkcpkAsVCMG6H40eFDiWU=;
 b=KS5np4l20CPy30iUYUv9TXTS1rFtOgl1LZuyMbEK29pTlJ54+GI6aCZFc7AldVNauNW/7hB78eFT0ejgIsPDF+7Lg9XNdKgksAWO9ssHgvf2FV8c3EQVR/ddKndyX7fgiVaFqFzDqHpuYpeuOxO3lhyO6ss3avVY2EtEirdXSU9VfQlZ2U8RevPVPMMo59RfV1jHrhZGsp3hOyApRZYRfKYVhsajklamxl9dYwmOdsnxy0gEaJGUvVNuUlnd1nxJ1WeMmQ8IFqS1guavnykKDNY31haDEwsLlYjPKamRMsIi7QrZWsdkVMyLxAZX6F0+b0Vlu0MYiMEMl8tKgBKO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvHksyWOvuXF389pGRN/ePwkcpkAsVCMG6H40eFDiWU=;
 b=dkRRcgWwaur/UTLI+clkCBqUSpvNaIeO8KLuxRIZbk8VhCrES5ETIJ3CwwD82F5AS0WBNuOA+VEV2v02A757trgsvCgtq65ZiISPebHXJjjmxOTgSBq8y39cDrsArAMVOZ9oIMuxQwcn1aaG378mc5rH8x9oDtJ8gJEB392HSOc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6412.namprd06.prod.outlook.com (2603:10b6:5:111::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 20 Mar 2020 08:06:16 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 08:06:16 +0000
Subject: Re: [PATCH 2/3] brcmfmac: make firmware eap_restrict a module
 parameter
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@codeaurora.org, chi-hsien.lin@cypress.com
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-3-git-send-email-wright.feng@cypress.com>
 <aa29c77c-cfe4-3d71-1860-f9bcb9e0282b@broadcom.com>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <9683e5c3-5f68-5632-e1cf-c31e51379673@cypress.com>
Date:   Fri, 20 Mar 2020 16:06:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
In-Reply-To: <aa29c77c-cfe4-3d71-1860-f9bcb9e0282b@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:180::28) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.177] (61.222.14.99) by BY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:180::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend Transport; Fri, 20 Mar 2020 08:06:14 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa21670e-927e-4cfe-12e9-08d7cca590ac
X-MS-TrafficTypeDiagnostic: DM6PR06MB6412:|DM6PR06MB6412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB6412D734D9D85D780C16F1D4FBF50@DM6PR06MB6412.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(81156014)(16576012)(8676002)(44832011)(66476007)(478600001)(6666004)(66556008)(2906002)(66946007)(81166006)(186003)(26005)(31686004)(16526019)(2616005)(956004)(8936002)(4326008)(316002)(5660300002)(6636002)(31696002)(36756003)(6486002)(53546011)(86362001)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB6412;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEmH2QuvfOyjOwTHZ7dv9w8UKgCBgmmxMSSi7NpMexPx72Zh98HisT3TWrHTZKLgPCFfNQFOsie/Rlj0nxuoNsq/CcFYVGGIRbNFxjI1Z0HFzXkaaXfK5wzGD/eW9+2QSUFikRoROJXczgVkfJfjMCpP9n0y1cyZLWLILXRnjXDv1enCi1kkQmsTLLr1nrDkKp6eE8UJEtpZmfGEAUNcuop0Oy0UvZideuu3hfuiF7gYAwg7AFVh/0dkh/6lHhwj74YhlsZeuhwJvMd5m11IkAx62uke+GeiOwA0IXTto8sTy/pXyXk5ZThrv3svhZGyPZF4oeHG8PzSpkPgVbdBFS+o39QKRUhYBPG0ZqORVFBUKGyHL5E/5wsig0v30uiXeuYvnJuAWngwS+W8rzK8WiRWBz8s0j5GN5bhj8aPD0dAOflRC4zKzS356kut9lD9
X-MS-Exchange-AntiSpam-MessageData: RpYJa+m/11giMW4kKxhuLsiIyUBLLZ+pe06doJJ+p6NTCSKBanckdzwvZ58D5tPPyH9LCjR7EmvmQRTuaTKdPcfy7Mm+QzRfMG3bwtFg1UmTaFIB/O6veqgzlbImDlUixeYzN2ciY0SwUsWqrZuhlQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa21670e-927e-4cfe-12e9-08d7cca590ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 08:06:16.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70CPDq1Jt6e3JVWF4tvhQdKMLBLSxXcBr2f9iEMmaBhZIukdxABylGPIDBsTlJ+LHrRQb5cEZRHuQpWGEeOQsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6412
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Arend Van Spriel 於 3/19/2020 4:28 PM 寫道:
> On 3/19/2020 8:53 AM, Wright Feng wrote:
>> When eap_restrict is enabled, firmware will toss non-802.1x frames from
>> tx/rx data path if station not yet authorized.
>> Internal firmware eap_restrict is disabled by default. This patch makes
>> it possible to enable firmware eap_restrict by specifying
>> eap_restrict=1 as module parameter.
> 
> What is the reason for not having this toss behavior as default? Don't 
> see much reason for having the module parameter.

The eap_restrict feature in most of firmwares are disabled as default, 
and refer to our experience, using eap_restrict increases roam time for 
associations in some cases.
So what we do in this patch is not changing the default firmware 
behavior but still give users a way to enable eap_resrtict feature.

>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 9 
>> +++++++++
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c   | 5 +++++
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h   | 2 ++
>>   3 files changed, 16 insertions(+)
