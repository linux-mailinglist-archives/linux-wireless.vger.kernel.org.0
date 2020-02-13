Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740A815BC1F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 10:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgBMJv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 04:51:58 -0500
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:47550
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMJvy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 04:51:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvO3thMuQWBpYmEXxl8ooJb4fJ7Z//Gw5swDABSCcl+euT9OPXUKfRVfA6JZ0rrPhBbRTPO7B04lnmohwiQC/U98cUnJ8TXIc2XEc/Dh4WMIVjkgF/FcJfIbq6qvygUP7ddq0O5f5XApPO0PKOVQgHithR6xZQ687iFqJb0sts2v3EnFHeaR2Mr5awNxrwteIZ1ad4U48X3Cr+JAx33uHHYx41m92Xc3OZz7M8HcrM6rYqfRf4Ce7pcP/pMQPE1oNVwQY4GGB0w8BNKV5G8K7Zli6P4JQSMGJJcoYFwmnTmyj99SpxS5scCycUwPyj8flr8qQ4YwSCkPmp49KeogSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL7WOS4melmDIJk6gpU/XbFIVenFcGQ7WY2xY2FRo+o=;
 b=TSJ58GcDr0jnE+Lyq1scKMEvSaJAos7qHU7nzNKJiGz9p11EE45Ahh+P9IAiLAyS0LzUN14eKYa/opN61HcIGVGrYh5dFprEPWqd3xilznC4J6KL7hx3JuLN3RTrh9mWWlmBWNRRkuVdb15HUTtu7C+pDpJiV+W2QTeaie7J9czwiwAzV1/xNsl814Yb4ESEhADUbk9ZbJ5KTQmFrto1Lbhwpt50PdbtkkraH/Cd/1aRO0unc7slhdiukg81PdmI8tKWUsenlOafyVb7i/jE7aes6u3aQEIaZp/NjPP2HNwjdV9ZMWKjB+3xA1gMRvtHe4FKYbH3h9m9Fk1+6E/k9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL7WOS4melmDIJk6gpU/XbFIVenFcGQ7WY2xY2FRo+o=;
 b=IMKt0yW69SEa49ltbM8vnlFCGy9/Nco20ThYSJvdyFZi8MvP8S5S1686is31CxzKTX0zQlJ9flYdHUJzOfQ/zCRuZxjx0EWSdDRkw3MV/92SFbkrWq5SZEfjYdd/L03IGmt4yzB9NQ3EokAin1xS6w3zS9tK1iRzHPz39zXGNQ8=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB5052.eurprd04.prod.outlook.com (20.176.234.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Thu, 13 Feb 2020 09:51:50 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::d55c:9106:6fb2:cc34]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::d55c:9106:6fb2:cc34%4]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 09:51:50 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        James Cao <james.cao@nxp.com>, Cathy Luo <xiaohua.luo@nxp.com>
Subject: RE: [EXT] Re: [PATCH] mwifiex: change license text from MARVELL to
 NXP
Thread-Topic: [EXT] Re: [PATCH] mwifiex: change license text from MARVELL to
 NXP
Thread-Index: AQHV4b/tZx44F7YX6UePcnsCYOq30agY2xtNgAAHmTA=
Date:   Thu, 13 Feb 2020 09:51:50 +0000
Message-ID: <DB7PR04MB524216D914474B912619487C8F1A0@DB7PR04MB5242.eurprd04.prod.outlook.com>
References: <1581524230-10212-1-git-send-email-ganapathi.bhat@nxp.com>
 <877e0qx326.fsf@tynnyri.adurom.net>
