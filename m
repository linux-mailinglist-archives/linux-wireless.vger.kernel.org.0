Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961F14E1FD2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 06:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbiCUFNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 01:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiCUFNt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 01:13:49 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7BAB7C78
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 22:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647839543; x=1648444343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d9QDdp+Ojq5y8NmU7C4o3/gJpcMGitxtD4pQCND/TVI=;
  b=JgcbY8UrEgLV112Z61VJoH3o4+ShTc73CiKDe+jivCIOzE2ODVu2NBY3
   fBeUqHoKkAqSmFOMMYG/+6jU5b1llFnHqKo4alYYh/Zn2GGUG7zHmQTge
   /BErWIO66YoC0gNdToiJ+i/nuhNFcdmojJgnsoeSTMxxqcbKxf7jkgkCF
   0=;
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:12:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBlWw2Tv1GGX/Ytr7AMGJLNV16xPIuNMFZRNS1ZDs5dlkvFMxCa0eEgS4yTA0iyDlUfSiv0M5CtWI0KcP2zkw1ajq1VWvpkvuvNvV1OCo75J4UZAZHwznU2Pdid4zjJcoO4HvkDCDK0Xn2eBy9tFfGelaEDqV8CZV98lHXT7UAh6a0nBGV1oT7VR75zEKfz5Yw2Nrgay3dweDEN4TghSl2oHbI4Ab0xzubYLkQy1ZzEKGMw8vJsN3i0alKJoJTyJbi6CN2cT/O1UGdJFG6CXpLh8L0MSlWMWBDP21f/zLqUmjDAaN1PhDSk+EN4OwWz3dJGdxCVMSMPWqk6rXQ8a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9QDdp+Ojq5y8NmU7C4o3/gJpcMGitxtD4pQCND/TVI=;
 b=n2mvy/S27Pk7tbH6c3/zDwR8NLD9Kaw8eOCUopW4LK2cE1xnMETqs/C1kYmu80wubd17DI1aHQ07CBLoloz0rY9Ck92TTQ3BWBidkSxqvgLBtDk0mjk1wlJ6bo0qiTRnoKCG3vK9EZNOmIA+W0FANYOfeTCMKrKKytj4yEnbSdbQoNdWN24oBmLwncEvRy5KucPaPZgH/+lmdBqfb9xgwy0NEKpIIwlOIqR8WWlPXRJAVOXNF+klqvI/Ag36HzvpTikyVZ5Pz0R7SNry39WVY3DVLJu1rdKnBMn/NbPRSI7pEjCgOy6E/JJKVE9m25wWg03sNynh6/kuVjfxev3weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 BN7PR02MB5186.namprd02.prod.outlook.com (2603:10b6:408:21::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.18; Mon, 21 Mar 2022 05:12:19 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::68c2:f8b4:f787:211e]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::68c2:f8b4:f787:211e%3]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 05:12:19 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: RE: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
Thread-Topic: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
Thread-Index: AQHYIkgqfAgpLdnS+EWoRYfPSRKpZ6y6KrAAgA9VNCA=
Date:   Mon, 21 Mar 2022 05:12:19 +0000
Message-ID: <DM6PR02MB4937C53041172E9A52846A0BE9169@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
         <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
 <a517835c51a5eaf00e87fdaaef47546f70ff0d42.camel@sipsolutions.net>
