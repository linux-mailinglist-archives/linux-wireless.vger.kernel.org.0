Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4752E672D2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfGLP5w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 11:57:52 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:51644 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbfGLP5v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 11:57:51 -0400
X-Greylist: delayed 2333 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 11:57:50 EDT
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CF9YHN018311;
        Fri, 12 Jul 2019 09:17:11 -0600
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2050.outbound.protection.outlook.com [104.47.32.50])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tpsq38crc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 09:17:11 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFK2MEW4l/gZn2dr9XgMhl5G4tvTtkRGwZ5fSKcaFnDo81P521FtFGMejOV9z6v1fKBQybZhEP65bkmd8kCG4EWN52x5CWnZl+zMyahhoBBqO1BIVkKJ0kaTEqkzXJsAaUBuStpGJ3uQ0wf/14s/MGtSeHJZHRIfQE/+RTGuT3UaoV3uq2YsT63R8JQUeSl+wmx5La3I0s3gcZTriAbNNGJtsciq/5vvWxI+E2x7DMzvUZRevxV0+EhFcBkcLoh+fvxRIBKLrBv/RdVEXTNxv34DnqnGVud/38RFpdZAxhVbKdU95EMqjkPiwGCZ7PoVFF9+58nGYG8MAC0fQyuwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaO4yEDMimpmm8X2uB//Zq+/TZ4W3dOmCfuG9fwItyc=;
 b=go1S6gxfDkK0wgcUD8ju4c/7mcw+MjsIkMcXekId/UUrhS59hgl+//W1q64caKRXvjfOA41Y0S12AtV6U80kwmZab3EMMg0D1QRhKQQxQ+leT1CRCF9RmxlztukGGihAPgJTvp9VA+SavISOfc0TbvP/IMRM1ykmWA/UsAg3vIDjSexRethqsjQUdRXFnkrj0U4Q3y1Pa8CWsbC5itmPIluxtFjauozfDbLdjIalW4qXABAKboh4kpTakrFfBgEIw0dfCYWcqYQ2WpPucxlGJgElqPSd37jJYVKULc14h5djFhf50OhfpYBoPHa3fQlonefwHMoYa45VCzOt/AutLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaO4yEDMimpmm8X2uB//Zq+/TZ4W3dOmCfuG9fwItyc=;
 b=UH0MjiwxAEOlA2xcBwtAZIdw2MaB92lUWeR4PtWePjYGz+zff+frI8ckWWb9GrUowqxuTVRw6cEy0O0NYzYNpDJ81tPUea78CM2gXoe+cm0Vt/voDnBqCxOVWEluaYYWebtEG7bwGEYPBKwzpmNtYasM6aMgGsDdeZLzvPLLKqI=
