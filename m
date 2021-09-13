Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA94408BBB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbhIMNFe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:05:34 -0400
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:64256
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240056AbhIMNEq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jylXzKLLvKfrj4cAwDnHXFMO+963SB9KLa3fbN/NxWM/ReniSQi8p3knppgl6mq5sApwSURII6y3OzJY10oCrk1TV9y/m16/ABPWWW1Ye4vBIHUjcdHDSrjLlxLfYmxXlMDU7I5NocdJUwtJYpKeTlNKc9lQnyOeTtpHZ+GHiGiDS9+a9Y7+L42Hq4mramhztf9kqcwASzisV8bDMCycb993FTqXrRZyk8N+eqCV5ZxU4gQ492fjCmEu1hHRvipiSeLYcDuxNYzDjedGMCkD0gC3mybP/w4Uientu5jI9dHW6hcxCvxkjWZ19s8UHRQT0uf7UTcSffmkrB6tnyP6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=h4gFsja4+jJI7sjoTYcLY2a3J4ayXpCUWNk/C6lnwUw=;
 b=W5HxcE7tpksRyxxMlHyH2ePAYMCQx1AvnU2pHFS63CeHPTMLzIjBFQoMnUVguSsMMwWaBdT1BDy93pNE0eE2ilGwCwDNh4kqUXftLEILr2WoEA3JIshF9LN6hX0IpjPNaAtfiv3cBvz8vGUJib7qxEYZmcCCEwtSwmON1PuYe6rUhHu2rUsL2CtN/Mba3ZB+APaGD9/cpvwic8348nsufbkfG0pqtqIyDlTYa6BuULYYtNTuY4Osq4EoqlXRfhiyMAobTy/Y2h1VYSrDI69vj7g7H1rfoz2Xm1AaFJCzNJAAFh/dq1hHYM63C/ytzn0hyJKztSgHPA/0I8OArF9qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4gFsja4+jJI7sjoTYcLY2a3J4ayXpCUWNk/C6lnwUw=;
 b=kbfg9CSyIzbJasmTKAfuYzpJIN/MLzZzKFCTayjKx10jLRcRlzA0jNKFKPpwer6RpeaoXbwMcRLjxULIFZ5LtdncdQtQa261NB2dk0yJ9EyvUuz6PvcAB/K19UAf1kOmlcIHuvlpFdfzNSvfLlsKOmheEloIC4WgbSm5oCxPSfY=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3502.namprd11.prod.outlook.com (2603:10b6:805:da::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 13:03:03 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd%7]) with mapi id 15.20.4500.017; Mon, 13 Sep 2021
 13:03:03 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 24/32] staging: wfx: remove references to WFxxx in comments
Date:   Mon, 13 Sep 2021 15:01:55 +0200
Message-Id: <20210913130203.1903622-25-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913130203.1903622-1-Jerome.Pouiller@silabs.com>
References: <20210913130203.1903622-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR2P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::33)
 To SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PR2P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:03:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 611b6a58-ac36-43bc-a591-08d976b6d1d9
