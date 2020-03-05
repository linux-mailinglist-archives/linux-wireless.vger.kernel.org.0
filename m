Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59993179FD2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 07:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgCEGMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 01:12:13 -0500
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:12101
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbgCEGMM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 01:12:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8fQtPRW9r8QakRX2XutgqOZCVv1VF4WID6XiLv6+Rc136aEkgV4QjVeXMEz54ry5e9fq0srcD/B9WLyV5AEdsMtAvTNTiRr7MG8lBdfBaSV58GAx7lx07xiaMjjj5tr2oz8Z623TlmwNuhuXXLjU+tfMQ6xAXgK3YseqZXUDWkSNq7PkIJlYEB3QnxkgbiiwiMLLi+xPByZsQvQ0nbTZVEn5JUPtWbwhmu/KYGdIiU+g3wEd6+m5wHX7O+Rx5cqNhMTAz49S4/4wc8jSoPs4xs0UOAlGSY9SWrIAfGiBo+fmABRkIe90NpezOjclmUIUf56kQM213dytm8tco2eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ytm9Q2yx8Ys98O5hbHmueMzmjSuBvn+JuNhnkk2XzUM=;
 b=R9XIXtAnLfiOcMLpT6A+28qG5VEgSUKBoz5TxMpY85ekw6XqIqFLXwf5dX7TRW1cmjKF1MRtFe/PG2LBPS3V5rz+ayMh7X90b4CSPDrTqKOz1O0HPxPa6k2VHrvf+frVjJGojFK9F7liw7gG1jliQro5D5AKfl2E8eeAOI0Imz4qDu+ww2zCudAzvl5MjaSrzP7aJLrnfh5x4l3Y6UT8cZDVIXaJA3ka3rdrPT0UtmQYTBGDqHCeBsGhEyMrndQ8yDgA1HFcSJ10IzpZhoWBESiMp380MDgfhYBs5nAr9FL2jtxY0zXhdzEHuwu/NtaHnZ530oburaXJ08uYym90Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ytm9Q2yx8Ys98O5hbHmueMzmjSuBvn+JuNhnkk2XzUM=;
 b=nj1FTbG3l73FkOtffpHgU1JFKKOxbwPuXzkfC1YMHjSnEJjhV4LxCCvi0pl+pzjWVSoZssw44XBivA/VEaGwuRhudGwRkNcGGMJdT0pB01YBUFfdfgwZArUeasUXZZtJpUe+CPuMqdOLYTfSh4gtwYkQ/+BPdF2REXSuAuQfaDE=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB4316.eurprd04.prod.outlook.com (52.135.128.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 5 Mar 2020 06:12:10 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::d55c:9106:6fb2:cc34]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::d55c:9106:6fb2:cc34%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 06:12:10 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Arend Van Spriel <arend@broadcom.com>
Subject: RE: [EXT] [PATCH] mwifiex: set needed_headroom, not hard_header_len
Thread-Topic: [EXT] [PATCH] mwifiex: set needed_headroom, not hard_header_len
Thread-Index: AQHV7QGefb0w+LZbCU2BNI3eE64ugag5ZweQgAAOjACAABkz0A==
Date:   Thu, 5 Mar 2020 06:12:10 +0000
Message-ID: <DB7PR04MB5242361751E47736B116BFD98FE20@DB7PR04MB5242.eurprd04.prod.outlook.com>
References: <20200227000511.256055-1-briannorris@chromium.org>
 <DB7PR04MB524240B38FF6603D89D694538FE20@DB7PR04MB5242.eurprd04.prod.outlook.com>
 <CA+ASDXNvjJLzH+_0g1OUNckmRoLyNJVwiAg9=OPwd7LGk-E2Cg@mail.gmail.com>
