Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9321ECC5D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgFCJSj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:18:39 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:61017
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgFCJSi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp6taVVLz8G6S4rvzA4wT3xE5xaF5Y2gfflPYvmqKH0JD033TcfUwVrCQ/u8z52P1QvayZR7Z4rMhltsFx3ZJQDzbJGfdzXJYldNwN6w+wAq2y3qt947iCi/J8X6ZE4tPq2pJUUFMN/TcBpJHWbAY3m6MZJz3uL3PD2YgK/1JJLkgSBEBQZJegP3pTgZLBJES8WIoiVqNa4FUOJQw42+7R3QtS0gCj1qElQXbAWdca3266hmeGXO1fNuc14eusT6aTRDsIduizblii64zjmA4tvqX9Zl/75Fdyxq4dPPOiF/0Ln7CISnNqwTnO+npioU/wXBn3rlE3tbVcANxC4XIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8cRooJiwqJdO/ka8RVuSrn10RfPFXn7N311zL32yOs=;
 b=KRfhrHOyZydqS5HCqYkM1jIBSzHHZAZvJLd0rxdwPjLf5CEgLWlSipPwDH8GHM4NCDUm0Xd7GdAqjdV7N6biMI3tXT9UulCTEA3HqH9M2dBZ4ccgJH0JzngYXIlk9l70x2P0xgLUCKXMZJ9mBTkb1XHSaRLb+OcrvqaZjITxYwFyCPpZh8/AVY0E+mJrZA2bc4+6Z3vYsC1u9a6T+3DIYegE9oEz1IF85FE4SJEGDosXgbfsQYU2EM6BogCJL81DShHzXDjomohrellCWY/pjgAFp3lT3amGiHaKJ6KirufiONI4mc4TbPZkwpoM0O1JA5TZ+AvH7s6jcmT1FzCCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8cRooJiwqJdO/ka8RVuSrn10RfPFXn7N311zL32yOs=;
 b=miOa7SgTAEhInOUNntY4cxFUheK1gBhlfAI3+4vxJiO9C44HkrPLM+bWg7WLLJkci0biY+y6Fp0gGoEDixyfezHDFhgV9KlAI7I4ljDSAO7XUDpByigy+8/7Ar/ruLx5TuJNrPgY9Q1p8S5teSWCig8fBGfxlTB5r4qURQyabeE=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB5854.eurprd04.prod.outlook.com (2603:10a6:803:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 09:18:33 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 09:18:32 +0000
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
Subject: RE: [EXT] [PATCH 2/4] mwifiex: Fix firmware filename for sd8997
 chipset
Thread-Topic: [EXT] [PATCH 2/4] mwifiex: Fix firmware filename for sd8997
 chipset
Thread-Index: AQHWOYAwo3xstiho302SqwhGSyA3w6jGnMOA
Date:   Wed, 3 Jun 2020 09:18:32 +0000
Message-ID: <VI1PR04MB43663C312C48DE85B29EBD6F8F880@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200603082229.15043-1-pali@kernel.org>
 <20200603082229.15043-3-pali@kernel.org>
In-Reply-To: <20200603082229.15043-3-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f54c377-b782-4a50-e16c-08d8079f1665
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB5854D9729CABB13353BDC7528F880@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICLAuHDW7Q+xmu6Kb1AXZgo6EntPwN99JrJcCarQXNZhHe86V8eCsqzWpVXeWcjKYqOPfo2aEMW4/8pXGOjt4sz5Hoj7Rs1t2u9MXRvAy8HT/GK8+4zDUJ5IgMTa7Om5aVvxSdbT25DKO0AcfrNvR8oJOe66gdM/r++zcF+o4+jQsaqg1qBzCyrkA7IbnexNd7lI98tc0yqeIp/N+r1KwXRRubq547qv4PE3xr1hPY7DfiruhYS0n7LxKChkuFISaY/DJT7t6E1UrKDVVhJ4XprhdLgkL7D7dF617MzwI7AK1X4b/dbYTi/HrwN2Dw5czpUvdPC3jxgHSj7a1cSxBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(478600001)(4326008)(44832011)(86362001)(6506007)(66446008)(8676002)(2906002)(5660300002)(19618925003)(66476007)(26005)(33656002)(8936002)(52536014)(55016002)(66946007)(76116006)(4270600006)(64756008)(66556008)(186003)(558084003)(7696005)(9686003)(54906003)(316002)(7416002)(71200400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: M/aWDsG89RXfSW+bd46srDVcC6O2iFh92VZNALHKRnOG1EP9gM5E1ygnauHOnltklCSZCY7W9Q3l6s0ND8GecSajJOXC0sl/4ciyghH+fMRkvoAp7X39lKPanpkDxcF8WF7gVXSOOIqCcRedRifJLOEcJovaI5V7+zT6YiW2g5APdRhQzvx8plPAGfrfkuHdGE3f+cq3QWfvghJwvQJPZxPyKIvyu37GI5G+sYTRgPziOirci5h/04WtLtEqVYqQUdLz6noFalOjcBP/qYO9+JA/LXiPoH7e4DLV2OzV2ZGGIw3dzOaqbS+gYCcQYAlp5gP/KpNnsRI0oNAr96TzKxIWbcgTJ8akpy17H1jV3aPi0wSmCw3AUhEIfdSb4ajggrzHm+QJSSb+GRCBYifOHrcmwp6XO5hb/EzC0yOMvxb9pocKNVMGd8gQYgOf9PNWGpKI/zh+YYHnFdt19X1/kDQgwufTHSXYYxhB7qqmdIs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f54c377-b782-4a50-e16c-08d8079f1665
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 09:18:32.8586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdmTj3sWgQqB9vnRmNvzkz/MXT/5E51kS4S99vrhNUvSac2VFvN6HuRUaEcLJd8RMdLsrHNsueMU+v/RZxhQDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWNrZWQtYnk6IEdhbmFwYXRoaSBCaGF0IDxnYW5hcGF0aGkuYmhhdEBueHAuY29tPg0KDQo=
