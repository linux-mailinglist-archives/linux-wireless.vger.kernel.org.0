Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83D33239EF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 10:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbhBXJxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 04:53:45 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18018 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhBXJxB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 04:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614160379; x=1645696379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3/pWFu8DbYND77iXfpUdeWbTK7accm0rWm1H7nx6+Ok=;
  b=Ujcjb68f/kdVVd9Sf2QilA1KtBKLyGqqhqAKzE3yGO5ml5HNV5q0fEho
   s/aOceIdTnn9jHJsitMXUQndLLJUtkNfH/xg9NC8DSly7kEevdbJMbrRh
   VP3iDm83MESh3RBy1YgmOU10j5zqPLYE1mq+hPLyBTSG5nZBoSTmCft/O
   TjW3fzYlmdrrw0fQUyO36IOxNEC3nGxOis2/ThyjY8MveGKxySxRhS+iw
   iuq7Ic6QVFWVzeg4TxkdvKaKJ66cENYcdUEicLmPL7fasoBV34UO2Wmdz
   dV9mJYREnibIc6cdoRA1cu/wvdZrh2LLA2QTcUTVnorO8cFACArM9YsA/
   g==;
IronPort-SDR: Tv4ovvYBw+cWRAdjU1KK4hNrv6zyZGoIhh0ssvqTRou29bb+cleQl8QsDLdgaCR/6uosl3j1fQ
 eNIWrrGziGDFNUhnbimnXu7O9fW2vIeMB4JyPWARV7kM3J0gTns2+njrkaisW/iIKVXhOVZjKe
 HNPN7px8gRR7zYmp3gcF+ekdx5KXJN9+PtQbBvEdX41av4lgW3gbXhnHXOsAli3oUSRsgbX1Hd
 AF+zQPaIIwP8AflYgeZ6TRPArlgNRSGt099OCfm1KHMioBlfd2o9ru/dtAtpEcuFEneMSl75Eg
 cjE=
X-IronPort-AV: E=Sophos;i="5.81,202,1610434800"; 
   d="scan'208";a="116417287"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2021 02:51:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 02:51:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 24 Feb 2021 02:51:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHkuuDPZzLvw3mkuE8cpIo4deB2DroHb7ZcfshBJCjH74YCD0HYprMBjxUObe10mGM8HwP08dlyNMLzYpgaBAem3X3TvA/InB9L1oQP7QABY+Zm+mz5cBUY+9XBJ7am9rKRNGDdvMTEGObvXk4viUpa5WllexWeVr3356uXG1tTeexGK38P8BnCbnq7b2LdnlKOS65Dk3ety0MhU0RKehZOePx9w7gFYMVU20YmlVWYmZ5TGEmETtNYA77+nIALYiatqFgqRPDTYzQaVZHKPoJ/c8ftqCLMjTPfrHzK8Up3ayF1SjOAUNj2kGB4ISRXcmmXqZZ1ey4N1LJc9eFSsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/pWFu8DbYND77iXfpUdeWbTK7accm0rWm1H7nx6+Ok=;
 b=lIDT99mfQk8JyXvGZsoV1o9plrWF9MV+6EufRlUMupAVF1zollw1Jz4SBTtwF1VJHIT/7n2y1D5v31dKs1zy0MHWMmoHMfEyQn2kF8rIHp0k5/+WiKu5kVLsUblisL+J98Q/DhZot/L3dCYnlGojtfzU30fl0RoijZ1PWtCAzo2HP6K1wFozwzGM9XP5qywB4UWS9HGKHxP4ydu+6NMrWFuiRd+dObpPu21Fi0es+oJpGh/ypP11eUhe42HGFi5qjLYqbi5MxrGjXN3dCvps/RtkcSN2N/KD92d/VtS2hTEzSN3A2Uy4ZpUofsZ7VHdhbRVbKFMVOI/SFJ8shHDI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/pWFu8DbYND77iXfpUdeWbTK7accm0rWm1H7nx6+Ok=;
 b=ZQMirLzrSKlbnvRyHkSouEz8YtCKDH9ImstbCnYBke0ScSJ9kHAyGhvN360nX+JrnuFdKyXWw0yPLtrLDa/Y7qfBw4qJAub/QDK07XLzFvWXzshz8CpEe0sqQk5ZROipi768fkWqHnsuaaRv5nZV2rm7herm4P4i45dUXDUAslE=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BY5PR11MB4211.namprd11.prod.outlook.com (2603:10b6:a03:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 09:51:26 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Wed, 24 Feb 2021
 09:51:26 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>, <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] wilc1000: Support chip sleep over SPI
