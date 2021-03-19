Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255C7342176
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCSQJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:09:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:9940 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSQJL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616170151; x=1647706151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lB2ufUYkcw8RMYeo2WJnGIyWd11vE20aPOhjP6EoVaA=;
  b=cm+wDtAfa+rCsuX30gqYD+tYe9lW0dfW6b+IPX1Ep+OZ6n37AkwoWNj2
   RtS0KIStPX/5QsAs9ZXUe8UCjjn7CcrHAfNKYShShYq46vwbWXKmpkJqs
   z9BK6X4J8kCHpbbDZByOgervWzs/qSeACuWJU/W/RM4wL2WoclaY5HupY
   5ZdgIxD2My4d6TQyjqsgWzUveKJqzn//t1+oWg9n4Mxgfv04DTutBfOO2
   thap3V/60m8Dkcxh0FuwgcvK/wX1kbGbJqD5gupTzRVXgkvM/w5X1Lu+Q
   ZlcS2PpNtWgiiYfvm5OP0NDQaTVdqkh2GIX//2SNP78KYXSwrsiJwfTTf
   w==;
IronPort-SDR: TTOPDNV2cbCP+WcLjB/dTBHihfQuTZwjPMbF/P84IftbfEsI2qXhDKyvJhoG/kF1GIJ6J2pXN/
 TVimVKV3qqVr1cO7mu/OXj4XXnJWVX8qLaDEHl9UWCAWn5z6L28ai+8hnBfSgsnFAvir70Dwzs
 QIwjHtxmra4yk3iB+hjbXWWGTjXZcLO8tBRTVG9n4Hd6oD6fs9vFLTjNdPGUu5xQEu9FuhF7Cu
 gJ2b42v4x84fuWPxspUClh4uLWPRG54gjws0H8evQuLS2cUtAPE3bYMLUorTaR+SHlkmFfHz+L
 VdA=
X-IronPort-AV: E=Sophos;i="5.81,262,1610434800"; 
   d="scan'208";a="113415183"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Mar 2021 09:09:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 19 Mar 2021 09:09:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 19 Mar 2021 09:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGt6GrRrWi0bttLyKxtMgeleka0F9QX0vxYkCpRiHqw70Um6/Qh4EYTJqfDkXqNqo3TwRWqX+Zi6/gE+dS4nhuTA/nMGK0J4rwH6WNRX7IHjXAexnr6g/ovJqAy+rjkNrX+y79kLWIwIhZo5zNW+tsWiJXriCWZEOVIQEFaLfFbcX7AE+ikOBi7kiTds5uvgekJ5Bg2lDK7WR1CXl2YgbKHIQ+SO6YRVpNDW8cSOwmZgYS8A6+RAEOn0fmRhCHz5O2P5asq7HOpVYieo/NMXv7uydwbQLgJqXBkElZyhFFvwHN2p8eXiAo6e49JF9UgnpBrIAw9+DwxRAJX5blBCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB2ufUYkcw8RMYeo2WJnGIyWd11vE20aPOhjP6EoVaA=;
 b=FadEenlg/qHgYGmPLABSGzp1lzSy84f33hIB/odvRyvjwheCUD8XhJihgqjwdLkt+VGi1iYSnNO5Vm8t58ejP+vs5smpetGPGA2xWRaiHhUq6TfsVjUB1pBOklEm2hzToxg9G7l60+Z+SUjy0CIxz5b9KwNIxGUlaAyQRQVPdoH1YTkac6aZiiDIfJSC41C4JqjdQ2Z6iDZbjOcy2wax/MNR8inMrZb5vwKvhvucc6H60E33I5DPpbkgR8VAiLq7MSNNZECAzu1GUc2sQoqvVNlPg4tfiuJYJqnM/ru06Nv1wGSYRirdS0gIqN+xF+BIc3Zi/l9te1GRvXr+X1vv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB2ufUYkcw8RMYeo2WJnGIyWd11vE20aPOhjP6EoVaA=;
 b=PkL76eXaXuVnQTLol6eVR4Jfw7gGzerULJu9SbG8zVmfhKDrrXueVHXnOlO4ihAU7USPa8qRGwVNiFIEddAr4lSYXWfgqvrIuEC8alMB8qOV92VPudAQj7V4zoO7vyKvh38hU0LkjBSePRlbEdzQYOA7Er7c3doRFskVg7mbVlg=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BY5PR11MB3943.namprd11.prod.outlook.com (2603:10b6:a03:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 16:09:05 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 16:09:05 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <Claudiu.Beznea@microchip.com>, <kvalo@codeaurora.org>,
        <davidm@egauge.net>, <linux-wireless@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] wilc1000: fix a loop timeout condition
