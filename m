Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1518F9FF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 17:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCWQh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 12:37:28 -0400
Received: from mx3.watchguard.com ([63.251.166.21]:16267 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgCWQh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 12:37:27 -0400
Received: from PRDITOMBX01.wgti.net (172.24.2.21) by PRDITOMBX01.wgti.net
 (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 23 Mar
 2020 09:37:26 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 owa.watchguard.com (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3 via Frontend
 Transport; Mon, 23 Mar 2020 09:37:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv66oZsN7Uo/9PQqf4h5beEV6zShOJ402zXCbu6sDCH90kvv/Yf4GpU6i62EsPvqpMSJRksyLaCepBGbpuTJYWT/woiPh9yBgm36zxiOye8xOPa+2lnEicvTmp/YE7GGq/fRiMglQSBznuGvd0sbt3n/5c74D9mrr5xmbcCSTtxRtuYeF8oAQW7tT9QFwfvVCmQCe/U+lOYDakg3Fgl/J4nGbG+rihBAgqCDY/QoVuP2OSQYOJIjjd7jL+dEYVdrjP+UCSv4SlF5aQ6XgaBZt4Wk6G4BxG2w+C08GkgWrXZs+cGrsRT0M/CU1hKdobO43q7MPu/FwXcX56qg74qstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izjm424UDdC+pTvomLDt4yzKfm+kkL+joCUxUw6KC5c=;
 b=KfEAd3popS7pcVz/Sw4p5B7PzkTAbVFKTOGA8yZEcpjEPPcfp66HRKt7W7v7LX4usr+IIuITGqW7dRHY3cQoH6vDeDn6tZZROfwCMvYOV3sCBftnLo1qGi6aqImVDoHzhv2JMXJBhCJpEoitlwloemmAAp5XVFNKxxDeF4mqGckVFsVqHh8a/x79WzDd9rtdXynyyG/FIJLmxU9AFNfPyv/PW8GCkLVuVGPUnYyZk0X/pD3DaWCRyKJKD9BJTfpuI3YrvV2wS68C+5CR5kymlTpH5DC7xf2jpRTsFt1Ixqsl+7duJCVnLhw2soWfnc0jT72rlJQ5CuBLPgDkhzMhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izjm424UDdC+pTvomLDt4yzKfm+kkL+joCUxUw6KC5c=;
 b=pRsBe+/WIvCPIxmUoKz1RxGnNNy7suz0xL43Hoxn9TJB3YprFpkLNMR0KsTId/pFlvu/0FwEIRuyD4YAB7NCxbCD5CsvG3CFcwIXCAIXuviatLDMtWFz62/IU2QswcEucSgGRI9kI01QkVJ95qtav/teCA04ysBqGtIAPrxzbBQ=
Received: from BN7PR10MB2737.namprd10.prod.outlook.com (2603:10b6:406:c5::24)
 by BN7PR10MB2530.namprd10.prod.outlook.com (2603:10b6:406:c5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 16:37:24 +0000
Received: from BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128]) by BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128%3]) with mapi id 15.20.2835.017; Mon, 23 Mar 2020
 16:37:24 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Firmware Crashed