Received: from BYAPR05MB5909.namprd05.prod.outlook.com (20.178.50.154) by
 BYAPR05MB5496.namprd05.prod.outlook.com (20.177.186.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.8; Fri, 12 Jul 2019 15:17:09 +0000
Received: from BYAPR05MB5909.namprd05.prod.outlook.com
 ([fe80::9855:ac9b:a07b:6452]) by BYAPR05MB5909.namprd05.prod.outlook.com
 ([fe80::9855:ac9b:a07b:6452%6]) with mapi id 15.20.2094.001; Fri, 12 Jul 2019
 15:17:09 +0000
Received: from CY4PR05MB3608.namprd05.prod.outlook.com (10.171.244.165) by
 CY4PR05MB3112.namprd05.prod.outlook.com (10.172.160.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.6; Fri, 12 Jul 2019 15:16:17 +0000
Received: from CY4PR05MB3608.namprd05.prod.outlook.com
 ([fe80::61f7:9dea:160:7dfa]) by CY4PR05MB3608.namprd05.prod.outlook.com
 ([fe80::61f7:9dea:160:7dfa%4]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 15:16:17 +0000
From:   Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jouni Malinen <j@w1.fi>, Tova Mussai <tova.mussai@intel.com>
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
Thread-Topic: [RFC 0/8] nl80211: add 6GHz band support
Thread-Index: AQHVDwOueUZErpPaukC9adjLePZw0qZ6MXiAgABwPoCABNrjgIAxyVwigBRUNACAAXDN2oAAE5GAgABM64A=
Date:   Fri, 12 Jul 2019 15:16:17 +0000
Message-ID: <4ea863a3-656e-0c7a-57f0-b7cf88614233@quantenna.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
 <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
 <48a43287e65e1d24082dea2cc32ca14998acb8d1.camel@sipsolutions.net>
 <8ca6ef2e-b41b-da40-b29a-77666d440495@broadcom.com>
 <a6e317539fbd53ad5e2fd62ce3544260a3f74e77.camel@sipsolutions.net>
 <d22d5159-60d3-5926-5b3f-bdc3ff07af82@broadcom.com>
In-Reply-To: <d22d5159-60d3-5926-5b3f-bdc3ff07af82@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::20) To CY4PR05MB3608.namprd05.prod.outlook.com
 (2603:10b6:910:51::37)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf10c62a-d651-44f9-a7f3-08d706dbe2dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR05MB3112;
x-ms-traffictypediagnostic: CY4PR05MB3112:|BYAPR05MB5496:
x-microsoft-antispam-prvs: <CY4PR05MB3112AA4711D5CE6C0A670207B0F20@CY4PR05MB3112.namprd05.prod.outlook.com>
x-moderation-data: 7/12/2019 3:17:06 PM
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39850400004)(189003)(199004)(110136005)(436003)(66476007)(36756003)(66446008)(446003)(66066001)(229853002)(186003)(64756008)(4326008)(31686004)(486006)(68736007)(6116002)(11346002)(316002)(3846002)(476003)(66556008)(54906003)(2616005)(6506007)(71200400001)(52116002)(14454004)(76176011)(6512007)(26005)(305945005)(2906002)(8936002)(53546011)(7736002)(102836004)(256004)(478600001)(6486002)(81156014)(31696002)(81166006)(53936002)(8676002)(71190400001)(6436002)(6246003)(25786009)(386003)(66946007)(19627235002)(99286004)(5660300002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5496;H:BYAPR05MB5909.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kVgwmIttXsKl3zbsLVVqfIrIEH9gpu0+oH/kPEsmkVY8G4tUP4l+6kTvfW1sHvCEQgnaJ0MnQDTWkJRWXtmjoNA3523oQ/NH0ntXyyG97YkZsZ4H9/Zht22h8KzItd0dNABkPrARH7MFMqS9gGYBWl1tX8nZWfaFrBWZVXMVC0t4RsTdvLDQiXE4J2DhCa/Dkcib1wBnQopYkaKV5Ay3gnHT/b2hI9b9oCYh6NfmgWiLmWGz0ncO1sedeRKjbpzIOpOG664Xa0cNH/u4UaBXMb8QAdR+8JsccsQ3u/wo5qQx7r9/I97qWuvMc6D5pocF9yI+rruGqnrS0MefG6W3LK1deZYx6PW7i3FbTdyyAm6M5zJHCln6oRWwsCWLZjfDfnhkmIGuT6hFb6gUb2FoVF+olETbzAOPDkAc/FDK0W0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91CB944FD33F1849907BFA481562D14B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf10c62a-d651-44f9-a7f3-08d706dbe2dc
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_25dfc1cf-b320-4423-8943-6be228551bc6@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 15:17:09.2168
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5496
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120164
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gNy8xMi8xOSAxOjQwIFBNLCBBcmVuZCBWYW4gU3ByaWVsIHdyb3RlOg0KPiANCj4gDQo+IFRo
ZSBpbmNsdXNpb24gb2YgdGhlICJIRSBleHRlbmRlZCBjYXBhYmlsaXRpZXMiIGVsZW1lbnQgaXMg
ZGV0ZXJtaW5lZCBieSANCj4gdGhlIGRvdDExNkdPcHRpb25JbXBsZW1lbnRlZCBvcHRpb24uIChi
YW5kWzZHXSAhPSBOVUxMKSBwcm92aWRlcyB0aGF0IA0KPiBjb25kaXRpb24gYWx0aG91Z2ggdGhl
cmUgYXJlIG90aGVyIHdheXMgdG8gc29sdmUgdGhhdCBJIGd1ZXNzIDotcA0KPiBDb21lIHRvIHRo
aW5rIG9mIGl0LiBEb2VzIG1hYzgwMjExIG5lZWQgdGhhdC4gR3Vlc3MgSUVzIGFyZSBwcm92aWRl
ZCBieSANCj4gdXNlci1zcGFjZSwgcmlnaHQ/DQoNCk1heWJlIG5vdCBmb3IgdHJhbnNtaXNzaW9u
LCBidXQgd2UgcHJvYmFibHkgd2lsbCBuZWVkIHRvIHBhcnNlIHBlZXIncyANCklFcyBhdCBsZWFz
dCB0byBwcm9wZXJseSBmaWxsIFNDQU4gaW5mb3JtYXRpb24gYW5kIHByb3Blcmx5IHJlcG9ydCAN
CnBlZXIncyBjYXBhYmlsaXRpZXMuDQoNCj4+IEhvd2V2ZXIsIGZyb20gYSBmZWF0dXJlIGFkdmVy
dGlzZW1lbnQgcG9pbnQgb2Ygdmlldywgd2UgbWlnaHQgdmVyeSB3ZWxsDQo+PiBjb25zaWRlciA2
IEdIeiB0byBiZSBhIHNlcGFyYXRlIG5sODAyMTEgYmFuZCwgaW4gcGFydGljdWxhciBpZiB0aGVy
ZQ0KPj4gKmFyZSogaW5kZWVkIGRpZmZlcmVuY2VzIGFyb3VuZCB3aGF0IHJhdGVzIGFyZSBwZXJt
aXR0ZWQ/IFdoaWNoIGlzDQo+PiByZWFsbHkgdGhlIG9ubHkgcGxhY2Ugd2hlcmUgd2UgY2FyZS4g
T3IgbWF5YmUsIHRoaW5raW5nIGFib3V0IHRoaXMgbW9yZSwNCj4+IGlmIHRoZXJlIGNvdWxkIGJl
IGRldmljZXMgdGhhdCBoYXZlIGRpZmZlcmVudCBjYXBhYmlsaXRpZXMgaW4gNiBHSHogdGhhbg0K
Pj4gaW4gNSBHSHosIGluIHRoZSBzZW5zZSBvZiBIVC9WSFQvSEUgY2FwYWJpbGl0aWVzPw0KPiAN
Cj4gUmVnYXJkaW5nIHJhdGVzIHRoZSBhbnN3ZXIgc2VlbSB0byBiZSBpbiBjbGF1c2UgMjYuMTcu
Mi4xIGFzIHdlbGw6DQo+IA0KPiAiIiINCj4gQSBTVEEgc2hhbGwgbm90IHRyYW5zbWl0IGFuIEhU
IFBQRFUgaW4gdGhlIDYgR0h6IGJhbmQuIEEgU1RBIHNoYWxsIG5vdCANCj4gdHJhbnNtaXQgYSBW
SFQgUFBEVSBpbiB0aGUNCj4gNiBHSHogYmFuZC4gQSBTVEEgc2hhbGwgbm90IHRyYW5zbWl0IGEg
RFNTUywgSFIvRFNTUywgb3IgRVJQLU9GRE0gUFBEVSANCj4gaW4gdGhlIDYgR0h6IGJhbmQuDQo+
ICIiIg0KPiANCj4gSSBtYXkgYmUgd3JvbmcgYnV0IHRoYXQgc2VlbXMgdG8gc2F5IG9ubHkgSEUg
cmF0ZXMgYXJlIGFsbG93ZWQuDQoNClVubGVzcyBJJ20gd3JvbmcgbXlzZWxmLCB0aGlzIGxlYXZl
cyB1cyB3aXRoIDVHSHogT0ZETUEgUEhZICg4MDIuMTFhKS4gDQpGdXJ0aGVyIGluIDI2LjE3LjIu
MSBzcGVjIHN0YXRlcyB0aGUgZm9sbG93aW5nIHJlZ2FyZGluZyBiZWFjb25zOg0KInRoZSBCZWFj
b24gZnJhbWVzIG1heSBiZSBzZW50IGluIG5vbi1IVCBkdXBsaWNhdGUgUFBEVXMuIg0KDQo+IA0K
Pj4gQ2FuIHNvbWVib2R5IGRvIHRoZSBsZWd3b3JrIGFuZCByZWFsbHkgZ28gbG9vayBhdCB0aGUg
c3BlYyB0byBmaWd1cmUgb3V0DQo+PiB3aGF0IHRoZSBkaWZmZXJlbmNlcyBhcmU/IEknbSBub3Qg
ZXZlbiBzdXJlIG5vdyBsZWdhY3kgcmF0ZXMgYXJlDQo+PiBwZXJtaXR0ZWQgb3Igbm90IC0geW91
IChBcmVuZCkgc2VlbWVkIHRvIGltcGx5IHRoZXkncmUgbm90LCBhbmQgSWdvcg0KPj4gc2FpZCBv
bmx5IGZvciBiZWFjb25zIC4uLg0KPiANCj4gUmVnYXJkaW5nIGJlYWNvbnMgdGhlIHJhdGUgcmVx
dWlyZW1lbnQgaXMgaW4gY2xhdXNlIDI2LjE1LjYsIHdoaWNoIA0KPiBiYXNpY2FsbHkgc3RhdGVz
IHRoYXQgYmVhY29ucyBoYXZlIHRvIGJlIHRyYW5zbWl0dGVkIHdpdGggSEUgcmF0ZSB3aGVyZSAN
Cj4gTlNTIGVxdWFscyAxLg0KDQpJdCByZWFkcyBhcyBhIHJlcXVpcmVtZW50cyBmb3IgSEUgQmVh
Y29ucyB0cmFuc21pc3Npb24gaW4gNkdIeiBiYW5kIGlmIA0KU1RBIGNob3NlIHRvIHRyYW5zbWl0
IHN1Y2ggYmVhY29ucywgYnV0IGl0IGRvZXMgbm90IHN0YXRlIEhFIHN0YXRpb24gY2FuIA0KdHJh
bnNtaXQgSEUgYmVhY29ucyBvbmx5IGluIDZHSHogYmFuZC4NCg0KPj4NCj4+IEknbSBhbG1vc3Qg
dGVtcHRlZCB0byBzYXkgdGhhdCBnaXZlbiBhbGwgdGhlc2UgcG9zc2liaWxpdGllcyB3ZSBzaG91
bGQNCj4+IGluIGZhY3QgYWRkIGEgbmV3IHZhbHVlIHRvIHRoZSBiYW5kIGVudW0sIHdvcnN0IGNh
c2Ugd2UganVzdCBkdXBsaWNhdGUNCj4+IHNvbWUgZGF0YSwgYnV0IGlmIHRoZXJlIGRvIGVuZCB1
cCBiZWluZyBkaWZmZXJlbmNlcyB3ZSBjYW4gaGFuZGxlIHRoZW0NCj4+IG11Y2ggbW9yZSBncmFj
ZWZ1bGx5IHRoYW4gaWYgd2UgcHV0IGV2ZXJ5dGhpbmcgaW50byA1IEdIei4NCj4+DQoNCkkgdGhp
bmsgd2UgZG8gbmVlZCBhIG5ldyB2YWx1ZSBpbiBiYW5kIGVudW0sIGl0IHNlZW1zIG5hdHVyYWwg
YmVjYXVzZToNCi0gaXQgaGFzIGRpZmZlcmVudCBjYXBhYmlsaXRpZXMNCi0gaXQgaGFzIGRpZmZl
cmVudCByYXRlcw0KbWFpbnRhaW5pbmcgdGhpcyBpbmZvcm1hdGlvbiBpbiBhbnkgb3RoZXIgd2F5
IHNlZW1zIHdpbGwgYmUgbXVjaCBtb3JlIA0KY3VtYmVyc29tZS4NCg==
