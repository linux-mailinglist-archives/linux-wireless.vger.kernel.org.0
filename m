Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4440FBBD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbhIQPRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 11:17:55 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:15403
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245070AbhIQPQ6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 11:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmVm5ShgAJfaNEMYKwhAyN5scmdnZQAa3MgeUaiF3Av0de9BpVhy0gXn43y22lfa/omLsJc+tk6wcOvag2hV2m0bXIbbz4nbG88Pc4DxvSeoeJf7Zpx/6ROOeFCJAKTPvgjev7Ij9T4gOl3AZxXINFan8P2E8pTcuSgRztAZOzlLAIByC2Wu3JYObTwp/Oq89EBlvZr29cT2KdbYOyIGhZMfk885hRaRQ6lRKdwdBbgNZWgh3iJ/XBTUtVGIN99p4lZGyt1HvMtawDtQ2kF3ExB8Ylo/wEXn1vp0Fbd8hMkkuTOPH4TqJR2ReUOpsmdgvKoF64wnP67XPtLtgYt/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=agdAC3VUVrwvu6B1Coi2+jA/vJB6/tC0zCloVaIaojU=;
 b=D5L4puuXU2pclo+gcplLRDQYqNNx6aeJ3DkplojLCJr4eyAE7PKXWfLsB5i7oTt4U7kEpCSZ1yv91Tf0vwl8I5QKJcgnlC/nbnrp0AmGDCrbsKUngPMeRyifRiPZyXd1t0l/TBL4a4LzmbDzd8/SlkYL4q1JZ33WL1dwM1tou6tm9KckTIXxJAB3mduRjxqiSToz8ewk35YrTDKCXy07uAMfFZIlv2rKeKil4ZV+XxQ2bmYYsyYMFIIigp7fmGDExZbKSQVcK0E1pW6GAgCysDS/q+YshPUObZt/x1ItZHZ6tz0NJkbQCVYzBarSQsuWtYIqLqjstXcSjOR628yp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agdAC3VUVrwvu6B1Coi2+jA/vJB6/tC0zCloVaIaojU=;
 b=S6c33euPo7/7P665te0EbLGRP/23x9YiLwwmIJf/Kc4+slktsqStnf/+P0iSBVBf/iCvUBnD8Amx9TBaF/WA2NCxQZCKqoLrVcn6pJEvSFdm17Fc8pBnsiLP3Gy487LWD7qL1IW+Oz+bpw85mM70vK27tLBl5xLp+S8i3X4xcQY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 15:14:36 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd%7]) with mapi id 15.20.4500.017; Fri, 17 Sep 2021
 15:14:36 +0000
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
Subject: [PATCH v6 07/24] wfx: add bus_spi.c
Date:   Fri, 17 Sep 2021 17:13:43 +0200
Message-Id: <20210917151401.2274772-8-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917151401.2274772-1-Jerome.Pouiller@silabs.com>
References: <20210917151401.2274772-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
Received: from pc-42.silabs.com (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by SA9PR03CA0029.namprd03.prod.outlook.com (2603:10b6:806:20::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 15:14:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2718d408-1c3d-454e-c478-08d979eddc35
X-MS-TrafficTypeDiagnostic: SA0PR11MB4574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR11MB4574F1F49539096285E0A2E993DD9@SA0PR11MB4574.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaKXFfzQXh2FqUkLD71CtkzNmgraamh22xwlxzf5wawk+jB5qc7+QtelIpESBixi0vzFXMH4x+6XD/u54hLA9hnCdQ9PLvg+rVY7tUklJR2Uu1kQeTMHEX4gGCCnK44/JrVqMQUcP3wduUE5SkJxyWK7HxBlOG3ameucndLQ0fs/sWLmduW6kOPwGNe6O+j357w1NTKlb/GBCKGEXduDQBh/f3qJvYlWdLoX1crIpOR+1om9G8NnPDynRyG9UXFI04Nwv5KW2rsFeJ+tcSH6V0F+A37QfS93Ctlq2gDfeDvnSpB9yCIzqph7BmKz0i2M7/6ux8vcpHbL7IiGKAixQDdVp5vqzANB8g2I9SZDu48BHOKC4hZyEzXfyPcXvKVuWXODnjSU5IqZfDvIY1Qxi0NHoOQr2SZv8G+/yP6GVrKhbTQHd5DA0kV7OuEfx+A4XlLaTIh0uWwESgkwtex2NoStAwpFjuEoXPz7xcYuYFtrBs6AaYTGKwOoagQqYUHFcVyP0Bg61xBu470xv695OIkHz9In1J7nuDXvqIlo2jP5oiAwAILdafiHBiOfwuIjJfhFRhwtzE6BkgWfavHxeaiAUoHWt7PkLHHP8cQc99PCJFx4815G9GxtjBdtTiL0VWN9gJupmn16tKr41xR0pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39850400004)(396003)(366004)(52116002)(6666004)(38100700002)(8936002)(7696005)(478600001)(6486002)(186003)(7416002)(86362001)(5660300002)(54906003)(66556008)(66476007)(4326008)(1076003)(66946007)(2616005)(107886003)(6916009)(316002)(36756003)(8676002)(66574015)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRkNTdMdzNNN0gzU3dRYWZpNWdmOW9tWWlzYVdQNEFhSUxHUkRPMDlzK0VY?=
 =?utf-8?B?WlRDSTNOS0pxTHJzZUljQUswb29hQ3JnWmllL1Z4YXhkTEJ6Y2Y0aitsT2FX?=
 =?utf-8?B?TlZLVlJxWDBRWnArNUVONEdWaVZmZXQzU3NSUTVTM3F3NmJKZ1UvdXJubVIz?=
 =?utf-8?B?ZlFOQVorRDFFdWNsWURFUnVOYkJqMzhod3NaT1VkaHl5MG5DSjhQd3UxY3Jl?=
 =?utf-8?B?SmNEeW5CYkdubDNUTngyeXQ4MS9JTzg2TWNDUmdRWnZtMXlrRXBlOVlOMUhp?=
 =?utf-8?B?VE1XcXVmelR1ZkpOWkxJbmJxNkZtb3lXdWNmMTRFYjQyNWtQZnF2dDlqRGdz?=
 =?utf-8?B?a0pGM2pXOXNadW1EbkhQWFFLVFY4VEVONnJUVlU0UlhEcDlNdGpUaGFqenNi?=
 =?utf-8?B?b2wyRldKd1Zvc1RxaUhRcnIxbTRncWJFT1NRN1R2emhQTnRQaE0xZTM2UHFz?=
 =?utf-8?B?R2RmNVN0Ym95VXVOUmJZOHJ1b3J4MHhYS3BlUmU5L0kvVUpkMi9xOC9IbFNu?=
 =?utf-8?B?a1JXMTZqb1UyUE9lU0c2V2dxOWpuQkM0MG1QYU5aZHBUbDl3OFJZMSt2RENL?=
 =?utf-8?B?WXNaSWtUNC9seWlRMm11SjFkZU04VEtyZFc4U2lhN2tPNXhBWmFHSjZjcnFn?=
 =?utf-8?B?cldrYkZrWFQvTlEwOWVmdlQyWGt2SUNjdWhtd1AyOG0vc0VwSmp5TEJHMWdy?=
 =?utf-8?B?akJYa3NEQk81SGxrc3hCWGZVa2NrKytlYTQrT3JwMHA5K2hBbkVBbXI3S2l5?=
 =?utf-8?B?LzBEOHFRdUh1TXg3T3k1VEw0KytUVnFRVUZMQTRVcmloSlNLVWUwMStIcWs4?=
 =?utf-8?B?SzJ4Smo4YlZzVW9IQlNmMzdxQ3VheFArVHpmZFJ3QTlkajFaNVJKZ1JRb1JN?=
 =?utf-8?B?ekRXb1ZVN1lFaFYvOWRQWElFZTRIdzMxMTc5RXc1c1dhODBrN256S3RUZDk4?=
 =?utf-8?B?TnRTcFNKT25yYSttT1lVREgxaGNNUlBUS1BvcGd6bHNOUkgreUExZ1NHaU1W?=
 =?utf-8?B?azJrcTVYR29Yc1p1MkFTVzg4SmRWbUVPaEQyaTlJUXJhTDFDVUtXTE1QbFBM?=
 =?utf-8?B?MThZODRQYlh6SHZHMFNLd2UzWUJCc09xRkIvbFM2Z1BibDA4RnZUSnB0dkdM?=
 =?utf-8?B?bVNQWVNQc2RlbzR3ZWlHK1ErN0N0c0grNzBrU2JoNklhTVRQQWN1WVRoNkwv?=
 =?utf-8?B?ZHltNHNBai93Yzc1WFRBbmUxQmRzQlY4L0Q0M1VjZ3VaWHJPUmpaVWxSbUUv?=
 =?utf-8?B?L3ZZRDJCR0JlU1l1dGMzbFJQQjRGbTRuVzZ1ZTBqVkYycCt5MkYzcVVGWGFI?=
 =?utf-8?B?VEEvY3J2a1FBcHhiR0d6Wm9EQXgyaUliTEhGbHU1U1BuK0tWK0ZFZWZCUDc5?=
 =?utf-8?B?SzU1RVZWalNvS3lYK3huU21yT0hJcFlITmZtRWZ2b3RzdGt6Nk5ocDUwZmF1?=
 =?utf-8?B?RE0vOFZXd3VyUHplcThOYmNCV1dNK0RIdzVNNVJvYmI5WDNweGRWRSs0TGFj?=
 =?utf-8?B?WlljT2wxQmdGVktwOTlFTUoxVW11K1pSMVZPSFNQNkJTOTFFSW5aZnRlSXNH?=
 =?utf-8?B?VjFnUE8rbFdzR2VERzQ1aG52N0J6U2tWWUxwNUI1SUd1cHRSUWFBSWxmVGpR?=
 =?utf-8?B?NC9pRkNqajJmam92SkVXTWxhWnIyTWc2a0hER2g1VVpUaiszMjJQZ2UxN25T?=
 =?utf-8?B?d01jWmx6MTVXQ0FHVUtEU2tudmVSUlVUZnRQdk1pOTVUVDYvSGFhVG10N2ZD?=
 =?utf-8?B?STBVTFBXcVhNbU41K1ZSQkFXTXBRUDZFQVNtazZpenhVS2JiK0RTK3ErZTAw?=
 =?utf-8?B?RjJMT1RKN3VIMFgzK2VIdUpPQXZpWHZyYUN4bUh1ZlM5YkFDd2NQdlpGZ3l3?=
 =?utf-8?Q?PeYWkZv93j2GQ?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2718d408-1c3d-454e-c478-08d979eddc35
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 15:14:36.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2Acsdr2GM4DdOa35JFq7Dfn7AX+mk1NM/4tZj8feBNUJA8nRNo5wDfIUCvu60gGwaAkJYcUjBP3c3biph/qVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jIHwgMjcxICsr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyNzEgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3Nw
aS5jCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc3Bp
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYwpuZXcgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjU1ZmZjZDdjNDJlMgotLS0gL2Rldi9udWxs
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCkBAIC0wLDAg
KzEsMjcxIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisvKgor
ICogU1BJIGludGVyZmFjZS4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwgU2lsaWNv
biBMYWJvcmF0b3JpZXMsIEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMSwgU2FncmFkIEluYy4K
KyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJpY3Nzb24KKyAqLworI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgvZ3Bp
by9jb25zdW1lci5oPgorI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4KKyNpbmNsdWRlIDxsaW51
eC9pbnRlcnJ1cHQuaD4KKyNpbmNsdWRlIDxsaW51eC9pcnEuaD4KKyNpbmNsdWRlIDxsaW51eC9v
Zi5oPgorCisjaW5jbHVkZSAiYnVzLmgiCisjaW5jbHVkZSAid2Z4LmgiCisjaW5jbHVkZSAiaHdp
by5oIgorI2luY2x1ZGUgIm1haW4uaCIKKyNpbmNsdWRlICJiaC5oIgorCisjZGVmaW5lIFNFVF9X
UklURSAweDdGRkYgICAgICAgIC8qIHVzYWdlOiBhbmQgb3BlcmF0aW9uICovCisjZGVmaW5lIFNF
VF9SRUFEIDB4ODAwMCAgICAgICAgIC8qIHVzYWdlOiBvciBvcGVyYXRpb24gKi8KKworI2RlZmlu
ZSBXRlhfUkVTRVRfSU5WRVJURUQgMQorCitzdGF0aWMgY29uc3Qgc3RydWN0IHdmeF9wbGF0Zm9y
bV9kYXRhIHdmeF9zcGlfcGRhdGEgPSB7CisJLmZpbGVfZncgPSAid2ZtX3dmMjAwIiwKKwkuZmls
ZV9wZHMgPSAid2YyMDAucGRzIiwKKwkudXNlX3Jpc2luZ19jbGsgPSB0cnVlLAorfTsKKworc3Ry
dWN0IHdmeF9zcGlfcHJpdiB7CisJc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmM7CisJc3RydWN0IHdm
eF9kZXYgKmNvcmU7CisJc3RydWN0IGdwaW9fZGVzYyAqZ3Bpb19yZXNldDsKKwlib29sIG5lZWRf
c3dhYjsKK307CisKKy8qIFRoZSBjaGlwIHJlYWRzIDE2Yml0cyBvZiBkYXRhIGF0IHRpbWUgYW5k
IHBsYWNlIHRoZW0gZGlyZWN0bHkgaW50byAobGl0dGxlCisgKiBlbmRpYW4pIENQVSByZWdpc3Rl
ci4gU28sIHRoZSBjaGlwIGV4cGVjdHMgYnl0ZXMgb3JkZXIgdG8gYmUgIkIxIEIwIEIzIEIyIgor
ICogKHdoaWxlIExFIGlzICJCMCBCMSBCMiBCMyIgYW5kIEJFIGlzICJCMyBCMiBCMSBCMCIpCisg
KgorICogQSBsaXR0bGUgZW5kaWFuIGhvc3Qgd2l0aCBiaXRzX3Blcl93b3JkID09IDE2IHNob3Vs
ZCBkbyB0aGUgcmlnaHQgam9iCisgKiBuYXRpdmVseS4gVGhlIGNvZGUgYmVsb3cgdG8gc3VwcG9y
dCBiaWcgZW5kaWFuIGhvc3QgYW5kIGNvbW1vbmx5IHVzZWQgU1BJCisgKiA4Yml0cy4KKyAqLwor
c3RhdGljIGludCB3Znhfc3BpX2NvcHlfZnJvbV9pbyh2b2lkICpwcml2LCB1bnNpZ25lZCBpbnQg
YWRkciwKKwkJCQl2b2lkICpkc3QsIHNpemVfdCBjb3VudCkKK3sKKwlzdHJ1Y3Qgd2Z4X3NwaV9w
cml2ICpidXMgPSBwcml2OworCXUxNiByZWdhZGRyID0gKGFkZHIgPDwgMTIpIHwgKGNvdW50IC8g
MikgfCBTRVRfUkVBRDsKKwlzdHJ1Y3Qgc3BpX21lc3NhZ2UgICAgICBtOworCXN0cnVjdCBzcGlf
dHJhbnNmZXIgICAgIHRfYWRkciA9IHsKKwkJLnR4X2J1ZiAgICAgICAgID0gJnJlZ2FkZHIsCisJ
CS5sZW4gICAgICAgICAgICA9IHNpemVvZihyZWdhZGRyKSwKKwl9OworCXN0cnVjdCBzcGlfdHJh
bnNmZXIgICAgIHRfbXNnID0geworCQkucnhfYnVmICAgICAgICAgPSBkc3QsCisJCS5sZW4gICAg
ICAgICAgICA9IGNvdW50LAorCX07CisJdTE2ICpkc3QxNiA9IGRzdDsKKwlpbnQgcmV0LCBpOwor
CisJV0FSTihjb3VudCAlIDIsICJidWZmZXIgc2l6ZSBtdXN0IGJlIGEgbXVsdGlwbGUgb2YgMiIp
OworCisJY3B1X3RvX2xlMTZzKCZyZWdhZGRyKTsKKwlpZiAoYnVzLT5uZWVkX3N3YWIpCisJCXN3
YWIxNnMoJnJlZ2FkZHIpOworCisJc3BpX21lc3NhZ2VfaW5pdCgmbSk7CisJc3BpX21lc3NhZ2Vf
YWRkX3RhaWwoJnRfYWRkciwgJm0pOworCXNwaV9tZXNzYWdlX2FkZF90YWlsKCZ0X21zZywgJm0p
OworCXJldCA9IHNwaV9zeW5jKGJ1cy0+ZnVuYywgJm0pOworCisJaWYgKGJ1cy0+bmVlZF9zd2Fi
ICYmIGFkZHIgPT0gV0ZYX1JFR19DT05GSUcpCisJCWZvciAoaSA9IDA7IGkgPCBjb3VudCAvIDI7
IGkrKykKKwkJCXN3YWIxNnMoJmRzdDE2W2ldKTsKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMg
aW50IHdmeF9zcGlfY29weV90b19pbyh2b2lkICpwcml2LCB1bnNpZ25lZCBpbnQgYWRkciwKKwkJ
CSAgICAgIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IGNvdW50KQoreworCXN0cnVjdCB3Znhfc3Bp
X3ByaXYgKmJ1cyA9IHByaXY7CisJdTE2IHJlZ2FkZHIgPSAoYWRkciA8PCAxMikgfCAoY291bnQg
LyAyKTsKKwkvKiBGSVhNRTogdXNlIGEgYm91bmNlIGJ1ZmZlciAqLworCXUxNiAqc3JjMTYgPSAo
dm9pZCAqKXNyYzsKKwlpbnQgcmV0LCBpOworCXN0cnVjdCBzcGlfbWVzc2FnZSAgICAgIG07CisJ
c3RydWN0IHNwaV90cmFuc2ZlciAgICAgdF9hZGRyID0geworCQkudHhfYnVmICAgICAgICAgPSAm
cmVnYWRkciwKKwkJLmxlbiAgICAgICAgICAgID0gc2l6ZW9mKHJlZ2FkZHIpLAorCX07CisJc3Ry
dWN0IHNwaV90cmFuc2ZlciAgICAgdF9tc2cgPSB7CisJCS50eF9idWYgICAgICAgICA9IHNyYywK
KwkJLmxlbiAgICAgICAgICAgID0gY291bnQsCisJfTsKKworCVdBUk4oY291bnQgJSAyLCAiYnVm
ZmVyIHNpemUgbXVzdCBiZSBhIG11bHRpcGxlIG9mIDIiKTsKKwlXQVJOKHJlZ2FkZHIgJiBTRVRf
UkVBRCwgImJhZCBhZGRyIG9yIHNpemUgb3ZlcmZsb3ciKTsKKworCWNwdV90b19sZTE2cygmcmVn
YWRkcik7CisKKwkvKiBSZWdpc3RlciBhZGRyZXNzIGFuZCBDT05GSUcgY29udGVudCBhbHdheXMg
dXNlIDE2Yml0IGJpZyBlbmRpYW4KKwkgKiAoIkJBREMiIG9yZGVyKQorCSAqLworCWlmIChidXMt
Pm5lZWRfc3dhYikKKwkJc3dhYjE2cygmcmVnYWRkcik7CisJaWYgKGJ1cy0+bmVlZF9zd2FiICYm
IGFkZHIgPT0gV0ZYX1JFR19DT05GSUcpCisJCWZvciAoaSA9IDA7IGkgPCBjb3VudCAvIDI7IGkr
KykKKwkJCXN3YWIxNnMoJnNyYzE2W2ldKTsKKworCXNwaV9tZXNzYWdlX2luaXQoJm0pOworCXNw
aV9tZXNzYWdlX2FkZF90YWlsKCZ0X2FkZHIsICZtKTsKKwlzcGlfbWVzc2FnZV9hZGRfdGFpbCgm
dF9tc2csICZtKTsKKwlyZXQgPSBzcGlfc3luYyhidXMtPmZ1bmMsICZtKTsKKworCWlmIChidXMt
Pm5lZWRfc3dhYiAmJiBhZGRyID09IFdGWF9SRUdfQ09ORklHKQorCQlmb3IgKGkgPSAwOyBpIDwg
Y291bnQgLyAyOyBpKyspCisJCQlzd2FiMTZzKCZzcmMxNltpXSk7CisJcmV0dXJuIHJldDsKK30K
Kworc3RhdGljIHZvaWQgd2Z4X3NwaV9sb2NrKHZvaWQgKnByaXYpCit7Cit9CisKK3N0YXRpYyB2
b2lkIHdmeF9zcGlfdW5sb2NrKHZvaWQgKnByaXYpCit7Cit9CisKK3N0YXRpYyBpcnFyZXR1cm5f
dCB3Znhfc3BpX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKnByaXYpCit7CisJc3RydWN0IHdm
eF9zcGlfcHJpdiAqYnVzID0gcHJpdjsKKworCXdmeF9iaF9yZXF1ZXN0X3J4KGJ1cy0+Y29yZSk7
CisJcmV0dXJuIElSUV9IQU5ETEVEOworfQorCitzdGF0aWMgaW50IHdmeF9zcGlfaXJxX3N1YnNj
cmliZSh2b2lkICpwcml2KQoreworCXN0cnVjdCB3Znhfc3BpX3ByaXYgKmJ1cyA9IHByaXY7CisJ
dTMyIGZsYWdzOworCisJZmxhZ3MgPSBpcnFfZ2V0X3RyaWdnZXJfdHlwZShidXMtPmZ1bmMtPmly
cSk7CisJaWYgKCFmbGFncykKKwkJZmxhZ3MgPSBJUlFGX1RSSUdHRVJfSElHSDsKKwlmbGFncyB8
PSBJUlFGX09ORVNIT1Q7CisJcmV0dXJuIGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoJmJ1cy0+
ZnVuYy0+ZGV2LCBidXMtPmZ1bmMtPmlycSwgTlVMTCwKKwkJCQkJIHdmeF9zcGlfaXJxX2hhbmRs
ZXIsIElSUUZfT05FU0hPVCwKKwkJCQkJICJ3ZngiLCBidXMpOworfQorCitzdGF0aWMgaW50IHdm
eF9zcGlfaXJxX3Vuc3Vic2NyaWJlKHZvaWQgKnByaXYpCit7CisJc3RydWN0IHdmeF9zcGlfcHJp
diAqYnVzID0gcHJpdjsKKworCWRldm1fZnJlZV9pcnEoJmJ1cy0+ZnVuYy0+ZGV2LCBidXMtPmZ1
bmMtPmlycSwgYnVzKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHNpemVfdCB3Znhfc3BpX2Fs
aWduX3NpemUodm9pZCAqcHJpdiwgc2l6ZV90IHNpemUpCit7CisJLyogTW9zdCBvZiBTUEkgY29u
dHJvbGxlcnMgYXZvaWQgRE1BIGlmIGJ1ZmZlciBzaXplIGlzIG5vdCAzMmJpdCBhbGlnbmVkCisJ
ICovCisJcmV0dXJuIEFMSUdOKHNpemUsIDQpOworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGh3
YnVzX29wcyB3Znhfc3BpX2h3YnVzX29wcyA9IHsKKwkuY29weV9mcm9tX2lvID0gd2Z4X3NwaV9j
b3B5X2Zyb21faW8sCisJLmNvcHlfdG9faW8gPSB3Znhfc3BpX2NvcHlfdG9faW8sCisJLmlycV9z
dWJzY3JpYmUgPSB3Znhfc3BpX2lycV9zdWJzY3JpYmUsCisJLmlycV91bnN1YnNjcmliZSA9IHdm
eF9zcGlfaXJxX3Vuc3Vic2NyaWJlLAorCS5sb2NrCQkJPSB3Znhfc3BpX2xvY2ssCisJLnVubG9j
awkJCT0gd2Z4X3NwaV91bmxvY2ssCisJLmFsaWduX3NpemUJCT0gd2Z4X3NwaV9hbGlnbl9zaXpl
LAorfTsKKworc3RhdGljIGludCB3Znhfc3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpmdW5j
KQoreworCXN0cnVjdCB3Znhfc3BpX3ByaXYgKmJ1czsKKwlpbnQgcmV0OworCisJaWYgKCFmdW5j
LT5iaXRzX3Blcl93b3JkKQorCQlmdW5jLT5iaXRzX3Blcl93b3JkID0gMTY7CisJcmV0ID0gc3Bp
X3NldHVwKGZ1bmMpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisJLyogVHJhY2UgYmVsb3cg
aXMgYWxzbyBkaXNwbGF5ZWQgYnkgc3BpX3NldHVwKCkgaWYgY29tcGlsZWQgd2l0aCBERUJVRyAq
LworCWRldl9kYmcoJmZ1bmMtPmRldiwgIlNQSSBwYXJhbXM6IENTPSVkLCBtb2RlPSVkIGJpdHMv
d29yZD0lZCBzcGVlZD0lZFxuIiwKKwkJZnVuYy0+Y2hpcF9zZWxlY3QsIGZ1bmMtPm1vZGUsIGZ1
bmMtPmJpdHNfcGVyX3dvcmQsCisJCWZ1bmMtPm1heF9zcGVlZF9oeik7CisJaWYgKGZ1bmMtPmJp
dHNfcGVyX3dvcmQgIT0gMTYgJiYgZnVuYy0+Yml0c19wZXJfd29yZCAhPSA4KQorCQlkZXZfd2Fy
bigmZnVuYy0+ZGV2LCAidW51c3VhbCBiaXRzL3dvcmQgdmFsdWU6ICVkXG4iLAorCQkJIGZ1bmMt
PmJpdHNfcGVyX3dvcmQpOworCWlmIChmdW5jLT5tYXhfc3BlZWRfaHogPiA1MDAwMDAwMCkKKwkJ
ZGV2X3dhcm4oJmZ1bmMtPmRldiwgIiVkSHogaXMgYSB2ZXJ5IGhpZ2ggc3BlZWRcbiIsCisJCQkg
ZnVuYy0+bWF4X3NwZWVkX2h6KTsKKworCWJ1cyA9IGRldm1fa3phbGxvYygmZnVuYy0+ZGV2LCBz
aXplb2YoKmJ1cyksIEdGUF9LRVJORUwpOworCWlmICghYnVzKQorCQlyZXR1cm4gLUVOT01FTTsK
KwlidXMtPmZ1bmMgPSBmdW5jOworCWlmIChmdW5jLT5iaXRzX3Blcl93b3JkID09IDggfHwgSVNf
RU5BQkxFRChDT05GSUdfQ1BVX0JJR19FTkRJQU4pKQorCQlidXMtPm5lZWRfc3dhYiA9IHRydWU7
CisJc3BpX3NldF9kcnZkYXRhKGZ1bmMsIGJ1cyk7CisKKwlidXMtPmdwaW9fcmVzZXQgPSBkZXZt
X2dwaW9kX2dldF9vcHRpb25hbCgmZnVuYy0+ZGV2LCAicmVzZXQiLAorCQkJCQkJICBHUElPRF9P
VVRfTE9XKTsKKwlpZiAoSVNfRVJSKGJ1cy0+Z3Bpb19yZXNldCkpCisJCXJldHVybiBQVFJfRVJS
KGJ1cy0+Z3Bpb19yZXNldCk7CisJaWYgKCFidXMtPmdwaW9fcmVzZXQpIHsKKwkJZGV2X3dhcm4o
JmZ1bmMtPmRldiwKKwkJCSAiZ3BpbyByZXNldCBpcyBub3QgZGVmaW5lZCwgdHJ5aW5nIHRvIGxv
YWQgZmlybXdhcmUgYW55d2F5XG4iKTsKKwl9IGVsc2UgeworCQlncGlvZF9zZXRfY29uc3VtZXJf
bmFtZShidXMtPmdwaW9fcmVzZXQsICJ3ZnggcmVzZXQiKTsKKwkJaWYgKHNwaV9nZXRfZGV2aWNl
X2lkKGZ1bmMpLT5kcml2ZXJfZGF0YSAmIFdGWF9SRVNFVF9JTlZFUlRFRCkKKwkJCWdwaW9kX3Rv
Z2dsZV9hY3RpdmVfbG93KGJ1cy0+Z3Bpb19yZXNldCk7CisJCWdwaW9kX3NldF92YWx1ZV9jYW5z
bGVlcChidXMtPmdwaW9fcmVzZXQsIDEpOworCQl1c2xlZXBfcmFuZ2UoMTAwLCAxNTApOworCQln
cGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoYnVzLT5ncGlvX3Jlc2V0LCAwKTsKKwkJdXNsZWVwX3Jh
bmdlKDIwMDAsIDI1MDApOworCX0KKworCWJ1cy0+Y29yZSA9IHdmeF9pbml0X2NvbW1vbigmZnVu
Yy0+ZGV2LCAmd2Z4X3NwaV9wZGF0YSwKKwkJCQkgICAgJndmeF9zcGlfaHdidXNfb3BzLCBidXMp
OworCWlmICghYnVzLT5jb3JlKQorCQlyZXR1cm4gLUVJTzsKKworCXJldHVybiB3ZnhfcHJvYmUo
YnVzLT5jb3JlKTsKK30KKworc3RhdGljIGludCB3Znhfc3BpX3JlbW92ZShzdHJ1Y3Qgc3BpX2Rl
dmljZSAqZnVuYykKK3sKKwlzdHJ1Y3Qgd2Z4X3NwaV9wcml2ICpidXMgPSBzcGlfZ2V0X2RydmRh
dGEoZnVuYyk7CisKKwl3ZnhfcmVsZWFzZShidXMtPmNvcmUpOworCXJldHVybiAwOworfQorCisv
KiBGb3IgZHluYW1pYyBkcml2ZXIgYmluZGluZywga2VybmVsIGRvZXMgbm90IHVzZSBPRiB0byBt
YXRjaCBkcml2ZXIuIEl0IG9ubHkKKyAqIHVzZSBtb2RhbGlhcyBhbmQgbW9kYWxpYXMgaXMgYSBj
b3B5IG9mICdjb21wYXRpYmxlJyBEVCBub2RlIHdpdGggdmVuZG9yCisgKiBzdHJpcHBlZC4KKyAq
Lworc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIHdmeF9zcGlfaWRbXSA9IHsKKwl7
ICJ3Zngtc3BpIiwgV0ZYX1JFU0VUX0lOVkVSVEVEIH0sCisJeyAid2YyMDAiLCAwIH0sCisJeyB9
LAorfTsKK01PRFVMRV9ERVZJQ0VfVEFCTEUoc3BpLCB3Znhfc3BpX2lkKTsKKworI2lmZGVmIENP
TkZJR19PRgorc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgd2Z4X3NwaV9vZl9tYXRj
aFtdID0geworCXsgLmNvbXBhdGlibGUgPSAic2lsYWJzLHdmeC1zcGkiLCAuZGF0YSA9ICh2b2lk
ICopV0ZYX1JFU0VUX0lOVkVSVEVEIH0sCisJeyAuY29tcGF0aWJsZSA9ICJzaWxhYnMsd2YyMDAi
IH0sCisJeyB9LAorfTsKK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHdmeF9zcGlfb2ZfbWF0Y2gp
OworI2VuZGlmCisKK3N0cnVjdCBzcGlfZHJpdmVyIHdmeF9zcGlfZHJpdmVyID0geworCS5kcml2
ZXIgPSB7CisJCS5uYW1lID0gIndmeC1zcGkiLAorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRj
aF9wdHIod2Z4X3NwaV9vZl9tYXRjaCksCisJfSwKKwkuaWRfdGFibGUgPSB3Znhfc3BpX2lkLAor
CS5wcm9iZSA9IHdmeF9zcGlfcHJvYmUsCisJLnJlbW92ZSA9IHdmeF9zcGlfcmVtb3ZlLAorfTsK
LS0gCjIuMzMuMAoK
