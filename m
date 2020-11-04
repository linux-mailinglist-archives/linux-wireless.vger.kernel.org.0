Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A092A68B1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 16:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgKDPzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 10:55:04 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:54240
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731226AbgKDPyJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 10:54:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZtQ6XVHnY6BYbel55EMpkw8R8zvNBrWcqAnyfm49TV9OOekaLA5tcn0pmEvqzVDwP/n9XOGorbZgVXw/DMm6hAplJgIfJH5tNCHYlk30AClF7yLzbUc/me2zNpq6zl+rCujY/CyLU0yk1JWJ9G1DffhoFizpLG+AEJVb54eHWQO0MIegPMKV8muI9qMZbO+SNMXqPS0Pqv2eUYBmKORnY8UtXcTkZeOyWoV6Xdp02QrYkG+EzYFcSXAB6xiUHt9xm79CUSdtAjcKo6ynN2gbOEzoZOHLhiIiZAbVV1dJ7qlh0LbKxHALbV2vW1W72y1jWIPcMWEzf6OuLdjKOTRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzx7GjJTdUPKiaaRd4bh260anBlAccYiK+Ov2BmVArQ=;
 b=gMkNFLZkjuYim2Q2OqWvYmtkyfz7FvWQflwDAULGcQdCx1WKvu/+jN8HOtvxUhLB9QHXWFPYDeWy2h3DcWqD1NiQ0mbSJl80hfrTgMStNWvSZIRjDMoRO7a/OL+H5dj1xanq5MXHhwGZ2U+KBS8ylqLaiCXvHTSHzmY49dDmq/OiDf4N4l9s2U8rDBUesNDsgqRBuTYVRacftJstFjBySGeCEQm1T3DftL34yc+pRvfhSRFNwgXQxmMH/9g4NX+SKsrmCkW5TVEYBVxn47FgNbivd8h7yA4BGZT512oJRYTppANmhXetHMUCzuy8DjNBZesKDKQbucaz/pQG7xN7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzx7GjJTdUPKiaaRd4bh260anBlAccYiK+Ov2BmVArQ=;
 b=TnOvi9U1gLW0Yfi8eZ3QsJFJVODuMgxWODjFmgQnAnhtTp6oDV0PN9S/sSJRE2MRi8CJN9Vg9Ai/gMdPMwlGUPhGmZTtZbJAYesuEgTzJ5nB3QrymCF2kHooeV1nyEOP7LX4EmWbWnq8YcTx2XOsiN6BtFdIuzTuDC13rN4yZTo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32; Wed, 4 Nov
 2020 15:53:09 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::4f5:fbe5:44a7:cb8a%5]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:53:09 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 21/24] wfx: add debug.c/debug.h
Date:   Wed,  4 Nov 2020 16:52:04 +0100
Message-Id: <20201104155207.128076-22-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104155207.128076-1-Jerome.Pouiller@silabs.com>
References: <20201104155207.128076-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Originating-IP: [82.67.86.106]
X-ClientProxiedBy: SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45)
 To SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.silabs.com (82.67.86.106) by SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:53:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a990c66c-2dc9-4649-7a3b-08d880d9ba24
