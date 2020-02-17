Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41314161197
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2020 13:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgBQMHG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Feb 2020 07:07:06 -0500
Received: from mail-eopbgr760125.outbound.protection.outlook.com ([40.107.76.125]:13376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728898AbgBQMHF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Feb 2020 07:07:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wah7Ko6PE2oIl/znQ4J0icctG1w+0hhXFqkUnF9hrYG/zdKLgwC6BwF0FW13uLFspj1+isfytb88nV26yAb1xwvbfBSK5IwRw8whZTa4gcfLdXKvAxcMLdml7A/GCYot7k2qzdZWnidMuMyO6yfdW/94x9Yobu3vT8WTLPplPKGbjEFlPW8bUf+qGRIV2rSjt/DMXImpr7jmmtOyRseTHiFhhnGe5kIXlL50uvZmduKFL34zkdsA5gRy31jjGdYSvNO7JSRgvLhL/f+TGDd/cltPtM0ttFY9pr2hesO/Se4fIp7RlvHgSOydYgrc4p5Jv/TRUaQoMhlHPvDIzItelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBa0Hc4804LDgbrH7cYCmUkSCWQUGjf1L6xO7v5+5Mo=;
 b=kNN+kixBf4LU2F5fBqDyj9xf5cGbAMUU3MHYqm2r7lNkV/u2w2cu7yXF2SUQiNo4Y8TGe/eanSgExtyxjmMjufQ3Jb/lavJP/u7jEZhTp6AOq7g9C3REdM9kALxt3SCc0/Ii7V/hUwg38WlQpTiL8sutkCIdYdRg+IB23ZJWbgdtTRaB+DyVg9I9Rv27mYja21oQpDLeT2PCibf2MyjfeXpTxYWlwcWJnHZl3NKOx8doVn0SF9C9QmPlbzVBChF2ZNO24aD/GDKISd3kKxVd3VOzbJCcdRb4NvC5q6cbG7cVtBaFIj+PmozyHHc2cA9mQzXvdvAH+ZYfWfIzadJPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBa0Hc4804LDgbrH7cYCmUkSCWQUGjf1L6xO7v5+5Mo=;
 b=kb34a23SA+yELiwEr0Y+5ih+22tVCy4KUrP9v7EY2e6FydiQc1OEOFKTR/Lgp3f3qNEWkNtySamWgQdWoK/XOSJIx1tE2KIMfwYTKcRvdVL7ETjOxYhhKILWjoLQiF0WpQB4iywDW2yytgo1XwVlpHcHHx+uziSzFYC4CvgvX+U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5429.namprd06.prod.outlook.com (20.178.53.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Mon, 17 Feb 2020 12:07:02 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2729.025; Mon, 17 Feb 2020
 12:07:02 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH 5/6] brcmfmac: add USB autosuspend feature support
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
 <1581583476-60155-6-git-send-email-chi-hsien.lin@cypress.com>
 <6c7ab88b-658c-369e-7290-57f0c9bbb03f@broadcom.com>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <3b6f11ea-d466-6fb0-256c-4beb847df903@cypress.com>
Date:   Mon, 17 Feb 2020 20:06:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <6c7ab88b-658c-369e-7290-57f0c9bbb03f@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::45) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from [10.9.112.143] (61.222.14.99) by BYAPR11CA0104.namprd11.prod.outlook.com (2603:10b6:a03:f4::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend Transport; Mon, 17 Feb 2020 12:06:59 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2232421f-fca7-4f6f-44de-08d7b3a1e4ef
X-MS-TrafficTypeDiagnostic: BYAPR06MB5429:|BYAPR06MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5429C2DC4520DF55DE202412BB160@BYAPR06MB5429.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(199004)(189003)(4326008)(2616005)(956004)(31686004)(81156014)(81166006)(4744005)(16576012)(8676002)(66556008)(31696002)(66476007)(54906003)(66946007)(110136005)(86362001)(478600001)(52116002)(5660300002)(3450700001)(316002)(53546011)(6486002)(2906002)(16526019)(186003)(36756003)(8936002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5429;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztoq4GWTYQhG7ldTrqTIpG72jv8Ao7nhlyAHqKTfFtfUqSkJU4qMRRl4BbRMjYGSm3yOxcQ0YIEeHpEQWdHYERXy0Z7DEVIeyf1nYRVKLmxXSumC7VTM26xRS/ttB9+AMUGVjf5MF1pV+lfmBfMi5gl1lxXVW/gvyWZTh2FdHB5HbvFwaqzPG81cHCUAqFGfsDGw8L7Fzo4vjg3twC+MdpTv1R1xeTM0WLU3H7o5uiuikdVMN4WKfLX9hZIZSLp5mZQO86lnhbj7XwiLa+mmcldkHDRGIM1YSphc5YWEzhOn/4buu2WcKAKC/EcVqR7rQ1NBUNlh+1a4HupvEvRW9kRMtSJkYHMZJ9+V5Mf5jO3WkL8/+p3ZOdcqfc96k8OMAs5g0Ca8Qlb3ZmO0d06b3jEccYMJZZkIXKfM2JAZQK9DrWyPhCPgEfHePshDxDbp
X-MS-Exchange-AntiSpam-MessageData: 9ZtwVtPRJOj+jvj5UvBGPFhRE5R+6PVwnpw43DJaQZdAWwRQ1DgcN2GHX5+fASnwgmCQLpObQUzvaVTrMSNPmyJuoVXgZHIMqofl645En+cLF/vySt7Hi4orFGeIrR9oCFOEHTEYmV5I1vikTxBwKA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2232421f-fca7-4f6f-44de-08d7b3a1e4ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 12:07:02.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KPRFqkvJ09gqpYwrPDaRKwmOj/FWi0jxk/IVDwIODycH/pVhr0RqPK/iweRTbAbFHHdI0cLGoZNV6QC3HXF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5429
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 02/13/2020 5:36, Arend Van Spriel wrote:
> On 2/13/2020 9:44 AM, Chi-Hsien Lin wrote:
>> From: Wright Feng <wright.feng@cypress.com>
>>
>> We add enable dynamic suspend(autosuspend) support in host driver. It
>> can let platform cut down idle power consumption. To support autosuspend
>> feature in host driver. Kernel need to be build with CONFIG_USB_SUSPEND
>> and autosuspend need to be turn on.
> 
> You really have to explain why you are killing WOWL here!? I can come up
> with a reason, but better you do the explaining ;-)

Hi Arend,

Thanks for reviewing. It was because WOWL keeps waking up the host 
during autosuspend, but you're right, WOWL shouldn't be killed. We will 
explore if we can use "needs_remote_wakeup" feature to allow support for 
both.

Regards,
Chi-hsien Lin

> 
> Regards,
> Arend
> 
