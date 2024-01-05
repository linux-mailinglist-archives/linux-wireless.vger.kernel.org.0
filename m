Return-Path: <linux-wireless+bounces-1542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E526825BD5
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 21:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADA1283241
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5120310;
	Fri,  5 Jan 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="QL01p+UJ";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="QX94U5/J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD1200CC
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405KZiGI020792;
	Fri, 5 Jan 2024 21:35:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	12052020; bh=cxbGCG5ogZwvbeS3J1DZMpid9C8PK7qpBmEtnCA3L70=; b=QL0
	1p+UJvQBqU7qi4MDQNkR7P2qvpL/XAhCNT98R08IGHYrMRnDTorKTmd3GmHnKkWD
	XWbdkHWCmSy6IaoYHATAIAc7ErX0lZ/ZfwpN8ULXjCWsh5U0lSBmN0Dg0VptQpqP
	Ib/HZhyT0efZk/8hA+tTwJeD17j9RZ1XTH5KIacqBkyk0w1uP+QBbt6O+j+bIaAx
	rfAdzTwcb1v9LtbDF2EhIb2uHiAcy92qxiWqIr8VPrfE/2411Htf0z12iMqsbFZS
	WEb6ALsfdblpgwERtIvz877XnG7qtoeInCq/kafNIuN91R8eTxK0rxAmC6P685sG
	yI91LzcejPfTujwCW2g==
Received: from mail.beijerelectronics.com ([195.67.87.131])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3ve15m90y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 21:35:44 +0100 (CET)
Received: from EX01GLOBAL.beijerelectronics.com (10.101.10.25) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Fri, 5 Jan 2024 21:35:43 +0100
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.50) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17 via Frontend Transport; Fri, 5 Jan 2024 21:35:43 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLQp9cs17xR/EkNlRieNq9QQelLlQgwMIGBnmO9lywBv74z7hQbmIohIdTm74No6jrQrto8ssPchNwgtqOjn1ffyDebSmbXScu4SjUL4mjfS+ZiW5TRCBx8Wxk4Nvpfre5LyKGQc6Xy67YR7hzMkelA8vJ1wKpnFfxWl5L24Tdpta/w6/AIgnlv7SCmLuKxAT72Eps/fUh0ddz29fH0CCnu0PM4HGtM9e/dYONFWm1OYDsR1wiY5FG/cTU1Z0BcTkGI55ZbNCoqIU+6hllCqkBfiJIGYH6JO8+RkE2OKlQfoU2En+LivNxLnSrV2Fmx26qmwH0eQvZEekm8NB3mPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxbGCG5ogZwvbeS3J1DZMpid9C8PK7qpBmEtnCA3L70=;
 b=lG4ZIjRE6IleSwFlNd3b7qHwX0vMwBGFp/yhRa+TLxd4IVLOMwGDra8Jd+a+qFUCLedChSJ9Nk3CUfs2fob+GTPRohgyDGGSnKejwhvtXrYH73E+VSkTZwy8dy+l8J0Xy9FPUZVdP+Mf0XlDS2DX18p+L+fB8nSpkOgKzUVT9UcI0lw0wpJCAf+U46VVYBxNEOgHvnkuA8oReCv6BQneEuziIMuexuvBn13WeZH7YLrwqL3KfiF6fnyT2Yj5v/lYvpWsh+bUWwLlJnma+rwCzj/ucB1g/D9zuwKFJcMtgJ3hOGDAhSXE/O7JYtn6QNHsPXhv2dYq5aGkXETP8NK4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxbGCG5ogZwvbeS3J1DZMpid9C8PK7qpBmEtnCA3L70=;
 b=QX94U5/JullmDjJbDFzmvczd/xwy85arRi7rLUTGfpjQwWJBB53qdfM4a76cAZZYCHEy2rY38wZe794OZb5TKg0ziz3Knp+HVV3ExXgUHcBclkoo2Cr88r/gLkFNVhcb1aT/cz/h02gjDHgacgFmRbIOuW99QhkuJrCFkZurkrI=
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:296::18)
 by AM9P192MB0902.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 20:35:42 +0000
