Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C68E671B2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfGLOwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 10:52:32 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:48909 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLOwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 10:52:31 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 2KUSPctVNOb4CVUBI+eMjrN4mtJXiP/bHkSgMKj1ODjkr9OJ+hB1/1dP3bxB2/0Wc0zqdmX18V
 1vf9g4rFqBv4xqeiNhgsF7+mfgBu7IY/ZHQuReeNEBZs5o1YZGa4caOVBvNEdLrM8N5i4BVo2p
 zG8iKiVpY4tPDtUQxVBlUzOmKkgL0vLPGdWJIOGHJwMOrVb0RhWyaUfbyjwY0lRIrO5ZvitZVu
 6RBU0KW5M7lot6bLwtWgrzjwPwamh4DIaMlsI/B64lNtZ7fA9EQSrOfuR0rkxSRMvpn9qW0A8h
 8AU=
X-IronPort-AV: E=Sophos;i="5.63,482,1557212400"; 
   d="scan'208";a="38044563"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2019 07:52:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 12 Jul 2019 07:52:24 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 12 Jul 2019 07:52:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDKruqVy7XcViO5UUUCwHRl87btM5Sn1v3RcAMw0AVsG9Wu+/6Qd9YP5Qw3lYKCj86og65jdp/dDGzGtTO7f7rbaOMwfUUHjnz8nTAJglcM8kdzIHCiCUgcCTGj457xoBRJduxKAmuQmUminaGAuob2AMIcIBb/qswc90U/KuigUqW8ibaLtaLmSA/vkYNm8UlEbIJRkmWwLqihqopsygS2PKV4cCgiSZlZSBKC1CcJ80H3w13far88sClDQ7z6xDTpSl+3peG6Gmtti/4zRWSg0svGaAN/isCnCvPVYibYsNQAWnUduKD5viIg+CulquBOzwiOmsG8YxRvIRSSoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thMP+2db1Z4n/RQgFH2vkqaNbW5NQ6eEWGXZ0ix3v4w=;
 b=XlvMPOQGrjYLuKOEpZ3WK2i917IRmoeqa59r9+uiXYWi0VBbDmCwsXtEzUQ3V9hO8/bJh0cPNXl7YPGuGT9tAMla0jYyGQ4P4peMCreaAjjcgDfyTBrSUwo1CURxaFtpjMi6ULvYxCbLoR6ox6dcUnh+ylOMIbvAPZnrnrTxgFITIRyO+oxGRiTY2PwflgKv7fEp2Q7syhJLpen38eEuqrFSeaY/zX+D9R/ao3NJ4j0PpKQtP4QycMnIPU/u7t9tNdFXCCioS9OvIwxPg5OrThBsSmKr9LzgpEhk9VWPv/YeKiA93wzf5witugEUoPgTUF5YySspq573XHnpS1H3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thMP+2db1Z4n/RQgFH2vkqaNbW5NQ6eEWGXZ0ix3v4w=;
 b=SECHEWa0SFABxF3ldhxZZSHnbzrWJ6FWrDDCvaKrJYCPDthNTpPBWNQ4rAa9o1p2ZbEfs8TR9BLz/CQy4AhJIBvMXffkXct0cqZJMSs0iILFrLyovlBnjQ+czdULumJ7FDw95feoa15ckM7cJHIC4nHxwICLPz2hxm7a4SBm4qk=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB4050.namprd11.prod.outlook.com (10.255.130.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 14:52:19 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2073.012; Fri, 12 Jul 2019
 14:52:19 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <Adham.Abozaeid@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 02/16] wilc1000: add wilc_hif.c
Thread-Topic: [PATCH v2 02/16] wilc1000: add wilc_hif.c
Thread-Index: AQHVOFVVrcOMa5Im0kSsJ65zPNQoKabGmhEAgAB4AwA=
Date:   Fri, 12 Jul 2019 14:52:19 +0000
Message-ID: <82d35fcf-15f0-4b8a-20a9-3f50b0541651@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
 <1562896697-8002-3-git-send-email-ajay.kathat@microchip.com>
 <b6bb8a8b61ebbca40611dee07e4980a792bf2386.camel@sipsolutions.net>
