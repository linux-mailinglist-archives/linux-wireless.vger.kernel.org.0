Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A591ECC61
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFCJTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:19:01 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:19364
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgFCJTB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:19:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGoGRDJWEwenVn/1Og8vd+Kv+3ldPINVymr4uDBahLAKB6A8Jxyyghl4MmCYj2MgaJswNHIcbGeWS5zkZkI9c3yG0Cgs9pj0t3X2u/kv+eo+gZ0LBo6ftvKjABB9pWX+gXz58RuflrTPzkY7sVH4giFLFMGKASx3h4CMPm7yhVcn3iFAgcosPOjWXoQ6P7kOXodZQzpNTRtI9S7659/7f4rypom+x33uvSSLhi5gzdX7+QTW++ZrJXMoOLH8j551b/uxw7n067Ly7hcol7OE8BtxQQsdpdb7jnBCow9jvqODYvCxuhTxYj4260LnZHhzvt2FtjPXzJxrJvcMgRcs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8SYUhiaGRf3gliqgDPh+9KTtHYELGZpzrQRlk9zyqo=;
 b=ejE2rjWy5piXd9HlwfjqHqRldfhZUfLofqJUW2s4ALIEKmG+QbiO+yCOUaiMzzWxlhBn+eYdNbuivAzJVKkBYG0LIgXM/ksQGAX4bLekJfDQb7Lc8rEckqT49BCUobwPzRbxML6KJ4rcYbEUAM5xkSuy5+2P8GUbI9mmOVUSB7kSnRX7T5O1W8l5h3j9zF3rpagD/h7ikyVo1DLQqTvISHkHHoFUkC8f9nfsJCv51xab49RzJ9SqC2guWeSdKeBQHU6IYYsG7aXyncW2tp3KTxARQ/pwsm3iHwRUjsEd8fBjI+4l05ZteviHXZb9JBHCw3E5bNx1jp40/B1xCZCYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8SYUhiaGRf3gliqgDPh+9KTtHYELGZpzrQRlk9zyqo=;
 b=OywoU8PStlrCsqsPtHAWV2WNY5xMeAD3iO22vBvvhBFboAvs+s2lBCDMzmqyQULXuZ+5qQlzzUpMy0jFRHu7DfRlkBRw+L/heb50eors55y76BkVjkYxVWFGIB3xbialSeErLp0KfSORDp5ECEebDZGZ+eUmgBDtTBabWjVVaiI=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB5854.eurprd04.prod.outlook.com (2603:10a6:803:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 09:18:57 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 09:18:57 +0000
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
Subject: RE: [EXT] [PATCH 1/4] mwifiex: Fix firmware filename for sd8977
 chipset
Thread-Topic: [EXT] [PATCH 1/4] mwifiex: Fix firmware filename for sd8977
 chipset
Thread-Index: AQHWOYAu0AlQfq7g00Ks3xkelKR7bKjGnQIw
Date:   Wed, 3 Jun 2020 09:18:57 +0000
Message-ID: <VI1PR04MB4366A25C424086A4A2672F338F880@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200603082229.15043-1-pali@kernel.org>
 <20200603082229.15043-2-pali@kernel.org>
In-Reply-To: <20200603082229.15043-2-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b96c99c-ffe0-439e-bccb-08d8079f24d3
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB58544F7CE8F51BCD282DD9C08F880@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9PIUa24oKvA3s8DiICxNicEspXs072iwup/sr212QzsMl2OKya11Ham5b71ZqjvKAEusZE9qSWMPmlbz5sCZEpN2H/zKbwKivpD9IF0AtTPNehYuCEUxKZKZSxvMuSEgvOZFp0dTLG1WhM1xDOwXmo+Dwpj/6aJ2N2dW6VH16d30HTt3X4zG39jRRbZ5K5AtGeVvNE8IC8FZHkXf7YpYMR4jC7tI9gLirnHuq790jiqMoo6lJjY2KPaZSXxOAeKN0nUZ81ZsTEcGQrVR4VKa7fckC/qjWD0whW9QI/onTNHAc0CLOQX9XyCm4Wja2i7K/X4mQ2+wTbOy36/woMnpzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(478600001)(4326008)(44832011)(86362001)(6506007)(66446008)(8676002)(2906002)(5660300002)(19618925003)(66476007)(26005)(33656002)(8936002)(52536014)(55016002)(66946007)(76116006)(4270600006)(64756008)(66556008)(186003)(558084003)(7696005)(9686003)(54906003)(316002)(7416002)(71200400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wuVpp1qdqOErW4ZyeB9V0N9t8Iz1zUQ/eNW9MHFvYJLGXQkHyOld+hbbNfN7zoQ0Z6xlwjPldSpnG9AdGSzjP//euozbhpJZPyfccqgaRpauXWNdOf5bYWIzW4Z7MWTJ4QtdQD9iTDhaUh3KlAEavmWoJy7xGgCIkh08NJm9KUCq/pcNOlCTGiTHV4rO6nEV7RvWGADmhNzQr1O8ZgDiW77/g13K8CpO1iYmIF+RkAa8hZAyF/Q+ppY7fYMCfu/MpNSgZIxrmgB0Dmr/Whh4r3bSVY+dR8eS6WkMB1IBCtyQemAJSnKRLrHy5cws1kM9zVvbCFAy9oNkEXrC2xyI90RdVWTYIyxx1L/rLX/593Mwbe4tOTnJmRz7zA/RYrSKrV00nDwH8vohv6OJQegiXMZUN/XNgxs12gV4i+QpGQplsAj3WSNqmopCnTYl6wfjx4mHhWQfgzhr95w0tboMJvozbXQ88Poq1WbrPhLVWX0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b96c99c-ffe0-439e-bccb-08d8079f24d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 09:18:57.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ1ucszLoErH5ttQTQUkSsZ940yYwSEs0qulkJNiLfHpVSj+gTc63uXRWaGmBqhydhvHLdE8qCgDNuUqD2IjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWNrZWQtYnk6IEdhbmFwYXRoaSBCaGF0IDxnYW5hcGF0aGkuYmhhdEBueHAuY29tPg0K
