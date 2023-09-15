Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55F17A24BD
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjIOR3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbjIOR33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D41FF5
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694798964; x=1726334964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mRyhiVjXTxdSAjZDug5QOHs1P7HUuoxUk1rJbabSupc=;
  b=YXPJH5D88jy5UdQcoItgnpdmrIBAD0Az1JHhCqZnEYNlnxIcUWEboZEA
   1e6dVaWLyhkuG73TYvjeQBwUwc4x63Tb3bFumpk9yTpUVk3vq9zpt08QT
   s1azO5KgQw+FJed1oIwFuDKXNE2sRO3k9CWeQfizrbvKh3vMXPZaHIFdH
   dgoZOCAHNnk4STdV4xzpuFk1gJFmO9tJUOtJKe38JVyJXwygslwpzO1x6
   c5Mxn+2LT9Ti1HzCWmMa/CaHvP3JZ40HLZJQgFNUQR/vzMkxYlTtg5flc
   AW/t4HKU+NDdhJueBlIeWEjJVySSPbE/UpJHM8NI0ylorIeiuXch42JQZ
   A==;
X-CSE-ConnectionGUID: DRqCWK0dS4+XYBceG/tw/Q==
X-CSE-MsgGUID: XLl4k37wTE63hRmFawaMlw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="4911603"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 10:29:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 10:29:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 15 Sep 2023 10:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNDjLgSdF1tKJfY4TSLllH+q7unlXsl2ImJN2+ZX+pu27B1uUwn4l6xsE+9/jxvJPSXbjTU4/C//f5+aD+SfcrFOhxlpQKt3B1knqZnjUx3mL8J9JtZDx92S6Q7ClslcL7oqOTJ+DbAwHGvm++Jn/lUk1El4pOEpiNEgcOPHbMHsFQVyYhWNZ+aQUGjKlbv4m9EvaIV+OqKTIhtN62aNvhKZYobVtxngNjLQWotsiHBXLkd0kM9VYvy9hdCZKm/5ttErmpHMRYr3fJZqowHzGVvhTWQ4z0ARp8fIyq1g3R3R2WMOyGd+68HLeiSHPzlITHTjEjFShUGqsu97nHfukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRyhiVjXTxdSAjZDug5QOHs1P7HUuoxUk1rJbabSupc=;
 b=GBAWdx4QRWg/xsapp/KG91rv91YyB4HeMfQPD9L6LmrGmvWW2ZF46AeoUFy8J8+aETMbIj8LlgvLTRcEX4oEsjdakrNODixb8nKysW9KIHqfaAiw0AugaVEmwsO/0ipIRWUB8kKpp68X8qcJvuy1RLg472DUlSG0wAOTw/nDMBWNk4yc776NiK4Fwq5qgWvtWWMRmLerx+eotwdg/sWRqBqXRtnbUS2WbOPaqUxVXSaZ+v5oP0vO0DmPGrSIN68psKhuOG4yF9KYxTBA4kWbBjiuQaWBywooNKwnTtn2V5erx5ftl2fs7E/BtRczLBVQIm2NCiMD/xKLq9nC0DlNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRyhiVjXTxdSAjZDug5QOHs1P7HUuoxUk1rJbabSupc=;
 b=nTJYIA2xxDBtmyj3jcI1yAKLSSSJABOrv5SjBbPN4esmqCSe4rS28RjBM/4nSkcd0rI+BS03/ids7LQwe2pPEuOi+LXAqUDWjP3rBDqBIx30qbC53iFUvwR8YvfIwX062r6ErPnGrJ+ARO3fP/pBhlBFjk/dGYY80ll35++TAug=
Received: from DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) by
 SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 17:29:21 +0000
Received: from DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2]) by DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 17:29:21 +0000
From:   <Prasurjya.Rohansaikia@microchip.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3] wifi: wilc1000: Added back-off algorithm to balance tx
 queue packets.
Thread-Topic: [PATCH v3] wifi: wilc1000: Added back-off algorithm to balance
 tx queue packets.
Thread-Index: AQHZ4a36H8g8Ibgqk0++EZxK8R8Jf7APpikAgAyKygA=
Date:   Fri, 15 Sep 2023 17:29:21 +0000
Message-ID: <3540ccd3-38fb-fe70-1a2d-afa099c5b3ac@microchip.com>
References: <20230907170851.178834-1-prasurjya.rohansaikia@microchip.com>
 <fc3eadf9f8f9e88ed2f1632253646ac1245e9c64.camel@sipsolutions.net>
