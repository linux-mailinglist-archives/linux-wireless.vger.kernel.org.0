Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E9419202C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 05:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgCYEaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 00:30:19 -0400
Received: from mail-bn8nam12on2132.outbound.protection.outlook.com ([40.107.237.132]:10304
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgCYEaT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 00:30:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyuexeV4Iaxmq4fYSmf/jC8ppHQF2PYcymY0FY8kFbV6rBzhlw/lEaTK1pnxbKQwCGJCn1dJgxkmp+EZs6IxmvkbFPemeHZFbTQg7atNRgI4392Z386hEC/B+AzbOutKKBnCc4gQgf0Vn5cdurKBcKIYj+L5BnUm63DT+yo/wFBbdw8Oj2FiyHfW3gPTxkPfa6gqboUkOcMN0FSmUEKf1WIXaLgMFpFbc7mrq8KPEPIk1yoYBsIbZALO4QWMw7VTtlUU90cS3apX4Bybi3Dapslhca+XI39pUz7pQDUGqchyzNorxakDbwYlhu9qXyF4ZA5/lsnKg5SX+Bw1r82K+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy+Eu0aFWdXJGP1OBpsHptVSxSQS3lCjRJoMMBs2pt0=;
 b=T8lFxUEOxFzROl3zhzJU+Dok4lCixPKJSrSLbGY/WjKYdROl1bxSImUnwTLafebW07NMkOzkpk/8gmdjfaD2EZkaWGLvOjSuwOh2UIV8+PMSRCUR9Es2u+sv9z3bKvlnoWIJ+pGkkplH8rRr4fJJeTx+bGBn+l+8K+xeMaVJeFzlO3PBWZRtb/ZFojgNJsRodHOaQdA/qsnPTcCzXmghsUMQoyEcV1t9AWkkKvsn+xq+X1uzT6zHuKQw1PpN4TYy8KItttuXpLlhgav345H9R7e7GAA8lAp61NNsYPX1p23FCDPIMjtl6Al1k7RPgEUhVsL763LGGNZ0E5gEOWtDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy+Eu0aFWdXJGP1OBpsHptVSxSQS3lCjRJoMMBs2pt0=;
 b=OiOEAa3/mz0sVQBppjxTfH52mzKGkeAONA28WfcvtPZXsrImpNdKhFlgTXPeoS+yRmLLDcwdDndjZfKvEToXIntZORZ6Z4w8XQVOe7G78AZSHsZMtIsi4fg6+WnhejWw+xBsWD97pCUCF37XLy4VJpjA7K65bw5We/gwd7x3vgU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5644.namprd06.prod.outlook.com (2603:10b6:5:11c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Wed, 25 Mar 2020 04:30:16 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2856.018; Wed, 25 Mar 2020
 04:30:16 +0000
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
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <02b42d9f-7ba3-bb7e-36a6-5e141d37d75d@cypress.com>
Date:   Wed, 25 Mar 2020 12:29:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200324182358.GD162390@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:f6::24) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (123.194.189.67) by TY2PR04CA0012.apcprd04.prod.outlook.com (2603:1096:404:f6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend Transport; Wed, 25 Mar 2020 04:30:13 +0000
X-Originating-IP: [123.194.189.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95ab8a08-ecc7-49ca-06a6-08d7d075378d
X-MS-TrafficTypeDiagnostic: DM6PR06MB5644:|DM6PR06MB5644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB56440B9F5B3D6F26AB9CD4CCFBCE0@DM6PR06MB5644.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39860400002)(478600001)(8936002)(81156014)(81166006)(6486002)(8676002)(6666004)(36756003)(2906002)(52116002)(6916009)(44832011)(31696002)(956004)(2616005)(16526019)(31686004)(26005)(66946007)(66556008)(66476007)(5660300002)(4326008)(16576012)(186003)(316002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB5644;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu8kMFtfUQSrFlqFzgA78hmxanDQL5A9gMiNgpwHUsanzS0Jq61h4PJWt2ETRdpgf+fBJzExWW+aexngsD4mxehniKAgBllkLrxIHHm3Iur9hKWOjDOulJK6l+9YLK7fKZTG5xs2kQO3xngjweHAII23Q1pYTyf8ca64UjTGf6+1CibsjfGkg2h/TkxlK85kUIEb9+qNV9/UenMQ3xJaFsTPoVqxgHnkIm+w8q/7jvUJVXvNhlpk/+V6UAmIx/TNPRve2WHXan1gNnxQ3U7vVP5xf54+X515wkh3KWccPrF2j9HhhLZW7rM+Zil3WNKGPBnFexh2uzgk5jEnukVEiV/2q5jr9/T0qv2eoQa2i1h0ngqPoPy1byUYJJOAnY/H/Y937CtaguS6qrylE89pvFKeM3pXwKwxWEwlm8ibJUWRGFy8puzZ0wxkmMDxkUti
X-MS-Exchange-AntiSpam-MessageData: kP6INVeYRNLhuIIdmqVZKhgZ6HptlsNKlSSt+xet4gbHUstQ4YVgdzItHgf22uYS7NyZyojURchXDRs7PTPxuxCWYyigdSR7z7uhunSy/A5Q5v4OzkO/wR3OqnWPT5pRaR5kNM06Vm7kHHoydY40BQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ab8a08-ecc7-49ca-06a6-08d7d075378d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 04:30:16.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJC29JY5wn2v38m3ZoIO91kG2rvHx59ZvBhYJvryIFgwCl1XFVNNeEIu9tLWpVnXJG4CaUQ9iJMaaTzMwTXydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5644
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Tejun Heo 於 3/25/2020 2:23 AM 寫道:
> Hello,
> 
> On Fri, Mar 20, 2020 at 04:08:47PM +0800, Wright Feng wrote:
>>> So two things changed, 1) WQ_HIGHPRI flag added *and* 2) use
>>> allow_workqueue basically dropping __WQ_ORDERED. Not sure which one
>>> contributes to the behavior described in the commit message.
>>
>> The combination of Unbound and max_active==1 implies ordered, so I suppose
>> we don't need to set __WQ_ORDERED bit in flags.
> 
> It doesn't on NUMA setups. If you need ordered execution, you need the flag.
> 
> Thanks.
>
Hi Tejun,
In kernel/workqueue.c, it helps set __WQ_ORDERED flag for the 
condition(Unbound && max_active == 1) to keep the previous behavior to 
avoid subtle breakages on NUMA.
Does it mean we don't have to set the flags in alloc_workqueue? or I 
misunderstand something?
If that's incorrect, would you please give me a hint how to set 
__WQ_ORDERED(internal use flag) and WQ_HIGHPRI flags at the same time?

---
/*
  * Unbound && max_active == 1 used to imply ordered, which is no
  * longer the case on NUMA machines due to per-node pools.  While
  * alloc_ordered_workqueue() is the right way to create an ordered
  * workqueue, keep the previous behavior to avoid subtle breakages
  * on NUMA.
  */
if ((flags & WQ_UNBOUND) && max_active == 1)
     flags |= __WQ_ORDERED;
---

Regards,
Wright