Thread-Topic: [PATCH] wilc1000: fix a loop timeout condition
Thread-Index: AQHXHM7r7aiJxEGzHkG4ByzDuJ3eP6qLer8A
Date:   Fri, 19 Mar 2021 16:09:05 +0000
Message-ID: <cd087f6b-5f99-3bce-0015-ccf1a82625f2@microchip.com>
References: <YFS5gx/gi70zlIaO@mwanda>
In-Reply-To: <YFS5gx/gi70zlIaO@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [49.207.63.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 813d7b91-d878-49a5-0ade-08d8eaf151d4
x-ms-traffictypediagnostic: BY5PR11MB3943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3943AB58B2CEC2A3A80126C1E3689@BY5PR11MB3943.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUmetkIiVu/TpP1Z4wzdZl+GRwWHfMVC1DMwj0W0GCUIQHU8Gv+KhWOntR28JojeFVW9fYMxN53BQ8mhPGpVk6FutmKkK5weTDhj3jmnDHXYFhWIBcZnH0SV031eGaQCvBfpgTi7eo53orwxbdeU5M2cNjxhJj+bW2vA65a7cSmbF2pmk28VSzQM+6jeTYnhMNL3t2PhvbAv8Yh3L6GAzVa2Ex458i8FvKrq/WuSkxgWErkriRT2Muf0OowC8JIJGTHYQduLcfnid6AeR2W3/sR+Y8CcXAXCVlzyMovYf5GAfhetFqosx/1PB9nCB6od1D/E3LkfywqdccZZclZ13W/X/QV7DLjuk8Y1OtI2+E7A9LFuaO6kmkjgCNGxfMAvymvjY2qOyAl6J83f+VMJw9gDgV4PvQHZlTH/9xg2IcmTO6yTh2Ri8VehGrzh+8KaS+fVL1D5Ob3qgkp3OY+rB5r0BZW9EjOHmg/soVT3c1cl7Oy0eXprS088/19I/JSJdjPgmvc4pwjsuTohRmc1ZBW2PCx+4fEguN4SRRXK6ZpPaZHLncEAbl8KwZCB6MvLrA7cx/8Nz3l9Z+5mGurcewtrBhCmmLj3yK6U2GoqOn878mYOJCsolg3/ZO07VhEiKrOfWgUJERTwyzBL1H3nc7exZJ7L+afMKFHrBnVva+OLeiANsurB0EUeeNbK8ONMNDEk1icJ3008W6yy+hPyZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(376002)(396003)(8936002)(6512007)(83380400001)(66946007)(31686004)(64756008)(478600001)(6486002)(76116006)(26005)(8676002)(53546011)(55236004)(36756003)(31696002)(2906002)(86362001)(5660300002)(71200400001)(4326008)(66476007)(91956017)(66446008)(54906003)(6916009)(186003)(2616005)(316002)(66556008)(6506007)(38100700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ekhoOHB4dEZ4ZGozL0FyS0x2aTVIQ09pOFd1MmVmZVRFdk9GUXJUVURVUkUz?=
 =?utf-8?B?ekFJTDNQQlowRmMvLzd1Qk9xOXJYMXozUExkTkJHMU4rWTRyMjJvT21XOXBI?=
 =?utf-8?B?SVZKdXd2aW1qTUQ4TXVRTEF6VHl0dmtzaXZjd3pqTEszTGlZRUpzOW9LNFU3?=
 =?utf-8?B?OGJIUW4xNmhYQ1lOQ0QzeVlEQnA5V0RLbWZaVk5NMWtDS2M2czB2b21xbEFG?=
 =?utf-8?B?b0tTTnFLU0tNYUtYTjNvTHoxRnZUMzVtN0dCREhEbG82eVRIa1A0bDNMMzBj?=
 =?utf-8?B?VkRDNTJvUWVvTFRweUN4MGhKNkZCVGNvMlhlZGNOdzZkeVY2Mm1qdlVOOU0w?=
 =?utf-8?B?NDE5a0JlRjh3L1RhZ0xldGlHa3VWRnRVZE5qcW8yaFpha3AraUVFVmNWRjRL?=
 =?utf-8?B?YlJ1dTFRclFFL1hUUWFCdUU2ZDhrS2hVQThNTDQvR09XZitDR1B3dnFLZHN6?=
 =?utf-8?B?bldhZzR1b3FsbHd2ZnBuZ1RBVTRxSWZOZnBhNjB5WERWb041UEVrRTd6VHZJ?=
 =?utf-8?B?NDZ2K2NaRi9wV0VBci82TjJ3OEhVdllNVTF5QUFQUDlNSVp1aElNWE92Z216?=
 =?utf-8?B?RFdXUHJWK3pYV1IwTUJEa1Uza3ZCYmJUSGcwMGVJWHc2QWltZ3VSemR1SStV?=
 =?utf-8?B?NTNlaUgySnY5NUhTMk8vTWI1a0dTYysrbkwxMjcxaXpWdGFKMWtiMWNjM05X?=
 =?utf-8?B?Qk5iU1hOTGdBNXRsSVFBZUREZmtvUlk2TnJteVNpRFE4RHJXUXFTc2ZhWUJF?=
 =?utf-8?B?QlI5SUl2Umx4YlJ5MXFBQXlCT0FhMGU0dWlzTEVoaysxbGVlaEV1N05LVkJ6?=
 =?utf-8?B?SEQxZDlGOVZPSG0xRWFOdEladW5LaVMwdzJoaU1hS0JYcno1U0NGMi81aUtF?=
 =?utf-8?B?LytRV0RYNjZRTmxyMUZZNGhYcDVsNFhSWUN6Rld1eVdLTHJJOU5LUElObSs4?=
 =?utf-8?B?aERqUWEySG1EVDdrUFJVaHFZUEZUUXEyRkJ3ZEcrOGxYVGJXZjhpditTWFY3?=
 =?utf-8?B?alBWbG1qaE4ycEwwc21JWU1ibDNpQVZkbWIzdVV3dXQxeEZldjBNKzF0OHZM?=
 =?utf-8?B?eWRYejRuYzJhbEpMZVQwVFFZMFdDQWVYZk1lY2VYd2hsaXdRbmZpcFFqUmJE?=
 =?utf-8?B?eU5jY05EcXp6SHpoYmFqR1oySGRraFpRNGFET2s4RXN4VzBJbkQ4b0lUd3pT?=
 =?utf-8?B?V0p5b2pjR21OejdtQXZIUEtmRnp1R3hnMEYzc1gycTJGMmNuNGZnOEYzc01a?=
 =?utf-8?B?TVA2T0gxRnFBNFkrRFNJK2tnZXVVUTQ4REdTcnJEWHF2L2xwbFFoenI5WVNV?=
 =?utf-8?B?Y0RvellpaVRJVlZuQ1ErNUk0bE1PeW03QWg5U2pBNFpsS2hBY0diWHN6amVy?=
 =?utf-8?B?VFdyNGxhYmNDc2Y5UVlNNituaW5aRkpaWEJhVUw4OUJwc3NLN0xiRFlnOU9Z?=
 =?utf-8?B?b1lrbTBPc1FlNnk1MS9KT25WTGVvYkFaVlNrek1FdFVVaUpQdjB0Y2c1aHBP?=
 =?utf-8?B?R3hFOXVyWEsvL0R3SDQ1QmJ1a0txZjRHQm5OVVlHTTJwK1JVZFVhY0VPMmFD?=
 =?utf-8?B?MmpqeXdZWWpjMEkybWNIMUVZeExRUXBmOHdBZU81VllRVGlubC9PUDZicldD?=
 =?utf-8?B?SmNmUy9BeGpLR2FINW5ndHNUbm5jMktaV1ppNGtKUXFXeDk5NG5JbGRXSG1L?=
 =?utf-8?B?bE1pWFVPdGRJQjV5Z29haHY0SUxxZ2FxRUFYQU13L1BQTUpyNFRyNmduNzNR?=
 =?utf-8?Q?Lp//MUq5R+17bt+f7A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <539655535C6FCF43A1806AA31195A9EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813d7b91-d878-49a5-0ade-08d8eaf151d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 16:09:05.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0d6oW+14KtC62fTn3C9H5nL1pM+g1Xu18zj7gKCOndm7OHDaXHV2P3Nmr9CsCMkc+ApiNHK3uCCHltvOF/0wnIMam5MQXBOVywHuixuFzfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3943
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiAxOS8wMy8yMSA4OjE3IHBtLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiANCj4gSWYgdGhl
IGxvb3AgZmFpbHMsIHRoZSAid2hpbGUodHJpYWxzLS0pIHsiIGxvb3Agd2lsbCBleGl0IHdpdGgg
InRyaWFscyINCj4gc2V0IHRvIC0xLiAgVGhlIHRlc3QgZm9yIHRoYXQgZXhwZWN0cyBpdCB0byBl
bmQgd2l0aCAidHJpYWxzIiBzZXQgdG8gMA0KPiBzbyB0aGUgd2FybmluZyBtZXNzYWdlIHdpbGwg
bm90IGJlIHByaW50ZWQuDQo+IA0KPiBGaXggdGhpcyBieSBjaGFuZ2luZyBmcm9tIGEgcG9zdC1v
cCB0byBhIHByZS1vcC4gIFRoaXMgZG9lcyBtZWFuIHRoYXQNCj4gd2Ugb25seSBtYWtlIDk5IGF0
dGVtcHRzIGluc3RlYWQgb2YgMTAwIGJ1dCB0aGF0J3Mgb2theS4NCj4gDQo+IEZpeGVzOiBmMTM1
YTE1NzFhMDUgKCJ3aWxjMTAwMDogU3VwcG9ydCBjaGlwIHNsZWVwIG92ZXIgU1BJIikNCj4gU2ln
bmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KDQpU
aGFua3MgRGFuLg0KDQpBY2tlZC1ieTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlw
LmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAw
MC93bGFuLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2No
aXAvd2lsYzEwMDAvd2xhbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMx
MDAwL3dsYW4uYw0KPiBpbmRleCBkNGE5MGM0OTAwODQuLjIwMzBmYzdmNTNjYSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3dsYW4uYw0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5jDQo+IEBA
IC01NzUsNyArNTc1LDcgQEAgdm9pZCBjaGlwX2FsbG93X3NsZWVwKHN0cnVjdCB3aWxjICp3aWxj
KQ0KPiAgICAgICAgICAgICAgICAgdG9faG9zdF9mcm9tX2Z3X2JpdCA9IFdJTENfU1BJX0ZXX1RP
X0hPU1RfQklUOw0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgd2hpbGUgKHRyaWFscy0tKSB7
DQo+ICsgICAgICAgd2hpbGUgKC0tdHJpYWxzKSB7DQo+ICAgICAgICAgICAgICAgICByZXQgPSBo
aWZfZnVuYy0+aGlmX3JlYWRfcmVnKHdpbGMsIHRvX2hvc3RfZnJvbV9md19yZWcsICZyZWcpOw0K
PiAgICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuOw0KPiAtLQ0KPiAyLjMwLjINCj4gDQo=
