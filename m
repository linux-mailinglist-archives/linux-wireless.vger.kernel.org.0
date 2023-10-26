Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0DC7D8C4E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 01:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjJZXq5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 19:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXqz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 19:46:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8A7198
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698364009; x=1729900009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/rxrn157ldgZ4dB+MSQJqACNmjTcPLxuo3YJKPvKaDQ=;
  b=cN5ktC/WAUJWHuQZPqbx+oBjivZLfuyqzw+B48Zonw1Ddtx54kdMya13
   8orAyFeWJuJPeTNQJR8UvT2UNsyEwjRdY6USQJBRVnhevKB3mZRgDCSLB
   8coNa6WXgHekaHiM8Po2zNYLn3xJrsGSO1XaKlhQI66H7x1RNHJFkfL0r
   ZqMCkkIA+0bPtbXxPNgLnj8Xfkg9CEYUcjslAjfCJmeJOfSZENyXIprhm
   dojmOzNfqukXsclU4UAPPMplrDDFEUF0daWUw+hnGWPH/3ttvH+fkxk9R
   nRRPKnXUjo2jwJZWlG8xSll7Z7CicmKEzvtn7FA0Stz84v7ZTg/k+2iv6
   A==;
X-CSE-ConnectionGUID: oD9ykWEdT+mfBl2WAag4Pw==
X-CSE-MsgGUID: hLlYM3uvSAe8oSx69+T3rA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="177856403"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2023 16:46:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 26 Oct 2023 16:46:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 26 Oct 2023 16:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTC/NWxWLzl3mixqKp/wPaN0iiwmvVG0otBTWwWn04oyHPit6QgpL43+vII2XEqZWkMV1QBoeWjyHOAZ1yxeVm60QGuFakPedZDiLmt3aGaWZkATWeSc1c9tJX80RMyiNPRZauZDYPU8AzGujumBbEBuSUBz9j8e1jLg/p8rqO0BnT1cguhh2r7ZBa9vSKSswydMDAnR7Hjydl4I4F/X3M94yQmSuJfP0MjHRXPENsSQRrFSe+y9hczfh/agv1B10ZJaI5KgK0ZXAJRbFS7JWNNS5k3gIXD014ufDRMilmtZcNqEs6bUeuHLUNDBHUfwvVn+XkGMIfzFlatN1mrvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rxrn157ldgZ4dB+MSQJqACNmjTcPLxuo3YJKPvKaDQ=;
 b=UI9ASLweWUtsrXx42D0yczGyNXtQ1XtFxShurfnw7XVeoJKGMX7BIHrb1ygiD/0185fFVjHmb3Oh6Rz/onWtHngG263nu5mMvzzuae4BvIq2BeuMuz7/1AK3mZfFPtiGQCU0UEkATWVaqYk0gJP2WRBUdWOCT3PIdc/RzBuhl8Xxe5gzAgfoDTWeJ2zw7JQ2u885+M+dnUfxKV4mmzZVhFUUksbkiptq7EKp523pcyJnWjEplcmhcp56UEhOHRSbhbqfwj9LWAfQxwy3MytrR8Y05n7112fBCsfwRGry8IfSOn6mCXkKQDsHe40DJMxhG2CbNXfc39rQwLHypENzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rxrn157ldgZ4dB+MSQJqACNmjTcPLxuo3YJKPvKaDQ=;
 b=a5xthP8/49M+snUXndstmaRydvV/3ibaxN80kp+V2H/ONy5rYOvF4CJ7TMFvv7LDuUjDOvSoAlUbZ2frkWYA4pQ6GEc7q08pcE+Cx7V5OfvH7yJ/HlbJoLUP65J52nsYJJWF4dpujrkKR5kbkrl0OC9ho2fxIA4DX4xaGF8fI7g=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 23:46:25 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3c04:22dd:c79d:1788]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3c04:22dd:c79d:1788%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 23:46:25 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <dmantipov@yandex.ru>
