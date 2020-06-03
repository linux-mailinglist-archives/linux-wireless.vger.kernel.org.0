Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091A11ECC59
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgFCJSB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:18:01 -0400
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:6059
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgFCJSB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:18:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD9pHFxfb/1hg8bCIbLKXz0K11SEAXl57IGSjC5yx87xfGPhAMC0DolJ6hjtMTR3mOhK6elyoBYsIbY8EwiCEudns+Y8/Dj98+GxLQ+OtxUg65AYMni1j2da0aOdMzlRzUqBwrgZQiSzW+EwUFB6OXGavwK1zmVSckqpRZRtNveOs7M73F/huZXZfNi7OXl8GfZ5YITkExNOeXYleAxFKH67FS3mq4MA9KG7ZEzWrCWVq3/yRiNTkvLfWpXAgTt1qeDNdnmYIEt2G+tcnmDDrQE5jRQzXx/JCu0p56O8VzKcGTQWZfS9XXWo015ryVsKx1POsqUDTOk7D0B03p27lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FUJ+C1pApJOANztQdzPKoiwSUVWKnZ1i6xErXLDM5s=;
 b=hjS4K586ZdJ19DcOHlbThxa6SNREjmB8z4IQHTdSRjIzvJotShE1KWL8KCCSuUAkttkzGoFWGeyJZ6HiIM08maWNDXtjZV5c1YFgQFcNj7zi9ZPF234Ouwdlde0mZ3VG0hMFoeDDZmRJd3QAdBn+QrgDi53i5R2KKkQSTkyVpKn9H3iN8ZAWjPySZAGwBR+zbR91bBx/vAyviC4sFFMaKq0p0sAp+ekgKCfx8HH+bm7A9gBStQtDEQvsRKbw5OrYoE6SOW4jsNlm05YxFGyUtIpwPGawEf8xdfJ5KTwiYLCtowlgGZ0UDsjT/7p7hvoSDxRMIHjeF95XxvTSAqcmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FUJ+C1pApJOANztQdzPKoiwSUVWKnZ1i6xErXLDM5s=;
 b=InFJWA+n9Ov7YiO/BvF8nQmFxZw2dRXF3jk+gt49Y6r2MQl41yHO89Tv174wkjWzUp4FsepRRlwkNVmhbOdNKBs2cisO9xqHgVqwctzCF/6CS/pyiK/QPOoyKOIeDT8sJ2Ff8T/l1OjDjCrDEAy1H2iIZew2kAs9RcjO/ZEy3sw=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB4094.eurprd04.prod.outlook.com (2603:10a6:803:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 09:17:56 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 09:17:56 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hemantkumar Suthar <shemant@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Zhaoyang Liu <liuzy@marvell.com>, Cathy Luo <cluo@marvell.com>
Subject: RE: [EXT] [PATCH 0/4] marvell: Fix firmware filenames for
 sd8977/sd8997 chipsets
Thread-Topic: [EXT] [PATCH 0/4] marvell: Fix firmware filenames for
 sd8977/sd8997 chipsets
Thread-Index: AQHWOYAualKOSbAU1kKfAkawWcwZ0qjGnFZQ
Date:   Wed, 3 Jun 2020 09:17:56 +0000
Message-ID: <VI1PR04MB4366E635AE42AF40300D8BBE8F880@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200603082229.15043-1-pali@kernel.org>
In-Reply-To: <20200603082229.15043-1-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e9dcf77-eb74-4826-4b04-08d8079f00e8
x-ms-traffictypediagnostic: VI1PR04MB4094:
x-microsoft-antispam-prvs: <VI1PR04MB4094EC62DEFAB66589A23F0C8F880@VI1PR04MB4094.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcJ3JYH9p5axl++HemRB5EMJ/vn55fMXFTeboSIsr0vg6ssfxisYew+95XH5/i9H5kZ7el0KrGvTP6SSwJVdk9iCDOBXsEKOXj86NRxOhtn1ASVUiHm7XgjjCjMj+rmLxV0Zp38rXR7o5XuJRzG1jeVqDwrSz7HowKHOjMqw2CxSzHRwIzOzyndNq0EhmLXRisKMeBM8D0qW5OsH9bv5aoYkGYrCHpeMDSVTjix4MSRqcRDM6oYgMt83+GpK7UNNm+I2SiRyN0f6uFbl7Yx2qtDS6MxtkrClUnkWyix4wih6SXccUYqy5dXqDYqL9oSFCaB9cLZqH9edAIpA/HLj2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(33656002)(2906002)(66946007)(478600001)(8936002)(64756008)(66556008)(76116006)(86362001)(66446008)(8676002)(54906003)(316002)(66476007)(110136005)(7416002)(7696005)(9686003)(55016002)(5660300002)(558084003)(44832011)(4326008)(186003)(26005)(52536014)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VIydxggsplQaYa0xsCict369iZh4zTjOHTCuy2Xm1No8Hzk++3iuOKO9Br4JW+Ikc7a5xmmldtGU0p50M3OWCLbjwpKS0e8Ts46drSvbuhJdnC7+Xgd/T2pp3wlRPvI9nfGYBoaHkjQvIwFQTojZF8ik/M3Cgshx2UWbj7/P3F/F6k1DZR3X09neUQ8B/BrI6JS1qIef0ucTyn9BmJT92vHzYjiwxR1w84TQBh5MGpwiNQ/mdl+8Hl+Ckgv+Xug+pH3E5C9sCietEBlr2YxyjNACS9ceIigqEk26+wMTISp84Mcf6udTHIhInGUCovi9gFgQ/T5hvtLEClM+h105hd/cfFyjsYQ9J0pdq4xcGsoi9UFi991QUSaCUIpQ0lEVLVGn+qavLYe7h5HVUj0LLUNzU0gi6uML/6nR+5/Y/ZVxgO1FBDHflr4KRhffUtphKElXxHBiLlzulU/7/i5Jr3wSPir1Yyx+TaXg36gS53w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9dcf77-eb74-4826-4b04-08d8079f00e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 09:17:56.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4QWI62N5DaNhws2wso7irfu+Mw9wYVj/LMI7JN8mYWwXWKpasRUw4l06fim7A6u0mjgFP/mPyi2fasvUO8NPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4094
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgUGFsaSwNCg0KPiBUaGlzIHBhdGNoIHNlcmllcyBmaXhlcyBtd2lmaWV4IGFuZCBidG1ydmwg
ZHJpdmVycyB0byBsb2FkIGZpcm13YXJlIGZvcg0KPiBzZDg5NzcgYW5kIHNkODk5NyBjaGlwc2V0
cyBmcm9tIGNvcnJlY3QgZmlsZW5hbWUuDQoNClRoYW5rcyB5b3UgZm9yIHRoZSBjaGFuZ2VzLCBJ
IHdpbGwgYWNrIGVhY2ggcGF0Y2g7DQoNClJlZ2FyZHMsDQpHYW5hcGF0aGkNCg0K
