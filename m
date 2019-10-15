Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5CAD77CF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 15:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbfJON7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 09:59:32 -0400
Received: from esa3.hc3102-66.iphmx.com ([139.138.33.118]:21538 "EHLO
        esa3.hc3102-66.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfJON7b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 09:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=jax.org; i=@jax.org; q=dns/txt; s=selector1;
  t=1571147971; x=1602683971;
  h=arc-seal:arc-message-signature:
   arc-authentication-results:from:to:subject:thread-topic:
   thread-index:date:message-id:accept-language:
   content-language:x-ms-has-attach:x-ms-tnef-correlator:
   x-clientproxiedby:authentication-results:
   x-ms-exchange-messagesentrepresentingtype:
   x-originating-ip:x-ms-publictraffictype:
   x-ms-office365-filtering-correlation-id:
   x-ms-traffictypediagnostic:x-ms-exchange-purlcount:
   x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
   x-forefront-prvs:x-forefront-antispam-report:
   x-ms-exchange-senderadcheck:x-microsoft-antispam:
   x-microsoft-antispam-message-info:
   x-ms-exchange-transport-forked:content-type:content-id:
   mime-version:x-originatororg:
   x-ms-exchange-crosstenant-network-message-id:
   x-ms-exchange-crosstenant-originalarrivaltime:
   x-ms-exchange-crosstenant-fromentityheader:
   x-ms-exchange-crosstenant-id:
   x-ms-exchange-crosstenant-mailboxtype:
   x-ms-exchange-crosstenant-userprincipalname:
   x-ms-exchange-transport-crosstenantheadersstamped:
   content-transfer-encoding:ironport-sdr;
  bh=LpYVcI/nKl3ePfhPtimLf9FBhvsYGXhknQzH43CvZT0=;
  b=Vu0Vp8KOHXstIsbUqKoNoHKqR7l3cC8fyTV0etZK9ph8i1yAxeRVQ6UW
   XBopIOKlfmV0taQ2K2WnuAN55t8jhd0fs1D8kS/+hp93cAL6WoncPs8+A
   41pCKSqT9fgh3BDOvvMVggnrKrtJnst+rzdb+W6ENZ9DhDkWcfGGkGKDJ
   M=;
IronPort-SDR: reSA44OcX484aQCzFD4SgsPgC5POEZQZ075DrCaBuF86qXPuMipGs9FWhmefWn+FVCGML/yfsS
 QEKPYOIJpg837FSikjqlHVV6vQW8MpB84sEXpY36ZH8luXVdpZfEcTGhOAw4/6jUXEdw5UhrR+
 nycLUFJ89qP2XNEFudF6YENx31J9zW9dX5S0JnpFlg5PBbW8ZrOKajxnRQKAGtUhdgDG1deWhF
 DBFX+/SyUNGtuoI4jv4YGZ7vcRBwtO90fmZIbyCrvKPBSkF2xMaXHE9kmLVkjIPEhSDpaGUAVA
 y0Y=
Received: from mail-by2nam03lp2059.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.59])
  by ob1.hc3102-66.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:59:30 +0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUjS2eHqgVI41aNNSoLhb8qdQdhnddRcNzHp1F94cK+EvkJD6nwxgMbfczsgMFRqRHvjMqAdLplaINFClCrgi//oH/nbRKf3/S6wuwabaApzxiteiSRSClCNVQzmHKUz+I0f+5TTBM/7+3dlWjkgfQ+bn7wXvbgIm0uckhKmb2nPLSSxI/UKRyG7Q+wGM6Io1EGtsZF3GbUXFcUUVNICTO27GJfXa5uDuYL1ElPEO3avudDKK60hmLgKHbv2KZOHhAJ9jHfKrHZdyuPpmZ7x+NoqAdYwhAQk2mu/tkMwITujZvhoM9panTOtcniFR6T5mMRasly68L4jBXDP6zxofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxFbdyfpsL2YHCvaNOB1fDSu7guVN47lUzoivIO8Uw4=;
 b=m9jfdlGGj7wYffUu/fNlYwwq5EmLiEwtAk6DBBvHjC3HkE6651MDUqcKxPlNinJT7V01DdjZF0aTCA6XirvjkwbM9PLXrRRwS9B/ePu01HgeYyd20xom9/bK9ivdNgTQW+D2E2zH6Fyu9r5iyREdwa8ahaPf+majFeVplWtbA1PrFP7L3/KrFoeo/7XWSc1t93nvPlxPp+DjF0glxTdY1Yox4e9OWINaWha+LeI2aXR9MP0DRHv+IHt5I9bSz2nmvcUcgE0K7NdgTo5jDlFnrrUr+34jpYJ2iKxaQBt25tDz03s6n6IpQUC7YFL9TR6gsBdEGdINncc8H4JMMjT63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jax.org; dmarc=pass action=none header.from=jax.org; dkim=pass
 header.d=jax.org; arc=none