CC:     <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: wilc1000: simplify remain on channel support
Thread-Topic: [PATCH 1/2] wifi: wilc1000: simplify remain on channel support
Thread-Index: AQHaCBZ2kWdHJRuCZkyLh46i5xbuXbBcvRaA
Date:   Thu, 26 Oct 2023 23:46:25 +0000
Message-ID: <093d085e-3162-44ee-9a42-cc20685a2a0a@microchip.com>
References: <20231026141016.71407-1-dmantipov@yandex.ru>
In-Reply-To: <20231026141016.71407-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SA1PR11MB7014:EE_
x-ms-office365-filtering-correlation-id: 1501361e-c0bc-4c86-5ae8-08dbd67dc46e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z6ccj+XzWDok5HrOzts+FtyJJk7zgb9buQvI4woLkN0MrzK1Clz45AUsCLISHGRcu/xdLVM7+k6vRRuAgcjCTGK6aaMPkAJjiNoWmJ0yod1si917eswrAxDWK5tWKTkXpDF4AfteLDaH31A/ujrZlcwJ1DAD4nuwo/7yYuEnjJfw0L0a/RU1bXX7QrO1/RAaJkTZmcOcVJH2QqnjXoSCB8f4aVRrtZ7WwRAzYAW3WPwgnwaZTTsuuVatqtDQKhbWznjV360firOpiR3Ca//tFCofSjbKwqxEMgsJUv6aT12tewEQDZ2o4t4FvmV7/Ea20/ukk/n7Gs4hamTjJyAXWFg2ZLm98N7O4SUPv3hcjb1yhquLL+EDuBfHydRYOfL6ditz9Qf0ibqYNa8QlYsnFPZFuhBmyzl1003jwaPZj9aHeiE42KlWnKZaayZMBgaXl6XmN7ZPYRiL+Ml7SisTRaeEyo9DdZwEgIVEvDDrmyfyXDce5DOJbYU/qJmEXjrT9VjCFvpuHDLrPbptdpY/pvwFgA6ZqbssB2sUu32jkoZVKI+WYlj/0dqwkVQ3l1HarMSlvOWBQPflgTRfZL3Pj2n91hA8luhsRVU2UyTEuJyh0stZBl1ANMomk+9mzB9cCaJ6S8F6PJKYrdCZSjoHhe6YnJclMVPTohR1eK+MqLRDSCj0CApNsh27MKfkfYiecUZoL0FXaU64KFjKrdJ5q00A+Ko9lC+OV50VeC2rNsU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(38070700009)(31686004)(38100700002)(41300700001)(2906002)(31696002)(5660300002)(36756003)(86362001)(8936002)(8676002)(2616005)(4326008)(26005)(6506007)(91956017)(66946007)(6512007)(66446008)(71200400001)(122000001)(316002)(66556008)(6916009)(54906003)(66476007)(76116006)(64756008)(478600001)(83380400001)(6486002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkVrdWVDYitpQzBXYUlWVk51Sk0vRVY0SXk4M3hZR2JLQmdPVTdNZEFZenVj?=
 =?utf-8?B?eDl2Y21rbkJZOXRKdWk2bm9vV2phSlVoQTdjbkVSZjdLQmV3SFVoY01HRXJv?=
 =?utf-8?B?MTMwalpBWVBNU3hNaFR1WG5kQUw2N21QaGphZlF1WGVHd0xFdlEreWZNNkpo?=
 =?utf-8?B?N0RYdW15Wk5zKzhKZ3JET2xobE1pN0lSTWl3Y0gxbjRpdWtsL2RiNldLUGhU?=
 =?utf-8?B?MTR4YURzN2NBSThJckZxOTBIV0U4RDN6Ylowb3BPUTNJRHFvZmdIY2xyWDU2?=
 =?utf-8?B?SnpQd21nd1Nkc0xyOTVZRzVabUhKQXhVdVJNempiL2xjYVdYZ0J5N2p5UHJi?=
 =?utf-8?B?QWVmWXNtS0VGWkErWW5sWXNaeHhFUkZoVEZCSWdqeU9ob0lDUDJ2cXhIQVNM?=
 =?utf-8?B?Nm85cEZXanlBMEs0UVRTaTJFdHlKUjlNMjJxcjVsSkpZeWVyR3VPbEdzOVNR?=
 =?utf-8?B?TStLai9HQmFyc1pWdHhNTnpTR0FUK0N4MUJzREgrMkdnajNaSkpJOWxiRGxL?=
 =?utf-8?B?WTNQTm9kdmZGeTZDZWtzU09TYnVkWklkSkl6ajArdEVZU0laSFl4eTFxTjZY?=
 =?utf-8?B?aEZTcFpXQW5aejl3ejZLRXcyMWlxZEloTTZXMFFJNWxMTTdlR1Z4MTBmWWh4?=
 =?utf-8?B?NHI0UjFydHdVMDM3U3E0cWE4L29DejZQTjNldGVUeTZUZzJqWk8zRDNyVHpU?=
 =?utf-8?B?NU4yLzNXaWJ0WmNNOTZqVlF2OGRkaVl4a0VJbHZBS3pKeE9za3pUVEFNS25E?=
 =?utf-8?B?dnVrRTArZ05Hbm9pVnAzQ0ZkT1RNOEtmcjk0OFRNTUViOHE1cjZSNkZxZzRk?=
 =?utf-8?B?QXRMNWYva3Q3VUhValBKZ2Nrb21TVHpsTE0xUjU5SWNmZlQyaFY1UG0xeWx5?=
 =?utf-8?B?eE1WdmZGVlN2V1kzUzdZUUtQUGhOd05TWEFoZkQ4ckJGSXhJUnBmRXdEaFVu?=
 =?utf-8?B?NGVjQ0dOYXhEUmsrVFcvMlh1SkQvWVlMYisrZVlIVnFoWmNES1QxdXFRVnEw?=
 =?utf-8?B?QThka2ZsaEhDQ21RZi9qM2w1aWlWZ28raXVNZ24rM3B2YUV5UVpqMTkxU3l6?=
 =?utf-8?B?R0RoNEptZHY4alFYcnN0V0xFdnlWWEdsVUN6VFVoR1VmVnhGVnpQVnRFQUQr?=
 =?utf-8?B?NlI5MGx3YmllZkIwNW94N1R5cXpjVmFhOVlsOUkxMVk3dkVkdTl2RFN1NUVy?=
 =?utf-8?B?SDUrUU9GVVVHNDFqTGpmL2pNVlRuMUJTemtXdFArSVdYT2N2Q250MXZFK3ZM?=
 =?utf-8?B?U2tqMlJnUHdHeUNuSTNxOG1KbUt0c1NzUVE4NVl0SjB0QU42Y0dpbDQxTEtz?=
 =?utf-8?B?cXFjSjJwb1ByU0tjci96MENpN21kK2VKbCtUODJSY0tOTktNVlE1dHhnMXNM?=
 =?utf-8?B?OW9qZGxKUGRxaWluVVladFFHaFJKRDVlZTRXQzh5N05ycVA1bTA1MXVRQWVL?=
 =?utf-8?B?eGMvc0tTVGJmSytwTFIwWjl5elJvaTVVbFZlZkJtWHprRGNQL3NGUm5NcUhO?=
 =?utf-8?B?Q2xERG1YU1l1bUY4b1EwNnlGNVM2V2RWVlFGUVVlUjczN2RTWjFpalhWWTJT?=
 =?utf-8?B?dFQ1aHN2TUROTVliTmdKNnY3NEV1TXFjd3I2WVVtQXZ2WUJWTE5qdi84SWxx?=
 =?utf-8?B?d2N0clZaaFhCcXcybWNGaklIK05aQ2w3M2p3b0RBRmZ0OWxubEo0UmNYV2R6?=
 =?utf-8?B?ZGpjWHd2aVBRcGFuY1RzL0srRUhrdndSTzNxYTZWN3RwNng4R2FyNnloallX?=
 =?utf-8?B?RkpQTGFrQTcxQ3F2S0liOGFUZUYrZFZGemFKSTVXU0dCSVM4eFZoV29iMi8r?=
 =?utf-8?B?Q3ByZnRTY05iWTVvcDVSNnAxcHYrbm1LbWZMWWVBdGpiZTlScWdzMVhROXJZ?=
 =?utf-8?B?ckZiNXppWFQ0QlBEcGorRDUyOW5XMklaazVtUTdmNHBwUWhSayt2ck5QTkRI?=
 =?utf-8?B?azJwdnJOWDJveU9RZ3JCRE5GUjVhTmo0YjlCSGRMZlMvMkwrczQzbGJYYTlU?=
 =?utf-8?B?d1o5ejlUbWR5Ync5SkF0dWFaMUdtZ2c4ektSeDJyNmY0SEw5MmdVS0JFd2ZY?=
 =?utf-8?B?clF1S2daQ3V0VDdwYnFMRjhCWXlvU0hja1o4SWZOOW15TE9jRFZoWkdkQkJt?=
 =?utf-8?Q?29MMfBS1e948q7G/30rw6zvKy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9CB6335B4C9DE4684BA88C2D444BF9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1501361e-c0bc-4c86-5ae8-08dbd67dc46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 23:46:25.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhTSkkl2Lo6wlIrfTg6TnqdeG/s81LEnQ6wbK7P6ektx4t3FPX279Wzc8++26U6/M7Eq7c55R+jyKNaVvs/PDGZFmwPjY2/WqIGDfYrvw+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMTAvMjYvMjMgMDc6MTAsIERtaXRyeSBBbnRpcG92IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZvciAnc3RydWN0IHdpbGNfcmVtYWluX2NoJywg