X-MS-TrafficTypeDiagnostic: SN6PR11MB3502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB3502669176BD210C7CEB985B93D99@SN6PR11MB3502.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 299lcnW53emT5CP5trlCwBQWvSY32LBHp0rNflRqqLE5z1GOqt08vJNSN5Y4F4fWaZMBiK4XhqdMeVzdraX5aDtdGkOUkOGSwwkXSOL49H2E0kZoGkreQDyyfv/P8Vqw7I/XpUhRNj8uw+FWCQO5YuXT3YQM8dfT4FvIRB1T7D19Oi6/pSzGmwcOu9k0R6Sad7/C1f+HWeNbAX1wFACLwHc8fp2kK3s5acrR4ba3XqvAYCLFnRua2a3NQF5Up0Uabg9/l6T5ECaajNjDdO7u+0/s183kbue1kQQNugsgl5gDyAvgFrXJmdoPL1dB359rmT3QAbbXbPdBDmv4MwliPajmkfg0hC2ba0vAjx7DgSLqti/mi8pZkMvX9Z0VhAMGtl/GgkAX2zvbHhgW1a0O6/6iB8ACuCdpnHPY0SuopZX52lqSkG6MKLOvlwHR/jy8XIKRH30cn1L3jyAEXGzyCiwSUEnYIXStcsIPEyQs68/i5Hnn+aeXV6ZCQWCOA36N+1pTr1aOwGMeNrbEyDPGYf1HWdrDZrogbUICADzLAhpR+hvm+BrVRDvKiDWN9uSs83EtZTTETOWjbNyftk9YsR9pHkNWGu+AnQbIxLxBv3Qjt5myLugWztV3qem6Ns9fxUbiSIJi9+ZvXq0nyqarQauxTZbE7RilX7SUnj6Tn29Yg+JqZkGxs0w8LG7ZXunKVZtsLVAeJWe3gaw3QGeAjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(376002)(346002)(366004)(6666004)(316002)(66476007)(8676002)(186003)(7696005)(52116002)(30864003)(66946007)(26005)(4326008)(66556008)(2906002)(54906003)(107886003)(6486002)(2616005)(478600001)(1076003)(36756003)(5660300002)(66574015)(956004)(8936002)(86362001)(38100700002)(38350700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3FJN0pROGRXNzhnaUxuTlprM0xrQ2JSYXdrR0ZaZlU1RDN3eHcvWThlSXRw?=
 =?utf-8?B?UCsyajJveDhhSUlCTk9nZEl0NS8zVCtBaGcwMWltcUhEV2NZcnVxVGJoUTJJ?=
 =?utf-8?B?cHNLeENDbG0vaWxLZmREWU5iRHBBbTN1Z3pUU095Vi84ODc3UzB4Nm5XMytX?=
 =?utf-8?B?bTQ1TWhBczlUY1BzZzNHc0dGd2I4WXNLMkdjRU9XZ1NsZ1IrUEdIOXVpNmNi?=
 =?utf-8?B?VStiV3RLVGoyQXJ2cTNhZDlHcVhwS2pyekd3UkhHb2pOeG5tUWkwUzlEOXJR?=
 =?utf-8?B?Ny9SZUJWYVlaZTVVQTZ4SnBGNU1Hb2s5ZkJuODM1cEJzK1RaZDZJbWppR05t?=
 =?utf-8?B?YkdaZmpZbmN6OHFKNFVOY1djSjBZa1NiN1VmUzdWR2x0Y0dFZklGdGZiWnFa?=
 =?utf-8?B?T2MvdVB1WkV0aktoeTkvaDdERmFadmJ0RXYzL0hrZzh3c3ROUmFrUFgwYytw?=
 =?utf-8?B?aHBrVUt1MU1tbUY0cENNYTJRTWJJMzhVUkRWdDl0cnJDbWNzSnRQbmtvOXBQ?=
 =?utf-8?B?OGw2WFVHY0EzblhFN3g0cS96cEFRNDRaSzIySXNhU1ExVGFvdlEyakhvRDJT?=
 =?utf-8?B?enNIdmJDSEpQY1Y4VWhaK3ArelNFNDlCMVNTNTV1S3VYdkNJSksybFpaNDNq?=
 =?utf-8?B?UkIyZ3NNT2h0eHk0aWplOTdPZ1VrNXNCMjhjdkhFOWVBZGZGZ2ExMFFoUWUz?=
 =?utf-8?B?S1VvQ3ZEdzIyZXhKMkpkaDQ5T3JnZ3pLcnI2U0Y0N0lDbzhxMmNyT0YybjJF?=
 =?utf-8?B?NDdaYVRZcVNCWTFrc2xkaUtWUW9uNmtjdTczck51WGRpeFVrbk9FcGs3ZkMz?=
 =?utf-8?B?QUZibUlyak10cHVEMWpRWExZWjBBWk11RXB4dmZCSzNsdjZDUmZwU3BGL29Q?=
 =?utf-8?B?T3NBRXJwR3NTU2QyYm9TVHFyem90WWZmcEFGakEvVlk4WUM2N2hlNGNrWXFn?=
 =?utf-8?B?NU5iUWpFT3lwRm9oTWVFM0NjNWhHdkNMRFZsemZwYWlYbGswdHlaWnJiL0lG?=
 =?utf-8?B?bW5zVzVBUnMwQzdoZ2xoN0hVVHBtTmNkNkNMc29oV3lLTVBmbGxBZTllNDNI?=
 =?utf-8?B?Mm0venVmTmxNSGp0VUFDaUVTOGx3MnNCZkJBVlFJUkV1L2doNTJVcEI4NUla?=
 =?utf-8?B?dGxzdDFud3c5NWNXQmNuZS9MQTFtSW1HQXFpdnZ2cGQ0Rk1YWTd2QXdMVTMx?=
 =?utf-8?B?K2xXYnIybjdySWZtRFRKYkNZVUZJUUhZOGFjT2RNZ2tIcWNyeHloOXRtMXZB?=
 =?utf-8?B?YWRtVzk2NHhhUmp3b3lzVkRmTzZlNFNmdEZGUk5QZS9mbTdpbXIzdFhsbkdz?=
 =?utf-8?B?c0FTc1lEQ3I4VWNqL3ZDMm5RdVViblZhT2hmUFUzZklvallQbkNEVnh0c3Jh?=
 =?utf-8?B?TVdDNmNTVmZNdVZRaGZwSzYvNFkvRUl5cEh5b3hWRVp5a1o4M3RyUUFPMm02?=
 =?utf-8?B?aGp2cEhNUHRnQU5qMFREY0U2R29VK2RCdDgzTVArT05uN29HNXpjZEZreFdk?=
 =?utf-8?B?eWdyVnJoUE04OHl4SjFuSjc0UlJNNDBNWWYwWWRtT2xnaFAzdFQ2U0prVHA3?=
 =?utf-8?B?eC9EQVVCTWZ6Tk9CUkJ5L1hWVFc4MzMrc0lyZGhQWXhCblYyMkNHK0NnTWVh?=
 =?utf-8?B?UjdMSmJxRVNXTStBNWs3NGt1OFVPVWg2SjZ6YkR3eWwzZFRwcjdoZjlXZE1q?=
 =?utf-8?B?S3JrWCtEa09oSXRQcHB4N3NGTkhSdCtWMUNUWmdQSTkvOTQ1RnNxTVJYakRh?=
 =?utf-8?Q?0fkPvdCKtvgernuSCDJYkC+xqYknRf0FxPVMOJn?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611b6a58-ac36-43bc-a591-08d976b6d1d9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:03:02.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxLtf+My3Ep7X7XBajZymR4eMCvBT2lXjrYbUd/Xqaf88ZGdANswg2GfCzyGohwJ/zN7RdRCZNBO+QKrFcGeRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3502
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKVGhl
IFdGMjAwIGlzIHRoZSBvbmx5IHJlcHJlc2VudGF0aXZlIG9mIHRoZSBXRnh4eCBzZXJpZXMgYW5k
IHRoZQpkZXZlbG9wbWVudCBvZiBhbnkgc3VjY2Vzc29yIGlzIG5vdCBleHBlY3RlZC4gU28sIGZv
ciBjbGFyaXR5LCByZXBsYWNlCm9jY3VycmVuY2VzIG9mICJXRnh4eCIgd2l0aCAiV0YyMDAiLgoK
U2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMu
Y29tPgotLS0KIGRyaXZlcnMvc3RhZ2luZy93ZngvYmguYyAgICAgICAgICAgICAgfCAgNCArKy0t
CiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2J1c19zcGkuYyAgICAgICAgIHwgIDYgKysrLS0tCiBkcml2
ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfdHguYyAgICAgICAgIHwgIDQgKystLQogZHJpdmVycy9zdGFn
aW5nL3dmeC9md2lvLmMgICAgICAgICAgICB8ICA0ICsrLS0KIGRyaXZlcnMvc3RhZ2luZy93Zngv
aGlmX2FwaV9jbWQuaCAgICAgfCAgMiArLQogZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX2dl
bmVyYWwuaCB8ICAyICstCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9hcGlfbWliLmggICAgIHwg
IDIgKy0KIGRyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3J4LmMgICAgICAgICAgfCAgMyArLS0KIGRy
aXZlcnMvc3RhZ2luZy93ZngvaGlmX3J4LmggICAgICAgICAgfCAgMyArLS0KIGRyaXZlcnMvc3Rh
Z2luZy93ZngvaGlmX3R4LmMgICAgICAgICAgfCAxMiArKysrKy0tLS0tLS0KIGRyaXZlcnMvc3Rh
Z2luZy93ZngvaGlmX3R4LmggICAgICAgICAgfCAgNCArKy0tCiBkcml2ZXJzL3N0YWdpbmcvd2Z4
L2hpZl90eF9taWIuYyAgICAgIHwgIDIgKy0KIGRyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3R4X21p
Yi5oICAgICAgfCAgMiArLQogZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmMgICAgICAgICAgICB8
ICAyICstCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L3N0YS5jICAgICAgICAgICAgIHwgIDQgKy0tLQog
ZHJpdmVycy9zdGFnaW5nL3dmeC9zdGEuaCAgICAgICAgICAgICB8ICAyICstCiBkcml2ZXJzL3N0
YWdpbmcvd2Z4L3dmeC5oICAgICAgICAgICAgIHwgIDIgKy0KIDE3IGZpbGVzIGNoYW5nZWQsIDI3
IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Rh
Z2luZy93ZngvYmguYyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvYmguYwppbmRleCBlZDUzZDBiNDU1
OTIuLjc4ZmE4MWQ4MjUxNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9iaC5jCisr
KyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvYmguYwpAQCAtNzIsNyArNzIsNyBAQCBzdGF0aWMgaW50
IHJ4X2hlbHBlcihzdHJ1Y3Qgd2Z4X2RldiAqd2Rldiwgc2l6ZV90IHJlYWRfbGVuLCBpbnQgKmlz
X2NuZikKIAlpbnQgcGlnZ3liYWNrID0gMDsKIAogCVdBUk4ocmVhZF9sZW4gPiByb3VuZF9kb3du
KDB4RkZGLCAyKSAqIHNpemVvZih1MTYpLAotCSAgICAgIiVzOiByZXF1ZXN0IGV4Y2VlZCBXRngg
Y2FwYWJpbGl0eSIsIF9fZnVuY19fKTsKKwkgICAgICIlczogcmVxdWVzdCBleGNlZWQgdGhlIGNo
aXAgY2FwYWJpbGl0eSIsIF9fZnVuY19fKTsKIAogCS8vIEFkZCAyIHRvIHRha2UgaW50byBhY2Nv
dW50IHBpZ2d5YmFjayBzaXplCiAJYWxsb2NfbGVuID0gd2Rldi0+aHdidXNfb3BzLT5hbGlnbl9z
aXplKHdkZXYtPmh3YnVzX3ByaXYsIHJlYWRfbGVuICsgMik7CkBAIC0xODEsNyArMTgxLDcgQEAg
c3RhdGljIHZvaWQgdHhfaGVscGVyKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX21z
ZyAqaGlmKQogCiAJZGF0YSA9IGhpZjsKIAlXQVJOKGxlbiA+IHdkZXYtPmh3X2NhcHMuc2l6ZV9p
bnBfY2hfYnVmLAotCSAgICAgIiVzOiByZXF1ZXN0IGV4Y2VlZCBXRnggY2FwYWJpbGl0eTogJXp1
ID4gJWRcbiIsIF9fZnVuY19fLAorCSAgICAgIiVzOiByZXF1ZXN0IGV4Y2VlZCB0aGUgY2hpcCBj
YXBhYmlsaXR5OiAlenUgPiAlZFxuIiwgX19mdW5jX18sCiAJICAgICBsZW4sIHdkZXYtPmh3X2Nh
cHMuc2l6ZV9pbnBfY2hfYnVmKTsKIAlsZW4gPSB3ZGV2LT5od2J1c19vcHMtPmFsaWduX3NpemUo
d2Rldi0+aHdidXNfcHJpdiwgbGVuKTsKIAlyZXQgPSB3ZnhfZGF0YV93cml0ZSh3ZGV2LCBkYXRh
LCBsZW4pOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc3BpLmMgYi9kcml2
ZXJzL3N0YWdpbmcvd2Z4L2J1c19zcGkuYwppbmRleCBhOTkxMjVkMWEzMGQuLjc1OWUwODUwNDhj
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc3BpLmMKKysrIGIvZHJpdmVy
cy9zdGFnaW5nL3dmeC9idXNfc3BpLmMKQEAgLTM5LDkgKzM5LDkgQEAgc3RydWN0IHdmeF9zcGlf
cHJpdiB7CiB9OwogCiAvKgotICogV0Z4IGNoaXAgcmVhZCBkYXRhIDE2Yml0cyBhdCB0aW1lIGFu
ZCBwbGFjZSB0aGVtIGRpcmVjdGx5IGludG8gKGxpdHRsZQotICogZW5kaWFuKSBDUFUgcmVnaXN0
ZXIuIFNvLCBjaGlwIGV4cGVjdCBieXRlIG9yZGVyIGxpa2UgIkIxIEIwIEIzIEIyIiAod2hpbGUK
LSAqIExFIGlzICJCMCBCMSBCMiBCMyIgYW5kIEJFIGlzICJCMyBCMiBCMSBCMCIpCisgKiBUaGUg
Y2hpcCByZWFkcyAxNmJpdHMgb2YgZGF0YSBhdCB0aW1lIGFuZCBwbGFjZSB0aGVtIGRpcmVjdGx5
IGludG8gKGxpdHRsZQorICogZW5kaWFuKSBDUFUgcmVnaXN0ZXIuIFNvLCB0aGUgY2hpcCBleHBl
Y3RzIGJ5dGVzIG9yZGVyIHRvIGJlICJCMSBCMCBCMyBCMiIKKyAqICh3aGlsZSBMRSBpcyAiQjAg
QjEgQjIgQjMiIGFuZCBCRSBpcyAiQjMgQjIgQjEgQjAiKQogICoKICAqIEEgbGl0dGxlIGVuZGlh
biBob3N0IHdpdGggYml0c19wZXJfd29yZCA9PSAxNiBzaG91bGQgZG8gdGhlIHJpZ2h0IGpvYgog
ICogbmF0aXZlbHkuIFRoZSBjb2RlIGJlbG93IHRvIHN1cHBvcnQgYmlnIGVuZGlhbiBob3N0IGFu
ZCBjb21tb25seSB1c2VkIFNQSQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRh
X3R4LmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfdHguYwppbmRleCA3N2Q2OWVkNzNlMjgu
LmYxNDFhYjUwZjRmZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3R4LmMK
KysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9kYXRhX3R4LmMKQEAgLTMxLDggKzMxLDggQEAgc3Rh
dGljIGludCB3ZnhfZ2V0X2h3X3JhdGUoc3RydWN0IHdmeF9kZXYgKndkZXYsCiAJCX0KIAkJcmV0
dXJuIHJhdGUtPmlkeCArIDE0OwogCX0KLQkvLyBXRnggb25seSBzdXBwb3J0IDJHSHosIGVsc2Ug
YmFuZCBpbmZvcm1hdGlvbiBzaG91bGQgYmUgcmV0cmlldmVkCi0JLy8gZnJvbSBpZWVlODAyMTFf
dHhfaW5mbworCS8vIFRoZSBkZXZpY2Ugb25seSBzdXBwb3J0IDJHSHosIGVsc2UgYmFuZCBpbmZv
cm1hdGlvbiBzaG91bGQgYmUKKwkvLyByZXRyaWV2ZWQgZnJvbSBpZWVlODAyMTFfdHhfaW5mbwog
CWJhbmQgPSB3ZGV2LT5ody0+d2lwaHktPmJhbmRzW05MODAyMTFfQkFORF8yR0haXTsKIAlpZiAo
cmF0ZS0+aWR4ID49IGJhbmQtPm5fYml0cmF0ZXMpIHsKIAkJV0FSTigxLCAid3JvbmcgcmF0ZS0+
aWR4IHZhbHVlOiAlZCIsIHJhdGUtPmlkeCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcv
d2Z4L2Z3aW8uYyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvZndpby5jCmluZGV4IDFiOGFlYzAyZDE2
OS4uN2I5MWFjNjE1ZjRhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2Z3aW8uYwor
KysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2Z3aW8uYwpAQCAtMjA3LDggKzIwNyw4IEBAIHN0YXRp
YyBpbnQgdXBsb2FkX2Zpcm13YXJlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBjb25zdCB1OCAqZGF0
YSwgc2l6ZV90IGxlbikKIAkJaWYgKHJldCA8IDApCiAJCQlyZXR1cm4gcmV0OwogCi0JCS8vIFdG
eCBzZWVtcyB0byBub3Qgc3VwcG9ydCB3cml0aW5nIDAgaW4gdGhpcyByZWdpc3RlciBkdXJpbmcK
LQkJLy8gZmlyc3QgbG9vcAorCQkvLyBUaGUgZGV2aWNlIHNlZW1zIHRvIG5vdCBzdXBwb3J0IHdy
aXRpbmcgMCBpbiB0aGlzIHJlZ2lzdGVyCisJCS8vIGR1cmluZyBmaXJzdCBsb29wCiAJCW9mZnMg
Kz0gRE5MRF9CTE9DS19TSVpFOwogCQlyZXQgPSBzcmFtX3JlZ193cml0ZSh3ZGV2LCBXRlhfRENB
X1BVVCwgb2Zmcyk7CiAJCWlmIChyZXQgPCAwKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5n
L3dmeC9oaWZfYXBpX2NtZC5oIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX2NtZC5oCmlu
ZGV4IDU4YzliYjAzNjAxMS4uNTUzZGM0NTE0MmYyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdp
bmcvd2Z4L2hpZl9hcGlfY21kLmgKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX2Nt
ZC5oCkBAIC0xLDYgKzEsNiBAQAogLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEFwYWNoZS0y
LjAgKi8KIC8qCi0gKiBXRnggaGFyZHdhcmUgaW50ZXJmYWNlIGRlZmluaXRpb25zCisgKiBXRjIw
MCBoYXJkd2FyZSBpbnRlcmZhY2UgZGVmaW5pdGlvbnMKICAqCiAgKiBDb3B5cmlnaHQgKGMpIDIw
MTgtMjAyMCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMgSW5jLgogICovCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3N0YWdpbmcvd2Z4L2hpZl9hcGlfZ2VuZXJhbC5oIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9o
aWZfYXBpX2dlbmVyYWwuaAppbmRleCA3NzAzMGNlY2YxMzQuLjcxNGUxZGQ4MDhlNiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfYXBpX2dlbmVyYWwuaAorKysgYi9kcml2ZXJz
L3N0YWdpbmcvd2Z4L2hpZl9hcGlfZ2VuZXJhbC5oCkBAIC0xLDYgKzEsNiBAQAogLyogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEFwYWNoZS0yLjAgKi8KIC8qCi0gKiBXRnggaGFyZHdhcmUgaW50
ZXJmYWNlIGRlZmluaXRpb25zCisgKiBXRjIwMCBoYXJkd2FyZSBpbnRlcmZhY2UgZGVmaW5pdGlv
bnMKICAqCiAgKiBDb3B5cmlnaHQgKGMpIDIwMTgtMjAyMCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMg
SW5jLgogICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9hcGlfbWliLmgg
Yi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9hcGlfbWliLmgKaW5kZXggMmE3NDFhMzdhOTBjLi5i
NzZmMTkyMjRiNWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlmX2FwaV9taWIu
aAorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9hcGlfbWliLmgKQEAgLTEsNiArMSw2IEBA
CiAvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogQXBhY2hlLTIuMCAqLwogLyoKLSAqIFdGeCBo
YXJkd2FyZSBpbnRlcmZhY2UgZGVmaW5pdGlvbnMKKyAqIFdGMjAwIGhhcmR3YXJlIGludGVyZmFj
ZSBkZWZpbml0aW9ucwogICoKICAqIENvcHlyaWdodCAoYykgMjAxOC0yMDIwLCBTaWxpY29uIExh
Ym9yYXRvcmllcyBJbmMuCiAgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlm
X3J4LmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9yeC5jCmluZGV4IGE2MGM0YTRiYTkzNS4u
ZmNmZDVjY2M5ZjAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9yeC5jCisr
KyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3J4LmMKQEAgLTEsNyArMSw2IEBACiAvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CiAvKgotICogSW1wbGVtZW50YXRpb24g
b2YgY2hpcC10by1ob3N0IGV2ZW50IChha2EgaW5kaWNhdGlvbnMpIG9mIFdGeHh4IFNwbGl0IE1h
YwotICogKFdTTSkgQVBJLgorICogSGFuZGxpbmcgb2YgdGhlIGNoaXAtdG8taG9zdCBldmVudHMg
KGFrYSBpbmRpY2F0aW9ucykgb2YgdGhlIGhhcmR3YXJlIEFQSS4KICAqCiAgKiBDb3B5cmlnaHQg
KGMpIDIwMTctMjAyMCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4KICAqIENvcHlyaWdodCAo
YykgMjAxMCwgU1QtRXJpY3Nzb24KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlm
X3J4LmggYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9yeC5oCmluZGV4IGYwN2MxMGM4YzZiZC4u
OTY1NDNiODFmYTc3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl9yeC5oCisr
KyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3J4LmgKQEAgLTEsNyArMSw2IEBACiAvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovCiAvKgotICogSW1wbGVtZW50YXRp
b24gb2YgY2hpcC10by1ob3N0IGV2ZW50IChha2EgaW5kaWNhdGlvbnMpIG9mIFdGeHh4IFNwbGl0
IE1hYwotICogKFdTTSkgQVBJLgorICogSGFuZGxpbmcgb2YgdGhlIGNoaXAtdG8taG9zdCBldmVu
dHMgKGFrYSBpbmRpY2F0aW9ucykgb2YgdGhlIGhhcmR3YXJlIEFQSS4KICAqCiAgKiBDb3B5cmln
aHQgKGMpIDIwMTctMjAxOSwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4KICAqIENvcHlyaWdo
dCAoYykgMjAxMCwgU1QtRXJpY3Nzb24KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93Zngv
aGlmX3R4LmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eC5jCmluZGV4IGM1YWIxYzJlMWUw
Ny4uYzFjOTc5NDUzMTdlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eC5j
CisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3R4LmMKQEAgLTEsNyArMSw3IEBACiAvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CiAvKgotICogSW1wbGVtZW50YXRp
b24gb2YgaG9zdC10by1jaGlwIGNvbW1hbmRzIChha2EgcmVxdWVzdC9jb25maXJtYXRpb24pIG9m
IFdGeHh4Ci0gKiBTcGxpdCBNYWMgKFdTTSkgQVBJLgorICogSW1wbGVtZW50YXRpb24gb2YgdGhl
IGhvc3QtdG8tY2hpcCBjb21tYW5kcyAoYWthIHJlcXVlc3QvY29uZmlybWF0aW9uKSBvZiB0aGUK
KyAqIGhhcmR3YXJlIEFQSS4KICAqCiAgKiBDb3B5cmlnaHQgKGMpIDIwMTctMjAyMCwgU2lsaWNv
biBMYWJvcmF0b3JpZXMsIEluYy4KICAqIENvcHlyaWdodCAoYykgMjAxMCwgU1QtRXJpY3Nzb24K
QEAgLTI4LDcgKzI4LDcgQEAgc3RhdGljIHZvaWQgd2Z4X2ZpbGxfaGVhZGVyKHN0cnVjdCBoaWZf
bXNnICpoaWYsIGludCBpZl9pZCwKIAlpZiAoaWZfaWQgPT0gLTEpCiAJCWlmX2lkID0gMjsKIAot
CVdBUk4oY21kID4gMHgzZiwgImludmFsaWQgV1NNIGNvbW1hbmQgJSMuMngiLCBjbWQpOworCVdB
Uk4oY21kID4gMHgzZiwgImludmFsaWQgaGFyZHdhcmUgY29tbWFuZCAlIy4yeCIsIGNtZCk7CiAJ
V0FSTihzaXplID4gMHhGRkYsICJyZXF1ZXN0ZWQgYnVmZmVyIGlzIHRvbyBsYXJnZTogJXp1IGJ5
dGVzIiwgc2l6ZSk7CiAJV0FSTihpZl9pZCA+IDB4MywgImludmFsaWQgaW50ZXJmYWNlIElEICVk
IiwgaWZfaWQpOwogCkBAIC0xMDgsMTIgKzEwOCwxMCBAQCBpbnQgd2Z4X2NtZF9zZW5kKHN0cnVj
dCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1Y3QgaGlmX21zZyAqcmVxdWVzdCwKIAkJbWliX3NlcCA9ICIv
IjsKIAl9CiAJaWYgKHJldCA8IDApCi0JCWRldl9lcnIod2Rldi0+ZGV2LAotCQkJIldTTSByZXF1
ZXN0ICVzJXMlcyAoJSMuMngpIG9uIHZpZiAlZCByZXR1cm5lZCBlcnJvciAlZFxuIiwKKwkJZGV2
X2Vycih3ZGV2LT5kZXYsICJoYXJkd2FyZSByZXF1ZXN0ICVzJXMlcyAoJSMuMngpIG9uIHZpZiAl
ZCByZXR1cm5lZCBlcnJvciAlZFxuIiwKIAkJCWdldF9oaWZfbmFtZShjbWQpLCBtaWJfc2VwLCBt
aWJfbmFtZSwgY21kLCB2aWYsIHJldCk7CiAJaWYgKHJldCA+IDApCi0JCWRldl93YXJuKHdkZXYt
PmRldiwKLQkJCSAiV1NNIHJlcXVlc3QgJXMlcyVzICglIy4yeCkgb24gdmlmICVkIHJldHVybmVk
IHN0YXR1cyAlZFxuIiwKKwkJZGV2X3dhcm4od2Rldi0+ZGV2LCAiaGFyZHdhcmUgcmVxdWVzdCAl
cyVzJXMgKCUjLjJ4KSBvbiB2aWYgJWQgcmV0dXJuZWQgc3RhdHVzICVkXG4iLAogCQkJIGdldF9o
aWZfbmFtZShjbWQpLCBtaWJfc2VwLCBtaWJfbmFtZSwgY21kLCB2aWYsIHJldCk7CiAKIAlyZXR1
cm4gcmV0OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHguaCBiL2RyaXZl
cnMvc3RhZ2luZy93ZngvaGlmX3R4LmgKaW5kZXggNDZlZWQ2Y2ZhMjQ3Li5lNTdlYWJkY2ZhNzcg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3R4LmgKKysrIGIvZHJpdmVycy9z
dGFnaW5nL3dmeC9oaWZfdHguaApAQCAtMSw3ICsxLDcgQEAKIC8qIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8KIC8qCi0gKiBJbXBsZW1lbnRhdGlvbiBvZiBob3N0LXRv
LWNoaXAgY29tbWFuZHMgKGFrYSByZXF1ZXN0L2NvbmZpcm1hdGlvbikgb2YgV0Z4eHgKLSAqIFNw
bGl0IE1hYyAoV1NNKSBBUEkuCisgKiBJbXBsZW1lbnRhdGlvbiBvZiB0aGUgaG9zdC10by1jaGlw
IGNvbW1hbmRzIChha2EgcmVxdWVzdC9jb25maXJtYXRpb24pIG9mIHRoZQorICogaGFyZHdhcmUg
QVBJLgogICoKICAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExhYm9yYXRvcmll
cywgSW5jLgogICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3NvbgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHhfbWliLmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hp
Zl90eF9taWIuYwppbmRleCAxOTAwYjdmYWZkOWUuLmM3NDUyNzE5NDRlOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHhfbWliLmMKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dm
eC9oaWZfdHhfbWliLmMKQEAgLTEsNiArMSw2IEBACiAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vbmx5CiAvKgotICogSW1wbGVtZW50YXRpb24gb2YgaG9zdC10by1jaGlwIE1J
QnMgb2YgV0Z4eHggU3BsaXQgTWFjIChXU00pIEFQSS4KKyAqIEltcGxlbWVudGF0aW9uIG9mIHRo
ZSBob3N0LXRvLWNoaXAgTUlCcyBvZiB0aGUgaGFyZHdhcmUgQVBJLgogICoKICAqIENvcHlyaWdo
dCAoYykgMjAxNy0yMDIwLCBTaWxpY29uIExhYm9yYXRvcmllcywgSW5jLgogICogQ29weXJpZ2h0
IChjKSAyMDEwLCBTVC1Fcmljc3NvbgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9o
aWZfdHhfbWliLmggYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eF9taWIuaAppbmRleCA4MTJi
M2JhMGYwMGUuLjJhM2I4NDg2OGVlNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9o
aWZfdHhfbWliLmgKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHhfbWliLmgKQEAgLTEs
NiArMSw2IEBACiAvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovCiAv
KgotICogSW1wbGVtZW50YXRpb24gb2YgaG9zdC10by1jaGlwIE1JQnMgb2YgV0Z4eHggU3BsaXQg
TWFjIChXU00pIEFQSS4KKyAqIEltcGxlbWVudGF0aW9uIG9mIHRoZSBob3N0LXRvLWNoaXAgTUlC
cyBvZiB0aGUgaGFyZHdhcmUgQVBJLgogICoKICAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIwLCBT
aWxpY29uIExhYm9yYXRvcmllcywgSW5jLgogICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmlj
c3NvbgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmMgYi9kcml2ZXJzL3N0
YWdpbmcvd2Z4L21haW4uYwppbmRleCAyYTc1OWYzNTU0YzkuLjAyYjJlMWM0ZWUxMiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmMKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dm
eC9tYWluLmMKQEAgLTM1LDcgKzM1LDcgQEAKIAogI2RlZmluZSBXRlhfUERTX01BWF9TSVpFIDE1
MDAKIAotTU9EVUxFX0RFU0NSSVBUSU9OKCJTaWxpY29uIExhYnMgODAyLjExIFdpcmVsZXNzIExB
TiBkcml2ZXIgZm9yIFdGeCIpOworTU9EVUxFX0RFU0NSSVBUSU9OKCJTaWxpY29uIExhYnMgODAy
LjExIFdpcmVsZXNzIExBTiBkcml2ZXIgZm9yIFdGMjAwIik7CiBNT0RVTEVfQVVUSE9SKCJKw6ly
w7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Iik7CiBNT0RVTEVfTElD
RU5TRSgiR1BMIik7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93Zngvc3RhLmMgYi9k
cml2ZXJzL3N0YWdpbmcvd2Z4L3N0YS5jCmluZGV4IDFlOGQwNWM0ZjJkYS4uMWUyMWJlZWVkNDM4
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3N0YS5jCisrKyBiL2RyaXZlcnMvc3Rh
Z2luZy93Zngvc3RhLmMKQEAgLTI0LDcgKzI0LDcgQEAgdTMyIHdmeF9yYXRlX21hc2tfdG9faHco
c3RydWN0IHdmeF9kZXYgKndkZXYsIHUzMiByYXRlcykKIHsKIAlpbnQgaTsKIAl1MzIgcmV0ID0g
MDsKLQkvLyBXRnggb25seSBzdXBwb3J0IDJHSHoKKwkvLyBUaGUgZGV2aWNlIG9ubHkgc3VwcG9y
dHMgMkdIegogCXN0cnVjdCBpZWVlODAyMTFfc3VwcG9ydGVkX2JhbmQgKnNiYW5kID0gd2Rldi0+
aHctPndpcGh5LT5iYW5kc1tOTDgwMjExX0JBTkRfMkdIWl07CiAKIAlmb3IgKGkgPSAwOyBpIDwg
c2JhbmQtPm5fYml0cmF0ZXM7IGkrKykgewpAQCAtMjQyLDggKzI0Miw2IEBAIGludCB3Znhfc2V0
X3J0c190aHJlc2hvbGQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHUzMiB2YWx1ZSkKIAlyZXR1
cm4gMDsKIH0KIAotLyogV1NNIGNhbGxiYWNrcyAqLwotCiB2b2lkIHdmeF9ldmVudF9yZXBvcnRf
cnNzaShzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgdTggcmF3X3JjcGlfcnNzaSkKIHsKIAkvKiBSU1NJ
OiBzaWduZWQgUTguMCwgUkNQSTogdW5zaWduZWQgUTcuMQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
dGFnaW5nL3dmeC9zdGEuaCBiL2RyaXZlcnMvc3RhZ2luZy93Zngvc3RhLmgKaW5kZXggZDdiNWRm
NWVhNGU2Li4wNTZlZDUyNjdhYmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy93Zngvc3Rh
LmgKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9zdGEuaApAQCAtNTksNyArNTksNyBAQCB2b2lk
IHdmeF91bmFzc2lnbl92aWZfY2hhbmN0eChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywKIAkJCSAg
ICAgIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCiAJCQkgICAgICBzdHJ1Y3QgaWVlZTgwMjEx
X2NoYW5jdHhfY29uZiAqY29uZik7CiAKLS8vIFdTTSBDYWxsYmFja3MKKy8vIEhhcmR3YXJlIEFQ
SSBDYWxsYmFja3MKIHZvaWQgd2Z4X2Nvb2xpbmdfdGltZW91dF93b3JrKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yayk7CiB2b2lkIHdmeF9zdXNwZW5kX2hvdF9kZXYoc3RydWN0IHdmeF9kZXYgKndk
ZXYsIGVudW0gc3RhX25vdGlmeV9jbWQgY21kKTsKIHZvaWQgd2Z4X3N1c3BlbmRfcmVzdW1lX21j
KHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBlbnVtIHN0YV9ub3RpZnlfY21kIGNtZCk7CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oIGIvZHJpdmVycy9zdGFnaW5nL3dmeC93Zngu
aAppbmRleCA5NzQ5NjAyZjZjZGMuLjU2MzdmOWFmNzljMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9z
dGFnaW5nL3dmeC93ZnguaAorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oCkBAIC0xLDYg
KzEsNiBAQAogLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLwogLyoK
LSAqIENvbW1vbiBwcml2YXRlIGRhdGEgZm9yIFNpbGljb24gTGFicyBXRnggY2hpcHMuCisgKiBD
b21tb24gcHJpdmF0ZSBkYXRhLgogICoKICAqIENvcHlyaWdodCAoYykgMjAxNy0yMDIwLCBTaWxp
Y29uIExhYm9yYXRvcmllcywgSW5jLgogICogQ29weXJpZ2h0IChjKSAyMDEwLCBTVC1Fcmljc3Nv
bgotLSAKMi4zMy4wCgo=
