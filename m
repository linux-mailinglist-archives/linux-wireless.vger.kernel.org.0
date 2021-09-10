Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1620D406F17
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Sep 2021 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhIJQLL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Sep 2021 12:11:11 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:58752
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229907AbhIJQJC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Sep 2021 12:09:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRdiBPUklVd1jToTtFlqIGhuCa+h5YkxA1vmVZDdUIDrKVE6p/ZuY8Yf8Tkmg7I9w8ZgLCRR69y/uyYAs4958Hul6kdKPJ8myePevTQ7ozU87d2e6ds04B+nezlIkiBqaBBUtrJj6n5xlvlDu2BkAZ7TVm9i/SW4YSR5Hgst+yIkXnG0e97gMsAAjmOkkPjmOCWd8QQvEHYCodqvzD5otoCLUa8n/L6/UHlKbjA5uo314rEgEK+wEk9OkYlRmpOpk+M/n5jQ4wA7zX1jynHI+6D4e8gQVDWCHLnwGlji1NVgHTVOn46UNDRpU3NM27cIurzjA7vlDAPui6evPczVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ASE4rAagVGXa5deMw5+RxN7XsAlkN46v5/lzPTuDMuc=;
 b=K8U64UoLXvj1ac+Co4mxj7VShsDKiKyK5sD6A4oybqi6qvCu5FWDIq9RGtoOy/2HQjN40fOplie+GYd3C0PnaVNBC0rP1dRec7tpBQD9sCfuy7oMgtznMNGT8NwuzRZ7UQZRqeVdPphNJs4KDh2IPIK8IgBgUfeNMt3EBf/FIJsS/xBGC6ubPiN0gd84QORPPlhyZKNQmwDmXRW8OQWdw8/RrsPv8QTK95wml5QPC/v2ajlgEOZfo6gF5EaBNamN/elXyGlbkV+TFP2f15zyJtW+/9YghE4oeExM+OhuFpPbcAW0RNKPoEv6MLvHBAr5y2IPLmu3h82CeDXpyhsSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASE4rAagVGXa5deMw5+RxN7XsAlkN46v5/lzPTuDMuc=;
 b=o8g/yrYmRBcNMMh0ZtxfhbQ4Srt+5pJ4CooILanKooLhVL5d50S6gOFqyj4aOa4FNtJPUDsnGIwOT5jb+wbK1EG/fXCCnEw8fjkmG93FdgT6leK5HMf1pykB7EUhLPssNNu8kdwYULh5yIMnWncyCRzWRLWdOvteLzIQzYxOCVw=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3118.namprd11.prod.outlook.com (2603:10b6:805:dc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 16:06:00 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 16:06:00 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 14/31] staging: wfx: uniformize counter names
Date:   Fri, 10 Sep 2021 18:04:47 +0200
Message-Id: <20210910160504.1794332-15-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910160504.1794332-1-Jerome.Pouiller@silabs.com>
References: <20210910160504.1794332-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SN4PR0601CA0006.namprd06.prod.outlook.com
 (2603:10b6:803:2f::16) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
