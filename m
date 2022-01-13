Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFBA48D48B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 10:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiAMI6m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 03:58:42 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:10080
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233214AbiAMI5s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 03:57:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECKn7KfAiffSJ8bpNZludrm+K8pAc/mO3AZi7AZMYDK7DEbFxPVO3ttFs5oZ1/gyUc8yghLMhr+5zEEmrmKY2v/WvnM8c3iknOs2o3apje7HOPY6/O7VU53yUT+zyIlpWdsLwWCX4A9XpwH+ILCYJNlFlplKFydYdEKr9tPKCYJgtxI2OLQRQR4ytZSlZNhgLCucTUXNmgufjPJk3ZwL8FjegusPUzJrefW5f5zbcj8wn3U45CXCQL8/Vu7JkPFEFllBRzceyKbecIjIJDQnfYlWf9m4xEnuNXlVbxz4e5oNfIYX9JxHhP9Aite3AiSsbnCWVfuSfN2cUUX9/hCuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApN0805FqwaTDZhmNkzwiulmD6L+UBqGdb9PdCHBUZg=;
 b=EmYrE+0m6Tpv8QSANAcDSYRCSTzGguGJWgBDA+9NT+VZeRJjMUUVN2JQAMO8dIkVnAvOJZfxS9WEsXyzooxevABw4wQuK8VqIfRkcgnDdo6GJf/59Q3vLqCAhkJtDP2tqC+eAZ3U6pl+Y4fbO8BJ8e7bSIb3sPwvzKykJqlwL+U22yvLO5tuC5sSA6ZQF87/8Jty1oxJshJeIDLlsFIr/CrmyiHAphknxVJ6yIGJPp1EoBWEhMY/+DVzoczD2JTxR2WAFkcgtPFJ143NUtc13/7eFE8shJans4wqIZgbBOqMuBNoIPfKd/UUNx9bMsThmR+5CQvdlIapcQ5weJm7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApN0805FqwaTDZhmNkzwiulmD6L+UBqGdb9PdCHBUZg=;
 b=PVne9K+Tic62BzXrCvH9uUY1AK9OMFMqF/3tt1huS0f8SbMKkcHm/J1mqhCcV1is5ARxbVFP5/cTMv47TLk/E0bC0LgwAeFoVw4JPIuqicVXc/4+qV5qT+Np9ZVLEUeD1uCHfOatV7Wl/bbEwV+Z09NfqCebT6QGQNIiAuC5cDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by CY4PR1101MB2071.namprd11.prod.outlook.com (2603:10b6:910:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 08:56:32 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 08:56:32 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 27/31] staging: wfx: map 'compatible' attribute with board name
