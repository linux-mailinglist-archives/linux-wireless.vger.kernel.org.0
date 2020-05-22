Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED93A1DE54B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 13:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgEVLYl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 07:24:41 -0400
Received: from mail-dm6nam11on2136.outbound.protection.outlook.com ([40.107.223.136]:45216
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728281AbgEVLYl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 07:24:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwsxZhhNCr6p6Agh7O7Va2+8oCramJ3BuDByj7Un17hsbKJGM3DsFlMkR0R10euHWUYRyZK4bAVG6Qjk0D9OrmCxeeM2Tp94AZhKuuAa778eTuiuPdc3ZwLBlUem8nz9caI5t2+2ZEDSDSX3M5hjKq/7ASvNILoE1qoNbdTXumr5cq5H6TCLhWXg1exSik6P4Zq0oMsxB9YBtyGqzTnqn/H6Cnc8Fjv4k+tFKmdmquiYHJKVGjgDmpZYb2hxaxZAMX0HLZnz+W4ujM95WWxHwLDQdJfOjJYnqYYxJ9fSe71C63oz2Zi8ml/WO8M2eFp2jdNamVfQ6/3+cdk98lhDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inYjdd3SiNfvgTAXfaMlYGRErqGBmDyOq+vfIeDPjmI=;
 b=KYDkFEeAaAGtQ1jx0e5wmEQ9G0be7bUASEiijr8qqS69mKXYcZnssiDsH8B6G9NeYulhHSE/pShmWYWlOOEIUYx6arS//LYKVFUAQSfAu6iFQ97fU/biQZrdyPsZVfnz7nUfwFgv/KX0XyTicnrLSo9QsbfAmnt/YNcGG2wZrryXorTDnUm0o3P2Iz+Djd30k5poY/wzQUPGXFsR1nvo8PkUxFbEXEpjxlxRYXI5ui54hZlelRmgY/ZN3j3C/ZnzkHsJltiaxmrYKnhuNZyEKqZD0TtNeHe+q1M41f77aqjEjTqcfyHVTmtgy67DiQNNhyAbl/0gpKXdpJdjDIGXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inYjdd3SiNfvgTAXfaMlYGRErqGBmDyOq+vfIeDPjmI=;
 b=ERiNetfh1bhE3JckoWccxGQVIzTS8GzCIwGKnlvK5Nqhg6z1XsGSeL5hu1buRK792OaUJXz/3aTBPLvkog8Ng6VBI7eyipXudsnyy9QbKv9yhwNmolOaRCn3bZ6qZy1B/aa72m+tcnArOksGD9ReDNUvxl5Wt3JAfCr7rsPG+tM=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5560.namprd06.prod.outlook.com (2603:10b6:a03:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 11:24:36 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 11:24:36 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH 0/5] brcmfmac: SDIO parameter change series
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>
References: <20200521034838.57371-1-chi-hsien.lin@cypress.com>
 <87o8qg9rwm.fsf@codeaurora.org>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <55084891-6bef-6b5a-f344-f7e08439bcb1@cypress.com>
Date:   Fri, 22 May 2020 19:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <87o8qg9rwm.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:74::37) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BYAPR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:74::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.8 via Frontend Transport; Fri, 22 May 2020 11:24:34 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e9cb4fc-bd5f-4d21-a3fb-08d7fe42b572
X-MS-TrafficTypeDiagnostic: BYAPR06MB5560:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB55604DFF37CA9E9654927406BBB40@BYAPR06MB5560.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8PSSO2Ah+9ywopZUrObRu2h9bDfenUllsb7mnEdkUZPf9TvSMKeHPdDHWeiHDENoXvhiBezif4LQdPl2TJaqT/eoGH4tojRmsefPsMIk6lwRerS2l3MP+ObQKUeDqwtg0yc6vERyHIuTNjhe/x6FZFQV84fQv6rD/X9KLwetPZZ3RW7ZOBij310wxfVRuvGzIbGiAbVZVT+REh4dxbvohN+sO1I/wrSRqqk8sxXD+qXf6XKzM8TZ7L4ms6W3l3xNSfZxAA/dVL+q7AnnbA6i+EouVQyOp3ud23F/w/P5WhLbvvCvIKpOa3WIyhBQXpxtCsor0q8yBeMGhxRwW5+wA7JmT8ASOkzArlQ33uoGs3YQTPS6gN//SuJb7di2yg+xq7de25akhnh6Gy2dAUPxkez0xPDW1xl1Sjua8xJ4xW5YeAdIaDKLKlw2q3Avl5fUx6Cqc1Gf+aiRzWK3mnb5JleMux7Yg355b0pe4viu+yEKmOl9np1jZKPQxcHjZUC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(39860400002)(346002)(366004)(66476007)(66946007)(8936002)(5660300002)(31696002)(478600001)(53546011)(86362001)(4326008)(8676002)(52116002)(107886003)(66556008)(16576012)(6666004)(316002)(31686004)(36756003)(54906003)(956004)(2616005)(3450700001)(26005)(6916009)(16526019)(186003)(2906002)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PfWlxFNyczziBGTqfeu7G0wZ3TZ9V933be2ytc6Ymh2ZUiJ2vb77dxMqRa2g5y/2SgelYlPZORsUzJc7dVFjr8PM4mWiG0MooIV+gKYFMpd9Fsa7MwChVfrR7AWAAKfDLyxLU/wXbAHtfemDWhsk/7LYePgHoO3ml7vIW350dV+zQ24SuHX7CqB0g4MgVOEXZxEXWzLaxNTeGLacVp7fvj6QbAMOV19eGQyaUR0AVkIkQI1On7wxjg3EUkkKN7Kr7FgiiEdkF8922o/VEG10jfcJh0mn5KfrvAqFt0JoWoEe9qX/u+P8TEBlgzA84/3NFVEOoE9hFzYZ2x96koef2h805KXfEY9eVSRKYEl76kKRN/sIecfco0VCAm1cMIOhnQlZMOjbe+/xTnYgs5rOzCESQKquXvX6kHceyDCCiEkEgjJTyqAlwXUz2DIYJSWO6WdpqfLbAjST+tS1MSbGpsseV72UjKZblncRB20KRLs=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9cb4fc-bd5f-4d21-a3fb-08d7fe42b572
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 11:24:36.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fjWZSpT5ku9QccQ4ecl/oxXQ22nydQykl7VlA9LqvjgFxYjbAcwOrw5cF9/k18Urjs3izvOLYaUHGBZ4jdWTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5560
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/22/2020 6:37, Kalle Valo wrote:
> Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:
> 
>> Set F2 blocksize and watermark for several chips to fix bus error during
>> stress tests.
>>
>>
>> Double Lo (2):
>>    brcmfmac: fix 4339 CRC error under SDIO 3.0 SDR104 mode
>>    brcmfmac: 43012 Update MES Watermark
>>
>> Frank Kao (1):
>>    brcmfmac: set F2 blocksize and watermark for 4354/4356 SDIO
>>
>> Wright Feng (2):
>>    brcmfmac: set F2 blocksize for 4373
>>    brcmfmac: fix 43455 CRC error under SDIO 3.0 SDR104 mode
>>
>>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 22 ++++++-
>>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 58 ++++++++++++++++---
>>   2 files changed, 70 insertions(+), 10 deletions(-)
>>
>> --
>> 2.25.0
>>
>>
>> This message and any attachments may contain confidential information
>> from Cypress or its subsidiaries. If it has been received in error,
>> please advise the sender and immediately delete this message.
> 
> If you want me to apply something don't include disclaimers like this.
> These kind of emails go immeadiately to /dev/null.

Thanks for the feedback. This is added by our mail server by default 
without showing to us. Looks like a recent git upgrade caused the 
previous exception rule to fail. I'll fix it with IT and submit a V2.


> 