Thread-Topic: Firmware Crashed
Thread-Index: AdX/0YxOsQET/+KrQn2mecR6d2iN5gAP8c6AAEdzTgA=
Date:   Mon, 23 Mar 2020 16:37:24 +0000
Message-ID: <BN7PR10MB27370353B542954AD795D77E9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
References: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com>
In-Reply-To: <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [66.235.15.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b3608b1-437c-46fb-2545-08d7cf4877a7
x-ms-traffictypediagnostic: BN7PR10MB2530:
x-microsoft-antispam-prvs: <BN7PR10MB253037BD8DD363C0C9C53F879AF00@BN7PR10MB2530.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39850400004)(199004)(7116003)(3480700007)(478600001)(76116006)(52536014)(33656002)(4744005)(4326008)(2906002)(9686003)(6916009)(55016002)(5660300002)(186003)(26005)(86362001)(81166006)(81156014)(6506007)(53546011)(8676002)(8936002)(7696005)(316002)(66476007)(64756008)(66446008)(66556008)(71200400001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR10MB2530;H:BN7PR10MB2737.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uRV/pcqTVfG5K3/+owVK76iZKE9ese0pheXm4i5qFmTthwKJCqSWirYd3Q3YIpL28jcfCSGLWUgxTmOhKXJu9uLB8+YJ9CBXIWe9vJQYV0Tgp6n/GentRpiOB8wvlJ1xs9YUlpIoJd70kDEcFqqar+rn5rL4ij8fIpW/yWkwv4g9Kia8r7omgPdci/EazpoQ6/Eulm8UmOBN5wCnj9wopKI+LdwqJ0lI/Y8Fw8qlZVgf22y2EJhuEL/cVSGdr4ekX4VP/xX1NYJU58XTi7Itho1mbwlQOXdclxZd4aRGuqHNQeOTzFVlaUIdL4zcP65yCnASrfouDfGqFWfd++VTbUnnqh+rhIQ4llKtePP2Rlu716lsBt1zKFLNnN/Dw7i/DQDlws3DPG1OFOqSWFIFZV/6Z55l4fLJElorXOkI02LL5rfATqd4KABVGJVO0nYk
x-ms-exchange-antispam-messagedata: QQm9WPyC+EcSvAQM6omXJgLJWg0moyCwxK2oxTj6d2OmvVfnMq7JSJnKy6FJlL1jW+SxLOdNvXXKskaYzXL4CAUSKHlLFeiHeJB2Xge7LjTVmQgzjCqRvDd9+Ap3xgrCMOuDls0m581LDuaaHLs75Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3608b1-437c-46fb-2545-08d7cf4877a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 16:37:24.6992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YntpSbMTXBSc37AwUi94Bb4U73tLeG6G3egbI5g0ojhYjckGsAJHVsjfpVzdl0INvSuab/4vz8hB9+NG89X4BQrqKMeCHcZaLLP9GoJyRn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2530
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tm8sIGl0IHdpbGwgYmUgdmVyeSBkaWZmaWN1bHQgZm9yIHVzIHRvIHVwZ3JhZGUgdGhlIGtlcm5l
bC4gDQpUaGlzIG1vZHVsZShRQ0E5OTg2IFBDSWUpIGlzIGZyb20gdGhlIGEgdGhpcmQgcGFydHkg
Y29tcGFueS4gVGhleSBhcmUgdXNpbmcgdGhlIFFDQSBkcml2ZXIgYW5kIGl0IHdvcmtzIHdlbGwu
IFdlIGFyZSB0cnlpbmcgdG8gaW50ZWdyYXRlIHRoaXMgbW9kdWxlIHRvIG91ciBvd24gZGV2aWNl
KFBQQy02NCArIEtlcm5lbCA0LjE0LjgzKS4gV2UgZG9uJ3Qgd2FudCB0byB1cGdyYWRlIHRoZSBr
ZXJuZWwsIHNpbmNlIGl0IHdpbGwgYmUgYSBodWdlIGNoYWxsZW5nZSB3b3JrIGZvciB1cy4NCg0K
DQpUaGFua3MNCk1pbmcgQ2hlbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IFRvbSBQc3lib3JnIDxwb3plZ2EudG9taXNsYXZAZ21haWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgTWFyY2ggMjEsIDIwMjAgMTE6MTYgUE0NCj4gVG86IE1pbmcgQ2hlbiA8TWluZy5DaGVu
QHdhdGNoZ3VhcmQuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZn
ZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IEZpcm13YXJlIENyYXNoZWQNCj4gDQo+IGNh
biB5b3UgdHJ5IHRvIGJvb3QgaXQgaW4gYW5vdGhlciBkZXZpY2UgYW5kIHVzaW5nIHNvbWUgZGlz
dHJvIHRoYXQNCj4gaGFzIDQuMTkgb3IgbGF0ZXIga2VybmVsIHdpdGhvdXQgYmFja3BvcnRzPw0K
