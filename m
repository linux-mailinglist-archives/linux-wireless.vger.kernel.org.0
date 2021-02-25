Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC03249E1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 05:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhBYEvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 23:51:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:13802 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbhBYEvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 23:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614228700; x=1645764700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6bXL0guE42xqKxZaiPVaJCKpUP0YthlVjyJvKuAirYI=;
  b=oBrJW1T6GwLxS5cMIU+zTjhIYgka+iMkAvtfeQgCMydnwh8JEC3Xlzqo
   PzSG4SJJyY0AHb9J2FKD9vt8Z19B2TahevKClfiUcgFtC+i6TajOCwwDE
   LSGnCXKiSFqj9ipT8S9Nl0Odts/rG20k6BrXIzwXJr+CQ8V0zXa6sgqi9
   NhrFROmv82mrlgbyMatxyNn2z+1a1Slta6P7i/9ypUrDbkkxy7PqLijaE
   Ui9mEwtYyr5th4eVHeQ9eHjGNODBu1txXAL7/BUULY0zwrYmdmH+yYY/A
   gPRrt/U9QoGXxHMbg1zxGOQ9506hrWq593Bl7Nbsa3HWh0vgVKqDQWw/M
   w==;
IronPort-SDR: ifcas2SuY6fNPJWv97lbWpAmfppE9wgb/GDAd4ihmyUK2audOvyOOoeq10EcyGmi5M8htRD50q
 pHmPvCKUK0KMWGI54VmBFl9LrL0W8jr5ucuaLN/lIeMxmpR6b1FO8rTcIossTZoNU97ILT5CI+
 vaGCdoY4Jxh+lCBA/aFX7ddYty4/vyMVXzeFFmfm1pvI+vDfDew8JIZMVn60ZHcEFGhFSHHF3l
 1ndkkNzcXVVl5JgdXbIQikjPn7+iuNpxW54z1eaxFo5Gj24f1zBt+TgwJ4y5SIU35mkx32LOiw
 hpk=
X-IronPort-AV: E=Sophos;i="5.81,203,1610434800"; 
   d="scan'208";a="45385686"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2021 21:50:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 21:50:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 24 Feb 2021 21:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbcdX+HZoFjOUyEMfyTYGLMG89CmybI/L/DadToBHTA0CZmBsT+I8sELRd+w7OTCD0XtCHEyMinG0pLVJkZawoZ/cMYB41SSSNc3biurC14HV9bg1aKnCMc2myreskOWx+gjtzwPrLQemlkaNpCll7+IB4ZkLy9wMceHh8kwve58O5oYMvdCxDOKms626Z4nlI5VlK8VeQela3NUdNiAAxSZ+3i9Lu7aIrqhlAZtoGQFSMx6I6tUutND8IuoUkTte184hXxJdjcF91G2zKU3J/94F0JaxvJMvnjZkNKxT+EdyinmsloF8t9RqoF16p8esiPenFpPs9YaDSEbkDN/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bXL0guE42xqKxZaiPVaJCKpUP0YthlVjyJvKuAirYI=;
 b=eKW2ECJy+iwagn+dWdQLPlLNveWu1g3AOFn2b4tpRU3OfY4JhKPL4TMEPFuh/h9UX6zHzNlVPR1pdHnJM9m1c/3Kphby5mvRYGRtM9gPjg6vLqpyg8mWfdk4YfEzBL/ILhJSMuaxVJMAKpbitCkWA/lurHAoHNFJNwPS8nvT90r22NSnoyKrE8gC/BkP0UtB2t4xyX6xb3Bx+4jZxI/vFKvwds2DOdo2CWP14nDaK8yNjJ0PFr/Y7O6rT06RgIBaWbuhyJg25yaZEwbhknWFWnIWlvuVDbH4wiDcJACXSjBWFWljbt7WbgmeLZGh6edqmOdVkIoNf59w6Q0K1sdhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bXL0guE42xqKxZaiPVaJCKpUP0YthlVjyJvKuAirYI=;
 b=ieUHC7fQjlmRbV0Om8ZNFMi5AClEo9ivSvzTKZpzB8CD10r2cY+1YrUoHIKAeCcekWdgD3efpqv2n9cfeuB8NMqDZCXf0FNta02omjsH7aAm7hhh0MykC3v3OhBLtTA3WA6+oQp2jjGr5d0KqjnHdi8wYOYKsK7rMPqI52u6lg4=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 25 Feb
 2021 04:50:23 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 04:50:23 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>, <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
