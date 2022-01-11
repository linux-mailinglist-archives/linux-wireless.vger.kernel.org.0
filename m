Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A647748B374
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 18:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbiAKRR2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 12:17:28 -0500
Received: from mail-dm3nam07on2048.outbound.protection.outlook.com ([40.107.95.48]:3521
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344112AbiAKRQR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 12:16:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUxs4ZLKtHBysXfiHOUrqu+9G9+9quelybPxWqHtfJroV2yBsVTYhA/0YUj3FI//ummljORMPv/ntsU6m1fX5bptMDuuQuNOz9tt0DzsSgM0Oba6s/Eu5XZlT7+DPolNfdRFeIkVporZNjBxUzCBP72H4xblxLk1eEa8sArLFiJXWGxCJjytBq+IKUTI/Vu2A2VgD7zuA+Uf3nNdfhulZPWqfc2gpBawtwpwzxplJq+v1e5tS7ZzEFbqdIDcOCdwSdSiTZv1DScEsCroi2cP8Oo+JddH7LXIHnr9b4uTBJJ5YifcNkX8de46H0Z79OJqHLBEx9JmGXuvCnM7gUNKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD9CGCIKRgqarRPLO7no6UDtYXi3qW60U9IwbzsRPlQ=;
 b=VMa1IB5OxxnzTTSFW2gmEBqrqWMr1OPRuoU4V6Km2iUwv0bdyk3ReKHe3hjQF4Irc8BMuDHYe3NJL7lnXJydKONRkolJalOdJHg2QPRmu7ExQIKv/NR+1dXtGAwGqQQDiPxc5mWsqJAZbFC2ip9qIwPOkhtD1e0khzX+C+crnvw4spYOCsuGxOqXu6qjSplTuzUixpVC2vO49EbecuLwbW7dc8/6Rl3e95rjSz+30ax9kwZJ6GVdda6YoIZj1WMPOEMmEJHQpv9TT/ZeZaqMOE0UOVXyB8wJiec/XjTIwmoaI+2kDyJ7aMnr+gWJ+5JeLY1TtGNYea9h3Y4mIVzXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD9CGCIKRgqarRPLO7no6UDtYXi3qW60U9IwbzsRPlQ=;
 b=qBQ54S/QilZuvoIab0uzOb2e422r82mOzLZ7qKBGZ2TmL4T3wjOAULGG2eTYKKa0KL0F+dL0SZZr22qiO1nG2rAq0hhBGhC/j0zgPm35efSXUupcEw5cjcATIDROl1E9V4sw9TeGcFKoIheT7YHc2EUwh2FHfWEzk3NU2aYu7/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 17:15:14 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:15:14 +0000
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
Subject: [PATCH v9 11/24] wfx: add bh.c/bh.h
Date:   Tue, 11 Jan 2022 18:14:11 +0100
Message-Id: <20220111171424.862764-12-Jerome.Pouiller@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4b3d4cd-46ef-4864-eaaa-08d9d525eea2
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB5674E01A1506C554B4F51D0F93519@PH0PR11MB5674.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4Yab+ktxqSEbTgSGyCvgIqke/SRNEDotMgW0ExKPJRVw/Z6AsHqGHej43siAAHBr0Dd/7eMOqyrRKgH40TlV0Ni/M7nOeEIhrUpqJuQVD1gm1P8zg6EEIlU32zzgYrkqUimNobVczghagreaOzJ18lWyWcOIEtTPer5m+H5jzpswNUdqpc8gUq60RTWU64qu/DvRjHNQBeLVLgJTVbGu2iqJTj8t9iXZlVyzf8xKdCs5d8Vy7gbdDIuZ0ocUGGAJaAjpTGoUnlP2ZUt3xsPWAWvnhL+wAXmuUF+Iitcb1G8DA7BkpXkXKH6yPvx/4mtQAUulRVthbBitFGbyYKN4u5HISctXx7/Kl3l2G+z4iAg4twnyEcE+mRt9IYRpMptDX5pl8nmRpAEIz0kshveJ9D3R2AOxCgjp7SgN+ANFYCzFJJTg9sK4hdyCJxaWoBb+lRQvVXcn/iho3wcPEKK+uZQMGn1fZpD/sneICR9+cqxanEtBqYROnDXMfWtfHXCEzURV0CiTKJ/X+KKb/ubdPJ59g998LUFN3lMdR0014glHWU58A44qGJyDbgf9Ys7isC/ex9fvuyphvBPgCf3a3eOeaB77x8JfripJFOwM7GGGl1yJ2AsqenHjZo4yS5atUR8+P7bEAyxUVFjXMC97w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66946007)(66574015)(8936002)(107886003)(4326008)(66476007)(508600001)(36756003)(7416002)(8676002)(86362001)(6916009)(83380400001)(52116002)(316002)(6512007)(2906002)(6666004)(30864003)(6486002)(1076003)(186003)(66556008)(54906003)(38100700002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBlNUtENy9JbE5jLzFld3Qzc0h2TkRXOEJqL2dSUjNjQWRnMHNXSk5rQmxr?=
 =?utf-8?B?WlU3K0xNWmlIYytqT2krQXBVMHp2cVFQQk9rK2dIZFRSMHZDdXZqNEVzMnJi?=
 =?utf-8?B?cFh2NU15Tndoei9lMHNuSWwrMzlnT3ZFd3dlaGNQNG9NVDE1RFo2bG1tKzFq?=
 =?utf-8?B?MndlSm1FbHo1YUJIL0sxbndiSnNaNDBDenhDZTU4bGtib3AzelVpeDBSa1Vk?=
 =?utf-8?B?S1YwVUtvSWV0ZXJtbGxFMnp5YWRFaWpjL2J3dkFCYmpQaTBManJIMFpsUjdN?=
 =?utf-8?B?amxieEpvY2Q5TzVvUjhodTJnZkJlNXhwV296S1NRbHIxMlczdVZMU0w5MlM1?=
 =?utf-8?B?WTE0V3pLSFhrcXN4aC9nbi82MmJwcUZWZW5qTDRLbWZVWTFtOVlxb1BkNEF5?=
 =?utf-8?B?ODZPV1RkZVNkWHE0N1Aybm1UVk85eGFzd1o0WmlPVFV4Nnl2Z01sTXc3WFNX?=
 =?utf-8?B?OEN2VWM1c3hZR0cxbkVIUUtKTG02b3VoY3BxSm9mT0RJSXZRYVdxY2Q4YnNI?=
 =?utf-8?B?YVBOellOTUhsdlRDRXd0MkpOZ2FjNzJ2WVBzS2RSckhIa2lKenNoaWkxRCsy?=
 =?utf-8?B?d0pOYUxvb2xVNjNSSzlEaDRISU9OTTZaR3g2OTlRbG5ISUhjVVlvZmlwNUJH?=
 =?utf-8?B?OE90a0o3cE1DaXhjTUt6NEZwRUNQbUNyeXQ0OXhENVRMMFN3OTBqWjdkekpG?=
 =?utf-8?B?QlhnUXg4MHdjV3M4RUFhVjhTdVE2YTdDemtYdlg2MjdzdERlWTlaaExadkxo?=
 =?utf-8?B?dkdIWUVWcVlKa2hZWWZibkhSczR6bXRmYlordDE3aCtQV1pBWi84bkxsODBP?=
 =?utf-8?B?RVFkUXlLRFMwbEZYK1JxeHUrZGVGQWFyYkdUcFJsdUtpSzhZcnhHY1B5RGZO?=
 =?utf-8?B?d2w0RDhtVFFyOFFPV2YzdUxidWpoUDlLa2ltWnljbXYzSGovYXpXbXNGbTFG?=
 =?utf-8?B?clFKMnZBUk9nbHRNOU1sUDBaZndEd00ybStyWXBSa3A1TW4zVkM3VHd2WnZZ?=
 =?utf-8?B?WVlVL2ZNZkk5bm5hbVBQVnNsYXlQV2o1MTZ0VElJV1ZnVGlWVkgxV3RKbmdH?=
 =?utf-8?B?ZnJKUytheTFDQVgxUzdJVGhIMjk3RlRaREZWYTlMdHBGUFpxVUV6NDRmRzRj?=
 =?utf-8?B?RElGRnU2Si84UWtsejZ0REhYZm9mbkhDRGEwQ0pteGZUMXd0V3NlaXNyOFdy?=
 =?utf-8?B?MEEzNlcxcU9xZTZ0dENsSVdHaTVaaG5jYkovOGtReDZxTnZwaVhqN2Zlall1?=
 =?utf-8?B?SmNON3BUdkRzcXF6UituVUNhcTllS25rNFhrNUppZ2huOGFkVHRrajRKYVE3?=
 =?utf-8?B?OVYydXIvTVorVTl3V24wMm9RZW5QeTdxR3EvcXdNeTZDUW5QN2t1am1xOXBp?=
 =?utf-8?B?ODlSbmZDSitHZFl0bHdZeUcrWXgrUmRhK1lzdHNiNXNXbnRWKzVJdENmcjE0?=
 =?utf-8?B?b0x0c3RPWjJFc3hidjhNYTZUbVdGU3c1SEIzNXd0cHd2TWJWRmx4bEVVWm9X?=
 =?utf-8?B?MmdtVFRrT3pLVk1NM25sYlRjV1RXRHp1Vk9JbGVwYTVnaFNPeUw2eFpSV2w0?=
 =?utf-8?B?OVJTTVNEUER3dk4yc3NRblMwNEVIcTY4QXg3R2RTQy9YWm5oRnBQS2dHMlNG?=
 =?utf-8?B?KzdsRm1uclJFV3cyYkt2RzVRdytXSFgzTk1DY25JUG11dTNtaGdRQnljZzRZ?=
 =?utf-8?B?dnlLRGRKb0oydU1SOTVLWHl2WFJzdkxBdFMyN2R3a09mVkhDbnBRYzV4SnRD?=
 =?utf-8?B?UHAyUnQ2cHh5ZTY0enZvS2IxR3djclZVRkhjaUpab3dkU1g4WWZhME5JR2Nm?=
 =?utf-8?B?d0l2UVBDSlJPVXVEa25Rc2JaSmtPV3Y0dW1KMXBuRHp5ZXluc056NkdQVGVD?=
 =?utf-8?B?YjV5dGFhR3U4NU1TUWJHSEtjTWxDYXVYeEhIT2R5eWR1cjhJMFlSS1lqRHk2?=
 =?utf-8?B?UkQwbGttdEk1SlVJdWhwdEFnb25ta2FtZ2NQYWEzWWhzQ3kzeEs2SXZKa01V?=
 =?utf-8?B?YjBaTVlwbmlocHUrNXZ3bm9jM1VrS2NsWTRMaFZ4VDI1SWpyTUE5cHRxck9C?=
 =?utf-8?B?dExYdHZxOXZXY3oyOE92OGJEa2wzRk9SSXYzdGFLOXZpWkd0eHd3aG5EUkFX?=
 =?utf-8?B?VmVEMFltOThlOFBrRm5LNWtzQzFLNkh5MDRhbXp5V1o4R2NpVUZwc1pJK3VY?=
 =?utf-8?B?S0RMOUI3Y0M4UzQ5Y0tlZzdpeis0RmoyWjVqUlVCRW5lbWtJREE5N3NlbGNC?=
 =?utf-8?Q?31w+9Fa3P6yo0Qv7h2W87SZC/niuldJZTtAfMAFAVU=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b3d4cd-46ef-4864-eaaa-08d9d525eea2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:15:14.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WJXxZvi590ROybMYYUOVkBDTlH4V4aNloaip7/GT/3zhtEmZ5AMVHnCRK8CzN0IldOG6Kms+hAyDKIYBTBhkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5674
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYmguYyB8IDMyMyArKysrKysr
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYmgu
aCB8ICAzNCArKysKIDIgZmlsZXMgY2hhbmdlZCwgMzU3IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2JoLmMKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2JoLmgKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2JoLmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L2JoLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAwLi40YzZiYTljMzQyYTYKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9zaWxhYnMvd2Z4L2JoLmMKQEAgLTAsMCArMSwzMjMgQEAKKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8qCisgKiBJbnRlcnJ1cHQgYm90dG9tIGhhbGYgKEJI
KS4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMs
IEluYy4KKyAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJpY3Nzb24KKyAqLworI2luY2x1ZGUg
PGxpbnV4L2dwaW8vY29uc3VtZXIuaD4KKyNpbmNsdWRlIDxuZXQvbWFjODAyMTEuaD4KKworI2lu
Y2x1ZGUgImJoLmgiCisjaW5jbHVkZSAid2Z4LmgiCisjaW5jbHVkZSAiaHdpby5oIgorI2luY2x1
ZGUgInRyYWNlcy5oIgorI2luY2x1ZGUgImhpZl9yeC5oIgorI2luY2x1ZGUgImhpZl9hcGlfY21k
LmgiCisKK3N0YXRpYyB2b2lkIGRldmljZV93YWtldXAoc3RydWN0IHdmeF9kZXYgKndkZXYpCit7
CisJaW50IG1heF9yZXRyeSA9IDM7CisKKwlpZiAoIXdkZXYtPnBkYXRhLmdwaW9fd2FrZXVwKQor
CQlyZXR1cm47CisJaWYgKGdwaW9kX2dldF92YWx1ZV9jYW5zbGVlcCh3ZGV2LT5wZGF0YS5ncGlv
X3dha2V1cCkgPiAwKQorCQlyZXR1cm47CisKKwlpZiAod2Z4X2FwaV9vbGRlcl90aGFuKHdkZXYs
IDEsIDQpKSB7CisJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcCh3ZGV2LT5wZGF0YS5ncGlvX3dh
a2V1cCwgMSk7CisJCWlmICghY29tcGxldGlvbl9kb25lKCZ3ZGV2LT5oaWYuY3RybF9yZWFkeSkp
CisJCQl1c2xlZXBfcmFuZ2UoMjAwMCwgMjUwMCk7CisJCXJldHVybjsKKwl9CisJZm9yICg7Oykg
eworCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAod2Rldi0+cGRhdGEuZ3Bpb193YWtldXAsIDEp
OworCQkvKiBjb21wbGV0aW9uLmggZG9lcyBub3QgcHJvdmlkZSBhbnkgZnVuY3Rpb24gdG8gd2Fp
dCBjb21wbGV0aW9uIHdpdGhvdXQgY29uc3VtZSBpdAorCQkgKiAoYSBraW5kIG9mIHdhaXRfZm9y
X2NvbXBsZXRpb25fZG9uZV90aW1lb3V0KCkpLiBTbyB3ZSBoYXZlIHRvIGVtdWxhdGUgaXQuCisJ
CSAqLworCQlpZiAod2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZ3ZGV2LT5oaWYuY3RybF9y
ZWFkeSwgbXNlY3NfdG9famlmZmllcygyKSkpIHsKKwkJCWNvbXBsZXRlKCZ3ZGV2LT5oaWYuY3Ry
bF9yZWFkeSk7CisJCQlyZXR1cm47CisJCX0gZWxzZSBpZiAobWF4X3JldHJ5LS0gPiAwKSB7CisJ
CQkvKiBPbGRlciBmaXJtd2FyZXMgaGF2ZSBhIHJhY2UgaW4gc2xlZXAvd2FrZS11cCBwcm9jZXNz
LiAgUmVkbyB0aGUgcHJvY2VzcworCQkJICogaXMgc3VmZmljaWVudCB0byB1bmZyZWV6ZSB0aGUg
Y2hpcC4KKwkJCSAqLworCQkJZGV2X2Vycih3ZGV2LT5kZXYsICJ0aW1lb3V0IHdoaWxlIHdha2Ug
dXAgY2hpcFxuIik7CisJCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAod2Rldi0+cGRhdGEuZ3Bp
b193YWtldXAsIDApOworCQkJdXNsZWVwX3JhbmdlKDIwMDAsIDI1MDApOworCQl9IGVsc2Ugewor
CQkJZGV2X2Vycih3ZGV2LT5kZXYsICJtYXggd2FrZS11cCByZXRyaWVzIHJlYWNoZWRcbiIpOwor
CQkJcmV0dXJuOworCQl9CisJfQorfQorCitzdGF0aWMgdm9pZCBkZXZpY2VfcmVsZWFzZShzdHJ1
Y3Qgd2Z4X2RldiAqd2RldikKK3sKKwlpZiAoIXdkZXYtPnBkYXRhLmdwaW9fd2FrZXVwKQorCQly
ZXR1cm47CisKKwlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAod2Rldi0+cGRhdGEuZ3Bpb193YWtl
dXAsIDApOworfQorCitzdGF0aWMgaW50IHJ4X2hlbHBlcihzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwg
c2l6ZV90IHJlYWRfbGVuLCBpbnQgKmlzX2NuZikKK3sKKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwor
CXN0cnVjdCB3ZnhfaGlmX21zZyAqaGlmOworCXNpemVfdCBhbGxvY19sZW47CisJc2l6ZV90IGNv
bXB1dGVkX2xlbjsKKwlpbnQgcmVsZWFzZV9jb3VudDsKKwlpbnQgcGlnZ3liYWNrID0gMDsKKwor
CVdBUk4ocmVhZF9sZW4gPiByb3VuZF9kb3duKDB4RkZGLCAyKSAqIHNpemVvZih1MTYpLCAicmVx
dWVzdCBleGNlZWQgdGhlIGNoaXAgY2FwYWJpbGl0eSIpOworCisJLyogQWRkIDIgdG8gdGFrZSBp
bnRvIGFjY291bnQgcGlnZ3liYWNrIHNpemUgKi8KKwlhbGxvY19sZW4gPSB3ZGV2LT5od2J1c19v
cHMtPmFsaWduX3NpemUod2Rldi0+aHdidXNfcHJpdiwgcmVhZF9sZW4gKyAyKTsKKwlza2IgPSBk
ZXZfYWxsb2Nfc2tiKGFsbG9jX2xlbik7CisJaWYgKCFza2IpCisJCXJldHVybiAtRU5PTUVNOwor
CisJaWYgKHdmeF9kYXRhX3JlYWQod2Rldiwgc2tiLT5kYXRhLCBhbGxvY19sZW4pKQorCQlnb3Rv
IGVycjsKKworCXBpZ2d5YmFjayA9IGxlMTZfdG9fY3B1cCgoX19sZTE2ICopKHNrYi0+ZGF0YSAr
IGFsbG9jX2xlbiAtIDIpKTsKKwlfdHJhY2VfcGlnZ3liYWNrKHBpZ2d5YmFjaywgZmFsc2UpOwor
CisJaGlmID0gKHN0cnVjdCB3ZnhfaGlmX21zZyAqKXNrYi0+ZGF0YTsKKwlXQVJOKGhpZi0+ZW5j
cnlwdGVkICYgMHgzLCAiZW5jcnlwdGlvbiBpcyB1bnN1cHBvcnRlZCIpOworCWlmIChXQVJOKHJl
YWRfbGVuIDwgc2l6ZW9mKHN0cnVjdCB3ZnhfaGlmX21zZyksICJjb3JydXB0ZWQgcmVhZCIpKQor
CQlnb3RvIGVycjsKKwljb21wdXRlZF9sZW4gPSBsZTE2X3RvX2NwdShoaWYtPmxlbik7CisJY29t
cHV0ZWRfbGVuID0gcm91bmRfdXAoY29tcHV0ZWRfbGVuLCAyKTsKKwlpZiAoY29tcHV0ZWRfbGVu
ICE9IHJlYWRfbGVuKSB7CisJCWRldl9lcnIod2Rldi0+ZGV2LCAiaW5jb25zaXN0ZW50IG1lc3Nh
Z2UgbGVuZ3RoOiAlenUgIT0gJXp1XG4iLAorCQkJY29tcHV0ZWRfbGVuLCByZWFkX2xlbik7CisJ
CXByaW50X2hleF9kdW1wKEtFUk5fSU5GTywgImhpZjogIiwgRFVNUF9QUkVGSVhfT0ZGU0VULCAx
NiwgMSwKKwkJCSAgICAgICBoaWYsIHJlYWRfbGVuLCB0cnVlKTsKKwkJZ290byBlcnI7CisJfQor
CisJaWYgKCEoaGlmLT5pZCAmIEhJRl9JRF9JU19JTkRJQ0FUSU9OKSkgeworCQkoKmlzX2NuZikr
KzsKKwkJaWYgKGhpZi0+aWQgPT0gSElGX0NORl9JRF9NVUxUSV9UUkFOU01JVCkKKwkJCXJlbGVh
c2VfY291bnQgPQorCQkJCSgoc3RydWN0IHdmeF9oaWZfY25mX211bHRpX3RyYW5zbWl0ICopaGlm
LT5ib2R5KS0+bnVtX3R4X2NvbmZzOworCQllbHNlCisJCQlyZWxlYXNlX2NvdW50ID0gMTsKKwkJ
V0FSTih3ZGV2LT5oaWYudHhfYnVmZmVyc191c2VkIDwgcmVsZWFzZV9jb3VudCwgImNvcnJ1cHRl
ZCBidWZmZXIgY291bnRlciIpOworCQl3ZGV2LT5oaWYudHhfYnVmZmVyc191c2VkIC09IHJlbGVh
c2VfY291bnQ7CisJfQorCV90cmFjZV9oaWZfcmVjdihoaWYsIHdkZXYtPmhpZi50eF9idWZmZXJz
X3VzZWQpOworCisJaWYgKGhpZi0+aWQgIT0gSElGX0lORF9JRF9FWENFUFRJT04gJiYgaGlmLT5p
ZCAhPSBISUZfSU5EX0lEX0VSUk9SKSB7CisJCWlmIChoaWYtPnNlcW51bSAhPSB3ZGV2LT5oaWYu
cnhfc2VxbnVtKQorCQkJZGV2X3dhcm4od2Rldi0+ZGV2LCAid3JvbmcgbWVzc2FnZSBzZXF1ZW5j
ZTogJWQgIT0gJWRcbiIsCisJCQkJIGhpZi0+c2VxbnVtLCB3ZGV2LT5oaWYucnhfc2VxbnVtKTsK
KwkJd2Rldi0+aGlmLnJ4X3NlcW51bSA9IChoaWYtPnNlcW51bSArIDEpICUgKEhJRl9DT1VOVEVS
X01BWCArIDEpOworCX0KKworCXNrYl9wdXQoc2tiLCBsZTE2X3RvX2NwdShoaWYtPmxlbikpOwor
CS8qIHdmeF9oYW5kbGVfcnggdGFrZXMgY2FyZSBvbiBTS0IgbGl2ZXRpbWUgKi8KKwl3ZnhfaGFu
ZGxlX3J4KHdkZXYsIHNrYik7CisJaWYgKCF3ZGV2LT5oaWYudHhfYnVmZmVyc191c2VkKQorCQl3
YWtlX3VwKCZ3ZGV2LT5oaWYudHhfYnVmZmVyc19lbXB0eSk7CisKKwlyZXR1cm4gcGlnZ3liYWNr
OworCitlcnI6CisJaWYgKHNrYikKKwkJZGV2X2tmcmVlX3NrYihza2IpOworCXJldHVybiAtRUlP
OworfQorCitzdGF0aWMgaW50IGJoX3dvcmtfcngoc3RydWN0IHdmeF9kZXYgKndkZXYsIGludCBt
YXhfbXNnLCBpbnQgKm51bV9jbmYpCit7CisJc2l6ZV90IGxlbjsKKwlpbnQgaTsKKwlpbnQgY3Ry
bF9yZWcsIHBpZ2d5YmFjazsKKworCXBpZ2d5YmFjayA9IDA7CisJZm9yIChpID0gMDsgaSA8IG1h
eF9tc2c7IGkrKykgeworCQlpZiAocGlnZ3liYWNrICYgQ1RSTF9ORVhUX0xFTl9NQVNLKQorCQkJ
Y3RybF9yZWcgPSBwaWdneWJhY2s7CisJCWVsc2UgaWYgKHRyeV93YWl0X2Zvcl9jb21wbGV0aW9u
KCZ3ZGV2LT5oaWYuY3RybF9yZWFkeSkpCisJCQljdHJsX3JlZyA9IGF0b21pY194Y2hnKCZ3ZGV2
LT5oaWYuY3RybF9yZWcsIDApOworCQllbHNlCisJCQljdHJsX3JlZyA9IDA7CisJCWlmICghKGN0
cmxfcmVnICYgQ1RSTF9ORVhUX0xFTl9NQVNLKSkKKwkJCXJldHVybiBpOworCQkvKiBjdHJsX3Jl
ZyB1bml0cyBhcmUgMTZiaXRzIHdvcmRzICovCisJCWxlbiA9IChjdHJsX3JlZyAmIENUUkxfTkVY
VF9MRU5fTUFTSykgKiAyOworCQlwaWdneWJhY2sgPSByeF9oZWxwZXIod2RldiwgbGVuLCBudW1f
Y25mKTsKKwkJaWYgKHBpZ2d5YmFjayA8IDApCisJCQlyZXR1cm4gaTsKKwkJaWYgKCEocGlnZ3li
YWNrICYgQ1RSTF9XTEFOX1JFQURZKSkKKwkJCWRldl9lcnIod2Rldi0+ZGV2LCAidW5leHBlY3Rl
ZCBwaWdneWJhY2sgdmFsdWU6IHJlYWR5IGJpdCBub3Qgc2V0OiAlMDR4XG4iLAorCQkJCXBpZ2d5
YmFjayk7CisJfQorCWlmIChwaWdneWJhY2sgJiBDVFJMX05FWFRfTEVOX01BU0spIHsKKwkJY3Ry
bF9yZWcgPSBhdG9taWNfeGNoZygmd2Rldi0+aGlmLmN0cmxfcmVnLCBwaWdneWJhY2spOworCQlj
b21wbGV0ZSgmd2Rldi0+aGlmLmN0cmxfcmVhZHkpOworCQlpZiAoY3RybF9yZWcpCisJCQlkZXZf
ZXJyKHdkZXYtPmRldiwgInVuZXhwZWN0ZWQgSVJRIGhhcHBlbmVkOiAlMDR4LyUwNHhcbiIsCisJ
CQkJY3RybF9yZWcsIHBpZ2d5YmFjayk7CisJfQorCXJldHVybiBpOworfQorCitzdGF0aWMgdm9p
ZCB0eF9oZWxwZXIoc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCB3ZnhfaGlmX21zZyAqaGlm
KQoreworCWludCByZXQ7CisJdm9pZCAqZGF0YTsKKwlib29sIGlzX2VuY3J5cHRlZCA9IGZhbHNl
OworCXNpemVfdCBsZW4gPSBsZTE2X3RvX2NwdShoaWYtPmxlbik7CisKKwlXQVJOKGxlbiA8IHNp
emVvZigqaGlmKSwgInRyeSB0byBzZW5kIGNvcnJ1cHRlZCBkYXRhIik7CisKKwloaWYtPnNlcW51
bSA9IHdkZXYtPmhpZi50eF9zZXFudW07CisJd2Rldi0+aGlmLnR4X3NlcW51bSA9ICh3ZGV2LT5o
aWYudHhfc2VxbnVtICsgMSkgJSAoSElGX0NPVU5URVJfTUFYICsgMSk7CisKKwlkYXRhID0gaGlm
OworCVdBUk4obGVuID4gbGUxNl90b19jcHUod2Rldi0+aHdfY2Fwcy5zaXplX2lucF9jaF9idWYp
LAorCSAgICAgInJlcXVlc3QgZXhjZWVkIHRoZSBjaGlwIGNhcGFiaWxpdHk6ICV6dSA+ICVkXG4i
LAorCSAgICAgbGVuLCBsZTE2X3RvX2NwdSh3ZGV2LT5od19jYXBzLnNpemVfaW5wX2NoX2J1Zikp
OworCWxlbiA9IHdkZXYtPmh3YnVzX29wcy0+YWxpZ25fc2l6ZSh3ZGV2LT5od2J1c19wcml2LCBs
ZW4pOworCXJldCA9IHdmeF9kYXRhX3dyaXRlKHdkZXYsIGRhdGEsIGxlbik7CisJaWYgKHJldCkK
KwkJZ290byBlbmQ7CisKKwl3ZGV2LT5oaWYudHhfYnVmZmVyc191c2VkKys7CisJX3RyYWNlX2hp
Zl9zZW5kKGhpZiwgd2Rldi0+aGlmLnR4X2J1ZmZlcnNfdXNlZCk7CitlbmQ6CisJaWYgKGlzX2Vu
Y3J5cHRlZCkKKwkJa2ZyZWUoZGF0YSk7Cit9CisKK3N0YXRpYyBpbnQgYmhfd29ya190eChzdHJ1
Y3Qgd2Z4X2RldiAqd2RldiwgaW50IG1heF9tc2cpCit7CisJc3RydWN0IHdmeF9oaWZfbXNnICpo
aWY7CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgbWF4X21zZzsgaSsrKSB7CisJCWhpZiA9
IE5VTEw7CisJCWlmICh3ZGV2LT5oaWYudHhfYnVmZmVyc191c2VkIDwgbGUxNl90b19jcHUod2Rl
di0+aHdfY2Fwcy5udW1faW5wX2NoX2J1ZnMpKSB7CisJCQlpZiAodHJ5X3dhaXRfZm9yX2NvbXBs
ZXRpb24oJndkZXYtPmhpZl9jbWQucmVhZHkpKSB7CisJCQkJV0FSTighbXV0ZXhfaXNfbG9ja2Vk
KCZ3ZGV2LT5oaWZfY21kLmxvY2spLCAiZGF0YSBsb2NraW5nIGVycm9yIik7CisJCQkJaGlmID0g
d2Rldi0+aGlmX2NtZC5idWZfc2VuZDsKKwkJCX0gZWxzZSB7CisJCQkJaGlmID0gd2Z4X3R4X3F1
ZXVlc19nZXQod2Rldik7CisJCQl9CisJCX0KKwkJaWYgKCFoaWYpCisJCQlyZXR1cm4gaTsKKwkJ
dHhfaGVscGVyKHdkZXYsIGhpZik7CisJfQorCXJldHVybiBpOworfQorCisvKiBJbiBTRElPIG1v
ZGUsIGl0IGlzIG5lY2Vzc2FyeSB0byBtYWtlIGFuIGFjY2VzcyB0byBhIHJlZ2lzdGVyIHRvIGFj
a25vd2xlZGdlIGxhc3QgcmVjZWl2ZWQKKyAqIG1lc3NhZ2UuIEl0IGNvdWxkIGJlIHBvc3NpYmxl
IHRvIHJlc3RyaWN0IHRoaXMgYWNrbm93bGVkZ2UgdG8gU0RJTyBtb2RlIGFuZCBvbmx5IGlmIGxh
c3QKKyAqIG9wZXJhdGlvbiB3YXMgcnguCisgKi8KK3N0YXRpYyB2b2lkIGFja19zZGlvX2RhdGEo
c3RydWN0IHdmeF9kZXYgKndkZXYpCit7CisJdTMyIGNmZ19yZWc7CisKKwl3ZnhfY29uZmlnX3Jl
Z19yZWFkKHdkZXYsICZjZmdfcmVnKTsKKwlpZiAoY2ZnX3JlZyAmIDB4RkYpIHsKKwkJZGV2X3dh
cm4od2Rldi0+ZGV2LCAiY2hpcCByZXBvcnRzIGVycm9yczogJTAyeFxuIiwgY2ZnX3JlZyAmIDB4
RkYpOworCQl3ZnhfY29uZmlnX3JlZ193cml0ZV9iaXRzKHdkZXYsIDB4RkYsIDB4MDApOworCX0K
K30KKworc3RhdGljIHZvaWQgYmhfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCit7CisJ
c3RydWN0IHdmeF9kZXYgKndkZXYgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHdmeF9kZXYs
IGhpZi5iaCk7CisJaW50IHN0YXRzX3JlcSA9IDAsIHN0YXRzX2NuZiA9IDAsIHN0YXRzX2luZCA9
IDA7CisJYm9vbCByZWxlYXNlX2NoaXAgPSBmYWxzZSwgbGFzdF9vcF9pc19yeCA9IGZhbHNlOwor
CWludCBudW1fdHgsIG51bV9yeDsKKworCWRldmljZV93YWtldXAod2Rldik7CisJZG8geworCQlu
dW1fdHggPSBiaF93b3JrX3R4KHdkZXYsIDMyKTsKKwkJc3RhdHNfcmVxICs9IG51bV90eDsKKwkJ
aWYgKG51bV90eCkKKwkJCWxhc3Rfb3BfaXNfcnggPSBmYWxzZTsKKwkJbnVtX3J4ID0gYmhfd29y
a19yeCh3ZGV2LCAzMiwgJnN0YXRzX2NuZik7CisJCXN0YXRzX2luZCArPSBudW1fcng7CisJCWlm
IChudW1fcngpCisJCQlsYXN0X29wX2lzX3J4ID0gdHJ1ZTsKKwl9IHdoaWxlIChudW1fcnggfHwg
bnVtX3R4KTsKKwlzdGF0c19pbmQgLT0gc3RhdHNfY25mOworCisJaWYgKGxhc3Rfb3BfaXNfcngp
CisJCWFja19zZGlvX2RhdGEod2Rldik7CisJaWYgKCF3ZGV2LT5oaWYudHhfYnVmZmVyc191c2Vk
ICYmICF3b3JrX3BlbmRpbmcod29yaykpIHsKKwkJZGV2aWNlX3JlbGVhc2Uod2Rldik7CisJCXJl
bGVhc2VfY2hpcCA9IHRydWU7CisJfQorCV90cmFjZV9iaF9zdGF0cyhzdGF0c19pbmQsIHN0YXRz
X3JlcSwgc3RhdHNfY25mLCB3ZGV2LT5oaWYudHhfYnVmZmVyc191c2VkLCByZWxlYXNlX2NoaXAp
OworfQorCisvKiBBbiBJUlEgZnJvbSBjaGlwIGRpZCBvY2N1ciAqLwordm9pZCB3ZnhfYmhfcmVx
dWVzdF9yeChzdHJ1Y3Qgd2Z4X2RldiAqd2RldikKK3sKKwl1MzIgY3VyLCBwcmV2OworCisJd2Z4
X2NvbnRyb2xfcmVnX3JlYWQod2RldiwgJmN1cik7CisJcHJldiA9IGF0b21pY194Y2hnKCZ3ZGV2
LT5oaWYuY3RybF9yZWcsIGN1cik7CisJY29tcGxldGUoJndkZXYtPmhpZi5jdHJsX3JlYWR5KTsK
KwlxdWV1ZV93b3JrKHN5c3RlbV9oaWdocHJpX3dxLCAmd2Rldi0+aGlmLmJoKTsKKworCWlmICgh
KGN1ciAmIENUUkxfTkVYVF9MRU5fTUFTSykpCisJCWRldl9lcnIod2Rldi0+ZGV2LCAidW5leHBl
Y3RlZCBjb250cm9sIHJlZ2lzdGVyIHZhbHVlOiBsZW5ndGggZmllbGQgaXMgMDogJTA0eFxuIiwK
KwkJCWN1cik7CisJaWYgKHByZXYgIT0gMCkKKwkJZGV2X2Vycih3ZGV2LT5kZXYsICJyZWNlaXZl
ZCBJUlEgYnV0IHByZXZpb3VzIGRhdGEgd2FzIG5vdCAoeWV0KSByZWFkOiAlMDR4LyUwNHhcbiIs
CisJCQlwcmV2LCBjdXIpOworfQorCisvKiBEcml2ZXIgd2FudCB0byBzZW5kIGRhdGEgKi8KK3Zv
aWQgd2Z4X2JoX3JlcXVlc3RfdHgoc3RydWN0IHdmeF9kZXYgKndkZXYpCit7CisJcXVldWVfd29y
ayhzeXN0ZW1faGlnaHByaV93cSwgJndkZXYtPmhpZi5iaCk7Cit9CisKKy8qIElmIElSUSBpcyBu
b3QgYXZhaWxhYmxlLCB0aGlzIGZ1bmN0aW9uIGFsbG93IHRvIG1hbnVhbGx5IHBvbGwgdGhlIGNv
bnRyb2wgcmVnaXN0ZXIgYW5kIHNpbXVsYXRlCisgKiBhbiBJUlEgYWhlbiBhbiBldmVudCBoYXBw
ZW5lZC4KKyAqCisgKiBOb3RlIHRoYXQgdGhlIGRldmljZSBoYXMgYSBidWc6IElmIGFuIElSUSBy
YWlzZSB3aGlsZSBob3N0IHJlYWQgY29udHJvbCByZWdpc3RlciwgdGhlIElSUSBpcworICogbG9z
dC4gU28sIHVzZSB0aGlzIGZ1bmN0aW9uIGNhcmVmdWxseSAob25seSBkdWluZyBkZXZpY2UgaW5p
dGlhbGlzYXRpb24pLgorICovCit2b2lkIHdmeF9iaF9wb2xsX2lycShzdHJ1Y3Qgd2Z4X2RldiAq
d2RldikKK3sKKwlrdGltZV90IG5vdywgc3RhcnQ7CisJdTMyIHJlZzsKKworCVdBUk4oIXdkZXYt
PnBvbGxfaXJxLCAidW5leHBlY3RlZCBJUlEgcG9sbGluZyBjYW4gbWFzayBJUlEiKTsKKwlzdGFy
dCA9IGt0aW1lX2dldCgpOworCWZvciAoOzspIHsKKwkJd2Z4X2NvbnRyb2xfcmVnX3JlYWQod2Rl
diwgJnJlZyk7CisJCW5vdyA9IGt0aW1lX2dldCgpOworCQlpZiAocmVnICYgMHhGRkYpCisJCQli
cmVhazsKKwkJaWYgKGt0aW1lX2FmdGVyKG5vdywga3RpbWVfYWRkX21zKHN0YXJ0LCAxMDAwKSkp
IHsKKwkJCWRldl9lcnIod2Rldi0+ZGV2LCAidGltZSBvdXQgd2hpbGUgcG9sbGluZyBjb250cm9s
IHJlZ2lzdGVyXG4iKTsKKwkJCXJldHVybjsKKwkJfQorCQl1ZGVsYXkoMjAwKTsKKwl9CisJd2Z4
X2JoX3JlcXVlc3Rfcngod2Rldik7Cit9CisKK3ZvaWQgd2Z4X2JoX3JlZ2lzdGVyKHN0cnVjdCB3
ZnhfZGV2ICp3ZGV2KQoreworCUlOSVRfV09SSygmd2Rldi0+aGlmLmJoLCBiaF93b3JrKTsKKwlp
bml0X2NvbXBsZXRpb24oJndkZXYtPmhpZi5jdHJsX3JlYWR5KTsKKwlpbml0X3dhaXRxdWV1ZV9o
ZWFkKCZ3ZGV2LT5oaWYudHhfYnVmZmVyc19lbXB0eSk7Cit9CisKK3ZvaWQgd2Z4X2JoX3VucmVn
aXN0ZXIoc3RydWN0IHdmeF9kZXYgKndkZXYpCit7CisJZmx1c2hfd29yaygmd2Rldi0+aGlmLmJo
KTsKK30KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYmguaCBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYmguaApuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMDAuLmE0NGM4YjQyMWI3YwotLS0gL2Rldi9udWxsCisrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYmguaApAQCAtMCwwICsxLDM0IEBACisvKiBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovCisvKgorICogSW50ZXJydXB0
IGJvdHRvbSBoYWxmIChCSCkuCisgKgorICogQ29weXJpZ2h0IChjKSAyMDE3LTIwMjAsIFNpbGlj
b24gTGFib3JhdG9yaWVzLCBJbmMuCisgKiBDb3B5cmlnaHQgKGMpIDIwMTAsIFNULUVyaWNzc29u
CisgKi8KKyNpZm5kZWYgV0ZYX0JIX0gKKyNkZWZpbmUgV0ZYX0JIX0gKKworI2luY2x1ZGUgPGxp
bnV4L2F0b21pYy5oPgorI2luY2x1ZGUgPGxpbnV4L3dhaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9j
b21wbGV0aW9uLmg+CisjaW5jbHVkZSA8bGludXgvd29ya3F1ZXVlLmg+CisKK3N0cnVjdCB3Znhf
ZGV2OworCitzdHJ1Y3Qgd2Z4X2hpZiB7CisJc3RydWN0IHdvcmtfc3RydWN0IGJoOworCXN0cnVj
dCBjb21wbGV0aW9uIGN0cmxfcmVhZHk7CisJd2FpdF9xdWV1ZV9oZWFkX3QgdHhfYnVmZmVyc19l
bXB0eTsKKwlhdG9taWNfdCBjdHJsX3JlZzsKKwlpbnQgcnhfc2VxbnVtOworCWludCB0eF9zZXFu
dW07CisJaW50IHR4X2J1ZmZlcnNfdXNlZDsKK307CisKK3ZvaWQgd2Z4X2JoX3JlZ2lzdGVyKHN0
cnVjdCB3ZnhfZGV2ICp3ZGV2KTsKK3ZvaWQgd2Z4X2JoX3VucmVnaXN0ZXIoc3RydWN0IHdmeF9k
ZXYgKndkZXYpOwordm9pZCB3ZnhfYmhfcmVxdWVzdF9yeChzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7
Cit2b2lkIHdmeF9iaF9yZXF1ZXN0X3R4KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KTsKK3ZvaWQgd2Z4
X2JoX3BvbGxfaXJxKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KTsKKworI2VuZGlmCi0tIAoyLjM0LjEK
Cg==
