Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69976E0084
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 23:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLVK7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 17:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLVK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 17:10:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2A5244
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681333855; x=1712869855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LNZjzCnwDX7WBXZVPVr3F9qraaFmaythXK7K0cgkh9s=;
  b=pTsRC8HPsYPiftCeNuI8o4GBB5akQs9WhFpbxTSeqCaBVpELyeTb+QYv
   87OFSW4a6wMUGBBceCvrN6qvp+Q2zKmm6sJ4c3R+CGwj3rRojPojhkp1I
   wVQZPSFyQbgrzlmQ3v6BhE0R/myUL1R4egAMTpKVfDNtkzgcveQ1XfZRM
   x/UPeFRsypcTfTsJ4qtBAOa4sPrtEpUbgV44Alj5T+pZlAem0f+wk3i+K
   p0s7RDvarme+Ztxxxh6GqYWJfd3GbCBGGCHqbo1syr6M0IzT+Slgts6TH
   ycV7AGYOtxK/S8HxMUjVpF8jWkyDsLf/vbNiWDiubvRiWNrcH8FL3rjVL
   g==;
X-IronPort-AV: E=Sophos;i="5.98,339,1673938800"; 
   d="scan'208";a="210145350"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2023 14:10:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Apr 2023 14:10:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Apr 2023 14:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyZKqnBETXJjsRqH6gPIIsYyRWfYunLKwRH5cSJ9duQxUC2k/cEVpvYdd4QWaq4XUEdAZhagjZ5am6zMjn1azdGuHFYhmxps9zW90uyK0Tf6CP0tsn7fKGfVkFZU+zx4+m3fWsiPQUkLbKr0BYKe6TYw7tNouh4CCxvA1jaStO07/lBE3lEKNSnPg0F5GfS76vHgjsy/kGuMNyrgZkm7QlSmUtb4XlMieHwovPm4yiTXSikT7iFoLKeCvZur6sPLJIHEK9Ue1IREH7CWBVJ06KRK1FS4HhJ3u+GXztVdj4VoUGlC4PdYAtflUMZ5kHbWcPCs2zZiozQQldVayr7r1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNZjzCnwDX7WBXZVPVr3F9qraaFmaythXK7K0cgkh9s=;
 b=WRmXGkOOIGk/NHgNwhACt3jFFxb6LhnyxkgXBLVdiVJZXKRnfv6rHDWMcKUQzAAlkmWBVZFQd5UkE9yuIk6og3ftDIm9m/47FTYTs2rTH2JX1ZRDhG+636/wzM1LswUe4RuzPUODl5wbjFTgtLsOAKT1oORwYMxM6LM5mtF0Z6H9SkjN7nIjKwYXDdycaa+lOwPkAfNentct6AsRgRxeezjpz/Valv1vPr0VB04ERPEbY0u9nsxFPkipqeeSZaYh9J038RlP12ysY2nwMex/8gGbB+IHzng/viD39TfpI+WxEKX6f1Fl57jJG3Tj+oUQLnnuu+ot1Z4a0F/uCFMwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNZjzCnwDX7WBXZVPVr3F9qraaFmaythXK7K0cgkh9s=;
 b=aTYXbtTXuutjNPQ6UwaLcH5RHOLcQW1StOXaFH/VOtJij/WdN5nOsumuxeisYnOjOcFqhtAkQSjEKczaiW/o5/H5SayygKlMaQqY/rTelulJAt74UszIEqek2Rxukgxlfp+5NwQS6LGqoagmH6PNZIy7lQUxUgpr+i4hnSYWhSc=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 21:10:36 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::98c3:3683:c871:b2c1]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::98c3:3683:c871:b2c1%5]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 21:10:36 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: Re: wilc1000: AP mode issue
Thread-Topic: wilc1000: AP mode issue
Thread-Index: AQHZbLnhJZ4VSZXgk0Wrqq7u9w+rJq8m0zwAgAFCdgD//+PiAA==
Date:   Wed, 12 Apr 2023 21:10:36 +0000
Message-ID: <ae3f0a16-0285-018f-9a71-7017fd705617@microchip.com>
References: <e4cece9076cc9a5a4e4dbfa258a828eaec97e1af.camel@egauge.net>
 <bdd4f49a-213a-bf55-1c29-d74e56221795@microchip.com>
 <5fb4291c1d97f42e0d4904cd2f316326efd6003a.camel@egauge.net>