In-Reply-To: <b6bb8a8b61ebbca40611dee07e4980a792bf2386.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::14)
 To BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fcf5572-0fc2-4d74-38e5-08d706d889e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR11MB4050;
x-ms-traffictypediagnostic: BN6PR11MB4050:
x-microsoft-antispam-prvs: <BN6PR11MB4050A5C10048B64C5EF1FE6BE3F20@BN6PR11MB4050.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(6512007)(6246003)(53936002)(31686004)(6436002)(2501003)(76176011)(229853002)(52116002)(66446008)(66066001)(66476007)(66556008)(64756008)(66946007)(107886003)(6506007)(386003)(53546011)(14444005)(102836004)(5660300002)(256004)(68736007)(99286004)(4326008)(8936002)(71190400001)(71200400001)(81156014)(81166006)(186003)(2906002)(25786009)(6486002)(78486014)(110136005)(478600001)(54906003)(316002)(6116002)(3846002)(305945005)(31696002)(86362001)(14454004)(26005)(476003)(446003)(36756003)(11346002)(2616005)(486006)(7736002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4050;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NYWzZtSvg7+J6mRdPQqKcdSVDv6Tr282CHbGW10hN1mKh34aP390gp74a4ugJiXSoa3EAURKwJy+Y1tQJPHYZ0P/d6lmw7ycmR6wGag0+vMRznmSJuV2cw0MThnHXpYU5irnZd2u9mlrU3aCwtsZsz+D6f3q3kE1Mjxc9jTNDP5LG8Y/4LQ15pEKG4IvO1tgqRMNZEtL6eUCLDj500PJ3n5lXEwO1numimQH15zpFNJAlDSLG+dpDeLy+Plz3tYQqmyu3Ril0/CR6aRjbaw0TO1txPve4f7Sj/VKOn59SURL8ZQoHU1oupQl5dtKRYgiZNG+o62tY7TzRyjghD5+M/aJEB9isspO+uFzHqu1lXZAWICXDQkofNd4fSqCyUSM/Qwh6FVpO+yaCaV+NIPhAo87IVzWFwwW8LhCEVlttB4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <901CA7829C48DB42BCDF9D269D0CE27F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcf5572-0fc2-4d74-38e5-08d706d889e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 14:52:19.4894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4050
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDcvMTIvMjAxOSAxOjEyIFBNLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPiBFeHRlcm5h
bCBFLU1haWwNCj4gDQo+IA0KPj4gK3N0cnVjdCB3aWxjX3NldF9tdWx0aWNhc3Qgew0KPj4gKwl1
MzIgZW5hYmxlZDsNCj4+ICsJdTMyIGNudDsNCj4+ICsJdTggKm1jX2xpc3Q7DQo+PiArfTsNCj4+
ICsNCj4+ICtzdHJ1Y3Qgd2lsY19kZWxfYWxsX3N0YSB7DQo+PiArCXU4IGFzc29jX3N0YTsNCj4+
ICsJdTggbWFjW1dJTENfTUFYX05VTV9TVEFdW0VUSF9BTEVOXTsNCj4+ICt9Ow0KPj4gKw0KPj4g
K3N0cnVjdCB3aWxjX29wX21vZGUgew0KPj4gKwlfX2xlMzIgbW9kZTsNCj4+ICt9Ow0KPj4gKw0K
Pj4gK3N0cnVjdCB3aWxjX3JlZ19mcmFtZSB7DQo+PiArCWJvb2wgcmVnOw0KPj4gKwl1OCByZWdf
aWQ7DQo+PiArCV9fbGUxNiBmcmFtZV90eXBlOw0KPj4gK30gX19wYWNrZWQ7DQo+IA0KPiAnYm9v
bCcgaXMgYSBwcmV0dHkgYmFkIGlkZWEsIHRoZXJlJ3Mgbm8gc3RvcmFnZSBndWFyYW50ZWUgZm9y
IGl0LiBVc2UgdTgNCj4gaW5zdGVhZCwgZXNwZWNpYWxseSBpbiBhIGZpcm13YXJlIHN0cnVjdC4N
Cj4gDQo+IEJ1dCBvdmVyYWxsLCBpZiBJIHJlbWVtYmVyIGNvcnJlY3RseSwgdGhpcyBpcyBhIG1h
c3NpdmUgaW1wcm92ZW1lbnQsDQo+IGxhc3QgdGltZSBJIGxvb2tlZCBJIHRoaW5rIHlvdSBiYXNp
Y2FsbHkgaGFkIHNvbWV0aGluZyBsaWtlDQo+IA0KPiBjaGFyIG1zZ1sxMF07DQo+IGludCBpID0g
MDsNCj4gbXNnW2krK10gPSByZWc7DQo+IG1zZ1tpKytdID0gcmVnX2lkOw0KPiBtc2dbaSsrXSA9
IGZyYW1lX3R5cGUgPj4gODsNCj4gbXNnW2krK10gPSAodTgpZnJhbWVfdHlwZTsNCj4gDQo+IHNv
IG9idmlvdXNseSB0aGlzIGlzICptdWNoKiBiZXR0ZXIuDQo+IA0KPiBJIHN0aWxsIHRoaW5rIHlv
dSdkIGJlbmVmaXQgZnJvbSBwdXR0aW5nIHRoZSBmaXJtd2FyZSBBUEkgc3RydWN0cyBpbnRvIGEN
Cj4gc2VwYXJhdGUgaW5jbHVkZSBmaWxlIHNvIHlvdSBjYW4gZGlmZmVyZW50aWF0ZSB0aGVtLCBi
dXQgWU1NVi4NCj4gDQo+PiAraW50IHdpbGNfc2NhbihzdHJ1Y3Qgd2lsY192aWYgKnZpZiwgdTgg
c2Nhbl9zb3VyY2UsIHU4IHNjYW5fdHlwZSwNCj4+ICsJICAgICAgdTggKmNoX2ZyZXFfbGlzdCwg
dTggY2hfbGlzdF9sZW4sDQo+PiArCSAgICAgIHZvaWQgKCpzY2FuX3Jlc3VsdF9mbikoZW51bSBz
Y2FuX2V2ZW50LA0KPj4gKwkJCQkgICAgIHN0cnVjdCB3aWxjX3JjdmRfbmV0X2luZm8gKiwgdm9p
ZCAqKSwNCj4+ICsJICAgICAgdm9pZCAqdXNlcl9hcmcsIHN0cnVjdCBjZmc4MDIxMV9zY2FuX3Jl
cXVlc3QgKnJlcXVlc3QpDQo+PiArew0KPj4gKwlpbnQgcmVzdWx0ID0gMDsNCj4+ICsJc3RydWN0
IHdpZCB3aWRfbGlzdFs1XTsNCj4gDQo+PiArCXdpZF9saXN0W2luZGV4XS5pZCA9IFdJRF9JTkZP
X0VMRU1FTlRfUFJPQkU7DQo+PiArCXdpZF9saXN0W2luZGV4XS50eXBlID0gV0lEX0JJTl9EQVRB
Ow0KPj4gKwl3aWRfbGlzdFtpbmRleF0udmFsID0gKHM4ICopcmVxdWVzdC0+aWU7DQo+PiArCXdp
ZF9saXN0W2luZGV4XS5zaXplID0gcmVxdWVzdC0+aWVfbGVuOw0KPj4gKwlpbmRleCsrOw0KPj4g
Kw0KPj4gKwl3aWRfbGlzdFtpbmRleF0uaWQgPSBXSURfU0NBTl9UWVBFOw0KPj4gKwl3aWRfbGlz
dFtpbmRleF0udHlwZSA9IFdJRF9DSEFSOw0KPj4gKwl3aWRfbGlzdFtpbmRleF0uc2l6ZSA9IHNp
emVvZihjaGFyKTsNCj4+ICsJd2lkX2xpc3RbaW5kZXhdLnZhbCA9IChzOCAqKSZzY2FuX3R5cGU7
DQo+PiArCWluZGV4Kys7DQo+IA0KPiANCj4gSSBzdGlsbCBmaW5kIHRoaXMgd2hvbGUgd2lkX2xp
c3Qgc3R1ZmYgdG8gYmUgYSBiaXQgY29uZnVzaW5nLCBlc3BlY2lhbGx5DQo+IHNpbmNlIGl0IGxv
b2tzIGxpa2UgYSAqZmlybXdhcmUqIHRoaW5nIGJ1dCB0aGVuIHlvdSBoYXZlIHRoZSAqaG9zdA0K
PiBwb2ludGVyKiBpbnNpZGUgdGhlIHZhbHVlIC4uLg0KPiANCj4gVGhlcmUgbXVzdCBiZSBhIHRy
YW5zbGF0aW9uIGxheWVyIHNvbWV3aGVyZSwgYnV0IEkgY2FuJ3QgaGVscCBidXQgd29uZGVyDQo+
IGlmIHRoYXQncyByZWFsbHkgd29ydGggdGhlIGNvbXBsZXhpdHksIHZzLiBqdXN0IGJ1aWxkaW5n
IHRoZSByaWdodCB0aGluZw0KPiBkaXJlY3RseSBoZXJlICh3aXRoIHNvbWUgaGVscGVycyBwZXJo
YXBzKS4NCj4NCg0KVGhlIHRyYW5zbGF0aW9uIHRvIGZpcm13YXJlIGJ1ZmZlciBoYXBwZW5zIGlu
IHdpbGNfd2xhbl9jZmdfc2V0KCkgYW5kDQp3aWxjX3dsYW5fY2ZnX2NvbW1pdCgpIGFkZHMgYSBz
aW5nbGUgKndpbGNfY2ZnX2NtZF9oZHIqIGhlYWRlciBiZWZvcmUNCnNlbmRpbmcgdG8gZmlybXdh
cmUuDQoNClRoZXJlIGFyZSB0d28gd2F5cyB0byBzZW5kIHRoZSB3aWQncyBmcm9tIGhvc3QgdG8g
ZmlybXdhcmUuDQoNCjEvIFNpbmdsZSBXaWQgLT4gSW4gdGhpcyBjYXNlLCBzaW5nbGUgd2lkIGlz
IHNlbnQgYnkgYWRkaW5nDQoqd2lsY19jZmdfY21kX2hkciogaW4gc2luZ2xlIGNvbW1hbmQgYnVm
ZmVyIHRvIGZpcm13YXJlLg0KaS5lIDx3aWxjX2NmZ19jbWRfaGRyPjx3aWQxPg0KDQoyLyBNdXRs
aXBsZSBXaWQncyAtPiBJbiB0aGlzIGNhc2UsIG11bHRpcGxlIHdpZCdzIGFyZSBjbHViYmxlZCB0
b2dldGhlcg0KYW5kIHNlbnQgaW4gc2luZ2xlIGNvbW1hbmQgYnVmZmVyLg0KZS5nLiA8d2lsY19j
ZmdfY21kX2hkcj48d2lkMT48d2lkMj48d2lkMz4NCkFzIHRoZSBmaXJtd2FyZSBpcyBkZXNpZ24g
dG8gcmVjZWl2ZSBjb25maWd1cmF0aW9uIHVuZGVyIGRpZmZlcmVudA0KV0lEJ3MsIHNvIGl0IGlz
IHJlcXVpcmVkIGZyb20gdGhlIGhvc3Qgc2lkZSB0byBjbHViIHRoZXNlIHBhcmFtZXRlcnMNCndo
ZW5ldmVyIGRhdGEgaXMgcmVsYXRlZC4NCg0KQ3VycmVudGx5LCB3aWxjX3NlbmRfY29uZmlnX3Br
dCgpIGlzIHByb3ZpZGVkIGFzIGhlbHBlciBBUEkgdG8gY29uc3RydWN0DQpidWZmZXIgYmFzZWQg
b24gcGFzc2VkICp3aWRzKiBhbmQgKmNvdW50cyouIFRoaXMgd2lsbCBhdm9pZCBhZGRpbmcNCnNp
bWlsYXIgbG9naWMgaW4gbXVsdGlwbGUgcGxhY2VzLg0KDQpSZWdhcmRzLA0KQWpheQ0K
