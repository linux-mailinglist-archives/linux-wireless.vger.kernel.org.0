Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FE3B26F4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 07:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhFXFpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 01:45:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16698 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhFXFpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 01:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624513415; x=1656049415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SMkfm/rcmEsZoNe6YM0Ha513qhBZfWaSJLzUkdgf6UM=;
  b=FFztM+uQfg/tkcqaBZO3xylLF3a7B4hifAKF8KrEsjcAzSYyKyrn+Xyd
   dJx0FmWlZE7pgR/qfPlyChmJsXoqiLfD9Ee+xYDxhOBiB5Wx1Bhu97ri4
   eNQv8NCGISV2seQLoj+jekNYxwyTM979E3RNe/168HF8hNkRuhJ2mVZil
   sgGcJTWWm+Ru0oj3RlJxl9zJxhNx2ZCebHaH5fDfZSkyp971r0y/2u21d
   OvWv1Ht3dHa3snbiN6d5NanZFgEqx4+VzMbYNmYj55fqQV9+C1E+NhP3X
   qeZXvr3rtS7HULpt1ffWt+Nz+Gg79NM36bXgkebyCZAd6e0mSPVA+d96P
   w==;
IronPort-SDR: g5oWH4z5U9Q1x1xtzK3H4p7XRdV1sRp00if1G8IMd/QajIaEHe9KHdiq+74HPC4z+gKaIvvHot
 M7H8nnMuQ3dm9XakVS7dgg0HnmxMcPe2zQPjDfjU9hcUGILkEMkFpbBFYlgNx6cYA7Om0AkuTm
 icHtmBsBhZm21d3gakkQ4lYIfnf7fhtEoLj9Fjt2Wd7NX5jC2zXOCD0wJYU1RtP2WjAt/1oNXo
 hDvBUblUclA7rMV+88NrSmvgyw/TpOapDEAemTsJ5YsBhHVON89mTxBIYphLCML7H5RT8yGANL
 CCU=
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="126444665"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2021 22:43:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 22:43:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 23 Jun 2021 22:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFKIchsVO2xAVGNdqy5qq2ntxeb8yqReMeSso2eJnttosSSolZuN3yPEVEddyWCgjhtdT/k66/ZHfSEPr5zk2bknRfyMrA/AKOXSOh78ZOO8r7o2mIXkdzZ4Csdk2BkRZixdpUrVf2EigcwO78gIbBU+8rwdFFg6wcyNQq9Umqu/rpCdysZ52dTYmDb6zNbpiBGnki5w0Tssj49kYbdNsv4RyzdgP8xyYqq5bqj2hKE1dJzlF0UHjUGRoU1jstBuaotUxhkNhtxLTYubYx3uzocTT5LQF7i5yd3NgesFuR4/9k9LtfbJI8TXJ5MVGGuFqXAx2qNIWKwGiRP5wt9gQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMkfm/rcmEsZoNe6YM0Ha513qhBZfWaSJLzUkdgf6UM=;
 b=JzWa6KTHHrj64Dwp55n2WjmiwppV7QyzG+oZzYuW5EpUzoFTcgO5rHuRgW0QRVm1A6rrA8q9dKaim3EMs5QapdPHZUWAUCWBVsZtUljtPF1OyR7zyc6ukoSh8NVK95QyFhjfXw7ywfOo8mo48L1EOM25BMwKcYVqyXA/+BQkv/h4b9WSvV5lWbdpfmUt9T8sa/O6FxQ234O3vgZrMJsKcfFuMoEh1UVy0JfwP1jHyiyWnMGKBQG9h5FlSn5uu01h0nYu2i45fsWQxlS5Hzl8osqaFdE+mywsvWieMJP1pcvIOyq9cRBGiImZdfC8/XLK9nk6y04KYJ0qKgClUPDZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMkfm/rcmEsZoNe6YM0Ha513qhBZfWaSJLzUkdgf6UM=;
 b=ZsHMaUAgahnfmw5085qhOPmydEZveYz0t16fJ68Etyrctfm91qdSVb4I1XaFeFz2D8qMBR3jfk4pvia1JMewqGUG5L3W7B/SgOSXic1vmaRUgv5hxIsRLUp2oeJa8f+Efea66vHrJKF+5YPKsodKoi8K8K+GDYsZwrTn8H1229Q=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB2710.namprd11.prod.outlook.com (2603:10b6:a02:c7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Thu, 24 Jun
 2021 05:43:24 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::cfb:6c2e:60dd:91dc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::cfb:6c2e:60dd:91dc%4]) with mapi id 15.20.4264.019; Thu, 24 Jun 2021
 05:43:24 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 01/12] wilc1000: move 'deinit_lock' lock init/destory
 inside module probe
