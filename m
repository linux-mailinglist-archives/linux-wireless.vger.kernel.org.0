Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CDD1E60D3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbgE1M2G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 08:28:06 -0400
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:64583
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389675AbgE1M2E (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 08:28:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZJOBhsSD7G97hU6jHwRMUk36yf0G6ENxvyZ7+nvgABCq2/e+q+OWD/ZJsRUccDcuxUHCbbJYUpXfj8DP9ThzrguxCM2nc7zbec1qt0P1+VlggSggnSscIUXKb0y2MUYohLCQwgcalT9Mt1EPi09FsYoVxSRH3aQEiXdwiqpBlwECYrkWrl7OgCbjRPfWDH4raYyth0gpulQ9OlUJO9WFq8Q6158rwxtdeBGToDQDxLzKWpHKqGFs0cloqQQkHvvXLvnckibdgOI8i8DyjXK/GpCJYUhbCqEmLMja56J5fEfuBZk9alR8uM4yVyfp0si1ApmzeLzUoat+OLSxL+wDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxUhPFjBba9j9NTmmRFl38ADoehkBBskOCr6VfVPWeA=;
 b=c4inaiMmU9aePCPr3U0CEyChGqRw6o9EDkU/5Vo5wgevLW6JSQYkYRuQn4baB5VOTMT7WsZFoAQ4v48SZ0Il65hA6qDm085yRckZxE2OJrA4dcArqELAxLwP5Lp61vPymabE60nOZLxZ6i/zWboNjcUOagxXRyU8CgZBjgD+6cV4JznkKiS4DWoeHdq6QVVvapif2HEsQQYs2OMSWQuRlAIDKUWRcnmPdn2cqKCFRC8DBAip6ZTkxYFHwK6Bja4lCTZdHD6CeFl0VYZhZFi3gKP4g/GhiZMiymeMQ2BCETl2PCXzZYdlxXRU7WBeQJD+8k64lvx6myIfB31zPct8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxUhPFjBba9j9NTmmRFl38ADoehkBBskOCr6VfVPWeA=;
 b=L7xsA4H12ldOsLrFMhBAuzqnVTURUoqnr+gknjVeYntsH/x/nbd6gOJM6nfWqYVbauhDYo5qwm2aeKMldgSfYZgrrhex+m8VtgRAH4q5flf8rUFp7k/O7/MGrbJrZw6ml/Qy+GQQSOwQ8oyYrgS+amEYvEUPPTykUIHo2DlU4WQ=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB6095.eurprd04.prod.outlook.com (2603:10a6:803:f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Thu, 28 May
 2020 12:27:59 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 12:27:59 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Subject: RE: [EXT] [PATCH 04/11] mmc: sdio: Move SDIO IDs from btmrvl driver
 to common include file
Thread-Topic: [EXT] [PATCH 04/11] mmc: sdio: Move SDIO IDs from btmrvl driver
 to common include file
Thread-Index: AQHWMEeyh682z/ig0kGzv14HIh2QU6i9deIQ
Date:   Thu, 28 May 2020 12:27:59 +0000
Message-ID: <VI1PR04MB4366DC81FF6F107CDA1A658B8F8E0@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200522144412.19712-1-pali@kernel.org>
 <20200522144412.19712-5-pali@kernel.org>
In-Reply-To: <20200522144412.19712-5-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 230124b8-4ca4-4d1a-0da0-08d803028f1c
x-ms-traffictypediagnostic: VI1PR04MB6095:
x-microsoft-antispam-prvs: <VI1PR04MB6095F3D40CC36660FA73A7848F8E0@VI1PR04MB6095.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5gYnGTpkDezkHfd0x7wrYWPe5b9jgVoDH7lHXnjLDXAg8WSZ4I/rBYy9KpD2O55MgD1YwaOehYwTdDI/6E6Eq185spaq17qhQLFVMzLwD+P1xCuVyNEDxOf6FfMTVHFNZ5108sgk3ttvCkqqrteBNjw+S9EW00mUgX/emlUkuYfXTK+o9Z6jwcc0Nji2TBXVJxrIh7yoyiGY/jmAQQoiwdArJZn0edK/ujyK+q1jIGK3hs2h0VyuAWpW+6zjA34DCOO89AsqRAgiZe8//mXQBNr07XCIQ0S2nrtWU+EJyQMBnIRRcfrGInKiaTSrTmb9ZZlCgC2lCF7NTRdPquEl48sxbY5arJdOX9zqXGwae8dNGvHDeN68CD8HJleQmMB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(44832011)(33656002)(316002)(55016002)(110136005)(558084003)(7416002)(8676002)(9686003)(4326008)(2906002)(8936002)(186003)(26005)(66946007)(86362001)(5660300002)(52536014)(6506007)(76116006)(66446008)(66556008)(66476007)(54906003)(478600001)(71200400001)(64756008)(7696005)(40753002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pMsDcOYGepsi9ye1X4VLuFQcUp6AwMHjvDkLIw+NVcs3SVhhCnuB2hyMFGgcCsoevvVq68aZWzrQ7xBXyERHTnhPsv1lltA9LxcsgMMV65eommKY1NZdmwHXtBVAwfa7saaF8fCdDH6qhGlfoWqV6EalTymzPzpDQQM0qe3cKGKqnRR7npjQnEM2xFX5XPMZW5yy/pyBig9y4r0G/8ZzllysIzz3Ij7a4tlIwQJ58MonP4HmdWcX1YV95t/L3ScsxjUJn/A/Ijhj9nibWKVZOl0nGaGbqDhtvvI9gFuN0YQDjUYMohfL5I+PYOskuqWwZXlOSKlqkIhAJIQIOC34WRSXIYb+uKsQQA5r+AjNsI5uiunbo+0HmbntqZeEDQJLC78pQ83QWBuOfUilGOD9HSpMjTfGqApGHEnFPNpePadEZtRJ+B6XyqhZIM8AnqWsf5xMf2bJyW/Qfmn6LR4DHRKC811W+LqB3ShqghYAZxI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230124b8-4ca4-4d1a-0da0-08d803028f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 12:27:59.7334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5IZeovv3ghdmaaRezjp5Od7sctFpha2SfibEXlAmbqERQyE5R1ccYIrW3KZ1F9h/GmJgCO42oY1hD0GDLYxUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6095
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgUGFsaSwNCg0KPiBEZWZpbmUgYXBwcm9wcmlhdGUgbWFjcm8gbmFtZXMgZm9yIGNvbnNpc3Rl
bmN5IHdpdGggb3RoZXIgTWFydmVsbCBtYWNyb3MuDQo+IA0KVGhhbmtzIGZvciB0aGUgY2hhbmdl
Ow0KDQpBY2tlZC1ieTogR2FuYXBhdGhpIEJoYXQgPGdhbmFwYXRoaS5iaGF0QG54cC5jb20+DQo=
