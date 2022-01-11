Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A2C48B363
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 18:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbiAKRQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 12:16:48 -0500
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:39233
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240026AbiAKRQC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 12:16:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzOSCTFu+1puLNK0J2uIEtrvktuYe0MeECe2kfiJuQJlW3nOkV5ap16dInvg61UnSsFmwcPqzwLYQYf+luJgaBb8CPi8JHD5/ZQ3NE+5umfMHbhoxyqSCRIGXn+/mSyBXZj/FIMYice78TL3BkZBKOG7mQdwofnygUmCiPwiHsCce+OzM5ac/msznobAkLLrZPswZLgUBS6LRkqFFGuhAgqGwkrHgjbqPR99xic5baonrG6ZnItIqSSvzmBwCXtJ18pGHzKVkuKyXxYcctYKDF9RwJ2CFwXttNa7eizfU1nfIMywvwVaxiYzSiEM5CP8aM+vEdP4FHuD/odM+bCR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B9o9LpLBOM8DiiwWYOHksQDZ7PKy4BMdRm2lgbWfZ0=;
 b=b9aCZxdKCDXBVPBBvMYuexsHHIiYYeB6D7z2O7nrD+Fl1HQ0KuGZkIqm72BtTmLbV2Rjjk0HYHLjKDfDCG1I5H0rr7QirA7AbbTzSHqciiWwkrNVKC/N4qUJ8DATZzjT3mWP9Swej7FXPl74jKjtwx3rIUxqRClop+p1obMkMR6fEHxQ9KH/d78r/KXZNnOjYhDPtSMlcN1KH4oYgL8EzUnQq0eUvvc2VJp6O5137ekNjIN/DGIXLZspt7AZdUkkoKG75zshbQTUJ7V9ohjk45uwqstFxb0Igu4z+5PRRUTtTkVrkBCYiBhwvAp1+xSPZe7JUCFq8GIAAxMb8PyvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B9o9LpLBOM8DiiwWYOHksQDZ7PKy4BMdRm2lgbWfZ0=;
 b=fC+jvvDlJfiex8ZGdVYLoEn3Z2JRaeZRlNbswfSWJ1d3BDAW74skWga3RuPzzEIfbIsAZjEJsPKr6FIr4qSTFFCQCiuiots0KBD97Ut+KRp8x3SbgdhsaIHyICISPioESaY6QJcQIINa1+KFZ+wAevSYwLlMqObAn15+Qp8MjyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 17:15:33 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:15:33 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v9 18/24] wfx: add data_tx.c/data_tx.h