Thread-Topic: [PATCH 01/12] wilc1000: move 'deinit_lock' lock init/destory
 inside module probe
Thread-Index: AQHXOG6fh5Se5HWONEeyioxi64smcKsjBtQA
Date:   Thu, 24 Jun 2021 05:43:23 +0000
Message-ID: <d2e57ac8-f0ba-bc3a-7aea-9b233a8eb20b@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
 <20210423182925.5865-2-ajay.kathat@microchip.com>
In-Reply-To: <20210423182925.5865-2-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39f9db28-cd7c-497e-b706-08d936d2fb82
x-ms-traffictypediagnostic: BYAPR11MB2710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2710B374B53610FEBEB71E52E3079@BYAPR11MB2710.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DGX9dulzyTUbfojkOIXPS/TkEXc732f6TKfy46LdIzfh74wi3pAIgsDwfdHS0YnnHTyUfp80gyhPNjGMGq8MZrQL7Pva8+saw+SJwXdW+nq86L0J8rpywzwZNdJmS0LRCAcaPCCulTE7ck+VP1EWuTJH3SFoQqJCe6GW6WlSj3jsdWw+lFnt4cWjs48yV7bUEAEnCUalfpkrrTEcizpqEk8C823XrqI56cW4GGXMavjBMKskgMS7qlJnL71rI0l7yTylHr+XgSV+5LgRmJKplNpxj+zUYXpf760zYLL/GAmTHWldpFurb0x0xmonUhfQeYllNtirsUMA1d+AzlropqKsKcjY5Lao/cd3nSQxGb6+XIm2EvV6qqcbycBlKTRCm2x16U+xNO2epYIurO+Dp/arXOlofJhkkQ9e5+xhRpBUzZ0lpcT6QVcfKJhSb4NjJllr9T1mbbeLrg3rh9bTuPBlgekDur+435xn/tXB6ytbFYm/AV3BjRGBDSPFmTWojx/ayepAzes87n5yW72G9a/L4COGMqDe6ab/JYEdsmJEfVeh5cIPsq20ZmW0Goi9ivvqTSKnb32XusQ+5+4g1ah4rh8kx3YETYbePHkgi0GnnMJ6driuGqw1qGmrpqIYVjbZFxtryzx/kKaB9yArd/CyVHaFxnFJE4G9ezQzUBTU0zs0+moSdETIxpI2H4f9G3JAIlNYP6rRr9e3JkuELSvn+igCjV4d2gQn8Efgy/Z9laCrh0UlrgJ1ogULNY15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(83380400001)(186003)(66476007)(76116006)(91956017)(6512007)(31696002)(86362001)(26005)(66556008)(66446008)(64756008)(36756003)(66946007)(71200400001)(122000001)(2906002)(8936002)(4326008)(316002)(55236004)(8676002)(31686004)(558084003)(2616005)(478600001)(6506007)(5660300002)(107886003)(38100700002)(110136005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkVBRjJmdHdUaVY1d1I5UVBnTGJFTnU4TVJSY04xWWFGR05taUROQXo5K1Vw?=
 =?utf-8?B?RGRhSUJvaWhiQlJYYSs5L0cxc3gvV1Y3b3NlYW01dVgzdWRnNzM2VFN1T2FO?=
 =?utf-8?B?cnBtcDhRRHJSWkFWNmZVbldiU3orZ0hCUVhvM1JGZXdrWVFJYXBreS9UVDBq?=
 =?utf-8?B?Z1BJWnpZT0tNOVZTbTVLT3NNbm1XVUZ4MXZNeTUrMldGQ0JFbElzVGxteUEw?=
 =?utf-8?B?azdNRWVtbFh5WlE0TmFzWVMrZzhDK2luRGwrK2diYUxsUFdBYTdXYmRDWTdo?=
 =?utf-8?B?NWh4VFdlbU1YVGdLSlpuK0JJV0M5bTZkV1EwalVPQVJ1eFA2TkZrYkRlWGJI?=
 =?utf-8?B?YUdBNVFMdm0vOHE5MERHNHVSTEE4ZG1KWXJLZkRNbHA1ZWpuRm0zaHUyMFRw?=
 =?utf-8?B?eFR1WUJ5YXZIMDhOUmJxM3VxelhyaWZKdlJzSURuMnIzaHljS0ptZTFJcXND?=
 =?utf-8?B?alBMdVBRSnltZFUzMGtUZnNpeVFyaHVpdnJOOTdKVEhyeTBQT2MrNnArUWds?=
 =?utf-8?B?Y2c1eUxnVC91NWZjdGw3dWhLRFJ1OHQvcmxDdTYyRHNQUXNISkJEOXBmYWdw?=
 =?utf-8?B?ZlF1SGtFMDVEaDJlb2N3M2E0N1Z0M1FZd1RvN1VVSFVkVTFzdm4wR3hWcHNT?=
 =?utf-8?B?L0JiWFdRV2RIY01SaXNzN3hTMVkvNVozOThZK3lDUWlwN081Z0R0U3dhNG42?=
 =?utf-8?B?Y1FLM3J3T2Y3M0NqMnJIMm5tYk5rWmQ5MmFuQis0RHp3S0E1QjZpVmtKc1Er?=
 =?utf-8?B?a2pXcG1TUXhXeXNMOTdUbi9NalJXM2FFeE84NVc1dmFuZUx6a29zYUdaK0t5?=
 =?utf-8?B?bzFBQ0t2Yk5Zc1gvVXdJbDJkK0pDdGpObEUwN1NVRk94eE9LcHgzUDRnZEhO?=
 =?utf-8?B?ZFlIV1REYWdCUnJ0OHpaMVlTN0tWYjZsRHJrU0FkemFoMTl5NVpQMFhWL3g2?=
 =?utf-8?B?RmdjVVJvb0h2NmVQYW12RFNXbkcvbUh0Qk1XR3hlam5EVFFXODAyL1M4WFFo?=
 =?utf-8?B?c0JLRWQ2a3g2bWNoZCtURC8rSU02akdGSjFseTYwSXloVFFEL2tZb0d0VGJJ?=
 =?utf-8?B?N0JSbHBOeGp4WnVib3VEU2VTMWZpTkFXWXdlWFNlWWVSTGdUSUF2a2p2SlZj?=
 =?utf-8?B?enRVaWFFRlc3ejBSVHRLTTdGNk11YXovTUtTYTBPK0tTZUdCbUs1ejlid3Bs?=
 =?utf-8?B?WGFjcDRwVWJlZXk2d2lPaXlCaDYwUVg4Y0hPV0FmWWdROGxqdVo5WGhMbUJx?=
 =?utf-8?B?Q0tkRzBJdnhWTVVBYnZMQXVaaE5PbDMvY20rV09YUDM1RHA5UUxOWXU1TXlq?=
 =?utf-8?B?NkpIQ2JmYSs5U1hFa3Q2SmRzR2pBUWQ4T3BmajlPVFltSHhGeENkQmdMTlBG?=
 =?utf-8?B?K0hQNE5WeU5HcVVCU2RHZ21ncys5NDFIYTVRazh4NnVxT2VnTlZuZmppNWJz?=
 =?utf-8?B?NlE3akRRaHg3R0tvczJUck9rMHIvdkp1bXVkemtaWXovSklZZ250cWVsVGlT?=
 =?utf-8?B?Q1J1d05NSStWcjM2SkJMZVBScXVoTU9CWVBod3hGVE53b3hkSi9rNkhxWXhj?=
 =?utf-8?B?bEk5RnBjU092R3VhVThTWldYSVQyLzVEQXdYRXpFZmR1WU5LbWZYTDZPOEp6?=
 =?utf-8?B?ZGFneGxxL2xMcHV4NVRVTHhVU2MxWjBiRTBhcitKM3NVd2pRTUdlTEpnQU40?=
 =?utf-8?B?Ny9uZXhTRldPcFo3anN5anQ3c2VOQlhHdlZUT3dWRU01UEhPWXpwYTI3SzRT?=
 =?utf-8?Q?tfXT4s7mfiZFh5v8Dk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B27D6EBC71F3F649911A5A7D9826D1E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f9db28-cd7c-497e-b706-08d936d2fb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 05:43:23.9021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6XbjvUVihFz5Shwm/wMj1MZL5kHNT88EsrBjO8Y5o8fguNeqQP+V67eRhYyBPWYdhVpxJqktzPVLFysLc+OS/YQwhpu0ePx0aKNFdUicIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2710
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCkkgb2JzZXJ2ZWQgdGhlIHNlcmllcyBzdGF0dXMgaXMgdXBkYXRlZCB0byAn
RGVmZXJyZWQnIHN0YXRlIGluIHRoZSANCnBhdGNod29yayBsaW5rLiBTaW5jZSB0aGVyZSBhcmUg
bm8gY29tbWVudHMgaW4gcGF0Y2h3b3JrLCBzbyBJIGp1c3QgDQp3YW50ZWQgdG8gY29uZmlybSBp
ZiBhbnl0aGluZyBpcyBuZWVkZWQgZnJvbSBtZS4NCg0KDQpSZWdhcmRzLA0KDQpBamF5DQo=