In-Reply-To: <5fb4291c1d97f42e0d4904cd2f316326efd6003a.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|PH7PR11MB5944:EE_
x-ms-office365-filtering-correlation-id: 489bd559-bbcc-4372-044c-08db3b9a5c51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6P3/y5BsrDqhEn92V17uCToDoDIynWdu4FWiPVYl4RP0Idq7Exln+bmIuYzd+drifMwltsOzCQjJv6ivVPEnfj67hu0rgz+Q8W7RPnUwik5dCukaBAIkqQoTUarN6pvaTVEQ//4i7xtVCa7qZ99p1eTwunHAYpT8LMRqE5/WfoIDelDGtvJP3Cj2HSnEptvi0DKrhWphA7E9/aE06QVuFYuzM7SmBwuMRPrRoOkzUFm9yp/oD6TLaZiNWP+5dwAm244DZZQr5TrqhpzIIeJP0AW3FWSuonjGVQezxDZ0Y1/gaGODBogSWTsuSmJGpFpb095nlfJaLIocYN7zHe1diGhDbooBbaCSxgvZmN5VmlUo+MTxaE5J69zBDk70u2ZwwQdSqEVjkpEbL1EAg7ZDaWdOpG7f/zQNU1dFeVq1BXMDuvRtGr8JBx1zAFLPwxg83KgFzal3EtCPA4oM9UtszQBRzF9kTltlkctywEVKtYAWlh2nl6GNVfnaHcoG06FnOTTkqzGarUi2sODtHm/+MuBRhsWivtjaG3xchr+eTUVNou5FYhSsD//vQ6NAa1YsC4iUKEirgSUopG/1dV4eSckXTO0RGmpSoHADM9/6lPnn0awEAkj7BuDvjP67Z3JFCUwgy2YtUQrdnrFFqRM14KjkxHgadMzFvftag3EcGy8o5Z0RAOLCBFc3VZtx5wY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(2616005)(83380400001)(76116006)(26005)(6486002)(71200400001)(478600001)(6512007)(53546011)(6506007)(186003)(2906002)(36756003)(38100700002)(64756008)(6916009)(66446008)(41300700001)(122000001)(66556008)(8936002)(31696002)(66946007)(38070700005)(66476007)(316002)(8676002)(4326008)(86362001)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXNpUXBmUHB2dERpREh0b0FybUJNU3RDR2dsdUJLSTFFSDVZUm1FTGFkdVpt?=
 =?utf-8?B?d1lEc3RQTVp5eUpWT3lndWFicHFrRXNWeWFSOGFYWVJBNVhkOGVVOXBxVks4?=
 =?utf-8?B?dW5SQi9mTm1wOWFOdXBxVVE5YkJ4d05XTTIxc0ZqWCtSTlg1aU5lQ05Demgx?=
 =?utf-8?B?U3FZZXZteHdXSWFMRHdCaW5DQ1RYbjRRWmFTZEN6eXVjUWlNYTBiZ1ZqR0Rz?=
 =?utf-8?B?OWJIdlV5SHJyRnVwcVUrZEdrRk81cDFCSFYvNXBMMHBkNWRzeklFakNUWTZz?=
 =?utf-8?B?TnQ4clRFT0V1eEFRdklzTGtkM3lZemhlajRsM2g1bmo2TzFObU5RMmt5cXdS?=
 =?utf-8?B?c3BUZml2OXFLNXgwdFk5c1l5NlFBalp4QUV3c0sycG1QMUlTZVZRemdyVkxq?=
 =?utf-8?B?cE5uWVFyVGsrK3JzSlZDeW96REIxdWdQS0JTamt0UGhaTitIdVRPdVJzNWZC?=
 =?utf-8?B?VHUweStac2toS0VUNlVOL212WmhPaVJpZG1pWHV2Y2xmc243SEcrRFpGVW5q?=
 =?utf-8?B?NEFtbnhGWDd1RDF0T0UyNjZNYysxbnpZNFQ4MVVLWFF1VVFKQVVzcVhFdFJ4?=
 =?utf-8?B?VWIvZW9acGJVQ25nTkhKc05TYzlTZ0NLMVhkNnFBQ3c4SktNUnFoYzhDNU5q?=
 =?utf-8?B?b29GVlVvNEFMeWc2S014WmY5SU02anNwcHdFUzZ5VmF3SlRJQXg2Z1BUQ2Z1?=
 =?utf-8?B?Sit1UnE2dld4WmlPQ000RXJOdGw1emtYSzhKVVVzd09oOVFPRG1RNWg3L2ha?=
 =?utf-8?B?ejk1TVdpTjJYb1p6dXdSVnJ4K2ZRRTNCb1IzYm5NZTlsOElyYjcrRE96bWV1?=
 =?utf-8?B?TGlPQm96NmQzd0VrTmxGZ3I3bFpvN3MxVGI1TkVsMFFIOW1zaEc1bGNDeUtW?=
 =?utf-8?B?MUpvNW02SE41ci9kZnBCdElOWURiWVVkNGhsdk9GNmhsdXBFL2plckV1cnFG?=
 =?utf-8?B?NXRLSGcvZ0VEcHp6OW5uMWN6VE1vTzdHcmQvNHloeGVDWVpxUTFuenRDNS9t?=
 =?utf-8?B?d2tpNjNKMklHTlQxZkJoK0s2L3J4b2c3WjU5SHdmaFkwb0NPWk9mam1SYkY3?=
 =?utf-8?B?TFlXNHFXMHkzNC9UQlFybzZiaE80NEJPek1hUVhJNDAybHAxS1ZiSHgyVVpr?=
 =?utf-8?B?eEx5SDJHYjUraElCN1I5VkwrWkYxWlBGMVp4djBOTWdOVDk0aVo3L1FSeXI0?=
 =?utf-8?B?emhhbmlIUGhSbEhWbVBjRHpXR1BpTEhYVEx2Qk1jWFlSUDRGUHAvTS9aU0Mx?=
 =?utf-8?B?V2gxZjM0dGNIOXBDUHE4Snhpdlo5dGcxb2ZiZ0czQVpXMzd0V0JTZmVyNXcr?=
 =?utf-8?B?UWFkQm94UUZZR1M4QndsMEZyWjdGcUd0K2gxTnFtTzNPVDFleFUxWUxUd3Ri?=
 =?utf-8?B?cUcyUzJZb1pVOW8ydFRLVDdrMW5SOEJ1cVNGMC9uWWNEd21DZDRwTnp1bjJ0?=
 =?utf-8?B?RGJjNTJuVU54Ty9EMnhQYUVQRG54WlhqU0NlRmNSM3YxY0c3ekVQcTZSZFkx?=
 =?utf-8?B?dEdOUG5KS3AyUUd1UUNuZW5iTFE2Qm5XdkhTVjIzenhNc0JMdHoxTVR6Ykhq?=
 =?utf-8?B?ZW4za3lTbzFrNnZ5S04yd3NKbWxhSDlHbjFsWENhL1RWLzk1QXI3bXdBTGJW?=
 =?utf-8?B?MHRKejVRZVlSTXA4Ylc0NnRZKzdzWWo2c1I2UVczY29zS0pWMzN1Y3lIMmtI?=
 =?utf-8?B?MXJ2TGduNk1xQ2tqWFJ1K0JCSkpPZnUyMEptR3NKRnVPcklmeElHTXA0YUtE?=
 =?utf-8?B?TUI1dWlKLzlXY09kMDg5SnMxY2FFMGorWnhrS1hQWHc2eE5Pc21rS3MrQzhC?=
 =?utf-8?B?dmZLa0ZMRmh3MGZBSnphcnlsY0hhRHFjanVNaklXZ2hMQzkvaE9NdVo0NmVX?=
 =?utf-8?B?UUI4MW5uNEVFSGRIUE1Vdi9LcWJxcjhVa09ScmRRUWwrdTVGZDY4VVZiY1Q2?=
 =?utf-8?B?V3N4dCtXRkFhOHlTditEcDNjeGVtdXNqdzRRRjUxTHBDT2ZZSm9XZEFxU3JH?=
 =?utf-8?B?b2ZlNW5FbFJ6OFpBY29yTDlRSTR0ZnUrYndIOTNkR1owdEZlTDVnOUp6U05M?=
 =?utf-8?B?WkFKYTZydWEyMWsyUm1rekgvUG5PMU1qQmVTYnR0NDYrN0lFSXlqYkE3a1BE?=
 =?utf-8?Q?NQxn2i3cQ56qkaO+Hu48cAKkq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8C4BA5051139E408DEA32567389C02B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489bd559-bbcc-4372-044c-08db3b9a5c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 21:10:36.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccNPvOQeZzXzolY/Xnj3pgIA5vDSCsal2gHHeI3+U368rxJl12w69eu4aj4X9JPPLUahmS4lfTgdsPCxHiDgP+cp/ZoVZMmHjeYubHVqlW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIDQvMTIvMjMgMTI6NDcsIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFqYXksDQo+IA0K