Thread-Topic: [PATCH 4/4] wilc1000: Add support for enabling CRC
Thread-Index: AQHXCnEwZSbR0AsbwkSoOjOCksEYjKpnEzuAgABrPwCAANAWAA==
Date:   Thu, 25 Feb 2021 04:50:23 +0000
Message-ID: <08ce86f5-f11d-7398-a566-5ed0e989eef8@microchip.com>
References: <20210224055135.1509200-1-davidm@egauge.net>
 <20210224055135.1509200-4-davidm@egauge.net>
 <f58ec951-4ab4-2ed4-78d4-96ebb448f494@microchip.com>
 <de208903375a13c31717c668f83e71b3f0f9d6f5.camel@egauge.net>
In-Reply-To: <de208903375a13c31717c668f83e71b3f0f9d6f5.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: egauge.net; dkim=none (message not signed)
 header.d=none;egauge.net; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [106.51.110.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d887907f-02d2-4bf9-fc0c-08d8d948dca9
x-ms-traffictypediagnostic: BY5PR11MB4165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4165336A909091BFC14063C9E39E9@BY5PR11MB4165.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TloLAMUcjeJIsI8CD72G/87tobC+ub6U/DkqO1F+nn1976xfLSgLo9/wKmll4BJztldX466gtKuIY9sq829uDE200rkihyt7AcAQ2dBwxH+uB2k93q069tVJGE3e9LPvAXBD1xuk4NXoy8coi+Ptjn5VqOra1flwp11Ah16DWo2MygSyaCvCGdOtyN4XmEfMaoDnSmbL8q3sfYZpvF0YeBv4I0SsNlXKpuf327EsdY61hW6IADjtNwDvQ2zzdAlR99Rc1AWGG80ck2AL/m3ja3i+0EvRKBQ6ZFg+BS5X/TDNYwfeAHQQVlBtbbsWO/J/qr3SltAN/cIzzEPJdqPWBtkygo1vcOftM2I0dUaJQko/J11Ey+RVQwBZCJ9b+dhltTuLZyO7EAw2wJT2ghlP8382Hm+Y9xsmNP6MuHzlZ3Gwwe77mqEBK8rwEGQEBG3kP7z0G1nu5i7L9jyOczMjI7eIFw2UIdroxeGZMjH/AbQFxB84Dgc0pWbFWZeZZ3oeYj+sEvaJguVwKelD25CT87P4WIq/AigWeDsn7nLT+cFjig/kguJlL68P5V70kXehVLhH2LwjZpJbqybcwNMF20p3S1jftptBHlI/VMzbUf0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(366004)(2906002)(53546011)(66446008)(6506007)(66476007)(64756008)(36756003)(316002)(86362001)(83380400001)(5660300002)(107886003)(186003)(66556008)(110136005)(76116006)(66946007)(2616005)(71200400001)(6512007)(4326008)(6486002)(26005)(91956017)(31696002)(8676002)(55236004)(8936002)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K1QzK0thVU9wWW5paFVuRnlyWXhIcjh4MDV2OGxLcXBGczlXaUVDc0w3NE5p?=
 =?utf-8?B?WUlJblJpeHdUNzlKZit0MTVLek1LNDBsaUtVMlpDTWw5RllYNWRma1p4bFEv?=
 =?utf-8?B?azcweGRoM04yRkVsWlRUQ05wNFlRVmk2b1NyQlRpVGdKbW1hVUJoeE5Kbkhh?=
 =?utf-8?B?ek5VN3VlemRCSklNcHBUS29sR24yTXU4QUh1NG1Lei80aVo0cTJpSDRUcE11?=
 =?utf-8?B?V1BiYm5XdDA4S2ExNlpmQ1NGbzVtN1gwMkxhQ2d6TXVvOW9OWFVwME5iaHZm?=
 =?utf-8?B?K2FHY0tnSWNhT1dSZ09NM3dPSnlQYTRlM1F3RFE1MGNYM3p3TEtoYXFlMXRB?=
 =?utf-8?B?SU4zcEdBcDIwMWJlNnVSOUpya2xVYm1wODhsNWZ4ZG91MndqcFp6dXd0U01Z?=
 =?utf-8?B?UlBwSDJBQWQreldhRkFYdytEd1JkcDgwd0dieWZCWlhLc2pVTXB2VUFWMnhv?=
 =?utf-8?B?a1U0ZWIvdEVCZGdZMlVJaTJNNUN0a0JXWVlxM0NROEI2eTQ4RlZZa3N6T2t2?=
 =?utf-8?B?bmZCdFlpZGNvT1E5UHlReW9BUWlJZ2ZUUGFIOGNRaEF3czJJQWVVejBaUDlK?=
 =?utf-8?B?Z2NGMVNtYzl5M3pOZEVZZUpHTUxvWVB0dmNCcVkvZThBSklMN1VMT1hDM01l?=
 =?utf-8?B?RFUvTHQxLzlaV0c2bE5WVjU5Z1B5L21iNEt0ZUR2UUE2ZmV4S2dnMmxCSzJa?=
 =?utf-8?B?NVBzeTVIQ1RjRjhaYS9MZTJwem5NUHhkVmcxUDBqTUQ4RVRMd3lld0VrN055?=
 =?utf-8?B?N0plZ2JRa1doMWNuNjQrUmR4a1VRdEtpYkhCRHFMWGpzTExxY1V1T1VkMC90?=
 =?utf-8?B?TWFtOHdkTG5VRFVFTjlFcklVQ0E4RTZaRkY4WnVyNzAvMGRoYUlVNkczcUJ4?=
 =?utf-8?B?dHFadEZxeE5WN3BjNmJjSmI1SHVSNVhkY08xMm5FWVdQcDd2dXYyelpUYURz?=
 =?utf-8?B?dWxBYWNPN292eFRDeHAzcUp1MVFQNFE3SU5hdDYwOXRSKzQ4eU10elNEVVFZ?=
 =?utf-8?B?MlZMRmVJN2VhejlPdlkzVUJ5RkpZRmF0b0pIbDFJNUlkZWRaQTF0TWkycW5R?=
 =?utf-8?B?RlJvbFFNUm5uVTB6V25yZHBadGdyeXg5aDBhK3ZMMjc1WWhXUm1ZWjZUOFdG?=
 =?utf-8?B?eHlRZ2UySjUrVGhvVFFqa0pJR1N1ZVFvZHNINVJGL1YydVRHYkRYMFZCWW1W?=
 =?utf-8?B?VWpOcUdUMW90dzdqNFprQ2JMdkdKWUowWkRCM1RPMkIxZkpuSWZjVWM0ZUxx?=
 =?utf-8?B?RjloblJoNUE3RU5IOHRKbVRuVEQ4WUpDNVVhUTZkbXUzbkVYelQ0Y2NHS09J?=
 =?utf-8?B?cGIzb2lSYmdsN3ZzMURTNmtxR2lSNUlCUVhZbmZ2NTZ6K0xPa0NhdWtQRmFo?=
 =?utf-8?B?ajNyaVRaVEZnV2VycEJWVUcydWovLzg2R1gxNHozZnozR3lISWJVNGhmelAr?=
 =?utf-8?B?bGlxZldZYkw1elZLait4NEVkcGJ3cUhBY0JjSlBGeGhETytoTkVUVDd2bjRv?=
 =?utf-8?B?TGNuQ1cxWjBhVGVQOVJTRkVnTjIwS3Q3WE9ldWVCZm1xRnEyZGVsME1LU0NC?=
 =?utf-8?B?bzIzNEZJZVdTRHd6YzlaOHZlaUxzTmtQeUFLb1N4ZHBFaUJNYnc0U3piMWo3?=
 =?utf-8?B?TDJRSmYxS0hFRmVnMnN3Z1JWSi95NXZvVGtZVlhhU2Z6VkpRZUFNT0tjRnV5?=
 =?utf-8?B?aXd1cWhyVjJkcWc3SFkyYkpMTXpWd3hpNGI5b1pBNVV2QTdCSGN6azJvamlN?=
 =?utf-8?Q?uB0oOtMB3ZtNxLgF9DG9JppHPQ64Bpdv3/lNV0E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CCA2342B3DA774CA26E946A30224C05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d887907f-02d2-4bf9-fc0c-08d8d948dca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 04:50:23.5178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jGEbqm7ZW9L7gF4dsdU1V6/JkdpF4FoXe+jY6xGb39ictDYOkv0wyOzQaZ43lYz7qz07ISAuo65ysDlOT6G3FS2qUsuxffSyKrc3zWJDdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4165
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDI0LzAyLzIxIDk6NTUgcG0sIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgMjAyMS0wMi0y
NCBhdCAxMDowMSArMDAwMCwgQWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gDQo+
PiBUaGlzIHBhdGNoIHNlcmllcyBhbHNvIGxvb2tzIG9rYXkgdG8gbWUuIEkganVzdCBoYXZlIG9u
ZSBpbnB1dCB3aGljaCBpcw0KPj4gY2FwdHVyZWQgYmVsb3cuDQo+Pg0KPj4gV2UgbmVlZCB0byBk
aXNhYmxlIGJvdGggY3JjNyBhbmQgY3JjMTYgd2hpbGUgcmV0cnlpbmcgb24gZmFpbHVyZSBhdHRl
bXB0DQo+PiBieSBhZGRpbmcgYmVsb3cgbGluZQ0KPj4NCj4+IHNwaV9wcml2LT5jcmMxNl9lbmFi
bGVkID0gZmFsc2U7DQo+IA0KPiBBaCwgeW91J3JlIHJpZ2h0LiAgV2UgY2FuIGFsd2F5cyBwcm9i
ZSB3aXRoIENSQzE2IG9mZiBzaW5jZSB0aGUgY2hpcA0KPiByZXR1cm5zIHZhbGlkIHJlZ2lzdGVy
IGRhdGEgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIGNyYzE2X2VuYWJsZWQgaXMNCj4gdHJ1ZSBvciBm
YWxzZS4gIEknbSB0aGlua2luZyBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiANCj4gICAgICAgICBz
cGlfcHJpdi0+Y3JjMTZfZW5hYmxlZCA9IGZhbHNlOyAvLyBpZ25vcmUgQ1JDMTYgZHVyaW5nIENS
Qy0NCj4gZGV0ZWN0aW9uDQo+ICAgICAgICAgZm9yIChjcmM3ID0gMTsgY3JjNyA+PSAwOyAtLWNy
YzcpIHsNCg0KDQpJdHMgYmV0dGVyIHRvIGZpcnN0IHRyeSB3aXRoIGNyYzcgZGlzYWJsZSBhbmQg
dGhlbiB3aXRoIGVuYWJsZSBiZWNhdXNlDQpvdXIgZGVmYXVsdCBjb25maWd1cmF0aW9uIGhhcyBi
b3RoIGRpc2FibGVkIHNvIGl0IHdpbGwgcmV0dXJuIHN1Y2Nlc3MNCmltbWVkaWF0bHkgb24gcmVh
dHRlbXB0IGZvciBkZWZhdWx0IGNvbmZpZ3VyYXRpb24uDQoNCglmb3IgKGNyYzcgPSAwOyBjcmM3
IDw9IDE7ICsrY3JjNykgew0KDQoNCj4gICAgICAgICAgICAgICAgIHNwaV9wcml2LT5jcmM3X2Vu
YWJsZWQgPSBjcmM3Ow0KPiAgICAgICAgICAgICAgICAgcmV0ID0gc3BpX2ludGVybmFsX3JlYWQo
d2lsYywgV0lMQ19TUElfUFJPVE9DT0xfT0ZGU0VULA0KPiAmcmVnKTsNCj4gICAgICAgICAgICAg
ICAgIGlmIChyZXQgPT0gMCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAg
ICAgICAgfQ0KPiAgICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIo
JnNwaS0+ZGV2LCAiRmFpbGVkIHdpdGggYWxsIHBvc3NpYmxlIENSQw0KPiBzZXR0aW5ncy5cbiIp
Ow0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICB9DQo+IA0KPj4gQnkg
ZGVmYXVsdCB0aGUgQ1JDIGNoZWNrcyBhcmUgZGlzYWJsZWQsIHNvIGlmIHRoZSBrZXJuZWwgbW9k
dWxlIGlzDQo+PiByZWxvYWRlZCBpdCBzaG91bGQgcmVhdHRlbXB0IHdpdGggYm90aCBkaXNhYmxl
ZC4NCj4gDQo+IEFyZSB5b3Ugc3VyZSBhYm91dCB0aGF0PyAgTXkgdGVzdCBkZXZpY2VzIHJlc2V0
cyBpbnRvOg0KPiANCj4gIFBST1RPQ09MX1JFRyA9IDB4MmUNCj4gPiB3aGljaCBzaG91bGQgYmUg
Q1JDNyBhbmQgQ1JDMTYgb24sIHJpZ2h0Pw0KDQoNClRoZSB3b3JrYXJvdW5kIHdhcyBhZGRlZCBm
b3Igc2NlbmFyaW8gd2hlbiBrZXJuZWwgbW9kdWxlIGlzIGxvYWRlZA0Kd2l0aG91dCBDUkMgZW5h
YmxlZCBpbiBXSUxDMTAwMCBjaGlwLiBUaGUgc2NlbmFyaW8gd2FzIG9ic2VydmVkIGR1cmluZw0K
dGhlIGtlcm5lbCBtb2R1bGUgdW5sb2FkKHJtbW9kKSB0aGVuIHJlbG9hZChpbnNtb2QvbW9kcHJv
YmUpLiBNb3N0bHkgdGhlDQpkcml2ZXIgd2lsbCByZWFkIHdpdGggQ1JDIE9OIGJ1dCBpZiBpdCBm
YWlscyB0aGVuIHJlYWQgYXR0ZW1wdCBzaG91bGQgYmUNCnRyaWVkIHdpdGggQ1JDIE9GRi4NCg0K
DQpSZWdhcmRzLA0KQWpheQ0K