Received: from DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::3885:f67b:6780:66ef]) by DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 ([fe80::3885:f67b:6780:66ef%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 20:35:42 +0000
Message-ID: <728b6538-19b3-4fb4-b91e-f72080c4c9f0@westermo.com>
Date: Fri, 5 Jan 2024 21:35:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iw: strip NLA_FLAGS from printed bands
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Zefir Kurtisi <Zefir.Kurtisi@westermo.com>
References: <20231221222842.1310957-1-matthias.may@westermo.com>
 <6a54a2afd9e2b1b67822e3ca9b86654e3886feef.camel@sipsolutions.net>
From: Matthias May <matthias.may@westermo.com>
In-Reply-To: <6a54a2afd9e2b1b67822e3ca9b86654e3886feef.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::11) To DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:296::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB1388:EE_|AM9P192MB0902:EE_
X-MS-Office365-Filtering-Correlation-Id: 72608f40-2da1-4b06-9101-08dc0e2de2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hG7Zr+TKh7r9hlSvZG5Bbkz/bWolJ/ZguW7+ngleBXKaLEgUftiWlAOPoleQsdcVmMPHRXJ4uWq6wuMuqln3iq6v0eJq0TjKQrdzPJz+e/65egFh1cQPKuBltFwbTlq/+cNwBBTnkIL4iF/UoqeMCeNWtsQxRq+e2hENLvoXPy94ZWD60hz1SAscLSj8PQHQ2jAtnNk4bAJc5QItiZZuDsts1Yin+mVDMxOFqSa5NYhsRbMY0w6goMnpNH+J9RxafY/hlPJQmf3jW9mDbwiy67jSZBJVpiBnQgmoP1Pihr06JRNtRR95VQnhFHXJCtteUrCIsBjINkdpKP/Kta74p40DtK3xnl6/r+zny+MOqC8eSw2omVKYmkdBic6fxmvtMof7Tk5iCso4SatLtnN7u9RgD05yFrc5aQGs71WvCM7Ve2d1db4GpwKSjwihA/ORXAYW+IHP+ygNn7ssl6UxiMulfbLrFt+5Bb5t6cDZZUXj51Cg19E0zNAG+5L1V9fiO2gVwPi03gfCbL/kPfBfkJHZTLRtu6CTVYqjIAJsDjjK1y1yhKGNUYpNqVaLkX2xvKrW5DPM+i6BpZpB02l/RwZ7jjkHTkXs9yFo1kqTZzo7yAt1nOOmw72f0XTIkhYfnFXfr8J3HfbEMYaRN9Y3nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB1388.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(107886003)(2616005)(53546011)(6506007)(6512007)(26005)(41300700001)(6486002)(31696002)(86362001)(4326008)(316002)(8676002)(8936002)(110136005)(4744005)(5660300002)(4001150100001)(2906002)(44832011)(36756003)(66946007)(66556008)(66476007)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWpSUjEzSUpYQ0pNZDBOdUZ5akR0ZXVvbVNFOHZ0U1c5dFJCV0R2UHpJNmFm?=
 =?utf-8?B?RXE5bldqRmg2d3VwM3dDSFBzWkNYMExtM3VxVjQ1dlVxTi9oaC9TTjByV0tG?=
 =?utf-8?B?U1RPMTBlM28rajg5bEoxKzdJRlNSZW1iUnZSVTh5UEprNDUrdFBkdFFDa2JZ?=
 =?utf-8?B?T3F6TmRab1N1VS9OSGU3M2FwaVRHbXBMZFFSL0Y4RW5PZFBGMFRVWENIN2Nu?=
 =?utf-8?B?UjVGTkdKbkJiOFFUSkc1UDRIakxYNFpqSjhESVNEaHRiWUxjc1pYSTJZQXZI?=
 =?utf-8?B?VDBJK1k2Nk90MC80UGpSZ0ZwWndGWlFWWU9hQUhUUTRKQWFCOEVmYlVEN0Vz?=
 =?utf-8?B?RU5wMVVOeUREQTZadnBFeVlnTE5TdkxxcGZaOVFXeHZkK2hVVi9FSjhsZW9h?=
 =?utf-8?B?SnN0czNOUUJ2SElEQTdYaklXcERhRnFPWC9ROWIxZWUyVkZEdUJEQStGRzdF?=
 =?utf-8?B?NGcxMFlmR3c4eTQ5TUNoUXpLQ0gyTURNcWN6eGRwRkdHRlF2SFZHZFhBVG52?=
 =?utf-8?B?QWtHY1ZTTS84REpsRTIyWjJkdTRrRjlXejVJMnhIeWdvTnRaNE1FVGZRL2gr?=
 =?utf-8?B?TFJSNitsc3A3RStoOTdFSU9iRGJkZUtiSDBoY3ZNT3hjK1dJbjdrMUdmTUJ3?=
 =?utf-8?B?bGtjNEszSnJja3NsS3dHazE2KytKRDdYUnFZYVpXR3lvUk4vVHJsWWVZT2VZ?=
 =?utf-8?B?d1ZqNkU4OXYwUDdjOCtYL3g0UHNaSjVqSlpNUmU2TXQvZmhPcVI3dzRVMm4y?=
 =?utf-8?B?Slc0NWRFUjJVMkdPcCtlQkUwNmh0NmVQNXJqSnFZVG5tek5kY0tya0ZkTFNp?=
 =?utf-8?B?WUtEb011YnY3bE15QTAyWmtmUHBLQWdZN0p4c0g5TDlhQzJxZFNJNjdaTG5Q?=
 =?utf-8?B?WXUrWmZjWUo3RzFVSitSWXdpeHdjWnVCTE56QlJVSXcyNTZjeG9xVjNVNEho?=
 =?utf-8?B?ZlhMN0lqSzc0ZDBCdUxVd2NlSURKa0VSSXg4MkhGekZFd1hLUWh2cEh5TUx1?=
 =?utf-8?B?b2tnZTVQaFpzOHFLUllrUUI0ZHNzb1ZtMEhBUnVnT1ZGdUJ6QnZDd0FpQkw4?=
 =?utf-8?B?RDFRUC9SV3ptS09aQTRiSUlRcGVSVDViMXZ6QTQzMzR6SHQ0WnVBN01LRGpL?=
 =?utf-8?B?eUtPcUdUcHRrN0hDUFFPd205RXlzRmZ6Yk00bjZQY0RxVnBseEkwRHFTVHFj?=
 =?utf-8?B?QUp1RyswekU1QVJMWGl2Y0JnZXhySVJ0eHBLYVREajduck16bkVLb3pQL1Zy?=
 =?utf-8?B?UWJQZmVxRnhHWUI0eGlvUytiQnk2QUxmUG9vMHdreUZCQTBPa0RVUmRwS0Qz?=
 =?utf-8?B?U004ZDFLM0JQem1oaGRWQVFGS25UM2wyUWJTMWZXbW5JREptZ2Q4UngwU05G?=
 =?utf-8?B?eUR1bFpkR2dYU2VxaTI3TnFoWHE4ck5lUGFaWjVFQzJPZ2xsSmtvM0tCdVlp?=
 =?utf-8?B?MWlpaCtvTGtnd1hpcWgwWHdvbnF1S09XOEhtYzY2MktNUGJZamE2anNTWVFC?=
 =?utf-8?B?QnpVR2hKN0Q4Mm4vbkVlNDM1NTZENTBKdVlTNTVBUGVQSGtTN2ZzSndkY1Bp?=
 =?utf-8?B?LzdYMnJtVmJjSGFpT1owSjlQUzEzQzdDT2xVUWNYMlMwZ2pjTFlBNURQWWJ1?=
 =?utf-8?B?UnErME95STdwZnR0czZCcEVnSVNyTWVJUUNGTk5VdHRJdUJxc1o1ZmkwYnNa?=
 =?utf-8?B?Mk1EU0E0ZTZNNG5RQ1pLM20wNlF6SVg5bFlUcnY5WDk4VU0rM1NSd0FIV1ZN?=
 =?utf-8?B?MTB1cnNmZDQ3czUzUlBKUDFDZFh6MnZCNWZ0c0pzay83TlJrLzMzVTVVRGFj?=
 =?utf-8?B?b1o3aFNKcldNQ1NqM0szaHNlc3doV01zREwzZytDUFBnYVF1TzVIZ0c2OU9M?=
 =?utf-8?B?NWs4aU5qRjEzRUx6NVVuQytuRUl0WklneUJGb3lJeVlERjFmUGZJeUxEdTIw?=
 =?utf-8?B?akFOZ2tUaE4xbmlsUEQ4VWNzcmFtOEE2bC9VLysxeFd4WGNqS1hUVk1XaTZK?=
 =?utf-8?B?U0ZQMXdaSjF2V29rQUYyOWNNbDkvSU1kV0QxQ250cjlyOTJpUzUzUjRDYzc4?=
 =?utf-8?B?WmVUSU1tU3E4SUZZQzdHQ3ZuM1lxb3lDNENIblRwT3p4aG5kQytpdDgxNzNX?=
 =?utf-8?Q?T6lWXOJLWuQwE3KT+nP1PRpkz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72608f40-2da1-4b06-9101-08dc0e2de2cf
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1388.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 20:35:42.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOtfOqxKcH2V0ZtSGfqkoa3WXzLcGpBTW1cXz94HR4iqsj7rw3djMq0i4txacPTbg52BLpjpL98wY0K5kiRwIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0902
X-OrganizationHeadersPreserved: AM9P192MB0902.EURP192.PROD.OUTLOOK.COM
X-CrossPremisesHeadersPromoted: EX01GLOBAL.beijerelectronics.com
X-CrossPremisesHeadersFiltered: EX01GLOBAL.beijerelectronics.com
X-OriginatorOrg: westermo.com
X-Proofpoint-GUID: tBZUidp8DsS0TpxJWAtYGHecojnTvp-0
X-Proofpoint-ORIG-GUID: tBZUidp8DsS0TpxJWAtYGHecojnTvp-0

On 31/12/2023 22:59, Johannes Berg wrote:
> On Thu, 2023-12-21 at 22:29 +0000, Matthias May wrote:
>> nl_band->nla_type might have NLA_F_NESTED (0x8000) set,
> I'm curious - how does that happen?
>
> Not that the change looks wrong per se, but ... I don't think this can
> happen?
>
> johannes
>
Hi Johannes

We saw that happen on one of our platforms where we are forced to use an 
out-of-tree driver by QCA (SPF12.2).
If you think this is something that can not happen with upstream 
drivers, feel free to ignore this patch.

BR
Matthias