In-Reply-To: <a517835c51a5eaf00e87fdaaef47546f70ff0d42.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84a5dc8c-ad5b-4586-280f-08da0af95f9a
x-ms-traffictypediagnostic: BN7PR02MB5186:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR02MB51869AF2341CE5AA4609B6FF95169@BN7PR02MB5186.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UD1xzFth0q8qkWsbPTihOazJL0fb9n/VMweVXkqw+x5Gp82hKuFL0nful2xerhpQRdd6Mjz5QWXidFMMxe2nHbWSM/zcypPgq6Aea/PTqY2Da8fo3z81QEcuRhMOVh3PSnwNDDmR3KkdlxpcHYC6h+fa7A0rTdIE8o+lxqMa2fAkL7dRADNGInAJo18GUopTOdafvQhByPivo90ZPJQOobOcOcbVVa8C+avbtB9J/R8rGHTIw6E2mmfVhAl3J035Atkek5Eio8qqbFUrh9ISrYSJzCoNNeWnozyX4PZ2Oy8t9yg4Apg2JpVNtLQiOknQTPFuzdkBPdezsgJNQIXHdSai/HDeBVA0BhUi/0fxBRgo/i2TpPmmfctDd9dAeoUYe2SmdzcKEl4pPVKkfmK838WKs87u9eECC/vgmXTjOoMI9yphsPC7emtwR4wSMKX8RBVfimWokhy2O/dMZYWAiotxgcySCoaIaWHPDrt2oSwbqDla6OTGKfK3WeRxokF0/I9aKtP1iCMTFr1yqwDgPGrsPMI+x5bVp78Bhua8U5nWTQZ/lrAz8z7pjdRfL9L+cvuPT8YVn7/HAUOaX8QlvW7jxiwIgodwJOG3ThCh8ymjiMOPRuBEV7obF44cpV7Dfa9UB550iLrssxdEJc42aAG5C6C9ZPnjwrEYYUyYxGrBWdTzdzNhoBfMRIFQ5PQVLzIKQwIl+AW7BO0yZMmheQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(122000001)(53546011)(110136005)(54906003)(9686003)(7696005)(6506007)(71200400001)(33656002)(508600001)(2906002)(186003)(316002)(26005)(4326008)(66946007)(66446008)(76116006)(38070700005)(64756008)(66556008)(66476007)(8676002)(38100700002)(52536014)(86362001)(5660300002)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVlRdGxrMk5GNjVvUDZMaEFYOUdxM1BIZ3BiTW9IN3ZCRkJKMkE5UEF6eU1Q?=
 =?utf-8?B?M25iTVZBbkE4MGYybHZnVzN2V0ZQSHVwdlFQT05YVFVqNURJQnpFNm14V3B4?=
 =?utf-8?B?Q3UrbWpaem5nU3NxdFZ5elozMDF2UnBiK0NtdzdzKzk0MEVzUnZtSjJBZDRh?=
 =?utf-8?B?MUF5cndvdXBjWTQrMjVkY2xIMStLZTVNTEVLWjZkNnUwSVZ1TzZzUDg0S0JI?=
 =?utf-8?B?ZDByV2xjcFd3SGQvcjByQmxlUVdIdXEwVUt1VFh3bm1zNUtrdVZOZ0JEK3dv?=
 =?utf-8?B?d1F0S3VKQWNoQWQ1N0tURUJEb2RiMkQwbWkyekNFR2R0bHdYM3loRHZZSTBp?=
 =?utf-8?B?VjBoRWhiRWpma2l6ZjVXbmJndzRncGttTUtiVFpuUEZRcTlmdktJU0lxOWpJ?=
 =?utf-8?B?d2o1RkRNbFVPTTQwclZTZHFaZ2QrS3JmRUVmZGdHVE5wS2tWNzJVYXhBQmw3?=
 =?utf-8?B?YzdDYXl0UisxcE05QkRRZDFkczRXTFNoczlEeldLcVVQcUFvandhWncyT1Jy?=
 =?utf-8?B?K28weHBPU0xJS1N0Rjlua2JLaGZUR2JJMWJBUjdjeFVXRDNDUzhFRUpZbW1I?=
 =?utf-8?B?SHdEbzN1eThuRHVmRVAxOER4c3AwaXEzR1FKUmJkbUlKZHg5SnVTUXlpdFlO?=
 =?utf-8?B?L0pkdlorNitkZFlNSkQ0bzBITldITWN2eUhZVW01eWUxQVJ2cFBMaFZVNGhY?=
 =?utf-8?B?ZlRsTEFuWlBNaDlBL2VUM0JvTXhhZWdLVkhKR2N5QWYzTXIyUnVXSkhBUjFy?=
 =?utf-8?B?YisrZ2MyaW5HVVhuWUZicG12OFRpSlJJOTFJalJVK2lONFVkQzZ3V01xWTV5?=
 =?utf-8?B?UFJWZ2F3M1pqY1ozTXRCVUZnVE5XME9rQll3QWVld0tzWTlaaWZNSnhoYnhs?=
 =?utf-8?B?cU5ZcktUZy9WL0VCUkk1YU9RMjloRUgveFFMM2dWYnVlb0V4NVBzMTBnbFBa?=
 =?utf-8?B?Sms2K3NMRmw2dy8rZjlFTU9uT2tuSHZvQ0FxdlU0ZFBZVWpqNjY0OXJaOWVF?=
 =?utf-8?B?SDJqUXp4Qk5iWUp2TGVWOGlyNS9GaE5KOTl6NXMvbzVHNVg5MnArUkRvMUVG?=
 =?utf-8?B?Smp1by9wY1RaUFphMXhWeTlMbW5NTVJsRFZoby9tbWY3ZEZaZ1hsS3FPcEpk?=
 =?utf-8?B?YWtSVW1lTnB1OTdaZ0R0ekxjWWFiUkZPd2h0R1RxbUJVZ3JCOUt1TUp3bU1w?=
 =?utf-8?B?d3JNbTlwYXppbFNyVFEyK0hHQjVFZW5ldXN5bksxSGRXOHczVDRESndHRFMx?=
 =?utf-8?B?MG9tUFpvL05JY2pPa1BjY0dPNUtsWGExa1B5d2pEKzhPM2xOZVJRekcrUW9a?=
 =?utf-8?B?Q29kWDNqTTEwd013aXdraDNmdUhZbjVRcCtHcEMwQnRGR3NkeFFQTWFRRkdi?=
 =?utf-8?B?b0RUZkUyOWdLNDEwRVJSUHdPc3ovNkRZdzM0VDlocmN4QnJFblNZL0RRMG1k?=
 =?utf-8?B?NTRCREd4RkU0cjVtUEpFL0QvVEp2K1NtMVA5QVJleVlyQ01NUzhDY1UyZDJl?=
 =?utf-8?B?SEJweFRReVhZSmJZQkxLWlhzSnphT2ZLaVZzQzc1ekhodldZdUYyay94RnQx?=
 =?utf-8?B?OVFtNVE2RENMcm1hR0NnSHdZRUdRb0VZTEJBV25CWlVKaHpzeHBGZ2JVdExY?=
 =?utf-8?B?WlJuSnI4MjV3TjFYdjZwenlLcUFpM3ZzaU83VHpQaVBGSjlrR0hJeVh2eGZ5?=
 =?utf-8?B?VkZOcVJxRWVNOVpFUk81MEhUUmxVdEx3Q3ZRSnFoVElKY3NyVHNKUUtYN2N3?=
 =?utf-8?B?bHNhNEZtNTdPUmVlTWErUWxlU1FyRDZKeGtyNGFQWDJQbWxJSTcyNE1ITG14?=
 =?utf-8?B?dHk3eUpQTmpTWkRTQnRBaEYxSVhzaFYxUlpIWE9RZmhzc3EwQkZuQmFNdnFp?=
 =?utf-8?B?MXJWdUZkNkkyK1RoRE1YU1dZcFR0UjFVQVV5YjJsZTI0a3V6dXdSRUVwL1l3?=
 =?utf-8?Q?i9F+tYcZWfg1jRkqIDlBlOPy3Zp1L6uz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a5dc8c-ad5b-4586-280f-08da0af95f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 05:12:19.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVvm/ZP0jty7Ay61EO9AUONcZcfKUD/CF4AHoLCdwmaVVj893E+1RaYFB1ydP2tcLDRl5rLr8AyM0qsD+DidvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5186
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTEsIDIwMjIg
NDozMyBQTQ0KPiBUbzogUmFtZXNoa3VtYXIgU3VuZGFyYW0gKFFVSUMpIDxxdWljX3JhbWVzc0Bx
dWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgYXRoMTFr
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIG1hYzgwMjEx
OiBhZGQgc3VwcG9ydCB0byBjb25maWd1cmUgNkdIeiBub24taHQNCj4gZHVwbGljYXRlIHRyYW5z
bWlzc2lvbg0KPiANCj4gSGksDQo+IA0KPiBDb3VwbGUgb2Ygbm90ZXMgYmVsb3c6DQo+IA0KPiA+
IEBAIC03MDQsNiArNzA0LDcgQEAgc3RydWN0IGllZWU4MDIxMV9ic3NfY29uZiB7DQo+ID4gIAlz
dHJ1Y3QgY2ZnODAyMTFfaGVfYnNzX2NvbG9yIGhlX2Jzc19jb2xvcjsNCj4gPiAgCXN0cnVjdCBp
ZWVlODAyMTFfZmlsc19kaXNjb3ZlcnkgZmlsc19kaXNjb3Zlcnk7DQo+ID4gIAl1MzIgdW5zb2xf
YmNhc3RfcHJvYmVfcmVzcF9pbnRlcnZhbDsNCj4gPiArCWJvb2wgaGVfNmdfbm9uaHRfZHVwX2Jl
YWNvbl9zZXQ7DQo+IA0KPiBUaGlzIGlzIG1pc3NpbmcgZG9jdW1lbnRhdGlvbi4NClRoYW5rcywg
d2lsbCBhZGQgaXQgaW4gbmV4dCBwYXRjaA0KPiANCj4gPiArCWNhcCA9IGNmZzgwMjExX2ZpbmRf
ZXh0X2VsZW0oV0xBTl9FSURfRVhUX0hFX09QRVJBVElPTiwNCj4gPiArCQkJCSAgICAgcGFyYW1z
LT50YWlsLCBwYXJhbXMtPnRhaWxfbGVuKTsNCj4gPiArCWlmIChjYXAgJiYgY2FwLT5kYXRhbGVu
ID49IHNpemVvZigqaGVfb3BlcikgKyAxKSB7DQo+ID4gKwkJaGVfb3BlciA9ICh2b2lkICopKGNh
cC0+ZGF0YSArIDEpOw0KPiA+ICsJCWhlXzZnaHpfb3BlciA9IGllZWU4MDIxMV9oZV82Z2h6X29w
ZXIoaGVfb3Blcik7DQo+ID4gKwkJaWYgKGhlXzZnaHpfb3Blcikgew0KPiA+ICsJCQlzZGF0YS0+
dmlmLmJzc19jb25mLmhlXzZnX25vbmh0X2R1cF9iZWFjb25fc2V0ID0NCj4gZmFsc2U7DQo+ID4g
KwkJCWlmICh1OF9nZXRfYml0cyhoZV82Z2h6X29wZXItPmNvbnRyb2wsDQo+ID4gKw0KPiAJSUVF
RTgwMjExX0hFXzZHSFpfT1BFUl9DVFJMX0RVUF9CRUFDT04pKSB7DQo+ID4gKwkJCQlzZGF0YS0N
Cj4gPnZpZi5ic3NfY29uZi5oZV82Z19ub25odF9kdXBfYmVhY29uX3NldCA9IHRydWU7DQo+ID4g
KwkJCX0NCj4gDQo+IG5vIGJyYWNlcyBuZWVkZWQgdGhlcmUsIGFuZCBubyB1OF9nZXRfYml0cygp
IGVpdGhlciwgeW91IGNhbiBqdXN0ICYgPw0KU3VyZSwgSSByZW1lbWJlciBJIGdvdCBzcGFyc2Ug
d2FybmluZ3MgbGFzdCB0aW1lIHdpdGhvdXQgdGhpcyAoYWxzbyB0b29rIHJlZmVyZW5jZSBmcm9t
IG5ldC9tYWM4MDIxMS91dGlsLmMgaWVlZTgwMjExX2NoYW5kZWZfaGVfNmdoel9vcGVyKCkpLCB3
aWxsIHNlbmQgdjIgd2l0aCAnanVzdCAmJyBhbnl3YXkuDQo+IA0KPiA+ICsJCX0NCj4gPiArCX0N
Cj4gDQo+IEkgYW0gd29uZGVyaW5nIHRob3VnaCBpZiB0aGlzIHNob3VsZCBldmVuIGJlIGRldGVj
dGVkIGZyb20gdGhlIEhFDQo+IG9wZXJhdGlvbiBlbGVtZW50IGl0c2VsZiwgcmF0aGVyIHRoYW4g
ZnJvbSB0aGUgYmVhY29uIHJhdGUgc2V0dGluZ3MgdGhhdCBhcmUNCj4gc2VwYXJhdGUgaW4gbmw4
MDIxMT8NClRoaXMgaXMgYSBCVyBkZXBlbmRlbnQgYml0IGluIEhFIE9wZXIgSUUgYW5kIHVzZXIg
c3BhY2UgY2FuIHN3aXRjaCBCVyAoQ1NBL2NoYW4gc3dpdGNoIHNjZW5hcmlvcykuDQpXaGljaCBj
YW4gY2FsbCBhc3NpZ25fYmVhY29uIGRpcmVjdGx5LCBIZW5jZSBhZGRpbmcgdGhlIGxvZ2ljIGhl
cmUgdG8gY292ZXIgYWxsIEJlYWNvbiBjaGFuZ2UgY2FzZXMuDQo+IA0KPiBqb2hhbm5lcw0K
