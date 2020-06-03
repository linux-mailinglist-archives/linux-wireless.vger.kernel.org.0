Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708871ECC68
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgFCJTT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:19:19 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:2820
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbgFCJTS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:19:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhzuerhW71NiJ+wn5OQVIuXurDcCBq6OMeIBk1E/hfIw0tprxsMFxOCvxxvnfmyEIHoQ9MX6EelGXiNECd/MKZzoR/ItK5tI+alZm+iu/H/QHWSw59jIepx9L9clnVJXCI+NyMjzWyCt9XQnUmQsq0ih8tuKBHOILxaxT2vXlw6p9SEyzXazt3gAHm8FzSWVxuZ17Uxfil6hYCCDUx6IOmOh9a7kO0+CxYTzducZeq773KrK+tFrW9rp9BENJMjYViPDuDd8CW5FW+m4bLCBR9QZr4sqprxhLeaPxCf4JU3wib45e38F8E1n/rsGd+LSMdaucwtQ8WmGqNz6ItzAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8SYUhiaGRf3gliqgDPh+9KTtHYELGZpzrQRlk9zyqo=;
 b=JCCHq+cH8BT4QQrvZ2wtbdY/YeDjQv/J4Ldw/fa+4M5i+rPdgP/evlXwYRPV/VJmrjoonjTt5GpNEL7aZud8IWWVPNPdlm4WtuBoc5mDmQ0TehXBewBPoLrBWG8EeRpa+NM/YVOs/60BVnbYzzyW7kpeWHtsinoK9JcvQN0petu49092rfYAACQpy1MQmtzUTU/QKdWWJFHBqpIe2MMmKLF9ZE6jkiwb5dXO05tyIEP52BEcBAjAPYYYpOvOpny3qkarCh0QMjde5tqAN8DLy659vr1Ojyzh1jjoVn5mrmUDMq5q0za0OcVPZZZYwjVymseWpcjloKzIaPKjO/depw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8SYUhiaGRf3gliqgDPh+9KTtHYELGZpzrQRlk9zyqo=;
 b=Gn3OMcFwnRAwRVXz6KuGrH2WlXcjsiOGsmurC6Vz315p9f2Yd7ery9J+TSqtOSY+R7NDzbZubppOxR8DO6mc4ooiKeEzkHBxUXK7wL+2fKBohZkJTbqb2sEyPfLPYxXlixONevnUMEBoJ3x083QTtty8dHhXN/WvutN0h88DdWw=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB5854.eurprd04.prod.outlook.com (2603:10a6:803:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 09:19:14 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 09:19:14 +0000
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
Subject: RE: [EXT] [PATCH 4/4] btmrvl: Fix firmware filename for sd8997
 chipset
Thread-Topic: [EXT] [PATCH 4/4] btmrvl: Fix firmware filename for sd8997
 chipset
Thread-Index: AQHWOYA00kkEwUYYGE6UTNGbj3DPb6jGnRVQ
Date:   Wed, 3 Jun 2020 09:19:14 +0000
Message-ID: <VI1PR04MB43665C2835DFEDB7B4107EF28F880@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200603082229.15043-1-pali@kernel.org>
 <20200603082229.15043-5-pali@kernel.org>
In-Reply-To: <20200603082229.15043-5-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e1b0208-79e5-4599-5913-08d8079f2f59
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB58540F89F07A83FFFE588A218F880@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CTDmzqR3bGmbh0Pxk91R9rqTvj9RdkFYs4vInT3N11pMskgNPWqxcgZIR1/5bltXx6K1xWeS/znP85KhKr9xPBrykfH3hjJnhBQIHY0Qf+3DahIKXXS3kTml3boEnCSmBvYaORNtrgmDN76t7zmlhuapoPel68+G1JKAIewC2/B4iPoj0/KGG7MtNLq5R32f072kC9NPgkOQj5YNBfPnMTwANHgT7lZIbqydkjqK3JNdZNYRxKVZB0lFNHlss9GWuz3OSS/BsmnCXggmmfryN/kkFxpasOr0MCBjHqcDFICTW1nE6XBb+5Xl5fEVOERa7Dp/uZz1vcjwBr2LY67gnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(478600001)(4326008)(44832011)(86362001)(6506007)(66446008)(8676002)(2906002)(5660300002)(19618925003)(66476007)(26005)(33656002)(8936002)(52536014)(55016002)(66946007)(76116006)(4270600006)(64756008)(66556008)(186003)(558084003)(7696005)(9686003)(54906003)(316002)(7416002)(71200400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hrqcy71IVjsFIrU0BFd81CQRJp22QKEbPko83X3B0FY2ji44nNH+j+mRR8YHDxN0Vs1aOTl+xCTywwabItgscjrzsPZEsNCkvW2jncRKs2rAbNME7uNqgJBGV+G1+jLZhB73iSW32+JLKWmcF3IyVczYbo+tANhUP4S6Wrz9bA59VcSP78CrYiN7JjipmtMOgVONLDz3C6fSTeRoE+sLTkA6jSIz2qBrLng5U7Qf71hCpfwGLHQCZcJTCrOiPjtpy9QWDggc2EY5oUngWf9h0PO7Qh/jOipntHCBfjCV9+nuRWm2GbrrC5qxLAfkz9pycupBxkGfOe3lmp4HzZXiJ0l6P5LrTmsXKm/bjWFI7bBouk8CgdgSK1nAO8JrZvEbvrc6sY+kfjZWrpW/bb1Fmg7WJ+LL4k2JnuR5pFRc5s0DWjFaBh7kdopW7U9Az78VDuFzbsB8rbyoSTEUk30LOio0x1ox1EDSbzO7wsQDKxo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1b0208-79e5-4599-5913-08d8079f2f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 09:19:14.6985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8lobjbzSIfpd0FNGTZroSVvbWlFUVacLsvGjdrH+NdkQImAkBN9IT5R9kZdXbBZuB5bLajKJBiBMRCEtqSlqfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWNrZWQtYnk6IEdhbmFwYXRoaSBCaGF0IDxnYW5hcGF0aGkuYmhhdEBueHAuY29tPg0K
