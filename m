Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9C192BD9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 16:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgCYPGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 11:06:47 -0400
Received: from mail-mw2nam10on2096.outbound.protection.outlook.com ([40.107.94.96]:23265
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727439AbgCYPGr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 11:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGjyn2zqL9tYSUBeDq+jtnBYa/KkBlLe/pOsnPVk10CUzJtGO4UNyzcwigxqmIu24J85O5yWIHzfqY9H3Obyre6Pi4lr1Rep6JW6O02vA6TMqm1+yE9iV/2uBYkggL5B1l+q2ZriwZxhLSezZRdbRYUr33kTroMi+9boTJhSc1ruIFXkWxzl72bTD631jDHJ1Wi/XtjNRf67uB0AnA5klJttp1mg1KSo+diPMTw5Tr1oEL5WPLLJTsON1xtVOyoIjmxwxC+sURErB06P1W66lAWh/BJhfLJg3nJikXafJhamM0cc6UMCAtaesZmjgA2uX4sgHF0P7uuslDVk/ml/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWIQqrBk33HXlWq+a59N2/0suwFofMte+hdutO5kvfs=;
 b=jtbv7E6XfUSF1MdUuVLF5/FXx1+9XQDliHyK3jL1Yl3crtVs6Vi0WH9otrknQ1xd5Sx0+zoEyDrd5X+i6mwkcTWfQTlBAak1MNqTb6sUQoCKtdxqnheLd12bIvZbH18VKcTSlkG3kNKm60BSorUoO/AfKpYITvcNpIsGfqYTcc7Js7/GgL6iznz/FNesT/3kMJE/fChQn3pEmYI1yY9c5lyVpAYPU6YxA2C3BZJ46Y+cQ2zALQHbim4AroYAasGiIH8A+1Deh2nEBO5IqIHargg2ZdsRv9I6mDflHGggqz9F46QvCxnngWfCvMuKzkBu44pJ1oGRIu6hFr1NujDsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWIQqrBk33HXlWq+a59N2/0suwFofMte+hdutO5kvfs=;
 b=X3NBHGL7+ShKiWX8bHtUdZy+luaQiXcfpa71C3wavwZmpNMhxEmTtlxEcYoSY2l2QEPYy+AnZNWYTPBq6obMSJA/NbXbDyVcBkWGUZwn853jyJnEm13CbpZsbB4QD/aDAzvBC0Ams2Pbm4NF/0IKHMD0AAEZT3zirKR4jk4HVOY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4636.namprd06.prod.outlook.com (2603:10b6:5:11::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 15:06:45 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2856.018; Wed, 25 Mar 2020
 15:06:45 +0000
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Tejun Heo <tj@kernel.org>
Cc:     franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@codeaurora.org, chi-hsien.lin@cypress.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
 <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
 <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
 <20200324182358.GD162390@mtj.duckdns.org>
 <02b42d9f-7ba3-bb7e-36a6-5e141d37d75d@cypress.com>
 <20200325140814.GI162390@mtj.duckdns.org>
 <171122f50d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <c1192351-6f72-6f82-bb2b-9f91266d8aab@cypress.com>
Date:   Wed, 25 Mar 2020 23:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <171122f50d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0014.jpnprd01.prod.outlook.com (2603:1096:404::26)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (123.194.189.67) by TYAPR01CA0014.jpnprd01.prod.outlook.com (2603:1096:404::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Wed, 25 Mar 2020 15:06:42 +0000
X-Originating-IP: [123.194.189.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a14ab3e6-c1c5-4010-d1df-08d7d0ce2237
X-MS-TrafficTypeDiagnostic: DM6PR06MB4636:|DM6PR06MB4636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB463688F68F9FE128BF8B6F55FBCE0@DM6PR06MB4636.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(316002)(6666004)(16576012)(66556008)(110136005)(31696002)(6486002)(66946007)(66476007)(26005)(16526019)(36756003)(86362001)(186003)(81156014)(4326008)(44832011)(8676002)(52116002)(478600001)(2616005)(5660300002)(31686004)(956004)(2906002)(8936002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4636;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gJeLLNH0CZZGNX17+ZCDWaGto1pCqcyThP33z/hwjCpLaGXAtEttcWkV1CaFmrgQUt6et6M9w3z4PgueLaVLrBjax5AjOrM6/yZcDZvy+vNnnyeGnEZWenlgUFdAEs0k/qWE1FRIWt0fPNCBdbxLsongV3MC486Nt3hipTuEzdWvf0gcNGWs2wlkaRegeouEmV8DEEo6SRNvdFLIfJUvy/XC3oSxcqFYYjWztdo+2fJu6/jDFq5NbVPGaTcobpNsAAXu+weMhI9tPZhJfiFbs37kqM8dqroosN4Sw0us9uJOfzNnQhja7LFO8KePAN5AWTyO1pHIUFx2iivJK2Sc2qerYxmScSnhTevPsoYG5nC2H+ty1UF+XfQBTHBUbAwOdCsttORw1rY/mdZtfYtft8/te6sqolKMqyvwtgha/C/tSBjGsDZ+on9osfeiYbj
X-MS-Exchange-AntiSpam-MessageData: rp/VkA4QyXEcopYn0/gjjCpPSJGFYsNSRVy9/vlINOk6Pghu4vM+Ps1zhmRCiJtU2qHARKRfKxY8i1laWlBFyGLGnd7djLyhxrLWv02Qykba3AZZdJuYfFgrlnRtAxBPWreJZdrc/itr6d4G4VUx3w==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14ab3e6-c1c5-4010-d1df-08d7d0ce2237
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 15:06:45.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxtO6Q1nXDP9RR3/ShLkQNgbvvhpFmDVEDObCgcUWwKAMGiaCJJ8mPxXKjZJRl0OVtqwWEe/YIQmLI1jr1xw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4636
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Arend Van Spriel 於 3/25/2020 10:53 PM 寫道:
> On March 25, 2020 3:08:18 PM Tejun Heo <tj@kernel.org> wrote:
> 
>> On Wed, Mar 25, 2020 at 12:29:44PM +0800, Wright Feng wrote:
>>> If that's incorrect, would you please give me a hint how to set
>>> __WQ_ORDERED(internal use flag) and WQ_HIGHPRI flags at the same time?
>>
>> Wouldn't alloc_ordered_workqueue(NAME, WQ_HIGHPRI, ...) do what you want?
> 
> That was my initial suggestion. Can WQ_HIGHPRI be used together with 
> WQ_MEMRECLAIM?
> 
> Regards,
> Arend
I was trying do that, but the comment of alloc_oredered_workqueue shows 
that only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful, so...

I will measure the throughput with "alloc_ordered_workqueue(NAME, 
WQ_HIGHPRI, ...)" to see if WQ_HIGHPRI works with 
alloc_ordered_workqueue. Thanks for the suggestion.

---
/**
  * alloc_ordered_workqueue - allocate an ordered workqueue
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
  * @args...: args for @fmt
  *
...
  */
---

Regards,
Wright
