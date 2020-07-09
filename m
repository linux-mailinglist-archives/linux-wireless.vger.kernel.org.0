Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64F82196C7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2020 05:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGIDnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jul 2020 23:43:41 -0400
Received: from mail-am6eur05on2056.outbound.protection.outlook.com ([40.107.22.56]:1736
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgGIDnl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jul 2020 23:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoBlPdGze0t2uOJWBzUGexMYDTOwRIofAQALFd8JgKk1PtmKLnDLb7I9QbmJEzDNxyncx2YhzN8C02zHHACk5A9SUO0KzAm24SVs9u1eTluhrBw0cAKn73FB+O5mZ0PPRyVLxrmd6WOa/jQMhQr/YmO7d8WxXE63Ko3GHxCYZo/8N4i0PiuFhxPZ3Lzt5tMcX5fvfT5DB46g+FNfoJzVzftnXZmhLDCYN4NRzuE3e9xMmP9Kyw9Je/Lwi6jW960QLBs+pOGAAH7HS694zqzOo/SXvCuGA2nqLisKQ5MqwTHeag1PshCfuCdt+BoGNnpCPuwTwGcLRK0ynSSuypltHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2YE3kBW2hp0cS3YhbXAgeF39YU76nZVtngZ310nrQM=;
 b=ZSGqdcEPKlT+2rab22MXpGI5871Kbah2vZ1e2+fiJ1in7CAgt55uDobQT8ejHtjtyHvfK0MKiFCUn37ch9Zo5S32rSEM3paZvyQQkmGy9Kghq7pTsDtJYd0vlWXyK1DAALZnMqbD/wgB/+EuZwt667iwX4qXOzo7U7sRjvPTLk3F+3BZg/5+M6rCntkn+VDdOxg7rDydMXLmyzwTvwyy4+jUlS95rwyJwCkUF65Ge/tNPxQm8tMCmthP3/YWN1k9Q+dp34ZXKN4VIONMmfvs8KU/TYrSgDNVZRLq08SjZ2RUSr840L9pIBvKOc15d+f6j0c3fBnH2tTmtEFFfWx/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2YE3kBW2hp0cS3YhbXAgeF39YU76nZVtngZ310nrQM=;
 b=sCM/gHF4PEnRn/hsxoiBIklbZiHOPfihhcNY3VndVhwZ/wur5jEYau/6cSuT7B1tYbwOGo2exwEq9qspbU8FAc47AJykTs3kNdGezzLWLl27p6q8PIHdveZygjXPj5goXDyMQo5/HTJde/OICjMwQC9dJbZkf5+uGL1FblFTadU=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB4335.eurprd04.prod.outlook.com (2603:10a6:803:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 9 Jul
 2020 03:43:37 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3153.031; Thu, 9 Jul 2020
 03:43:37 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>
CC:     Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Bing Zhao <bzhao@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Marc Yang <yangyang@marvell.com>,
        "frankh@marvell.com" <frankh@marvell.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [EXT] [PATCH net-next] mwifiex: Prevent memory corruption
 handling keys
Thread-Topic: [EXT] [PATCH net-next] mwifiex: Prevent memory corruption
 handling keys
Thread-Index: AQHWVR87H4tDoS6U/UG2OCjcvd/Gaqj+m7bA
Date:   Thu, 9 Jul 2020 03:43:37 +0000
Message-ID: <VI1PR04MB4366F9D7F65F90569A1ACB308F640@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200708115857.GA13729@mwanda>
In-Reply-To: <20200708115857.GA13729@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16ffe419-35a5-434d-36ff-08d823ba43a2
x-ms-traffictypediagnostic: VI1PR04MB4335:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB43359D7AE6DD2102C7265CBE8F640@VI1PR04MB4335.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04599F3534
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7gCvRKYANMF4xAbbywArNptyd9VXEs6mIikrVdlJq9WyAcW+NVP6kF4ZveWbRuxpMKB+LyFmp931qW/EZSYr0b0Zpyrl02WqOXzE9smoS4Ks42iS5S6MrWcghXujKELRqeVrujLAkJLcgDKHBUrwvyNlsVOnsk7jE0/xpV83nksT2LA1OFRDbQdy7vDUsbSs7gfgIf1YeFbbfCRe8rF+HEODP/JnqlZaiQJd2bQgijCAhx3vBFu5rpWfes+yhn6oxdfGn/UDrYO9gQBO1+cDWIJ7BBY5RXBZLYqdB57JYdI1OpADmr9ZlWxpiiHlOxCc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(478600001)(6506007)(52536014)(33656002)(8676002)(26005)(76116006)(7416002)(4326008)(8936002)(86362001)(44832011)(66946007)(2906002)(54906003)(558084003)(64756008)(186003)(66446008)(9686003)(55016002)(7696005)(66476007)(66556008)(71200400001)(316002)(5660300002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nAjI5eFGhjheoktEZe7v2eLrUh0wvqGbrboJhh/vSkTY/YCTndJlpAvn9GTf98qDp6YtGWvMAx9vbnnfK114PCGanZwRsRZ2HPu78gz1v4XA4t6b+DBm7Xxiusk2+tMGGf8LUOqIVhT9L0LdJL6AMIDbz2DiDOQWmE339jzHjgCDPWHWzt4ElV63/KwRIYJZbOP5hHrfUb51S5d9Foo8QjMActt2F+2Hy8fERbjn39kZQwOh6f1wZwn4DqAzFjzdd+vsmnV6SzhNfDA5H6HrxVwvInCjQK5kQCOiOIzuuHeB6qXNAhJYhUIeUHRPov4XVxc0J6NsR2ldmC3IohkfMQemyITWnCzQtpzAp+Iu6aMTkrQd3wjsi4El4tzUzLWySITDmqsTQNFAj7C8ukbFCbMM3N/SL8lKH8SpLTcO4RBIACLI/10U3k/efqUi24daqF4i7zGNZfRnBLUK3nGTBs3u9aLSsq1eYtGOm+lcgUY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ffe419-35a5-434d-36ff-08d823ba43a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 03:43:37.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgoJmdOJpZ1JTZApgfZaFmiGsPeSrI+O9X8eDDrSptoUpX+7fHU/T7fS6kGjOUrlH2/00bvXQ2EZHf84vkc6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4335
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

> The length of the key comes from the network and it's a 16 bit number.  I=
t
> needs to be capped to prevent a buffer overflow.

Thank you for this change.

Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>

Regards,
Ganapathi