Date:   Thu, 13 Jan 2022 09:55:20 +0100
Message-Id: <20220113085524.1110708-28-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113085524.1110708-1-Jerome.Pouiller@silabs.com>
References: <20220113085524.1110708-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SA0PR11CA0117.namprd11.prod.outlook.com
 (2603:10b6:806:d1::32) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cef6f82-2b05-48e1-4117-08d9d6729881
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2071:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2071980FAAF4E455989C808293539@CY4PR1101MB2071.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuVgBbQ+gwipZgrJpyvyRYSPW5GMySC7oyC0d2laiMjbBVopNbIRH3WykSPqy5xIyQ/lM9PiIIitFTkjEddcfe+09+uTjCsCezGyanCeG/hkEpU4p4KjgNCCozV1xx5Lb5RyH48BUkjFUq2Z5wjaZkb42kTz4+uzGJ5r34JUJBB9wEU0uF8elEXXqRSvMRjMXxS8HGB2KaoF/b8Z2ifdnuvmwTeFAMJvAzm7k+l9suozL75D/h8ThEbCG+qKzWcbpxcvs0t2nzgfH6XRsHJGvzqAkIKIEvgwMpgIp3xr9ByEL/RImRmIhPZQyOPYS66q5nWGEAYydEZqTwYn01QwEhzcsIbaRBmn1CLhsWtM0TZB/4kc6RpowIlOgftoHwdvnn1H6L5iCj3e6MO5JnzPRT+uuzqebgOveyojAolfVQxcMsV4lfbK31gdkiybKLlR0eOFwMBtvQIndI7mHY1STEJB1L4WdPbGcLE5Ap8xEsUTKqU6h9s7hKIy8bJtvnr3Upyp/LV/of/vinqvizZu/WAbOLocOe/DDqnEgcou6rZeEF1l/qYz4XtM2jWojH1+xlscp79tqWljz0DO03i6u3aGf/e4s8ijySQ2aXDnmsLlNIOdU0NAPVU9WZ4DoWFlHAeONDTjwY/RWflxwqNJWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(66476007)(52116002)(8676002)(6486002)(4326008)(38100700002)(8936002)(83380400001)(6506007)(107886003)(66556008)(6666004)(36756003)(508600001)(2906002)(5660300002)(6512007)(1076003)(86362001)(186003)(316002)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJCSXA5Snp2c3lrbTh2N0JCRmR5c01ZUGxBaXNEbTVnOVRLUUQ0VGNWTGJw?=
 =?utf-8?B?VWp2ZVUvOGNONU9ib2NjNG5JNWtyLzJHR1Vwb1p5RG1qTXduWWxMbzcwWFU3?=
 =?utf-8?B?U2Y3aXcrNlAzeVlqUlRIMWlZVjdmZlJsd1ZZd3Vxd3BGS29WQzE0OHRjYTll?=
 =?utf-8?B?Sy96WVArRkR4ZG5wa0hLZ214WUp6U29IWlVNLzA1ZHVZVWlmV2NqRHdqZkhX?=
 =?utf-8?B?WU8wSW1DTHBGOWpZS0xYMGpFaDZmQUc3bWZ0bk84VktsYkdrN1B4UGpPS0R2?=
 =?utf-8?B?czNzcWY5YmhqWUhtWUhZdE53SFppdWdGWHd6aG96V0F0WWx3NVQ2bHlQV1hz?=
 =?utf-8?B?elVpKzE1ZW5vcEs2MGQ2cFp4OFdpZ2hMQmllZ3JjQktlbDFTUUlqZlJyUXg3?=
 =?utf-8?B?S2ZXS3k2emZPU1pubDQ4ekdlUnFyMkdEelI0bDJPQ3hTM0cvbDhUVTFYdmZa?=
 =?utf-8?B?R0U5NXF0cENOYXRvdjVOWUhGa0ZUM1VzakdiNUs4Z1BCZldxY0MxcTNSVkZ0?=
 =?utf-8?B?bCtGUGVuNnA4SURJMXd1Y1p1andjcEMxcG0zdWptUC8vbVA4KzhGOWVUT2Fh?=
 =?utf-8?B?Z1k4SGdoOHAyNDNQTWpZOUVZYXh1T214dmUrNGhnclNLR1pFTmptM1JvVHEz?=
 =?utf-8?B?eTZ1Y3pCU0RDWGJ3dWtyejlsYkpPb1o2R1BvMlQzVGg1UlcvMmRoSWJQdFdl?=
 =?utf-8?B?MWZGdkg3bmhyM29yR0YvYitWbEsrNm8xcHBxSitySGlGbWQ0U055R0psUTVu?=
 =?utf-8?B?Z3lzUzFDOXFBS2o0aStUTGNsSDZiWnArOFE4SVUxU3RtMDZ6K2VPbHJmRW1R?=
 =?utf-8?B?dU1rUFVOWENVSGNJdjBVaWJtZmlVRlFnY3VRbGZONDVqRUJuVlZZOTFQTFpj?=
 =?utf-8?B?eU5wbHl0Ui9aV0htcUVGc1ZnZVNKdkN2Tjh0SGNDYWU2QUJXN1hBdTFTS2Yy?=
 =?utf-8?B?N2tINWlnQ0tWV1YyYm8xY3ZEV0svOFcyd2c3Tmk3ZUhDcG1kWmdwVlRXUFJs?=
 =?utf-8?B?Z3Rtd3VmVEpONDJqVEt6U1JsbTRCME1Ec0g1dVplZG90SkF5VDhMRU9BMG0w?=
 =?utf-8?B?VVRtZFBhd0JwTTFCVmlmOTM2WFZjUmExbGZEeVh6RGVITVRQMyt1NkpjK2Mv?=
 =?utf-8?B?NnlUeFdid3hpZWcxUS9KaGRRMFA2N0VGb1RLZ0M2YTJBRHp6Y0hWbXBoMWJN?=
 =?utf-8?B?NkhQeTJvZGZGMzEvVkNiK2FXQ3dTRjAvRDFZS1BGMmxpUk1IeWRBdlBaOXY3?=
 =?utf-8?B?aGtNR1lXUVMxWElIN3NWRHhOZzR5Tlo0Sno3KzVSK3RMeTVkY09BV0pHditu?=
 =?utf-8?B?a3Q5OFVRZENmM3g3dmZkVnZNL2JZSXZKUDV3cW4yeHFZZHFJTlE2OFF3WWNx?=
 =?utf-8?B?RXhyWGRKRGRjdVI5bEtxQTFYVEFIeGk3OGFCZk4xZ1MrVThIVlFFWm5LS25T?=
 =?utf-8?B?MitFeEFmdDRHdXNwREpYdlJRQU5ZMkx6WEYyUGZpNlhNc3dDdlIrSmZyQkJ1?=
 =?utf-8?B?RVhGQ1poc2dGRFpyNVR6RXN5YjlHKzViTFN0MEhORkgyYkp0UlNkTm9wV3VP?=
 =?utf-8?B?bndnbEJwU2t1a0FNQTVUVDJEZ2FkeG5Mekw0RHdvR1pza2JGTzc4bnYrTjFJ?=
 =?utf-8?B?K05WS1E0ckVGYzc3UnZOc2FaV0o5WDNGVVVaelNaYitpZnJZMTBDTWxMQXJI?=
 =?utf-8?B?b2pEa3VjVHV1K2ZZMXc1QTBRdTlic3lqVUczTVRyTXpXamxFZlZJZHF4ZDFa?=
 =?utf-8?B?UE9jZDhsaHJwTkpXVW15b3JsRDFuN2lYZ0NiKzNzRXcyb2RvYWZRVnpIN1ZV?=
 =?utf-8?B?WGZORTJKbGRFamxhbkdSYlpBcnltc044b3FZeW8yYnZUTjlCVnljTnFGd3Ns?=
 =?utf-8?B?N1lkUE9jUDNpbm9RUXdSYW0vdjJTTnlzU08wa2RnY21FcjluU2dabWR1UHlU?=
 =?utf-8?B?aUVudWJWaE1xWDZFQXp6dzRiVWJTMHBzKzQwam5MY2xTQ3l0UjIvSEt2MWlJ?=
 =?utf-8?B?MjJrN255NFNwa3E0TFFhMHVDSFJ6Z24va0dZWE91QXZpY0pCam1MWGZqMjBn?=
 =?utf-8?B?ZW4zOXEydXpaTUJKUEVyeEhkZ0ZuTllSNVlGZ2VjdHVmWmREWUl5d2UxUTdt?=
 =?utf-8?B?MEhIYlZtNHRJLzJiZW16cTdtN0M2UHl3S3MwNCt1TU5tQm95U1h0RmxBdTRQ?=
 =?utf-8?B?TW4wSGJLb0FJNzgvc2Zob3NaU0Z2Y091Nks2cnA2SDZzMWpZTkJaMmhyVy8y?=
 =?utf-8?Q?vkMaBfTVi7RQlxpp9zNcfTuM4gOQZl+2sRAi9xlt7E=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cef6f82-2b05-48e1-4117-08d9d6729881
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 08:56:32.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKzeNH02Y1ya2RE2gOZnPNdTrm28qyHvHgspz1AwPW+8U+pHtbjChy1ukXltomz3gMzB6UTMx8sR8RDKo4jVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2071
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKIldG
MjAwIiBvbmx5IGRlc2lnbmF0ZXMgdGhlIGNoaXAuIFRvIG1ha2UgYSBXaUZpIGJvYXJkLCB0aGUg
Y2hpcCBtdXN0IGJlCmFzc29jaWF0ZWQgd2l0aCBhbiBhbnRlbm5hLiBUaGUgYW50ZW5uYSBjb25m
aWd1cmF0aW9uIGlzIGxvY2F0ZWQgaW4Kc2VwYXJhdGUgZmlsZXMgKGFrYSBQRFMgZmlsZXMgaW4g
U2lsYWJzIHdvcmRpbmcpLiBDdXJyZW50bHksIHVzZXIgaGFzIHRvCndyaXRlIGluIGhpcyBEVCBz
b21ldGhpbmcgbGlrZToKCiAgICBjb21wYXRpYmxlID0gInNpbGFicyx3ZjIwMCI7CiAgICBjb25m
aWcgPSAiYnJkNDAwMWEucGRzIjsKCkl0IGlzIGZhciBiZXR0ZXIgdG8gZW1iZWQgYSBsaXN0IG9m
IGtub3duIGJvYXJkcyAoY2hpcCArIGFudGVubmEpIGluIHRoZQpkcml2ZXIuIFNvIHRoZSB1c2Vy
IGp1c3QgaGF2ZSB0byBkZWNsYXJlOgoKICAgIGNvbXBhdGlibGUgPSAic2lsYWJzLGJyZDQwMDFh
IjsKClRoaXMgcGF0Y2ggYWRkIHRoZSBjb25maWd1cmF0aW9ucyBmb3IgdGhlIGV2YWx1YXRpb24g
Ym9hcmRzIHNvbGQgYnkKU2lsYWJzLiBUbyBwcm92aWRlIGEgZnVsbCBwbHVnLWFuZC1wbGF5IGV4
cGVyaWVuY2UsIHRoZSBhc3NvY2lhdGVkIFBEUwpmaWxlc1sxXSB3aWxsIGJlIGF2YWlsYWJsZSBp
biBsaW51eC1maXJtd2FyZS4KClRoaXMgcGF0Y2ggZG9lcyBub3QgYnJlYWsgY29tcGF0aWJpbGl0
eSB3aXRoIGV4aXN0aW5nIHNldHVwcy4KClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVy
IDxqZXJvbWUucG91aWxsZXJAc2lsYWJzLmNvbT4KLS0tCiAuLi4vYmluZGluZ3MvbmV0L3dpcmVs
ZXNzL3NpbGFicyx3ZngueWFtbCAgICAgfCAxMSArKy0tCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2J1
c19zZGlvLmMgICAgICAgICAgICAgICAgfCAzNSArKysrKysrKysrKy0tCiBkcml2ZXJzL3N0YWdp
bmcvd2Z4L2J1c19zcGkuYyAgICAgICAgICAgICAgICAgfCA1MiArKysrKysrKysrKysrKysrLS0t
CiBkcml2ZXJzL3N0YWdpbmcvd2Z4L21haW4uaCAgICAgICAgICAgICAgICAgICAgfCAgMSArCiA0
IGZpbGVzIGNoYW5nZWQsIDgzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC93aXJlbGVzcy9zaWxhYnMsd2Z4LnlhbWwgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3Mvc2lsYWJzLHdmeC55
YW1sCmluZGV4IDUxMGVkZDEyZWQxOS4uNDRhZWJhMGY3Mjc2IDEwMDY0NAotLS0gYS9kcml2ZXJz
L3N0YWdpbmcvd2Z4L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxl
c3Mvc2lsYWJzLHdmeC55YW1sCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9zaWxhYnMsd2Z4LnlhbWwKQEAgLTM5
LDcgKzM5LDEyIEBAIGRlc2NyaXB0aW9uOgogCiBwcm9wZXJ0aWVzOgogICBjb21wYXRpYmxlOgot
ICAgIGNvbnN0OiBzaWxhYnMsd2YyMDAKKyAgICBpdGVtczoKKyAgICAgIC0gZW51bToKKyAgICAg
ICAgICAtIHNpbGFicyxicmQ0MDAxYSAjIFdHTTE2MFAgRXZhbHVhdGlvbiBCb2FyZAorICAgICAg
ICAgIC0gc2lsYWJzLGJyZDgwMjJhICMgV0YyMDAgRXZhbHVhdGlvbiBCb2FyZAorICAgICAgICAg
IC0gc2lsYWJzLGJyZDgwMjNhICMgV0ZNMjAwIEV2YWx1YXRpb24gQm9hcmQKKyAgICAgIC0gY29u
c3Q6IHNpbGFicyx3ZjIwMCAjIENoaXAgYWxvbmUgd2l0aG91dCBhbnRlbm5hCiAgIHJlZzoKICAg
ICBkZXNjcmlwdGlvbjoKICAgICAgIFdoZW4gdXNlZCBvbiBTRElPIGJ1cywgPHJlZz4gbXVzdCBi
ZSBzZXQgdG8gMS4gV2hlbiB1c2VkIG9uIFNQSSBidXMsIGl0IGlzCkBAIC04Nyw3ICs5Miw3IEBA
IGV4YW1wbGVzOgogICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsKIAogICAgICAgICB3ZnhAMCB7
Ci0gICAgICAgICAgICBjb21wYXRpYmxlID0gInNpbGFicyx3ZjIwMCI7CisgICAgICAgICAgICBj
b21wYXRpYmxlID0gInNpbGFicyxicmQ4MDIyYSIsICJzaWxhYnMsd2YyMDAiOwogICAgICAgICAg
ICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwm
d2Z4X2lycSAmd2Z4X2dwaW9zPjsKICAgICAgICAgICAgIHJlZyA9IDwwPjsKQEAgLTExNSw3ICsx
MjAsNyBAQCBleGFtcGxlczoKICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47CiAKICAgICAgICAg
bW1jQDEgewotICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaWxhYnMsd2YyMDAiOworICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJzaWxhYnMsYnJkODAyMmEiLCAic2lsYWJzLHdmMjAwIjsKICAg
ICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CiAgICAgICAgICAgICBwaW5jdHJs
LTAgPSA8JndmeF93YWtldXA+OwogICAgICAgICAgICAgcmVnID0gPDE+OwpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc2Rpby5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNf
c2Rpby5jCmluZGV4IDVjNDVjY2Q4NWE3ZC4uMzYxNTg1NzYzZjMwIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3N0YWdpbmcvd2Z4L2J1c19zZGlvLmMKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNf
c2Rpby5jCkBAIC0xMCw2ICsxMCw3IEBACiAjaW5jbHVkZSA8bGludXgvbW1jL3NkaW9fZnVuYy5o
PgogI2luY2x1ZGUgPGxpbnV4L21tYy9jYXJkLmg+CiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0
Lmg+CisjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+CiAjaW5jbHVkZSA8bGludXgvb2ZfaXJx
Lmg+CiAjaW5jbHVkZSA8bGludXgvaXJxLmg+CiAjaW5jbHVkZSA8bGludXgvYWxpZ24uaD4KQEAg
LTIwLDcgKzIxLDI4IEBACiAjaW5jbHVkZSAibWFpbi5oIgogI2luY2x1ZGUgImJoLmgiCiAKLXN0
YXRpYyBjb25zdCBzdHJ1Y3Qgd2Z4X3BsYXRmb3JtX2RhdGEgd2Z4X3NkaW9fcGRhdGEgPSB7Citz
dGF0aWMgY29uc3Qgc3RydWN0IHdmeF9wbGF0Zm9ybV9kYXRhIHBkYXRhX3dmMjAwID0geworCS5m
aWxlX2Z3ID0gIndmbV93ZjIwMCIsCisJLmZpbGVfcGRzID0gIndmMjAwLnBkcyIsCit9OworCitz
dGF0aWMgY29uc3Qgc3RydWN0IHdmeF9wbGF0Zm9ybV9kYXRhIHBkYXRhX2JyZDQwMDFhID0gewor
CS5maWxlX2Z3ID0gIndmbV93ZjIwMCIsCisJLmZpbGVfcGRzID0gImJyZDQwMDFhLnBkcyIsCit9
OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHdmeF9wbGF0Zm9ybV9kYXRhIHBkYXRhX2JyZDgwMjJh
ID0geworCS5maWxlX2Z3ID0gIndmbV93ZjIwMCIsCisJLmZpbGVfcGRzID0gImJyZDgwMjJhLnBk
cyIsCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHdmeF9wbGF0Zm9ybV9kYXRhIHBkYXRhX2Jy
ZDgwMjNhID0geworCS5maWxlX2Z3ID0gIndmbV93ZjIwMCIsCisJLmZpbGVfcGRzID0gImJyZDgw
MjNhLnBkcyIsCit9OworCisvKiBMZWdhY3kgRFQgZG9uJ3QgdXNlIGl0ICovCitzdGF0aWMgY29u
c3Qgc3RydWN0IHdmeF9wbGF0Zm9ybV9kYXRhIHBkYXRhX3dmeF9zZGlvID0gewogCS5maWxlX2Z3
ID0gIndmbV93ZjIwMCIsCiAJLmZpbGVfcGRzID0gIndmMjAwLnBkcyIsCiB9OwpAQCAtMTY3LDE0
ICsxODksMTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB3ZnhfaHdidXNfb3BzIHdmeF9zZGlvX2h3
YnVzX29wcyA9IHsKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHdmeF9z
ZGlvX29mX21hdGNoW10gPSB7Ci0JeyAuY29tcGF0aWJsZSA9ICJzaWxhYnMsd2Z4LXNkaW8iIH0s
Ci0JeyAuY29tcGF0aWJsZSA9ICJzaWxhYnMsd2YyMDAiIH0sCisJeyAuY29tcGF0aWJsZSA9ICJz
aWxhYnMsd2YyMDAiLCAgICAuZGF0YSA9ICZwZGF0YV93ZjIwMCB9LAorCXsgLmNvbXBhdGlibGUg
PSAic2lsYWJzLGJyZDQwMDFhIiwgLmRhdGEgPSAmcGRhdGFfYnJkNDAwMWEgfSwKKwl7IC5jb21w
YXRpYmxlID0gInNpbGFicyxicmQ4MDIyYSIsIC5kYXRhID0gJnBkYXRhX2JyZDgwMjJhIH0sCisJ
eyAuY29tcGF0aWJsZSA9ICJzaWxhYnMsYnJkODAyM2EiLCAuZGF0YSA9ICZwZGF0YV9icmQ4MDIz
YSB9LAorCXsgLmNvbXBhdGlibGUgPSAic2lsYWJzLHdmeC1zZGlvIiwgLmRhdGEgPSAmcGRhdGFf
d2Z4X3NkaW8gfSwKIAl7IH0sCiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgd2Z4X3NkaW9f
b2ZfbWF0Y2gpOwogCiBzdGF0aWMgaW50IHdmeF9zZGlvX3Byb2JlKHN0cnVjdCBzZGlvX2Z1bmMg
KmZ1bmMsIGNvbnN0IHN0cnVjdCBzZGlvX2RldmljZV9pZCAqaWQpCiB7CisJY29uc3Qgc3RydWN0
IHdmeF9wbGF0Zm9ybV9kYXRhICpwZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmZnVu
Yy0+ZGV2KTsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZnVuYy0+ZGV2Lm9mX25vZGU7CiAJ
c3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1czsKIAlpbnQgcmV0OwpAQCAtMjE2LDggKzI0Miw3IEBA
IHN0YXRpYyBpbnQgd2Z4X3NkaW9fcHJvYmUoc3RydWN0IHNkaW9fZnVuYyAqZnVuYywgY29uc3Qg
c3RydWN0IHNkaW9fZGV2aWNlX2lkICppCiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAotCWJ1
cy0+Y29yZSA9IHdmeF9pbml0X2NvbW1vbigmZnVuYy0+ZGV2LCAmd2Z4X3NkaW9fcGRhdGEsCi0J
CQkJICAgICZ3Znhfc2Rpb19od2J1c19vcHMsIGJ1cyk7CisJYnVzLT5jb3JlID0gd2Z4X2luaXRf
Y29tbW9uKCZmdW5jLT5kZXYsIHBkYXRhLCAmd2Z4X3NkaW9faHdidXNfb3BzLCBidXMpOwogCWlm
ICghYnVzLT5jb3JlKSB7CiAJCXJldCA9IC1FSU87CiAJCWdvdG8gc2Rpb19yZWxlYXNlOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc3BpLmMgYi9kcml2ZXJzL3N0YWdpbmcv
d2Z4L2J1c19zcGkuYwppbmRleCA0MTdiYjc0Yzg4YjkuLjlhYTUyZDc2Y2RkYSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc3BpLmMKKysrIGIvZHJpdmVycy9zdGFnaW5nL3dm
eC9idXNfc3BpLmMKQEAgLTIzLDEyICsyMywzNiBAQAogI2RlZmluZSBTRVRfV1JJVEUgMHg3RkZG
ICAgICAgICAvKiB1c2FnZTogYW5kIG9wZXJhdGlvbiAqLwogI2RlZmluZSBTRVRfUkVBRCAweDgw
MDAgICAgICAgICAvKiB1c2FnZTogb3Igb3BlcmF0aW9uICovCiAKLSNkZWZpbmUgV0ZYX1JFU0VU
X0lOVkVSVEVEIDEKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgd2Z4X3BsYXRmb3JtX2RhdGEgcGRhdGFf
d2YyMDAgPSB7CisJLmZpbGVfZncgPSAid2ZtX3dmMjAwIiwKKwkuZmlsZV9wZHMgPSAid2YyMDAu
cGRzIiwKKwkudXNlX3Jpc2luZ19jbGsgPSB0cnVlLAorfTsKKworc3RhdGljIGNvbnN0IHN0cnVj
dCB3ZnhfcGxhdGZvcm1fZGF0YSBwZGF0YV9icmQ0MDAxYSA9IHsKKwkuZmlsZV9mdyA9ICJ3Zm1f
d2YyMDAiLAorCS5maWxlX3BkcyA9ICJicmQ0MDAxYS5wZHMiLAorCS51c2VfcmlzaW5nX2NsayA9
IHRydWUsCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHdmeF9wbGF0Zm9ybV9kYXRhIHBkYXRh
X2JyZDgwMjJhID0geworCS5maWxlX2Z3ID0gIndmbV93ZjIwMCIsCisJLmZpbGVfcGRzID0gImJy
ZDgwMjJhLnBkcyIsCisJLnVzZV9yaXNpbmdfY2xrID0gdHJ1ZSwKK307CisKK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgd2Z4X3BsYXRmb3JtX2RhdGEgcGRhdGFfYnJkODAyM2EgPSB7CisJLmZpbGVfZncg
PSAid2ZtX3dmMjAwIiwKKwkuZmlsZV9wZHMgPSAiYnJkODAyM2EucGRzIiwKKwkudXNlX3Jpc2lu
Z19jbGsgPSB0cnVlLAorfTsKIAotc3RhdGljIGNvbnN0IHN0cnVjdCB3ZnhfcGxhdGZvcm1fZGF0
YSB3Znhfc3BpX3BkYXRhID0geworLyogTGVnYWN5IERUIGRvbid0IHVzZSBpdCAqLworc3RhdGlj
IGNvbnN0IHN0cnVjdCB3ZnhfcGxhdGZvcm1fZGF0YSBwZGF0YV93Znhfc3BpID0gewogCS5maWxl
X2Z3ID0gIndmbV93ZjIwMCIsCiAJLmZpbGVfcGRzID0gIndmMjAwLnBkcyIsCiAJLnVzZV9yaXNp
bmdfY2xrID0gdHJ1ZSwKKwkucmVzZXRfaW52ZXJ0ZWQgPSB0cnVlLAogfTsKIAogc3RydWN0IHdm
eF9zcGlfcHJpdiB7CkBAIC0xNzUsNiArMTk5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB3Znhf
aHdidXNfb3BzIHdmeF9zcGlfaHdidXNfb3BzID0gewogCiBzdGF0aWMgaW50IHdmeF9zcGlfcHJv
YmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCiB7CisJc3RydWN0IHdmeF9wbGF0Zm9ybV9kYXRh
ICpwZGF0YTsKIAlzdHJ1Y3Qgd2Z4X3NwaV9wcml2ICpidXM7CiAJaW50IHJldDsKIApAQCAtMTgz
LDYgKzIwOCwxMiBAQCBzdGF0aWMgaW50IHdmeF9zcGlfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2Ug
KmZ1bmMpCiAJcmV0ID0gc3BpX3NldHVwKGZ1bmMpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7
CisJcGRhdGEgPSAoc3RydWN0IHdmeF9wbGF0Zm9ybV9kYXRhICopc3BpX2dldF9kZXZpY2VfaWQo
ZnVuYyktPmRyaXZlcl9kYXRhOworCWlmICghcGRhdGEpIHsKKwkJZGV2X2VycigmZnVuYy0+ZGV2
LCAidW5hYmxlIHRvIHJldHJpZXZlIGRyaXZlciBkYXRhIChwbGVhc2UgcmVwb3J0KVxuIik7CisJ
CXJldHVybiAtRU5PREVWOworCX0KKwogCS8qIFRyYWNlIGJlbG93IGlzIGFsc28gZGlzcGxheWVk
IGJ5IHNwaV9zZXR1cCgpIGlmIGNvbXBpbGVkIHdpdGggREVCVUcgKi8KIAlkZXZfZGJnKCZmdW5j
LT5kZXYsICJTUEkgcGFyYW1zOiBDUz0lZCwgbW9kZT0lZCBiaXRzL3dvcmQ9JWQgc3BlZWQ9JWRc
biIsCiAJCWZ1bmMtPmNoaXBfc2VsZWN0LCBmdW5jLT5tb2RlLCBmdW5jLT5iaXRzX3Blcl93b3Jk
LCBmdW5jLT5tYXhfc3BlZWRfaHopOwpAQCAtMjA2LDcgKzIzNyw3IEBAIHN0YXRpYyBpbnQgd2Z4
X3NwaV9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqZnVuYykKIAkJZGV2X3dhcm4oJmZ1bmMtPmRl
diwgImdwaW8gcmVzZXQgaXMgbm90IGRlZmluZWQsIHRyeWluZyB0byBsb2FkIGZpcm13YXJlIGFu
eXdheVxuIik7CiAJfSBlbHNlIHsKIAkJZ3Bpb2Rfc2V0X2NvbnN1bWVyX25hbWUoYnVzLT5ncGlv
X3Jlc2V0LCAid2Z4IHJlc2V0Iik7Ci0JCWlmIChzcGlfZ2V0X2RldmljZV9pZChmdW5jKS0+ZHJp
dmVyX2RhdGEgJiBXRlhfUkVTRVRfSU5WRVJURUQpCisJCWlmIChwZGF0YS0+cmVzZXRfaW52ZXJ0
ZWQpCiAJCQlncGlvZF90b2dnbGVfYWN0aXZlX2xvdyhidXMtPmdwaW9fcmVzZXQpOwogCQlncGlv
ZF9zZXRfdmFsdWVfY2Fuc2xlZXAoYnVzLT5ncGlvX3Jlc2V0LCAxKTsKIAkJdXNsZWVwX3Jhbmdl
KDEwMCwgMTUwKTsKQEAgLTIxNCw4ICsyNDUsNyBAQCBzdGF0aWMgaW50IHdmeF9zcGlfcHJvYmUo
c3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCiAJCXVzbGVlcF9yYW5nZSgyMDAwLCAyNTAwKTsKIAl9
CiAKLQlidXMtPmNvcmUgPSB3ZnhfaW5pdF9jb21tb24oJmZ1bmMtPmRldiwgJndmeF9zcGlfcGRh
dGEsCi0JCQkJICAgICZ3Znhfc3BpX2h3YnVzX29wcywgYnVzKTsKKwlidXMtPmNvcmUgPSB3Znhf
aW5pdF9jb21tb24oJmZ1bmMtPmRldiwgcGRhdGEsICZ3Znhfc3BpX2h3YnVzX29wcywgYnVzKTsK
IAlpZiAoIWJ1cy0+Y29yZSkKIAkJcmV0dXJuIC1FSU87CiAKQEAgLTIzNSwxNiArMjY1LDIyIEBA
IHN0YXRpYyBpbnQgd2Z4X3NwaV9yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCiAgKiBz
dHJpcHBlZC4KICAqLwogc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIHdmeF9zcGlf
aWRbXSA9IHsKLQl7ICJ3Zngtc3BpIiwgV0ZYX1JFU0VUX0lOVkVSVEVEIH0sCi0JeyAid2YyMDAi
LCAwIH0sCisJeyAid2YyMDAiLCAgICAoa2VybmVsX3Vsb25nX3QpJnBkYXRhX3dmMjAwIH0sCisJ
eyAiYnJkNDAwMWEiLCAoa2VybmVsX3Vsb25nX3QpJnBkYXRhX2JyZDQwMDFhIH0sCisJeyAiYnJk
ODAyMmEiLCAoa2VybmVsX3Vsb25nX3QpJnBkYXRhX2JyZDgwMjJhIH0sCisJeyAiYnJkODAyM2Ei
LCAoa2VybmVsX3Vsb25nX3QpJnBkYXRhX2JyZDgwMjNhIH0sCisJeyAid2Z4LXNwaSIsICAoa2Vy
bmVsX3Vsb25nX3QpJnBkYXRhX3dmeF9zcGkgfSwKIAl7IH0sCiB9OwogTU9EVUxFX0RFVklDRV9U
QUJMRShzcGksIHdmeF9zcGlfaWQpOwogCiAjaWZkZWYgQ09ORklHX09GCiBzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCB3Znhfc3BpX29mX21hdGNoW10gPSB7Ci0JeyAuY29tcGF0aWJs
ZSA9ICJzaWxhYnMsd2Z4LXNwaSIsIC5kYXRhID0gKHZvaWQgKilXRlhfUkVTRVRfSU5WRVJURUQg
fSwKIAl7IC5jb21wYXRpYmxlID0gInNpbGFicyx3ZjIwMCIgfSwKKwl7IC5jb21wYXRpYmxlID0g
InNpbGFicyxicmQ0MDAxYSIgfSwKKwl7IC5jb21wYXRpYmxlID0gInNpbGFicyxicmQ4MDIyYSIg
fSwKKwl7IC5jb21wYXRpYmxlID0gInNpbGFicyxicmQ4MDIzYSIgfSwKKwl7IC5jb21wYXRpYmxl
ID0gInNpbGFicyx3Zngtc3BpIiB9LAogCXsgfSwKIH07CiBNT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCB3Znhfc3BpX29mX21hdGNoKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFp
bi5oIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmgKaW5kZXggNjhjNjY1MzA3MTUzLi5mY2Qy
NmIyNDUxOWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy93ZngvbWFpbi5oCisrKyBiL2Ry
aXZlcnMvc3RhZ2luZy93ZngvbWFpbi5oCkBAIC0yMyw2ICsyMyw3IEBAIHN0cnVjdCB3ZnhfcGxh
dGZvcm1fZGF0YSB7CiAJY29uc3QgY2hhciAqZmlsZV9mdzsKIAljb25zdCBjaGFyICpmaWxlX3Bk
czsKIAlzdHJ1Y3QgZ3Bpb19kZXNjICpncGlvX3dha2V1cDsKKwlib29sIHJlc2V0X2ludmVydGVk
OwogCS8qIGlmIHRydWUgSElGIERfb3V0IGlzIHNhbXBsZWQgb24gdGhlIHJpc2luZyBlZGdlIG9m
IHRoZSBjbG9jayAoaW50ZW5kZWQgdG8gYmUgdXNlZCBpbgogCSAqIDUwTWh6IFNESU8pCiAJICov
Ci0tIAoyLjM0LjEKCg==
