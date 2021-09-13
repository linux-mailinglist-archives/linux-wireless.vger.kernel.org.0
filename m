Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C53F408C08
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbhIMNIW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:08:22 -0400
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:58976
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236206AbhIMNGW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:06:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYWstLBAS/ir6pw4+e3XufyRb0TbGi4GH+HqS+ffyqsWbmC/1csiGVtVZcndGBsrxXgDmsHIrrfGXW7d3SfSjrbZs8c6gdRdPIPs0Qg5i3Kza7iaf9dAlUZiq5XRJU2Z95RYjofirdhGo+6tSRbVlxU+g79htU3pnbhE70E5we45tXEvtHMok4RnusFi4FOb/Rl7CAmBOARlSEpv44K3cL+pkLh+P0ziXIMcxkVgwgV7dz3t8JZ+RO7uMJLep6lUlJeuYsQQjC0do84rHzH3947lWCX1tzsJxbRG3HRCfvQ7msJZZE0yOBXSkEEaUS8eRr0UFTzI1+JtbpJudnpemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JAmRoT+yqJyVJqFuWU287ozQKOUwlLHdKHeabfJ8CtE=;
 b=UZakWSIcSefVPvMipGXzXnlfk35noUDZth5fMmI/sjRAIz0XFa3xL8NmJA57J9OVBkV6/7qrRPMrhqc6RZ2KtfeIfrIkcLaMUU4mEJrsHDIceaozj7/fqmw9icUXQ0o0Inq79c2WyZo/VF638EFe8DqFqqZPmZ5KwuMBGk2fDpQ27R++Cn2ECJj1t/6dftD9ltCM0lKOkgJTxXHxI5CyNmOcvHpwbS8Fzyb7KMdQ6rBCi+boj6Iwqinq07c7TWJCG2mILoJn7xAGD4jiTYzJ7UZ4QjrARcMjwIKjRmN3SMXezf3KC1YTjv1fLgdr3/T2NWIQMPZwT7lEIjE08DvoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAmRoT+yqJyVJqFuWU287ozQKOUwlLHdKHeabfJ8CtE=;
 b=k2wgvEYOL6LmF8Ow+Q0YK0rKRVNLOcnRVd+Egq1jAYAxV+nWAgxu9nGJpT6r5zatzLXZNYif1Ly0vFaRzRnIuOOdpvP7FCfeWuzJ1kFGqt1j+29MnbG6t6hzKV+Nxff+knixMjJAP4eLbrF9ur39tBdoUwZ7qtcqd4FdIu9kcuA=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB3502.namprd11.prod.outlook.com (2603:10b6:805:da::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 13:03:17 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::7050:a0a:415:2ccd%7]) with mapi id 15.20.4500.017; Mon, 13 Sep 2021
 13:03:17 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 32/32] staging: wfx: ensure IRQ is ready before enabling it
Date:   Mon, 13 Sep 2021 15:02:03 +0200
Message-Id: <20210913130203.1903622-33-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913130203.1903622-1-Jerome.Pouiller@silabs.com>
References: <20210913130203.1903622-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR2P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::33)
 To SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PR2P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:03:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a887f48-40ce-4089-887a-08d976b6da94