Date:   Tue, 11 Jan 2022 18:14:18 +0100
Message-Id: <20220111171424.862764-19-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
References: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b10a0a0-6f15-4e3b-c0d6-08d9d525f9c7
X-MS-TrafficTypeDiagnostic: PH0PR11MB5657:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB56577144DBC191473A1AFE3293519@PH0PR11MB5657.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bF5jULtywjaNqn31fx8HcfUQGtmUNvu5eL9TByh6HRJ0ZK2E+fnDDQPDSgtjUTd4EMHeHqMfdkY5+w0ROdyu89T4D65ZgEiZMsTpuf2dVod1367FBJZpc/8MDjGd5O/APhvz+y8sAwSR/OVfWFxAoJSYtds0sR4DpTmamazs8CA+p9WM7NJLcZCAUUuqGOuVTk7URwhq69k6vqwQ2jn4s64oPPQb0mVV3K32pD8G9IdgrhO/4/uSNbKoP38vVZzEHSp2L7yCXTqhAyCDUfrukCq/JbGG9vjzVNIiGHOd1ZpOm1ojmY3wExelvDkLKNWBPgBBSpgkLaoAMJgzZinahRJrUCquFRDHOLH5SaXI8QRn5nrJ6xFs6YvNmsmzpJaRjRKSz+rqxKrjJokfFHYgyR117s+L1iA3u3KgotZc8QbyCen978teiF0JHlAIzJkndb6tQogdN1Xt78Co85pOkuYFBWuNJUo7x1fVfQ32lFAr7XbpsTDUzOnLswNILV2TngaDgceWlC/0menRvvdetHpUy4tYImrN8ckcHSmSDKHB2WkibF0Vwues0dEbyToHcYoaa+ZMwoh+La5THqZ1rcN5wI5Y7ovmXW2pbyOYVvH5g+nq548sD4jhZp74SiSnyaTR1glx/VSm+hPLU5zQZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66574015)(86362001)(5660300002)(8936002)(7416002)(6916009)(8676002)(83380400001)(1076003)(6486002)(36756003)(38100700002)(186003)(66946007)(6666004)(2616005)(4326008)(2906002)(316002)(107886003)(66556008)(66476007)(54906003)(6512007)(508600001)(30864003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFUK3FONFNnWjZPWklZSVI4Zm9NNDJHaUZFTkRmK1B4cURwaUw4bnd4Q0tk?=
 =?utf-8?B?TVpzbFkxcHhzS08reldxSmE4aWorcXFVUXZ6SWh2VGNvWlJhQVovRldqTXZm?=
 =?utf-8?B?Wms1QitvSElsSkNkZGtBQWNud3ZWcmJqSXdJRkt2T2Y5ZUpMVU4yRGxoOHFw?=
 =?utf-8?B?WjBzWEhqUVRCNzR6anRnQVBudmd2OTJVaHozUm5ERW1BQlZSR0FjSHVZamJ6?=
 =?utf-8?B?ZzdYdTNQN2xXTmVpNUhHVlRreDNYbk5UQi9VWmRqY0NlMmU1NldRWDg5dzRz?=
 =?utf-8?B?S2dUVEY2bi9IQjlMS3BTMmV1WmhVbE5pcGRNZmlXMGF1akRDczlhZzZ3REJl?=
 =?utf-8?B?UEVHZmlYdWsxU0RTL2llQ1JmZU1iRDg2aXFza0xjTGJlbmxjSE5yTWtzb3J2?=
 =?utf-8?B?eWxZSlRVN1NSR2t5OHBOTStHOUhCNlpWYjhnNU4xc1NDRjh5dDZkMnJEbXRK?=
 =?utf-8?B?bXpoa3haTmFYaUJ4N0JBSjFud082bzU2aC9SWCtieTNlSjM0dU8xS1hibEt6?=
 =?utf-8?B?V1pzSEFOTUEwUGI5MVJ2cU1yM2RIRDliOHpjL1BNbkNCeHhpUU90NExhZVFw?=
 =?utf-8?B?TEJUWEdvejNvbzQrSDJlbHk1anlxaDdWTXc4RExqTnNCTHB4RERlSVd5d3p0?=
 =?utf-8?B?ZWd2OSsra3k5ODdaTWtWQUNtcFlVNkNQQXFubHJkbVFtMFdMQVVnTWNESVd6?=
 =?utf-8?B?blVWQzhTRXh2NCt6T2FXUk1kdytNak15MDVRd2FGeUZEQThhNXJXcmhndlJr?=
 =?utf-8?B?SDlyKzhTYU9pVlQyZFJpWU0raUdDMmpIMXNOUWVhNU1nWHlpOGhzRkJmbTNL?=
 =?utf-8?B?c1ExRkVYS3RjQTF0alFnNHZ1czBQR3l1dGlnandWQk40OTJIcXpQL1VrNVEx?=
 =?utf-8?B?MFJjdG5PRTR6U1dUelJuZTF2WEdqUXhLWVM1ZlBnZXBmbFdiT3RxK0RYRVdC?=
 =?utf-8?B?cnA4SHRwL2dJS2tmbWE3MjdDelJqTEU1Z3pmdmZmQVlhbXJhV24xckRPZldX?=
 =?utf-8?B?cmZCY3B0OTFvTjcwcThtOFJiN0xhOE5lY011eng4WVdFMStVamxodlh2UytH?=
 =?utf-8?B?NTBoWDl2Q1lrQ2FlVXk2a0pkOGZOaVE4R2VVUlhOQ3NndDVVeVVQajRmcktn?=
 =?utf-8?B?SklrMFBnZllDUnJGWjdDYW1pdU15WlhsazNNaFRqWDAzU0FkZG03eStzYnVQ?=
 =?utf-8?B?U3Axcmp3SXMxVWIwRzBCUTZseDBrSVNaZmtuU1FwVXlHcCtKWWJvKzA1YUth?=
 =?utf-8?B?TytUUE1xZmdLcEpzME1FTmRaZjNhQVZweEdqNGNHNEp6YWxHMXIxckMyMXps?=
 =?utf-8?B?ZWYvWjJJdE4vRmE4VWtpdzRMeENTZ1ZqQm1PMnJoOEVFQmpXa0MxZUQxTHNq?=
 =?utf-8?B?NUtCdXJXaHNXS0JyczEzRTRYS0NjeE4xZjhTa3paTk9qVUJmbHA0cktvU0t1?=
 =?utf-8?B?OE12VVgzb0VTUytPR1Q3dWV1UXRha2ZMSWt1VUVlVk03NSthSGV5dTNTWWQw?=
 =?utf-8?B?L2srbnloYmJCK2RYWFVrdTd4c1FBa1l2RGZHN0hCZm5IM0RCbjNsazIwTzYw?=
 =?utf-8?B?VXk1ZEdNNkR2UnJmYmNRMXV3aXBhMFYxTUp6R2oyY2hHOVNRWGd4SUdWRS9x?=
 =?utf-8?B?TEUySVo4T1hFTG5XeGxVUFRKRC8rK1B2SmlQUVp4cVNKTmZyR2JERVFjejNR?=
 =?utf-8?B?aUwxcDd2c1JkRjl4Z0QwL3gwK0VKaEMyVnFWNENKbFVQa2hVeXZLaE5yT1FQ?=
 =?utf-8?B?dUhNT0x4aDdRQ3dGbERTMGlxSHlVcDcwT0xmUGVqN0NqTUFmM0txM2hTeEl4?=
 =?utf-8?B?dGh5UjBZRmdXYmR3OUhDQmQvSFdkK3lpK1RWc2U1TUlpZ2t6dGxjSVdmRkMr?=
 =?utf-8?B?MVY3MVdEbmZaN2F2TGN3Q0tJQXhhdE5tQVVMNUJaSUROL3BOMkdxdEpROHZ0?=
 =?utf-8?B?TmFDby9BQlgvYS9nY0JIektrR25TNlRVbG13QzlVeitVZzB3TG9UZ1NXWjBn?=
 =?utf-8?B?cG5kbTBUbmRyRUV1TUhHQWRxREU4SHdnaytJVHN2bVNoa012M2hIN2JqMWkz?=
 =?utf-8?B?ZGJpdktXREpZWFhXZlFldUZsR05UWEc4MEFKU2o1R2NWTVRwY2JsUG9sK2RL?=
 =?utf-8?B?ZHR6UWJsb2hrM3FtMHVnaVdNYmRhVkp2NVRrblRrWit3ZVc3YlJhMG0vU0Ns?=
 =?utf-8?B?VG9mQ1phcmZCTHR2eDZqVzhwRDNOclpoWDVxdmplWUhYZUJCdEsxaWpSdTZY?=
 =?utf-8?Q?hEMuXJpPXpNnn9SL722HoExuAcAIXHQy+goXRbkC7M=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b10a0a0-6f15-4e3b-c0d6-08d9d525f9c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:15:33.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUbbF7MSFJXzvlWvSjNMN78wVxoStrbkTZCT2GAk+1c+CNBZmJlWQ/Y2V2PIdLxei0J8dUilNA4K+AAXvElx7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5657
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0YV90eC5jIHwgNTcyICsr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0
YV90eC5oIHwgIDY2ICsrKwogMiBmaWxlcyBjaGFuZ2VkLCA2MzggaW5zZXJ0aW9ucygrKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0YV90eC5j
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRh
X3R4LmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFf
dHguYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0YV90eC5jCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uZDdiY2YzYmFlMDhhCi0tLSAvZGV2L251
bGwKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRhX3R4LmMKQEAgLTAs
MCArMSw1NzIgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8q
CisgKiBEYXRhIHRyYW5zbWl0dGluZyBpbXBsZW1lbnRhdGlvbi4KKyAqCisgKiBDb3B5cmlnaHQg
KGMpIDIwMTctMjAyMCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4KKyAqIENvcHlyaWdodCAo
YykgMjAxMCwgU1QtRXJpY3Nzb24KKyAqLworI2luY2x1ZGUgPG5ldC9tYWM4MDIxMS5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNlLmg+CisKKyNpbmNsdWRlICJkYXRhX3R4LmgiCisjaW5j
bHVkZSAid2Z4LmgiCisjaW5jbHVkZSAiYmguaCIKKyNpbmNsdWRlICJzdGEuaCIKKyNpbmNsdWRl
ICJxdWV1ZS5oIgorI2luY2x1ZGUgImRlYnVnLmgiCisjaW5jbHVkZSAidHJhY2VzLmgiCisjaW5j
bHVkZSAiaGlmX3R4X21pYi5oIgorCitzdGF0aWMgaW50IHdmeF9nZXRfaHdfcmF0ZShzdHJ1Y3Qg
d2Z4X2RldiAqd2RldiwgY29uc3Qgc3RydWN0IGllZWU4MDIxMV90eF9yYXRlICpyYXRlKQorewor
CXN0cnVjdCBpZWVlODAyMTFfc3VwcG9ydGVkX2JhbmQgKmJhbmQ7CisKKwlpZiAocmF0ZS0+aWR4
IDwgMCkKKwkJcmV0dXJuIC0xOworCWlmIChyYXRlLT5mbGFncyAmIElFRUU4MDIxMV9UWF9SQ19N
Q1MpIHsKKwkJaWYgKHJhdGUtPmlkeCA+IDcpIHsKKwkJCVdBUk4oMSwgIndyb25nIHJhdGUtPmlk
eCB2YWx1ZTogJWQiLCByYXRlLT5pZHgpOworCQkJcmV0dXJuIC0xOworCQl9CisJCXJldHVybiBy
YXRlLT5pZHggKyAxNDsKKwl9CisJLyogVGhlIGRldmljZSBvbmx5IHN1cHBvcnQgMkdIeiwgZWxz
ZSBiYW5kIGluZm9ybWF0aW9uIHNob3VsZCBiZSByZXRyaWV2ZWQgZnJvbQorCSAqIGllZWU4MDIx
MV90eF9pbmZvCisJICovCisJYmFuZCA9IHdkZXYtPmh3LT53aXBoeS0+YmFuZHNbTkw4MDIxMV9C
QU5EXzJHSFpdOworCWlmIChyYXRlLT5pZHggPj0gYmFuZC0+bl9iaXRyYXRlcykgeworCQlXQVJO
KDEsICJ3cm9uZyByYXRlLT5pZHggdmFsdWU6ICVkIiwgcmF0ZS0+aWR4KTsKKwkJcmV0dXJuIC0x
OworCX0KKwlyZXR1cm4gYmFuZC0+Yml0cmF0ZXNbcmF0ZS0+aWR4XS5od192YWx1ZTsKK30KKwor
LyogVFggcG9saWN5IGNhY2hlIGltcGxlbWVudGF0aW9uICovCisKK3N0YXRpYyB2b2lkIHdmeF90
eF9wb2xpY3lfYnVpbGQoc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCB3ZnhfdHhfcG9saWN5
ICpwb2xpY3ksCisJCQkJc3RydWN0IGllZWU4MDIxMV90eF9yYXRlICpyYXRlcykKK3sKKwlzdHJ1
Y3Qgd2Z4X2RldiAqd2RldiA9IHd2aWYtPndkZXY7CisJaW50IGksIHJhdGVpZDsKKwl1OCBjb3Vu
dDsKKworCVdBUk4ocmF0ZXNbMF0uaWR4IDwgMCwgImludmFsaWQgcmF0ZSBwb2xpY3kiKTsKKwlt
ZW1zZXQocG9saWN5LCAwLCBzaXplb2YoKnBvbGljeSkpOworCWZvciAoaSA9IDA7IGkgPCBJRUVF
ODAyMTFfVFhfTUFYX1JBVEVTOyArK2kpIHsKKwkJaWYgKHJhdGVzW2ldLmlkeCA8IDApCisJCQli
cmVhazsKKwkJV0FSTl9PTihyYXRlc1tpXS5jb3VudCA+IDE1KTsKKwkJcmF0ZWlkID0gd2Z4X2dl
dF9od19yYXRlKHdkZXYsICZyYXRlc1tpXSk7CisJCS8qIFBhY2sgdHdvIHZhbHVlcyBpbiBlYWNo
IGJ5dGUgb2YgcG9saWN5LT5yYXRlcyAqLworCQljb3VudCA9IHJhdGVzW2ldLmNvdW50OworCQlp
ZiAocmF0ZWlkICUgMikKKwkJCWNvdW50IDw8PSA0OworCQlwb2xpY3ktPnJhdGVzW3JhdGVpZCAv
IDJdIHw9IGNvdW50OworCX0KK30KKworc3RhdGljIGJvb2wgd2Z4X3R4X3BvbGljeV9pc19lcXVh
bChjb25zdCBzdHJ1Y3Qgd2Z4X3R4X3BvbGljeSAqYSwgY29uc3Qgc3RydWN0IHdmeF90eF9wb2xp
Y3kgKmIpCit7CisJcmV0dXJuICFtZW1jbXAoYS0+cmF0ZXMsIGItPnJhdGVzLCBzaXplb2YoYS0+
cmF0ZXMpKTsKK30KKworc3RhdGljIGludCB3ZnhfdHhfcG9saWN5X2ZpbmQoc3RydWN0IHdmeF90
eF9wb2xpY3lfY2FjaGUgKmNhY2hlLCBzdHJ1Y3Qgd2Z4X3R4X3BvbGljeSAqd2FudGVkKQorewor
CXN0cnVjdCB3ZnhfdHhfcG9saWN5ICppdDsKKworCWxpc3RfZm9yX2VhY2hfZW50cnkoaXQsICZj
YWNoZS0+dXNlZCwgbGluaykKKwkJaWYgKHdmeF90eF9wb2xpY3lfaXNfZXF1YWwod2FudGVkLCBp
dCkpCisJCQlyZXR1cm4gaXQgLSBjYWNoZS0+Y2FjaGU7CisJbGlzdF9mb3JfZWFjaF9lbnRyeShp
dCwgJmNhY2hlLT5mcmVlLCBsaW5rKQorCQlpZiAod2Z4X3R4X3BvbGljeV9pc19lcXVhbCh3YW50
ZWQsIGl0KSkKKwkJCXJldHVybiBpdCAtIGNhY2hlLT5jYWNoZTsKKwlyZXR1cm4gLTE7Cit9CisK
K3N0YXRpYyB2b2lkIHdmeF90eF9wb2xpY3lfdXNlKHN0cnVjdCB3ZnhfdHhfcG9saWN5X2NhY2hl
ICpjYWNoZSwgc3RydWN0IHdmeF90eF9wb2xpY3kgKmVudHJ5KQoreworCSsrZW50cnktPnVzYWdl
X2NvdW50OworCWxpc3RfbW92ZSgmZW50cnktPmxpbmssICZjYWNoZS0+dXNlZCk7Cit9CisKK3N0
YXRpYyBpbnQgd2Z4X3R4X3BvbGljeV9yZWxlYXNlKHN0cnVjdCB3ZnhfdHhfcG9saWN5X2NhY2hl
ICpjYWNoZSwgc3RydWN0IHdmeF90eF9wb2xpY3kgKmVudHJ5KQoreworCWludCByZXQgPSAtLWVu
dHJ5LT51c2FnZV9jb3VudDsKKworCWlmICghcmV0KQorCQlsaXN0X21vdmUoJmVudHJ5LT5saW5r
LCAmY2FjaGUtPmZyZWUpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgd2Z4X3R4X3Bv
bGljeV9nZXQoc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBpZWVlODAyMTFfdHhfcmF0ZSAq
cmF0ZXMsIGJvb2wgKnJlbmV3KQoreworCWludCBpZHg7CisJc3RydWN0IHdmeF90eF9wb2xpY3lf
Y2FjaGUgKmNhY2hlID0gJnd2aWYtPnR4X3BvbGljeV9jYWNoZTsKKwlzdHJ1Y3Qgd2Z4X3R4X3Bv
bGljeSB3YW50ZWQ7CisJc3RydWN0IHdmeF90eF9wb2xpY3kgKmVudHJ5OworCisJd2Z4X3R4X3Bv
bGljeV9idWlsZCh3dmlmLCAmd2FudGVkLCByYXRlcyk7CisKKwlzcGluX2xvY2tfYmgoJmNhY2hl
LT5sb2NrKTsKKwlpZiAobGlzdF9lbXB0eSgmY2FjaGUtPmZyZWUpKSB7CisJCVdBUk4oMSwgInVu
YWJsZSB0byBnZXQgYSB2YWxpZCBUeCBwb2xpY3kiKTsKKwkJc3Bpbl91bmxvY2tfYmgoJmNhY2hl
LT5sb2NrKTsKKwkJcmV0dXJuIEhJRl9UWF9SRVRSWV9QT0xJQ1lfSU5WQUxJRDsKKwl9CisJaWR4
ID0gd2Z4X3R4X3BvbGljeV9maW5kKGNhY2hlLCAmd2FudGVkKTsKKwlpZiAoaWR4ID49IDApIHsK
KwkJKnJlbmV3ID0gZmFsc2U7CisJfSBlbHNlIHsKKwkJLyogSWYgcG9saWN5IGlzIG5vdCBmb3Vu
ZCBjcmVhdGUgYSBuZXcgb25lIHVzaW5nIHRoZSBvbGRlc3QKKwkJICogZW50cnkgaW4gImZyZWUi
IGxpc3QKKwkJICovCisJCSpyZW5ldyA9IHRydWU7CisJCWVudHJ5ID0gbGlzdF9lbnRyeShjYWNo
ZS0+ZnJlZS5wcmV2LCBzdHJ1Y3Qgd2Z4X3R4X3BvbGljeSwgbGluayk7CisJCW1lbWNweShlbnRy
eS0+cmF0ZXMsIHdhbnRlZC5yYXRlcywgc2l6ZW9mKGVudHJ5LT5yYXRlcykpOworCQllbnRyeS0+
dXBsb2FkZWQgPSBmYWxzZTsKKwkJZW50cnktPnVzYWdlX2NvdW50ID0gMDsKKwkJaWR4ID0gZW50
cnkgLSBjYWNoZS0+Y2FjaGU7CisJfQorCXdmeF90eF9wb2xpY3lfdXNlKGNhY2hlLCAmY2FjaGUt
PmNhY2hlW2lkeF0pOworCWlmIChsaXN0X2VtcHR5KCZjYWNoZS0+ZnJlZSkpCisJCWllZWU4MDIx
MV9zdG9wX3F1ZXVlcyh3dmlmLT53ZGV2LT5odyk7CisJc3Bpbl91bmxvY2tfYmgoJmNhY2hlLT5s
b2NrKTsKKwlyZXR1cm4gaWR4OworfQorCitzdGF0aWMgdm9pZCB3ZnhfdHhfcG9saWN5X3B1dChz
dHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgaW50IGlkeCkKK3sKKwlpbnQgdXNhZ2UsIGxvY2tlZDsKKwlz
dHJ1Y3Qgd2Z4X3R4X3BvbGljeV9jYWNoZSAqY2FjaGUgPSAmd3ZpZi0+dHhfcG9saWN5X2NhY2hl
OworCisJaWYgKGlkeCA9PSBISUZfVFhfUkVUUllfUE9MSUNZX0lOVkFMSUQpCisJCXJldHVybjsK
KwlzcGluX2xvY2tfYmgoJmNhY2hlLT5sb2NrKTsKKwlsb2NrZWQgPSBsaXN0X2VtcHR5KCZjYWNo
ZS0+ZnJlZSk7CisJdXNhZ2UgPSB3ZnhfdHhfcG9saWN5X3JlbGVhc2UoY2FjaGUsICZjYWNoZS0+
Y2FjaGVbaWR4XSk7CisJaWYgKGxvY2tlZCAmJiAhdXNhZ2UpCisJCWllZWU4MDIxMV93YWtlX3F1
ZXVlcyh3dmlmLT53ZGV2LT5odyk7CisJc3Bpbl91bmxvY2tfYmgoJmNhY2hlLT5sb2NrKTsKK30K
Kworc3RhdGljIGludCB3ZnhfdHhfcG9saWN5X3VwbG9hZChzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZikK
K3sKKwlzdHJ1Y3Qgd2Z4X3R4X3BvbGljeSAqcG9saWNpZXMgPSB3dmlmLT50eF9wb2xpY3lfY2Fj
aGUuY2FjaGU7CisJdTggdG1wX3JhdGVzWzEyXTsKKwlpbnQgaSwgaXNfdXNlZDsKKworCWRvIHsK
KwkJc3Bpbl9sb2NrX2JoKCZ3dmlmLT50eF9wb2xpY3lfY2FjaGUubG9jayk7CisJCWZvciAoaSA9
IDA7IGkgPCBBUlJBWV9TSVpFKHd2aWYtPnR4X3BvbGljeV9jYWNoZS5jYWNoZSk7ICsraSkgewor
CQkJaXNfdXNlZCA9IG1lbXpjbXAocG9saWNpZXNbaV0ucmF0ZXMsIHNpemVvZihwb2xpY2llc1tp
XS5yYXRlcykpOworCQkJaWYgKCFwb2xpY2llc1tpXS51cGxvYWRlZCAmJiBpc191c2VkKQorCQkJ
CWJyZWFrOworCQl9CisJCWlmIChpIDwgQVJSQVlfU0laRSh3dmlmLT50eF9wb2xpY3lfY2FjaGUu
Y2FjaGUpKSB7CisJCQlwb2xpY2llc1tpXS51cGxvYWRlZCA9IHRydWU7CisJCQltZW1jcHkodG1w
X3JhdGVzLCBwb2xpY2llc1tpXS5yYXRlcywgc2l6ZW9mKHRtcF9yYXRlcykpOworCQkJc3Bpbl91
bmxvY2tfYmgoJnd2aWYtPnR4X3BvbGljeV9jYWNoZS5sb2NrKTsKKwkJCXdmeF9oaWZfc2V0X3R4
X3JhdGVfcmV0cnlfcG9saWN5KHd2aWYsIGksIHRtcF9yYXRlcyk7CisJCX0gZWxzZSB7CisJCQlz
cGluX3VubG9ja19iaCgmd3ZpZi0+dHhfcG9saWN5X2NhY2hlLmxvY2spOworCQl9CisJfSB3aGls
ZSAoaSA8IEFSUkFZX1NJWkUod3ZpZi0+dHhfcG9saWN5X2NhY2hlLmNhY2hlKSk7CisJcmV0dXJu
IDA7Cit9CisKK3ZvaWQgd2Z4X3R4X3BvbGljeV91cGxvYWRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspCit7CisJc3RydWN0IHdmeF92aWYgKnd2aWYgPSBjb250YWluZXJfb2Yod29yaywg
c3RydWN0IHdmeF92aWYsIHR4X3BvbGljeV91cGxvYWRfd29yayk7CisKKwl3ZnhfdHhfcG9saWN5
X3VwbG9hZCh3dmlmKTsKKwl3ZnhfdHhfdW5sb2NrKHd2aWYtPndkZXYpOworfQorCit2b2lkIHdm
eF90eF9wb2xpY3lfaW5pdChzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZikKK3sKKwlzdHJ1Y3Qgd2Z4X3R4
X3BvbGljeV9jYWNoZSAqY2FjaGUgPSAmd3ZpZi0+dHhfcG9saWN5X2NhY2hlOworCWludCBpOwor
CisJbWVtc2V0KGNhY2hlLCAwLCBzaXplb2YoKmNhY2hlKSk7CisKKwlzcGluX2xvY2tfaW5pdCgm
Y2FjaGUtPmxvY2spOworCUlOSVRfTElTVF9IRUFEKCZjYWNoZS0+dXNlZCk7CisJSU5JVF9MSVNU
X0hFQUQoJmNhY2hlLT5mcmVlKTsKKworCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNhY2hl
LT5jYWNoZSk7ICsraSkKKwkJbGlzdF9hZGQoJmNhY2hlLT5jYWNoZVtpXS5saW5rLCAmY2FjaGUt
PmZyZWUpOworfQorCisvKiBUeCBpbXBsZW1lbnRhdGlvbiAqLworCitzdGF0aWMgYm9vbCB3Znhf
aXNfYWN0aW9uX2JhY2soc3RydWN0IGllZWU4MDIxMV9oZHIgKmhkcikKK3sKKwlzdHJ1Y3QgaWVl
ZTgwMjExX21nbXQgKm1nbXQgPSAoc3RydWN0IGllZWU4MDIxMV9tZ210ICopaGRyOworCisJaWYg
KCFpZWVlODAyMTFfaXNfYWN0aW9uKG1nbXQtPmZyYW1lX2NvbnRyb2wpKQorCQlyZXR1cm4gZmFs
c2U7CisJaWYgKG1nbXQtPnUuYWN0aW9uLmNhdGVnb3J5ICE9IFdMQU5fQ0FURUdPUllfQkFDSykK
KwkJcmV0dXJuIGZhbHNlOworCXJldHVybiB0cnVlOworfQorCitzdGF0aWMgdTggd2Z4X3R4X2dl
dF9saW5rX2lkKHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3Rh
LAorCQkJICAgICBzdHJ1Y3QgaWVlZTgwMjExX2hkciAqaGRyKQoreworCXN0cnVjdCB3Znhfc3Rh
X3ByaXYgKnN0YV9wcml2ID0gc3RhID8gKHN0cnVjdCB3Znhfc3RhX3ByaXYgKikmc3RhLT5kcnZf
cHJpdiA6IE5VTEw7CisJY29uc3QgdTggKmRhID0gaWVlZTgwMjExX2dldF9EQShoZHIpOworCisJ
aWYgKHN0YV9wcml2ICYmIHN0YV9wcml2LT5saW5rX2lkKQorCQlyZXR1cm4gc3RhX3ByaXYtPmxp
bmtfaWQ7CisJaWYgKHd2aWYtPnZpZi0+dHlwZSAhPSBOTDgwMjExX0lGVFlQRV9BUCkKKwkJcmV0
dXJuIDA7CisJaWYgKGlzX211bHRpY2FzdF9ldGhlcl9hZGRyKGRhKSkKKwkJcmV0dXJuIDA7CisJ
cmV0dXJuIEhJRl9MSU5LX0lEX05PVF9BU1NPQ0lBVEVEOworfQorCitzdGF0aWMgdm9pZCB3Znhf
dHhfZml4dXBfcmF0ZXMoc3RydWN0IGllZWU4MDIxMV90eF9yYXRlICpyYXRlcykKK3sKKwlpbnQg
aTsKKwlib29sIGZpbmlzaGVkOworCisJLyogRmlybXdhcmUgaXMgbm90IGFibGUgdG8gbWl4IHJh
dGVzIHdpdGggZGlmZmVyZW50IGZsYWdzICovCisJZm9yIChpID0gMDsgaSA8IElFRUU4MDIxMV9U
WF9NQVhfUkFURVM7IGkrKykgeworCQlpZiAocmF0ZXNbMF0uZmxhZ3MgJiBJRUVFODAyMTFfVFhf
UkNfU0hPUlRfR0kpCisJCQlyYXRlc1tpXS5mbGFncyB8PSBJRUVFODAyMTFfVFhfUkNfU0hPUlRf
R0k7CisJCWlmICghKHJhdGVzWzBdLmZsYWdzICYgSUVFRTgwMjExX1RYX1JDX1NIT1JUX0dJKSkK
KwkJCXJhdGVzW2ldLmZsYWdzICY9IH5JRUVFODAyMTFfVFhfUkNfU0hPUlRfR0k7CisJCWlmICgh
KHJhdGVzWzBdLmZsYWdzICYgSUVFRTgwMjExX1RYX1JDX1VTRV9SVFNfQ1RTKSkKKwkJCXJhdGVz
W2ldLmZsYWdzICY9IH5JRUVFODAyMTFfVFhfUkNfVVNFX1JUU19DVFM7CisJfQorCisJLyogU29y
dCByYXRlcyBhbmQgcmVtb3ZlIGR1cGxpY2F0ZXMgKi8KKwlkbyB7CisJCWZpbmlzaGVkID0gdHJ1
ZTsKKwkJZm9yIChpID0gMDsgaSA8IElFRUU4MDIxMV9UWF9NQVhfUkFURVMgLSAxOyBpKyspIHsK
KwkJCWlmIChyYXRlc1tpICsgMV0uaWR4ID09IHJhdGVzW2ldLmlkeCAmJgorCQkJICAgIHJhdGVz
W2ldLmlkeCAhPSAtMSkgeworCQkJCXJhdGVzW2ldLmNvdW50ICs9IHJhdGVzW2kgKyAxXS5jb3Vu
dDsKKwkJCQlpZiAocmF0ZXNbaV0uY291bnQgPiAxNSkKKwkJCQkJcmF0ZXNbaV0uY291bnQgPSAx
NTsKKwkJCQlyYXRlc1tpICsgMV0uaWR4ID0gLTE7CisJCQkJcmF0ZXNbaSArIDFdLmNvdW50ID0g
MDsKKworCQkJCWZpbmlzaGVkID0gZmFsc2U7CisJCQl9CisJCQlpZiAocmF0ZXNbaSArIDFdLmlk
eCA+IHJhdGVzW2ldLmlkeCkgeworCQkJCXN3YXAocmF0ZXNbaSArIDFdLCByYXRlc1tpXSk7CisJ
CQkJZmluaXNoZWQgPSBmYWxzZTsKKwkJCX0KKwkJfQorCX0gd2hpbGUgKCFmaW5pc2hlZCk7CisJ
LyogRW5zdXJlIHRoYXQgTUNTMCBvciAxTWJwcyBpcyBwcmVzZW50IGF0IHRoZSBlbmQgb2YgdGhl
IHJldHJ5IGxpc3QgKi8KKwlmb3IgKGkgPSAwOyBpIDwgSUVFRTgwMjExX1RYX01BWF9SQVRFUzsg
aSsrKSB7CisJCWlmIChyYXRlc1tpXS5pZHggPT0gMCkKKwkJCWJyZWFrOworCQlpZiAocmF0ZXNb
aV0uaWR4ID09IC0xKSB7CisJCQlyYXRlc1tpXS5pZHggPSAwOworCQkJcmF0ZXNbaV0uY291bnQg
PSA4OyAvKiA9PSBody0+bWF4X3JhdGVfdHJpZXMgKi8KKwkJCXJhdGVzW2ldLmZsYWdzID0gcmF0
ZXNbaSAtIDFdLmZsYWdzICYgSUVFRTgwMjExX1RYX1JDX01DUzsKKwkJCWJyZWFrOworCQl9CisJ
fQorCS8qIEFsbCByZXRyaWVzIHVzZSBsb25nIEdJICovCisJZm9yIChpID0gMTsgaSA8IElFRUU4
MDIxMV9UWF9NQVhfUkFURVM7IGkrKykKKwkJcmF0ZXNbaV0uZmxhZ3MgJj0gfklFRUU4MDIxMV9U
WF9SQ19TSE9SVF9HSTsKK30KKworc3RhdGljIHU4IHdmeF90eF9nZXRfcmV0cnlfcG9saWN5X2lk
KHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKnR4X2luZm8p
Cit7CisJYm9vbCB0eF9wb2xpY3lfcmVuZXcgPSBmYWxzZTsKKwl1OCByZXQ7CisKKwlyZXQgPSB3
ZnhfdHhfcG9saWN5X2dldCh3dmlmLCB0eF9pbmZvLT5kcml2ZXJfcmF0ZXMsICZ0eF9wb2xpY3lf
cmVuZXcpOworCWlmIChyZXQgPT0gSElGX1RYX1JFVFJZX1BPTElDWV9JTlZBTElEKQorCQlkZXZf
d2Fybih3dmlmLT53ZGV2LT5kZXYsICJ1bmFibGUgdG8gZ2V0IGEgdmFsaWQgVHggcG9saWN5Iik7
CisKKwlpZiAodHhfcG9saWN5X3JlbmV3KSB7CisJCXdmeF90eF9sb2NrKHd2aWYtPndkZXYpOwor
CQlpZiAoIXNjaGVkdWxlX3dvcmsoJnd2aWYtPnR4X3BvbGljeV91cGxvYWRfd29yaykpCisJCQl3
ZnhfdHhfdW5sb2NrKHd2aWYtPndkZXYpOworCX0KKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMg
aW50IHdmeF90eF9nZXRfZnJhbWVfZm9ybWF0KHN0cnVjdCBpZWVlODAyMTFfdHhfaW5mbyAqdHhf
aW5mbykKK3sKKwlpZiAoISh0eF9pbmZvLT5kcml2ZXJfcmF0ZXNbMF0uZmxhZ3MgJiBJRUVFODAy
MTFfVFhfUkNfTUNTKSkKKwkJcmV0dXJuIEhJRl9GUkFNRV9GT1JNQVRfTk9OX0hUOworCWVsc2Ug
aWYgKCEodHhfaW5mby0+ZHJpdmVyX3JhdGVzWzBdLmZsYWdzICYgSUVFRTgwMjExX1RYX1JDX0dS
RUVOX0ZJRUxEKSkKKwkJcmV0dXJuIEhJRl9GUkFNRV9GT1JNQVRfTUlYRURfRk9STUFUX0hUOwor
CWVsc2UKKwkJcmV0dXJuIEhJRl9GUkFNRV9GT1JNQVRfR0ZfSFRfMTFOOworfQorCitzdGF0aWMg
aW50IHdmeF90eF9nZXRfaWN2X2xlbihzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICpod19rZXkp
Cit7CisJaW50IG1pY19zcGFjZTsKKworCWlmICghaHdfa2V5KQorCQlyZXR1cm4gMDsKKwlpZiAo
aHdfa2V5LT5jaXBoZXIgPT0gV0xBTl9DSVBIRVJfU1VJVEVfQUVTX0NNQUMpCisJCXJldHVybiAw
OworCW1pY19zcGFjZSA9IChod19rZXktPmNpcGhlciA9PSBXTEFOX0NJUEhFUl9TVUlURV9US0lQ
KSA/IDggOiAwOworCXJldHVybiBod19rZXktPmljdl9sZW4gKyBtaWNfc3BhY2U7Cit9CisKK3N0
YXRpYyBpbnQgd2Z4X3R4X2lubmVyKHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBzdHJ1Y3QgaWVlZTgw
MjExX3N0YSAqc3RhLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQoreworCXN0cnVjdCB3ZnhfaGlmX21z
ZyAqaGlmX21zZzsKKwlzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKnJlcTsKKwlzdHJ1Y3Qgd2Z4X3R4
X3ByaXYgKnR4X3ByaXY7CisJc3RydWN0IGllZWU4MDIxMV90eF9pbmZvICp0eF9pbmZvID0gSUVF
RTgwMjExX1NLQl9DQihza2IpOworCXN0cnVjdCBpZWVlODAyMTFfa2V5X2NvbmYgKmh3X2tleSA9
IHR4X2luZm8tPmNvbnRyb2wuaHdfa2V5OworCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIgPSAo
c3RydWN0IGllZWU4MDIxMV9oZHIgKilza2ItPmRhdGE7CisJaW50IHF1ZXVlX2lkID0gc2tiX2dl
dF9xdWV1ZV9tYXBwaW5nKHNrYik7CisJc2l6ZV90IG9mZnNldCA9IChzaXplX3Qpc2tiLT5kYXRh
ICYgMzsKKwlpbnQgd21zZ19sZW4gPSBzaXplb2Yoc3RydWN0IHdmeF9oaWZfbXNnKSArIHNpemVv
ZihzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHgpICsgb2Zmc2V0OworCisJV0FSTihxdWV1ZV9pZCA+PSBJ
RUVFODAyMTFfTlVNX0FDUywgInVuc3VwcG9ydGVkIHF1ZXVlX2lkIik7CisJd2Z4X3R4X2ZpeHVw
X3JhdGVzKHR4X2luZm8tPmRyaXZlcl9yYXRlcyk7CisKKwkvKiBGcm9tIG5vdyB0eF9pbmZvLT5j
b250cm9sIGlzIHVudXNhYmxlICovCisJbWVtc2V0KHR4X2luZm8tPnJhdGVfZHJpdmVyX2RhdGEs
IDAsIHNpemVvZihzdHJ1Y3Qgd2Z4X3R4X3ByaXYpKTsKKwkvKiBGaWxsIHR4X3ByaXYgKi8KKwl0
eF9wcml2ID0gKHN0cnVjdCB3ZnhfdHhfcHJpdiAqKXR4X2luZm8tPnJhdGVfZHJpdmVyX2RhdGE7
CisJdHhfcHJpdi0+aWN2X3NpemUgPSB3ZnhfdHhfZ2V0X2ljdl9sZW4oaHdfa2V5KTsKKworCS8q
IEZpbGwgaGlmX21zZyAqLworCVdBUk4oc2tiX2hlYWRyb29tKHNrYikgPCB3bXNnX2xlbiwgIm5v
dCBlbm91Z2ggc3BhY2UgaW4gc2tiIik7CisJV0FSTihvZmZzZXQgJiAxLCAiYXR0ZW1wdCB0byB0
cmFuc21pdCBhbiB1bmFsaWduZWQgZnJhbWUiKTsKKwlza2JfcHV0KHNrYiwgdHhfcHJpdi0+aWN2
X3NpemUpOworCXNrYl9wdXNoKHNrYiwgd21zZ19sZW4pOworCW1lbXNldChza2ItPmRhdGEsIDAs
IHdtc2dfbGVuKTsKKwloaWZfbXNnID0gKHN0cnVjdCB3ZnhfaGlmX21zZyAqKXNrYi0+ZGF0YTsK
KwloaWZfbXNnLT5sZW4gPSBjcHVfdG9fbGUxNihza2ItPmxlbik7CisJaGlmX21zZy0+aWQgPSBI
SUZfUkVRX0lEX1RYOworCWhpZl9tc2ctPmludGVyZmFjZSA9IHd2aWYtPmlkOworCWlmIChza2It
PmxlbiA+IGxlMTZfdG9fY3B1KHd2aWYtPndkZXYtPmh3X2NhcHMuc2l6ZV9pbnBfY2hfYnVmKSkg
eworCQlkZXZfd2Fybih3dmlmLT53ZGV2LT5kZXYsCisJCQkgInJlcXVlc3RlZCBmcmFtZSBzaXpl
ICglZCkgaXMgbGFyZ2VyIHRoYW4gbWF4aW11bSBzdXBwb3J0ZWQgKCVkKVxuIiwKKwkJCSBza2It
PmxlbiwgbGUxNl90b19jcHUod3ZpZi0+d2Rldi0+aHdfY2Fwcy5zaXplX2lucF9jaF9idWYpKTsK
KwkJc2tiX3B1bGwoc2tiLCB3bXNnX2xlbik7CisJCXJldHVybiAtRUlPOworCX0KKworCS8qIEZp
bGwgdHggcmVxdWVzdCAqLworCXJlcSA9IChzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKiloaWZfbXNn
LT5ib2R5OworCS8qIHBhY2tldF9pZCBqdXN0IG5lZWQgdG8gYmUgdW5pcXVlIG9uIGRldmljZS4g
MzJiaXRzIGFyZSBtb3JlIHRoYW4gbmVjZXNzYXJ5IGZvciB0aGF0IHRhc2ssCisJICogc28gd2Ug
dGFrZSBhZHZhbnRhZ2Ugb2YgaXQgdG8gYWRkIHNvbWUgZXh0cmEgZGF0YSBmb3IgZGVidWcuCisJ
ICovCisJcmVxLT5wYWNrZXRfaWQgPSBhdG9taWNfYWRkX3JldHVybigxLCAmd3ZpZi0+d2Rldi0+
cGFja2V0X2lkKSAmIDB4RkZGRjsKKwlyZXEtPnBhY2tldF9pZCB8PSBJRUVFODAyMTFfU0VRX1RP
X1NOKGxlMTZfdG9fY3B1KGhkci0+c2VxX2N0cmwpKSA8PCAxNjsKKwlyZXEtPnBhY2tldF9pZCB8
PSBxdWV1ZV9pZCA8PCAyODsKKworCXJlcS0+ZmNfb2Zmc2V0ID0gb2Zmc2V0OworCS8qIFF1ZXVl
IGluZGV4IGFyZSBpbnZlcnRlZCBiZXR3ZWVuIGZpcm13YXJlIGFuZCBMaW51eCAqLworCXJlcS0+
cXVldWVfaWQgPSAzIC0gcXVldWVfaWQ7CisJcmVxLT5wZWVyX3N0YV9pZCA9IHdmeF90eF9nZXRf
bGlua19pZCh3dmlmLCBzdGEsIGhkcik7CisJcmVxLT5yZXRyeV9wb2xpY3lfaW5kZXggPSB3Znhf
dHhfZ2V0X3JldHJ5X3BvbGljeV9pZCh3dmlmLCB0eF9pbmZvKTsKKwlyZXEtPmZyYW1lX2Zvcm1h
dCA9IHdmeF90eF9nZXRfZnJhbWVfZm9ybWF0KHR4X2luZm8pOworCWlmICh0eF9pbmZvLT5kcml2
ZXJfcmF0ZXNbMF0uZmxhZ3MgJiBJRUVFODAyMTFfVFhfUkNfU0hPUlRfR0kpCisJCXJlcS0+c2hv
cnRfZ2kgPSAxOworCWlmICh0eF9pbmZvLT5mbGFncyAmIElFRUU4MDIxMV9UWF9DVExfU0VORF9B
RlRFUl9EVElNKQorCQlyZXEtPmFmdGVyX2R0aW0gPSAxOworCisJLyogQXV4aWxpYXJ5IG9wZXJh
dGlvbnMgKi8KKwl3ZnhfdHhfcXVldWVzX3B1dCh3dmlmLCBza2IpOworCWlmICh0eF9pbmZvLT5m
bGFncyAmIElFRUU4MDIxMV9UWF9DVExfU0VORF9BRlRFUl9EVElNKQorCQlzY2hlZHVsZV93b3Jr
KCZ3dmlmLT51cGRhdGVfdGltX3dvcmspOworCXdmeF9iaF9yZXF1ZXN0X3R4KHd2aWYtPndkZXYp
OworCXJldHVybiAwOworfQorCit2b2lkIHdmeF90eChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywg
c3RydWN0IGllZWU4MDIxMV90eF9jb250cm9sICpjb250cm9sLCBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
KQoreworCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2ID0gaHctPnByaXY7CisJc3RydWN0IHdmeF92aWYg
Knd2aWY7CisJc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSA9IGNvbnRyb2wgPyBjb250cm9sLT5z
dGEgOiBOVUxMOworCXN0cnVjdCBpZWVlODAyMTFfdHhfaW5mbyAqdHhfaW5mbyA9IElFRUU4MDIx
MV9TS0JfQ0Ioc2tiKTsKKwlzdHJ1Y3QgaWVlZTgwMjExX2hkciAqaGRyID0gKHN0cnVjdCBpZWVl
ODAyMTFfaGRyICopc2tiLT5kYXRhOworCXNpemVfdCBkcml2ZXJfZGF0YV9yb29tID0gc2l6ZW9m
X2ZpZWxkKHN0cnVjdCBpZWVlODAyMTFfdHhfaW5mbywgcmF0ZV9kcml2ZXJfZGF0YSk7CisKKwlC
VUlMRF9CVUdfT05fTVNHKHNpemVvZihzdHJ1Y3Qgd2Z4X3R4X3ByaXYpID4gZHJpdmVyX2RhdGFf
cm9vbSwKKwkJCSAic3RydWN0IHR4X3ByaXYgaXMgdG9vIGxhcmdlIik7CisJV0FSTihza2ItPm5l
eHQgfHwgc2tiLT5wcmV2LCAic2tiIGlzIGFscmVhZHkgbWVtYmVyIG9mIGEgbGlzdCIpOworCS8q
IGNvbnRyb2wudmlmIGNhbiBiZSBOVUxMIGZvciBpbmplY3RlZCBmcmFtZXMgKi8KKwlpZiAodHhf
aW5mby0+Y29udHJvbC52aWYpCisJCXd2aWYgPSAoc3RydWN0IHdmeF92aWYgKil0eF9pbmZvLT5j
b250cm9sLnZpZi0+ZHJ2X3ByaXY7CisJZWxzZQorCQl3dmlmID0gd3ZpZl9pdGVyYXRlKHdkZXYs
IE5VTEwpOworCWlmIChXQVJOX09OKCF3dmlmKSkKKwkJZ290byBkcm9wOworCS8qIEJlY2F1c2Ug
b2YgVFhfQU1QRFVfU0VUVVBfSU5fSFcsIG1hYzgwMjExIGRvZXMgbm90IHRyeSB0byBzZW5kIGFu
eSBCbG9ja0FjayBzZXNzaW9uCisJICogbWFuYWdlbWVudCBmcmFtZS4gVGhlIGNoZWNrIGJlbG93
IGV4aXN0IGp1c3QgaW4gY2FzZS4KKwkgKi8KKwlpZiAod2Z4X2lzX2FjdGlvbl9iYWNrKGhkcikp
IHsKKwkJZGV2X2luZm8od2Rldi0+ZGV2LCAiZHJvcCBCQSBhY3Rpb25cbiIpOworCQlnb3RvIGRy
b3A7CisJfQorCWlmICh3ZnhfdHhfaW5uZXIod3ZpZiwgc3RhLCBza2IpKQorCQlnb3RvIGRyb3A7
CisKKwlyZXR1cm47CisKK2Ryb3A6CisJaWVlZTgwMjExX3R4X3N0YXR1c19pcnFzYWZlKHdkZXYt
Pmh3LCBza2IpOworfQorCitzdGF0aWMgdm9pZCB3Znhfc2tiX2R0b3Ioc3RydWN0IHdmeF92aWYg
Knd2aWYsIHN0cnVjdCBza19idWZmICpza2IpCit7CisJc3RydWN0IHdmeF9oaWZfbXNnICpoaWYg
PSAoc3RydWN0IHdmeF9oaWZfbXNnICopc2tiLT5kYXRhOworCXN0cnVjdCB3ZnhfaGlmX3JlcV90
eCAqcmVxID0gKHN0cnVjdCB3ZnhfaGlmX3JlcV90eCAqKWhpZi0+Ym9keTsKKwl1bnNpZ25lZCBp
bnQgb2Zmc2V0ID0gc2l6ZW9mKHN0cnVjdCB3ZnhfaGlmX21zZykgKyBzaXplb2Yoc3RydWN0IHdm
eF9oaWZfcmVxX3R4KSArCisJCQkgICAgICByZXEtPmZjX29mZnNldDsKKworCWlmICghd3ZpZikg
eworCQlwcl93YXJuKCJ2aWYgYXNzb2NpYXRlZCB3aXRoIHRoZSBza2IgZG9lcyBub3QgZXhpc3Qg
YW55bW9yZVxuIik7CisJCXJldHVybjsKKwl9CisJd2Z4X3R4X3BvbGljeV9wdXQod3ZpZiwgcmVx
LT5yZXRyeV9wb2xpY3lfaW5kZXgpOworCXNrYl9wdWxsKHNrYiwgb2Zmc2V0KTsKKwlpZWVlODAy
MTFfdHhfc3RhdHVzX2lycXNhZmUod3ZpZi0+d2Rldi0+aHcsIHNrYik7Cit9CisKK3N0YXRpYyB2
b2lkIHdmeF90eF9maWxsX3JhdGVzKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaWVlZTgw
MjExX3R4X2luZm8gKnR4X2luZm8sCisJCQkgICAgICBjb25zdCBzdHJ1Y3Qgd2Z4X2hpZl9jbmZf
dHggKmFyZykKK3sKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4X3JhdGUgKnJhdGU7CisJaW50IHR4X2Nv
dW50OworCWludCBpOworCisJdHhfY291bnQgPSBhcmctPmFja19mYWlsdXJlczsKKwlpZiAoIWFy
Zy0+c3RhdHVzIHx8IGFyZy0+YWNrX2ZhaWx1cmVzKQorCQl0eF9jb3VudCArPSAxOyAvKiBBbHNv
IHJlcG9ydCBzdWNjZXNzICovCisJZm9yIChpID0gMDsgaSA8IElFRUU4MDIxMV9UWF9NQVhfUkFU
RVM7IGkrKykgeworCQlyYXRlID0gJnR4X2luZm8tPnN0YXR1cy5yYXRlc1tpXTsKKwkJaWYgKHJh
dGUtPmlkeCA8IDApCisJCQlicmVhazsKKwkJaWYgKHR4X2NvdW50IDwgcmF0ZS0+Y291bnQgJiYg
YXJnLT5zdGF0dXMgPT0gSElGX1NUQVRVU19UWF9GQUlMX1JFVFJJRVMgJiYKKwkJICAgIGFyZy0+
YWNrX2ZhaWx1cmVzKQorCQkJZGV2X2RiZyh3ZGV2LT5kZXYsICJhbGwgcmV0cmllcyB3ZXJlIG5v
dCBjb25zdW1lZDogJWQgIT0gJWRcbiIsCisJCQkJcmF0ZS0+Y291bnQsIHR4X2NvdW50KTsKKwkJ
aWYgKHR4X2NvdW50IDw9IHJhdGUtPmNvdW50ICYmIHR4X2NvdW50ICYmCisJCSAgICBhcmctPnR4
ZWRfcmF0ZSAhPSB3ZnhfZ2V0X2h3X3JhdGUod2RldiwgcmF0ZSkpCisJCQlkZXZfZGJnKHdkZXYt
PmRldiwgImluY29uc2lzdGVudCB0eF9pbmZvIHJhdGVzOiAlZCAhPSAlZFxuIiwKKwkJCQlhcmct
PnR4ZWRfcmF0ZSwgd2Z4X2dldF9od19yYXRlKHdkZXYsIHJhdGUpKTsKKwkJaWYgKHR4X2NvdW50
ID4gcmF0ZS0+Y291bnQpIHsKKwkJCXR4X2NvdW50IC09IHJhdGUtPmNvdW50OworCQl9IGVsc2Ug
aWYgKCF0eF9jb3VudCkgeworCQkJcmF0ZS0+Y291bnQgPSAwOworCQkJcmF0ZS0+aWR4ID0gLTE7
CisJCX0gZWxzZSB7CisJCQlyYXRlLT5jb3VudCA9IHR4X2NvdW50OworCQkJdHhfY291bnQgPSAw
OworCQl9CisJfQorCWlmICh0eF9jb3VudCkKKwkJZGV2X2RiZyh3ZGV2LT5kZXYsICIlZCBtb3Jl
IHJldHJpZXMgdGhhbiBleHBlY3RlZFxuIiwgdHhfY291bnQpOworfQorCit2b2lkIHdmeF90eF9j
b25maXJtX2NiKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBjb25zdCBzdHJ1Y3Qgd2Z4X2hpZl9jbmZf
dHggKmFyZykKK3sKKwljb25zdCBzdHJ1Y3Qgd2Z4X3R4X3ByaXYgKnR4X3ByaXY7CisJc3RydWN0
IGllZWU4MDIxMV90eF9pbmZvICp0eF9pbmZvOworCXN0cnVjdCB3ZnhfdmlmICp3dmlmOworCXN0
cnVjdCBza19idWZmICpza2I7CisKKwlza2IgPSB3ZnhfcGVuZGluZ19nZXQod2RldiwgYXJnLT5w
YWNrZXRfaWQpOworCWlmICghc2tiKSB7CisJCWRldl93YXJuKHdkZXYtPmRldiwgInJlY2VpdmVk
IHVua25vd24gcGFja2V0X2lkICglIy44eCkgZnJvbSBjaGlwXG4iLAorCQkJIGFyZy0+cGFja2V0
X2lkKTsKKwkJcmV0dXJuOworCX0KKwl0eF9pbmZvID0gSUVFRTgwMjExX1NLQl9DQihza2IpOwor
CXR4X3ByaXYgPSB3Znhfc2tiX3R4X3ByaXYoc2tiKTsKKwl3dmlmID0gd2Rldl90b193dmlmKHdk
ZXYsICgoc3RydWN0IHdmeF9oaWZfbXNnICopc2tiLT5kYXRhKS0+aW50ZXJmYWNlKTsKKwlXQVJO
X09OKCF3dmlmKTsKKwlpZiAoIXd2aWYpCisJCXJldHVybjsKKworCS8qIE5vdGUgdGhhdCB3Znhf
cGVuZGluZ19nZXRfcGt0X3VzX2RlbGF5KCkgZ2V0IGRhdGEgZnJvbSB0eF9pbmZvICovCisJX3Ry
YWNlX3R4X3N0YXRzKGFyZywgc2tiLCB3ZnhfcGVuZGluZ19nZXRfcGt0X3VzX2RlbGF5KHdkZXYs
IHNrYikpOworCXdmeF90eF9maWxsX3JhdGVzKHdkZXYsIHR4X2luZm8sIGFyZyk7CisJc2tiX3Ry
aW0oc2tiLCBza2ItPmxlbiAtIHR4X3ByaXYtPmljdl9zaXplKTsKKworCS8qIEZyb20gbm93LCB5
b3UgY2FuIHRvdWNoIHRvIHR4X2luZm8tPnN0YXR1cywgYnV0IGRvIG5vdCB0b3VjaCB0bworCSAq
IHR4X3ByaXYgYW55bW9yZQorCSAqLworCS8qIEZJWE1FOiB1c2UgaWVlZTgwMjExX3R4X2luZm9f
Y2xlYXJfc3RhdHVzKCkgKi8KKwltZW1zZXQodHhfaW5mby0+cmF0ZV9kcml2ZXJfZGF0YSwgMCwg
c2l6ZW9mKHR4X2luZm8tPnJhdGVfZHJpdmVyX2RhdGEpKTsKKwltZW1zZXQodHhfaW5mby0+cGFk
LCAwLCBzaXplb2YodHhfaW5mby0+cGFkKSk7CisKKwlpZiAoIWFyZy0+c3RhdHVzKSB7CisJCXR4
X2luZm8tPnN0YXR1cy50eF90aW1lID0gbGUzMl90b19jcHUoYXJnLT5tZWRpYV9kZWxheSkgLQor
CQkJCQkgIGxlMzJfdG9fY3B1KGFyZy0+dHhfcXVldWVfZGVsYXkpOworCQlpZiAodHhfaW5mby0+
ZmxhZ3MgJiBJRUVFODAyMTFfVFhfQ1RMX05PX0FDSykKKwkJCXR4X2luZm8tPmZsYWdzIHw9IElF
RUU4MDIxMV9UWF9TVEFUX05PQUNLX1RSQU5TTUlUVEVEOworCQllbHNlCisJCQl0eF9pbmZvLT5m
bGFncyB8PSBJRUVFODAyMTFfVFhfU1RBVF9BQ0s7CisJfSBlbHNlIGlmIChhcmctPnN0YXR1cyA9
PSBISUZfU1RBVFVTX1RYX0ZBSUxfUkVRVUVVRSkgeworCQlXQVJOKCFhcmctPnJlcXVldWUsICJp
bmNvaGVyZW50IHN0YXR1cyBhbmQgcmVzdWx0X2ZsYWdzIik7CisJCWlmICh0eF9pbmZvLT5mbGFn
cyAmIElFRUU4MDIxMV9UWF9DVExfU0VORF9BRlRFUl9EVElNKSB7CisJCQl3dmlmLT5hZnRlcl9k
dGltX3R4X2FsbG93ZWQgPSBmYWxzZTsgLyogRFRJTSBwZXJpb2QgZWxhcHNlZCAqLworCQkJc2No
ZWR1bGVfd29yaygmd3ZpZi0+dXBkYXRlX3RpbV93b3JrKTsKKwkJfQorCQl0eF9pbmZvLT5mbGFn
cyB8PSBJRUVFODAyMTFfVFhfU1RBVF9UWF9GSUxURVJFRDsKKwl9CisJd2Z4X3NrYl9kdG9yKHd2
aWYsIHNrYik7Cit9CisKK3N0YXRpYyB2b2lkIHdmeF9mbHVzaF92aWYoc3RydWN0IHdmeF92aWYg
Knd2aWYsIHUzMiBxdWV1ZXMsIHN0cnVjdCBza19idWZmX2hlYWQgKmRyb3BwZWQpCit7CisJc3Ry
dWN0IHdmeF9xdWV1ZSAqcXVldWU7CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgSUVFRTgw
MjExX05VTV9BQ1M7IGkrKykgeworCQlpZiAoIShCSVQoaSkgJiBxdWV1ZXMpKQorCQkJY29udGlu
dWU7CisJCXF1ZXVlID0gJnd2aWYtPnR4X3F1ZXVlW2ldOworCQlpZiAoZHJvcHBlZCkKKwkJCXdm
eF90eF9xdWV1ZV9kcm9wKHd2aWYsIHF1ZXVlLCBkcm9wcGVkKTsKKwl9CisJaWYgKHd2aWYtPndk
ZXYtPmNoaXBfZnJvemVuKQorCQlyZXR1cm47CisJZm9yIChpID0gMDsgaSA8IElFRUU4MDIxMV9O
VU1fQUNTOyBpKyspIHsKKwkJaWYgKCEoQklUKGkpICYgcXVldWVzKSkKKwkJCWNvbnRpbnVlOwor
CQlxdWV1ZSA9ICZ3dmlmLT50eF9xdWV1ZVtpXTsKKwkJaWYgKHdhaXRfZXZlbnRfdGltZW91dCh3
dmlmLT53ZGV2LT50eF9kZXF1ZXVlLCB3ZnhfdHhfcXVldWVfZW1wdHkod3ZpZiwgcXVldWUpLAor
CQkJCSAgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMDApKSA8PSAwKQorCQkJZGV2X3dhcm4od3Zp
Zi0+d2Rldi0+ZGV2LCAiZnJhbWVzIHF1ZXVlZCB3aGlsZSBmbHVzaGluZyB0eCBxdWV1ZXM/Iik7
CisJfQorfQorCit2b2lkIHdmeF9mbHVzaChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0
IGllZWU4MDIxMV92aWYgKnZpZiwgdTMyIHF1ZXVlcywgYm9vbCBkcm9wKQoreworCXN0cnVjdCB3
ZnhfZGV2ICp3ZGV2ID0gaHctPnByaXY7CisJc3RydWN0IHNrX2J1ZmZfaGVhZCBkcm9wcGVkOwor
CXN0cnVjdCB3ZnhfdmlmICp3dmlmOworCXN0cnVjdCB3ZnhfaGlmX21zZyAqaGlmOworCXN0cnVj
dCBza19idWZmICpza2I7CisKKwlza2JfcXVldWVfaGVhZF9pbml0KCZkcm9wcGVkKTsKKwlpZiAo
dmlmKSB7CisJCXd2aWYgPSAoc3RydWN0IHdmeF92aWYgKil2aWYtPmRydl9wcml2OworCQl3Znhf
Zmx1c2hfdmlmKHd2aWYsIHF1ZXVlcywgZHJvcCA/ICZkcm9wcGVkIDogTlVMTCk7CisJfSBlbHNl
IHsKKwkJd3ZpZiA9IE5VTEw7CisJCXdoaWxlICgod3ZpZiA9IHd2aWZfaXRlcmF0ZSh3ZGV2LCB3
dmlmKSkgIT0gTlVMTCkKKwkJCXdmeF9mbHVzaF92aWYod3ZpZiwgcXVldWVzLCBkcm9wID8gJmRy
b3BwZWQgOiBOVUxMKTsKKwl9CisJd2Z4X3R4X2ZsdXNoKHdkZXYpOworCWlmICh3ZGV2LT5jaGlw
X2Zyb3plbikKKwkJd2Z4X3BlbmRpbmdfZHJvcCh3ZGV2LCAmZHJvcHBlZCk7CisJd2hpbGUgKChz
a2IgPSBza2JfZGVxdWV1ZSgmZHJvcHBlZCkpICE9IE5VTEwpIHsKKwkJaGlmID0gKHN0cnVjdCB3
ZnhfaGlmX21zZyAqKXNrYi0+ZGF0YTsKKwkJd3ZpZiA9IHdkZXZfdG9fd3ZpZih3ZGV2LCBoaWYt
PmludGVyZmFjZSk7CisJCWllZWU4MDIxMV90eF9pbmZvX2NsZWFyX3N0YXR1cyhJRUVFODAyMTFf
U0tCX0NCKHNrYikpOworCQl3Znhfc2tiX2R0b3Iod3ZpZiwgc2tiKTsKKwl9Cit9CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguaCBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0YV90eC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAwMDAwMC4uOTgzNDcwNzA1ZTRiCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRhX3R4LmgKQEAgLTAsMCArMSw2NiBAQAorLyog
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLworLyoKKyAqIERhdGEgdHJh
bnNtaXR0aW5nIGltcGxlbWVudGF0aW9uLgorICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIw
LCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5jLgorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1F
cmljc3NvbgorICovCisjaWZuZGVmIFdGWF9EQVRBX1RYX0gKKyNkZWZpbmUgV0ZYX0RBVEFfVFhf
SAorCisjaW5jbHVkZSA8bGludXgvbGlzdC5oPgorI2luY2x1ZGUgPG5ldC9tYWM4MDIxMS5oPgor
CisjaW5jbHVkZSAiaGlmX2FwaV9jbWQuaCIKKyNpbmNsdWRlICJoaWZfYXBpX21pYi5oIgorCitz
dHJ1Y3Qgd2Z4X3R4X3ByaXY7CitzdHJ1Y3Qgd2Z4X2RldjsKK3N0cnVjdCB3ZnhfdmlmOworCitz
dHJ1Y3Qgd2Z4X3R4X3BvbGljeSB7CisJc3RydWN0IGxpc3RfaGVhZCBsaW5rOworCWludCB1c2Fn
ZV9jb3VudDsKKwl1OCByYXRlc1sxMl07CisJYm9vbCB1cGxvYWRlZDsKK307CisKK3N0cnVjdCB3
ZnhfdHhfcG9saWN5X2NhY2hlIHsKKwlzdHJ1Y3Qgd2Z4X3R4X3BvbGljeSBjYWNoZVtISUZfVFhf
UkVUUllfUE9MSUNZX01BWF07CisJLyogRklYTUU6IHVzZSBhIHRyZWVzIGFuZCBkcm9wIGhhc2gg
ZnJvbSB0eF9wb2xpY3kgKi8KKwlzdHJ1Y3QgbGlzdF9oZWFkIHVzZWQ7CisJc3RydWN0IGxpc3Rf
aGVhZCBmcmVlOworCXNwaW5sb2NrX3QgbG9jazsKK307CisKK3N0cnVjdCB3ZnhfdHhfcHJpdiB7
CisJa3RpbWVfdCB4bWl0X3RpbWVzdGFtcDsKKwl1bnNpZ25lZCBjaGFyIGljdl9zaXplOworfTsK
Kwordm9pZCB3ZnhfdHhfcG9saWN5X2luaXQoc3RydWN0IHdmeF92aWYgKnd2aWYpOwordm9pZCB3
ZnhfdHhfcG9saWN5X3VwbG9hZF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7CisKK3Zv
aWQgd2Z4X3R4KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3R4X2Nv
bnRyb2wgKmNvbnRyb2wsIHN0cnVjdCBza19idWZmICpza2IpOwordm9pZCB3ZnhfdHhfY29uZmly
bV9jYihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgY29uc3Qgc3RydWN0IHdmeF9oaWZfY25mX3R4ICph
cmcpOwordm9pZCB3ZnhfZmx1c2goc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYsIHUzMiBxdWV1ZXMsIGJvb2wgZHJvcCk7CisKK3N0YXRpYyBpbmxpbmUg
c3RydWN0IHdmeF90eF9wcml2ICp3Znhfc2tiX3R4X3ByaXYoc3RydWN0IHNrX2J1ZmYgKnNrYikK
K3sKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKnR4X2luZm87CisKKwlpZiAoIXNrYikKKwkJ
cmV0dXJuIE5VTEw7CisJdHhfaW5mbyA9IElFRUU4MDIxMV9TS0JfQ0Ioc2tiKTsKKwlyZXR1cm4g
KHN0cnVjdCB3ZnhfdHhfcHJpdiAqKXR4X2luZm8tPnJhdGVfZHJpdmVyX2RhdGE7Cit9CisKK3N0
YXRpYyBpbmxpbmUgc3RydWN0IHdmeF9oaWZfcmVxX3R4ICp3Znhfc2tiX3R4cmVxKHN0cnVjdCBz
a19idWZmICpza2IpCit7CisJc3RydWN0IHdmeF9oaWZfbXNnICpoaWYgPSAoc3RydWN0IHdmeF9o
aWZfbXNnICopc2tiLT5kYXRhOworCXN0cnVjdCB3ZnhfaGlmX3JlcV90eCAqcmVxID0gKHN0cnVj
dCB3ZnhfaGlmX3JlcV90eCAqKWhpZi0+Ym9keTsKKworCXJldHVybiByZXE7Cit9CisKKyNlbmRp
ZgotLSAKMi4zNC4xCgo=
