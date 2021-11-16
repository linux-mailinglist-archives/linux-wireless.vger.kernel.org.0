Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E6452C5E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 09:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhKPIH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 03:07:58 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:61545 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhKPIHy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 03:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1637049898; x=1637654698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YDwHfPCLoC1jvzTy/MytO1NCyg76031VMgwqRhQai6o=;
  b=hl6SGpauZ1UJDfpACMdF+lVPLzRG3QZKjE+I1Sw0s72I9zaA9MEqstOO
   aAhrznRnDJIhFu4eO7wHt2gRAPhBXEn91cG2AYfAowfhnuXvo5tWrNO0+
   RASRLZuTJRu6t+XY8/aTfoG8zV/MNdMeM6XpyDeaZuYOK/xh+hSf6jERj
   I=;
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 08:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXzIXVWEbNPQJ+Q+GpEN63vScpX1mHqfew2wELEA3ZTqVZCW1oy4k4fSpbAFpn1NBYJzbain5mtaW0SnZWL7YD3Q/3U6RtGW4lmRd3bIduFPhMYNlRBRRCyXmPkTQkWeSu0p5VPRldAP1AvIeRn94a56/6LcqXbV6puV1LU0kYufXuuiz5fFIcnM+xpFhKQsttRW9vvJnFfY3ABlOTuXvzLLdM5xk79TWxf5SQqyNFl9FJMcfUuO+bOWjgu+rskCJe3UHnMSThGycsFmF6InOEoBkNG6Xy2LBK7DdP+TImP38TyaiRngNZyEjfNgbcMOr5MfSyth5eLhfZhGPrfBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDwHfPCLoC1jvzTy/MytO1NCyg76031VMgwqRhQai6o=;
 b=R75NzCN61fffPSVRgtNA/V8+oa8FjU0g0IiSwHCkyMg088DWDjlF09c9izo+qTHF6LtBKNDYtpCJUb3b6zkk1vs1B1syvHrqlw6HF1qNFM3M19AoFVZzFz9Oa9X3qDvsOo1vNtmXeXV1XmqitTbD/n02h0oTUr74MzkKPKBifblKSzYH60hOPkZIA0xk0d2fbogZBrXSx+IxX/EAkw81uGzHaMPIu9GzR4wuxHdqL1LnCVq7R2diyl+nSztAewOmlPIyRmfQxrQ7DJpVi5o97kb/lTvs4UqvLv+WBV/Ksk3mPlX+qSC3pnN9LydBygmVUhVIu+qCEnbhUpeV5MoxQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8199.namprd02.prod.outlook.com (2603:10b6:8:3::7) by
 DM5PR02MB3656.namprd02.prod.outlook.com (2603:10b6:4:b3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Tue, 16 Nov 2021 08:04:54 +0000
Received: from DM8PR02MB8199.namprd02.prod.outlook.com
 ([fe80::14c7:317b:5dfc:ec99]) by DM8PR02MB8199.namprd02.prod.outlook.com
 ([fe80::14c7:317b:5dfc:ec99%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 08:04:54 +0000
From:   "Seevalamuthu Mariappan (Temp) (QUIC)" <quic_seevalam@quicinc.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "Seevalamuthu Mariappan (Temp) (QUIC)" <quic_seevalam@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] ath11k: add hw_param for wakeup_mhi
Thread-Topic: [PATCH] ath11k: add hw_param for wakeup_mhi
Thread-Index: AQHX15a4ozFT70/O7UuQdcg1uRZG3awEZhFWgAFsBNA=
Date:   Tue, 16 Nov 2021 08:04:54 +0000
Message-ID: <DM8PR02MB819953610F46F24C11AD955DF6999@DM8PR02MB8199.namprd02.prod.outlook.com>
References: <1636702019-26142-1-git-send-email-quic_seevalam@quicinc.com>
 <87czn1iurz.fsf@codeaurora.org>
In-Reply-To: <87czn1iurz.fsf@codeaurora.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57610cc8-e260-4246-80a9-08d9a8d7c62b
x-ms-traffictypediagnostic: DM5PR02MB3656:
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB3656A1F3F170B51E6C6154E08A999@DM5PR02MB3656.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:299;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dsYQ3MYFwcLSqmAwo0oiUvtnio7Bbbd5bQ/dK8R1i8Ka2jIOXEW/icfrEa3ZsooEXqTbXb/oLcL2CoYQkJGdRnTm+vjEUBz8Parr1/VMJZwjemc/lkc14JH6P7ZYp1CJ06xhv+8RyVGvz9jPgeZLQvA7fdZn6WTMmWpWEXDGZbLCICrOBHOilSVH9hpQtta1Tc4t79InEgschsw/4Dgq5A/JHKnyWQIgO4Sh+TWEijx/x1RNE4cblqKoc4mMTQNs7O0LfrC/KYtiuMVkNjQpN228eIU5FkPBWLO7PF6MZ29eMHhaGKjPrVIOQwxzrPoZPE5d1iAdcBGJYlfBR9kSq1QZFb+xYgvimJyOauwJRwO6Gad10xTuTjXQ5qdSeBR37hLRTQf69HsqxGwkeo3c2J08X1ZVcCbeSY4eRSiVbS99jTEhGJwqMrfG3S0+b9YRReQGpW+F3qctHur6AsYtznNsm9zLy9NiDTjYJ7fUbH762ZOaPSdEYnHlb6df5iQZfLhu+T80XDYcBt9xBHOPPRU5phSTD5CSYLiivP2kx+zGULlPIAWOJEby9DMnSVHJPcxFKnK66YpcwPPyIrQ0PCDIxBRrflq8QnUqweQ9dS330cI5iRT4vPCOSIPPaOl0qW+d3G4xV85dZm0CL69YiKmmT0HgaqWHQcfPbbVZlnReWfv9Ra1NH5wStmUlCjongBCwnhCNVleDQ9PH7ywy77bKV93XAgAtmHG/acM0KPqLAOp6zeoDpKYd0meZ0MbjQmTa4t4Q7GSOCS2rkWm/PJOCKcSs2iRXKg+G89k0/Dw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8199.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(4326008)(8936002)(83380400001)(966005)(6506007)(55016002)(508600001)(2906002)(38070700005)(8676002)(7696005)(66476007)(9686003)(71200400001)(66946007)(316002)(38100700002)(76116006)(66556008)(122000001)(110136005)(5660300002)(52536014)(86362001)(54906003)(26005)(66446008)(64756008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P9AKouG9Hum+04Am9U5mgRFKjpYDWrnrGxhS8v/7ITUM4fM6ybLskWOrFYgd?=
 =?us-ascii?Q?Xe/B+HtlcI1jkjeSdW21QmyxELuxr0jBPTPlK8G9bWBfvvuLUAoBbc7xnoOW?=
 =?us-ascii?Q?XwssH0wRrYndkIjM0+ZyNN5vV9EA4sCi6G7yz30hCzsJmjTT/tHCywzVkih3?=
 =?us-ascii?Q?U1CTYmSQ4UZeIbcvi+PxIGjv8AduSHlFTlNMTGgIiCfU8Epe+bF6V6YyRPRo?=
 =?us-ascii?Q?PHN05u/27tVWWlagw9+q24Xwe/KaW6envCMTlb6HGmV2JEsxHK3FcgIbUgjj?=
 =?us-ascii?Q?GvZBkIlLDQIyGHfNGI/xw73RNfAaPOXyim+/0OHB5GlebVvlJGFXYf6wzK4s?=
 =?us-ascii?Q?OHEu8rtyT+XIY3acZVI1wUII4ZMKLt6+hGggisRxCR+At2aho75H6ByfkDGT?=
 =?us-ascii?Q?v2qcZVZy9ml1eleryXxvQHS+SW2x0y8mdFI9hU9s8gq7noACg3/WSlpIKAAq?=
 =?us-ascii?Q?bIuWzzG6u8IWuYpF+FHeOvYE6MUMkoiYIWw6/DIvoVxWg53POihfn/QnIx+J?=
 =?us-ascii?Q?mwjCb76r0rCm8RExKtTWrLENvVabGYwVtIIo2kSt3JM5XU4P8AatdfXFbFO7?=
 =?us-ascii?Q?CcCBLiLvwDwJJLUQkISXYsYn8gr4clkdO9avWJ3tVr5I8icP0JbMb76rv2cM?=
 =?us-ascii?Q?/r1ZCPrIfVTfYvjgkj2nnsKzWZIoNUcRPBuM9ZhxRl3HrWBz/R9KUCFGmbbb?=
 =?us-ascii?Q?wAK5oZOcnu+yvSRqOop+KUDHRkdLL6dBtLpUqhXH/+58N4jlPKyS969otz+5?=
 =?us-ascii?Q?psr3vGdX++hIs5Oj0tcqObJEwo1ouYv6uzCVVXNiCPAluWy6fBZ5oKmUJSYI?=
 =?us-ascii?Q?g/mDNv6n73ryp7bvBQUXmXiyuKhPm7e6fev+4uF0VfFL1ofv/F0G1X1YeMy4?=
 =?us-ascii?Q?pRolVUwBp97ZpZcJaDeNxJsnZ/nvFq788k2oZLxaKzxvBC5jf/w5ax/qbcYY?=
 =?us-ascii?Q?M/0ayrFjzU/5+F/DFomeXcs5l1++aA58AthlVKGWNuORuUZAhaBX/F3/acEa?=
 =?us-ascii?Q?mNfU1WnXHlSOWodl7CsTN8w4MJb92i84/IotPf5bIyWi3HKWPDzeQwl8lnQt?=
 =?us-ascii?Q?uUo68AmVZkFGc2d1SmaWbJy9m1YABATQRSsdyEqa7ZZktWFg5IfIFRRVpNjN?=
 =?us-ascii?Q?fQwsln4W5vyaN1A4KWlpgkn1fFWetE/hPFbrNrYCjMjm+4BOBc5754uTIuAZ?=
 =?us-ascii?Q?8syyYKTewVjGY65gX2mBSY3E+OL/N0/nzC/ebBeRlVEvhpjEyjkfGBMSGIhq?=
 =?us-ascii?Q?ZxyPA+Y4rYCdGfwyXmm8Qaaq80qlSFirIxtg8bL0OQhJJr67D3kbXBXigGDj?=
 =?us-ascii?Q?EC+ORopPaK8nwBETKwgNI+Re7we4XGz2B0soFv5lnDTbEJvq4b72R2n5MrQz?=
 =?us-ascii?Q?wRjAX97yf4iLEolvRhWJT3PmVoCvFAo9ZUcsPwSmGhNOsXaNhqVy5KnRivtK?=
 =?us-ascii?Q?WWRl2JYKmK6/QgBttmmPTmIVQWwjwt2Pq5W+4prBPPVErOnRaE0Iom+v4oQe?=
 =?us-ascii?Q?jgkY8BqAwqg9kaJ541CCXpZFBa8Rpg5qasObPG48DKst6J6DC9HMXNtGuiZh?=
 =?us-ascii?Q?DU1cB5rk73Rj3/mvtIcr+kL/WMlmE5kv016lFiBdSiuc+TBBi135x4OjMrZY?=
 =?us-ascii?Q?ON69rBxBLH+Nq1bkD9hrh5m4ZzwMMPDbca4nIIO49ws54zO1Kys+Z8THCq8C?=
 =?us-ascii?Q?JWYwsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8199.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57610cc8-e260-4246-80a9-08d9a8d7c62b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 08:04:54.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fT3Ri6tZqW/djS3A0aROLCEbIZlQguy0Kjyn1dgOp+w9yElhvFmGQwu1wMlvDrwRndQf1Uhls1Ie4xrekcAAlR1M0g1t0zBOZ15dLULE0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3656
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Seevalamuthu Mariappan <quic_seevalam@quicinc.com> writes:
>=20
> > Wakeup mhi is needed before pci_read/write only for QCA6390 and
> > WCN6855. Since wakeup & release mhi is enabled for all hardwares,
> > below mhi assert is seen in QCN9074.
> >
> > 	Kernel panic - not syncing: dev_wake !=3D 0
> > 	CPU: 2 PID: 13535 Comm: procd Not tainted 4.4.60 #1
> > 	Hardware name: Generic DT based system
> > 	[<80316dac>] (unwind_backtrace) from [<80313700>]
> (show_stack+0x10/0x14)
> > 	[<80313700>] (show_stack) from [<805135dc>]
> (dump_stack+0x7c/0x9c)
> > 	[<805135dc>] (dump_stack) from [<8032136c>] (panic+0x84/0x1f8)
> > 	[<8032136c>] (panic) from [<80549b24>]
> (mhi_pm_disable_transition+0x3b8/0x5b8)
> > 	[<80549b24>] (mhi_pm_disable_transition) from [<80549ddc>]
> (mhi_power_down+0xb8/0x100)
> > 	[<80549ddc>] (mhi_power_down) from [<7f5242b0>]
> (ath11k_mhi_op_status_cb+0x284/0x3ac [ath11k_pci])
> > 	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET
> pm_state:SHUTDOWN Process
> > 	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET
> pm_state:SHUTDOWN Process
> > 	[E][__mhi_device_get_sync] Did not enter M0 state, cur_state:RESET
> pm_state:SHUTDOWN Process
> > 	[<7f5242b0>] (ath11k_mhi_op_status_cb [ath11k_pci]) from
> [<7f524878>] (ath11k_mhi_stop+0x10/0x20 [ath11k_pci])
> > 	[<7f524878>] (ath11k_mhi_stop [ath11k_pci]) from [<7f525b94>]
> (ath11k_pci_power_down+0x54/0x90 [ath11k_pci])
> > 	[<7f525b94>] (ath11k_pci_power_down [ath11k_pci]) from
> [<8056b2a8>] (pci_device_shutdown+0x30/0x44)
> > 	[<8056b2a8>] (pci_device_shutdown) from [<805cfa0c>]
> (device_shutdown+0x124/0x174)
> > 	[<805cfa0c>] (device_shutdown) from [<8033aaa4>]
> (kernel_restart+0xc/0x50)
> > 	[<8033aaa4>] (kernel_restart) from [<8033ada8>]
> (SyS_reboot+0x178/0x1ec)
> > 	[<8033ada8>] (SyS_reboot) from [<80301b80>]
> > (ret_fast_syscall+0x0/0x34)
> >
> > Hence, disable wakeup/release mhi using hw_param for other hardwares.
> >
> > Tested-on: QCN9074 hw1.0 PCI
> > WLAN.HK.2.5.0.1-01060-QCAHKSWPL_SILICONZ-1
> >
> > Fixes: a05bd85133 ("ath11k: read and write registers below unwindowed
> > address")
> > Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
>=20
> The commit log is not quite clear, are you saying that commit a05bd85133
> broke QCN9074 support altogether? Or it was failing only in some cases?
> I can update the commit log.
>=20

[seevalam]: MHI assert seen during 'rmmod ath11k_pci' for QCN9074.

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches

Regards,
Seevalamuthu M