X-MS-TrafficTypeDiagnostic: SN6PR11MB2718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB2718AE991D35F8BB405C43AE93EF0@SN6PR11MB2718.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ttSELqhggrOuo2/nbKCBEJzc8hJeBBsUVgxQ4cKKjrvgthA1rGk4R8EfetaR2f19DXuyBT4G0fYxzqzxKzIHFNH4NL+fTYEc9Cm5Sbu3YZAZy5VQLChVX3948B4wQ3QdAB1Oy1CWHDUVUy83QC1wYIDJH/SPRJXhqDwrcmSaAiBF7zzah1e1oggyEjRipmCRy+Q2jApHE7rZnph7qAzanz4gTMQUxI1VBV+ntwF84zWtv0B/a8Kn/m7qfK2hh4LAnBhBsXUdSFqKsKtnjivkkiRWGzGjf6U7Vg6ZWkB06r5HXzKihJrKBPYhEkNM0x6UKq0iqVMR4T1Zrv/fLzKJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39850400004)(136003)(396003)(8936002)(478600001)(186003)(16526019)(956004)(2616005)(6486002)(8676002)(66574015)(66476007)(66556008)(66946007)(316002)(7696005)(6666004)(83380400001)(26005)(54906003)(107886003)(30864003)(36756003)(52116002)(7416002)(4326008)(5660300002)(86362001)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: usfcgO9Cs0shBF5xYyO73TXzFe6rLMtW0RXhl67owijNg2986NSs2n2i/JVnNXWKwYsvKXDis8o1MSLDro/gGFOpa0UWT9H+LXBiifcNVbO82QVS6Eeh4AD8J+nxZ2aJmcDUR45a6n/9OEARRX6VCjk8mnBdKDGy28CFyokkVXeehAZsWTREdURuGeOhtzmqCJG8ape5Fljo6u8BPNYE4UYAefptTeIxLAPwXCmmxH8uGFSwuKLxNHXNKiEPGJVOELUY64D1oEuj30+x0H7pdWi2H+VZpWxXBdAn1cljxahO+8BNDoRoKMQPHUwUyorpa7eKAGVMEIpV96HPiIweQFbQVTFvO94T5g+Yp5YMT7kvBeOK7JTHUQ5mkDnHqblIxEDAAG3fMdGFZ65LkSL0tR+I16L2rh+1sXnAQTfFzCQNlIChsdRMxaetbamywcbD5VNs8IlAH2ZEKgQqoMnl3GvFJLJEf7LuHWDMEVYn7LjWWji4nz1K/yt5FbVmXnG+vLGnT8cyXKFpnmUMterya+cy2CTf2lhuk8Yh4LKxgwp40vJXzl2sfTvzKq8pA003z+ERPIoA2xSE/LDiXNVSmdZqa25ZIzoSloKZRE2MmfViZ4P0y9NrDD6qzs/Gx5qpy5nvlDf1m4MuNSlHuu5L/A==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a990c66c-2dc9-4649-7a3b-08d880d9ba24
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:53:09.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1mg/Z09Vki/hZaicwOtLF3vniYSsl+feDWo+kIkRMnYMeCpjtDVMgcitvMPA0vIrOJyyPaAFEA4HJFbEx4S6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2718
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYyB8IDM1OSArKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVi
dWcuaCB8ICAxOSArKwogMiBmaWxlcyBjaGFuZ2VkLCAzNzggaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaAoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMDAuLmVlZGFkYTc4YzI1ZgotLS0gL2Rldi9udWxsCisrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuYwpAQCAtMCwwICsxLDM1OSBAQAor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQorLyoKKyAqIERlYnVnZnMg
aW50ZXJmYWNlLgorICoKKyAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExhYm9y
YXRvcmllcywgSW5jLgorICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgorICovCisj
aW5jbHVkZSA8bGludXgvZGVidWdmcy5oPgorI2luY2x1ZGUgPGxpbnV4L3NlcV9maWxlLmg+Cisj
aW5jbHVkZSA8bGludXgvY3JjMzIuaD4KKworI2luY2x1ZGUgImRlYnVnLmgiCisjaW5jbHVkZSAi
d2Z4LmgiCisjaW5jbHVkZSAic3RhLmgiCisjaW5jbHVkZSAibWFpbi5oIgorI2luY2x1ZGUgImhp
Zl90eC5oIgorI2luY2x1ZGUgImhpZl90eF9taWIuaCIKKworI2RlZmluZSBDUkVBVEVfVFJBQ0Vf
UE9JTlRTCisjaW5jbHVkZSAidHJhY2VzLmgiCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdHJhY2Vf
cHJpbnRfZmxhZ3MgaGlmX21zZ19wcmludF9tYXBbXSA9IHsKKwloaWZfbXNnX2xpc3QsCit9Owor
CitzdGF0aWMgY29uc3Qgc3RydWN0IHRyYWNlX3ByaW50X2ZsYWdzIGhpZl9taWJfcHJpbnRfbWFw
W10gPSB7CisJaGlmX21pYl9saXN0LAorfTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCB0cmFjZV9w
cmludF9mbGFncyB3ZnhfcmVnX3ByaW50X21hcFtdID0geworCXdmeF9yZWdfbGlzdCwKK307CisK
K3N0YXRpYyBjb25zdCBjaGFyICpnZXRfc3ltYm9sKHVuc2lnbmVkIGxvbmcgdmFsLAorCQkJICAg
ICAgY29uc3Qgc3RydWN0IHRyYWNlX3ByaW50X2ZsYWdzICpzeW1ib2xfYXJyYXkpCit7CisJaW50
IGk7CisKKwlmb3IgKGkgPSAwOyBzeW1ib2xfYXJyYXlbaV0ubWFzayAhPSAtMTsgaSsrKSB7CisJ
CWlmICh2YWwgPT0gc3ltYm9sX2FycmF5W2ldLm1hc2spCisJCQlyZXR1cm4gc3ltYm9sX2FycmF5
W2ldLm5hbWU7CisJfQorCisJcmV0dXJuICJ1bmtub3duIjsKK30KKworY29uc3QgY2hhciAqZ2V0
X2hpZl9uYW1lKHVuc2lnbmVkIGxvbmcgaWQpCit7CisJcmV0dXJuIGdldF9zeW1ib2woaWQsIGhp
Zl9tc2dfcHJpbnRfbWFwKTsKK30KKworY29uc3QgY2hhciAqZ2V0X21pYl9uYW1lKHVuc2lnbmVk
IGxvbmcgaWQpCit7CisJcmV0dXJuIGdldF9zeW1ib2woaWQsIGhpZl9taWJfcHJpbnRfbWFwKTsK
K30KKworY29uc3QgY2hhciAqZ2V0X3JlZ19uYW1lKHVuc2lnbmVkIGxvbmcgaWQpCit7CisJcmV0
dXJuIGdldF9zeW1ib2woaWQsIHdmeF9yZWdfcHJpbnRfbWFwKTsKK30KKworc3RhdGljIGludCB3
ZnhfY291bnRlcnNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikKK3sKKwlpbnQg
cmV0LCBpOworCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2ID0gc2VxLT5wcml2YXRlOworCXN0cnVjdCBo
aWZfbWliX2V4dGVuZGVkX2NvdW50X3RhYmxlIGNvdW50ZXJzWzNdOworCisJZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUoY291bnRlcnMpOyBpKyspIHsKKwkJcmV0ID0gaGlmX2dldF9jb3VudGVy
c190YWJsZSh3ZGV2LCBpLCBjb3VudGVycyArIGkpOworCQlpZiAocmV0IDwgMCkKKwkJCXJldHVy
biByZXQ7CisJCWlmIChyZXQgPiAwKQorCQkJcmV0dXJuIC1FSU87CisJfQorCisJc2VxX3ByaW50
ZihzZXEsICIlLTI0cyAlMTJzICUxMnMgJTEyc1xuIiwKKwkJICAgIiIsICJnbG9iYWwiLCAiaWZh
Y2UgMCIsICJpZmFjZSAxIik7CisKKyNkZWZpbmUgUFVUX0NPVU5URVIobmFtZSkgXAorCXNlcV9w
cmludGYoc2VxLCAiJS0yNHMgJTEyZCAlMTJkICUxMmRcbiIsICNuYW1lLCBcCisJCSAgIGxlMzJf
dG9fY3B1KGNvdW50ZXJzWzJdLmNvdW50XyMjbmFtZSksIFwKKwkJICAgbGUzMl90b19jcHUoY291
bnRlcnNbMF0uY291bnRfIyNuYW1lKSwgXAorCQkgICBsZTMyX3RvX2NwdShjb3VudGVyc1sxXS5j
b3VudF8jI25hbWUpKQorCisJUFVUX0NPVU5URVIodHhfcGFja2V0cyk7CisJUFVUX0NPVU5URVIo
dHhfbXVsdGljYXN0X2ZyYW1lcyk7CisJUFVUX0NPVU5URVIodHhfZnJhbWVzX3N1Y2Nlc3MpOwor
CVBVVF9DT1VOVEVSKHR4X2ZyYW1lX2ZhaWx1cmVzKTsKKwlQVVRfQ09VTlRFUih0eF9mcmFtZXNf
cmV0cmllZCk7CisJUFVUX0NPVU5URVIodHhfZnJhbWVzX211bHRpX3JldHJpZWQpOworCisJUFVU
X0NPVU5URVIocnRzX3N1Y2Nlc3MpOworCVBVVF9DT1VOVEVSKHJ0c19mYWlsdXJlcyk7CisJUFVU
X0NPVU5URVIoYWNrX2ZhaWx1cmVzKTsKKworCVBVVF9DT1VOVEVSKHJ4X3BhY2tldHMpOworCVBV
VF9DT1VOVEVSKHJ4X2ZyYW1lc19zdWNjZXNzKTsKKwlQVVRfQ09VTlRFUihyeF9wYWNrZXRfZXJy
b3JzKTsKKwlQVVRfQ09VTlRFUihwbGNwX2Vycm9ycyk7CisJUFVUX0NPVU5URVIoZmNzX2Vycm9y
cyk7CisJUFVUX0NPVU5URVIocnhfZGVjcnlwdGlvbl9mYWlsdXJlcyk7CisJUFVUX0NPVU5URVIo
cnhfbWljX2ZhaWx1cmVzKTsKKwlQVVRfQ09VTlRFUihyeF9ub19rZXlfZmFpbHVyZXMpOworCVBV
VF9DT1VOVEVSKHJ4X2ZyYW1lX2R1cGxpY2F0ZXMpOworCVBVVF9DT1VOVEVSKHJ4X211bHRpY2Fz
dF9mcmFtZXMpOworCVBVVF9DT1VOVEVSKHJ4X2NtYWNpY3ZfZXJyb3JzKTsKKwlQVVRfQ09VTlRF
UihyeF9jbWFjX3JlcGxheXMpOworCVBVVF9DT1VOVEVSKHJ4X21nbXRfY2NtcF9yZXBsYXlzKTsK
KworCVBVVF9DT1VOVEVSKHJ4X2JlYWNvbik7CisJUFVUX0NPVU5URVIobWlzc19iZWFjb24pOwor
CisjdW5kZWYgUFVUX0NPVU5URVIKKworCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNvdW50
ZXJzWzBdLnJlc2VydmVkKTsgaSsrKQorCQlzZXFfcHJpbnRmKHNlcSwgInJlc2VydmVkWyUwMmRd
JTEycyAlMTJkICUxMmQgJTEyZFxuIiwgaSwgIiIsCisJCQkgICBsZTMyX3RvX2NwdShjb3VudGVy
c1syXS5yZXNlcnZlZFtpXSksCisJCQkgICBsZTMyX3RvX2NwdShjb3VudGVyc1swXS5yZXNlcnZl
ZFtpXSksCisJCQkgICBsZTMyX3RvX2NwdShjb3VudGVyc1sxXS5yZXNlcnZlZFtpXSkpOworCisJ
cmV0dXJuIDA7Cit9CitERUZJTkVfU0hPV19BVFRSSUJVVEUod2Z4X2NvdW50ZXJzKTsKKworc3Rh
dGljIGNvbnN0IGNoYXIgKiBjb25zdCBjaGFubmVsX25hbWVzW10gPSB7CisJWzBdID0gIjFNIiwK
KwlbMV0gPSAiMk0iLAorCVsyXSA9ICI1LjVNIiwKKwlbM10gPSAiMTFNIiwKKwkvKiBFbnRyaWVz
IDQgYW5kIDUgZG9lcyBub3QgZXhpc3QgKi8KKwlbNl0gPSAiNk0iLAorCVs3XSA9ICI5TSIsCisJ
WzhdID0gIjEyTSIsCisJWzldID0gIjE4TSIsCisJWzEwXSA9ICIyNE0iLAorCVsxMV0gPSAiMzZN
IiwKKwlbMTJdID0gIjQ4TSIsCisJWzEzXSA9ICI1NE0iLAorCVsxNF0gPSAiTUNTMCIsCisJWzE1
XSA9ICJNQ1MxIiwKKwlbMTZdID0gIk1DUzIiLAorCVsxN10gPSAiTUNTMyIsCisJWzE4XSA9ICJN
Q1M0IiwKKwlbMTldID0gIk1DUzUiLAorCVsyMF0gPSAiTUNTNiIsCisJWzIxXSA9ICJNQ1M3IiwK
K307CisKK3N0YXRpYyBpbnQgd2Z4X3J4X3N0YXRzX3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEs
IHZvaWQgKnYpCit7CisJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBzZXEtPnByaXZhdGU7CisJc3Ry
dWN0IGhpZl9yeF9zdGF0cyAqc3QgPSAmd2Rldi0+cnhfc3RhdHM7CisJaW50IGk7CisKKwltdXRl
eF9sb2NrKCZ3ZGV2LT5yeF9zdGF0c19sb2NrKTsKKwlzZXFfcHJpbnRmKHNlcSwgIlRpbWVzdGFt
cDogJWR1c1xuIiwgc3QtPmRhdGUpOworCXNlcV9wcmludGYoc2VxLCAiTG93IHBvd2VyIGNsb2Nr
OiBmcmVxdWVuY3kgJXVIeiwgZXh0ZXJuYWwgJXNcbiIsCisJCSAgIGxlMzJfdG9fY3B1KHN0LT5w
d3JfY2xrX2ZyZXEpLAorCQkgICBzdC0+aXNfZXh0X3B3cl9jbGsgPyAieWVzIiA6ICJubyIpOwor
CXNlcV9wcmludGYoc2VxLAorCQkgICAiTnVtLiBvZiBmcmFtZXM6ICVkLCBQRVIgKHgxMGU0KTog
JWQsIFRocm91Z2hwdXQ6ICVkS2Jwcy9zXG4iLAorCQkgICBzdC0+bmJfcnhfZnJhbWUsIHN0LT5w
ZXJfdG90YWwsIHN0LT50aHJvdWdocHV0KTsKKwlzZXFfcHV0cyhzZXEsICIgICAgICAgTnVtLiBv
ZiAgICAgIFBFUiAgICAgUlNTSSAgICAgIFNOUiAgICAgIENGT1xuIik7CisJc2VxX3B1dHMoc2Vx
LCAiICAgICAgICBmcmFtZXMgICh4MTBlNCkgICAgKGRCbSkgICAgIChkQikgICAgKGtIeilcbiIp
OworCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNoYW5uZWxfbmFtZXMpOyBpKyspIHsKKwkJ
aWYgKGNoYW5uZWxfbmFtZXNbaV0pCisJCQlzZXFfcHJpbnRmKHNlcSwgIiU1cyAlOGQgJThkICU4
ZCAlOGQgJThkXG4iLAorCQkJCSAgIGNoYW5uZWxfbmFtZXNbaV0sCisJCQkJICAgbGUzMl90b19j
cHUoc3QtPm5iX3J4X2J5X3JhdGVbaV0pLAorCQkJCSAgIGxlMTZfdG9fY3B1KHN0LT5wZXJbaV0p
LAorCQkJCSAgIChzMTYpbGUxNl90b19jcHUoc3QtPnJzc2lbaV0pIC8gMTAwLAorCQkJCSAgIChz
MTYpbGUxNl90b19jcHUoc3QtPnNucltpXSkgLyAxMDAsCisJCQkJICAgKHMxNilsZTE2X3RvX2Nw
dShzdC0+Y2ZvW2ldKSk7CisJfQorCW11dGV4X3VubG9jaygmd2Rldi0+cnhfc3RhdHNfbG9jayk7
CisKKwlyZXR1cm4gMDsKK30KK0RFRklORV9TSE9XX0FUVFJJQlVURSh3Znhfcnhfc3RhdHMpOwor
CitzdGF0aWMgaW50IHdmeF90eF9wb3dlcl9sb29wX3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEs
IHZvaWQgKnYpCit7CisJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBzZXEtPnByaXZhdGU7CisJc3Ry
dWN0IGhpZl90eF9wb3dlcl9sb29wX2luZm8gKnN0ID0gJndkZXYtPnR4X3Bvd2VyX2xvb3BfaW5m
bzsKKwlpbnQgdG1wOworCisJbXV0ZXhfbG9jaygmd2Rldi0+dHhfcG93ZXJfbG9vcF9pbmZvX2xv
Y2spOworCXRtcCA9IGxlMTZfdG9fY3B1KHN0LT50eF9nYWluX2RpZyk7CisJc2VxX3ByaW50Zihz
ZXEsICJUeCBnYWluIGRpZ2l0YWw6ICVkXG4iLCB0bXApOworCXRtcCA9IGxlMTZfdG9fY3B1KHN0
LT50eF9nYWluX3BhKTsKKwlzZXFfcHJpbnRmKHNlcSwgIlR4IGdhaW4gUEE6ICVkXG4iLCB0bXAp
OworCXRtcCA9IChzMTYpbGUxNl90b19jcHUoc3QtPnRhcmdldF9wb3V0KTsKKwlzZXFfcHJpbnRm
KHNlcSwgIlRhcmdldCBQb3V0OiAlZC4lMDJkIGRCbVxuIiwgdG1wIC8gNCwgKHRtcCAlIDQpICog
MjUpOworCXRtcCA9IChzMTYpbGUxNl90b19jcHUoc3QtPnBfZXN0aW1hdGlvbik7CisJc2VxX3By
aW50ZihzZXEsICJGRU0gUG91dDogJWQuJTAyZCBkQm1cbiIsIHRtcCAvIDQsICh0bXAgJSA0KSAq
IDI1KTsKKwl0bXAgPSBsZTE2X3RvX2NwdShzdC0+dnBkZXQpOworCXNlcV9wcmludGYoc2VxLCAi
VnBkZXQ6ICVkIG1WXG4iLCB0bXApOworCXNlcV9wcmludGYoc2VxLCAiTWVhc3VyZSBpbmRleDog
JWRcbiIsIHN0LT5tZWFzdXJlbWVudF9pbmRleCk7CisJbXV0ZXhfdW5sb2NrKCZ3ZGV2LT50eF9w
b3dlcl9sb29wX2luZm9fbG9jayk7CisKKwlyZXR1cm4gMDsKK30KK0RFRklORV9TSE9XX0FUVFJJ
QlVURSh3ZnhfdHhfcG93ZXJfbG9vcCk7CisKK3N0YXRpYyBzc2l6ZV90IHdmeF9zZW5kX3Bkc193
cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKKwkJCQkgIGNvbnN0IGNoYXIgX191c2VyICp1c2VyX2J1
ZiwKKwkJCQkgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQoreworCXN0cnVjdCB3ZnhfZGV2
ICp3ZGV2ID0gZmlsZS0+cHJpdmF0ZV9kYXRhOworCWNoYXIgKmJ1ZjsKKwlpbnQgcmV0OworCisJ
aWYgKCpwcG9zICE9IDApIHsKKwkJZGV2X2RiZyh3ZGV2LT5kZXYsICJQRFMgZGF0YSBtdXN0IGJl
IHdyaXR0ZW4gaW4gb25lIHRyYW5zYWN0aW9uIik7CisJCXJldHVybiAtRUJVU1k7CisJfQorCWJ1
ZiA9IG1lbWR1cF91c2VyKHVzZXJfYnVmLCBjb3VudCk7CisJaWYgKElTX0VSUihidWYpKQorCQly
ZXR1cm4gUFRSX0VSUihidWYpOworCSpwcG9zID0gKnBwb3MgKyBjb3VudDsKKwlyZXQgPSB3Znhf
c2VuZF9wZHMod2RldiwgYnVmLCBjb3VudCk7CisJa2ZyZWUoYnVmKTsKKwlpZiAocmV0IDwgMCkK
KwkJcmV0dXJuIHJldDsKKwlyZXR1cm4gY291bnQ7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZmlsZV9vcGVyYXRpb25zIHdmeF9zZW5kX3Bkc19mb3BzID0geworCS5vcGVuID0gc2ltcGxlX29w
ZW4sCisJLndyaXRlID0gd2Z4X3NlbmRfcGRzX3dyaXRlLAorfTsKKworc3RydWN0IGRiZ2ZzX2hp
Zl9tc2cgeworCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2OworCXN0cnVjdCBjb21wbGV0aW9uIGNvbXBs
ZXRlOworCXU4IHJlcGx5WzEwMjRdOworCWludCByZXQ7Cit9OworCitzdGF0aWMgc3NpemVfdCB3
Znhfc2VuZF9oaWZfbXNnX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAorCQkJCSAgICAgIGNvbnN0
IGNoYXIgX191c2VyICp1c2VyX2J1ZiwKKwkJCQkgICAgICBzaXplX3QgY291bnQsIGxvZmZfdCAq
cHBvcykKK3sKKwlzdHJ1Y3QgZGJnZnNfaGlmX21zZyAqY29udGV4dCA9IGZpbGUtPnByaXZhdGVf
ZGF0YTsKKwlzdHJ1Y3Qgd2Z4X2RldiAqd2RldiA9IGNvbnRleHQtPndkZXY7CisJc3RydWN0IGhp
Zl9tc2cgKnJlcXVlc3Q7CisKKwlpZiAoY29tcGxldGlvbl9kb25lKCZjb250ZXh0LT5jb21wbGV0
ZSkpIHsKKwkJZGV2X2RiZyh3ZGV2LT5kZXYsICJyZWFkIHByZXZpb3VzIHJlc3VsdCBiZWZvcmUg
c3RhcnQgYSBuZXcgb25lXG4iKTsKKwkJcmV0dXJuIC1FQlVTWTsKKwl9CisJaWYgKGNvdW50IDwg
c2l6ZW9mKHN0cnVjdCBoaWZfbXNnKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwkvLyB3ZnhfY21k
X3NlbmQoKSBjaGVja3MgdGhhdCByZXBseSBidWZmZXIgaXMgd2lkZSBlbm91Z2gsIGJ1dCBkb2Vz
IG5vdAorCS8vIHJldHVybiBwcmVjaXNlIGxlbmd0aCByZWFkLiBVc2VyIGhhdmUgdG8ga25vdyBo
b3cgbWFueSBieXRlcyBzaG91bGQKKwkvLyBiZSByZWFkLiBGaWxsaW5nIHJlcGx5IGJ1ZmZlciB3
aXRoIGEgbWVtb3J5IHBhdHRlcm4gbWF5IGhlbHAgdXNlci4KKwltZW1zZXQoY29udGV4dC0+cmVw
bHksIDB4RkYsIHNpemVvZihjb250ZXh0LT5yZXBseSkpOworCXJlcXVlc3QgPSBtZW1kdXBfdXNl
cih1c2VyX2J1ZiwgY291bnQpOworCWlmIChJU19FUlIocmVxdWVzdCkpCisJCXJldHVybiBQVFJf
RVJSKHJlcXVlc3QpOworCWlmIChsZTE2X3RvX2NwdShyZXF1ZXN0LT5sZW4pICE9IGNvdW50KSB7
CisJCWtmcmVlKHJlcXVlc3QpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisJY29udGV4dC0+cmV0
ID0gd2Z4X2NtZF9zZW5kKHdkZXYsIHJlcXVlc3QsIGNvbnRleHQtPnJlcGx5LAorCQkJCSAgICBz
aXplb2YoY29udGV4dC0+cmVwbHkpLCBmYWxzZSk7CisKKwlrZnJlZShyZXF1ZXN0KTsKKwljb21w
bGV0ZSgmY29udGV4dC0+Y29tcGxldGUpOworCXJldHVybiBjb3VudDsKK30KKworc3RhdGljIHNz
aXplX3Qgd2Z4X3NlbmRfaGlmX21zZ19yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBjaGFyIF9fdXNl
ciAqdXNlcl9idWYsCisJCQkJICAgICBzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykKK3sKKwlz
dHJ1Y3QgZGJnZnNfaGlmX21zZyAqY29udGV4dCA9IGZpbGUtPnByaXZhdGVfZGF0YTsKKwlpbnQg
cmV0OworCisJaWYgKGNvdW50ID4gc2l6ZW9mKGNvbnRleHQtPnJlcGx5KSkKKwkJcmV0dXJuIC1F
SU5WQUw7CisJcmV0ID0gd2FpdF9mb3JfY29tcGxldGlvbl9pbnRlcnJ1cHRpYmxlKCZjb250ZXh0
LT5jb21wbGV0ZSk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwlpZiAoY29udGV4dC0+cmV0
IDwgMCkKKwkJcmV0dXJuIGNvbnRleHQtPnJldDsKKwkvLyBCZSBjYXJlZnVsLCB3cml0ZSgpIGlz
IHdhaXRpbmcgZm9yIGEgZnVsbCBtZXNzYWdlIHdoaWxlIHJlYWQoKQorCS8vIG9ubHkgcmV0dXJu
cyBhIHBheWxvYWQKKwlpZiAoY29weV90b191c2VyKHVzZXJfYnVmLCBjb250ZXh0LT5yZXBseSwg
Y291bnQpKQorCQlyZXR1cm4gLUVGQVVMVDsKKworCXJldHVybiBjb3VudDsKK30KKworc3RhdGlj
IGludCB3Znhfc2VuZF9oaWZfbXNnX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZp
bGUgKmZpbGUpCit7CisJc3RydWN0IGRiZ2ZzX2hpZl9tc2cgKmNvbnRleHQgPSBremFsbG9jKHNp
emVvZigqY29udGV4dCksIEdGUF9LRVJORUwpOworCisJaWYgKCFjb250ZXh0KQorCQlyZXR1cm4g
LUVOT01FTTsKKwljb250ZXh0LT53ZGV2ID0gaW5vZGUtPmlfcHJpdmF0ZTsKKwlpbml0X2NvbXBs
ZXRpb24oJmNvbnRleHQtPmNvbXBsZXRlKTsKKwlmaWxlLT5wcml2YXRlX2RhdGEgPSBjb250ZXh0
OworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHdmeF9zZW5kX2hpZl9tc2dfcmVsZWFzZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKK3sKKwlzdHJ1Y3QgZGJnZnNf
aGlmX21zZyAqY29udGV4dCA9IGZpbGUtPnByaXZhdGVfZGF0YTsKKworCWtmcmVlKGNvbnRleHQp
OworCXJldHVybiAwOworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyB3
Znhfc2VuZF9oaWZfbXNnX2ZvcHMgPSB7CisJLm9wZW4gPSB3Znhfc2VuZF9oaWZfbXNnX29wZW4s
CisJLnJlbGVhc2UgPSB3Znhfc2VuZF9oaWZfbXNnX3JlbGVhc2UsCisJLndyaXRlID0gd2Z4X3Nl
bmRfaGlmX21zZ193cml0ZSwKKwkucmVhZCA9IHdmeF9zZW5kX2hpZl9tc2dfcmVhZCwKK307CisK
K3N0YXRpYyBpbnQgd2Z4X3BzX3RpbWVvdXRfc2V0KHZvaWQgKmRhdGEsIHU2NCB2YWwpCit7CisJ
c3RydWN0IHdmeF9kZXYgKndkZXYgPSAoc3RydWN0IHdmeF9kZXYgKilkYXRhOworCXN0cnVjdCB3
ZnhfdmlmICp3dmlmOworCisJd2Rldi0+Zm9yY2VfcHNfdGltZW91dCA9IHZhbDsKKwl3dmlmID0g
TlVMTDsKKwl3aGlsZSAoKHd2aWYgPSB3dmlmX2l0ZXJhdGUod2Rldiwgd3ZpZikpICE9IE5VTEwp
CisJCXdmeF91cGRhdGVfcG0od3ZpZik7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgd2Z4
X3BzX3RpbWVvdXRfZ2V0KHZvaWQgKmRhdGEsIHU2NCAqdmFsKQoreworCXN0cnVjdCB3ZnhfZGV2
ICp3ZGV2ID0gKHN0cnVjdCB3ZnhfZGV2ICopZGF0YTsKKworCSp2YWwgPSB3ZGV2LT5mb3JjZV9w
c190aW1lb3V0OworCXJldHVybiAwOworfQorCitERUZJTkVfREVCVUdGU19BVFRSSUJVVEUod2Z4
X3BzX3RpbWVvdXRfZm9wcywgd2Z4X3BzX3RpbWVvdXRfZ2V0LCB3ZnhfcHNfdGltZW91dF9zZXQs
ICIlbGxkXG4iKTsKKworaW50IHdmeF9kZWJ1Z19pbml0KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQor
eworCXN0cnVjdCBkZW50cnkgKmQ7CisKKwlkID0gZGVidWdmc19jcmVhdGVfZGlyKCJ3ZngiLCB3
ZGV2LT5ody0+d2lwaHktPmRlYnVnZnNkaXIpOworCWRlYnVnZnNfY3JlYXRlX2ZpbGUoImNvdW50
ZXJzIiwgMDQ0NCwgZCwgd2RldiwgJndmeF9jb3VudGVyc19mb3BzKTsKKwlkZWJ1Z2ZzX2NyZWF0
ZV9maWxlKCJyeF9zdGF0cyIsIDA0NDQsIGQsIHdkZXYsICZ3Znhfcnhfc3RhdHNfZm9wcyk7CisJ
ZGVidWdmc19jcmVhdGVfZmlsZSgidHhfcG93ZXJfbG9vcCIsIDA0NDQsIGQsIHdkZXYsCisJCQkg
ICAgJndmeF90eF9wb3dlcl9sb29wX2ZvcHMpOworCWRlYnVnZnNfY3JlYXRlX2ZpbGUoInNlbmRf
cGRzIiwgMDIwMCwgZCwgd2RldiwgJndmeF9zZW5kX3Bkc19mb3BzKTsKKwlkZWJ1Z2ZzX2NyZWF0
ZV9maWxlKCJzZW5kX2hpZl9tc2ciLCAwNjAwLCBkLCB3ZGV2LAorCQkJICAgICZ3Znhfc2VuZF9o
aWZfbXNnX2ZvcHMpOworCWRlYnVnZnNfY3JlYXRlX2ZpbGUoInBzX3RpbWVvdXQiLCAwNjAwLCBk
LCB3ZGV2LCAmd2Z4X3BzX3RpbWVvdXRfZm9wcyk7CisKKwlyZXR1cm4gMDsKK30KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaCBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwMDAwMDAuLjZmMmY4NGQ2NGM5ZQotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93ZngvZGVidWcuaApAQCAtMCwwICsxLDE5IEBACisvKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovCisvKgorICogRGVidWdmcyBpbnRlcmZh
Y2UuCisgKgorICogQ29weXJpZ2h0IChjKSAyMDE3LTIwMTksIFNpbGljb24gTGFib3JhdG9yaWVz
LCBJbmMuCisgKiBDb3B5cmlnaHQgKGMpIDIwMTEsIFNULUVyaWNzc29uCisgKi8KKyNpZm5kZWYg
V0ZYX0RFQlVHX0gKKyNkZWZpbmUgV0ZYX0RFQlVHX0gKKworc3RydWN0IHdmeF9kZXY7CisKK2lu
dCB3ZnhfZGVidWdfaW5pdChzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7CisKK2NvbnN0IGNoYXIgKmdl
dF9oaWZfbmFtZSh1bnNpZ25lZCBsb25nIGlkKTsKK2NvbnN0IGNoYXIgKmdldF9taWJfbmFtZSh1
bnNpZ25lZCBsb25nIGlkKTsKK2NvbnN0IGNoYXIgKmdldF9yZWdfbmFtZSh1bnNpZ25lZCBsb25n
IGlkKTsKKworI2VuZGlmIC8qIFdGWF9ERUJVR19IICovCi0tIAoyLjI4LjAKCg==