In-Reply-To: <CA+ASDXNvjJLzH+_0g1OUNckmRoLyNJVwiAg9=OPwd7LGk-E2Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-originating-ip: [115.112.95.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2310c18f-ca47-444f-da69-08d7c0cc23bf
x-ms-traffictypediagnostic: DB7PR04MB4316:
x-microsoft-antispam-prvs: <DB7PR04MB4316658C556CA6BB669468018FE20@DB7PR04MB4316.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(4326008)(71200400001)(66946007)(64756008)(86362001)(66476007)(5660300002)(8676002)(76116006)(478600001)(66556008)(316002)(66446008)(26005)(81156014)(6506007)(6916009)(9686003)(2906002)(55016002)(44832011)(54906003)(7696005)(186003)(8936002)(55236004)(52536014)(81166006)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4316;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDyIJyptb1gaEHJEu8lDst/k8GEUfl8AIo/uFYWgusm52X+tSM+az30iDkl0TqmkmjsA7Tep68wGmm1R7hcOvWUpLM1+yXEdpZ9D6fT8lW79iPVEy4BP3dTxLrsSRIf0i36bSpxAjgH5UeNtxfS4GrstcfBVEPbKbbJEXYiVzcWHoCvo/BhLJn/MH/XyhM+5KPcmKlARfp9s05nkULa+Q2r+4UKKSbPZL3lxeXyaX6Y3kVuLLeY44zRscAb5VxfV3Vk/Hz7kOdSYK0dOb964NSdmaUd2vkGYqM6QZbKYHybv8HE0aGe7yvb17huVxjGROLUW3KHF7sTXc8UrE1vcqarIckjhe88xJDajeOdZrSkb7oOxN6QRbtEwycl8r+zuGyywrScKpSWfycuj3n4d6Sf1sG2fXq3nDZULP8cV07Vc/DEvSsWYHMS07AIfdcSU
x-ms-exchange-antispam-messagedata: Q4PSJ5c5nJXZCi8VHkjuYcVlGhvD8ZzvijxEu1Rr34+zTDzxvc/z2uhVCFGTeOwcMwYVRtj0kcROHGM+GZb1mjlp6ot6t1Sdy2a25eWbT20KjqKsdqMyJaduAQjZWR2kx2hcZGT0xVKDo9XwRVRMsw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2310c18f-ca47-444f-da69-08d7c0cc23bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 06:12:10.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CEKEwyA1Tu2IcJYH997slSxWj7C+92OOIAzg623ChtRpguzZY2rgl4gNhx1o5A58iU3cjzqw37HIItkG39GAmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4316
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQnJpYW4sDQoNCj4gPiA+IGhhcmRfaGVhZGVyX2xlbiBwcm92aWRlcyBsaW1pdGF0aW9ucyBm
b3IgdGhpbmdzIGxpa2UgQUZfUEFDS0VULCBzdWNoDQo+ID4gPiB0aGF0IHdlIGRvbid0IGFsbG93
IHRyYW5zbWl0dGluZyBwYWNrZXRzIHNtYWxsZXIgdGhhbiB0aGlzLg0KPiA+DQo+ID4gT0s7IEhv
d2V2ZXIsIGFyZSB3ZSBub3Qgc3VwcG9zZWQgdG8gbWVudGlvbiBoYXJkX2hlYWRlcl9sZW4gYWxz
bz8NCj4gDQo+IE5vLCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgd2UgZG8gbm90IG5lZWQgdG8g
Ym90aGVyIHdpdGgNCj4gaGFyZF9oZWFkZXJfbGVuIG91cnNlbHZlcyAtLSBldGhlcl9zZXR1cCgp
IGVzdGFibGlzaGVzIHRoZSBhcHByb3ByaWF0ZQ0KPiBMMiBoZWFkZXIgcGFyYW1ldGVycy4gSSB0
aGluayB0aGF0J3MgY292ZXJlZCBhIGxpdHRsZSBiZXR0ZXIgYmVsb3cuDQoNCk9LLiBJIGdvdCB5
b3UuDQo+IA0KPiA+ID4gVGhpcyBpcyB0aGUgZXNzZW50aWFsbHkgdGhlIHNhbWUgYnVnIChhbmQg
Zml4KSB0aGF0IGJyY21mbWFjIGhhZCwNCj4gPiA+IGZpeGVkIGluIGNvbW1pdCBjYjM5Mjg4ZmQ2
YmIgKCJicmNtZm1hYzogdXNlIG5kZXYtDQo+ID5uZWVkZWRfaGVhZHJvb20NCj4gPiA+IHRvIHJl
c2VydmUgYWRkaXRpb25hbCBoZWFkZXIgc3BhY2UiKS4NCj4gPg0KPiA+IE9LOyBJIHJlYWQgdGhp
cyBjb21taXQ6DQo+ID4NCj4gPiAiLi4uIEFjY29yZGluZyB0byBkZWZpbml0aW9uIG9mIExMX1JF
U0VSVkVEX1NQQUNFKCkgYW5kIGhhcmRfaGVhZGVyX2xlbiwNCj4gd2Ugc2hvdWxkIHVzZSBoYXJk
X2hlYWRlcl9sZW4gdG8gcmVzZXJ2ZSBmb3IgTDIgaGVhZGVyLCBsaWtlIGV0aGVybmV0DQo+IGhl
YWRlcihFVEhfSExFTikgaW4gb3VyIGNhc2UgYW5kIHVzZSBuZWVkZWRfaGVhZHJvb20gZm9yIHRo
ZSBhZGRpdGlvbmFsDQo+IGhlYWRyb29tIG5lZWRlZCBieSBoYXJkd2FyZS4uLiINCj4gDQo+IFll
YWgsIHRoYXQncyBwcm9iYWJseSBhIGxpdHRsZSBtb3JlIHZlcmJvc2UgYW5kIGFjY3VyYXRlIGRl
c2NyaXB0aW9uLCB3aGljaCBpcw0KPiBwYXJ0bHkgd2h5IEkgcmVmZXJyZWQgdG8gdGhhdCBjb21t
aXQgOikNCj4gDQo+ID4gU28sIGRvZXMgaXQgbWVhbiwgaGFyZF9oZWFkZXJfbGVuIGlzIGFscmVh
ZHkgY29uc2lkZXJlZCBieSB1cHBlciBsYXllcj8NCj4gDQo+IFJpZ2h0LCBpdCdzIHNldCBieSBl
dGhlcl9zZXR1cCgpLg0KDQpZZXMsIFRoYW5rcy4NCg0KQWNrZWQtYnk6IEdhbmFwYXRoaSBCaGF0
IDxnYW5hcGF0aGkuZ2JoYXRAbnhwLmNvbT4NCg0KUmVnYXJkcywNCkdhbmFwYXRoaQ0K
