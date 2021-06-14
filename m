Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336C73A6CFF
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhFNRU3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 13:20:29 -0400
Received: from mail-eopbgr00122.outbound.protection.outlook.com ([40.107.0.122]:49742
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235582AbhFNRU1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 13:20:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEUe4F9fQGIsEC6Qb/580XWTuDjIHWfPSQOr2TZXycMVW7eKzeFOqmMo6Af9G3T77tzmbxubjfKKWqUhD1bh9aDUluyzvWOyL4oLY5wGPB8avnCqhX2LPxIdM1nE5D9DPuIMerF3ya8j9NGiJ0XqO7Q/mhkfMPP3lXNl1rxiCTpNEZVjiaOGTMX9HRyh08j5gCvFQf84u56DGZMcYWjAg5F67na1Dl+JH0lKElBMDYF8O/D/ldRf4Kjdcu9ISzlQ3m/z1pfbDirEtCw1YsFOVFo3/QK61uKOcCoEu6iAHHrHhzM1tOeIYexOytdDnsA/DPLX9erucc7Dg7dz/vY/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEfmqAL3lMeM7CuPDF7bhAvIuzHL8ujXB5N6GHvXA7g=;
 b=kSt0CNHCU3bNresWHTIwJA4RBK68v4ifMM/5aR2PoEH1wYTuiVJFTQQuTGEdvKrJT+IpOpuEGgiYyrd1Ve0C80kib5rX45oibywwvSrKJYwIFQAbUt+P6H0cVquQipQTHPO8VL53ks0jwXa3yVXoVnbf18sYARjYquQksYKuy34pAxjh/nKS95rNO659xB9v76MkososiTCEdv2I4JTX5YWSFo/cYr7yTRihVF7rh9Tb3DZVnPMbdeUq/LRHIuMm6MCECfMNyUt034pCuT9Uq2xGYWmGur2df7BwmqvcNH1osK8yaxigUVUcviEzyyc9BBPn+01M4AVvqhSeRvh10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEfmqAL3lMeM7CuPDF7bhAvIuzHL8ujXB5N6GHvXA7g=;
 b=UhqD3HyQ1xLG0qV5S4dG6e2IVy6zw2Ogc6CNaU/nMCoHzPtcMmICrWfbZC12KJoPbZqav8QBS83OdK7TsybLDXcMR9YHwKIsx1+VgW17NbYzv0rImuAI13Sh368pjTZXcNrcEDGU1cjK2TjCF2tVtWS0HGkel23inWp61ak3fAs=
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VE1PR03MB5152.eurprd03.prod.outlook.com (2603:10a6:802:ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Mon, 14 Jun
 2021 17:18:21 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::1134:eb4d:952c:85fb]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::1134:eb4d:952c:85fb%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:18:21 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Kalle Valo <kvalo@codeaurora.org>,
        =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>
CC:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
Subject: Re: [PATCH 1/2] brcmfmac: fix setting of station info chains bitmask
Thread-Topic: [PATCH 1/2] brcmfmac: fix setting of station info chains bitmask
Thread-Index: AQHXQnqLrkcIm6m/cUuFlqnvRe20bqsTu4qAgAAUKUeAAC3jAA==
Date:   Mon, 14 Jun 2021 17:18:21 +0000
Message-ID: <3dec15fc-568c-806e-e1b6-1b40b75135a0@bang-olufsen.dk>
References: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
 <ea5a0ce5-1bc9-774c-06be-6ecc284531c5@pqrs.dk>
 <87wnqwy0r7.fsf@codeaurora.org>
In-Reply-To: <87wnqwy0r7.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=bang-olufsen.dk;
x-originating-ip: [80.71.142.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14ecb705-da33-4577-2c12-08d92f5868cc
x-ms-traffictypediagnostic: VE1PR03MB5152:
x-microsoft-antispam-prvs: <VE1PR03MB5152EAF8180702D9312AF2B483319@VE1PR03MB5152.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJezWT/LkC6mKCOLx38kCMzH8VRheEInSZndqBtlXrSC73J2oTVxd54Kq53I3YmQgK5+pCyKAFaft4oEri+m7WRjYV2tWLd4r5cfbK0oKH3cD+jVc2Oc6H4ZGmUA+R7TxF9aMJWV8cS4FWiYVOVakJZGWTuOOZrqCuwLeChMkzerUbybJl0az8QocMrRO+mTwmkybHk3MvjvRMtpYgAsxZreiplG4rATxfk81PyFCIVac5+JFYbPCFBKZASgmRHvcjEPaUJLoJA2KRYJlESFgWZk2HQTlN0AoEM66S34rgHUk26EZmVqQrxhRUsc58XA+5I1MxmdY99CDDCZa0F7ADpF1BVslqn9XlMDyePRpfiffZ2o2apXymr6I4lMjVKnTqEPhmx8Hk2tWIX2Dgq8al8gFkhSw7LoFKj6FxgPAaXLYf/1d8MWmkje7jFG5oPP25+x/S+HikajexTdAgW+yuISo9aWH98qQQ175RV+cJ9yVLYE11nYZU30ZVRVU2LKjfgIyABTloS+zRNWfphf6op3Hkgkndr09qdkYt3hA6AID5k+RsDTbrwSRjmzVRU/5U6mVoRFGfZisiJsw1YYSjb8llNZVp0xkPvuhKqlmWbOQf5xX3UCxZlLjcLqqOQw7cVU+XcWlHrOlJQNvRY1DpZjZTOlsqc1ek2K/eM2V9/jDg+z/CgG9OBjJKHyrc1DowVbeyA6vCMg4WySEg76rUz36R/y2m6gbQbJjY7PxyAcHS19CkuJwkwU4PI7AlYxgkpdrc057t0kMpEOtYz0xdUot9cs38S3WPUL4/4W/x0MV5mmJ929DboWCtGReDZH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39830400003)(396003)(110136005)(6486002)(2906002)(6512007)(31696002)(85182001)(4744005)(54906003)(36756003)(7416002)(26005)(71200400001)(186003)(2616005)(316002)(83380400001)(478600001)(31686004)(86362001)(966005)(4326008)(53546011)(5660300002)(66946007)(64756008)(66446008)(66476007)(66556008)(6506007)(8676002)(85202003)(91956017)(66574015)(76116006)(8976002)(8936002)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEtMQzB4U3BPMUxLdjNaeEw3QnJTbGQ0c20rMHZ0bDNONklYOXVTaE9JMnky?=
 =?utf-8?B?NUVqcy9WQjFsNWFHbWhNU3l5VlNtQmpoZ3AzeWJWSHVNZXdGQmVrWTZyVjlm?=
 =?utf-8?B?bE0xSno3YmhFQ2V3aDhTcTVjeHk0dWF0K1FEaUZVK3B0ZVB2bWExNHJDb0hW?=
 =?utf-8?B?dG93dlNZQVBRVVlHRU5idWtkUms0akt6OG82djI2aUFCVXQxa3ZYWXRkMTRC?=
 =?utf-8?B?VUJSQkt1V2Y0QnJObjdxdERJUm5VNElaK2RZTzhQQ21rOEg1OU1MbjFJcDNE?=
 =?utf-8?B?Q0FJV2pyM29IMWtieEluYWV4K0JUV21rSWdmeTlGZmsvWXppTEtOdUhuVkxL?=
 =?utf-8?B?MkxEUDhSRzZjQkc5cm9TUUNNSWM0MGdHR2RIRit1aG5kYlRDY0w5dGNlek80?=
 =?utf-8?B?OUJrN29DVXRYQ0hwS21HTjc1azNONE9xbnUrRGgwek5xTFAyZ085RmhEbUN2?=
 =?utf-8?B?OW0yQzFxeTRSdVpDNzFGRENnWEQwMGRCelJEek5URENFRDNPekU2a3ZHcXlF?=
 =?utf-8?B?RlNxVEw1bWZ0cnRQVHMycFNKWDVFMVRXWUVRUFdkc2huTzVvaGRxbnpYaFRP?=
 =?utf-8?B?cXlrU3lLUTZEK0x2Ni9iU2lZYzFxcjBBbDRIVXR6Znd6TjZGQjkxM0VQZFhT?=
 =?utf-8?B?eEhlRDcvdkZRNXNjUHFsRW45UkZNVGdjOFVMS2hSdjljaG9qRzEwb0RsRG1m?=
 =?utf-8?B?bHJEcTJSTVFwWmxWQnZaTEZaelhYVTRJaENpKzVGbm9FR2NBNUNVRFRmMW5l?=
 =?utf-8?B?bDFFS1diRzk2KzhsKzhZYURTRDN3UlpCVXNoZVZNSG9NT1R2YmZDTHlWTFJa?=
 =?utf-8?B?OXp2Y1c5OWp0ZTBUTExNWlIxRm5tYXJUSDFlY1QxT1B1SkJYQXVERkRLOHZy?=
 =?utf-8?B?Q3g1M0d1U0xIbEN6QlFsY2Rnby9yL05wUUkxcTVvY0pjM3ZKTEJhKzNVZU4y?=
 =?utf-8?B?QXErVUJsbUtLdmFWeThiOXhNRVNTUkJrZ3BxejJwK2hHb0Z3enZjWGFGZGhj?=
 =?utf-8?B?VXJIamxVYTlRUXY1c0hObmg5UkJlcGhEUlRsa1djbFVqK1UwK1FWYWJyQzRp?=
 =?utf-8?B?VUY5cVNJbUZGYzFvb25hc1V0Nnk3Sy9aM2pwenJ3bHZ2M3ptUVR0dGVnL2Jk?=
 =?utf-8?B?YnROZENKVkJFdjlPd3JQMmtvN2NCVXRYdGFzYnNkQ0V2VXdJSDdRbm5Ka3hG?=
 =?utf-8?B?ZFVNWHpkYU5XRHlqcG1MblFKL1ZjRnUybnRPZi9iNVNFZERieXc3K3JHblN6?=
 =?utf-8?B?VHU3c1ArUjF5cE4zOUdYVGhoYUE5VlNHc1ErUWlEeXFWbEsyS1NZT2dXRFhX?=
 =?utf-8?B?VENSaDdDOEtKU3lOSGRHLzMzNGhpd1I5OWhwNEdmUUY2MFZicFBxNmQ3bkpn?=
 =?utf-8?B?MzZVeml1ZXFsa0NNRE1nZWVnVVI5NUFxSmZuRE03OTFIYW5OMUZmYU9YZ014?=
 =?utf-8?B?Lzcvd3BaclIyeU1YUVQwSk1iNm1BbU9URzZoTEQvTjZuUGgyZEJzbjE2dUow?=
 =?utf-8?B?eVRjQ0RoLzU0MS9VUlVOWTdvcGNaYzRSVEdtRFZWaXVUOUJaWGNhdDFHN0c0?=
 =?utf-8?B?NFFvd0xsc2FJNks5NkVuc1ZUT1pxMzJZMnVua2tZZDMyME95VXpzRHRrUHEw?=
 =?utf-8?B?ZEo1UHdYUDZnelBIM1hwSXlNbHdhbDFOdjhIamJJL1RVZktwcmQ5NFZtVXA3?=
 =?utf-8?B?TDlTZFB5RmNldlZtcWVJejlRM1JLcStZZndTSGZKeWFQNjh6MUUyd1FaUkxs?=
 =?utf-8?Q?fCgjjixedhCwoe+vEWqIAR7Saum0AYb2Gt3KIdm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <66114D76D63E7F4CA71B84DE94723CBA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ecb705-da33-4577-2c12-08d92f5868cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 17:18:21.0774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xmg3wfcdST7bXyhy5Rg1RsWSod7/aUM5z+Nh1iN5198URZkKQM71TX9izxhMq/uLCrBJIW3pICDB3SFpFCSS0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5152
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDYvMTQvMjEgNDozMyBQTSwgS2FsbGUgVmFsbyB3cm90ZToNCj4gQWx2
aW4gxaBpcHJhZ2EgPGFsdmluQHBxcnMuZGs+IHdyaXRlczoNCj4gDQo+PiBIZWxsbywNCj4+DQo+
PiBPbiA1LzYvMjEgMzoyMCBQTSwgQWx2aW4gxaBpcHJhZ2Egd3JvdGU6DQo+Pj4gVGhlIHNpbmZv
LT5jaGFpbnMgZmllbGQgaXMgYSBiaXRtYXNrIGZvciBmaWxsZWQgdmFsdWVzIGluIGNoYWluX3Np
Z25hbA0KPj4+IGFuZCBjaGFpbl9zaWduYWxfYXZnLCBub3QgYSBjb3VudC4gVHJlYXQgaXQgYXMg
c3VjaCBzbyB0aGF0IHRoZSBkcml2ZXINCj4+PiBjYW4gcHJvcGVybHkgcmVwb3J0IHBlci1jaGFp
biBSU1NJIGluZm9ybWF0aW9uLg0KPj4+DQo+Pg0KPj4gPHNuaXA+DQo+Pg0KPj4gVGhpcyBpcyBh
IGdlbnRsZSBwaW5nIHRvIHNlZSBpZiB0aGVzZSB0d28gcGF0Y2hlcyBnb3QgbG9zdC4gSSB3YXMg
dG9sZA0KPj4gb24gYW5vdGhlciBtYWlsaW5nIGxpc3QgcmVjZW50bHkgdGhhdCBtYWlsIHNlbnQg
ZnJvbSBteSB3b3JrIGFkZHJlc3MNCj4+IGlzIGZpbmRpbmcgaXRzIHdheSBpbnRvIHBlb3BsZXMn
IGp1bmsgZm9sZGVycy4NCj4+DQo+PiBJIHdpbGwgcmVzZW5kIHRoZSBwYXRjaGVzIGluIHRoZSBu
ZWFyIGZ1dHVyZSBpZiBJIGRvbid0IHNlZSBhbnkNCj4+IHJlc3BvbnNlIGhlcmUuDQo+IA0KPiBJ
IGp1c3QgaGF2ZSBiZWVuIGJ1c3kgYW5kIGhlYXZpbHkgYmFja2xvZ2dlZC4gVGhlIHBhdGNoZXMg
YXJlIGluDQo+IHBhdGNod29yaywgc28gbm8gbmVlZCB0byByZXNlbmQ6DQo+IA0KPiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvbGlzdC8/c2VyaWVz
PTQ3Nzg3NyZzdGF0ZT0qPj4gDQoNCkdyZWF0IC0gdGhhbmtzIGZvciB0aGUgcXVpY2sgcmVwbHku
IEkgd2lsbCBub3QgcmVzZW5kLg0KDQpLaW5kIHJlZ2FyZHMsDQpBbHZpbg==
