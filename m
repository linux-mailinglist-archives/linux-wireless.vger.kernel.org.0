Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33B819C2C7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgDBNhB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:37:01 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:62747 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbgDBNhB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1585834621; x=1617370621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0cRcZzEt4NgDr0UkddGCNHxYlQq0CleKgPAMlVYs2qs=;
  b=NItyBYJp517K+8s0NCeCi+THH280eRtC/QB6Vml7AerpSlbrOh365xWR
   AEBqp9Yck/rnsSlWy8DO2B0ngNZgddDSqzI589xUjvlhHq8vz9VzfTR4k
   p63wlCSzE0kzve6xjoteLfp+MRVTEKPLKKJHvdCHqKmgBilMlGoBIoLV9
   nC9wGVb0GgHQpdmcpvc7jJpHP60Lrqsarr/8XkPvP+aafIZxsNWXU1N0/
   GW7LgEkrDxIgvMfu0ufdWQLH7jjhlzoyNAUKMUYtrQ8gW99pKTxsWAtGd
   FMYILny8XPwj5wFRu7sKCiCOhmmGIODvO88Vrb2KzSiXCZQeAOH4YwdCT
   w==;
IronPort-SDR: CgOflhd8F8Lnz/zxCVs5I6zl/lzAx/bUx0ewI0gI+dKRg6qZI0lOnS9n7lmozpdHKiJoqVMsH2
 4xgjPimf5E3HWvbqBE4aqbCZO8cHaxLDRrYEtnJcdn42d8RzdEugE7J0+SVw7e8dpVoyAAB219
 3txRBl1pkjG9J7pKYdNH3fCgZzOVeTpXcT2U1pGqSEmCteazb18iwQj4KeSnh0/4BCtwMm3rqK
 /BPJxGdcFonh42STAfutaR7RoFbXCsowp6HQo4/XOOhyQDvEDNvL30/t2p4Q9/R/8qWlkG35jE
 UYY=
