Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF71E78BA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 10:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgE2ItX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 04:49:23 -0400
Received: from mail-db8eur05on2088.outbound.protection.outlook.com ([40.107.20.88]:6197
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbgE2ItW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 04:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYdr9oubVQ0BjFmoOUK3q0GjvWxwHtklsQ5RlSuB6XuEiAyrQfQ3N17MAH2LiTZYcGFl4t2rwIQJQjViCzMs7LRky1tmSK5hC61TUj/wQ8wBXUxw+lgiCWJW/D+ZdBKOx+S90WRfL1/VpipmgORZSQ+UPrmNEi5JLJooRv4DWVlMayquRaHlsbqPK7Zh4ouIJ1/phGo02GuPTKLXB1YDCSvi6ysbmXM1ChcNtUWHmEhLQTZOfGEyk1WnCcl2vMWgBzmATFpXxRvaV0eF4grYd8AgIew9bah7xl28GGe3aspSTpcxpFxka4rnLYHY76WSuMOxvrfJbKN8VQsRRyjD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnJF8OcP9DSD3Dt18UaXvNRZewPdSmwIqlog+zrrIJE=;
 b=V3Ch24rZrkVF1nFq5lVpDWaAm6IXj203F0DApEExvMa9GxGT4nyT8Td/P/5g909lRQASw1sxqhJ9svKYEmOGrWinPch3MEw6pdoe1qB2K7mVSrvnQAHGmx6YziyZoYiOibbuGgIzcBGq+2IWZuFGqlLTkWZ0pqm9gnzSXcUMfK6rPz7b+6dfD9uHK7vGUi6hrhPI8aTCm+CPAMI1t7f9cBYRi3APq+vzPz00ZNvLaXZRHRmO23Zv9oieKLMPx+BayI9NYiPsfuJJfU15VSM6ZIO1jMs2srmYEwnoAEMclq+4MSwowCho89mhzNf+87ntnQwtxp8vZWS6yUut9XipTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnJF8OcP9DSD3Dt18UaXvNRZewPdSmwIqlog+zrrIJE=;
 b=dYZEyWNmw65xHSlf1UuEwgE0XP2Y50/tRYdSRUdcA8LHG3Kr7C1qPkWU0650skqVL8AboKd7CUQdkoLNpgAZ24nwymPmSDsevL5W7HuzpjaW3pNw2B+omDc9v9vNpojYVuINbIQZbLhc0KLrbGq0u/PIINCRzg6IdX8dfS1LDjk=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB4560.eurprd04.prod.outlook.com (2603:10a6:803:6d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 08:49:18 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 08:49:18 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        =?iso-8859-1?Q?Marek_Beh=FAn?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Topic: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Index: AQHWKrwXtO/N2oQua0+uJ10PPhSg4aiqXxHQgBMCnACAAXIN0IAAAhkAgAAAaZA=
Date:   Fri, 29 May 2020 08:49:18 +0000
Message-ID: <VI1PR04MB4366DECFA1EB5C3D6AADB0818F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200515132353.vfor7v4buzoddfmb@pali>
 <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200528103432.irmsaaz72x3xophg@pali>
 <VI1PR04MB4366409B8E293A265851DA948F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529084630.j7rpdypt6vycsedh@pali>
In-Reply-To: <20200529084630.j7rpdypt6vycsedh@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.54.18.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b92e77f-7321-4df6-58ad-08d803ad2c9a
x-ms-traffictypediagnostic: VI1PR04MB4560:
x-microsoft-antispam-prvs: <VI1PR04MB456059FB9AB5C97CF58E2F298F8F0@VI1PR04MB4560.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFnZMAu8TsLdiFHTPb1+otjWR87Swn6tSkluUJVoJSzctTXPjgXYD0KYiGK3NxAtJ+24trlTel4zul5ddwgcT7cNQv0TzkgAqriJw9lL0hV9PgVkGHcvKelVOGUDPAgg3kFfC+KuuOQNYN7JNXfqtU6RtmP1Oycj5gwRyTpRNmi4/mVQ77bZrp5DUDpEUfRg9Ydm8PoeSOKYCpc9Nps5ujWLVbmBScGqvD1rEBd0lT1F4gcVNjdK3mj/IYvF7AHrQxYhNyZXPFsC0JeLpOoAysiKuFg9ncu+QC4srIwLWm1WPjO5EaaELoBf8LYhsy4srIFK9qq6+onoW4Qj6DJhjKVVjPgDno6Tnhkn3tWhNhnKWUa5uk42GtIByy4fUMv0WmuMWpQJhalDZchpWIUZRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(6916009)(52536014)(8936002)(4326008)(5660300002)(66946007)(8676002)(71200400001)(76116006)(55016002)(66476007)(64756008)(66556008)(9686003)(33656002)(66446008)(316002)(44832011)(26005)(186003)(2906002)(7696005)(83380400001)(6506007)(478600001)(966005)(54906003)(558084003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vQgdARbe5tjNhzNiCEdbvFt47v68BBBzeW10INxGCb0frMma+ef5cX7yBudKnrqmTmM35jMXM1aizpBK+Ub0SjYfKd4TntEhdgaNfglhCendspfrsipATN/uUZfXjQOIwx2h/hrphM7sCZ44YnHZRfvwZxbUXXKkt0ijrDXeJ3MhYQ0sHcbzP1lq0/TmZNiEi5JyPGBnNvNIZsWbM7aK2swGtT+AVlN3RjXD/5g2QlbJ68lU+tLCyk6HYBqG8T2+YNTU3XjB31xCRaKnny7BS5xlFgH3c6nixbzhCxPr3Vu9w1JqwzdK2wFDHPWH0xq/TXhlll4u43oAfnkc5ZgyWWHCRppYWKnWnm+6/s2YfUvujItlvdwwuttIB92Nkn+6UeJ/KiIpev0mo44xd9J4xcFXpRuGLULB+MoQiOFgYH+W1YKdolFJ1w/oICTkb4BL+Rb3BCesQb15ojEutPCnYhjLp04C3+XLqnxC/n4x7FFI+qJke8HOsPLcCKE9Ekeo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b92e77f-7321-4df6-58ad-08d803ad2c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 08:49:18.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxpkvCwr1Ehn9CKHzXGQIfUCWf/qIDvTMPH+Gctd73Z2YFiX9MgOKS/lmLZJ3NBfW5j6cIhxSqw8TBEgbdVDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4560
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Pali,
=20
> Hello Ganapathi! Thank you for information. Can you point me to git tree =
or
> location where are firmware files already updated?

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

or

https://github.com/NXP/mwifiex-firmware


Regards,
Ganapathi
