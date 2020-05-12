Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A11CF2DE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgELKug (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:50:36 -0400
Received: from mail-dm6nam11on2104.outbound.protection.outlook.com ([40.107.223.104]:37569
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728990AbgELKug (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1lqdyO5BEofH8X6JMvuAwQDAPBrZh1I58MNqK2MdA+oEIpxwwdaBmiTRgtMPrGQrXOPGDy2vz7L6cEMLJhFo9T65uebXEwacFeIocgzRTrutVnpYzakvwAnCnKm/78PJleQrvlirCVcCsZsI1Qubzwj/oF6ZtwmDXZdzZtFHDIyr97uECWa0ySIT2D2PZBEj2x463n6Cbks56r/RN9yHmY4pLHDc+JQbzj66FK5p8yOAc/8I8XGUNANVbwudET26gewz0tl482zxXi3fU4ARLMAV9AREUeNHMd8i/HM7EDjJ1IwKgGnXWw6OrotIm5hwETNlvw5vuwYSk/RrKjv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx2Rja6uB6kxPm5NHXqWnVixJ+smyCUcCptxyWOHR5M=;
 b=Z9BxVV3bzQBFSa43E6f333/c5IswUmwjxtV9G3oJeo5VPijxWk6OGXB74kFtJoiOScWUyyPiDeXBiCs6Oa5lm47qc0qLWqc6eTRY+85Vf7MZoPZQ6IjUxoKPoBgCzkr2q0+40IDNY1YDQpGs/8gmRBO+OoFHnEWB19YMXXmw5S4KYjE8M2EOiUwTBybQHA42Yw65MJ0F2W225HSCLEBLoOS0hAkdlfz8FXbhL5p68E8Ik1QY5eVQ9QGjrIcxD0dmUym3lzB1kqFrgFCcQWZTai3zrPsxpXvPOSkv/BxGc5M9Q6SnFlPSXDbSbosJUp9qPlFwmo3I1L3Wbs7wxpn+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx2Rja6uB6kxPm5NHXqWnVixJ+smyCUcCptxyWOHR5M=;
 b=iBlScOxDorkVJZDGcYXKft58bQvn6s+rQ9L4mukf4ZS9YdxQGRHGidbfy/gDBhS1NmsddY4r4glH0Kj065BjvraLMHxWhosxxbtXKWbly63bNM5XXh3kcZnPzaAZQlmxM9dgZdyLdvCc5f54Guw8WSPE1hiBLT+iqx1CmMPyyP8=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5334.namprd06.prod.outlook.com (2603:10b6:a03:c3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 12 May
 2020 10:50:32 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.3000.016; Tue, 12 May 2020
 10:50:32 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH] brcmfmac: fix WPA/WPA2-PSK 4-way handshake offload and
 SAE offload failures
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
References: <1589277788-119966-1-git-send-email-chi-hsien.lin@cypress.com>
 <8736853053.fsf@kamboji.qca.qualcomm.com>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <eee1c02d-63eb-933f-3a3e-fb303778f98b@cypress.com>
Date:   Tue, 12 May 2020 18:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <8736853053.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:217::9) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BY3PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:217::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Tue, 12 May 2020 10:50:30 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bad59b1c-c00d-471c-7fdb-08d7f6624af1
X-MS-TrafficTypeDiagnostic: BYAPR06MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5334C26B6E62067EEF6D1DC8BBBE0@BYAPR06MB5334.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V665xVdAVCi/isdzSuGXMdI8fHBZ0CIVVKeG8qAa2+q1PFXXqcL+MR360WSpDT+g/j08D0WF+EF6vmt2Nc/YDsTZquESuI+dtW81Bct+02cnGDiFaQ5QMaquac8dQOxkSOhH4bpWTlZ0OaCt7em+7XnrBPHIzFcrTYWxbP2Y+nRe9966QpYMeeKC+eeddn9HMh7M093StYI49P3gOpq0o6wuYBz4e4PF+Yc5KYTOsLkPfX4jn/NWoa5o6ZtlgCZMOEp//aoqWmKd0X6Kq+svIw7mXB2uIKO2+PERW4nESndCylHcUmWXIdTCGg9x7HAQtn6A4FeGdeCaq1bAvACjkaEBAYdTag6XzOgG1s492Dwd30oJxTeGy0RdHHV5fwCOUMdKC7kCPNcv9HBWD/9LagfwcF8ZRLCtAkw2Y1BvVoxgoumxzJrbzwZWxae7xrWu3RIKfZSsUA+UCkfgFroGTHtzBWhlZ1XHpcraso8QPvSjZHr/TOakPeWh+USJ/h0MeRIcqrUn74KL+CfXxqSDUk2ViACqL0mJpJn+3JjqqzjrZc2OCJRfzxiFzbgZ2I+c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(33430700001)(8676002)(8936002)(2616005)(956004)(54906003)(16576012)(31686004)(107886003)(316002)(36756003)(4326008)(66556008)(6486002)(66946007)(66476007)(478600001)(53546011)(186003)(52116002)(16526019)(3450700001)(5660300002)(6916009)(2906002)(26005)(33440700001)(31696002)(86362001)(4744005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: f+qN2I8lp+zLD77Urk5FRqMXK6sTaOmhJ5DKRzixARaC8ZpDRqtw6SVdaqWNGMBvJJEdPjUDNIsyrBzl3fbHVn8genXMgQnzagBrY5pkGVfKouesuc0mfp+es/vu1nD8mpmOHiIZiLcXoBP8XukjuLh7RdYnEUP6XZYTnVUNrrRoIbpoYw1Efly/ogm/Up7Qp9f/ZvMFmmyjNR+9Ni7pXsGbJgDyxShuCue5hiWJusETePILDI0VeYlzD9ZUeDEs6i7g+CyLI47GL0UyVcSxSv4boSHyzyceZzNGgkU8it3Jlj/035R+yOyFAS18rxLgRVotaWrxEJa0lM0119y2yu/RI5B6kZLX4YiTMCIoL4uyfGNhfHDPXolCCAVBmt1PepJG8g0jeuERfdnwXbTRODnNggaRVu+aEJO4FySn+5tTdF1PzD20VxH89UL695v6DAqu0yiWjhMLoQ6oWze86uJBg9ZQb7s6cgCZ7DnBDhI=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad59b1c-c00d-471c-7fdb-08d7f6624af1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 10:50:32.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvY+H/jrWnA88LdrV3rn5nqeeHZ4rl6F0y5QtSl7IQUsSyB4AR8X6VV/bGX/efMqHiGEuP/JkVjk3Ljwq+UYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5334
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/12/2020 6:42, Kalle Valo wrote:
> Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:
> 
>> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>>
>> An incorrect value of use_fwsup is set for 4-way handshake offload for
>> WPA//WPA2-PSK, caused by commit 3b1e0a7bdfee ("brcmfmac: add support for
>> SAE authentication offload"). It results in missing bit
>> BRCMF_VIF_STATUS_EAP_SUCCESS set in brcmf_is_linkup() and causes the
>> failure. This patch correct the value for the case.
>>
>> Also setting bit BRCMF_VIF_STATUS_EAP_SUCCESS for SAE offload case in
>> brcmf_is_linkup() to fix SAE offload failure.
>>
>> Fixes: 3b1e0a7bdfee ("brcmfmac: add support for SAE authentication
>> offload")
> 
> Fixes line needs to be in one line. I can fix that during commit, no
> need to resend because of this.

Thanks a lot for fixing it. We'll use one line going forward.

> 