ZHJvcCBzZXQgYnV0IG90aGVyd2lzZSB1bnVzZWQgJ2R1cmF0aW9uJw0KPiBmaWVsZCBhbmQgYWRq
dXN0ICdleHBpcmVkJyBjYWxsYmFjayBhc3N1bWluZyB0aGF0IHRoZSBvbmx5IGRhdGEgcGFzc2Vk
DQo+IHRvIGl0IGlzICdzdHJ1Y3Qgd2lsY192aWYgKicsIHRodXMgbWFraW5nICd3aWxjX3JlbWFp
bl9vbl9jaGFubmVsKCknDQo+IGEgYml0IHNpbXBsZXIgYXMgd2VsbC4gQ29tcGlsZSB0ZXN0ZWQg
b25seS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBBbnRpcG92IDxkbWFudGlwb3ZAeWFu
ZGV4LnJ1Pg0KDQpBY2tlZC1ieTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9j
Zmc4MDIxMS5jIHwgIDggKysrLS0tLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hp
cC93aWxjMTAwMC9oaWYuYyAgICAgIHwgMTMgKysrKystLS0tLS0tLQ0KPiAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5oICAgICAgfCAxMyArKysrKy0tLS0tLS0t
DQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAw
MC9jZmc4MDIxMS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2Nm
ZzgwMjExLmMNCj4gaW5kZXggZGE1MmY5MTY5M2I1Li5iZjJhNjA1MzM1MDYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9jZmc4MDIxMS5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9jZmc4MDIxMS5j
DQo+IEBAIC0xMDk0LDkgKzEwOTQsOCBAQCBzdGF0aWMgdm9pZCB3aWxjX3dmaV9tZ210X3R4X2Nv
bXBsZXRlKHZvaWQgKnByaXYsIGludCBzdGF0dXMpDQo+ICAgICAgICAga2ZyZWUocHZfZGF0YSk7
DQo+ICB9DQo+IA0KPiAtc3RhdGljIHZvaWQgd2lsY193ZmlfcmVtYWluX29uX2NoYW5uZWxfZXhw
aXJlZCh2b2lkICpkYXRhLCB1NjQgY29va2llKQ0KPiArc3RhdGljIHZvaWQgd2lsY193ZmlfcmVt
YWluX29uX2NoYW5uZWxfZXhwaXJlZChzdHJ1Y3Qgd2lsY192aWYgKnZpZiwgdTY0IGNvb2tpZSkN
Cj4gIHsNCj4gLSAgICAgICBzdHJ1Y3Qgd2lsY192aWYgKnZpZiA9IGRhdGE7DQo+ICAgICAgICAg
c3RydWN0IHdpbGNfcHJpdiAqcHJpdiA9ICZ2aWYtPnByaXY7DQo+ICAgICAgICAgc3RydWN0IHdp
bGNfd2ZpX3AycF9saXN0ZW5fcGFyYW1zICpwYXJhbXMgPSAmcHJpdi0+cmVtYWluX29uX2NoX3Bh
cmFtczsNCj4gDQo+IEBAIC0xMTI4LDkgKzExMjcsOCBAQCBzdGF0aWMgaW50IHJlbWFpbl9vbl9j
aGFubmVsKHN0cnVjdCB3aXBoeSAqd2lwaHksDQo+ICAgICAgICAgaWYgKGlkID09IDApDQo+ICAg
ICAgICAgICAgICAgICBpZCA9ICsrcHJpdi0+aW5jX3JvY19jb29raWU7DQo+IA0KPiAtICAgICAg
IHJldCA9IHdpbGNfcmVtYWluX29uX2NoYW5uZWwodmlmLCBpZCwgZHVyYXRpb24sIGNoYW4tPmh3
X3ZhbHVlLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2lsY193Zmlf
cmVtYWluX29uX2NoYW5uZWxfZXhwaXJlZCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICh2b2lkICopdmlmKTsNCj4gKyAgICAgICByZXQgPSB3aWxjX3JlbWFpbl9vbl9j
aGFubmVsKHZpZiwgaWQsIGNoYW4tPmh3X3ZhbHVlLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgd2lsY193ZmlfcmVtYWluX29uX2NoYW5uZWxfZXhwaXJlZCk7DQo+ICAg
ICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5jDQo+IGluZGV4IGEy
OGRhNTkzODQ4MS4uMmM0MjY4M2RkNWZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvaGlmLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5jDQo+IEBAIC04NzgsNyArODc4LDcgQEAgc3RhdGlj
IGludCBoYW5kbGVfcmVtYWluX29uX2NoYW4oc3RydWN0IHdpbGNfdmlmICp2aWYsDQo+ICAgICAg
ICAgaWYgKHJlc3VsdCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+IA0KPiAt
ICAgICAgIGhpZl9kcnYtPnJlbWFpbl9vbl9jaC5hcmcgPSBoaWZfcmVtYWluX2NoLT5hcmc7DQo+
ICsgICAgICAgaGlmX2Rydi0+cmVtYWluX29uX2NoLnZpZiA9IGhpZl9yZW1haW5fY2gtPnZpZjsN
Cj4gICAgICAgICBoaWZfZHJ2LT5yZW1haW5fb25fY2guZXhwaXJlZCA9IGhpZl9yZW1haW5fY2gt
PmV4cGlyZWQ7DQo+ICAgICAgICAgaGlmX2Rydi0+cmVtYWluX29uX2NoLmNoID0gaGlmX3JlbWFp
bl9jaC0+Y2g7DQo+ICAgICAgICAgaGlmX2Rydi0+cmVtYWluX29uX2NoLmNvb2tpZSA9IGhpZl9y
ZW1haW5fY2gtPmNvb2tpZTsNCj4gQEAgLTkxNSw3ICs5MTUsNyBAQCBzdGF0aWMgaW50IHdpbGNf
aGFuZGxlX3JvY19leHBpcmVkKHN0cnVjdCB3aWxjX3ZpZiAqdmlmLCB1NjQgY29va2llKQ0KPiAg
ICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAgIGlmIChoaWZfZHJ2LT5yZW1h
aW5fb25fY2guZXhwaXJlZCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBoaWZfZHJ2LT5y
ZW1haW5fb25fY2guZXhwaXJlZChoaWZfZHJ2LT5yZW1haW5fb25fY2guYXJnLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBoaWZfZHJ2LT5yZW1haW5fb25fY2guZXhwaXJlZChoaWZfZHJ2LT5y
ZW1haW5fb25fY2gudmlmLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb29raWUpOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAg
IH0gZWxzZSB7DQo+IEBAIC0xNjY5LDE4ICsxNjY5LDE1IEBAIHZvaWQgd2lsY19zY2FuX2NvbXBs
ZXRlX3JlY2VpdmVkKHN0cnVjdCB3aWxjICp3aWxjLCB1OCAqYnVmZmVyLCB1MzIgbGVuZ3RoKQ0K
PiAgICAgICAgIH0NCj4gIH0NCj4gDQo+IC1pbnQgd2lsY19yZW1haW5fb25fY2hhbm5lbChzdHJ1
Y3Qgd2lsY192aWYgKnZpZiwgdTY0IGNvb2tpZSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgdTMyIGR1cmF0aW9uLCB1MTYgY2hhbiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
dm9pZCAoKmV4cGlyZWQpKHZvaWQgKiwgdTY0KSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgdm9pZCAqdXNlcl9hcmcpDQo+ICtpbnQgd2lsY19yZW1haW5fb25fY2hhbm5lbChzdHJ1Y3Qg
d2lsY192aWYgKnZpZiwgdTY0IGNvb2tpZSwgdTE2IGNoYW4sDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKCpleHBpcmVkKShzdHJ1Y3Qgd2lsY192aWYgKiwgdTY0KSkNCj4gIHsN
Cj4gICAgICAgICBzdHJ1Y3Qgd2lsY19yZW1haW5fY2ggcm9jOw0KPiAgICAgICAgIGludCByZXN1
bHQ7DQo+IA0KPiAgICAgICAgIHJvYy5jaCA9IGNoYW47DQo+ICAgICAgICAgcm9jLmV4cGlyZWQg
PSBleHBpcmVkOw0KPiAtICAgICAgIHJvYy5hcmcgPSB1c2VyX2FyZzsNCj4gLSAgICAgICByb2Mu
ZHVyYXRpb24gPSBkdXJhdGlvbjsNCj4gKyAgICAgICByb2MudmlmID0gdmlmOw0KPiAgICAgICAg
IHJvYy5jb29raWUgPSBjb29raWU7DQo+ICAgICAgICAgcmVzdWx0ID0gaGFuZGxlX3JlbWFpbl9v
bl9jaGFuKHZpZiwgJnJvYyk7DQo+ICAgICAgICAgaWYgKHJlc3VsdCkNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuaCBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuaA0KPiBpbmRleCA4ZTM4NmRiNzJl
NDUuLmIwY2IzNTU5MDAyNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWlj
cm9jaGlwL3dpbGMxMDAwL2hpZi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3Jv
Y2hpcC93aWxjMTAwMC9oaWYuaA0KPiBAQCAtMTE4LDExICsxMTgsMTEgQEAgc3RydWN0IHdpbGNf
Y29ubl9pbmZvIHsNCj4gICAgICAgICB2b2lkICpwYXJhbTsNCj4gIH07DQo+IA0KPiArc3RydWN0
IHdpbGNfdmlmOw0KPiAgc3RydWN0IHdpbGNfcmVtYWluX2NoIHsNCj4gICAgICAgICB1MTYgY2g7
DQo+IC0gICAgICAgdTMyIGR1cmF0aW9uOw0KPiAtICAgICAgIHZvaWQgKCpleHBpcmVkKSh2b2lk
ICpwcml2LCB1NjQgY29va2llKTsNCj4gLSAgICAgICB2b2lkICphcmc7DQo+ICsgICAgICAgdm9p
ZCAoKmV4cGlyZWQpKHN0cnVjdCB3aWxjX3ZpZiAqdmlmLCB1NjQgY29va2llKTsNCj4gKyAgICAg
ICBzdHJ1Y3Qgd2lsY192aWYgKnZpZjsNCj4gICAgICAgICB1NjQgY29va2llOw0KPiAgfTsNCj4g
DQo+IEBAIC0xNTAsNyArMTUwLDYgQEAgc3RydWN0IGhvc3RfaWZfZHJ2IHsNCj4gICAgICAgICB1
OCBhc3NvY19yZXNwW1dJTENfTUFYX0FTU09DX1JFU1BfRlJBTUVfU0laRV07DQo+ICB9Ow0KPiAN
Cj4gLXN0cnVjdCB3aWxjX3ZpZjsNCj4gIGludCB3aWxjX2FkZF9wdGsoc3RydWN0IHdpbGNfdmlm
ICp2aWYsIGNvbnN0IHU4ICpwdGssIHU4IHB0a19rZXlfbGVuLA0KPiAgICAgICAgICAgICAgICAg
IGNvbnN0IHU4ICptYWNfYWRkciwgY29uc3QgdTggKnJ4X21pYywgY29uc3QgdTggKnR4X21pYywN
Cj4gICAgICAgICAgICAgICAgICB1OCBtb2RlLCB1OCBjaXBoZXJfbW9kZSwgdTggaW5kZXgpOw0K
PiBAQCAtMTkyLDEwICsxOTEsOCBAQCBpbnQgd2lsY19lZGl0X3N0YXRpb24oc3RydWN0IHdpbGNf
dmlmICp2aWYsIGNvbnN0IHU4ICptYWMsDQo+ICBpbnQgd2lsY19zZXRfcG93ZXJfbWdtdChzdHJ1
Y3Qgd2lsY192aWYgKnZpZiwgYm9vbCBlbmFibGVkLCB1MzIgdGltZW91dCk7DQo+ICBpbnQgd2ls
Y19zZXR1cF9tdWx0aWNhc3RfZmlsdGVyKHN0cnVjdCB3aWxjX3ZpZiAqdmlmLCB1MzIgZW5hYmxl
ZCwgdTMyIGNvdW50LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4ICptY19s
aXN0KTsNCj4gLWludCB3aWxjX3JlbWFpbl9vbl9jaGFubmVsKHN0cnVjdCB3aWxjX3ZpZiAqdmlm
LCB1NjQgY29va2llLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgZHVyYXRpb24s
IHUxNiBjaGFuLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICgqZXhwaXJlZCko
dm9pZCAqLCB1NjQpLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICp1c2VyX2Fy
Zyk7DQo+ICtpbnQgd2lsY19yZW1haW5fb25fY2hhbm5lbChzdHJ1Y3Qgd2lsY192aWYgKnZpZiwg
dTY0IGNvb2tpZSwgdTE2IGNoYW4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQg
KCpleHBpcmVkKShzdHJ1Y3Qgd2lsY192aWYgKiwgdTY0KSk7DQo+ICBpbnQgd2lsY19saXN0ZW5f
c3RhdGVfZXhwaXJlZChzdHJ1Y3Qgd2lsY192aWYgKnZpZiwgdTY0IGNvb2tpZSk7DQo+ICB2b2lk
IHdpbGNfZnJhbWVfcmVnaXN0ZXIoc3RydWN0IHdpbGNfdmlmICp2aWYsIHUxNiBmcmFtZV90eXBl
LCBib29sIHJlZyk7DQo+ICBpbnQgd2lsY19zZXRfb3BlcmF0aW9uX21vZGUoc3RydWN0IHdpbGNf
dmlmICp2aWYsIGludCBpbmRleCwgdTggbW9kZSwNCj4gLS0NCj4gMi40MS4wDQo+IA0KDQo=
