Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107451E7891
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgE2IoA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 04:44:00 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:6091
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgE2In7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 04:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2tYrUYnHPwl25J5oEx3O3IpH0Fz7Zfm8xlT99n5AGRWznmJzNLs6EdfvNOO+x5xNgdbRmY9k6FcikZqD3O9lpwe73KA0jO2ktx5iov9y7R9i5WNSghBna764heEqGawCBU+ojknfBogxpfyJz8HcXCOBflpWNTc9qLaupCcO8z1MuV+at17pd0DeMQEIcUfgEZs7Fhyvb0ddfWQnQGmdutYpMr4bs2CSt1QGf4rKsBj6+iPk+zhdd0/07CvI2Y4EEAJ7ni9p+zI1Hy+4Eimdz+fvHx7eibNC246rQcE1lxUZN72diihibAPsi+9toPfU1ERq0VTSscspV3CdeD3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78GDs1gfvZQWswkAYwsFeuk4nP3hvK73o8X1JV7dIuI=;
 b=T0BIDKRXwMlODiP3DF5BGAnGr6RHIERAvhL3nauTIuIksHNJ4pHLL0Kcs4i+6E8Nty5dcxMeV2hHdyophW+ILTL4pHbVdAfyp0XD7TIXeklKDwzS7Ow1jHG5I3bL6FIlNfn09tlWC8kLMfukAZEbUk/AYQmPPvy7RPG0SFypGqBt3rmeCZPIUNJX9xxN5h6G/nriOdiFF0iiaFIjK1Kc+ubbWL3D2GK3cXr/NhjySLQLq5gWjxuWPWq2/1ZuP5VUgTXUQ49i/ixt9QpjLM424yF4OVTc0ZxAnMKbKTKbTj5jMhyEfj7ewwZjuAOfbMdc8NOVKHcsz0NC8kPkIPNj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78GDs1gfvZQWswkAYwsFeuk4nP3hvK73o8X1JV7dIuI=;
 b=dR4tUQykTCxX0biQAufLtB1Rt4MvcQIOo2EZ21IMwYDld4PBp93aFigT9r7hdJTqAQ8WfBDJkdNB9kZ5leOU2XsHHyknK/oEBX84xuDGC1J/qN67QIQbtgR5kDRRfmdK+v1IKr+YnGiszL1egcZLgpK7Qe36Q6v0NgSpr+bxxxk=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB5295.eurprd04.prod.outlook.com (2603:10a6:803:59::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 08:43:56 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 08:43:56 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        =?iso-8859-1?Q?Marek_Beh=FAn?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Topic: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Index: AQHWKrwXtO/N2oQua0+uJ10PPhSg4aiqXxHQgBMCnACAAXIN0A==
Date:   Fri, 29 May 2020 08:43:56 +0000
Message-ID: <VI1PR04MB4366409B8E293A265851DA948F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200515132353.vfor7v4buzoddfmb@pali>
 <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200528103432.irmsaaz72x3xophg@pali>
In-Reply-To: <20200528103432.irmsaaz72x3xophg@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92e6a581-0b34-4d0b-1f3b-08d803ac6c89
x-ms-traffictypediagnostic: VI1PR04MB5295:
x-microsoft-antispam-prvs: <VI1PR04MB52952FEDF358E119E661F0C98F8F0@VI1PR04MB5295.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENbWaQTbktIL5J8Rfvc5feJQlAg1dH3J7kTotT/LRmMoVN22Mxq5vA1UboSeZWm9lATFOyEw6w2ihod2ZGIFw3DaGumwkhAaq2bft653TWc6UHMXfadcOYHLr0VTewQMbpu4jQJXGHHIMtnmuhh0ZJJb+S5KYPhf9VILuE2ENfD+h6Qqg2zh0oDV2WfiB4NAmuMNYdapB6G+rOziDE1LTomVeO0qJBrKh5RYyEdB1eTE0Ek5DvUEBc5pHxOUMO3OMmDiL/m2lLsxj9ucqpWljtMsVfYnROkj0Rn1V9mEx4QXqGJjIGjC2p/1Hw3uHo79YAwp9SAjtgs43nMrIXXs4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(52536014)(4744005)(54906003)(33656002)(5660300002)(71200400001)(2906002)(6916009)(8936002)(64756008)(316002)(66556008)(66446008)(8676002)(66946007)(76116006)(66476007)(44832011)(83380400001)(55016002)(7696005)(86362001)(6506007)(9686003)(478600001)(186003)(26005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: svWWM8QpfiDKlON5mb0JWqsXsddCuzJhX0QOJD9Ew0lSXjN0gRzeEdQabNuWkqiTgQDo5WZg400gwh3FIMZ4FBCKYbt5to+svB3Q35sWU1RFDhTMKiu1aLfYjvS9tXkIs527rpf36WsNJO7ezY55AF8gm+uv3QnGEXPG5EJPsrZku1+570RLTd8yMnfu9hZJ8hw8+3dpmS5rS8G/NNyrMcGwYHUumU/PdBii1riDalVu7nqUH7dOpfs7KLCgamBIhIhNzcDgtzuufsKqjzubzGZYxxMYeYxuyGZ1TDFp4r7wIFocObDToP83F/+RnmdUKZajV64HM4UDAZC139ld0zqST5TdS/o1ux2T0dr7wIN3XHyTEv5eXOORGfxVY34sXPc403kKTAafuwgZLU7AgQult0Kx4wm8LoceJP4OPxvtZv+2uKiSCc6xjmCpolC2AHLOqB88MZ+gXVYJ2lGKaozeVz6yWLUXP7Q3ESr8BasPXvblJtV/UgTb2ymGbGCJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e6a581-0b34-4d0b-1f3b-08d803ac6c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 08:43:56.2029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAzOjf9zYnbMxQinVHbuByHvlwWo2NY4fztxb9I5uzPGozno1nwfDcjpXqbzHnqvCWHuAK7iTcdT5JnGLGj7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5295
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Pali,

> According to publicly available information, firmware for these W8xxx
> Marvell wifi chips is vulnerable to security issue CVE-2019-6496 [1].
>=20
> Are you able to update firmwares to the last versions and give us some
> information which (old) firmware versions are affected by that security i=
ssue?
>=20
> So Linux distribution would know if they are distributing older vulnerabl=
e
> firmwares and should push security fixes with new firmware versions.
>=20

88W8787, 88W8797, 88W8801, 88W8897, and 88W8997 models are all already upda=
ted, with one exception:
usb8897_uapsta.bin, which we will upstream soon;

Regards,
Ganapathi
