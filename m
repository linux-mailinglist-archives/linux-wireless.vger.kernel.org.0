Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09B13F988C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbhH0LyI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 07:54:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:64571 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhH0LyH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 07:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630065199; x=1661601199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GTm+hvLjg+wjnJJvvrIZg7tXHNKmfu0nLpTysL133W0=;
  b=gddqR6s0M26t91MKfLGPqMDRvCSwQgmaoz0TxBL9GRC8RAOV4G1ZXP54
   PNMKeTUGkbMAQ5j9xNCtq1z1rpiqePsrdo2XfdHtDXLx8uoX88fpgwJ27
   0J8zwM2k50BNZFThOT/jsrfNVy+Rno87RRA4f94vZcA8R9xl5uCkLFZaY
   s4N8rzQr+/9BrzsDdxvWPy4axdYdeWKTzOaKkniVkQVJtHlSsMr6M99Nv
   n3n3XEhTgtnv84G8TKfhj/wxW2I7p7R9ym2WVPVAclkztYm3q/cf044Zz
   cMIBLIDFL2GALB11qwF6SmY0MdfpaylalF1YbpEw8lJR7e7CSzvdPPUbe
   w==;
IronPort-SDR: /W+X4FykTDRtUSosnqqNVfpHmOlIv70zub7/jstaqLGvBpcUW0fm1JUpHdSTxAYdNKZq6ppN0w
 ZX3HYCPD3uxsvVI6WrUF3K7GWmp13jHn9GfX/e4tXCBJRqj2uGttQ1zVnopwuwxwaQGapvN//z
 KjTGsyjzzfLIC253Pc2bXTYDbxfvjZsmGSqQN9QwEOfXe69vbWiTMyHIsAhsrIY3btH/+XSRYT
 idDnL3icPjlQV1W8frq7R2OZTzUkdu5CxJQuzBwY2pyyomCaYjYjmOORcV1RBxsOVi+zp+P8wm
 5AFuiWCMnbz1tc6qQF4nmdPO
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="141840999"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Aug 2021 04:53:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 27 Aug 2021 04:53:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Fri, 27 Aug 2021 04:53:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxq8OzL1pBLbVz7KsphaUnax/MJ/0Y55KwZgy25Ei68aX3jPzXt1PXoL1mlGnC7Hc+iSSjuglvvMzsFW794VD4RWI64h8E7IFhUMJYTfDZeKjB3dSukNiC59Mx60+pfwZrj2yIhWG0tRdT5mHhFy6YE7S62z0lp8p9c6IHXRA6z+ecdlWSgFFnewuWAsZpC+UmrAb2FlppLQT3IPdXyXSj6vl3A2zfCfCAzF8Kcd6tQ1JPrtqLox6VQBY57VdOJXILhg1L9/w+8/hN4p3dR/qKRti3FeoSzY8M4lBp5v9i9qrlZcLSnes9/tIifsSLt55Vk/Ogp9hGr2KHkA61ZyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTm+hvLjg+wjnJJvvrIZg7tXHNKmfu0nLpTysL133W0=;
 b=csfWK97DPfNsyv5mGkFzXee7L3lZmngiK3ycWl4aaH0OteR6OfY7SfZM6UNl2JfoHgd4cvSIUZVdd6/11fYfS7XT8GBeKxvWHlmbIGHHNpvkFoMnWn1CnmNmh5NchvXipw8/Y1lD5RMCiwYA9tvCc+LZhaHiYy3UNSCCC0ALFDwLi1su0DvCVuClhqjy6t44esvlu02X493cCjF2D9ev9OANxTsyXBb3ZVY5cbaILV68Ss6xTBXkoCjo8w+xmWZpECSUDHScW2kZESgkArF6ddzWsRh6m7djRNixKoBsKfPWea1FvUeOH1tUY0LUrgNkTpNxzKRM++ymnvPPQXCkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTm+hvLjg+wjnJJvvrIZg7tXHNKmfu0nLpTysL133W0=;
 b=DlbzzZYCkryMOjJB8P/da89EXLQREYMbH29SozqjfzoambMW+cmyN4M88/7EZMHlYgqXzP8TJaq1CEZE1jjMRb9peO1tlaLaZRHAV+vY3H0paZCx45janrlKj5owjx1IJ6c1gX7c37svAV2bFG2EmOkehH6OlDkpbCxuyUUx+9Y=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3045.namprd11.prod.outlook.com (2603:10b6:a03:88::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 11:53:16 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%4]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 11:53:16 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>, <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] wilc1000: Convert module-global "isinit" to
 device-specific variable
