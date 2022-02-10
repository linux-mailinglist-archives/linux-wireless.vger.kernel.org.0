Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18E74B0389
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 03:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiBJCrA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 21:47:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBJCqz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 21:46:55 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 18:46:56 PST
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE219240A1
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 18:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644461217; x=1645066017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OcjHwpEDGgN390xJiFmaPz+P6SLPK444HCnvDl8eDRA=;
  b=Pqm4nHnuk5BshSrMjdhBcx5Y7CUK1TnFUCE2x7rc/mXFfF59EDgGGWEt
   OTjioIkUzMK+5HqJbN8Se8QuH34GBL7tjxVk3jdB67Fvwoq4dFhY9hlao
   2VHZ1u0D1d8LBNo7UdtzL/13UAhTzCaDz+X6doR6GmvLWsEuSrYpDWRT7
   E=;
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:45:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9AExNWSAB4OPUnxzziEbN0WZGvUJRAv5Ppt+fg+prTZTnRV4G46rXrTfAkzf2v6PLlLI70V1lGebW2X2o59jmjtfDAqt1f8tfl1E+D/dWYdd5tqG33svC9bE0KLAQ+y24/0K5xtAoeRaUds/+yHflOA3u7Eu4GJu3OI3Sc575SZUrvIIb4P2GzBjqY5wZQe7Ywoecn7D947oogUl2j4WhbcQwEfmFQDCqTAjn293YMH9rKPxAuhgB91r7A7GyKLZKi0hPvr7flQ11WsFKkfhE0knph7TZmXw6aVaSA0g1ZIwkC1NH3vnGyAMYCikuMAlYC4M1MTEfJV1H8IaiEEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcjHwpEDGgN390xJiFmaPz+P6SLPK444HCnvDl8eDRA=;
 b=l/QFJf4dFi7uULM6EWE7NLxgW6SbIXvKIkxdbPmRaYJN02Rs309zdal5aOm61J5pK4/GGWaXN49m9u1901263JHWjIgXD3trKzQrMBfq1E+SOceS3gdoI4Vx2NbgZLaWualD8So2ikdy0aqCJa9eF4A2xbfiHGkkPMDCz+R/jVivG5parf6AvpsRwitqIKe0nb+mMr84DccU3EpFWnTW/lUaJIJ/2+4fI73KeCVF8Syq4sucZc26zNBQAtlisPVqqxD16MmYCNE/PogqUfeFX7syiJhsKCxHuEWcMBRgZuDQs0rFJboDitUvZoKNAPsRFk8iZ0PnzrMxJqUb5mpmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR02MB5430.namprd02.prod.outlook.com (2603:10b6:a03:a4::25)
 by SN6PR02MB4414.namprd02.prod.outlook.com (2603:10b6:805:b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 02:45:48 +0000
Received: from BYAPR02MB5430.namprd02.prod.outlook.com
 ([fe80::8dd4:65b2:2135:1ee4]) by BYAPR02MB5430.namprd02.prod.outlook.com
 ([fe80::8dd4:65b2:2135:1ee4%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 02:45:47 +0000
From:   "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com>
To:     Abhishek Kumar <kuabhs@chromium.org>,
        "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] ath11k: Reset PCIE_GPIO_CFG_REG register when power on
Thread-Topic: [PATCH] ath11k: Reset PCIE_GPIO_CFG_REG register when power on
Thread-Index: AQHYHhpj0UFeh4PMskyNPKMBRWX31KyMFGew
Date:   Thu, 10 Feb 2022 02:45:47 +0000
Message-ID: <BYAPR02MB54302CD5FF7C8C38710A4B83E02F9@BYAPR02MB5430.namprd02.prod.outlook.com>
References: <20220207093023.10605-1-quic_bqiang@quicinc.com>
 <CACTWRwugAHA87-AuEkC7tXEEuOhef_FrWBjjk4pQXZvpmHQ65A@mail.gmail.com>
In-Reply-To: <CACTWRwugAHA87-AuEkC7tXEEuOhef_FrWBjjk4pQXZvpmHQ65A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d8484c2-d5e9-4c12-01f9-08d9ec3f716f
x-ms-traffictypediagnostic: SN6PR02MB4414:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB4414EB263DA36C7DA5F7417A9C2F9@SN6PR02MB4414.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNu7QZb12QHIik8eyWmMg/lajE2iIKtQ3Z8KPD8aWE4//YfqDeofCNZfDo/0cjUIAajsmHjB2tCDWDtLBBnZ6MSWQBR7Y6kxeNnC+55WaHAY0bUAQwgEtIbx4FrhBhc5aom6v0zPA8+Y9wmrQmzeY8yLmg2aw6dEWsHIBldhmivRvhVNwjoGqjbvYJRrjVfqRSs4Zxn0BfmyaVJupT5rMjGbHSAXTEXFxQ3GpAXhzmhGUb0YFEtmIg1m4dOLJfJDQuL4EtJRZK2wvi7HQPzrLppzGb0KF9l1p0E90OelWjeAQE0vHvG5M7s2O108XzIEHYOg+9V25qTgwlmSdvf43HWA7wI3zjnz/XY9X3id6PC02tI7pm0jSeOPwOjqekfD6pONjcq49O8iISILNAYDHpAi1iKw4iY1gHasZuhVzc9qAUr6rpGqGk9dB+52KmnONXVmjtN1ozL9QkQDicLknxk1tHn1znP/HXolNGsvUqbJ9XZfpO7cl2u+4dN1CeD9PrO7ux+amx1Kb2bpWlnEq2b7zEMX06rD2+qeuEwg4Bao3MtBbqx6xoY+6rpzzleCFoOQ+i1ro8IJvbJcSWhmoKwxMzWRIp/qurI6/K7RuXJIViMhg1NPaxFJKrJGOrPFo0Nq6wBMZG4VJ3Kb8k7ewQApRHy1/vuAlLtrzdWMJsJkXaskKoMb9GFIZBKU/z2hDDAJTZPSql31gGQ7/qNluQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5430.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(8936002)(508600001)(71200400001)(110136005)(316002)(54906003)(38100700002)(83380400001)(5660300002)(2906002)(52536014)(9686003)(8676002)(66556008)(66476007)(186003)(26005)(55016003)(64756008)(76116006)(66446008)(33656002)(86362001)(6506007)(122000001)(7696005)(66946007)(4326008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WCtWQU0vTzN3TnpCK21vZUpsZkZEN2tBNEt0U0x2ek9ESnpNNzN0K2F4OTI0?=
 =?utf-8?B?V3ozd2h6bGJ1MmRTZUhFclBRSXp1d2x6SHhpay9ndVNkRmk5ZnRFTitORGxv?=
 =?utf-8?B?b3psQ1dlZWNHNm4yZzJBY2orQVBQQ29oVlRsUnZjU3RVNUZRUlZnYUxmVkRi?=
 =?utf-8?B?b1V0VkMxUFdBelpXM2VjMjMzRFl1R2dLdFVsNW5FWHB2ODcwN0NUWk1OQWlt?=
 =?utf-8?B?aTQzZ04rWTdwN1NrSzlKeFl4V0dJZTJJcVlQYnBOUWJOdW9hSDUvajlRQ2VN?=
 =?utf-8?B?WmJ4NnBpOCtWSUpiTWRxaUZqRWtORHU4OWlYcVdvSzFobUZzamhnSWZkOHpp?=
 =?utf-8?B?WlVnS3pFZ0xybHN2Q2pieVdHZDNHazRQdlJidDNkUHlobHVwSm5iUWxoTG1H?=
 =?utf-8?B?Z01WUVMwbXZTOGV5T3hsUW9HZHJQcno4NFB3VGJLdUpsM0dSV2xTZEFqNHEr?=
 =?utf-8?B?ZHQ1cDRkRXljU05ORkx4TmR2ZjQrV2hmUGlnVG4vTktqVTNORG5wR2ZxZ2NV?=
 =?utf-8?B?S1VMQm1IdHFGdDl2dlNkTjlLODJVbXRjVWcvRHE1VXBzZFBZNmR4Y3F2R3Iz?=
 =?utf-8?B?SFV1ZU1ESi8rY3NmU0tCVkk2Z3ZWVUF3NHZxWktnS09FUXVzVDJKc0xQM3N5?=
 =?utf-8?B?T0tVQ0JPb2ZIZDJIVElTY3hOa1JLOERabXlnNUpHb1p4VmlOdFVvNkpwK1BO?=
 =?utf-8?B?djhGdVIyc3ZnQ2lYZXdpS1FmbDMzdzNZL3ZWWS9VY3BwUGpHOXJHejRIVVpB?=
 =?utf-8?B?bXRMNkJObXNhcVhQaUlzR0JTUnIzRTVZdEIyWkp4bVlpWEtIa1ZYQTBqaFRZ?=
 =?utf-8?B?RC9ZalRNOVhtS3lZaWZSK1grT2hJbklLM0tWU0hOTFljOWFEczE0UlloQmhI?=
 =?utf-8?B?U2g0UW5YYXdWeHk2KzRZZEhsZGNCck1EYWdQeXJhRW1zZy8rL3BqTm9NcEI4?=
 =?utf-8?B?ZlZhRDE1UVBmU0lLUVViZ05pckhUbzVBaWRsTzMxSnVHK0k5ak1mRmdZRkov?=
 =?utf-8?B?Q1RvOGQ1Qzg5ZUJQR211M1JKVzRiUGpvWm5laGt0b2piaDRMRTM0elpMNkVY?=
 =?utf-8?B?VThBSkxhOUVVZ1gvVk9GMzhIaWZRaWpObWhZSGM3OHoyVXhQQ3Vzd2VoZ0Jp?=
 =?utf-8?B?ZHk0OFNOeWpHUC9KZ3BCbDdYOXhrVVpGdWVIeUtTall6UkhCT25YandleEZ3?=
 =?utf-8?B?OVFwVEk4ZXVmWGdHb2Y4WEhFWjl1eExPMUxGb0dweXdnSHh3czQrNUM0UUR3?=
 =?utf-8?B?SU5jY0JmK1NVQzYzUnZXUXFvZjlaM1dGNTJEUTFMdnVHUnF3bkc4aHRWekdU?=
 =?utf-8?B?RXVUVVJEYmpzK1NDMlVkQnp4dHpOR0NsbmdZRUlFVUVJZjFiZnVaQ1d0Tm1h?=
 =?utf-8?B?d1NaMER5czJnK1FRdEZxdXJScVAxRGNtWjR0cnQwMjBPOFNwTUN5U1lJNllQ?=
 =?utf-8?B?dHNmYjRqN1d4dFN6eWZuRm1JekYwbEZiNVhuVEZ4MFBwZDVRVVRNNXBrVmtn?=
 =?utf-8?B?WjU2N04rbnFtcjdueFlOa2F0NEhxaWJGbVhyekw4K1JlU3M4dHlCc3NLZGFF?=
 =?utf-8?B?dkc1K0VmRk5TNGJpSTBmUTM1VDQ2dVhxeGhJajROTEpFNFNuSERKN1E1cktq?=
 =?utf-8?B?bEswVEdYb1NETW5mdHo0RVk1NGlmZ3BCQURLd0lxS2ZnYnp6SzN4c29ZZ1B3?=
 =?utf-8?B?cEorMURxSTB4RlJKMWFiRUtGbk9Fd0h2aU1LR3JBOGt5ZStzL2xINmY1cWdP?=
 =?utf-8?B?TFNwZ2g0VFp0S2YydVd1bXlpa0ljZkQwbUo1Q2grc1cxZkYwaVlmQmFLTG84?=
 =?utf-8?B?Q3RDRERLdEU1bkNpK1p5QjBOYXRsODN1allIYUJxMXFrc2M0d21MSUhrN3c2?=
 =?utf-8?B?YW9OZVk4ZzF3QWltRWJpV0NzM2ZXSjF4QVJNU1lpTkVNVXZNZWJkQTRjN0Fp?=
 =?utf-8?B?ZUh1cUVrcmhpUUdWUSthSFUrMVlrM2sxUmlneWVSdFhKbEJLdWVuK1BLTWZH?=
 =?utf-8?B?NHlHUC9zTjZBQkNrbG1nOUdHUlhQOVdRUEhTZ2VYR0E4TEtqRmpGMHVjQ1lI?=
 =?utf-8?B?bmhuN0Y0RjhoTktzRFBsVk4vOXR4T0lDQmViL2VWd3ZXeUVwUzhWdUMwUVFk?=
 =?utf-8?B?eDE0SlllNDI3UDk4RjF0MUcwaVRxQmlVZG1Kc3hGaVc4SGpxaEpwMU1RRXc1?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5430.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8484c2-d5e9-4c12-01f9-08d9ec3f716f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 02:45:47.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0cTwVuFNQRZGWrZaO4rQmqkR5z0ZT0T1wF8JFk99+7vouCKbwnKuKiIIdNphD9J8GSsnJfVr+tJ09G/2hLXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4414
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFiaGlzaGVrIEt1bWFyIDxr
dWFiaHNAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTAsIDIwMjIg
OTowNSBBTQ0KPiBUbzogQmFvY2hlbiBRaWFuZyAoUVVJQykgPHF1aWNfYnFpYW5nQHF1aWNpbmMu
Y29tPg0KPiBDYzogYXRoMTFrQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXdpcmVsZXNzQHZn
ZXIua2VybmVsLm9yZzsgQWJoaXNoZWsNCj4gS3VtYXIgPGt1YWJoc0BjaHJvbWl1bS5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGF0aDExazogUmVzZXQgUENJRV9HUElPX0NGR19SRUcgcmVn
aXN0ZXIgd2hlbiBwb3dlcg0KPiBvbg0KPiANCj4gT24gTW9uLCBGZWIgNywgMjAyMiBhdCAxOjQx
IEFNIEJhb2NoZW4gUWlhbmcgPHF1aWNfYnFpYW5nQHF1aWNpbmMuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+IE9uIHNvbWUgbW9kdWxlcywgUENJRV9HUElPX0NGR19SRUcgaXMgbm90IGluaXRpYWxp
emVkIHRvIHJpZ2h0IHZhbHVlLA0KPiA+IHRoaXMgd2lsbCBjYXVzZSBXQ042ODU1IGhhcmR3YXJl
IGZhaWxzIHRvIGJlIGVudW1lcmF0ZWQuDQo+ID4NCj4gPiBGaXggaXQgYnkgZm9yY2Ugd3JpdGlu
ZyB0aGUgY29ycmVjdCB2YWx1ZSB0byB0aGlzIHJlZ2lzdGVyIHdoZW4gcG93ZXINCj4gPiBvbi4N
Cj4gPg0KPiA+IFRlc3RlZC1vbjogV0NONjg1NSBodzIuMCBQQ0kNCj4gPiBXTEFOLkhTUC4xLjEt
MDE3MjAuMS1RQ0FIU1BTV1BMX1YxX1YyX1NJTElDT05aX0xJVEUtMQ0KPiBDYW4geW91IGVsYWJv
cmF0ZSBob3cgeW91IHRlc3RlZCB0aGlzID8gSSBjYW4gc2VlIGR1ZSB0byB0aGlzIHBhdGNoIHNo
b3dzDQo+IHJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlIGFmdGVyIHJ1bm5pbmcgc2lt
dWxhdGVkIHdpZmkgY3Jhc2ggaW4gYSBsb29wLg0KPiA+DQoNCkNvdWxkIHlvdSBwbGVhc2Ugc2hh
cmUgYnVpbGQgaW5mbz8gIGtlcm5lbCBsb2dzPyBZb3VyIHRlc3Qgc3RlcHMgZXRjLj8NCg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEJhb2NoZW4gUWlhbmcgPHF1aWNfYnFpYW5nQHF1aWNpbmMuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTFrL3BjaS5jIHwgMTEg
KysrKysrKysrKysNCj4gPiBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTFrL3BjaS5oIHwg
IDMgKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMWsvcGNpLmMNCj4gPiBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMWsvcGNpLmMNCj4gPiBpbmRleCBkNzNiNTIy
YTAwODEuLjA2OTY4YWQ0ODhiMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9hdGgvYXRoMTFrL3BjaS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0
aDExay9wY2kuYw0KPiA+IEBAIC00NDUsNiArNDQ1LDE2IEBAIHN0YXRpYyB2b2lkIGF0aDExa19w
Y2lfZm9yY2Vfd2FrZShzdHJ1Y3QNCj4gYXRoMTFrX2Jhc2UgKmFiKQ0KPiA+ICAgICAgICAgbWRl
bGF5KDUpOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgYXRoMTFrX3BjaV9ncGlvX3Jl
c2V0KHN0cnVjdCBhdGgxMWtfYmFzZSAqYWIpIHsNCj4gPiArICAgICAgIGludCB2YWw7DQo+ID4g
Kw0KPiA+ICsgICAgICAgYXRoMTFrX3BjaV93cml0ZTMyKGFiLCBQQ0lFX0dQSU9fQ0ZHX1JFRywg
UENJRV9HUElPX1JFU0VUX1ZBTCk7DQo+ID4gKyAgICAgICBtZGVsYXkoMTApOw0KPiA+ICsgICAg
ICAgdmFsID0gYXRoMTFrX3BjaV9yZWFkMzIoYWIsIFBDSUVfR1BJT19DRkdfUkVHKTsNCj4gPiAr
ICAgICAgIGF0aDExa19kYmcoYWIsIEFUSDExS19EQkdfUENJLCAiZ3BpbyBjZmc6IDB4JXhcbiIs
IHZhbCk7IH0NCj4gTG9va3MgbGlrZSB5b3UgaGF2ZSBhZGRlZCBkZWxheSBiZWZvcmUgcmVhZGlu
ZyB3aGljaCBnZXRzIHByaW50ZWQgYXMgYSBkZWJ1Zw0KPiBsb2cuIEluIHRoaXMgY2FzZSwgSSBk
b24ndCB0aGluayB5b3Ugc2hvdWxkIGFkZCB0aGUgdW5jb25kaXRpb25hbCBkZWxheSBhbmQgcmVh
ZA0KPiB0aGUgcmVnaXN0ZXIgdW5jb25kaXRpb25hbGx5IGJ1dCByYXRoZXIgc2hvdWxkIGRvIG9u
bHkgaWYgZGVidWcgaXMgZW5hYmxlZC4NCj4gVGhvdWdodCA/DQo+ID4gKw0KPiA+ICBzdGF0aWMg
dm9pZCBhdGgxMWtfcGNpX3N3X3Jlc2V0KHN0cnVjdCBhdGgxMWtfYmFzZSAqYWIsIGJvb2wNCj4g
PiBwb3dlcl9vbikgIHsNCj4gPiAgICAgICAgIG1kZWxheSgxMDApOw0KPiA+IEBAIC00NjEsNiAr
NDcxLDcgQEAgc3RhdGljIHZvaWQgYXRoMTFrX3BjaV9zd19yZXNldChzdHJ1Y3QgYXRoMTFrX2Jh
c2UNCj4gKmFiLCBib29sIHBvd2VyX29uKQ0KPiA+ICAgICAgICAgYXRoMTFrX3BjaV9jbGVhcl9k
YmdfcmVnaXN0ZXJzKGFiKTsNCj4gPiAgICAgICAgIGF0aDExa19wY2lfc29jX2dsb2JhbF9yZXNl
dChhYik7DQo+ID4gICAgICAgICBhdGgxMWtfbWhpX3NldF9taGljdHJsX3Jlc2V0KGFiKTsNCj4g
PiArICAgICAgIGF0aDExa19wY2lfZ3Bpb19yZXNldChhYik7DQo+ID4gIH0NCj4gPg0KPiA+ICBp
bnQgYXRoMTFrX3BjaV9nZXRfbXNpX2lycShzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGlu
dCB2ZWN0b3IpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgx
MWsvcGNpLmgNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMWsvcGNpLmgNCj4g
PiBpbmRleCA2MWQ2N2IyMGEwZWIuLjI3MTZmYzc3NDVkNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTFrL3BjaS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvYXRoL2F0aDExay9wY2kuaA0KPiA+IEBAIC01Miw2ICs1Miw5IEBADQo+ID4gICNk
ZWZpbmUgV0xBT05fUUZQUk9NX1BXUl9DVFJMX1JFRyAgICAgICAgICAgICAgMHgwMWY4MDMxYw0K
PiA+ICAjZGVmaW5lIFFGUFJPTV9QV1JfQ1RSTF9WREQ0QkxPV19NQVNLICAgICAgICAgIDB4NA0K
PiA+DQo+ID4gKyNkZWZpbmUgUENJRV9HUElPX0NGR19SRUcgICAgICAgICAgICAgICAgICAgICAg
MHgwMTgwZTAwMA0KPiA+ICsjZGVmaW5lIFBDSUVfR1BJT19SRVNFVF9WQUwgICAgICAgICAgICAg
ICAgICAgIDB4YzUNCj4gPiArDQo+ID4gIHN0cnVjdCBhdGgxMWtfbXNpX3VzZXIgew0KPiA+ICAg
ICAgICAgY2hhciAqbmFtZTsNCj4gPiAgICAgICAgIGludCBudW1fdmVjdG9yczsNCj4gPiAtLQ0K
PiA+IDIuMjUuMQ0KPiA+DQo+IA0KPiBUaGFua3MNCj4gQWJoaXNoZWsNCg==