Received: from pc-42.silabs.com (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by SN4PR0601CA0006.namprd06.prod.outlook.com (2603:10b6:803:2f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Fri, 10 Sep 2021 16:05:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec5d45af-97c7-415c-c969-08d97474e164
X-MS-TrafficTypeDiagnostic: SN6PR11MB3118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB3118EC5935529E236592B1AC93D69@SN6PR11MB3118.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0u8oYv2028EhiOWhDYXb6X/y0Z1YDiki8TNWacMTarEVejiY26k9t5l9QkuLrM0zMQszp3pxGrz/joIEwhhsN8V4Q0NMEVyAM1X5Tj/iWL6WcqgZErdiEMkiEeitQ2k4rLXOk2IqH99l07pMVbhJu2cILyW7zbCyXSMqiW4xXi+BbMFpxmq0ZPi41K08QTJRn70Q4mLqjnP5ZHD3wyLFnl/yOQ5rkjLs06/02MHrnvztQblBETedGkM2eEe3+SrYqugKLOnjL7hS30q6PT2yHz7sJafxUGe7ohAtyvUSuMJYelQnsrhj6S+gVld6havV2Uap238UdnHRnxnJrkfmKLHkZm7v6t8KwAhKgGtlSTdj832dBY2U0tHQkzNoCil5fuZDv9Ct9audscFhRehbj3pBIYzX1er929U06j1nrlJaL3BtBxgdFOxR8fe0mtlAPcw5YmVnR64UcP+9v9GdjLVz+szIj6fLU+4ViCn6FGMWgQc7CLBZGeAqTRpH765eaCUE6ASawVIxse21bCdwJk+KmWKWL1VFxs3N+/dJTSyHSVscbBGi56nrWYtr3672vvWr/6HYZcd9S7sc7LHsw/eH0nY91QzoU5rVWPeAJvnTSV/WA/RIM+ggGJxtfYSlxftIU6E9CepZmyVVq0ct+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39850400004)(396003)(4326008)(66476007)(107886003)(36756003)(186003)(316002)(6486002)(66556008)(8676002)(6666004)(86362001)(2906002)(54906003)(38100700002)(83380400001)(8936002)(5660300002)(66946007)(1076003)(2616005)(52116002)(7696005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTQxazdMeEJNL0czS3huU3RSbHp4MTNHY3R6ZWVlNW80MW1lSnljaVlBV0dv?=
 =?utf-8?B?U1E5WHEyV0M1emZiN2l5WWo4aXFkWm1NUlE0bHg5ZFkxUlUyekd6QVZIcCs4?=
 =?utf-8?B?QnZYakhBYmdaT05Nc1BpYzdhd2xoQ09ZMkFwdm5qKzdLS1NCbXVmUWp1b0Zp?=
 =?utf-8?B?TU11ZXdsWi9GVGhocXZjakFNVWJXZytmeVByejZ0ZXV4REtyQnZjZ2Y4M21G?=
 =?utf-8?B?akRIZHpYMWpPUFlUWlR4ZUZTV0JyN1NHcmlqTExjT01NK1cvNDA4RGlMQUwr?=
 =?utf-8?B?ZDJjWTc0UmZSSnhtZmcxczBxejRQRk54cDNKRjYzOEN3a3RwL0V1TFlkK1VB?=
 =?utf-8?B?bkRVYWV5RkRseDRidHVEclpPQmdkTW5VSktlY2xPU2pDOXI0Z3l4YlhvL05X?=
 =?utf-8?B?WHhkWGhoZ0tyUldDOEphLzVrQ0N2SVBxSWdqajlJeVlDSEFWK3Q5bXp4OUZO?=
 =?utf-8?B?TnVqalJLOVVMSm9rZEY1M2RwbHM4UEVMSm9MRVRLMjVzNnYzam1qeG01QUJ0?=
 =?utf-8?B?cGZhcDlxWVVobks3MzJKVlY4eURKSUFtRHByOFlPd1RUWkhtN29oSC9wU1Zs?=
 =?utf-8?B?bmdOWXJ1SUhGL09EY0dIZlE0QVRRcHVEdzgvODd5cExxSTN4NlNmbmNSMHYr?=
 =?utf-8?B?TVdBR2Q2NE1FeW5lWm4rYlBlWEZwSklYRm5LRUwyTUVzcWxQNkc2Sk5TL202?=
 =?utf-8?B?VWwyVFFrMkxkbTRIeitvVUtkVkNyT1V4THBKc2x5SUJCOFlUYzZEQ2p5bDRT?=
 =?utf-8?B?SUQwM0taNHNoY3l2cW1xWEtINUcraUowd2lvdU41aHpaMy96Z1V5TTlWdW1E?=
 =?utf-8?B?WTBiMmpLblh4cWdpekQzWU5mR040WGYvdk40bWc0QWtBVjM1WXJxNkt2NzE3?=
 =?utf-8?B?N2lNaWY2OEN2c0pwTGIxUUlJbnhqWVpaS1ZDUnlGYWFvbWo0YUdVMFhYcjJL?=
 =?utf-8?B?L3g1RENjUWR6RjJkMlliWkVpOUJiY25LajVKZk9xQ0tkTS90bEVvV0xQTlYr?=
 =?utf-8?B?R0xZTldIamwxaWJEeTRXNEZZYnhaZ01PU1FEeFhXamNQSWFHbENyUE5UTVkr?=
 =?utf-8?B?MEJVQ1J4MnpaWWFBL1YwWVBNWTdQdmdlUnNXK2FDcnRQVmZmdVZ6c3JDLzJs?=
 =?utf-8?B?L0ZlaGNtY0JibUZIcEdQamtON1JYQUM2YnZRejJEV3JTaDBRVDZyYlRwOU50?=
 =?utf-8?B?TzIyMzZmRlFMbmJzMlM4Uk1HZklXSmRBV2Fnc2d1ZWs3eGNpcitOanI4YWVZ?=
 =?utf-8?B?QmNTQ2pkZkZLc2tGbWpWY3E2R1ZHdHVzR1BaMGUxdFJ5MmtxWDAvdlY2Yk9T?=
 =?utf-8?B?ZVBYVE1LMzh4OTZPeDMzUGxLYWNnSlY1Mk1LV3M3bTA2c01SWmQ5Q0JhV1JG?=
 =?utf-8?B?Vmh5WFZuR1ZFdzB4SWVwWU5VN2czL1Ziamd4K2dkNzFGVEhXVnBwK25DSXdo?=
 =?utf-8?B?d05rMUZCMDlWVmJEWjNHMXpSTmZTY1pmeG4rSlZTM1ZvWWlqODdtVkJiQThC?=
 =?utf-8?B?SVBaWWJ4VEQyWlpNQkxUWXV1b2h4Z0hTbWFOS2QzVWV6a2pWdG9kMng5RkJj?=
 =?utf-8?B?SGlYdTd1eG81S1ZiYWtaa3ZTeVF1d3l2V01iQ3BRd3Z0d2x6VXc1d3BndnVZ?=
 =?utf-8?B?bnd4NmI2dnBnRkVjMUdxVmlwbFY5WG1sRnZPTWJsWnRaNW5TMmRPZEF6VHYr?=
 =?utf-8?B?RjJTRVFHRjFsTS80V1BIZ2VnWXlWMzNSY2REd3NhUEJjWDVWNTA4WGNaUzJE?=
 =?utf-8?B?amtlMjJCS29YMjFTVE01UDhtWklpODJqdldweGd4ZGpTd3dxcC9LNGMrcGdI?=
 =?utf-8?B?OVNnSHRaYVcrbk52eTJBcWVJME05TDNVVEZGR0wyYWwvbHhvZzNEMVpEZjBW?=
 =?utf-8?Q?hwmKXTZkwRDBu?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5d45af-97c7-415c-c969-08d97474e164
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 16:05:59.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qd7YDW3dz1Ztw7Uq5Teq8sIG1WqXIr3r7udm91SO1K3MQcl08axGy7zXqN3Z3QSvfLMHO6+ooZkv5YNPnauXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3118
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKVGhl
IGRldmljZSBwcm92aWRlIHNvbWUgaW50ZXJuYWwgc3RhdGlzdGljIGNvdW50ZXJzLiBIb3dldmVy
LCB0aGUgbmFtZXMKb2YgY291bnRlciB3ZXJlIG5vdCB2ZXJ5IG1lYW5pbmdmdWwuCgpTaWduZWQt
b2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0t
LQogZHJpdmVycy9zdGFnaW5nL3dmeC9kZWJ1Zy5jICAgICAgIHwgNDUgKysrKysrKystLS0tLS0t
LS0KIGRyaXZlcnMvc3RhZ2luZy93ZngvaGlmX2FwaV9taWIuaCB8IDgyICsrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgNjMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9kZWJ1Zy5jIGIv
ZHJpdmVycy9zdGFnaW5nL3dmeC9kZWJ1Zy5jCmluZGV4IGU2N2NhMGQ4MThiYS4uMTZjM2Y1NWYx
YTNkIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2RlYnVnLmMKKysrIGIvZHJpdmVy
cy9zdGFnaW5nL3dmeC9kZWJ1Zy5jCkBAIC04MiwzNiArODIsMzcgQEAgc3RhdGljIGludCB3Znhf
Y291bnRlcnNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikKIAkJICAgbGUzMl90
b19jcHUoY291bnRlcnNbMF0uY291bnRfIyNuYW1lKSwgXAogCQkgICBsZTMyX3RvX2NwdShjb3Vu
dGVyc1sxXS5jb3VudF8jI25hbWUpKQogCi0JUFVUX0NPVU5URVIodHhfcGFja2V0cyk7Ci0JUFVU
X0NPVU5URVIodHhfbXVsdGljYXN0X2ZyYW1lcyk7CisJUFVUX0NPVU5URVIodHhfZnJhbWVzKTsK
KwlQVVRfQ09VTlRFUih0eF9mcmFtZXNfbXVsdGljYXN0KTsKIAlQVVRfQ09VTlRFUih0eF9mcmFt
ZXNfc3VjY2Vzcyk7Ci0JUFVUX0NPVU5URVIodHhfZnJhbWVfZmFpbHVyZXMpOwogCVBVVF9DT1VO
VEVSKHR4X2ZyYW1lc19yZXRyaWVkKTsKIAlQVVRfQ09VTlRFUih0eF9mcmFtZXNfbXVsdGlfcmV0
cmllZCk7CisJUFVUX0NPVU5URVIodHhfZnJhbWVzX2ZhaWxlZCk7CiAKKwlQVVRfQ09VTlRFUihh
Y2tfZmFpbGVkKTsKIAlQVVRfQ09VTlRFUihydHNfc3VjY2Vzcyk7Ci0JUFVUX0NPVU5URVIocnRz
X2ZhaWx1cmVzKTsKLQlQVVRfQ09VTlRFUihhY2tfZmFpbHVyZXMpOworCVBVVF9DT1VOVEVSKHJ0
c19mYWlsZWQpOwogCi0JUFVUX0NPVU5URVIocnhfcGFja2V0cyk7CisJUFVUX0NPVU5URVIocnhf
ZnJhbWVzKTsKKwlQVVRfQ09VTlRFUihyeF9mcmFtZXNfbXVsdGljYXN0KTsKIAlQVVRfQ09VTlRF
UihyeF9mcmFtZXNfc3VjY2Vzcyk7Ci0JUFVUX0NPVU5URVIocnhfcGFja2V0X2Vycm9ycyk7Ci0J
UFVUX0NPVU5URVIocGxjcF9lcnJvcnMpOwotCVBVVF9DT1VOVEVSKGZjc19lcnJvcnMpOwotCVBV
VF9DT1VOVEVSKHJ4X2RlY3J5cHRpb25fZmFpbHVyZXMpOwotCVBVVF9DT1VOVEVSKHJ4X21pY19m
YWlsdXJlcyk7Ci0JUFVUX0NPVU5URVIocnhfbm9fa2V5X2ZhaWx1cmVzKTsKLQlQVVRfQ09VTlRF
UihyeF9mcmFtZV9kdXBsaWNhdGVzKTsKLQlQVVRfQ09VTlRFUihyeF9tdWx0aWNhc3RfZnJhbWVz
KTsKLQlQVVRfQ09VTlRFUihyeF9jbWFjaWN2X2Vycm9ycyk7Ci0JUFVUX0NPVU5URVIocnhfY21h
Y19yZXBsYXlzKTsKLQlQVVRfQ09VTlRFUihyeF9tZ210X2NjbXBfcmVwbGF5cyk7CisJUFVUX0NP
VU5URVIocnhfZnJhbWVzX2ZhaWxlZCk7CisJUFVUX0NPVU5URVIoZHJvcF9wbGNwKTsKKwlQVVRf
Q09VTlRFUihkcm9wX2Zjcyk7CisJUFVUX0NPVU5URVIoZHJvcF9ub19rZXkpOworCVBVVF9DT1VO
VEVSKGRyb3BfZGVjcnlwdGlvbik7CisJUFVUX0NPVU5URVIoZHJvcF90a2lwX21pYyk7CisJUFVU
X0NPVU5URVIoZHJvcF9iaXBfbWljKTsKKwlQVVRfQ09VTlRFUihkcm9wX2NtYWNfaWN2KTsKKwlQ
VVRfQ09VTlRFUihkcm9wX2NtYWNfcmVwbGF5KTsKKwlQVVRfQ09VTlRFUihkcm9wX2NjbXBfcmVw
bGF5KTsKKwlQVVRfQ09VTlRFUihkcm9wX2R1cGxpY2F0ZSk7CiAKLQlQVVRfQ09VTlRFUihyeF9i
ZWFjb24pOwotCVBVVF9DT1VOVEVSKG1pc3NfYmVhY29uKTsKLQlQVVRfQ09VTlRFUihyeF9kdGlt
KTsKLQlQVVRfQ09VTlRFUihyeF9kdGltX2FpZDBfY2xyKTsKLQlQVVRfQ09VTlRFUihyeF9kdGlt
X2FpZDBfc2V0KTsKKwlQVVRfQ09VTlRFUihyeF9iY25fbWlzcyk7CisJUFVUX0NPVU5URVIocnhf
YmNuX3N1Y2Nlc3MpOworCVBVVF9DT1VOVEVSKHJ4X2Jjbl9kdGltKTsKKwlQVVRfQ09VTlRFUihy
eF9iY25fZHRpbV9haWQwX2Nscik7CisJUFVUX0NPVU5URVIocnhfYmNuX2R0aW1fYWlkMF9zZXQp
OwogCiAjdW5kZWYgUFVUX0NPVU5URVIKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dm
eC9oaWZfYXBpX21pYi5oIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX21pYi5oCmluZGV4
IGIyZGM0N2MzMTRjYy4uMmE3NDFhMzdhOTBjIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcv
d2Z4L2hpZl9hcGlfbWliLmgKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX21pYi5o
CkBAIC0xMzMsNjEgKzEzMyw2MSBAQCBzdHJ1Y3QgaGlmX21pYl9iY25fZmlsdGVyX2VuYWJsZSB7
CiB9IF9fcGFja2VkOwogCiBzdHJ1Y3QgaGlmX21pYl9leHRlbmRlZF9jb3VudF90YWJsZSB7Ci0J
X19sZTMyIGNvdW50X3BsY3BfZXJyb3JzOwotCV9fbGUzMiBjb3VudF9mY3NfZXJyb3JzOwotCV9f
bGUzMiBjb3VudF90eF9wYWNrZXRzOwotCV9fbGUzMiBjb3VudF9yeF9wYWNrZXRzOwotCV9fbGUz
MiBjb3VudF9yeF9wYWNrZXRfZXJyb3JzOwotCV9fbGUzMiBjb3VudF9yeF9kZWNyeXB0aW9uX2Zh
aWx1cmVzOwotCV9fbGUzMiBjb3VudF9yeF9taWNfZmFpbHVyZXM7Ci0JX19sZTMyIGNvdW50X3J4
X25vX2tleV9mYWlsdXJlczsKLQlfX2xlMzIgY291bnRfdHhfbXVsdGljYXN0X2ZyYW1lczsKKwlf
X2xlMzIgY291bnRfZHJvcF9wbGNwOworCV9fbGUzMiBjb3VudF9kcm9wX2ZjczsKKwlfX2xlMzIg
Y291bnRfdHhfZnJhbWVzOworCV9fbGUzMiBjb3VudF9yeF9mcmFtZXM7CisJX19sZTMyIGNvdW50
X3J4X2ZyYW1lc19mYWlsZWQ7CisJX19sZTMyIGNvdW50X2Ryb3BfZGVjcnlwdGlvbjsKKwlfX2xl
MzIgY291bnRfZHJvcF90a2lwX21pYzsKKwlfX2xlMzIgY291bnRfZHJvcF9ub19rZXk7CisJX19s
ZTMyIGNvdW50X3R4X2ZyYW1lc19tdWx0aWNhc3Q7CiAJX19sZTMyIGNvdW50X3R4X2ZyYW1lc19z
dWNjZXNzOwotCV9fbGUzMiBjb3VudF90eF9mcmFtZV9mYWlsdXJlczsKKwlfX2xlMzIgY291bnRf
dHhfZnJhbWVzX2ZhaWxlZDsKIAlfX2xlMzIgY291bnRfdHhfZnJhbWVzX3JldHJpZWQ7CiAJX19s
ZTMyIGNvdW50X3R4X2ZyYW1lc19tdWx0aV9yZXRyaWVkOwotCV9fbGUzMiBjb3VudF9yeF9mcmFt
ZV9kdXBsaWNhdGVzOworCV9fbGUzMiBjb3VudF9kcm9wX2R1cGxpY2F0ZTsKIAlfX2xlMzIgY291
bnRfcnRzX3N1Y2Nlc3M7Ci0JX19sZTMyIGNvdW50X3J0c19mYWlsdXJlczsKLQlfX2xlMzIgY291
bnRfYWNrX2ZhaWx1cmVzOwotCV9fbGUzMiBjb3VudF9yeF9tdWx0aWNhc3RfZnJhbWVzOworCV9f
bGUzMiBjb3VudF9ydHNfZmFpbGVkOworCV9fbGUzMiBjb3VudF9hY2tfZmFpbGVkOworCV9fbGUz
MiBjb3VudF9yeF9mcmFtZXNfbXVsdGljYXN0OwogCV9fbGUzMiBjb3VudF9yeF9mcmFtZXNfc3Vj
Y2VzczsKLQlfX2xlMzIgY291bnRfcnhfY21hY2ljdl9lcnJvcnM7Ci0JX19sZTMyIGNvdW50X3J4
X2NtYWNfcmVwbGF5czsKLQlfX2xlMzIgY291bnRfcnhfbWdtdF9jY21wX3JlcGxheXM7Ci0JX19s
ZTMyIGNvdW50X3J4X2JpcG1pY19lcnJvcnM7Ci0JX19sZTMyIGNvdW50X3J4X2JlYWNvbjsKLQlf
X2xlMzIgY291bnRfbWlzc19iZWFjb247Ci0JX19sZTMyIGNvdW50X3J4X2R0aW07Ci0JX19sZTMy
IGNvdW50X3J4X2R0aW1fYWlkMF9jbHI7Ci0JX19sZTMyIGNvdW50X3J4X2R0aW1fYWlkMF9zZXQ7
CisJX19sZTMyIGNvdW50X2Ryb3BfY21hY19pY3Y7CisJX19sZTMyIGNvdW50X2Ryb3BfY21hY19y
ZXBsYXk7CisJX19sZTMyIGNvdW50X2Ryb3BfY2NtcF9yZXBsYXk7CisJX19sZTMyIGNvdW50X2Ry
b3BfYmlwX21pYzsKKwlfX2xlMzIgY291bnRfcnhfYmNuX3N1Y2Nlc3M7CisJX19sZTMyIGNvdW50
X3J4X2Jjbl9taXNzOworCV9fbGUzMiBjb3VudF9yeF9iY25fZHRpbTsKKwlfX2xlMzIgY291bnRf
cnhfYmNuX2R0aW1fYWlkMF9jbHI7CisJX19sZTMyIGNvdW50X3J4X2Jjbl9kdGltX2FpZDBfc2V0
OwogCV9fbGUzMiByZXNlcnZlZFsxMl07CiB9IF9fcGFja2VkOwogCiBzdHJ1Y3QgaGlmX21pYl9j
b3VudF90YWJsZSB7Ci0JX19sZTMyIGNvdW50X3BsY3BfZXJyb3JzOwotCV9fbGUzMiBjb3VudF9m
Y3NfZXJyb3JzOwotCV9fbGUzMiBjb3VudF90eF9wYWNrZXRzOwotCV9fbGUzMiBjb3VudF9yeF9w
YWNrZXRzOwotCV9fbGUzMiBjb3VudF9yeF9wYWNrZXRfZXJyb3JzOwotCV9fbGUzMiBjb3VudF9y
eF9kZWNyeXB0aW9uX2ZhaWx1cmVzOwotCV9fbGUzMiBjb3VudF9yeF9taWNfZmFpbHVyZXM7Ci0J
X19sZTMyIGNvdW50X3J4X25vX2tleV9mYWlsdXJlczsKLQlfX2xlMzIgY291bnRfdHhfbXVsdGlj
YXN0X2ZyYW1lczsKKwlfX2xlMzIgY291bnRfZHJvcF9wbGNwOworCV9fbGUzMiBjb3VudF9kcm9w
X2ZjczsKKwlfX2xlMzIgY291bnRfdHhfZnJhbWVzOworCV9fbGUzMiBjb3VudF9yeF9mcmFtZXM7
CisJX19sZTMyIGNvdW50X3J4X2ZyYW1lc19mYWlsZWQ7CisJX19sZTMyIGNvdW50X2Ryb3BfZGVj
cnlwdGlvbjsKKwlfX2xlMzIgY291bnRfZHJvcF90a2lwX21pYzsKKwlfX2xlMzIgY291bnRfZHJv
cF9ub19rZXk7CisJX19sZTMyIGNvdW50X3R4X2ZyYW1lc19tdWx0aWNhc3Q7CiAJX19sZTMyIGNv
dW50X3R4X2ZyYW1lc19zdWNjZXNzOwotCV9fbGUzMiBjb3VudF90eF9mcmFtZV9mYWlsdXJlczsK
KwlfX2xlMzIgY291bnRfdHhfZnJhbWVzX2ZhaWxlZDsKIAlfX2xlMzIgY291bnRfdHhfZnJhbWVz
X3JldHJpZWQ7CiAJX19sZTMyIGNvdW50X3R4X2ZyYW1lc19tdWx0aV9yZXRyaWVkOwotCV9fbGUz
MiBjb3VudF9yeF9mcmFtZV9kdXBsaWNhdGVzOworCV9fbGUzMiBjb3VudF9kcm9wX2R1cGxpY2F0
ZTsKIAlfX2xlMzIgY291bnRfcnRzX3N1Y2Nlc3M7Ci0JX19sZTMyIGNvdW50X3J0c19mYWlsdXJl
czsKLQlfX2xlMzIgY291bnRfYWNrX2ZhaWx1cmVzOwotCV9fbGUzMiBjb3VudF9yeF9tdWx0aWNh
c3RfZnJhbWVzOworCV9fbGUzMiBjb3VudF9ydHNfZmFpbGVkOworCV9fbGUzMiBjb3VudF9hY2tf
ZmFpbGVkOworCV9fbGUzMiBjb3VudF9yeF9mcmFtZXNfbXVsdGljYXN0OwogCV9fbGUzMiBjb3Vu
dF9yeF9mcmFtZXNfc3VjY2VzczsKLQlfX2xlMzIgY291bnRfcnhfY21hY2ljdl9lcnJvcnM7Ci0J
X19sZTMyIGNvdW50X3J4X2NtYWNfcmVwbGF5czsKLQlfX2xlMzIgY291bnRfcnhfbWdtdF9jY21w
X3JlcGxheXM7Ci0JX19sZTMyIGNvdW50X3J4X2JpcG1pY19lcnJvcnM7CisJX19sZTMyIGNvdW50
X2Ryb3BfY21hY19pY3Y7CisJX19sZTMyIGNvdW50X2Ryb3BfY21hY19yZXBsYXk7CisJX19sZTMy
IGNvdW50X2Ryb3BfY2NtcF9yZXBsYXk7CisJX19sZTMyIGNvdW50X2Ryb3BfYmlwX21pYzsKIH0g
X19wYWNrZWQ7CiAKIHN0cnVjdCBoaWZfbWliX21hY19hZGRyZXNzIHsKLS0gCjIuMzMuMAoK