Thread-Topic: [PATCH] wilc1000: Convert module-global "isinit" to
 device-specific variable
Thread-Index: AQHXmrazjnhzTwfpNEymPaFd9DL+sKuHPs+A
Date:   Fri, 27 Aug 2021 11:53:16 +0000
Message-ID: <07ae5c5e-491a-2706-a368-7efcbb409ce9@microchip.com>
References: <20210826201127.2909616-1-davidm@egauge.net>
In-Reply-To: <20210826201127.2909616-1-davidm@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: egauge.net; dkim=none (message not signed)
 header.d=none;egauge.net; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92715144-5b84-4e0a-54be-08d9695141b5
x-ms-traffictypediagnostic: BYAPR11MB3045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB30452A068D7655028EBBF455E3C89@BYAPR11MB3045.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O9ixNu6TdjNHktEoH8EO1w0M/jmPqrfnpxFXvIb3vptbEEV9sfL2dlQKdQXc8VcFwyW3OH9S5FF6TSedXDtMIY35jITJ0XHFxTFxXMHNgOcnLruGZoBnXVPFQX76ZKI4dYcizi53t2uEeAGcadFkXf+2ww9nnP0AWSzlYPBzQT+swSPsNnCn1/SeXW3i/0RO/lXo7muRBEsfjdq4sYmPIK4xT8X7psTc3vMf8k+JbXIh5GiRpR3y9tgPzYQbnUzTdsyzw1wCMzPnBXYK36qbBZMSKP1FKOWaO4W6Zjrsk1sb2lKo3VkpjY+ykl0nDOVPuSg8bIU04SePB8g+0YjulFVUAqFx0O/ThwQ65KPkTyMZfvb5yOGRhWyiEaVuNdykn7gdmtEEDAmYPPPZldRGjNxZZ6p/xgX6kYFlc5d7RgWocWj1bh4EIxMp7/ASDCKDm7AwxmqvnlD4XW1uwotUssJarOBW1qhdysI59k7c7cqDQOevzAieIUY0KKZxjZI9E1NggBsIg9oF5m59B1VBtXKVxrr9GoZPMMyeMDQiTT3r9VZYIO4ux4WKKGerr4Agg1z1bdT+EGuQnpfkaYO4kYb7/KXNpH3ePl30+tsbR+GDyHWbGx+D8RikDz5YitQxrl4I1uad+4DQmhuIeJ4w/XhP4/ir0GRO2+wZzMJW9n1T184tD4p/ietmduiWUPiQVQJ0DMlzqwu6b0Yyitl1AJKNzyCW/AN1QioLqdiPgwHHGI2yhREtUWQPAI4nwWQjlwk8LfM2n1UhK67eeUM5FGTpZIhW5kBxz3q2uW4RYNDyhub4qk0DLRHwNhS6Dd0D08IBFkDPJED6Mxjq4jnUmtfaHmzlJUwRMcJcdHBgpYE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(110136005)(36756003)(83380400001)(2906002)(122000001)(91956017)(38070700005)(76116006)(66476007)(66556008)(6506007)(8676002)(53546011)(66446008)(478600001)(66946007)(71200400001)(186003)(86362001)(8936002)(26005)(107886003)(316002)(6486002)(31696002)(31686004)(2616005)(64756008)(38100700002)(966005)(4326008)(6512007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ai94YUlSUjBQbjdMWGRoT2RNaWpQd01xL1hxQ0pKWXl0MDFVMkoxbTdZWEM2?=
 =?utf-8?B?aW80OEhjR0tUbXBBcTNwbGo2T000b2Q4enNQNTkxOUpDR0pvUWVkMnc3Y1Fq?=
 =?utf-8?B?UEw1MER5aDJpcDRDVmtJWmFMaVF6dXh0VmNDTHVqS0NFUDlFZ3k3TjVMTkhN?=
 =?utf-8?B?YmE3UFZ1dVdsZkUvcC9iUHFhazRZWEczUlc1aTBZYWF4NHBnNHJ3RTNHaVBn?=
 =?utf-8?B?ZU80d0M2TzEwY3UvUktsZ0ZZZDB0WTg4QkJJSWFIditaYTFpdDExaGJjNzEy?=
 =?utf-8?B?NlY4ellDT1JxUUZxM2RrbFhLOHovYlFqTm5ycVdESnBKTnU3cnNHdWlFQk51?=
 =?utf-8?B?cjJMMjVLSEpnWHZWVzVaWTdvUGZBQWlnY1ZPcUQvTUs2ejJTTWJLeiszZlFP?=
 =?utf-8?B?aDlrQXhWdDVlQldWL0wzN25PRUFmZzJiaGk0K2xyY3BhamVrMnRjdUxmNjBG?=
 =?utf-8?B?M2dzYmNTc1dxQUZGSG9zckhWd3J4WGlXdVB2WHFSYzNMdEZBS2NxSktUU2Zv?=
 =?utf-8?B?d1gwb0VIVWZFNFZZMDJ2ZG1uNTVIaEsvVFFlWUNKY2tySTl4cjljaS9keWFT?=
 =?utf-8?B?Y2xpUnFnQTFsK0dOZlhZM1oyWGFBempSczAvNENvMXlLckordjc4eWV4Z0J5?=
 =?utf-8?B?Nm1lQkRSTXZlS3ZmWldIaXhENC9pblA0NHFXRm96OThFSWMwcU83QVRNUlRH?=
 =?utf-8?B?RTNaemZRellMdHAxZUp4eWRXL0txdk1pVWJocEkvUjBNNnBDOVRoNXVtTGlu?=
 =?utf-8?B?c2R5L3U2VVdJeU84cFBQM3NEZk4yazhaMmVWMm1McklUQWFCMkNHdmxKaGZM?=
 =?utf-8?B?V2EyYTZyQ3NmRzErNjVublBoSk8zeFpIc2x2clpJajVmODRMMkhkQUhqcncx?=
 =?utf-8?B?ckF6Wi9xYTlkZSt4c3hDRy9mc2FjS3hrTm9tUzFzM2tWOHZhR0F5TWN3UWJM?=
 =?utf-8?B?VjNWMWF6MkJ4SEdEMElTNnFZdThqU2QreWJ2VUFOWnd3U28xay9CRk95ZStJ?=
 =?utf-8?B?TWlXQjljOTR0OFR5Vmp4STZYMTJCK1VncnFrTkVGZmtMbFlnMkp5eXZ2bHNR?=
 =?utf-8?B?VmtFRWZnMmNQN3U3bVFUYTF0UEFEcWR1SisrMnprMjJFb0dNVW90a2hBc1BC?=
 =?utf-8?B?VExXYU00bFYvU1UxQjlUNXpWai9BZjhucEFCdXZIKzFBWnhOZjFJb0VzN25y?=
 =?utf-8?B?ZGFXTGhsVk5WTHVDeGJnMDdmcEZrVkJxbXRheStiM3NmdkY5NnIwUFlBakRj?=
 =?utf-8?B?ZzZtZkt1dnd0eDQ3OEFocVJ6UGxlUjZwQkxhS2QzbW41dlhBZlQrT1JxbFYx?=
 =?utf-8?B?NUlPeVJEWUk4QVY5eTNRQnVQNjNTd3B4RGJMMWVwTE9RZERNbCtIN0NjT0d1?=
 =?utf-8?B?a0FMMGdPTVYvQ1hob25xdkNqSTdnZU9ZMjhMaUd2RXc4OWs3V1l3cHZyWXY0?=
 =?utf-8?B?SjJGby9MaURjd2o5bXEva05KMDZzSlRlaXFDQTV1amw0UVdyUnkrbmhNeEw1?=
 =?utf-8?B?NjZNanBoSURiZUpiUkJ4Z1hKVDE4dnRDL1h3c3hNTk1NWEZETkJITGNvSEJR?=
 =?utf-8?B?WUdROE93U2daNEpKSHBOaTVvajhMQnFwc3ZwYUhHZDlESGpwb0FUTi85UUdX?=
 =?utf-8?B?T1o5TEs1ZTBpckZSZDduemNLV0xPdStTNmh5WGdMZnh3cFZocHpNQ2F1OCtS?=
 =?utf-8?B?by8rQjZBWk9jTlVhdGFVaXY0aXhKMXZyMXdFakE1TjA2clhzTnZ6QkxBbzkx?=
 =?utf-8?Q?cDqfQ95hdPdM9p82bU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9B03B451E52B74B997194FD51547A95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92715144-5b84-4e0a-54be-08d9695141b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 11:53:16.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMyt8ULCl9GYmtp2AMbk4jDZm6cS8osKtSRz2jJI+B7ogxjqUKBmzaHy7Ex0Gh4xTazueus2XBMk0wFCCr6HjlkNlc2oElA4Mzb5/d4gQjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3045
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGF2aWQsDQoNCg0KT24gMjcvMDgvMjEgMTo0MiBhbSwgRGF2aWQgTW9zYmVyZ2VyLVRhbmcg
d3JvdGU6DQoNCg0KVGhlIGNvZGUgY2hhbmdlcyBsb29rIG9rYXkgYnV0IHRoZSBjb21taXQgZGVz
Y3JpcHRpb24gaXMgbWlzc2luZy4gUGxlYXNlIA0KYWRkIHRoZSBhcHByb3ByaWF0ZSBjb21taXQg
ZGVzY3JpcHRpb24uDQoNCkJ0dywgSSB0b28gaGFkIHN1Ym1pdHRlZCBvbmUgcGF0Y2hbMV0gdG8g
YXZvaWQgdXNlIG9mIHRoZSBzdGF0aWMgDQp2YXJpYWJsZShpc2luaXQpIGluIHBhdGNoIHNlcmll
cyBbMl0gYnV0IEkgc3RpbGwgaGF2ZSB0byByZXN1Ym1pdCB0aGUgDQpzZXJpZXMgYWZ0ZXIgc29t
ZSByZXdvcmsuIEFzIHlvdXIgcGF0Y2ggaGFzIGxhbmRlZCBmaXJzdCBzbyBJIHdpbGwgDQpyZWFs
aWduIG15IFYyIHNlcmllcyBvbiB0b3Agb2YgeW91ciBwYXRjaC4NCg0KDQpSZWdhcmRzLA0KDQpB
amF5DQoNCg0KWzFdIA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4
LXdpcmVsZXNzL3BhdGNoLzIwMjEwNDIzMTgyOTI1LjU4NjUtMTAtYWpheS5rYXRoYXRAbWljcm9j
aGlwLmNvbS8NCg0KWzJdLiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC13aXJl
bGVzcy9tc2cyMTAyNzguaHRtbA0KDQoNCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTW9zYmVyZ2Vy
LVRhbmcgPGRhdmlkbUBlZ2F1Z2UubmV0Pg0KPiAtLS0NCj4gICBkcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvc3BpLmMgfCAxNSArKysrKysrKy0tLS0tLS0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jDQo+IGluZGV4IDhiMTgw
YzI5ZDY4Mi4uZGQ0ODFkYzBiNWNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvc3BpLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jDQo+IEBAIC0zOSw2ICszOSw3IEBAIE1PRFVMRV9QQVJN
X0RFU0MoZW5hYmxlX2NyYzE2LA0KPiAgICNkZWZpbmUgV0lMQ19TUElfUlNQX0hEUl9FWFRSQV9E
QVRBICAgIDgNCj4NCj4gICBzdHJ1Y3Qgd2lsY19zcGkgew0KPiArICAgICAgIGJvb2wgaXNpbml0
OyAgICAgICAgICAgIC8qIHRydWUgaWYgU1BJIHByb3RvY29sIGhhcyBiZWVuIGNvbmZpZ3VyZWQg
Ki8NCj4gICAgICAgICAgYm9vbCBwcm9iaW5nX2NyYzsgICAgICAgLyogdHJ1ZSBpZiB3ZSdyZSBw
cm9iaW5nIGNoaXAncyBDUkMgY29uZmlnICovDQo+ICAgICAgICAgIGJvb2wgY3JjN19lbmFibGVk
OyAgICAgIC8qIHRydWUgaWYgY3JjNyBpcyBjdXJyZW50bHkgZW5hYmxlZCAqLw0KPiAgICAgICAg
ICBib29sIGNyYzE2X2VuYWJsZWQ7ICAgICAvKiB0cnVlIGlmIGNyYzE2IGlzIGN1cnJlbnRseSBl
bmFibGVkICovDQo+IEBAIC05MDgsMTUgKzkwOSwxNSBAQCBzdGF0aWMgaW50IHdpbGNfc3BpX2lu
aXQoc3RydWN0IHdpbGMgKndpbGMsIGJvb2wgcmVzdW1lKQ0KPiAgICAgICAgICBzdHJ1Y3Qgd2ls
Y19zcGkgKnNwaV9wcml2ID0gd2lsYy0+YnVzX2RhdGE7DQo+ICAgICAgICAgIHUzMiByZWc7DQo+
ICAgICAgICAgIHUzMiBjaGlwaWQ7DQo+IC0gICAgICAgc3RhdGljIGludCBpc2luaXQ7DQo+ICAg
ICAgICAgIGludCByZXQsIGk7DQo+DQo+IC0gICAgICAgaWYgKGlzaW5pdCkgew0KPiArICAgICAg
IGlmIChzcGlfcHJpdi0+aXNpbml0KSB7DQo+ICsgICAgICAgICAgICAgICAvKiBDb25maXJtIHdl
IGNhbiByZWFkIGNoaXBpZCByZWdpc3RlciB3aXRob3V0IGVycm9yOiAqLw0KPiAgICAgICAgICAg
ICAgICAgIHJldCA9IHdpbGNfc3BpX3JlYWRfcmVnKHdpbGMsIFdJTENfQ0hJUElELCAmY2hpcGlk
KTsNCj4gLSAgICAgICAgICAgICAgIGlmIChyZXQpDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
IGRldl9lcnIoJnNwaS0+ZGV2LCAiRmFpbCBjbWQgcmVhZCBjaGlwIGlkLi4uXG4iKTsNCj4gKyAg
ICAgICAgICAgICAgIGlmIChyZXQgPT0gMCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIDA7DQo+DQo+IC0gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgICAgICAg
ICAgZGV2X2Vycigmc3BpLT5kZXYsICJGYWlsIGNtZCByZWFkIGNoaXAgaWQuLi5cbiIpOw0KPiAg
ICAgICAgICB9DQo+DQo+ICAgICAgICAgIC8qDQo+IEBAIC05NzQsNyArOTc1LDcgQEAgc3RhdGlj
IGludCB3aWxjX3NwaV9pbml0KHN0cnVjdCB3aWxjICp3aWxjLCBib29sIHJlc3VtZSkNCj4gICAg
ICAgICAgc3BpX3ByaXYtPnByb2JpbmdfY3JjID0gZmFsc2U7DQo+DQo+ICAgICAgICAgIC8qDQo+
IC0gICAgICAgICogbWFrZSBzdXJlIGNhbiByZWFkIGJhY2sgY2hpcCBpZCBjb3JyZWN0bHkNCj4g
KyAgICAgICAgKiBtYWtlIHN1cmUgY2FuIHJlYWQgY2hpcCBpZCB3aXRob3V0IHByb3RvY29sIGVy
cm9yDQo+ICAgICAgICAgICAqLw0KPiAgICAgICAgICByZXQgPSB3aWxjX3NwaV9yZWFkX3JlZyh3
aWxjLCBXSUxDX0NISVBJRCwgJmNoaXBpZCk7DQo+ICAgICAgICAgIGlmIChyZXQpIHsNCj4gQEAg
LTk4Miw3ICs5ODMsNyBAQCBzdGF0aWMgaW50IHdpbGNfc3BpX2luaXQoc3RydWN0IHdpbGMgKndp
bGMsIGJvb2wgcmVzdW1lKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAg
ICAgIH0NCj4NCj4gLSAgICAgICBpc2luaXQgPSAxOw0KPiArICAgICAgIHNwaV9wcml2LT5pc2lu
aXQgPSB0cnVlOw0KPg0KPiAgICAgICAgICByZXR1cm4gMDsNCj4gICB9DQo+IC0tDQo+IDIuMjUu
MQ0KPg0KDQo=
