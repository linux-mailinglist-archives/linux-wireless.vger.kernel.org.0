Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6223891C1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354734AbhESOqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 10:46:42 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:5804
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354743AbhESOqQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 10:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIKNQeuqzyTlgMEPvAQduW5VMEzcB1D0svnAs8qzibyfuTQZW+1EIXOlyqEJSWja8dQMwEhEBH14JCOgteSmKmR+dK6DanV6oyZHCoBJMqzAYHX8xYpieLRuRz6JYHZ4inJFtdJ42/hmkz93zkdm0F+6pSw7596qWsWT3IEyGxRoUYouOdvHuwUlCXCP9ftYlwxKKuMp6hV9Os1ZnO4s5U+y9KdbOM58YhvKssKQFZDrP03LHIsv/eD0esIZvLZI6BqKtvIpjm0fWS+JbIZyWIuM5baqserihJof19WMcE0RHS1Y6tpiDVRCYgR/w2o/bLdfrLzlwnvaXhigaerv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzIRV/V8fSbddicbP8nKQ6WT5yN4FoEyvn7fecdBF7o=;
 b=ViH4dJeuqXMj620zt8oFPUhL2Pm/VlKvJtAdbV8w2ctgGADy50lVqYf/d+YHFs+IgCvLvS8r7yLlOMX7QOdClPsO1o7weYiS3yGh0T8wz9w0KsUTqpfbxo1+3dQS+bn2gXdzyukY5Q7VYOw9pBxJJ86P7XyL2ktgVjvuOUFI8gTnLWNhombQZ/XCt4cjcredioGlx3LLm6Mc5ge3F8dsZ4BDBdsGiJOZjI/Vpr/WAn84jVGIJwwOhyAaYq/lXu9MLqRA6yGmIfQVviBPo02GbdGGdlRdw4qVLcyfABeCYn8DcgKP/yXOEwsYggNsgDnYMCTCoYT1IGXYICc1ndpr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzIRV/V8fSbddicbP8nKQ6WT5yN4FoEyvn7fecdBF7o=;
 b=VAigGBtCnEQTIDtAUNy5SGP7gr6R0OyyLxIbk0rXm0mKEktVX40Pd3Y7C/Lw9kn6PqqsPxG3O9ClKPhnIKK9/MNK77CSJ3V21HvPnIbxmtPhQ/lnFgWS+LiUVFSRCKvSaemk58m6meDdDTsHZHVBTPJ9Sxgoc9L/dVlyPaU8ddY=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (2603:10a6:5:2e::18) by
 DB7PR04MB5961.eurprd04.prod.outlook.com (2603:10a6:10:8c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 14:44:54 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::74dd:4a7a:3f72:c85b]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::74dd:4a7a:3f72:c85b%4]) with mapi id 15.20.4108.038; Wed, 19 May 2021
 14:44:54 +0000