In-Reply-To: <fc3eadf9f8f9e88ed2f1632253646ac1245e9c64.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6336:EE_|SA1PR11MB7109:EE_
x-ms-office365-filtering-correlation-id: 0d3599fb-928d-4251-5c73-08dbb6114c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eci7L/p1VZTBEY+5diIqnTlJ1gCAsr6aSrTO8iFAgLtWc6Ek3DN/hBXNjDauMFso1scTRywmk3kUuHtmVyFtVZwKeON2VWn6vFtF5T2v+v0+WV7I0XkAZiBpkY4CR+MVyYsQ0Ozgw69y/8kClvgIVoRsA982IHYTyLMA6QEfmoPNe40B8BfWTlYFmkabyWFtu8FxwZAHILjsQsXlCNUs/03WUxFkvBRlDNcvL93uVF8vQ0Q8+1M5f2ti6O1c44b/G3wdeW+aIgFHqowZSOqQQ5Y7SSTGhxuKxby3h44pj9Vmcxcu26gNjCgWQ8QGQeZ9qOv8Je6sGixNd6aYOgiUFnqDuh0essB21lPyN67jvCUuJ7qJ/pKAuzLqsTgdy9C13cIiOTYOEE1aqmkdZELHxlxEz0RhaAkbPhbMX+aubHyoTtE9BsL4ciHiE0orcMDmaokGQFctKtr3EifJOIv4XGxU8zyOOqqH/SSzo+fe26PDDDuivqDvhKy221zB6VFjp5U5n6pSlN5xIg3d0yBe2pIJ9lJRmZQIk7u7xBZaWb2u69c9oZqKrc5Ydd0N4i4dJnpH0gU6hcu9btPXOzNybLbltxUM5sATznlIfeLbpUcHFl0GMiKMYxLBQCBpP3T3G4FhIqFKrVOPYnY2hfbmUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6336.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(1800799009)(186009)(451199024)(31686004)(86362001)(31696002)(2906002)(36756003)(83380400001)(26005)(107886003)(2616005)(5660300002)(6512007)(71200400001)(8676002)(53546011)(4326008)(8936002)(110136005)(91956017)(6486002)(6506007)(38070700005)(122000001)(478600001)(38100700002)(76116006)(54906003)(64756008)(66556008)(66946007)(66476007)(66446008)(316002)(966005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZmMFBzTm9ESTRhS2dVOXVWRE9OWTJHZ2RqMyttNEt3WGV4SFZHelpXcUdp?=
 =?utf-8?B?K21HcnFwTU1JYWcxMERwajZvMW1SeEswaXBqUUR3SnpzbGY5NURXeDQxa203?=
 =?utf-8?B?M0JuYUZuVTJEZnA0bWhQQVdUMmxLcC95RnpRWUcrckdlK1FsNkVObVlqNlY0?=
 =?utf-8?B?Nm1HV1ZpSTRIelFaL2t2SVpmYkxrWnUyWGtMeFlSZW5ZSlp4NnZxZk1PeTFH?=
 =?utf-8?B?cjl0N1Q0QXZCVzZ1aS9NRnphUis4VzhIS0phb2txaHNFbFgzNi9kSFZrQ2xG?=
 =?utf-8?B?ZzVtSkQzSXhlbXpYdXNLR0IvOGZ6YWlrK05BNGR2MWFyYmhVMUVscUMzcERv?=
 =?utf-8?B?TzN3cTMrM3BxNnEyR25iTVJuU1NBVzZDQTdXNzk5R3RCb2MxMlpSeC9IbFp1?=
 =?utf-8?B?eTQzTWZ3a0N1SllXYktzNFplWHIxbmJSdkNMNDRZTGtNdERzNWF3Y0ZqcFM2?=
 =?utf-8?B?MXo0cFhwaVBnRXRVekd1WnlTYTNkMytWUHFXa2JmZSt6dkVXcDBmYS9oTnBw?=
 =?utf-8?B?blo3Yk5pWXcyNzdYUWx4Si9ZOHA4dllvNVhBQ3JsZWlyOHQ4emZhRzdkRlR2?=
 =?utf-8?B?cjZLYm9DcklnQmQ2cVFncWFXZ1p0TUZyTDRyQWY5cWx0MWpVbUZ4NnRSc0sr?=
 =?utf-8?B?R0MxcngxTjBnbERlcHBJK1BJeFp4UllCdFc5WDY1NEhmTUNJOTROMnhwdml1?=
 =?utf-8?B?WWpqbW5ZMW8yYm1XS0VBdndwcDFQLzVsT3pDREo0WnZBZjlXaEhYYXRsTWhm?=
 =?utf-8?B?TzNDTHU3K1l6YXhadGIxdnFsTnMxR3h4ZVM0dTNVN2wvWWo5eEI2SVZTYnhU?=
 =?utf-8?B?U052SEJvOUs2TExIZlpldTduczZDR083RC9IRytRam41czZWR2VGc0J4ZVNn?=
 =?utf-8?B?aDQ5YWFqbjNrQ0g0cDlnYThROGhxbVJ4SmZHQVRDWm9BVElPV213WW5nZUw5?=
 =?utf-8?B?cG5OaVZadGREN1JsZk5EMDhacXMwN3FhNVkxc0VURVk4ZytDaTRaZFptcmow?=
 =?utf-8?B?SjFFUjVzZ054dmFmQzZ0b0s5WVFiZGNRZTU0V1M4RUlFQ1d6QnA4cHV0QWI0?=
 =?utf-8?B?R3BmbFMxK0ZiMEV1dFN0MERJaklGbFc5ODQwVnM0b3I0bURDZHZpOWVkK1lD?=
 =?utf-8?B?dm9odmk3REVqVTBLcnRoaWRGbkRGK0ZtN3p2RE42VkdnSDMyYXJIMmxJN203?=
 =?utf-8?B?NEYyS05jc0t2SUNPcFNvN3h2czVkcWZ1U0d6U2g1OGxBeU02LzZjSmJaSzdG?=
 =?utf-8?B?QWcyYUZBeGxINWVIYWRsTjQvRDAwczd3dlg2MjBSVGE0b2NDWlJKUnhRaFlC?=
 =?utf-8?B?TWd1OXBYNmlkaXpaSENnemdTZVR4Z0I0dUZFN3B1ZlZCeXdqSEZPMG9ZRGdi?=
 =?utf-8?B?QWMyb1FHT2xmakZZUGFjbjJBOFNHdllIMitBdUtXd2FQcmFRTUMxVWhTYnpW?=
 =?utf-8?B?QmxhMFBTK010b1daR0RmS3BXSnN2RFZYcDJaZzlZWVRsaFlYS0JYa3pLQlUr?=
 =?utf-8?B?dXY4aDVmaVpTYkFRTkM4ZlpnVlN1UnlEU2lrYUlhUGE0R3Zac0M4MzllcnVV?=
 =?utf-8?B?YUJZcWtKYVQ3K1BHZCs3VzZmWDBMOGVpa1VCKzlNYzV6U0ZqdmhBYnprbWJr?=
 =?utf-8?B?eTVldmV1dHRFV1kxYlRhbkxLWDl0WUVnRk42Q2M1K0VIeUZJaGY4YmFiSGYw?=
 =?utf-8?B?Nlk5Vm9RZGFQRWRBNkcxajRFRlVOTUZpN2R4OHlzVlNqU0N3TXdPL3pORENT?=
 =?utf-8?B?Mmp5V05ZSWUySGpoKzZSL3J2VWwyTW9CSnhOUWNzb2JoRU1LYmVtK0RIUHA4?=
 =?utf-8?B?eG9PZkVOY3RJVUp3K2JWUmFtOWlUc0NOUk5aTU1pZVFnU29LNEdDcVgyTTNM?=
 =?utf-8?B?Kzk3QWlXTUVRWTZYTFJmdUlJSDgyTGdWL2JxTzJONmVYZTkwbVlTQ1BVajF4?=
 =?utf-8?B?MkQ3NU03R0kzQlkzdG5tWldhTzdGSzdGQnI4VFBaSmRMV1ZOVmM5OFZNRG9J?=
 =?utf-8?B?eGRJNjl5QUNzUDM4bS9vcnhTTG9QeVRKUkswWTVnMEVQZmtvSlJNbHE4Vk50?=
 =?utf-8?B?TXM2NjM1bnNOczhSTjU3N2Fhb2JUeHZZMUk3ODJKNTB5ZEt5NmF6YjFWOU9M?=
 =?utf-8?B?M2VINEtYMkFjV1FWSy9BL3BsMU1sbnVjclQvKzBiWlRvTnVDREJETXB4TWF2?=
 =?utf-8?Q?1MJ9PBXpiILhUm9FLYXoFs0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58A218A12786FA4FA3E4F3AAC92FC6E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3599fb-928d-4251-5c73-08dbb6114c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 17:29:21.3109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6iJFRd5GfsetszmJEBw0DP8QmdRvETJimESmrwZZD0uguccif/f4MAES8/eyPWsBOphymwSxhr5dA5StdWDnjWNjLMy5iEN+hunz6yQM+mxXZ+vBCvLnppkQZisLeQVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDkvNy8yMyAyMzoyNywgSm9oYW5uZXMgQmVyZyB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDIwMjMtMDktMDcgYXQgMTc6MDgg
KzAwMDAsIFByYXN1cmp5YS5Sb2hhbnNhaWtpYUBtaWNyb2NoaXAuY29tDQo+IHdyb3RlOg0KPj4g
RnJvbTogUHJhc3VyanlhIFJvaGFuIFNhaWtpYSA8cHJhc3VyanlhLnJvaGFuc2Fpa2lhQG1pY3Jv
Y2hpcC5jb20+DQo+Pg0KPj4gQWRkZWQgYW4gYWxnb3JpdGhtIHRvIGJhY2tvZmYgdGhlIFR4IFRh
c2sgd2hlbiBsb3cgbWVtb3J5IHNjZW5hcmlvIGlzDQo+PiB0cmlnZ2VyZWQgYXQgZmlybXdhcmUu
IER1cmluZyBoaWdoIGRhdGEgdHJhbnNmZXIgZnJvbSBob3N0LCB0aGUgZmlybXdhcmUNCj4+IHJ1
bnMgb3V0IG9mIFZNTSBtZW1vcnksIHdoaWNoIGlzIHVzZWQgdG8gaG9sZCB0aGUgZnJhbWVzIGZy
b20gdGhlIGhvc3QuDQo+PiBTbyBhZGRlZCBmbG93IGNvbnRyb2wgdG8gZGVsYXkgdGhlIHRyYW5z
bWl0IGZyb20gaG9zdCBzaWRlIHdoZW4gdGhlcmUgaXMNCj4+IG5vdCBlbm91Z2ggc3BhY2UgdG8g
YWNjb21vZGF0ZSBmcmFtZXMgaW4gZmlybXdhcmUgc2lkZS4NCj4+DQo+IA0KPiBodHRwczovL3dp
cmVsZXNzLndpa2kua2VybmVsLm9yZy9lbi9kZXZlbG9wZXJzL2RvY3VtZW50YXRpb24vc3VibWl0
dGluZ3BhdGNoZXMjY29tbWl0X21lc3NhZ2VzDQo+IA0KPiAgICBQbGVhc2Ugd3JpdGUgY29tbWl0
IG1lc3NhZ2VzLCBsaWtlIG1lbnRpb25lZCBmb3IgdGhlIHN1YmplY3QgYWJvdmUsDQo+ICAgIGlu
IGltcGVyYXRpdmUgdm9pY2UuDQo+IA0KPiBhbmQgdGhhdCBzYXlzOg0KPiANCj4gICAgU3ViamVj
dCBsaW5lcywgbGlrZSBjb21taXQgbWVzc2FnZXMgKHNlZSBiZWxvdykgc2hvdWxkIGJlIHdyaXR0
ZW4gaW4NCj4gICAgaW1wZXJhdGl2ZSB2b2ljZSAo4oCcZml4IGZvbyBhbmQgb3B0aW1pemUgYmFy
4oCdKSwgbm90IGluIGFueSBvdGhlciB3YXkgc3VjaA0KPiAgICBhcyBwYXN0IHRlbnNlICjigJxm
aXhlZCBmb28gYW5kIG9wdGltaXplZCBiYXLigJ0pLg0KPiANCj4gam9oYW5uZXMNCg0KVGhhbmtz
IHlvdSBmb3IgcG9pbnRpbmcgaXQgb3V0LiBJJ3ZlIGFjY29yZGluZ2x5IHVwZGF0ZWQgbXkgY3Vy
cmVudA0Kb3V0Z29pbmcgcGF0Y2ggJiB3aWxsIGRlZmluaXRlbHkga2VlcCB0aGlzIHBvaW50IGlu
IG1pbmQgdGhlIG5leHQgdGltZSBJDQpjcmVhdGUgYSBjb21taXQu