In-Reply-To: <877e0qx326.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-originating-ip: [115.112.95.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7ab7ee3-27c5-4216-f14c-08d7b06a5962
x-ms-traffictypediagnostic: DB7PR04MB5052:|DB7PR04MB5052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5052B2FAE02BDF7304435B508F1A0@DB7PR04MB5052.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(199004)(189003)(9686003)(316002)(44832011)(33656002)(4744005)(55016002)(86362001)(26005)(81156014)(8676002)(186003)(7696005)(8936002)(81166006)(6506007)(76116006)(66446008)(66556008)(55236004)(66476007)(64756008)(66946007)(45080400002)(52536014)(71200400001)(5660300002)(478600001)(4326008)(966005)(2906002)(54906003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5052;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0ZZn8fqb1pJzVyER9jiDWmxJPUmcqzeheNGUVWW/bs417aLLTQVqtErd4QAdcw97FV2UCN0MlILJ5LGiWPN+Xn4b1UTYJuqsZJpThKW8usQptWe7RRpYSo0uZJYScgaF2WWQ/yBMvkdIcS+aP5el0F3gLfdfHbcVB4HU0IO//WVo2MjdKgoBnU+BYsU5HwYZhFFEiWao6RGzJELWgZNltJF1hlgc5UlXXT9cWLaSEw3oxeQHa82rITu35olyEnbF6LnmQ5glShxDCmvDd11LaVhV2gtI00cTejJePm+mWyNyRdwdypB94U3UPWWpBPLcCStcqS/PO5o4i6jl+R2huKarsGc7kedE72OcAgbEOCoDMQdo8LWUys2M8cJcl1i5fmy3YNf9B6G+NZU18RxsuwO7dulwLKyWBF3b/sGbOfpxXq9NxUsLDrgqPm6mZISTjVSaicPAET/L5I58D7uQr1xDjgJg/ZFflKXk5ARB8f0eiLXEO4l70faFkyC2TKM2pluXN7EbziaYX2YaSbz0754RnLKPiVG+tm03BSU11wmCMth8BqLpSPErdJPqlriPQWPjSP3sZsdemLHaHYXplAmbGeX95rAiCP3dgH5HZymRlS9fE9ryu4jAAATw7ON
x-ms-exchange-antispam-messagedata: r2dxjnzMDpRCMew6YIkJqekYn9aOC+O0sPbS5AGiKSEgwFGCDObwB9E5uImUrtS/aGRzy4DbNBiym0G1njDpUTQ2MkGjMmdX58EN7EI0oW+pzleafNrL/s4UCLiMV6uZGUy+FONwN8YdQPItzwz3cQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ab7ee3-27c5-4216-f14c-08d7b06a5962
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:51:50.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuWBFEv57WUIUgX4xkDNEIKC9Rs+aL5s2ZN8zfJHEdWIDD12/srO4BfqhzHCKj4JDwDLIWngtnASQTxPbRJgoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5052
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCg0KPiBSZWxhdGUgdG8gdGhpcywgaXQgd291bGQgYmUgcmVhbGx5IG5pY2Ug
aWYgeW91IGNvdWxkIHN3aXRjaCBtd2lmaWV4IHRvIHVzZSBTUERYDQo+IHRhZ3MsIGl0J3Mgc28g
bXVjaCBtb3JlIG1haW50YWluZXIgZnJpZW5kbHk6DQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZ3d3cuDQo+IGtl
cm5lbC5vcmclMkZkb2MlMkZodG1sJTJGbGF0ZXN0JTJGcHJvY2VzcyUyRmxpY2Vuc2UtDQo+IHJ1
bGVzLmh0bWwmYW1wO2RhdGE9MDIlN0MwMSU3Q2dhbmFwYXRoaS5iaGF0JTQwbnhwLmNvbSU3Q2Jj
ZGUzM2MNCj4gMTAxMWE0YmEzYmJiYTA4ZDdiMDY2NmY2NiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDDQo+IDAlN0MwJTdDNjM3MTcxODI2MzA2MDU3ODQ0JmFtcDtzZGF0YT0x
bHNYOURpdFZRSHBkTWNhd1ltciUyQjcNCj4gWElpQWpMUU5LcTNDcHByZDBhVXFjJTNEJmFtcDty
ZXNlcnZlZD0wDQo+IA0KPiBCdXQgdGhhdCBzaG91bGQgYmUgZG9uZSBpbiBhIHNlcGFyYXRlIHBh
dGNoLCBubyBuZWVkIHRvIGNoYW5nZSB0aGlzIHBhdGNoLg0KDQpPSzsgSSB3aWxsIHNlbmQgYSBz
ZXBhcmF0ZSBwYXRjaCBzb29uOw0KDQoNClJlZ2FyZHMsDQpHYW5hcGF0aGkNCg==
