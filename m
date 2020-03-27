Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0E1953AF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 10:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgC0JOx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 05:14:53 -0400
Received: from mail-bn8nam12on2113.outbound.protection.outlook.com ([40.107.237.113]:13537
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbgC0JOx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 05:14:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/kQtnEkSJrNcU0jmOFijQ5m6LaxoPc/fkzpLfYn/drNmTngJuVAvD93INyGu23HUNvVgkttxueSuuntcijnQT8bkVTcDrZsvW66FkGVU3gWqLYZ2cYI/VJ4RWtYHtoCZztGxUndr6ZJ7WKFoQPx9ISDkSkVugfmjrbbmS0HPAOj/CJmM8Ej/U4qGdi6BOSo4/HAU+k6fq9P89uXHaQHMYKc7kddKbBpgtKlZVesVngN+FTJ2APR/6T5DjEZ+gdWGvOHd4/idz7424hAmXVHQB7YWBKZAzfP2umySm2ezFryq1Q9gIEJWc8mxV5zfwVchaWuHQ9aH7SODnuFOovKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg7TsrNDefBu2Pyv0lbCxRmQhwRh/qTQoCXEEz3wqOU=;
 b=km+mydP+K3ntHeBHUcPyIQd/0IfF1DT+nUWm1IN+GsssBmoJ3N8dNnu98/tFQnjMj/4215VlJYyhQz16SzvN0sWHdkTVOiMrhPj8SCF1TIseP7GpVDb2SMhH2/PqEzNws7uE5hnITM/s30ankReTNagA31pKKodUBerwiFVmmypw/8xmLNDwmJuG6LIFof2TViSE+BMZxX7WFMlsT5mbGzj0ZQc9mOW6tOFsdXrY31PtlY3ktSB1iUEk5iTnbHPjCSrzQKvWHebS1NV4u9XItXxSo5+bqxWK5R9qQNuXzGrLXBT3rDSneFRKhuSkqVnuFKKT5qbF/YFvvrwMiVVUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg7TsrNDefBu2Pyv0lbCxRmQhwRh/qTQoCXEEz3wqOU=;
 b=VPuWm5LPDUv8uFWqv6MKzSrAy40/u2DCGUAQVTQpPB8OWa+M3ButXhVFQpDKOfGRzwqqlB9+Q4euDCD+oUD8t/+MjRqh1k1hqW93mqeAlgykEcs/JY0p4+kDCK3LcPXwM+fI/0+5XgYoxI404DPcTuD/W7PcSchKPHONsp5Zvt0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6316.namprd06.prod.outlook.com (2603:10b6:5:121::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Fri, 27 Mar 2020 09:14:47 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2856.018; Fri, 27 Mar 2020
 09:14:46 +0000
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
To:     Tejun Heo <tj@kernel.org>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
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
 <c1192351-6f72-6f82-bb2b-9f91266d8aab@cypress.com>
 <20200325151234.GL162390@mtj.duckdns.org>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <342a1c26-16e6-d824-e421-5f4785f905b8@cypress.com>
Date:   Fri, 27 Mar 2020 17:14:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200325151234.GL162390@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:404:42::31) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (123.194.189.67) by TY2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:404:42::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Fri, 27 Mar 2020 09:14:44 +0000
X-Originating-IP: [123.194.189.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39aa5c2a-86fe-4ba3-18f1-08d7d22f4b5a
X-MS-TrafficTypeDiagnostic: DM6PR06MB6316:|DM6PR06MB6316:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB631696EF785AD97DBA995CE8FBCC0@DM6PR06MB6316.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(478600001)(6486002)(8676002)(8936002)(52116002)(81166006)(81156014)(6666004)(2906002)(36756003)(6916009)(31696002)(16576012)(956004)(16526019)(2616005)(186003)(31686004)(26005)(66476007)(5660300002)(4326008)(66556008)(316002)(86362001)(66946007)(44832011);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvs4MYECnZs2gotVFhTeVvQIRflQuHvH53dhjyvNWHmxIoy9DNO7myHMZXvLMxt+7lNwQMR4s9KqYdhucCoA6SJ/36IlHWB4CxcVC1ghB3nqd1iiBcqhCuZYMpv9D0qTUd+KP/YCOdLNgqEiIEZmtDMEm4n0C4F2LtElONKI8EEvVGtEASg7CHn17AXX2hPObQDZU4B2MuoOsZBmtv1CnmS//LKs/HaXOQJWzIurYtfVpR8NviAPHTHLzNd3PAURknsNOCxXFJw/nYNiApekecP+vpkOxT4xk5ouZ/zB98d69wLTxIVSnEIQ7bIoKI5ZvBXpx1QVjWKoMUS5vYdi6NqQadodeMzA/BOpOpDqm8UDClcI4Xmz4seYIPBNuoxwOlKPimP8qFWl2mxttUGC+3EGXKBUIOTbCBET5PGohWguotME8aHUmyxCL+hxjbHe
X-MS-Exchange-AntiSpam-MessageData: SIXzgU14+32hYGkp8jL6fDGzNx9BAUwUT+grydb2/kYu3bePRL9/oOFO2zngW+U2N+iYSJpqTLOkUSxFXeZDPHGK/3GVCz95HhZyBXX4kUUxhNvbQ4OxCIl1McReO9si9Fj8wl6c0L3F0sq12LZSyw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39aa5c2a-86fe-4ba3-18f1-08d7d22f4b5a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 09:14:46.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQFFPPm3U8IqDlIeCussKYbU0rQ17EW0kkfMOieIjkD4TA1m72EmDK+moqmY8dbdMBpeBtVWweRQD0ZchmlWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6316
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Tejun Heo 於 3/25/2020 11:12 PM 寫道:
> Hello,
> 
> On Wed, Mar 25, 2020 at 11:06:33PM +0800, Wright Feng wrote:
>> I was trying do that, but the comment of alloc_oredered_workqueue shows that
>> only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful, so...
>>
>> I will measure the throughput with "alloc_ordered_workqueue(NAME,
>> WQ_HIGHPRI, ...)" to see if WQ_HIGHPRI works with alloc_ordered_workqueue.
>> Thanks for the suggestion.
>>
>> ---
>> /**
>>   * alloc_ordered_workqueue - allocate an ordered workqueue
>>   * @fmt: printf format for the name of the workqueue
>>   * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
>>   * @args...: args for @fmt
> 
> Yeah, I think the comment is outdated. If it doesn't work as expected, please
> let me know.
> 
It works as expected. With alloc_oredered_workqueue(..., WQ_HIGHPRI, 
...), the nice value is -20 and throughput result with 43455(11ac) on 1 
core 1.6 Ghz platform is
Without WQ_HIGGPRI TX/RX: 293/301 (mbps)
With    WQ_HIGHPRI TX/RX: 293/321 (mbps)

Regards,
Wright
