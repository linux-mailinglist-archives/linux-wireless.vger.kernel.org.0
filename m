Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60720416596
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbhIWTDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 15:03:00 -0400
Received: from mail-oln040093003011.outbound.protection.outlook.com ([40.93.3.11]:58703
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240613AbhIWTC7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 15:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9YFSkXjDcRl25YyFHIBlmfLJ1lig2CLlPsYrckVRC5qhzPUkNuQJGdaajREsDYt6VsBA2UrPpe8iZNWRInBgF2NE5Mx9WoIqVEyA4U6/5nGa1g3kq+pjAjSxZrpw9Eq+OD4HCMuwuGQlwH8dyoLbiKX9hwSZQDnOgrrwIRIKwdXD38+Od1pykVHJnqja73UCW7rSRCdqEA0iKtW0Sg/XhvtGUq1PPDVqYQOCO9NsY1MIePgLNPvSPCtf+5zaMuwjSLnPoTHiHasCy8cA3RiIA3oUQCSFJtr9MEVKW7KBFxZghsvN3d7fVAUHEcyz/QEooM1iGGvvkYMuHIKaEIS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQi5/GqX1ZqgnNV6lZK2QnUJdIMso7ca2e/LRUKHGXA=;
 b=RXdxQKI/ub4my7Bx5YR+7OHsFnAsss/BGUJd3i/8aNayfwdahdWMU6OOw6cNcQsNIDfCJDA/iq+iHsoR1qmB/6DrZe9sWs2jbhzFWCgbRlJJZliNzgfcI1kf+cIlSwEsnLPXG0fpLsnz97NUb2Ou4cyZL0vCItCbIPOU/e0SbJ/1o4msKKPumxz8uDJvIeMjKHIjTcLWb/7+yWIlFWrlMojW6Vy7M4ENhDVJGK/hBvPsh6g+syg5iyDGV3Eeb7dueOF1qEln+syhisQXgUa84ciWhYnPfMa29z5Bw6kjDFp4CfULBkgUMEBRGRL6G40KfBwuA9glHx/AE8KWFyu87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQi5/GqX1ZqgnNV6lZK2QnUJdIMso7ca2e/LRUKHGXA=;
 b=AWVGxgMlbdq3eehAwVfazLOTDnjhVtv4lvnc2vNZnlfV2EMhDvUb2UK68L9VZgYy1+MFZ6I0RGipRE8nhVF/Onk96j8JqNRWjOPaIomgJDt9PRp77FegNP5RZjCIxs1WNDFnJwd5NfyvPX01trEGgwOoQ8kNFgTxUrSYnaeM3Sc=
Received: from CY4PR21MB1540.namprd21.prod.outlook.com (52.132.97.148) by
 CY4PR21MB0183.namprd21.prod.outlook.com (10.173.193.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.8; Thu, 23 Sep 2021 19:01:24 +0000
Received: from CY4PR21MB1540.namprd21.prod.outlook.com
 ([fe80::5c3b:d191:ba94:cc8]) by CY4PR21MB1540.namprd21.prod.outlook.com
 ([fe80::5c3b:d191:ba94:cc8%7]) with mapi id 15.20.4544.009; Thu, 23 Sep 2021
 19:01:24 +0000
From:   Guillaume Hetier <Guillaume.Hetier@microsoft.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "schuffelen@google.com" <schuffelen@google.com>,
        Shwetha Bhat <shwbhat@microsoft.com>,
        Andrew Beltrano <anbeltra@microsoft.com>,
        Brian Perkins <Brian.Perkins@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: RE: [EXTERNAL] Re: [RFC PATCH 1/1] Add control path virtualization in
 virt_wifi
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 1/1] Add control path virtualization
 in virt_wifi
Thread-Index: Adeo4rOI8QazMW8KRJmQmRS8i5kvqwF38f+AAEvzQGA=
Date:   Thu, 23 Sep 2021 19:01:24 +0000
Message-ID: <CY4PR21MB15401F95BAED44381746C11F8FA39@CY4PR21MB1540.namprd21.prod.outlook.com>
References: <CY4PR21MB15407FF4663D42C8CA3E1D678FD99@CY4PR21MB1540.namprd21.prod.outlook.com>
 <254b35a0eb1e0c68cdc87fa54470c7c079d5dd6e.camel@sipsolutions.net>
In-Reply-To: <254b35a0eb1e0c68cdc87fa54470c7c079d5dd6e.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=63d0e637-f267-4120-9035-0c963a689cdd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-22T20:41:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f082525-7b21-4a27-957d-08d97ec489fa
x-ms-traffictypediagnostic: CY4PR21MB0183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB018329FD0BFF6A1C67E37D768FA39@CY4PR21MB0183.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcTjreS4yOXa2VLi2i7BiS/QgDwShjGaTVLOegzvahAlvk0icqXsOuaAHuRx/1qgy+ZP34yRzRPGHdZH7i6Eq9b3sPk3wrXP/6drS175r2QbiKYDCI93VcSLGAKbu/l7dopLO3JaPWIDpdSDdYM7N+syX1S1Rr6/yL51YrQWEQZL7rAtkDwNuhWKi5vypHdQKTIK2z/d1j1abB6YzRJupcVh8GqkneAmsm1Q8nldT13E/EFfZEuOdrbXitK/1onAxfhUSS8dJG31s/0o4nyfaTwgBoiJjJr2VDxqbFf0cBj+8DRQ9jOcPf9GRvHq2cuKb8jmDEC/W0J8UaaRlvHs5WyWkLl0TrYTPD07LAIu7CcDUH7lilJRRk8B42vIyt6YGyTmoVSKWHXMl8a29Ti+b0Z0KEXTre6zhRKdHY1gCAP8P3AwSq/AQFHMMhFIuFSoO9gogNLeQsogOO3RK0AQec0Ig6y4SE/t6BXYbegBMvMm4cKbnVnSayaPCio8LVXVtVnte+OYRC0zPJASAkaiNf+O9C1pjjbXAVFENH1Ww2K9J08O9jeT8Vmjz4oj/h0u4U00KXGP+Hw/iFJHChpQ+/Mt3zkh4udF5JjtQ+JyiHH9k7xxkDgg8ZBirAehLNAeSvgr+OCyhOluOXEiY0AMvVaDVZQpQX5nbheHT/b1yK88aTPVfJghb2WCvbs7/8JcCGWzzD3WiY8POwSK6r0TDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1540.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(8676002)(38070700005)(9686003)(38100700002)(82950400001)(110136005)(66446008)(316002)(7696005)(6506007)(4326008)(186003)(54906003)(33656002)(82960400001)(122000001)(107886003)(76116006)(83380400001)(52536014)(66556008)(66476007)(66946007)(8990500004)(86362001)(8936002)(64756008)(5660300002)(2906002)(71200400001)(10290500003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXkvZy81UnZCaXdnNGs4ZEErQVNzTzBvejZQMFZOUXpwQmdLdUc4ZkJ4QlI2?=
 =?utf-8?B?WUR4ajNSc2lSVzcvRU5QUXgwUCtDVlJDdnRoTkRuN0dxU2dWZG9BV21rWVBY?=
 =?utf-8?B?YTBITU8rcW9XZmlXZ1MzOFJlZzU1RTFCVjBJQTNNb0Jra1lHZE9LdXViT3ZX?=
 =?utf-8?B?NkhCaUoxeVJUeHkybWRrUWNPM3crRmpNZXBFVkdZL01aZUZwb0lEWWJ1TGlB?=
 =?utf-8?B?WU1abXlya3B6S0ZZdnVseXlZQ1RXaktiZndjSXp6TjNwdUV0bFNoNnRoWlFT?=
 =?utf-8?B?SU84d2hWMktxR2pOMFYzVWp1Ly9YZVhJd0dyRGJ1aFE0TTI4NnovREhPYXhV?=
 =?utf-8?B?L0llM1hraE5QTVJTZkpybllTZVJmbFRRU25pbGxNMDlIblR2K3Y3RWFuNkdN?=
 =?utf-8?B?cU1yRnlGVitZeFVHbDJZTHUwRGREamgxNjJpMnNMY2pHTkhWZnhQZ05OQWtq?=
 =?utf-8?B?akpLbjlDTDFTb2hlOVhXVlo2akNQdG84YWYvQWNvRHJoczFOL0lpZFVLRWJl?=
 =?utf-8?B?RUc2R3FlYkFvS0MxYlYrc0VNamE0ck5BUTlHT2tIaURqdEhDaHVycGd0SGwv?=
 =?utf-8?B?a0NLbkdkZVpYQXNSUEh1QWovYmhRQXpwSGk5MCt0Vkl6QnFSZFZNUFBVUlpr?=
 =?utf-8?B?UkxsUFZ4Z3RWU2pVMHJQSjhKODMxV2ZsZkQrdmRwYkV3bDJmRVNmQ0xyT3Bj?=
 =?utf-8?B?bWFHR0FXMjd2UGhBZU1acm5SanJJS09saEppZUpWNDhFaGl2TnEwdFFvQkM3?=
 =?utf-8?B?V3crY2IybUZVaHd5d3J4R0cvcUpZS1NTNSsvZ29zM2dIajRQMXYvd0xQamJL?=
 =?utf-8?B?MWo4L2lpdEJ3K0hJaENVY3dJdEppQTdnTGFnb29wcGFUNkl2Z0l5cXc3VTYy?=
 =?utf-8?B?SWhFQU5VejVnZTlrekpwdVkrcThzc2UwdjlvOHRtcHNOYkp1eEpnbUNiT3pT?=
 =?utf-8?B?MXczd3JGVGdWaDN6SDNnRWQwNmZkL2N4U1g5dXcvNUN6VEcwOGI3S1JHSDdy?=
 =?utf-8?B?VkVDc0JtaW1yd0pjbDdrSDMwdjQzQWlmaE9DRXNadWZnOXpmSUZqaG5rTmFV?=
 =?utf-8?B?VVVyb2VzRDloNTZLa011Yy81OGVjSGJuL0tKNUxGQ293djF6NDRWemFyb0I0?=
 =?utf-8?B?aW9OSzJybFdyRjF3cEtpUlNCTmpTRzhpTE9hUFk0WnA5YXo2Y21EWnF2WDU2?=
 =?utf-8?B?cm5XTm5DVGxzTlFTOUlwOWVGY1FuN0V4RjVtbndmbE01UEtxcjFHdTRsQnRN?=
 =?utf-8?B?aDBnSHNxdnpRcFc3YVYxSW8zZDZSNDIxZVVCZlZFeFdEaEtIUGphNUVWMEV2?=
 =?utf-8?B?NXRzeElDMVJvRFdHaXAra3lWd1NnUTZGMzkwaU4xTkdrbktVYThQbjJ4cVFn?=
 =?utf-8?B?KzI5ZjIreDIycFFPMlQ5RFhxVDFJTnVkMjgvbEcrelozM2JmNCtqRkVUSVdX?=
 =?utf-8?B?N0tZQ3QwZEZWU3VLNG9xdDNjOTRQOS9aWlNXb09tKytLbHh5aWZrZU90Y29j?=
 =?utf-8?B?MWZ6QzJqUVpOUHNiYkZ0QVBZdFprcFdsRzlJRFdRMURhMVU1TlY5bkxRcStT?=
 =?utf-8?B?WmJldCtIbGFQNC83UDRZN2NVbU56MDd1NjN6MXVWU1B2L3VyVzdPZUJMQlox?=
 =?utf-8?B?ZFNIZlNLTVdrTFIxS3hldHpuWEt3L2sxRlhPUzBOanlRUHYxQ20vTW9wZUM5?=
 =?utf-8?B?SVdxNm1vRkFjNGdOVzVibjR2N29RVFRJZ0dCK0J5R3ZBOU1rVnVIc3NHVFl3?=
 =?utf-8?B?ZEltKzRYWFhhbEk5VFhDMXFFNVJDVXM0OGdSYUZwTGhTSlN5TVBCTXozNkI4?=
 =?utf-8?Q?7hMVnuZ6dYvjUIP/7KuRRlsiipVYjKK0M5QO8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1540.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f082525-7b21-4a27-957d-08d97ec489fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 19:01:24.1757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwTeKZmxy0BG5K+wHjer+ik68y3gF3YEL/Z/pL0ZVoSPpeEnXgJ8FcHkxg9n2o/+PosI3I8ntyF55jDQipU72Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0183
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4g
DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyMSwgMjAyMSAxOjI3DQo+PiBPbiBNb24sIDIw
MjEtMDktMTMgYXQgMjE6MDMgKzAwMDAsIEd1aWxsYXVtZSBIZXRpZXIgd3JvdGU6DQo+PiBUb2Rh
eSwgdGhlcmUgaXMgbm8gc29sdXRpb24gZm9yIFdpLUZpIGNvbnRyb2wgcGF0aCB2aXJ0dWFsaXph
dGlvbiBpbiBhIA0KPj4gTGludXggdmlydHVhbCBtYWNoaW5lLg0KPj4gDQo+IA0KPiBUcnVlIDop
DQo+IA0KPiBJIGd1ZXNzIEkga25ldyB0aGlzIHdhcyBldmVudHVhbGx5IGluZXZpdGFibGUsIGJ1
dCBpdCdzIGFsc28gcmVhbGx5DQo+IGRpZmZpY3VsdCwgZGVwZW5kaW5nIG9uIHdoYXQgeW91J3Jl
IHRyeWluZyB0byBkbz8NCj4gDQo+IEJ1dCB0aGVuLCBob3cgZXhhY3RseSBhcmUgeW91IHRyeWlu
ZyAob3IgZ29pbmcgdG8gdHJ5KSB0byB1c2UgdGhpcz8gSW4NCj4gbGlldSBvZiBhc3NpZ25pbmcg
dGhlIGVudGlyZSBOSUMgdG8gdGhlIFZNLCByZXBsYWNpbmcgUENJIHBhc3N0aHJvdWdoPw0KPiBP
ciBwZXJoYXBzIHNvbWVob3cgaW4gYWRkaXRpb24gdG8gdGhlIGhvc3Qgc3lzdGVtIChJIGd1ZXNz
IGluIEh5cGVyLVYNCj4gbGluZ28gdGhhdCdkIGJlIHRoZSByb290IHBhcnRpdGlvbj8pIHVzaW5n
IHRoZSBXaUZpIGFzIHdlbGw/DQogDQpPdXIgdGFyZ2V0IGlzIHRvIGdpdmUgdGhlIGd1ZXN0IFZN
IGEgc2ltaWxhciBsZXZlbCBvZiBjb250cm9sIG92ZXIgV2lGaSBhcw0Kb3RoZXIgYXBwbGljYXRp
b25zIG9uIHRoZSBob3N0LiAgVGhlIGhvc3QgT1Mga2VlcHMgY29udHJvbCBvZiB0aGUgTklDLiBS
ZXF1ZXN0cw0KZnJvbSB0aGUgZ3Vlc3QgYXJlIGV4ZWN1dGVkIHRocm91Z2ggY2FsbHMgdG8gcHVi
bGljIGhvc3Qgd2xhbiBBUElzIGFuZCB0aGUNCnJlc3VsdCBpcyByZXR1cm5lZCB0byB0aGUgZ3Vl
c3QgZHJpdmVyLg0KIA0KPiBJIHN1cHBvc2UgdGhlIGd1ZXN0IGRvZXNuJ3QgcmVhbGx5IG5lZWQg
dG8gY2FyZSwgYnV0IG9uIHRoZSBob3N0IGhhdmluZw0KPiBtdWx0aXBsZSB0aGluZ3MgdHJ5IHRv
IHVzZSBXaUZpIHdvdWxkIGJlIGRpZmZpY3VsdCAtIGUuZy4gaWYgdGhlIGhvc3QNCj4gc3VwcG9y
dHMgb25seSBhIHNpbmdsZSBjbGllbnQgaW50ZXJmYWNlLCB3aGF0IHNob3VsZCBoYXBwZW4/DQog
DQpTaW5jZSB0aGUgaG9zdCBrZWVwcyBjb250cm9sIG9mIHRoZSBOSUMsIGl0IGhhbmRsZXMgbXVs
dGlwbGUgdGhpbmdzIHRyeWluZyB0bw0KdXNlIFdpRmkgdGhlIHNhbWUgd2F5IGl0IGhhbmRsZXMg
ZGlmZmVyZW50IGhvc3QgYXBwbGljYXRpb25zIHRyeWluZyB0byB1c2UgV2ktRmkuDQpUaGlzIG1l
YW5zIHRoZSBob3N0IE9TIGNhbiByZWplY3QgYSBjb21tYW5kIGZyb20gdGhlIGd1ZXN0LCBvciB0
aGF0IHRoZSBndWVzdA0KVk0gY291bGQgZ2V0IGRpc2Nvbm5lY3RlZCBpZiBhbm90aGVyIHByb2dy
YW0gb24gdGhlIGhvc3QgaW5pdGlhdGVzIGEgY29ubmVjdGlvbg0KdG8gYSBkaWZmZXJlbnQgV2kt
RmkgbmV0d29yay4NCiANCj4gSU9XLCBJIHRoaW5rIEknbSBtb3JlIGNvbmNlcm5lZCBhYm91dCB0
aGUgKmhvc3QqIGltcGxlbWVudGF0aW9uIHRoYW4gdGhlDQo+ICpndWVzdCogaW1wbGVtZW50YXRp
b24uDQo+IA0KPiBGcm9tIHRoZSBndWVzdCBzaWRlLCB3ZSBjb3VsZCBiYXNpY2FsbHkgdHJlYXQg
aXQgbGlrZSBhbnkgb3RoZXINCj4gImZ1bGxNQUMiIGRldmljZSwgbm90IHVzZSBtYWM4MDIxMSwg
YW5kIHBva2UgdGhlIGNmZzgwMjExIEFQSXMgbW9yZSBvcg0KPiBsZXNzIGRpcmVjdGx5IG91dCBp
bnRvIHRoZSBoeXBlcnZpc29yLg0KPiANCj4gT2YgY291cnNlLCB5b3UgY291bGQgYXJndWUgdGhh
dCBJIGRvbid0IG5lZWQgdG8gY2FyZSwgYnV0IGl0IGZlZWxzIG9kZA0KPiB0byBiZSBhZGRpbmcg
c29tZXRoaW5nIGhlcmUgd2hlcmUgd2UgZG9uJ3Qga25vdyBob3cgdG8gaW1wbGVtZW50IHRoZQ0K
PiBvdGhlciBzaWRlLg0KIA0KQWdyZWVkLCBvbmx5IG9uZSBoYWxmIGRvZXNu4oCZdCBtYWtlIGEg
bG90IG9mIHNlbnNlLiAgV2UgYXJlIGluIHRoZSBwcm9jZXNzIG9mDQptYWtpbmcgb3VyIFdpbmRv
d3MgaG9zdCBwcm94eSBpbXBsZW1lbnRhdGlvbiBvcGVuIHNvdXJjZS4gSXQgc2hvdWxkIGJlIGEg
bWF0dGVyDQpvZiBkYXlzIG5vdy4gIEkgd2lsbCBzZW5kIGFuIHVwZGF0ZSB3aXRoIGEgbGluayB3
aGVuIGl0IGlzIGF2YWlsYWJsZS4NCiANCltzbmlwXQ0KIA0KPj4gQXJlIHRoZXJlIGV4aXN0aW5n
IHJlY29tbWVuZGF0aW9ucyBvciBhIHN0YW5kYXJkIHdheSB0byBzb2x2ZSB0aGlzIGluIHRoZQ0K
Pj4ga2VybmVsPw0KPiANCj4gTmV0bGluaz8gVGhvdWdoIEknbSBwcm9iYWJseSB0aGUgb25seSBv
bmUgdG8gaGF2ZSBldmVyIHRyYW5zcG9ydGVkDQo+IG5ldGxpbmsgb3ZlciB2aXJ0aW8gKGluIGh3
c2ltKS4NCiANCj4gSSdtIGFsbW9zdCBqb2tpbmcsIGJ1dCBpdCdzIG5vdCByZWFsbHkgYSBiYWQg
Zm9ybWF0LCBhbmQgaXQgaGFzIGEgbG90IG9mDQo+IGhlbHBlciBjb2RlIGFscmVhZHkgdG8gZm9y
bWF0IGFuZCBwYXJzZSBtZXNzYWdlcywgYm90aCBpbiB0aGUga2VybmVsIGFuZA0KPiBpbiB1c2Vy
c3BhY2UsIHNob3VsZCBvbmUgd2FudCB0byBpbXBsZW1lbnQgdGhlIGRldmljZSBzaWRlIChvbiB0
aGUNCj4gaG9zdC9oeXBlcnZpc29yKS4NCj4gDQo+IE1pZ2h0IGV2ZW4gYmUgZmVhc2libGUgdG8g
anVzdCBwYXNzIG5sODAyMTEgdGhyb3VnaCBzb21laG93PyBIbW0uDQo+IFBlcmhhcHMgbm90PyBI
YXZlbid0IHRob3VnaHQgaGFyZCBhYm91dCBpdCwgYnV0IGluIGEgd2F5IGl0J2QgYmUgbmljZSwN
Cj4gdGhlbiB3ZSB3b3VsZG4ndCBuZWVkIGFueSBuZXcgY29kZSBpbiB0aGUgZHJpdmVyIGZvciBu
ZXcgZmVhdHVyZXMsIHdlJ2QNCj4gaGF2ZSBhbGwgdGhlIGJpdHMgaW4gbmw4MDIxMSBhbHJlYWR5
IC4uLg0KIA0KVXNpbmcgbmV0bGluayBzZWVtcyBhIGdyZWF0IGlkZWEsIHRoYW5rcyBmb3IgdGhl
IHN1Z2dlc3Rpb24hIDopDQogDQpXZSBhbHNvIGNvbnNpZGVyZWQgZm9yd2FyZGluZyBubDgwMjEx
IG1lc3NhZ2VzIGRpcmVjdGx5LCBzaW5jZSBpdCBjb3VsZCBhdm9pZA0KdGhlIG5lZWQgZm9yIGEg
c3BlY2lhbGl6ZWQgZ3Vlc3QgZHJpdmVyLiAgSG93ZXZlciwgd2Ugd29uZGVyZWQgYWJvdXQNCmNv
bXBhdGliaWxpdHkgaXNzdWVzICh3aGF0IGlmIHRoZSBob3N0IGFuZCBndWVzdCB2ZXJzaW9ucyBv
ZiBubDgwMjExIGRvbuKAmXQNCm1hdGNoPyksIGFuZCBpdCBzZWVtZWQgbXVjaCBtb3JlIGNvbXBs
ZXggdG8gaW1wbGVtZW50LCB3aXRoIHNpZ25pZmljYW50IGNoYW5nZXMNCnRvIGNmZzgwMjExIGFu
ZCBsaWtlbHkgb3RoZXIgcGFydHMgb2YgdGhlIHdpcmVsZXNzIHN1YnN5c3RlbS4gIE92ZXJhbGws
IHRoZQ0Kbmw4MDIxMSBmb3J3YXJkaW5nIG9wdGlvbiBhcHBlYXJzIGFyY2hpdGVjdHVyYWxseSBz
b3VuZCwgYnV0IGdpdmVuIHRoZSBtdWNoDQpsYXJnZXIgc2NvcGUgYW5kIGltcGFjdCwgd2UgZm9j
dXNlZCBvbiBhIG1vcmUgdGFyZ2V0ZWQgc29sdXRpb24gaW4gd2hpY2ggdGhlDQpndWVzdCBkcml2
ZXIgZG9lc27igJl0IG93biB0aGUgaG9zdCBOSUMuICBXZSBmZWVsIHRoaXMgc29sdXRpb24gcHJv
dmlkZXMgYSBtaWRkbGUNCmdyb3VuZCB3aGVyZSB0aGUgaG9zdCBjYW4gZGVjaWRlIHdoaWNoIHBh
cnRzIG9mIGl0cyB3aXJlbGVzcyBzdGFjayB0byBwcm94eSB0bw0KdGhlIGd1ZXN0Lg0KIA0KR3Vp
bGxhdW1lDQo=