Received: from BN6PR06MB3411.namprd06.prod.outlook.com (10.174.235.157) by
 BN6PR06MB3505.namprd06.prod.outlook.com (10.175.131.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 13:59:29 +0000
Received: from BN6PR06MB3411.namprd06.prod.outlook.com
 ([fe80::eddd:8895:5383:2a8c]) by BN6PR06MB3411.namprd06.prod.outlook.com
 ([fe80::eddd:8895:5383:2a8c%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 13:59:29 +0000
From:   Josh Marshall <Josh.Marshall@jax.org>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [unconfirmed bug] missing firmware configuration
 `brcm/brcmfmac43602-pcie.txt`
Thread-Topic: [unconfirmed bug] missing firmware configuration
 `brcm/brcmfmac43602-pcie.txt`
Thread-Index: AQHVg2DDg/mWQ4cax064kqPpuZwnkg==
Date:   Tue, 15 Oct 2019 13:59:29 +0000
Message-ID: <907921df-34c1-6f08-1ece-bac896031397@jax.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:403:3::13) To BN6PR06MB3411.namprd06.prod.outlook.com
 (2603:10b6:405:47::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Josh.Marshall@jax.org; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [162.221.11.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 869cbf4c-5c28-4918-649a-08d75177e5dd
x-ms-traffictypediagnostic: BN6PR06MB3505:
x-ms-exchange-purlcount: 11
x-microsoft-antispam-prvs:  <BN6PR06MB3505BD8EEDD159434B44DB1EE9930@BN6PR06MB3505.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report:  SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39850400004)(346002)(376002)(396003)(199004)(189003)(44832011)(86362001)(6116002)(71190400001)(8936002)(478600001)(486006)(316002)(102836004)(81166006)(8676002)(81156014)(5660300002)(386003)(6506007)(305945005)(2616005)(476003)(7736002)(3846002)(2501003)(31696002)(786003)(4001150100001)(36756003)(16799955002)(52116002)(2906002)(66066001)(186003)(64756008)(66946007)(99286004)(966005)(66446008)(6512007)(66476007)(66556008)(14454004)(26005)(256004)(2351001)(6436002)(6486002)(71200400001)(25786009)(6916009)(31686004)(14444005)(5640700003)(6306002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3505;H:BN6PR06MB3411.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: jax.org does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  um5YegeRT86K7JE8EOWhRtUMO1R4mSIoTgN9pYjxD4xxAnZViduW0ya8ypKvYvTRpFdMW/kk/efiljxIj70wA53dthF46psQpAmP37l+O8rJH/1EJGOT44JZTaSXQXaFgJTzGEXSw4/ap32DxC2hOAIZmZEURgPtkx2eRdOFgzQu4R/Q4ADZoP1UZWWRqxDS3Ou4Znq5dm9hBy95H0KNZxP/1gx77NZVfFQA2WHcdtKwVWRYvaxs/1985bZSOo2UmAgRE+ieccB+6fDXrAYnFhJrfF8MjjtWt17k7xHhxFuG472YR5RGAc/l824bfHmPmq0Yqm441KhDvqGqzEg0i+/zNc7zniMwo8yO2zwZ9EP5b7kUHaxI4/knQcBBo3J82+tekhoKMa7DSu/aonMFP7Xr53gDyHYCfFyldBngDF/J5HEu0wDaTlw1LvfXL14iWpY+pdqLHd6wKHE+eLqBLg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E21A3DF955E9AA41A97F441A5717EB19@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: jax.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 869cbf4c-5c28-4918-649a-08d75177e5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 13:59:29.8002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d665caa-d62e-4678-9f5f-e707cf9ecbd1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAaBD+Y0Z8P8tNkWSC7Nx0IBPv0/YTm4AuhOXM81/bJP/uwBI/FgVziHvX4sHX6gCqmKnZAyyUC4GfRHmIAkug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3505
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGVsbG8sDQoNCkZpcnN0IHRpbWUgY29udGFjdGluZyBhIGtlcm5lbCBtYWlsaW5nIGxpc3QuDQoN
CkkndmUgYmVlbiB0cnlpbmcgdG8gZml4IHRoZSB3aXJlbGVzcyBvbiBteSBsYXB0b3AgKCBNYWNC
b29rUHJvMTIsMSApLsKgIA0KSXQgaGFzIHZlcnkgd2VhayBzaWduYWwgc3RyZW5ndGguwqAgSSBo
YXZlIGF0IGxlYXN0IHBhcnRpYWxseSByZWFkIA0KdGhyb3VnaCB0aGUgZm9sbG93aW5nOg0KDQpo
dHRwczovL2Fza3VidW50dS5jb20vcXVlc3Rpb25zLzc3NTAxMS9tYWNib29rLXByby0xNi0wNC13
aWZpLWRyaXZlci1pbnN0YWxsZWQtYnV0LW5vdC1hdmFpbGFibGUNCmh0dHBzOi8vYXNrdWJ1bnR1
LmNvbS9xdWVzdGlvbnMvMTA2NDQ0Mi93aWZpLW5vdC13b3JraW5nLXdpdGgtYmNtNDM2MDItb24t
dWJ1bnR1LTE4LTA0DQpodHRwczovL2Fza3VidW50dS5jb20vcXVlc3Rpb25zLzYyMjk4OC93aWZp
LWlzc3Vlcy13aXRoLW1hY2Jvb2stcHJvLXJldGluYS1lYXJseS0yMDE1LTEyLTItb24tdWJ1bnR1
LTE1LTA0DQogwqDCoMKgIGh0dHBzOi8vd2lraS5kZWJpYW4ub3JnL2JyY21mbWFjDQogwqDCoMKg
IGh0dHBzOi8vdWJ1bnR1Zm9ydW1zLm9yZy9zaG93dGhyZWFkLnBocD90PTIzNTQzNjUNCmh0dHBz
Oi8vYXNrdWJ1bnR1LmNvbS9xdWVzdGlvbnMvODg0MjkxL3VidW50dS0xNC0wNC13aXJlbGVzcy1u
b3Qtd29ya2luZy1vbi1tYWNib29rLXByby1kdWFsLWJvb3QNCmh0dHBzOi8vd3d3Lm1haWwtYXJj
aGl2ZS5jb20vbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnL21zZzE3MjI5Lmh0bWwNCmh0
dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vc2VhcmNoP2w9dWJ1bnR1LWJ1Z3NAbGlzdHMudWJ1
bnR1LmNvbSZxPXN1YmplY3Q6JTIyJTVDJTVCQnVnKzE2OTM1MjElNUMlNUQrUmUlNUMlM0ErYnJj
bWZtYWMlNUMlM0ErRGlyZWN0K2Zpcm13YXJlK2xvYWQrZmFpbGVkJTIyJm89bmV3ZXN0DQpodHRw
czovL2J1Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJjZS9saW51eC1maXJtd2FyZS8rYnVn
LzE3NzI2MjQNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L2Zpcm13YXJlL2xpbnV4LWZpcm13YXJlLmdpdC9wbGFpbi9icmNtLw0KDQpJIGNyZWF0ZWQgZW1w
dHkgZmlsZXMgYXQgYC9saWIvZmlybXdhcmUve2JyY21mbWFjNDM2MDItcGNpZS5BcHBsZVwgDQpJ
bmMuLU1hY0Jvb2tQcm8xNFwsMi50eHQsYnJjbWZtYWM0MzYwMi1wY2llLnR4dH1gDQoNCmBgYA0K
JCBkbWVzZyB8IGdyZXAgYnJjbQ0KW8KgwqDCoCA1LjMwNTk5OF0gdXNiY29yZTogcmVnaXN0ZXJl
ZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBicmNtZm1hYw0KW8KgwqDCoCA1LjQzMzU5OV0gYnJjbWZt
YWM6IGJyY21mX2Z3X2FsbG9jX3JlcXVlc3Q6IHVzaW5nIA0KYnJjbS9icmNtZm1hYzQzNjAyLXBj
aWUgZm9yIGNoaXAgQkNNNDM2MDIvMg0KW8KgwqDCoCA1LjQzNTE0MF0gYnJjbWZtYWMgMDAwMDow
MjowMC4wOiBsb2FkaW5nIA0KL2xpYi9maXJtd2FyZS9icmNtL2JyY21mbWFjNDM2MDItcGNpZS5B
cHBsZSBJbmMuLU1hY0Jvb2tQcm8xNCwyLnR4dCANCmZhaWxlZCB3aXRoIGVycm9yIC0yMg0KW8Kg
wqDCoCA1LjQzNTE0Ml0gYnJjbWZtYWMgMDAwMDowMjowMC4wOiBEaXJlY3QgZmlybXdhcmUgbG9h
ZCBmb3IgDQpicmNtL2JyY21mbWFjNDM2MDItcGNpZS5BcHBsZSBJbmMuLU1hY0Jvb2tQcm8xNCwy
LnR4dCBmYWlsZWQgd2l0aCBlcnJvciAtMjINClvCoMKgwqAgNS40MzUzNThdIGJyY21mbWFjIDAw
MDA6MDI6MDAuMDogbG9hZGluZyANCi9saWIvZmlybXdhcmUvYnJjbS9icmNtZm1hYzQzNjAyLXBj
aWUudHh0IGZhaWxlZCB3aXRoIGVycm9yIC0yMg0KW8KgwqDCoCA1LjQzNTM1OV0gYnJjbWZtYWMg
MDAwMDowMjowMC4wOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3IgDQpicmNtL2JyY21mbWFjNDM2
MDItcGNpZS50eHQgZmFpbGVkIHdpdGggZXJyb3IgLTIyDQpbwqDCoMKgIDUuNzgxODgxXSBicmNt
Zm1hYzogYnJjbWZfZndfYWxsb2NfcmVxdWVzdDogdXNpbmcgDQpicmNtL2JyY21mbWFjNDM2MDIt
cGNpZSBmb3IgY2hpcCBCQ000MzYwMi8yDQpbwqDCoMKgIDUuNzgxOTEwXSBicmNtZm1hYzogYnJj
bWZfY19wcm9jZXNzX2NsbV9ibG9iOiBubyBjbG1fYmxvYiBhdmFpbGFibGUgDQooZXJyPS0yKSwg
ZGV2aWNlIG1heSBoYXZlIGxpbWl0ZWQgY2hhbm5lbHMgYXZhaWxhYmxlDQpbwqDCoMKgIDUuNzgy
OTI3XSBicmNtZm1hYzogYnJjbWZfY19wcmVpbml0X2RjbWRzOiBGaXJtd2FyZTogQkNNNDM2MDIv
MiANCndsMDogTm92IDEwIDIwMTUgMDY6Mzg6MTAgdmVyc2lvbiA3LjM1LjE3Ny42MSAocjU5ODY1
NykgRldJRCAwMS1lYTY2MmE4Yw0KW8KgwqDCoCA1LjgyODU2MV0gYnJjbWZtYWMgMDAwMDowMjow
MC4wIHdscDJzMDogcmVuYW1lZCBmcm9tIHdsYW4wDQpgYGANCg0KV2hhdCBJIHRoaW5rIG1heSBu
ZWVkIHRvIGhhcHBlbiBpcyB0byBoYXZlIGEgcGFydGljdWxhciBjb25maWd1cmF0aW9uIA0KYWRk
ZWQgbGlrZSANCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L2Zpcm13YXJlL2xpbnV4LWZpcm13YXJlLmdpdC9wbGFpbi9icmNtL2JyY21mbWFjNDM0MzAtc2Rp
by5yYXNwYmVycnlwaSwzLW1vZGVsLWIudHh0IA0KYXMgYGJyY21mbWFjNDM2MDItcGNpZS50eHRg
IGluIG9yZGVyIHRvIG1ha2UgdGhlIGZ1bGwgcmFuZ2Ugb2YgY2hhbm5lbHMgDQphdmFpbGFibGUs
IGFuZCBieSB0aGF0IGltcHJvdmUgc2lnbmFsIHN0cmVuZ3RoLCBidXQgdGhpcyBpcyBvbmx5IGEg
c2hvdCANCmluIHRoZSBkYXJrLg0KLS0tCgpUaGUgaW5mb3JtYXRpb24gaW4gdGhpcyBlbWFpbCwg
aW5jbHVkaW5nIGF0dGFjaG1lbnRzLCBtYXkgYmUgY29uZmlkZW50aWFsIGFuZCBpcyBpbnRlbmRl
ZCBzb2xlbHkgZm9yIHRoZSBhZGRyZXNzZWUocykuIElmIHlvdSBiZWxpZXZlIHlvdSByZWNlaXZl
ZCB0aGlzIGVtYWlsIGJ5IG1pc3Rha2UsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXR1
cm4gZW1haWwgYXMgc29vbiBhcyBwb3NzaWJsZS4K