X-IronPort-AV: E=Sophos;i="5.72,335,1580799600"; 
   d="scan'208";a="69188552"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2020 06:37:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 2 Apr 2020 06:37:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 2 Apr 2020 06:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cau3wEn23X462++updQNwYfyIXaE7ALLUh00FjSFei6KDP7tnvPb69CXgZd30szV+lnZTfM3syD7GhCHpshW7cjnbp7Q7XqOtRjhhr0qwYeJw8IwYjSsvjNSdAu5zxkMO1TmN83YhpbBoD43d2JnQusZosC4Q6AK8wLJXdFZmm96Uix8cf7b4ZMJHiMfqD3I12M2+ngkAAXJ0e/esD4QcnZlIk12e7KVLG91SK9hqtWAqCC72f3k0X47FrT6PoiU7E34nHf9Uh+Cmm0pS0pzDAvAjy0tZmvuqfBlZQqhGo8Zdxfhk/ATd9hk0RbX/JDkvZ2eTQcTp9ZemqRtxn6usA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cRcZzEt4NgDr0UkddGCNHxYlQq0CleKgPAMlVYs2qs=;
 b=DKmHnnnCSMbqupYtpuOO5EnPKo9opWcyM7onDmw0iYKz2yPerkpEdDa+iB59lbVq/QB0O5ojAzRua1BnhHE7iKEoETyJpqiTau14uUKdjUMPnZNPlXGWdXq7fvcMguoWws8TZqaBOcH3wfHl3bVJ7Tg4chJ96RWOelW/Jd6jlFDYVgq7oPYxYzoGGhMzbpPprsjK/vkkHd+pMMoJMXvUyqoGB2pWPPGrkWaxYvFh/dAzIj4saWlzbQGZ78LHEwBcxCrMIs3UuyjnqKxr4hxsttXGgQfgjRVPJPpYqGkRv0haoux+stM7JOa1Vqzyh27Y3113BSki+4L48asvdxsJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cRcZzEt4NgDr0UkddGCNHxYlQq0CleKgPAMlVYs2qs=;
 b=j8kWHCa6z1VCvvd9FOilqcnR9PSMsV/orMF3UJ+Zao24+ClpHqEgwltTYfZzn3kx1QcfFw/g16lIyUoXMPL2DB7TI4tVNMEulVGTQjYvi0GiGzHc/wzWeS4xoJKM3nZ43uPsqyVklZSEvKWazXr9EHkJ2pzTrCGU2nZVMXeN6SE=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2997.namprd11.prod.outlook.com (2603:10b6:a03:8b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 13:36:57 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 13:36:57 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <lkml@sdf.org>, <Adham.Abozaeid@microchip.com>
Subject: Re: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a
 private copy
Thread-Topic: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a
 private copy
Thread-Index: AQHWA4KEkW7XFxV0nkCn6WUH3cFHMKhliiaAgABWYYA=
Date:   Thu, 2 Apr 2020 13:36:56 +0000
Message-ID: <e418c5e5-df8c-6b0d-ede5-01d2490c68d9@microchip.com>
References: <20200326152251.19094-1-ajay.kathat@microchip.com>
 <20200402082745.GG2001@kadam>
In-Reply-To: <20200402082745.GG2001@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [49.207.49.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79a2dd23-4d68-4161-f957-08d7d70ae9f8
x-ms-traffictypediagnostic: BYAPR11MB2997:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB299792BBD14DA885B18284AEE3C60@BYAPR11MB2997.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(39860400002)(346002)(366004)(376002)(64756008)(66446008)(8676002)(86362001)(76116006)(66476007)(66556008)(54906003)(66946007)(31686004)(31696002)(71200400001)(6512007)(2616005)(478600001)(26005)(4326008)(8936002)(6506007)(81166006)(6486002)(6916009)(186003)(91956017)(81156014)(2906002)(5660300002)(36756003)(107886003)(53546011)(316002)(55236004);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOQVjAfwRQEEQabO13vCt45Hklx8lHGi86KrfQDaDnj3/cBCqlUpKn9OrUJSDU4v6zGlxFuSvoXCQ42u3wxxvc+8++fyqs8+tF17TiuNkJeGOv0HUE3dXikZfBQmmaZleFY6EbpIiARil2XSRvwV2jaiyPLXrrj1Yxf6ZqvbttJvlykHBP5vpOMClbudCGlsSEUhWX9E2DOM91pIKJLPCVwyMY8G4SRU+r2dGJ1eQQSrDDR74Ff+73S/Weihz0mdBtUFt3HB45+KqVyFOMW/bUOBbzZOs+66OyPyAVfwL86P7nvkicTiKpc+i1JJ22wdncduFHJ4DUBwUdX6qU65aqnNy33aydNRtbFnkS0X13tBSaqG/qmjw9gRbDm4BRww5BU0yESZg/PKz1cH13kpatWI8LHA8o4aPkZr35Jc3DRF94Xhy8VlObPR3WWyEw+/
x-ms-exchange-antispam-messagedata: dqpYJzH7ib8hwNgGPdOOiXP+1N1JQsTdz44oGs0SSEvFjQvUPgEXZ7tXRXEtnWqjvyl/sNduNyI0PlNKU6UFASUT37GjMY4Wj52Dk1kKqxfVp8YW3GaHBoVw8xRnFJXEGi/aZlGiN8q8507ecpxBtw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9CBE86DAFF177429C11DA1FEE6C9FE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a2dd23-4d68-4161-f957-08d7d70ae9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 13:36:57.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1l6KKobyvjmQ51QYpa3caFfUsmj0oV6prdYV5NeTDbsTA5fwL6iySBBz6NALfnIE2lLs7si0RGuSvffrGNTFLTJbdlfv3QrtZdlUynQAhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2997
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGFuLA0KDQpPbiAwMi8wNC8yMCAxOjU3IHBtLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgTWFyIDI2LCAy
MDIwIGF0IDAzOjIzOjM2UE0gKzAwMDAsIEFqYXkuS2F0aGF0QG1pY3JvY2hpcC5jb20gd3JvdGU6
DQo+PiBGcm9tOiBHZW9yZ2UgU3BlbHZpbiA8bGttbEBTREYuT1JHPg0KPj4NCj4+IFRoZSBjb2Rl
IGluIGxpYi8gaXMgdGhlIGRlc2lyZWQgcG9seW5vbWlhbCwgYW5kIGV2ZW4gaW5jbHVkZXMNCj4+
IHRoZSAxLWJpdCBsZWZ0IHNoaWZ0IGluIHRoZSB0YWJsZSByYXRoZXIgdGhhbiBuZWVkaW5nIHRv
IGNvZGUNCj4+IGl0IGV4cGxpY2l0bHkuDQo+Pg0KPj4gV2hpbGUgSSdtIGluIEtjb25maWcsIGFk
ZCBhIGRlc2NyaXB0aW9uIG9mIHdoYXQgYSBXSUxDMTAwMCBpcy4NCj4+IEtjb25maWcgcXVlc3Rp
b25zIHRoYXQgcmVxdWlyZSBtZSB0byBsb29rIHVwIGEgZGF0YSBzaGVldCB0bw0KPj4gZmluZCBv
dXQgdGhhdCBJIHByb2JhYmx5IGRvbid0IGhhdmUgb25lIGFyZSBhIHBldCBwZWV2ZS4NCj4+DQo+
IA0KPiBJIGRvbid0IGtub3cgaG93IHRoaXMgcGF0Y2ggbWFkZSBpdCB0aHJvdWdoIHR3byB2ZXJz
aW9ucyB3aXRob3V0IGFueW9uZQ0KPiBjb21wbGFpbmluZyB0aGF0IHRoaXMgcGFyYWdyYXBoIHNo
b3VsZCBiZSBkb25lIGFzIGEgc2VwYXJhdGUgcGF0Y2guLi4NCj4gDQoNClRoZSBmaXJzdCB0d28g
dmVyc2lvbiBvZiBwYXRjaGVzIHdlcmUgbm90IHN1Ym1pdHRlZCB0byBkZXZlbEBkcml2ZXJkZXYN
Cm1haWxpbmcgbGlzdC4gSSB0b28gbWlzc2VkIHRoZSBwb2ludCB0byBrZWVwIHRoZSBLY29uZmln
IGNoYW5nZXMgaW4NCnNlcGFyYXRlIHBhdGNoLg0KDQo+PiBDYzogQWRoYW0gQWJvemFlaWQgPGFk
aGFtLmFib3phZWlkQG1pY3JvY2hpcC5jb20+DQo+PiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnDQo+PiBSZXZpZXdlZC1ieTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9j
aGlwLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEdlb3JnZSBTcGVsdmluIDxsa21sQHNkZi5vcmc+
DQo+PiAtLS0NCj4gDQo+IFRoaXMgc2hvdWxkIGhhdmUgeW91IFNpZ25lZC1vZmYtYnkuICBUaGUg
UmV2aWV3ZWQtYnkgaXMga2luZCBvZiBhc3N1bWVkDQo+IHNvIHlvdSBjYW4gZHJvcCB0aGF0IGJp
dC4gIEJ1dCBldmVyeW9uZSB3aG8gdG91Y2hlcyBhIHBhdGNoIG5lZWRzIHRvDQo+IGFkZCB0aGVp
ciBzaWduZWQgb2ZmIGJ5Lg0KPiANCg0KVGhhbmtzLCBJIHdpbGwgbWFrZSBhIG5vdGUgb2YgaXQu
DQoNClJlZ2FyZHMNCkFqYXk=