X-MS-TrafficTypeDiagnostic: SN6PR11MB3502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB35024699A34FDA7B622FEDE993D99@SN6PR11MB3502.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPI5Q5kS25OjCBLT6aPf7jy0QZEyAQb0aSeK+bJCu4OSrRRo1gto3ngKgUHg1F+2jVVBAWaJSQAcUc8PIbrx11lK8MBiC7mKFxau53cABCzkHpgaZ8gHIgXmBQ4XC1VgB8t2vH88jwMnO0+TfLUx1AioFClUatILn0vDQi1ieubl9kZAKlEIAp4T/GRKzkcAHmzMy2ECuUBjS1qW5n4gz/VJ3tOXn9dnRIBZw0GYH3wt5IUhmr/WSYJvcFIN+UeJXxqL+oyV9/dsA0oFePZ6T87XNGvDr18pGeaxbOhT6tjLgWR1sExqLTlm/zRZQwa93JTVjzMqm9stmtLEQ7LxjcRgtmJAxUHc1/XFVuzlQkwq4cZrwND95zXoIACHH5WbBn93e3gaFCLGnJ463Ccl8FKlc2QI8cPMxA5fgutL93Mm5fOTpkBM7SNmncDI1dlYJgt90jXDSnTwaIBa26uWt6wdKSTE42ALrgGOB9eNdmmjQb51WIkbTXlVJVRrbnZ0k0jZKGm0sJPJC1Of9H7a4uy0iv8kIWIFF+GusObdGH0fwEd1BLMhmFyveXcQJelVTb0XIqSHKjC6n+wm6QSp2jAuXHNdSOwk4vhqzpNqkCAKLQ2nJJZPLLCF1wRryJmwBzF7XOUP0JMYKZYoQZ/qDzvdE09a0A7TZqnMxAKErbKhsiROuWxYpUpBqIyAv6aRFGclHswm2FVCc3HYKi0hGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(376002)(346002)(366004)(6666004)(316002)(66476007)(8676002)(45080400002)(186003)(7696005)(52116002)(66946007)(26005)(4326008)(66556008)(2906002)(54906003)(107886003)(6486002)(2616005)(478600001)(1076003)(36756003)(5660300002)(66574015)(956004)(8936002)(86362001)(38100700002)(38350700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2drVWlVbnVWa1Q5c1p3N0lScEhtYURPQ2tVRVVLVVFrajZLYWo4QUF5VU45?=
 =?utf-8?B?OEFlMVdXQ2hIYTlTTUVOQ0VSZjBYdTBUQXBGZFVQbFlmL3hzYkhmam9rejA1?=
 =?utf-8?B?WlBKMXdrZGJaS0Zxa2M1a0hWamdCdmVQOEFENUErMmhtbVkwM2wyMXBneGFl?=
 =?utf-8?B?dUwzQ3EzNW1DVnZRL0VPN1JRWWxuZHlScGQ1M1Vpcm5rV1YzNGNlb3dKMk9R?=
 =?utf-8?B?bFQyUFpkMFlzRFg4b2FaaWlYd2lBNC9QRXB5U2dzRTBDcjJiNXB0WHI3MTZa?=
 =?utf-8?B?YzVSd0F5RXV0dUgzMjk1MTlIeENFd1pRRGo4V21OTVNrd2xpUG1MUjJReURp?=
 =?utf-8?B?ckFYYnlXa2VNMnJ1OEhaZDF6S21tYTR3UUoyZkdDOWx6ZXgzeXVpamFnT2Vq?=
 =?utf-8?B?dGplNjNwcUJjTm1heGI5QVBsYkcveUJBY0M2cHBpeC9MQk9UMFllZTRtKzc3?=
 =?utf-8?B?YnRHMVBLOEg0Y0JKcmw4V1hIWnp6dGtvSm9rbmdqS3Q5T1VYSFd2SUg5Wnlj?=
 =?utf-8?B?WUNlQWlUM2ZTbFVnbjhCR0hPZjNVQ0tZblAyY2tEdTBKd216R0NLZThEMERv?=
 =?utf-8?B?NnQrclN2RmN6cVVRVjFRT204cUxHY2tQcHdXYzRIMHRwYnVBaHlpVWE0dXQ1?=
 =?utf-8?B?c29XR2hFRFdtZ2kwTjcvVjR3Wk5Hc3RLVmoycmNBV3NhdERPTEVGcFJWcWwv?=
 =?utf-8?B?aHZFUGo0eUh6ejJQTlBRS2dtUDE2N0l5Q1gwNW9JdUIycFM1RGR3cTQxOXUz?=
 =?utf-8?B?eDBQVEl1REZFZXFCOGpBWjhKVXk5cGMvZmcvc2w1bytpdHEzZkxtL2NYVkda?=
 =?utf-8?B?UlQvU2Z1LzNUMGtSMU9QSEZTVjVIVml2TVB5ZnF4NUFHY3lENC9LZ05qVDkx?=
 =?utf-8?B?d0lZRXFQYVhHUTVBTHo3clBxdW1KV0JnNHZHWjJJUWwzWkt0cEFzV2hUQlRj?=
 =?utf-8?B?M0pSQWNDZ0FESkt3YkdaUFFXM295V0xBL1crYjhEeVVjdXJUaFRpMDZDcm9n?=
 =?utf-8?B?RHpiaDdPZkhLSytEbktxcjFyZ2pPaW10dW9ZYkhtZkFiUTVPTWtvdiszQ2hR?=
 =?utf-8?B?cE9FN0dYVk1BdVVSMnlYZkIxamcyY1RHazJWQmhGZERTNThHd3JGTU9HVGht?=
 =?utf-8?B?NWN4VjBzYkRUekpmSWVFeXlXTXB3RFFxc0d2YWkrcVZkVXVqVjFVQjR1Ujh4?=
 =?utf-8?B?UFhQRmdTMEZpREEyMFAvK0VBTGtaSmY1eEVtQ21mOUg2SElTQkRsbEQrUGlI?=
 =?utf-8?B?Wml5TDFwY29jY01mSStEL1owWnRySklhRjJZWkxrcEZiUE1rWHdNa3BtMGdL?=
 =?utf-8?B?TWJhUUlBeUJVVy9wWWlxMFdyME1yYk9CcUFZbXdsSWVuQzJWdmhDWTdhcW5P?=
 =?utf-8?B?T1lvUDJ1dExveHVvSk81ZDZQM1VLdzNKQ2dGbk40RjVSZ1FFOExDWTRZNlh0?=
 =?utf-8?B?eXZkazZTZnR1SDZleFNJaGtSWjY5TzJPL0hPOCtHR2I0M3A3NXpHNGJSMWJY?=
 =?utf-8?B?OU5BdmNyM1JtZzZtYkRYNGQ3eDU4Qk1tZ3I0dUdqRjh2SmdmWEZ1OUIxYnpo?=
 =?utf-8?B?cENhbG4wWTUwbkxYZTF0MlNOeVdkaEQ0SEhPZFRkV0JIK00wYmNpcCtGaFhI?=
 =?utf-8?B?eTcwRzBSa0JTTktLRkNobkZMaHFaVkNDbXJ4bWlEaXdjQm1zRXdCVmh5QTZh?=
 =?utf-8?B?TzNINm9rK2t2dVZ3TmtwTVV5MW5uNHU4Q1V6Sm5BVmg2WURSR0JwMEQrSVNi?=
 =?utf-8?Q?8pOYG2mt8GPLTZN/U9Iw1Es6ITJsD9VNFpRKF0Q?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a887f48-40ce-4089-887a-08d976b6da94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:03:17.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWoURAQRSpdc5Hiq7xzt9kJVaSz7ze4cOC881Z1j5YDrkif3C7LGaQFfeIwdAeQnQeaMou0ncBPgwrgb5CzpKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3502
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2lu
Y2UgY29tbWl0IDU1NjE3NzBmODBiMSAoInN0YWdpbmc6IHdmeDogcmVwYWlyIGV4dGVybmFsIElS
USBmb3IKU0RJTyIpLCB3Znhfc2Rpb19pcnFfc3Vic2NyaWJlKCkgZW5mb3JjZSB0aGUgZGV2aWNl
IHRvIHVzZSBJUlFzLgpIb3dldmVyLCB0aGVyZSBpcyBjdXJyZW50bHkgYSByYWNlIGluIHRoaXMg
Y29kZS4gQW4gSVJRIG1heSBoYXBwZW4KYmVmb3JlIHRoZSBJUlEgaGFzIGJlZW4gcmVnaXN0ZXJl
ZC4KClRoZSBwcm9ibGVtIGhhcyBvYnNlcnZlZCBkdXJpbmcgZGVidWcgc2Vzc2lvbiB3aGVuIHRo
ZSBkZXZpY2UgY3Jhc2hlcwpiZWZvcmUgdGhlIElSUSBzZXQgdXA6CgogICAgWyAxLjU0Nl0gd2Z4
LXNkaW8gbW1jMDowMDAxOjE6IHN0YXJ0ZWQgZmlybXdhcmUgMy4xMi4yICJXRjIwMF9BU0lDX1dG
TV8oSmVua2lucylfRlczLjEyLjIiIChBUEk6IDMuNywga2V5c2V0OiBDMCwgY2FwczogMHgwMDAw
MDAwMikKICAgIFsgMi41NTldIHdmeC1zZGlvIG1tYzA6MDAwMToxOiB0aW1lIG91dCB3aGlsZSBw
b2xsaW5nIGNvbnRyb2wgcmVnaXN0ZXIKICAgIFsgMy41NjVdIHdmeC1zZGlvIG1tYzA6MDAwMTox
OiBjaGlwIGlzIGFibm9ybWFsbHkgbG9uZyB0byBhbnN3ZXIKICAgIFsgNi41NjNdIHdmeC1zZGlv
IG1tYzA6MDAwMToxOiBjaGlwIGRpZCBub3QgYW5zd2VyCiAgICBbIDYuNTY4XSB3Zngtc2RpbyBt
bWMwOjAwMDE6MTogaGFyZHdhcmUgcmVxdWVzdCBDT05GSUdVUkFUSU9OICgweDA5KSBvbiB2aWYg
MiByZXR1cm5lZCBlcnJvciAtMTEwCiAgICBbIDYuNTc3XSB3Zngtc2RpbyBtbWMwOjAwMDE6MTog
UERTIGJ5dGVzIDAgdG8gMTI6IGNoaXAgZGlkbid0IHJlcGx5IChjb3JydXB0ZWQgZmlsZT8pCiAg
ICBbIDYuNTg1XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwCiAgICBbIDYuNTkyXSBwZ2QgPSBjMDAwNDAw
MAogICAgWyA2LjU5NV0gWzAwMDAwMDAwXSAqcGdkPTAwMDAwMDAwCiAgICBbIDYuNTk4XSBJbnRl
cm5hbCBlcnJvcjogT29wcyAtIEJVRzogMTcgWyMxXSBUSFVNQjIKICAgIFsgNi42MDNdIE1vZHVs
ZXMgbGlua2VkIGluOgogICAgWyA2LjYwNl0gQ1BVOiAwIFBJRDogMjMgQ29tbToga3dvcmtlci91
MjoxIE5vdCB0YWludGVkIDMuMTguMTkgIzc4CiAgICBbIDYuNjEyXSBXb3JrcXVldWU6IGttbWNk
IG1tY19yZXNjYW4KICAgIFsgNi42MTZdIHRhc2s6IGMxNzZkMTAwIHRpOiBjMGU1MDAwMCB0YXNr
LnRpOiBjMGU1MDAwMAogICAgWyA2LjYyMV0gUEMgaXMgYXQgd2FrZV91cF9wcm9jZXNzKzB4YS8w
eDE0CiAgICBbIDYuNjI1XSBMUiBpcyBhdCBzZGlvX2lycSsweDYxLzB4MjUwCiAgICBbIDYuNjI5
XSBwYyA6IFs8YzAwMWU4YWU+XSBsciA6IFs8YzAwZWM1YmQ+XSBwc3I6IDYwMDAwMWIzCiAgICBb
IDYuNjI5XSBzcCA6IGMwZTUxYmQ4IGlwIDogYzBlNTFjYzggZnAgOiAwMDAwMDAwMQogICAgWyA2
LjY0MF0gcjEwOiAwMDAwMDAwMyByOSA6IDAwMDAwMDAwIHI4IDogYzAwMDNjMzQKICAgIFsgNi42
NDRdIHI3IDogYzBlNTFiZDggcjYgOiBjMDAwM2MzMCByNSA6IDAwMDAwMDAxIHI0IDogYzBlNzhj
MDAKICAgIFsgNi42NTFdIHIzIDogMDAwMDAwMDAgcjIgOiAwMDAwMDAwMCByMSA6IDAwMDAwMDAz
IHIwIDogMDAwMDAwMDAKICAgIFsgNi42NTddIEZsYWdzOiBuWkN2IElSUXMgb2ZmIEZJUXMgb24g
TW9kZSBTVkNfMzIgSVNBIFRodW1iIFNlZ21lbnQga2VybmVsCiAgICBbIDYuNjY0XSBDb250cm9s
OiA1MGM1M2M3ZCBUYWJsZTogMTFmZDgwNTkgREFDOiAwMDAwMDAxNQogICAgWyA2LjY3MF0gUHJv
Y2VzcyBrd29ya2VyL3UyOjEgKHBpZDogMjMsIHN0YWNrIGxpbWl0ID0gMHhjMGU1MDFiMCkKICAg
IFsgNi42NzZdIFN0YWNrOiAoMHhjMGU1MWJkOCB0byAweGMwZTUyMDAwKQogICAgWy4uLl0KICAg
IFsgNi45NDldIFs8YzAwMWU4YWU+XSAod2FrZV91cF9wcm9jZXNzKSBmcm9tIFs8YzAwZWM1YmQ+
XSAoc2Rpb19pcnErMHg2MS8weDI1MCkKICAgIFsgNi45NTZdIFs8YzAwZWM1YmQ+XSAoc2Rpb19p
cnEpIGZyb20gWzxjMDAyNTA5OT5dIChoYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweDE3LzB4OTIp
CiAgICBbIDYuOTY0XSBbPGMwMDI1MDk5Pl0gKGhhbmRsZV9pcnFfZXZlbnRfcGVyY3B1KSBmcm9t
IFs8YzAwMjUxMmY+XSAoaGFuZGxlX2lycV9ldmVudCsweDFiLzB4MjQpCiAgICBbIDYuOTczXSBb
PGMwMDI1MTJmPl0gKGhhbmRsZV9pcnFfZXZlbnQpIGZyb20gWzxjMDAyNjU3Nz5dIChoYW5kbGVf
bGV2ZWxfaXJxKzB4NWQvMHg3NikKICAgIFsgNi45ODFdIFs8YzAwMjY1Nzc+XSAoaGFuZGxlX2xl
dmVsX2lycSkgZnJvbSBbPGMwMDI0Y2MzPl0gKGdlbmVyaWNfaGFuZGxlX2lycSsweDEzLzB4MWMp
CiAgICBbIDYuOTg5XSBbPGMwMDI0Y2MzPl0gKGdlbmVyaWNfaGFuZGxlX2lycSkgZnJvbSBbPGMw
MDI0ZGQ5Pl0gKF9faGFuZGxlX2RvbWFpbl9pcnErMHgzMS8weDQ4KQogICAgWyA2Ljk5N10gWzxj
MDAyNGRkOT5dIChfX2hhbmRsZV9kb21haW5faXJxKSBmcm9tIFs8YzAwMDgzNTk+XSAob3ZfaGFu
ZGxlX2lycSsweDMxLzB4ZTApCiAgICBbIDcuMDA1XSBbPGMwMDA4MzU5Pl0gKG92X2hhbmRsZV9p
cnEpIGZyb20gWzxjMDAwYWY1Yj5dIChfX2lycV9zdmMrMHgzYi8weDVjKQogICAgWyA3LjAxM10g
RXhjZXB0aW9uIHN0YWNrKDB4YzBlNTFjNjggdG8gMHhjMGU1MWNiMCkKICAgIFsuLi5dCiAgICBb
IDcuMDM4XSBbPGMwMDBhZjViPl0gKF9faXJxX3N2YykgZnJvbSBbPGMwMTc3NWFhPl0gKHdhaXRf
Zm9yX2NvbW1vbisweDllLzB4YzQpCiAgICBbIDcuMDQ1XSBbPGMwMTc3NWFhPl0gKHdhaXRfZm9y
X2NvbW1vbikgZnJvbSBbPGMwMGUxZGMzPl0gKG1tY193YWl0X2Zvcl9yZXErMHg0Yi8weGRjKQog
ICAgWyA3LjA1M10gWzxjMDBlMWRjMz5dIChtbWNfd2FpdF9mb3JfcmVxKSBmcm9tIFs8YzAwZTFl
ODM+XSAobW1jX3dhaXRfZm9yX2NtZCsweDJmLzB4MzQpCiAgICBbIDcuMDYxXSBbPGMwMGUxZTgz
Pl0gKG1tY193YWl0X2Zvcl9jbWQpIGZyb20gWzxjMDBlN2IyYj5dIChtbWNfaW9fcndfZGlyZWN0
X2hvc3QrMHg3MS8weGFjKQogICAgWyA3LjA3MF0gWzxjMDBlN2IyYj5dIChtbWNfaW9fcndfZGly
ZWN0X2hvc3QpIGZyb20gWzxjMDBlOGY3OT5dIChzZGlvX2NsYWltX2lycSsweDZiLzB4MTE2KQog
ICAgWyA3LjA3OF0gWzxjMDBlOGY3OT5dIChzZGlvX2NsYWltX2lycSkgZnJvbSBbPGMwMGQ4NDE1
Pl0gKHdmeF9zZGlvX2lycV9zdWJzY3JpYmUrMHgxOS8weDk0KQogICAgWyA3LjA4Nl0gWzxjMDBk
ODQxNT5dICh3Znhfc2Rpb19pcnFfc3Vic2NyaWJlKSBmcm9tIFs8YzAwZDUyMjk+XSAod2Z4X3By
b2JlKzB4MTg5LzB4MmFjKQogICAgWyA3LjA5NV0gWzxjMDBkNTIyOT5dICh3ZnhfcHJvYmUpIGZy
b20gWzxjMDBkODNiZj5dICh3Znhfc2Rpb19wcm9iZSsweDhmLzB4Y2MpCiAgICBbIDcuMTAyXSBb
PGMwMGQ4M2JmPl0gKHdmeF9zZGlvX3Byb2JlKSBmcm9tIFs8YzAwZTdmYmI+XSAoc2Rpb19idXNf
cHJvYmUrMHg1Zi8weGE4KQogICAgWyA3LjEwOV0gWzxjMDBlN2ZiYj5dIChzZGlvX2J1c19wcm9i
ZSkgZnJvbSBbPGMwMGJlMjI5Pl0gKGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg1OS8weDEzNCkKICAg
IFsgNy4xMThdIFs8YzAwYmUyMjk+XSAoZHJpdmVyX3Byb2JlX2RldmljZSkgZnJvbSBbPGMwMGJk
NGQ3Pl0gKGJ1c19mb3JfZWFjaF9kcnYrMHgzZi8weDRhKQogICAgWyA3LjEyNl0gWzxjMDBiZDRk
Nz5dIChidXNfZm9yX2VhY2hfZHJ2KSBmcm9tIFs8YzAwYmUxYTU+XSAoZGV2aWNlX2F0dGFjaCsw
eDNiLzB4NTIpCiAgICBbIDcuMTM0XSBbPGMwMGJlMWE1Pl0gKGRldmljZV9hdHRhY2gpIGZyb20g
WzxjMDBiZGMyYj5dIChidXNfcHJvYmVfZGV2aWNlKzB4MTcvMHg0YykKICAgIFsgNy4xNDFdIFs8
YzAwYmRjMmI+XSAoYnVzX3Byb2JlX2RldmljZSkgZnJvbSBbPGMwMGJjZDY5Pl0gKGRldmljZV9h
ZGQrMHgyYzUvMHgzMzQpCiAgICBbIDcuMTQ5XSBbPGMwMGJjZDY5Pl0gKGRldmljZV9hZGQpIGZy
b20gWzxjMDBlODBiZj5dIChzZGlvX2FkZF9mdW5jKzB4MjMvMHg0NCkKICAgIFsgNy4xNTZdIFs8
YzAwZTgwYmY+XSAoc2Rpb19hZGRfZnVuYykgZnJvbSBbPGMwMGU3OWViPl0gKG1tY19hdHRhY2hf
c2RpbysweDE4Ny8weDFlYykKICAgIFsgNy4xNjRdIFs8YzAwZTc5ZWI+XSAobW1jX2F0dGFjaF9z
ZGlvKSBmcm9tIFs8YzAwZTMxYmQ+XSAobW1jX3Jlc2NhbisweDE4ZC8weDFmYykKICAgIFsgNy4x
NzJdIFs8YzAwZTMxYmQ+XSAobW1jX3Jlc2NhbikgZnJvbSBbPGMwMDFhMTRmPl0gKHByb2Nlc3Nf
b25lX3dvcmsrMHhkNy8weDE3MCkKICAgIFsgNy4xNzldIFs8YzAwMWExNGY+XSAocHJvY2Vzc19v
bmVfd29yaykgZnJvbSBbPGMwMDFhNTliPl0gKHdvcmtlcl90aHJlYWQrMHgxMDMvMHgxYmMpCiAg
ICBbIDcuMTg3XSBbPGMwMDFhNTliPl0gKHdvcmtlcl90aHJlYWQpIGZyb20gWzxjMDAxYzczMT5d
IChrdGhyZWFkKzB4N2QvMHg5MCkKICAgIFsgNy4xOTRdIFs8YzAwMWM3MzE+XSAoa3RocmVhZCkg
ZnJvbSBbPGMwMDA4Y2UxPl0gKHJldF9mcm9tX2ZvcmsrMHgxMS8weDMwKQogICAgWyA3LjIwMV0g
Q29kZTogMjEwMyBiNTgwIDIyMDAgYWYwMCAoNjgxYikgNDZiZAogICAgWyA3LjIwNl0gLS0tWyBl
bmQgdHJhY2UgM2FiNTBhY2VkNDJlZWRiNCBdLS0tCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQ
b3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJpdmVycy9zdGFnaW5n
L3dmeC9idXNfc2Rpby5jIHwgMjEgKysrKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3N0YWdpbmcvd2Z4L2J1c19zZGlvLmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2J1c19zZGlvLmMK
aW5kZXggZWI3MGJlZjZiZDZlLi5hNjcwMTc2YmEwNmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3Rh
Z2luZy93ZngvYnVzX3NkaW8uYworKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2J1c19zZGlvLmMK
QEAgLTEyMCwxOSArMTIwLDIyIEBAIHN0YXRpYyBpbnQgd2Z4X3NkaW9faXJxX3N1YnNjcmliZSh2
b2lkICpwcml2KQogCQlyZXR1cm4gcmV0OwogCX0KIAotCXNkaW9fY2xhaW1faG9zdChidXMtPmZ1
bmMpOwotCWNjY3IgPSBzZGlvX2YwX3JlYWRiKGJ1cy0+ZnVuYywgU0RJT19DQ0NSX0lFTngsIE5V
TEwpOwotCWNjY3IgfD0gQklUKDApOwotCWNjY3IgfD0gQklUKGJ1cy0+ZnVuYy0+bnVtKTsKLQlz
ZGlvX2YwX3dyaXRlYihidXMtPmZ1bmMsIGNjY3IsIFNESU9fQ0NDUl9JRU54LCBOVUxMKTsKLQlz
ZGlvX3JlbGVhc2VfaG9zdChidXMtPmZ1bmMpOwogCWZsYWdzID0gaXJxX2dldF90cmlnZ2VyX3R5
cGUoYnVzLT5vZl9pcnEpOwogCWlmICghZmxhZ3MpCiAJCWZsYWdzID0gSVJRRl9UUklHR0VSX0hJ
R0g7CiAJZmxhZ3MgfD0gSVJRRl9PTkVTSE9UOwotCXJldHVybiBkZXZtX3JlcXVlc3RfdGhyZWFk
ZWRfaXJxKCZidXMtPmZ1bmMtPmRldiwgYnVzLT5vZl9pcnEsIE5VTEwsCi0JCQkJCSB3Znhfc2Rp
b19pcnFfaGFuZGxlcl9leHQsIGZsYWdzLAotCQkJCQkgIndmeCIsIGJ1cyk7CisJcmV0ID0gZGV2
bV9yZXF1ZXN0X3RocmVhZGVkX2lycSgmYnVzLT5mdW5jLT5kZXYsIGJ1cy0+b2ZfaXJxLCBOVUxM
LAorCQkJCQl3Znhfc2Rpb19pcnFfaGFuZGxlcl9leHQsIGZsYWdzLAorCQkJCQkid2Z4IiwgYnVz
KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCXNkaW9fY2xhaW1faG9zdChidXMtPmZ1bmMp
OworCWNjY3IgPSBzZGlvX2YwX3JlYWRiKGJ1cy0+ZnVuYywgU0RJT19DQ0NSX0lFTngsIE5VTEwp
OworCWNjY3IgfD0gQklUKDApOworCWNjY3IgfD0gQklUKGJ1cy0+ZnVuYy0+bnVtKTsKKwlzZGlv
X2YwX3dyaXRlYihidXMtPmZ1bmMsIGNjY3IsIFNESU9fQ0NDUl9JRU54LCBOVUxMKTsKKwlzZGlv
X3JlbGVhc2VfaG9zdChidXMtPmZ1bmMpOworCXJldHVybiAwOwogfQogCiBzdGF0aWMgaW50IHdm
eF9zZGlvX2lycV91bnN1YnNjcmliZSh2b2lkICpwcml2KQotLSAKMi4zMy4wCgo=