PiBPSywgaGVyZSBpcyBhIHNpbXBsZXIgdGVzdCBjYXNlOg0KPiANCj4gLSBTZXR1cCB3bGFuMCB0
byBjb25uZWN0IHRvIGFuIGV4aXN0aW5nIGFjY2VzcyBwb2ludC4NCj4gICBJbiBteSBjYXNlLCB3
bGFuMCBlbmRzIHVwIHdpdGggSVAgYWRkcmVzcyAxNzIuMTcuMi4yMzAuDQo+IA0KPiAtIFN0YXJ0
IGhvc3RhcGQgb24gd2xhbjB0c3Qgd2l0aCB0aGVzZSBjb21tYW5kczoNCj4gDQo+IC0tLQ0KPiBj
YXQgPiBob3N0YXBkLXdsYW4wdHN0LmNvbmYgPDxFT0YNCj4gaW50ZXJmYWNlPXdsYW4wdHN0DQo+
IGh3X21vZGU9Zw0KPiBjaGFubmVsPTYNCj4gaWVlZTgwMjExbj0xDQo+IHdtbV9lbmFibGVkPTEN
Cj4gc3NpZD1XTEFOMFRTVA0KPiB3cGE9Mg0KPiB3cGFfcGFzc3BocmFzZT1TT01FX1BBU1NXT1JE
DQo+IEVPRg0KPiBpdyBkZXYgd2xhbjAgaW50ZXJmYWNlIGFkZCB3bGFuMHRzdCB0eXBlIF9fYXAN
Cj4gaXAgbGluayBzZXQgZGV2IHdsYW4wdHN0IGFkZHJlc3MgMTI6MzQ6NTY6Nzg6OWE6YmMNCj4g
aXAgYWRkciBhZGQgMTAuMjM0LjE5My40Mi8yNCBkZXYgd2xhbjB0c3QNCj4gaG9zdGFwZCBob3N0
YXBkLXdsYW4wdHN0LmNvbmYNCj4gLS0tDQo+IA0KPiAtIENvbm5lY3QgYW5vdGhlciBjb21wdXRl
ciB0byBXTEFOMFRTVA0KPiANCj4gV2hlbiBJIHRyeSB0aGUgYWJvdmUsIHVzdWFsbHkgV0xBTjBU
U1Qgd29ya3MgZmluZSBidXQgYXMgc29vbiBhcyBpdCBzdGFydHMgdXAsDQo+IHBpbmdzIHRvIDE3
Mi4xNy4yLjIzMCBzdG9wLiAgU29tZXRpbWVzLCBXTEFOMFRTVCBzdGFydHMgdXAgZmluZSwgYnV0
IGFmdGVyIGEgZmV3DQo+IHNlY29uZHMsIHRoZSBjbGllbnQncyBjb25uZWN0aW9uIGdldHMgc2h1
dCBkb3duIGFuZCBXTEFOMFRTVCBzdG9wcw0KPiB3b3JraW5nIChvciBldmVuIGJlaW5nIGFkdmVy
dGlzZWQpLiAgV2hlbiB0aGF0IGhhcHBlbnMsIHBpbmdzIHRvIDE3Mi4xNy4yLjIzMA0KPiBzdGFy
dCB3b3JraW5nIGFnYWluLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGUgaXNzdWUgaXMgcmVhbGx5
IEFQLW1vZGUgc3BlY2lmaWMgdGhvdWdoLiAgSSBhbHNvIHNlZSBpc3N1ZXMNCj4gd2hlbiB0cnlp
bmcgdG8gY3JlYXRlIGEgdmlydHVhbCBpbnRlcmZhY2UgdGhhdCBjb25uZWN0cyB0byBhbm90aGVy
IGFjY2VzcyBwb2ludDoNCg0KSW4gd2lsYzEwMDAsIHRoZSBjb25jdXJyZW50IG1vZGUgaXMgb25s
eSBzdXBwb3J0ZWQgb24gYSBzaW5nbGUgY2hhbm5lbC4NCkkgc3VzcGVjdCB0aGUgU1RBIGFuZCBB
UCBhcmUgc3RhcnRlZCBvbiBkaWZmZXJlbnQgY2hhbm5lbHMuIEJlY2F1c2Ugb2YNCnRoYXQsIHRo
ZSBleGlzdGluZyBpbnRlcmZhY2UgaXMgZ2V0dGluZyBhZmZlY3RlZCB3aGVuIG90aGVyIGludGVy
ZmFjZSBpcw0Kc3RhcnRlZC4NCk9uY2UgdGhlIHN0YXRpb24gaXMgY29ubmVjdGVkIHRvIEFQIG9u
IHdsYW4wIGludGVyZmFjZSwgdHJ5IHVzaW5nIHRoZQ0Kc2FtZSBjaGFubmVsIG51bWJlciB0byBy
dW4gaG9zdGFwZCBvbiB3bGFuMHRzdCBpbnRlcmZhY2UuDQoNCj4gDQo+IC0gU2V0dXAgd2xhbjAg
dG8gY29ubmVjdCB0byBhbiBleGlzdGluZyBhY2Nlc3MgcG9pbnQuDQo+IC0gU3RhcnQgYSBzZWNv
bmQgY29ubmVjdGlvbiB0byBhbm90aGVyIGFjY2VzcyBwb2ludDoNCj4gDQo+IC0tLQ0KPiBpdyBk
ZXYgd2xhbjAgaW50ZXJmYWNlIGFkZCB3bGFuMHRzdCB0eXBlIG1hbmFnZWQNCj4gaXAgbGluayBz
ZXQgZGV2IHdsYW4wdHN0IGFkZHJlc3MgMTI6MzQ6NTY6Nzg6OWE6YmMNCj4gaXAgYWRkciBhZGQg
MTAuMC4wLjg4LzI0IGRldiB3bGFuMHRzdA0KPiB3cGFfc3VwcGxpY2FudCAtcyAtQiAtRG5sODAy
MTEgLWkgd2xhbjB0c3QgLWMgL2hvbWUvZWd1c2VyL3dsYW4wdHN0LmNvbmYNCj4gLS0tDQo+IA0K
PiBJbiB0aGlzIGNhc2UsIHRvbywgdHJhZmZpYyBvbiB3bGFuMCBhbmQgV0xBTjBUU1Qgc2VlbSB0
byBhZmZlY3QgZWFjaCBvdGhlci4NCj4gDQo+IEludGVyZXN0aW5nbHksIGluIHRoaXMgY2FzZSwg
SSBjYW4gYnJpbmcgYmFjayB0aGUgbm9uLXdvcmtpbmcgY29ubmVjdGlvbiBieQ0KPiBpc3N1aW5n
IGEgIndwYV9jbGkgcmVhc3NvY2lhdGUiIGNvbW1hbmQuICBUaGlzIHdpbGwgYnJpbmcgYmFjayB0
aGUgbm9uLXdvcmtpbmcNCj4gY29ubmVjdGlvbiwgYnV0IGJyZWFrIHRoZSBvbmUgdGhhdCBoYWQg
YmVlbiB3b3JraW5nIGZpbmUgYmVmb3JlICh0byBicmluZyBiYWNrDQo+IHRoZSBXTEFOMFRTVCBj
b25uZWN0aW9uLCB5b3UnZCBoYXZlIHRvIHVzZSAid3BhX2NsaSAtcCAvdmFyL3J1bi93cGFfc3Vw
cGxpY2FudC0NCj4gd2xhbjB0c3QgcmVhc3NvY2lhdGUiKS4NCg0KU2FtZSBhcyBhYm92ZSwgZm9y
IFNUQStTVEEgY29uY3VycmVudCBtb2RlLCBwbGVhc2UgY2hlY2sgd2l0aCBpZiBib3RoDQpBUCdz
IGFyZSBvbiBzYW1lIGNoYW5uZWwuDQoNCg0KUmVnYXJkcywNCkFqYXkNCg0K