From:   Sharvari Harisangam <sharvari.harisangam@nxp.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Mayur Arakere <mayur.arakere@nxp.com>
Subject: pull-request mwifiex-firmware 2021-05-19
Thread-Topic: pull-request mwifiex-firmware 2021-05-19
Thread-Index: AddMvUtpFmPfEiO5ReaLcYt/JiLOFA==
Date:   Wed, 19 May 2021 14:44:54 +0000
Message-ID: <DB7PR04MB45387F399B5963BD92C57CA3FC2B9@DB7PR04MB4538.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [116.75.138.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43bc5f3a-be13-4b64-b3c5-08d91ad4aa71
x-ms-traffictypediagnostic: DB7PR04MB5961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5961AACDA17A302F3000A30CFC2B9@DB7PR04MB5961.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F3SkokMM4YoxsFc0lxtXi4wkhtCDuX363wZBUygXjw3MQPG4mcd1GWF8xbD2yCtwYiU7WSFutgMyzEcWSmWn+BY0XfU2YSz4Bacagl76ALLEsWNtMwvgRIvvukiY/0/cn5L/eE9V/FOMtsyMYqQpgdMEsdGBkPuhlAcbFcccrAkXeDwKK+2jl3Dqd0P+nEoZFhaUaCajn3pjs8EzEuJes/+18x2hE7cp/zxyGXm21Y410OzOxmg3C5fX7KiIbrjLwW5vFBhNz03NhXZpETt8ZTGstcgzny9mEFx//idH1kfArpIgZlFi9/0S1UTu+xWjk74cElrY2mfqNskfgyrdAsyoDHi0SBPes0YoOy5gAIWRZE9gHDH+ZNkV1mUU1ZalBuENmsPqYSYIDI6EgPbl7/A+h3fxEEs/1bam3odSwjGHvN0hzaNmTK4zSch2s0kn6wH7PA1jprWfQFVcb2kWo4a2f6mJArBCuTGXh22TwfkERTMTXMgxw0wgEwgysipW9LgGMBsm1rAVtK04f4U8RzdyAzgU2MsdG6xCJal26ba3pBto+eqAgECu4vCAllzwKpA/ZHkkdqZriZlx8yOneFPXTp9WxGAAJIPrG6JomUt9w2otDE+vukA9i1KOx0C+pJfdIK+SjoziVJkb+uW1qOS13XpxcoF5eW7pX0cEztsn9bPB0UD08+/sdDz9heFz5I0PtNid9sQpqZTB6DBf3neUd76/3n8+n42dVi2eurE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4538.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(7696005)(44832011)(38100700002)(76116006)(33656002)(966005)(55236004)(4744005)(478600001)(66556008)(186003)(83380400001)(26005)(64756008)(66476007)(66446008)(4326008)(66946007)(55016002)(71200400001)(316002)(6506007)(54906003)(8936002)(122000001)(5660300002)(9686003)(2906002)(8676002)(52536014)(86362001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?a3ggnUq7+Aq3Aq5P2nTsJuYJ0dqJzDxh65e07zhlgVfgg6eS/qhMPH9Fva3s?=
 =?us-ascii?Q?MZGbAjUvjsjevs+o+0QLROi26lbsSxHwI5h0HOVigqIfDrIkIrGkK7XWBV8W?=
 =?us-ascii?Q?7Cp7l4pWTPTu8Q2XKOa76nj4ygNlkRRbTYosUVH2oHH7usD+8rcVojrh3JhY?=
 =?us-ascii?Q?hF7ik8hFzwLM3Qkfi12I6aikniKyY4BF+5/GLLZBlrQC0p36D1ZuMwhmJyTT?=
 =?us-ascii?Q?FxeRjVRCPZDdaHHX9lB62lXwGL2UABg9mpFbSp22A+nrREJJmiLScGatPeeA?=
 =?us-ascii?Q?9CABb+BXrmL2sK3hXvRFvC4B2lEISAWirTXpn3mWwzg+DFG+16DjW/cJBeM6?=
 =?us-ascii?Q?iMKTqKnR7RqjeAGhLyKnEGBMEeVlphfCbmsHbMFVNZAOXKJYC4mC4ZR8bQxI?=
 =?us-ascii?Q?ML3J/sbK2ZWi0cS7zskM4ps29Gmj1ElLsfwTnslAGbNLArpueyu3r/+NCoA2?=
 =?us-ascii?Q?W9y5WXdsJTxxzNCBIj95wVYhc997e7I4Eu0ka/CEj/vox05hWtVy6qy/NHfG?=
 =?us-ascii?Q?ArWuIWpNioRrEIZxc7shOzPVObwMWNZyuUPOCHAHdumWzBMjyDQErWCn5Z2s?=
 =?us-ascii?Q?YC1rvzti6lgEESDcwMuOJqKCYOkEmLADadzkJoIcJsVFe/YvpztG8f9mt6wv?=
 =?us-ascii?Q?txxwkoL3itcUjdBREV6aKiVtaleiq483N4z5vUBVWW7LuY1sMHmMJsgcUjoa?=
 =?us-ascii?Q?NHdc0YzBN70i4aZdBexudvrz29+3z+Nu3P09NZcmH4L0gCIEbzkaMB/sl32A?=
 =?us-ascii?Q?0c2riRhHjufJtRpz79eqtNqnASo45gBNWo4OhgC1nEnK4Zkpbxb5Dmxl2O93?=
 =?us-ascii?Q?HbAcHyfUUjcbIGfrXtvj4qc4sBwSU3tLrXvo2lovFepl1pfv1VqZDPgp1Alt?=
 =?us-ascii?Q?U7qdaarOUbjGW+SqyOJWAKYyXqWdV+HrnWCFUu7EvsULWWfJqV8F4KdF+7VG?=
 =?us-ascii?Q?s3qhRiCVMYybYVGuLHuGjj/SdxvT3LVlQmVbAGt0As9dSiEypFryiZSWvAg3?=
 =?us-ascii?Q?FR/rbAsDeR12zFTyXR28OpZWXtz3hCV4qvibXq2S5Tzewx8hgakeZ8SVnhdz?=
 =?us-ascii?Q?12jDso3tUf0UO7Z5Ozjl8TkU1g5IDDz+cw+buAOxX6Viff1/gQK+vQY3xzvd?=
 =?us-ascii?Q?Cl1CJdHICvK0+uVZzzJQ47R+QtPsSc6PhZFf/iBHhC0dV31/iwLX9hHFI+vR?=
 =?us-ascii?Q?buBH96uEQRQz+zPnJg4C1Koq0kZwb2Z7E1xWuYgPQYniaJTh78y4Yca0VfQc?=
 =?us-ascii?Q?QtGGA/ej8KGN12Ul/lUNtd+2X1vPAngJ6ng2iLL7mot4kqnO+wr3yM7sTbrG?=
 =?us-ascii?Q?KDQfZnNdifQJRqgpW/t9wr0F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4538.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bc5f3a-be13-4b64-b3c5-08d91ad4aa71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 14:44:54.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99sREKHH+qnGxX13TFBAxTgbAcasI7jKDMuWiTG6QE243dr5B7Y17Zy1p2j3AUzSF+U0sND0xmQy0LNjqfvYl+Efi3DFBxjo9+JY7UDOb5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5961
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following changes since commit 2a0a062e79b5fe9007e57c0fcd285e683e22373e=
:

  linux-firmware: update NXP SDSD-8997 firmware image (2020-08-03 06:51:36 =
+0530)

are available in the git repository at:

  https://github.com/NXP/mwifiex-firmware.git

for you to fetch changes up to db190ade4569c542cd257a9334f8f8956372f7b3:

  linux-firmware: update NXP PCIE-USB-8997 firmware image (2021-05-19 12:57=
:21 -0700)

----------------------------------------------------------------
Sharvari Harisangam (1):
      linux-firmware: update NXP PCIE-USB-8997 firmware image

 WHENCE                       |   2 ++
 nxp/pcieusb8997_combo_v4.bin | Bin 0 -> 638992 bytes
 2 files changed, 2 insertions(+)
 create mode 100644 nxp/pcieusb8997_combo_v4.bin