Thread-Topic: [PATCH] wilc1000: Support chip sleep over SPI
Thread-Index: AQHXCl3WzgU2J4ImLUKk/vrA/exvZapnEH0A
Date:   Wed, 24 Feb 2021 09:51:26 +0000
Message-ID: <7e982999-9347-67a6-f3ec-2e415540ad7e@microchip.com>
References: <20210224033317.1507603-1-davidm@egauge.net>
In-Reply-To: <20210224033317.1507603-1-davidm@egauge.net>
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
x-ms-office365-filtering-correlation-id: a8afe85c-123d-41cd-3a68-08d8d8a9c06e
x-ms-traffictypediagnostic: BY5PR11MB4211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB42117A7D9756A523F694CA5CE39F9@BY5PR11MB4211.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFO+yptLgTEtliNCg8m1RDvmR9vl259NewLWObkmiv834O4b3HNJWxjjEu1+5kOMzZnVThm4bLVG48KKp4IfzsmzZm85TP8vxLDK0F25V/0j0dTwQuc4vstqxgbAmdlGGkiE3YY+NfDpiyd/4h4O/RtfrWSCU8abpjGzXX4gfc0eDyemzLFPU+CxaalQXXvqRCztfFLJAFoG9AjCojknGGsP72y2azi1Nh4stJsPPPctuTkYdSkLTu+tbope80m2/exoGIwK/t3UKC6esVKlvj122g75z1mn3meZV6uqTqAQp2tVOQjiZEQHNWCcKhCVLl9Zns9T+1I6BjblcRYxHE0EdhXO95t08JFanOsM8DtMZ85dsC/bPkic/QBsdQ1RTpQaBOX8bA2Pw8rHbxA1ToHdDvBxQaY9d+8WXZYNcAPCigUSC6erpVmZcIXqkg+HOgw08Ddh7UUly47UkwMzkvRmxuoDHBjSGrkwh+IMyZpc01eH36kjUIv/cBQ3FOVOLgaYYaVqlIT2FCGVyISXTtBomYdtUQOaQ7cvB9+pGYxFJ5PovpFz7Zd1vc1SVjWGiGCnXHIQ97vpuv53phN9sX0MBeRHCtWBbu0JxzceDT0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(376002)(136003)(4326008)(31686004)(91956017)(64756008)(6486002)(66446008)(107886003)(5660300002)(316002)(110136005)(66946007)(66476007)(76116006)(83380400001)(55236004)(71200400001)(66556008)(26005)(86362001)(31696002)(36756003)(2616005)(478600001)(186003)(6506007)(53546011)(8676002)(6512007)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OWtzc04xV2hJdFRxdUpUSVFUS2UvaDNUVTYwWVVVbDZzMUlDemV0L09UUHhz?=
 =?utf-8?B?UExYbEhZQWtJTUVaVjlueW1DSUZFOUE5bU9uUk96OXpWRklSb3VyRHhydnRh?=
 =?utf-8?B?MzdZeUdLRi9PRU5IbWJIUDdjeXpJZWlWWXF4bUR4UTlCWjh2QzJjUkVSaW84?=
 =?utf-8?B?M2RQdFVyUVNjTFg0aElKU0MrTmVkeEdTMnd5VWZXOU1adXFPdHpGOXd5VEEr?=
 =?utf-8?B?WWM5R0lrVlZtS0V0YTBDRVJIMTJIRit1MWUreiswNGxDZHFVaTZZb0VOaTJN?=
 =?utf-8?B?c1RzcnVwNk1rRzVQd0p0aEhQMGIvcEtlRnIvYXdpQXo1Skw4NzE5NzAvQVdP?=
 =?utf-8?B?UUhlVHh0UmJyNUJYbTYram1TQmptbTE4bGh3SElYNE81UndBQmN2ZGJvT3VK?=
 =?utf-8?B?SmExTUxwOXdRcFNudmt4QUhTU2dUSlUrM1dMaXhFUVVIcTBtV0RMc0puYk1E?=
 =?utf-8?B?YURwbFNESE1yYUp1bGMvZk5RS1VBb2VUZHlzSVNGMlRWTmx2TmliYXNvYXpp?=
 =?utf-8?B?UEUzY0JhdGQvZmxielNUbWplQTA3bzZJcC93dVZpdUJTT3BVUFpkbDd4UTYw?=
 =?utf-8?B?a1ZUMDlsWWZnNVpjU0dkNTNhRkpaSittYVpIR3dUR2ZLYzhJMjAyNnNOeXVQ?=
 =?utf-8?B?WTNtZGY2cld2UGREYlkrUFg3MjJsREg0TXVzeldIUTk1V2FFaWJEUEpDNXVJ?=
 =?utf-8?B?QWUvNDdDVEt5N2Jib0lVQzArZjlBQVh1VkFJM0p4d1BUVzBKaTJ6YU9xZzBl?=
 =?utf-8?B?NVpEUWVUMHliaXl5VlFDb3JvUmE2dmQ1QUYyZkpaTldVOEJmeUM4cTVVcE8z?=
 =?utf-8?B?OHlndGlKMGFTOENERFdQNmQ2Z1dXZHVONzJJbi9GaWVXRmU4K1pWUkhib09J?=
 =?utf-8?B?c0o5eUxMUmxUMDdBRms4UkdESWJydkh4Nk1KTlBycm9SckpTa0h3Y1NVcS9z?=
 =?utf-8?B?S3FHamk2azFPOHUxNHlnaFNrYXJkek5pblZtUUJmdVdJVTdxZDNlNnpLY2xi?=
 =?utf-8?B?eGRCdWJ2dHk5WDlqQzI2R214clJBaHVKQXZTUGVMcUxGU1JML0VPNmFkTTVw?=
 =?utf-8?B?cG1waUd5NlY1TWt3ay82RU53VmtwSHArRzhabkJJR1ZVRXVVRWdBWVIvaER1?=
 =?utf-8?B?Z05MRklOL25nMkt0S2Z2bXJHWkxKNXQ1RXgwOFFCSFVsVEVtbm55TVhxL1dn?=
 =?utf-8?B?bHF6VGtHQlc4MTRmSkJtWEp0T3BsRzgzRDNTQytJU0xDd1hBSmVJTGVFT1RZ?=
 =?utf-8?B?YnBFcUhBQ0prVkZCbE1EaXJwVHFBS3UxTmprSkM4RHdGdjV2RVNDbTJXYm9h?=
 =?utf-8?B?bVdUbDdrazlUc0VhZlB6QUFCQ3lPWXVPb3pla2JMeGZiV3hoYUZIcGtkMERu?=
 =?utf-8?B?Y1lxQUJMVnFkZXB2aW5jT0NnWFRNcDNOd0Uwb1ZmYkhJbzlhY2VVU2hMRkxK?=
 =?utf-8?B?UVQyb1ZqZ0w4cUFlSjFodG5LdzJDQVcvM1FzRjVQTE5ZSjZ5WlJBRkFvOUZV?=
 =?utf-8?B?VDhVUW94T29zQ1ZVYUdzb0hZKzhxcWlhakNFNm1VdFZZaktHRmxydGRmMDgv?=
 =?utf-8?B?bEVNdFZWak55a25tbzNIejd5Tm1QSmlmM1EvS2JpL2dSdnpPaU4raDVjekI2?=
 =?utf-8?B?bnN0MWhaWkRPZElld1ZMNnJpK1o5RVZXL2F4VVBTU0FhdzNvVHhyQ2twTksv?=
 =?utf-8?B?UlVQZ29HUnNnSm4xM3VPSGV1c3hQU2cvTFlDUEMyWTJRcTVON0JyZnplSFdE?=
 =?utf-8?Q?OHdt9FkrmUnntlwPCoUo4TkvgUfR/EUFalGwq2L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8CFF77D707F7948BFB8CE704B7A52CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8afe85c-123d-41cd-3a68-08d8d8a9c06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 09:51:26.1113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCU67SKOsQRySCssudHxKkn1hwxKZuJgOT97xDN+YLVjSWvLimV4p6lB3DCtTTCkzeYOzaESIZ6gR8O55CgyWRe9bPF+dv2mcPwEdKyVfZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4211
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiAyNC8wMi8yMSA5OjAzIGFtLCBEYXZpZCBNb3NiZXJnZXItVGFuZyB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBjaGlwX2FsbG93X3NsZWVwKCkg
b25seSBzdXBwb3J0ZWQgd2FrZXVwIHZpYSBTRElPLCB3aGljaCBtYWRlIHRoZQ0KPiBkcml2ZXIg
dW51c2FibGUgb3ZlciBTUEkuICBUaGlzIGNvZGUgaXMgYSBzdHJhaWdodCBmb3J3YXJkIHBvcnQg
ZnJvbQ0KPiB0aGUgZHJpdmVyIGluIHRoZSBsaW51eC1hdDkxIHJlcG9zaXRvcnkuDQo+IA0KDQpU
aGFua3MgRGF2aWQuIFRoZSBwYXRjaCBsb29rcyBnb29kIHRvIG1lLg0KDQpBY2tlZC1ieTogQWph
eSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KSSB3aWxsIHdvcmsgb24gdGhl
IHdha2V1cCBzZXF1ZW5jZSBwYXRjaCBhbmQgdHJ5IHRvIHN1Ym1pdCBpdCBzb29uLg0KDQo+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIE1vc2Jlcmdlci1UYW5nIDxkYXZpZG1AZWdhdWdlLm5ldD4NCj4g
LS0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMgICAgfCA1
NiArKysrKysrKysrKysrKysrKy0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxj
MTAwMC93bGFuLmggICAgfCAgNiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNy
b2NoaXAvd2lsYzEwMDAvd2xhbi5jDQo+IGluZGV4IDMxZDUxMzg1YmE5My4uZDRhOTBjNDkwMDg0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAv
d2xhbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93
bGFuLmMNCj4gQEAgLTU1MiwxMiArNTUyLDYwIEBAIHN0YXRpYyBzdHJ1Y3QgcnhxX2VudHJ5X3Qg
KndpbGNfd2xhbl9yeHFfcmVtb3ZlKHN0cnVjdCB3aWxjICp3aWxjKQ0KPiAgdm9pZCBjaGlwX2Fs
bG93X3NsZWVwKHN0cnVjdCB3aWxjICp3aWxjKQ0KPiAgew0KPiAgICAgICAgIHUzMiByZWcgPSAw
Ow0KPiArICAgICAgIGNvbnN0IHN0cnVjdCB3aWxjX2hpZl9mdW5jICpoaWZfZnVuYyA9IHdpbGMt
PmhpZl9mdW5jOw0KPiArICAgICAgIHUzMiB3YWtldXBfcmVnLCB3YWtldXBfYml0Ow0KPiArICAg
ICAgIHUzMiB0b19ob3N0X2Zyb21fZndfcmVnLCB0b19ob3N0X2Zyb21fZndfYml0Ow0KPiArICAg
ICAgIHUzMiBmcm9tX2hvc3RfdG9fZndfcmVnLCBmcm9tX2hvc3RfdG9fZndfYml0Ow0KPiArICAg
ICAgIHUzMiB0cmlhbHMgPSAxMDA7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKw0KPiArICAgICAg
IGlmICh3aWxjLT5pb190eXBlID09IFdJTENfSElGX1NESU8pIHsNCj4gKyAgICAgICAgICAgICAg
IHdha2V1cF9yZWcgPSBXSUxDX1NESU9fV0FLRVVQX1JFRzsNCj4gKyAgICAgICAgICAgICAgIHdh
a2V1cF9iaXQgPSBXSUxDX1NESU9fV0FLRVVQX0JJVDsNCj4gKyAgICAgICAgICAgICAgIGZyb21f
aG9zdF90b19md19yZWcgPSBXSUxDX1NESU9fSE9TVF9UT19GV19SRUc7DQo+ICsgICAgICAgICAg
ICAgICBmcm9tX2hvc3RfdG9fZndfYml0ID0gV0lMQ19TRElPX0hPU1RfVE9fRldfQklUOw0KPiAr
ICAgICAgICAgICAgICAgdG9faG9zdF9mcm9tX2Z3X3JlZyA9IFdJTENfU0RJT19GV19UT19IT1NU
X1JFRzsNCj4gKyAgICAgICAgICAgICAgIHRvX2hvc3RfZnJvbV9md19iaXQgPSBXSUxDX1NESU9f
RldfVE9fSE9TVF9CSVQ7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIHdh
a2V1cF9yZWcgPSBXSUxDX1NQSV9XQUtFVVBfUkVHOw0KPiArICAgICAgICAgICAgICAgd2FrZXVw
X2JpdCA9IFdJTENfU1BJX1dBS0VVUF9CSVQ7DQo+ICsgICAgICAgICAgICAgICBmcm9tX2hvc3Rf
dG9fZndfcmVnID0gV0lMQ19TUElfSE9TVF9UT19GV19SRUc7DQo+ICsgICAgICAgICAgICAgICBm
cm9tX2hvc3RfdG9fZndfYml0ID0gV0lMQ19TUElfSE9TVF9UT19GV19CSVQ7DQo+ICsgICAgICAg
ICAgICAgICB0b19ob3N0X2Zyb21fZndfcmVnID0gV0lMQ19TUElfRldfVE9fSE9TVF9SRUc7DQo+
ICsgICAgICAgICAgICAgICB0b19ob3N0X2Zyb21fZndfYml0ID0gV0lMQ19TUElfRldfVE9fSE9T
VF9CSVQ7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgd2hpbGUgKHRyaWFscy0tKSB7DQo+
ICsgICAgICAgICAgICAgICByZXQgPSBoaWZfZnVuYy0+aGlmX3JlYWRfcmVnKHdpbGMsIHRvX2hv
c3RfZnJvbV9md19yZWcsICZyZWcpOw0KPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArICAgICAgICAgICAgICAgaWYgKChyZWcg
JiB0b19ob3N0X2Zyb21fZndfYml0KSA9PSAwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsNCj4gKyAgICAgICB9DQo+ICsgICAgICAgaWYgKCF0cmlhbHMpDQo+ICsgICAgICAgICAg
ICAgICBwcl93YXJuKCJGVyBub3QgcmVzcG9uZGluZ1xuIik7DQo+IA0KPiAtICAgICAgIHdpbGMt
PmhpZl9mdW5jLT5oaWZfcmVhZF9yZWcod2lsYywgV0lMQ19TRElPX1dBS0VVUF9SRUcsICZyZWcp
Ow0KPiArICAgICAgIC8qIENsZWFyIGJpdCAxICovDQo+ICsgICAgICAgcmV0ID0gaGlmX2Z1bmMt
PmhpZl9yZWFkX3JlZyh3aWxjLCB3YWtldXBfcmVnLCAmcmVnKTsNCj4gKyAgICAgICBpZiAocmV0
KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArICAgICAgIGlmIChyZWcgJiB3YWtldXBf
Yml0KSB7DQo+ICsgICAgICAgICAgICAgICByZWcgJj0gfndha2V1cF9iaXQ7DQo+ICsgICAgICAg
ICAgICAgICByZXQgPSBoaWZfZnVuYy0+aGlmX3dyaXRlX3JlZyh3aWxjLCB3YWtldXBfcmVnLCBy
ZWcpOw0KPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuOw0KPiArICAgICAgIH0NCj4gDQo+IC0gICAgICAgd2lsYy0+aGlmX2Z1bmMtPmhp
Zl93cml0ZV9yZWcod2lsYywgV0lMQ19TRElPX1dBS0VVUF9SRUcsDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVnICYgfldJTENfU0RJT19XQUtFVVBfQklUKTsNCj4g
LSAgICAgICB3aWxjLT5oaWZfZnVuYy0+aGlmX3dyaXRlX3JlZyh3aWxjLCBXSUxDX1NESU9fSE9T
VF9UT19GV19SRUcsIDApOw0KPiArICAgICAgIHJldCA9IGhpZl9mdW5jLT5oaWZfcmVhZF9yZWco
d2lsYywgZnJvbV9ob3N0X3RvX2Z3X3JlZywgJnJlZyk7DQo+ICsgICAgICAgaWYgKHJldCkNCj4g
KyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICBpZiAocmVnICYgZnJvbV9ob3N0X3Rv
X2Z3X2JpdCkgew0KPiArICAgICAgICAgICAgICAgcmVnICY9IH5mcm9tX2hvc3RfdG9fZndfYml0
Ow0KPiArICAgICAgICAgICAgICAgcmV0ID0gaGlmX2Z1bmMtPmhpZl93cml0ZV9yZWcod2lsYywg
ZnJvbV9ob3N0X3RvX2Z3X3JlZywgcmVnKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gKw0KPiArICAgICAgIH0NCj4gIH0N
Cj4gIEVYUE9SVF9TWU1CT0xfR1BMKGNoaXBfYWxsb3dfc2xlZXApOw0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmggYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5oDQo+IGluZGV4IGQ1NWVi
NmIzYTEyYS4uNjQ3OWFjYzEyYjk1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmgNCj4gQEAgLTk3LDYgKzk3LDEyIEBADQo+ICAjZGVm
aW5lIFdJTENfU1BJX1dBS0VVUF9SRUcgICAgICAgICAgICAweDENCj4gICNkZWZpbmUgV0lMQ19T
UElfV0FLRVVQX0JJVCAgICAgICAgICAgIEJJVCgxKQ0KPiANCj4gKyNkZWZpbmUgV0lMQ19TUElf
SE9TVF9UT19GV19SRUcgICAgICAgICAgICAgICAgMHgwYg0KPiArI2RlZmluZSBXSUxDX1NQSV9I
T1NUX1RPX0ZXX0JJVCAgICAgICAgICAgICAgICBCSVQoMCkNCj4gKw0KPiArI2RlZmluZSBXSUxD
X1NQSV9GV19UT19IT1NUX1JFRyAgICAgICAgICAgICAgICAweDEwDQo+ICsjZGVmaW5lIFdJTENf
U1BJX0ZXX1RPX0hPU1RfQklUICAgICAgICAgICAgICAgIEJJVCgwKQ0KPiArDQo+ICAjZGVmaW5l
IFdJTENfU1BJX1BST1RPQ09MX09GRlNFVCAgICAgICAoV0lMQ19TUElfUFJPVE9DT0xfQ09ORklH
IC0gXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFdJTENfU1BJ
X1JFR19CQVNFKQ0KPiANCj4gLS0NCj4gMi4yNS4xDQo+IA0K
