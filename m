Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48D442DB9C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Oct 2021 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhJNOdH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 10:33:07 -0400
Received: from mail-bn8nam08on2051.outbound.protection.outlook.com ([40.107.100.51]:59393
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231826AbhJNOdE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 10:33:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZMVhpT/xPrQs+1sbAKP0cBgvSYRIYXhdaKpO8kQ6DEk+FGqkCI5qoIrA6LErhf4vK3/AVIPNE1+9aNCapE5EjY6gWT73mPbjsitxoI5d/KfvQiJCcCfMNS6dCAAYxdnM4Wjk9m7xC9dj0arXLbvx9amqkChg2o/NqGEIiC+PERGXXdQ83iaH0JDgkLxXAmzySUPJMs5uq7Ts1C5eb+pw6hsaHr89nPkyxFNx3pSlQRILDK02xyFXVZ5uyk2et2ZePg2YNMlOBIGEUzEUNYikzlx5+L4wIdXr29rD5zep5GhDN6EOctZc3z/2IkKBbnjQ1dQCOR/gBe5E2RkfYLG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHLhGUr47mbss20fprjnXML/wDBRZ+cnYgR/gwb5xvs=;
 b=D9KfcLqW1fVQdwum4IZ9v0HmUqGI+zhTSw07y58Fjw8/lag7fM8v5avxymZo64Fk+h/ZK6ywlJdpY4qBkh/K+TCbnajKtYpm1bkZDHFO0Vp1KFmgmichNQdo6uBH2xHUDNj8jZyEd5dkJ3136GmxzYMCQcvzqt/N8zqMC5DcniP9tK9SKIm0ZSNu+yvENIy/JaW6sQfeD4aAfjLkPlVWEToKw7M36UYFBvl0mzEBc6yn5VVbAUHXSc3DL6ZkbguvsoatQQOgyW+tYI95iZQogHyKLHxuFyU0EYfwIbJVIF3mCSLh6Za961axkLi2u+3JUIwstiWiBbBDs2WhItCKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHLhGUr47mbss20fprjnXML/wDBRZ+cnYgR/gwb5xvs=;
 b=nKHA1s+aOPkH5cEYJykH3tPRiQBZ1vGr5u91zXutE8VMfQ3N8vdakZqXQEUqr9/vl26ffwQvq9RT9ir/uTxLe97HwY2Ib2QrrT4X3pI93RvEuD/lNVagL2DNEot1t9u0LfzkFm38WWaapohK9V44Za+icvjwO49hNhVI0hGNApA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5660.namprd11.prod.outlook.com (2603:10b6:510:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 14 Oct
 2021 14:30:56 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::31cb:3b13:b0e8:d8f4%9]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 14:30:56 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [RFC PATCH 2/2] mmc: allow to match the device tree to apply quirks
Date:   Thu, 14 Oct 2021 16:30:31 +0200
Message-Id: <20211014143031.1313783-3-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014143031.1313783-1-Jerome.Pouiller@silabs.com>
References: <20211014143031.1313783-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PAZP264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::20) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PAZP264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 14:30:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ab732ae-e2bf-44c5-8172-08d98f1f3bc6
X-MS-TrafficTypeDiagnostic: PH0PR11MB5660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB56607DD3B6171B614F9DA46493B89@PH0PR11MB5660.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvk7qAABwjGq1/DVzdZoCb6Ph6GuLeRKx5Om/aut26nkUK7P2VEeDYsYWhc0nGtouDzhOvjYpgxVFJlh5dwgt86QsbLQvuReYP5tkz+PfcVI/gwf0AA9I3pMhmSYqSdLFuw7LdCp4W7Xd97DDLKAUxYfL8zG3+E7mgmA7SYltR6ISyJyPi56ZIwmeFpGogHEF4CkYt78CwKw9/OGv4n7f8xqn4EYH+1exlTZ4r5MpGj0xpfIbPCYOZbMIVlg/IZ5raxVsfUYw+Sm2gN1R4E/8U8GDxFq3p/AFHegtysdjqj4gHKiKj2j0VVQ8KP9kzpkrh2rsnNRPha1PvqNzcEjo7pFzSO1ZRWdE1kcSsZIqPvuQWXsvAN8sGAv/gjJ7+2Va65FGrEXgkhXjAZctY8EvaRWtnHJ11APHJu2ktcjIsx5E5bfiaxQfq2Wl9YymAXxnY8C+Py1ahLj0j9pC7SWiPBeZMhv6LspOp2BjG1M0wpL91PBvYctuU9MzfBWytXDBlWvbkXxfGmWW3LxHgCyRZS6p4wWXRNimMF8Hl0E2zzn8fqz0MQiEbcJa8EXE4K+FWvdm9qOd7lJJ6v/9Yll+ftUKoU8tJT+oBW5R4x3UF0i2PTFXEBrSBV3yaV8Cteep1K0yAsvLR2UATAtUFzSH4m8lq5PEPY1o5qaeyhcv4k77p4qnzPWek/JImxJ6WxyLXtWpYkdy2k9yNKUIpVhvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(8936002)(66476007)(956004)(2616005)(36756003)(6486002)(508600001)(107886003)(4326008)(6666004)(26005)(316002)(7696005)(66556008)(5660300002)(186003)(6916009)(1076003)(2906002)(52116002)(38100700002)(8676002)(86362001)(38350700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTFrU3ZXNlRUMUIwMjAwSGJhM0UzV2JsOThOY2xQdWN3bTlFdDJwblFoZU1C?=
 =?utf-8?B?OHNKbFlrQzJSUDRBRmVnbHg5NDBTSlhYYWNnbjNPRDhzU1JVUG5La2dQeGd5?=
 =?utf-8?B?WEpBSGNMZU5hNVowb2xSWll4SENuR2ZDNldCbmJoSEpWeEZud09zT0dxZWM5?=
 =?utf-8?B?SHkxcGk2bHVDQVBBbFRDMU4zWEZyTFRJaHNuTlRkbFhoUVpFeDFjSUxkVFg3?=
 =?utf-8?B?USsxN05PdURoT0dkUk0yY0pSL0VwVkRmWmxzMkgzd2I3REFaNjhtVjVtV0Jk?=
 =?utf-8?B?VklIeUJXUDAvUkM0V3laWGNmY1RNQ25zdmNFb3hUelN5S1JPNGhPcWc1bTF6?=
 =?utf-8?B?bW41M0NHalg3eWlsazRTMjJSWVc4VW5kcWxUcU9CS0IrZ0ZDdGFLcm1jYU8w?=
 =?utf-8?B?UnFBTW90SGcwaGJsMEFyd0ZhRGF6L2dxVlFLOVZTc0FORldNVzNudjU5dEo5?=
 =?utf-8?B?U3ROR3ozTDhwQ2lUdnJFenlRdGlNVlU2WGE5aFdUZU5nWXNaTFhaazF2cW05?=
 =?utf-8?B?SGhhVlZxcjlvdzZNYWxRWXRJM1BTdFZidlpIS2x3dnVHS3VzTVAzQk1Fc1RL?=
 =?utf-8?B?WWd5N1N0ZW1SMEZhRzZ5Rmhob1o1cHdoVEF5OWM2RTFVVUgyY2RjT3diRUVw?=
 =?utf-8?B?ak9SKytKQWMvUkdTQXF4aE5pbis1N2sxN2VsYk5zUVVpMTNFRnFOcy8xd2Ux?=
 =?utf-8?B?YnFBMUloMGJIK2s2Z0ZFTklyV0JJYlFsbEJzaXBlVU9tWElIbFhDd3U3SHEy?=
 =?utf-8?B?REc1bG0xWmJWMzAyTS9FOEhsRjdaZjBKamJKbkVUVUszVUd3dXBlR1FzaFlY?=
 =?utf-8?B?SDg2YThiS2t6ZE9yVHdFYlhRY2JLMWxVWlMvUXUvSzloYUJuNTlXeTZFZ2Qv?=
 =?utf-8?B?RmJTNUxLWCtYVTM1M3Y3OXBOM1VjRmR3b3Qza2Mva2hpWVFXclFCK3Y4K0RK?=
 =?utf-8?B?UHd2bjZudFltaHI3NUVwSXlKRTg5TzdiUHVaT01ld1ZQVzhObHRtMFNtSk9j?=
 =?utf-8?B?K2JmTjhZYXVBOTExMXdlYmk0L3lTcDZ2MnN3VVBuL0VWMlpiMi9xRjVEeWhw?=
 =?utf-8?B?OFVJU0tKSG1uWVBXTmpaTE11b2RCSkZpT1pBb01sM2gxWlZWL1NOTzlQMXV0?=
 =?utf-8?B?NXZva001aVFyRGNkWEN2VTZUS2ZPdjYvTHJCN2ErT3RqQVlwQ2k3VzZWeitF?=
 =?utf-8?B?NnJsVjE1bGxTMllPem1Ic1BGRnlnTlRmemtYN1ZtM2VRQmVzZTBwQUNvWURI?=
 =?utf-8?B?Q0h2bjZvWVgxWU5BbjhnRmNIU3dzaGdaVURGS2dEZ3lHZ2pCMjVMNGlWK3l2?=
 =?utf-8?B?WVFjVmVTK1pnUlRpRFMyT2tZK05aazVSUU5zYXZVYXZOTlpCVXFqOHNjMGlw?=
 =?utf-8?B?NXpJUUdZUkZmVnlKS0wxRHB4ck84Mys0dFhoT2dsdVk0azNvVWpQYkYvZFpj?=
 =?utf-8?B?TXp5K2RyZUFhZEYwN2FmWTh3akkzbEVuNWdlWVhPU2hiN0hnZHZvSDNGRGcw?=
 =?utf-8?B?NkhUTmhITHkzZnRkMjFTZHNIQmdWYnVFSng3eGNxQ3czMWFVRDJJeFZ1RERK?=
 =?utf-8?B?QWZJbkFIWmF1WUhnOHlDckpoR2lxWUhwVHg4WmI1blFaZXRNbXFPNU5sd1pn?=
 =?utf-8?B?cHRDc1d2blhGR0tUKzlCRDhXRDNaY05UbmFLcVlCM0ZrSHpSZExYSEltcHdN?=
 =?utf-8?B?d29mODdoQUt5TlA1TFM4eTRQNXhxbitnd1Q4aC9DKytwTkRxSUJPTXVTc3F0?=
 =?utf-8?Q?Zm9AkBmfH3ho5Jh41DaTFBnLKGC6c0s6h/Smq4U?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab732ae-e2bf-44c5-8172-08d98f1f3bc6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 14:30:56.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLeMYgC1GJh5XJD+DyNrOXczWEgW4iRiRBD1mtQ0Up188nY7BivGn/s96MatxI07QnE/QUrqdl7G4bMN6w5dxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5660
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKTU1D
IHN1YnN5c3RlbSBwcm92aWRlcyBhIHdheSB0byBhcHBseSBxdWlya3Mgd2hlbiBhIGRldmljZSBt
YXRjaCBzb21lCnByb3BlcnRpZXMgKFZJRCwgUElELCBldGMuLi4pIFVuZm9ydHVuYXRlbHksIHNv
bWUgU0RJTyBkZXZpY2VzIGRvZXMgbm90CmNvbXBseSB3aXRoIHRoZSBTRElPIHNwZWNpZmljYXRp
b24gYW5kIGRvZXMgbm90IHByb3ZpZGUgcmVsaWFibGUgVklEL1BJRAooZWcuIFNpbGFicyBXRjIw
MCkuCgpTbywgdGhlIGRyaXZlcnMgZm9yIHRoZXNlIGRldmljZXMgcmVseSBvbiBkZXZpY2UgdHJl
ZSB0byBpZGVudGlmeSB0aGUKZGV2aWNlLgoKVGhpcyBwYXRjaCBhbGxvd3MgdGhlIE1NQyB0byBh
bHNvIHJlbHkgb24gdGhlIGRldmljZSB0cmVlIHRvIGFwcGx5IGEKcXVpcmsuCgpTaWduZWQtb2Zm
LWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQog
ZHJpdmVycy9tbWMvY29yZS9jYXJkLmggICB8ICAzICsrKwogZHJpdmVycy9tbWMvY29yZS9xdWly
a3MuaCB8IDE4ICsrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jYXJkLmggYi9kcml2ZXJzL21t
Yy9jb3JlL2NhcmQuaAppbmRleCA3YmQzOTJkNTVjZmEuLjJmNzNmODU2N2UxNCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9tbWMvY29yZS9jYXJkLmgKKysrIGIvZHJpdmVycy9tbWMvY29yZS9jYXJkLmgK
QEAgLTU5LDYgKzU5LDkgQEAgc3RydWN0IG1tY19maXh1cCB7CiAJLyogZm9yIE1NQyBjYXJkcyAq
LwogCXVuc2lnbmVkIGludCBleHRfY3NkX3JldjsKIAorCS8qIE1hdGNoIGFnYWluc3QgZnVuY3Rp
b25zIGRlY2xhcmVkIGluIGRldmljZSB0cmVlICovCisJY29uc3QgY2hhciAqY29uc3QgKm9mX2Nv
bXBhdGlibGU7CisKIAl2b2lkICgqdmVuZG9yX2ZpeHVwKShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQs
IGludCBkYXRhKTsKIAlpbnQgZGF0YTsKIH07CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3Jl
L3F1aXJrcy5oIGIvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaAppbmRleCBjN2VmMmQxNGIzNTku
LmVmMzY4Mzg2ZTcxMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaAorKysg
Yi9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oCkBAIC0xMCw2ICsxMCw3IEBACiAgKgogICovCiAK
KyNpbmNsdWRlIDxsaW51eC9vZi5oPgogI2luY2x1ZGUgPGxpbnV4L21tYy9zZGlvX2lkcy5oPgog
CiAjaW5jbHVkZSAiY2FyZC5oIgpAQCAtMTQ1LDYgKzE0NiwyMCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG1tY19maXh1cCBfX21heWJlX3VudXNlZCBzZGlvX2ZpeHVwX21ldGhvZHNbXSA9IHsKIAlF
TkRfRklYVVAKIH07CiAKK3N0YXRpYyBpbmxpbmUgYm9vbCBtbWNfZml4dXBfb2ZfY29tcGF0aWJs
ZV9tYXRjaChzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsCisJCQkJCQkgY29uc3QgY2hhciAqY29uc3Qg
KmNvbXBhdF9saXN0KQoreworCXN0cnVjdCBkZXZpY2Vfbm9kZSAqb2Zfbm9kZTsKKwlpbnQgaTsK
KworCWZvciAoaSA9IDA7IGkgPCA3OyBpKyspIHsKKwkJb2Zfbm9kZSA9IG1tY19vZl9maW5kX2No
aWxkX2RldmljZShjYXJkLT5ob3N0LCBpKTsKKwkJaWYgKG9mX25vZGUgJiYgb2ZfZGV2aWNlX2Nv
bXBhdGlibGVfbWF0Y2gob2Zfbm9kZSwgY29tcGF0X2xpc3QpKQorCQkJcmV0dXJuIHRydWU7CisJ
fQorCXJldHVybiBmYWxzZTsKK30KKwogc3RhdGljIGlubGluZSB2b2lkIG1tY19maXh1cF9kZXZp
Y2Uoc3RydWN0IG1tY19jYXJkICpjYXJkLAogCQkJCSAgICBjb25zdCBzdHJ1Y3QgbW1jX2ZpeHVw
ICp0YWJsZSkKIHsKQEAgLTE3Myw2ICsxODgsOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbW1jX2Zp
eHVwX2RldmljZShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsCiAJCQljb250aW51ZTsKIAkJaWYgKHJl
diA8IGYtPnJldl9zdGFydCB8fCByZXYgPiBmLT5yZXZfZW5kKQogCQkJY29udGludWU7CisJCWlm
IChmLT5vZl9jb21wYXRpYmxlICE9IE5VTEwgJiYKKwkJICAgICFtbWNfZml4dXBfb2ZfY29tcGF0
aWJsZV9tYXRjaChjYXJkLCBmLT5vZl9jb21wYXRpYmxlKSkKKwkJCWNvbnRpbnVlOwogCiAJCWRl
dl9kYmcoJmNhcmQtPmRldiwgImNhbGxpbmcgJXBzXG4iLCBmLT52ZW5kb3JfZml4dXApOwogCQlm
LT52ZW5kb3JfZml4dXAoY2FyZCwgZi0+ZGF0YSk7Ci0tIAoyLjMzLjAKCg==
